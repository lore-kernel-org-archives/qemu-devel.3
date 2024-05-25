Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C26AC25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 08:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAnEI-0000Mr-QH; Sat, 25 May 2024 04:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAnEH-0000MX-4H
 for qemu-devel@nongnu.org; Sat, 25 May 2024 04:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAnEC-0005Xx-IN
 for qemu-devel@nongnu.org; Sat, 25 May 2024 04:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716627491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0KOB3BGeetd+o8EFfMEcK22xRhv5FamBeHGBUaN+T8=;
 b=idO4JTbTSw+wysUrDpvdDdVLZaWRCAGH8AxFJ70rXFxADdr4Mtsr3qC4Hi73WMCWQcH8Ph
 +fdBBbfjgQXYVVhQo9qkM6d+YtWFry4ewnLP2z0x1b9CLhs++26JWfVFFHwj6s7sxSspOh
 jJmRiMBTTaVyP8LWTUNGRK22DXLD1nU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-m_LReziNOUiJfZjYJNgSQw-1; Sat, 25 May 2024 04:58:09 -0400
X-MC-Unique: m_LReziNOUiJfZjYJNgSQw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-355045ed552so691112f8f.2
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 01:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716627487; x=1717232287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0KOB3BGeetd+o8EFfMEcK22xRhv5FamBeHGBUaN+T8=;
 b=KbIVXV7gGy2/MKv2iWmCPvDoHyILGsMVplU30lQXLWc2ByoWen8FfBeLsiARlZwbG6
 syw08GpkZ1xSMs0K4s7n8PckMPoe3a3yeSrfYOGCYUBiGH1tda+a2Il2Sq5YcOxbRKgE
 E/NUktT8rBV69zLz/bMEKxBJXMWkZvN9TBjwDsvcC+EpaUVLl8eJqLBkHY87W9Am4+HC
 kaa9Zy7BCmpBHip2m3a1sq6eh1rvROVNpvcU34eVJbYaIn4q0ERnX6JZwdtK1RfOOiYf
 IfaRVyauelsfqxzMFGxTZ/teLjS4fbcHdX2RNdPVbVIgQ+SGCE64q42tiJ1YWRh/wIA+
 oEZA==
X-Gm-Message-State: AOJu0YyTSdoSde2tovqoaP/pRXoo8jWFp5ITlNjMsENkZqLHSBZMQRrZ
 WnSXO47i1iUfgO6L6nPDTmgDm+XKKIsQq7PUD8tI3z9ggR6oqmQKYVCIM+779+i2zf2aw4bbaba
 rM4uthODBlVRjC2wfL2wAIgQ+9CM7w61rgXNl68wfvnTNbjhXKNHkgvan8xoH+sc+CFzH/sJ4TF
 8AUiOiCfc85NXReWmMYGplnZisPKpmK1vNwRmsPQ==
X-Received: by 2002:a05:6000:4010:b0:356:4bfc:75cb with SMTP id
 ffacd0b85a97d-3564bfc76aamr2715108f8f.50.1716627487355; 
 Sat, 25 May 2024 01:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0o/VaiHUI69AR0WE40mELmJy3bA83iF/3U9M2n+sCWPFNBuoq9thmPIeEBRLB9bedyYMkAkgIJ9gXyqJOKr4=
X-Received: by 2002:a05:6000:4010:b0:356:4bfc:75cb with SMTP id
 ffacd0b85a97d-3564bfc76aamr2715094f8f.50.1716627486907; Sat, 25 May 2024
 01:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240524153323.1267511-2-pbonzini@redhat.com>
 <d41e0504-aa75-4d88-93c4-a30843ea3942@linaro.org>
In-Reply-To: <d41e0504-aa75-4d88-93c4-a30843ea3942@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 25 May 2024 10:57:55 +0200
Message-ID: <CABgObfZSt9HT+1ogJaa48=FWYNHM3bES8DFZVypN8e06Qo4oxA@mail.gmail.com>
Subject: Re: [PATCH] target/i386: always go through gen_eob*()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 24, 2024 at 6:51=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> >   static void gen_set_hflag(DisasContext *s, uint32_t mask)
> > @@ -2354,7 +2354,7 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot=
, int diff, int tb_num)
> >               tcg_gen_movi_tl(cpu_eip, new_eip);
> >           }
> >           tcg_gen_exit_tb(s->base.tb, tb_num);
> > -        s->base.is_jmp =3D DISAS_NORETURN;
> > +        s->base.is_jmp =3D DISAS_EOB_ONLY;
>
> This is wrong because exit_tb exits, and anything you add after is unreac=
hable.
> I think you simply want to remove the exit_tb call as well, but there may=
 be more cleanup
> possible in the wider context; I haven't checked.

Ok, I'll check this one more closely.

> > @@ -3769,7 +3769,7 @@ static void disas_insn_old(DisasContext *s, CPUSt=
ate *cpu, int b)
> >               gen_helper_vmrun(tcg_env, tcg_constant_i32(s->aflag - 1),
> >                                cur_insn_len_i32(s));
> >               tcg_gen_exit_tb(NULL, 0);
> > -            s->base.is_jmp =3D DISAS_NORETURN;
> > +            s->base.is_jmp =3D DISAS_EOB_ONLY;
>
> Calls exit_tb, which is probably bogus here and EOB_ONLY is correct.
> But I'd need to look deeper into what vmrun does.

This is correct, but do_vmexit() needs to clear RF and handle
singlestep, and the helper needs to clear HF_INHIBIT_IRQ_MASK. In this
respect VMRUN/vmexit are is not unlike SYSRET/SYSCALL respectively,
except that EFLAGS.TF is never set right after VMRUN. That is, the
guest EFLAGS value has its effect only after the first instruction in
the guest, while the SYSCALL EFLAGS value interrupts before the first
instruction in CPL0.

> > @@ -1642,7 +1642,7 @@ static void gen_HLT(DisasContext *s, CPUX86State =
*env, X86DecodedInsn *decode)
> >       gen_update_cc_op(s);
> >       gen_update_eip_cur(s);
> >       gen_helper_hlt(tcg_env, cur_insn_len_i32(s));
> > -    s->base.is_jmp =3D DISAS_NORETURN;
> > +    s->base.is_jmp =3D DISAS_EOB_ONLY;
>
> noreturn.
>
> > @@ -4022,7 +4022,7 @@ static void gen_XCHG(DisasContext *s, CPUX86State=
 *env, X86DecodedInsn *decode)
> >               gen_update_cc_op(s);
> >               gen_update_eip_cur(s);
> >               gen_helper_pause(tcg_env, cur_insn_len_i32(s));
> > -            s->base.is_jmp =3D DISAS_NORETURN;
> > +            s->base.is_jmp =3D DISAS_EOB_ONLY;
>
> noreturn.

But these should handle HF_INHIBIT_IRQ_MASK/RF/TF and they don't
(except for HLT clearing HF_INHIBIT_IRQ_MASK). So there is a bug but
it's in the helpers.

Paolo


