Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EB1C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDNM-0007dR-TB; Mon, 31 Mar 2025 07:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tzDMU-0007Xg-D7; Mon, 31 Mar 2025 07:31:28 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tzDMQ-0006sG-Uh; Mon, 31 Mar 2025 07:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1743420672; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=JIzvk0Jq1iJgYQ+hN/uUza2Z37gMfgvk+lWmawS+Pek=;
 b=Pk1to7dkOI2v5ZBu17fA4+K6T9Fh05KLgS3m8cmjC0K0Yosb6381ZhxsMJNMjFvIaVa1fT1EJzQbS6+QU7w3TxgWbruzUVR3TF4I3JRynywHxCqF87VgsXGNea605gTm02UVJY7lz/SGk9fhVkHOHAOFP6mPfYDVW9v7TO+18ps=
Received: from 30.166.64.216(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WTZ23Vn_1743420670 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 31 Mar 2025 19:31:11 +0800
Content-Type: multipart/alternative;
 boundary="------------QC239WoRnC5fgsZ8oy3c9Azo"
Message-ID: <9aa2f708-1c40-45c4-8f39-03fb7a529e99@linux.alibaba.com>
Date: Mon, 31 Mar 2025 19:31:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] target/riscv: pmp: exit csr writes early if value
 was not changed
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-5-loic@rivosinc.com>
 <3d3cf6a5-7ec2-427f-8f02-dc1e5a370996@linux.alibaba.com>
 <CAGKm2N+t4NH6vEswyGEmi3O_fCVvQ8p4qqReNu9rbD9x=wnCtQ@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAGKm2N+t4NH6vEswyGEmi3O_fCVvQ8p4qqReNu9rbD9x=wnCtQ@mail.gmail.com>
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------QC239WoRnC5fgsZ8oy3c9Azo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/3/31 17:44, Loïc Lefort wrote:
>
>
> On Sat, Mar 29, 2025 at 10:03 AM LIU Zhiwei 
> <zhiwei_liu@linux.alibaba.com> wrote:
>
>
>     On 2025/3/14 03:30, Loïc Lefort wrote:
>     > Signed-off-by: Loïc Lefort <loic@rivosinc.com>
>     > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>     > ---
>     >   target/riscv/pmp.c | 22 +++++++++++++++-------
>     >   1 file changed, 15 insertions(+), 7 deletions(-)
>     >
>     > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
>     > index c5f6cdaccb..845915e0c8 100644
>     > --- a/target/riscv/pmp.c
>     > +++ b/target/riscv/pmp.c
>     > @@ -141,6 +141,11 @@ static inline uint8_t
>     pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>     >   static bool pmp_write_cfg(CPURISCVState *env, uint32_t
>     pmp_index, uint8_t val)
>     >   {
>     >       if (pmp_index < MAX_RISCV_PMPS) {
>     > +        if (env->pmp_state.pmp[pmp_index].cfg_reg == val) {
>     > +            /* no change */
>     > +            return false;
>     > +        }
>     > +
>     >           if (pmp_is_readonly(env, pmp_index)) {
>     >               qemu_log_mask(LOG_GUEST_ERROR,
>     >                             "ignoring pmpcfg write - read only\n");
>     > @@ -528,6 +533,11 @@ void pmpaddr_csr_write(CPURISCVState *env,
>     uint32_t addr_index,
>     >       bool is_next_cfg_tor = false;
>     >
>     >       if (addr_index < MAX_RISCV_PMPS) {
>     > +        if (env->pmp_state.pmp[addr_index].addr_reg == val) {
>     > +            /* no change */
>     > +            return;
>     > +        }
>     > +
>     >           /*
>     >            * In TOR mode, need to check the lock bit of the next pmp
>     >            * (if there is a next).
>     > @@ -544,14 +554,12 @@ void pmpaddr_csr_write(CPURISCVState *env,
>     uint32_t addr_index,
>     >           }
>     >
>     >           if (!pmp_is_readonly(env, addr_index)) {
>     > -            if (env->pmp_state.pmp[addr_index].addr_reg != val) {
>
>     Is there some benefit removing this if sentence?
>
>
> The if is not removed, it's moved to the top of the function.

Oops! I miss it.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Thanks,
Zhiwei

> The goal is to skip processing and warnings when the write would not 
> change the value already present in the register.For pmp_write_cfg, 
> each pmpcfg register contains 4 config values and some of them might 
> be locked so we want to avoid warnings when writing with unchanged values.
> As you noted, the similar change in pmpaddr_csr_write has less 
> benefit: it's only a minor optimization and is done for symmetry with 
> pmp_write_cfg.

>
> Loïc.
>
>
>     > - env->pmp_state.pmp[addr_index].addr_reg = val;
>     > -                pmp_update_rule_addr(env, addr_index);
>     > -                if (is_next_cfg_tor) {
>     > -                    pmp_update_rule_addr(env, addr_index + 1);
>     > -                }
>     > -                tlb_flush(env_cpu(env));
>     > +            env->pmp_state.pmp[addr_index].addr_reg = val;
>     > +            pmp_update_rule_addr(env, addr_index);
>     > +            if (is_next_cfg_tor) {
>     > +                pmp_update_rule_addr(env, addr_index + 1);
>     >               }
>     > +            tlb_flush(env_cpu(env));
>     >           } else {
>     >               qemu_log_mask(LOG_GUEST_ERROR,
>     >                             "ignoring pmpaddr write - read only\n");
>
--------------QC239WoRnC5fgsZ8oy3c9Azo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025/3/31 17:44, Loïc Lefort wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGKm2N+t4NH6vEswyGEmi3O_fCVvQ8p4qqReNu9rbD9x=wnCtQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Sat, Mar 29, 2025 at
            10:03 AM LIU Zhiwei &lt;<a
              href="mailto:zhiwei_liu@linux.alibaba.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">zhiwei_liu@linux.alibaba.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
            On 2025/3/14 03:30, Loïc Lefort wrote:<br>
            &gt; Signed-off-by: Loïc Lefort &lt;<a
              href="mailto:loic@rivosinc.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">loic@rivosinc.com</a>&gt;<br>
            &gt; Reviewed-by: Daniel Henrique Barboza &lt;<a
              href="mailto:dbarboza@ventanamicro.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">dbarboza@ventanamicro.com</a>&gt;<br>
            &gt; ---<br>
            &gt;   target/riscv/pmp.c | 22 +++++++++++++++-------<br>
            &gt;   1 file changed, 15 insertions(+), 7 deletions(-)<br>
            &gt;<br>
            &gt; diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c<br>
            &gt; index c5f6cdaccb..845915e0c8 100644<br>
            &gt; --- a/target/riscv/pmp.c<br>
            &gt; +++ b/target/riscv/pmp.c<br>
            &gt; @@ -141,6 +141,11 @@ static inline uint8_t
            pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)<br>
            &gt;   static bool pmp_write_cfg(CPURISCVState *env,
            uint32_t pmp_index, uint8_t val)<br>
            &gt;   {<br>
            &gt;       if (pmp_index &lt; MAX_RISCV_PMPS) {<br>
            &gt; +        if (env-&gt;pmp_state.pmp[pmp_index].cfg_reg
            == val) {<br>
            &gt; +            /* no change */<br>
            &gt; +            return false;<br>
            &gt; +        }<br>
            &gt; +<br>
            &gt;           if (pmp_is_readonly(env, pmp_index)) {<br>
            &gt;               qemu_log_mask(LOG_GUEST_ERROR,<br>
            &gt;                             "ignoring pmpcfg write -
            read only\n");<br>
            &gt; @@ -528,6 +533,11 @@ void
            pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,<br>
            &gt;       bool is_next_cfg_tor = false;<br>
            &gt;   <br>
            &gt;       if (addr_index &lt; MAX_RISCV_PMPS) {<br>
            &gt; +        if (env-&gt;pmp_state.pmp[addr_index].addr_reg
            == val) {<br>
            &gt; +            /* no change */<br>
            &gt; +            return;<br>
            &gt; +        }<br>
            &gt; +<br>
            &gt;           /*<br>
            &gt;            * In TOR mode, need to check the lock bit of
            the next pmp<br>
            &gt;            * (if there is a next).<br>
            &gt; @@ -544,14 +554,12 @@ void
            pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,<br>
            &gt;           }<br>
            &gt;   <br>
            &gt;           if (!pmp_is_readonly(env, addr_index)) {<br>
            &gt; -            if
            (env-&gt;pmp_state.pmp[addr_index].addr_reg != val) {<br>
            <br>
            Is there some benefit removing this if sentence?<br>
            <br>
            <br>
          </blockquote>
          <div>The if is not removed, it's moved to the top of the
            function. </div>
        </div>
      </div>
    </blockquote>
    <p>Oops! I miss it.</p>
    <p>Reviewed-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a></p>
    <p>Thanks,<br>
      Zhiwei<br>
    </p>
    <blockquote type="cite"
cite="mid:CAGKm2N+t4NH6vEswyGEmi3O_fCVvQ8p4qqReNu9rbD9x=wnCtQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>The goal is to skip processing and warnings when the
            write would not change the value already present in the
            register.For pmp_write_cfg, each pmpcfg register contains 4
            config values and some of them might be locked so we want to
            avoid warnings when writing with unchanged values.</div>
          <div>As you noted, the similar change in pmpaddr_csr_write has
            less benefit: it's only a minor optimization and is done for
            symmetry with pmp_write_cfg.</div>
        </div>
      </div>
    </blockquote>
    <br>
    <blockquote type="cite"
cite="mid:CAGKm2N+t4NH6vEswyGEmi3O_fCVvQ8p4qqReNu9rbD9x=wnCtQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div><br>
          </div>
          <div>Loïc.</div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <br>
            &gt; -               
            env-&gt;pmp_state.pmp[addr_index].addr_reg = val;<br>
            &gt; -                pmp_update_rule_addr(env, addr_index);<br>
            &gt; -                if (is_next_cfg_tor) {<br>
            &gt; -                    pmp_update_rule_addr(env,
            addr_index + 1);<br>
            &gt; -                }<br>
            &gt; -                tlb_flush(env_cpu(env));<br>
            &gt; +            env-&gt;pmp_state.pmp[addr_index].addr_reg
            = val;<br>
            &gt; +            pmp_update_rule_addr(env, addr_index);<br>
            &gt; +            if (is_next_cfg_tor) {<br>
            &gt; +                pmp_update_rule_addr(env, addr_index +
            1);<br>
            &gt;               }<br>
            &gt; +            tlb_flush(env_cpu(env));<br>
            &gt;           } else {<br>
            &gt;               qemu_log_mask(LOG_GUEST_ERROR,<br>
            &gt;                             "ignoring pmpaddr write -
            read only\n");<br>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------QC239WoRnC5fgsZ8oy3c9Azo--

