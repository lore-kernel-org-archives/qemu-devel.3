Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3E2C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIiB-0000Fm-99; Mon, 15 Apr 2024 05:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rwIi8-0000BU-9L
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rwIi6-0003x3-Pr
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713173588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXeVV5KZsiTO7GW8ApZLRezbInuXzzD0NSa2Eoj+xTY=;
 b=bWxm8nb4lTzIhL8/VGTKEuljqN4NEkHUpBdpGrBkkWav8S2H9FRAD7RlEYGY9e0A6cHexP
 Rr6FrbY9sEAHQDlnNTvLXODkaCtD90pHuyVXaotIqOAhg30j2KGR0e3XTx6L9LUhC/IDnR
 2y394styGdOo0pHI0spOFNSWHeN8ELQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-kBQlcQQaOiaHqCreaeASgg-1; Mon, 15 Apr 2024 05:33:05 -0400
X-MC-Unique: kBQlcQQaOiaHqCreaeASgg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-343d7cd8f46so2319698f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713173583; x=1713778383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXeVV5KZsiTO7GW8ApZLRezbInuXzzD0NSa2Eoj+xTY=;
 b=I0TL3AZUOZhuWA+r/+pN3/sLGWqhxmba1iuQ6patk78KfGG0KQkXb0HhqSm0hMgPOy
 wFgr/Vp8RHxdn+1vTdsAbn3PVzf45bTDUiUwhdkpQ2sflXPSRinXfvrNDwswGJbcCTUL
 CzEvape4ggQ0M9VIg6B5QXRj/3DF09+IdOB38dgJI7hYyIjXHJiQ4m7zBnYMZDASMQuv
 oUN+cpxYeapYDAV2jLvxqJ9r2NINMvPguMGJQNG/iXDxhK8Io5uwuFKAP9O4RLbXGDFm
 H96J39B0l4OKJw0l9KAtiJSTuHxiy/UIHS2cJ3PAyRt2OK8YOwevANdR7DqUfOahA+Sh
 EcsA==
X-Gm-Message-State: AOJu0YzdhBrAaycOjDRy/IE0fRhu01WYoRHbu8AH6Gq1K+b2xQ9zF+jw
 241TA2frOaoKcBBzIHlK5uJg6hQgARKHLyfiI7rWKVHw9v96beYqUtT7tD9mteudcgVERPCPuR5
 ZiJnH3IdUZZgjJWfBwe/Mmju6VfU37h9GC2S39AODx5Cc3p28azUzS6I5500Hr/xFU/JILnpzh3
 lIsaY9Ek/QsJGnKrLX97szATl5PUbcxRGAR7jnKQ==
X-Received: by 2002:adf:db48:0:b0:346:7f2d:777d with SMTP id
 f8-20020adfdb48000000b003467f2d777dmr5618712wrj.2.1713173583740; 
 Mon, 15 Apr 2024 02:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5DUTXuVTZI6hbCxAFI/NsPy13P6jnVr9qrzxTIV2NDdxVwnTnY5RxCtxhHX3hnXUVBZkeMMtfF7jLIfMeps8=
X-Received: by 2002:adf:db48:0:b0:346:7f2d:777d with SMTP id
 f8-20020adfdb48000000b003467f2d777dmr5618700wrj.2.1713173583389; Mon, 15 Apr
 2024 02:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240415064518.4951-4-lrh2000@pku.edu.cn>
In-Reply-To: <20240415064518.4951-4-lrh2000@pku.edu.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Apr 2024 11:32:51 +0200
Message-ID: <CABgObfZmQoSBMQx=t0UYCa6t5d9RRZKy23zeW3orrBYnVQtKYQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
To: Ruihan Li <lrh2000@pku.edu.cn>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 15, 2024 at 8:50=E2=80=AFAM Ruihan Li <lrh2000@pku.edu.cn> wrot=
e:
>
> When emulated with QEMU, interrupts will never come in the following
> loop. However, if the NOP instruction is uncommented, interrupts will
> fire as normal.
>
>         loop:
>                 cli
>                 call do_sti
>                 jmp loop
>
>         do_sti:
>                 sti
>                 # nop
>                 ret
>
> This behavior is different from that of a real processor. For example,
> if KVM is enabled, interrupts will always fire regardless of whether the
> NOP instruction is commented or not. Also, the Intel Software Developer
> Manual states that after the STI instruction is executed, the interrupt
> inhibit should end as soon as the next instruction (e.g., the RET
> instruction if the NOP instruction is commented) is executed.

Thanks, interesting bug!

What do you think about writing this:

>      /* If several instructions disable interrupts, only the first does i=
t.  */
>      if (inhibit && !(s->flags & HF_INHIBIT_IRQ_MASK)) {
>          gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
> -    } else {
> +        inhibit_reset =3D false;
> +    } else if (!inhibit && (s->flags & HF_INHIBIT_IRQ_MASK)) {
>          gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
> +        inhibit_reset =3D true;
> +    } else {
> +        inhibit_reset =3D false;
>      }

in a slightly simpler manner:

    inhibit_reset =3D false;
    if (s->flags & HF_INHIBIT_IRQ_MASK) {
        gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
        inhibit_reset =3D true;
    } else if (inhibit) {
        gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
    }

No need to submit v3, I can do the change myself when applying.

Paolo


