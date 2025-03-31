Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E6CC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 09:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzBhB-00089m-WF; Mon, 31 Mar 2025 05:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tzBh3-00088n-Ec
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 05:44:34 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tzBh0-0001oq-VT
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 05:44:32 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5eb5ecf3217so7949723a12.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743414267; x=1744019067;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6WTvO7rp9XgapHjvxSmIjn3k+NKEuBzbaRfRdVRMOog=;
 b=cX7/cpn5WAGp0oFk1d3m3rhbMiXyiquwC/nnZl/CMOai7IvuwXnHDEEap8osr8xARj
 YhxbCE8tZ3MZN1fnQbYkmOjzpGTkzixSY8Ko9vJ7YwsvQx0su3tffY5crNks9tzaAi7G
 wiPfl/AOZMmpTvpcurClOh8hTTVSD+7ADqeDskAl38w/1xc++XIaRxbeXytE18lgqdJZ
 qcSTsU5ro4fHojD0Fn6oAHNq+50kWF3ODvPn5kmmBKUp0eZQ1at9Sl3YYqw9rmLqZHIC
 bsql6Itq7a4SDpInZmm0+8OkiP+o5MT96KV3NYsU3Bonr4WIfS4P7i+f6bLkLnyiqXDj
 i7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743414267; x=1744019067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6WTvO7rp9XgapHjvxSmIjn3k+NKEuBzbaRfRdVRMOog=;
 b=lVlgHmedybnwKxsoxkAeMkQHu7PPolPufWI1ao18Ba8TL61vpTeEGL+kfrd+rSP+2M
 vtqaUCSEg/kjBdagugpkZH8in0KRADPGKFrE7lrq1hZQRSu4phemr5X+nMI76NoVGktk
 o5j4Ix2qo3OlbnxiKGT9suhlurSeXpGZuChzYyLaxvfs8q08CrCdSmBDLUca1YdFm9+N
 FlGcKFSp44rk5Caa9NSgE93tvPrPnaKRLNQVOPBhnIz/W2HsqImwLbc6Z7mNRggb7xIM
 3S9GBkcdsYJFMQBZ4a79hATuc39AkAHb5Zu/JV9dH+mNp/Z0PnjJ9CTbn7y9cbv5mdxb
 K4Mw==
X-Gm-Message-State: AOJu0YxmNpetzfM2MKNJD6Y3fzi6GWgVhr0dwtMH5J/P/je+WtrentVI
 IDxTO/e0NEaVd1oTZNYPkl7Namd9aL1I1lmIVPQiN9bHOdhezNQQ3Rg+DvNRY+oBXjuTe8VXQWK
 KSD5kMNUTyM/ydEaGMwgbx2SQc4DuelRTxR0DmA==
X-Gm-Gg: ASbGncsfS46KjaUbT55BjqOo3SxJBMNtJ/XxHposr/E9PUQ1igyslj8b3aQeMMf7O77
 De3rmPsBplHeFqjpY29FTqMTBKWIhvFrteUP4CBM6bdCW5JvxVAkezf81bHaBcnKs7cNVjgok9n
 /XHrx3jeIaReEiYLn0bz1Fk/m0
X-Google-Smtp-Source: AGHT+IHyD/DjNHvN+uC2XXbqIOggbio/jdhZRPkfPBk7W9esmMkAZrrycc6OwU9Ab5jKpedriI4rh+BnHduKXkrX2+0=
X-Received: by 2002:a17:906:7955:b0:ac3:3f11:b49d with SMTP id
 a640c23a62f3a-ac7386300f8mr769943666b.0.1743414267166; Mon, 31 Mar 2025
 02:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-5-loic@rivosinc.com>
 <3d3cf6a5-7ec2-427f-8f02-dc1e5a370996@linux.alibaba.com>
In-Reply-To: <3d3cf6a5-7ec2-427f-8f02-dc1e5a370996@linux.alibaba.com>
From: =?UTF-8?B?TG/Dr2MgTGVmb3J0?= <loic@rivosinc.com>
Date: Mon, 31 Mar 2025 11:44:15 +0200
X-Gm-Features: AQ5f1Jp8q6Rlh2x1oolTlkqnY_PJ9OgGkd4TROXsmpY3gQQ5BqSqPFQA-6afblQ
Message-ID: <CAGKm2N+t4NH6vEswyGEmi3O_fCVvQ8p4qqReNu9rbD9x=wnCtQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] target/riscv: pmp: exit csr writes early if value
 was not changed
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: multipart/alternative; boundary="000000000000175d2d0631a044b3"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=loic@rivosinc.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000175d2d0631a044b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 10:03=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.aliba=
ba.com>
wrote:

>
> On 2025/3/14 03:30, Lo=C3=AFc Lefort wrote:
> > Signed-off-by: Lo=C3=AFc Lefort <loic@rivosinc.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >   target/riscv/pmp.c | 22 +++++++++++++++-------
> >   1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index c5f6cdaccb..845915e0c8 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -141,6 +141,11 @@ static inline uint8_t pmp_read_cfg(CPURISCVState
> *env, uint32_t pmp_index)
> >   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index,
> uint8_t val)
> >   {
> >       if (pmp_index < MAX_RISCV_PMPS) {
> > +        if (env->pmp_state.pmp[pmp_index].cfg_reg =3D=3D val) {
> > +            /* no change */
> > +            return false;
> > +        }
> > +
> >           if (pmp_is_readonly(env, pmp_index)) {
> >               qemu_log_mask(LOG_GUEST_ERROR,
> >                             "ignoring pmpcfg write - read only\n");
> > @@ -528,6 +533,11 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t
> addr_index,
> >       bool is_next_cfg_tor =3D false;
> >
> >       if (addr_index < MAX_RISCV_PMPS) {
> > +        if (env->pmp_state.pmp[addr_index].addr_reg =3D=3D val) {
> > +            /* no change */
> > +            return;
> > +        }
> > +
> >           /*
> >            * In TOR mode, need to check the lock bit of the next pmp
> >            * (if there is a next).
> > @@ -544,14 +554,12 @@ void pmpaddr_csr_write(CPURISCVState *env,
> uint32_t addr_index,
> >           }
> >
> >           if (!pmp_is_readonly(env, addr_index)) {
> > -            if (env->pmp_state.pmp[addr_index].addr_reg !=3D val) {
>
> Is there some benefit removing this if sentence?
>
>
> The if is not removed, it's moved to the top of the function. The goal is
to skip processing and warnings when the write would not change the value
already present in the register.For pmp_write_cfg, each pmpcfg register
contains 4 config values and some of them might be locked so we want to
avoid warnings when writing with unchanged values.
As you noted, the similar change in pmpaddr_csr_write has less benefit:
it's only a minor optimization and is done for symmetry with pmp_write_cfg.

Lo=C3=AFc.

>
> > -                env->pmp_state.pmp[addr_index].addr_reg =3D val;
> > -                pmp_update_rule_addr(env, addr_index);
> > -                if (is_next_cfg_tor) {
> > -                    pmp_update_rule_addr(env, addr_index + 1);
> > -                }
> > -                tlb_flush(env_cpu(env));
> > +            env->pmp_state.pmp[addr_index].addr_reg =3D val;
> > +            pmp_update_rule_addr(env, addr_index);
> > +            if (is_next_cfg_tor) {
> > +                pmp_update_rule_addr(env, addr_index + 1);
> >               }
> > +            tlb_flush(env_cpu(env));
> >           } else {
> >               qemu_log_mask(LOG_GUEST_ERROR,
> >                             "ignoring pmpaddr write - read only\n");
>

--000000000000175d2d0631a044b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 29,=
 2025 at 10:03=E2=80=AFAM LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux=
.alibaba.com">zhiwei_liu@linux.alibaba.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><br>
On 2025/3/14 03:30, Lo=C3=AFc Lefort wrote:<br>
&gt; Signed-off-by: Lo=C3=AFc Lefort &lt;<a href=3D"mailto:loic@rivosinc.co=
m" target=3D"_blank">loic@rivosinc.com</a>&gt;<br>
&gt; Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ve=
ntanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/pmp.c | 22 +++++++++++++++-------<br>
&gt;=C2=A0 =C2=A01 file changed, 15 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c<br>
&gt; index c5f6cdaccb..845915e0c8 100644<br>
&gt; --- a/target/riscv/pmp.c<br>
&gt; +++ b/target/riscv/pmp.c<br>
&gt; @@ -141,6 +141,11 @@ static inline uint8_t pmp_read_cfg(CPURISCVState =
*env, uint32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp=
_index, uint8_t val)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmp_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;pmp_state.pmp[pmp_index].cfg_=
reg =3D=3D val) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* no change */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmp_is_readonly(env, pmp_i=
ndex)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LO=
G_GUEST_ERROR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ignoring pmpcfg write - read only\n=
&quot;);<br>
&gt; @@ -528,6 +533,11 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32=
_t addr_index,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_next_cfg_tor =3D false;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (addr_index &lt; MAX_RISCV_PMPS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;pmp_state.pmp[addr_index].add=
r_reg =3D=3D val) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* no change */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * In TOR mode, need to check =
the lock bit of the next pmp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * (if there is a next).<br>
&gt; @@ -544,14 +554,12 @@ void pmpaddr_csr_write(CPURISCVState *env, uint3=
2_t addr_index,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pmp_is_readonly(env, addr=
_index)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;pmp_state.pmp[a=
ddr_index].addr_reg !=3D val) {<br>
<br>
Is there some benefit removing this if sentence?<br>
<br><br></blockquote><div>The if is not removed, it&#39;s moved to the top =
of the function. The goal is to skip processing and warnings when the write=
 would not change the value already present in the register.For pmp_write_c=
fg, each pmpcfg register contains 4 config values and some of them might be=
 locked so we want to avoid warnings when writing with unchanged values.</d=
iv><div>As you noted, the similar change in pmpaddr_csr_write has less bene=
fit: it&#39;s only a minor optimization and is done for symmetry with pmp_w=
rite_cfg.</div><div><br></div><div>Lo=C3=AFc.</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pmp_s=
tate.pmp[addr_index].addr_reg =3D val;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_update_ru=
le_addr(env, addr_index);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_next_c=
fg_tor) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pmp_update_rule_addr(env, addr_index + 1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlb_flush(env=
_cpu(env));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pmp_state.pmp[addr_=
index].addr_reg =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_update_rule_addr(env, a=
ddr_index);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_next_cfg_tor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_update_ru=
le_addr(env, addr_index + 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlb_flush(env_cpu(env));<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LO=
G_GUEST_ERROR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ignoring pmpaddr write - read only\=
n&quot;);<br>
</blockquote></div></div>

--000000000000175d2d0631a044b3--

