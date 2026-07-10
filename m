Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FE7C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCah-0004Dd-TO; Fri, 10 Jul 2026 10:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yisooan.dev@gmail.com>)
 id 1wiCag-0004DG-Aw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:52:34 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yisooan.dev@gmail.com>)
 id 1wiCae-0007c4-EQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:52:34 -0400
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7e9ecb1e13bso499021a34.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 07:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783695151; x=1784299951;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6K3++yYqtMVz+66TdVWG0CLOVt7auPHDlu9IMlBdkQk=;
 b=EGjZOoO6yX4qvsnaeBH9gNvuPHWKDCaGKcYjgisDMpxuWnzrR2+Qwl3Y5DgOAwUln6
 z1FmMdQm36Ze8tvtTp4XaPZNHM59lvLx5XTE5PKQm/vmVmCTWPAn8JHKSER9EGZdVjV6
 TbXS86UcL5prrLk/wwj009aJS/+LWP2JQsVQqidJU6kNWJrvlpfZzO4XVjET5t3PKQz1
 sNlr7OFJUiMVXK4KX6YC6k/047Gyid0SvOKNeGOWoMMC5yJbtn9OA+xmYvTbWSDBPIbX
 0zp3TqRA3rgy7HOlMgGsThfpM+nHY7kPOw4k3S+fZErDuLU5So+qedGvp8NtCc9WN22V
 +I5A==
X-Gm-Message-State: AOJu0Ywfi4G8ro/P9+6THRk55niJrkOblhEfT4X12JEP+yIf9SLywvn/
 SlU9QSDoCPYmUtm8I0oQQk8KBLfoXFVSEF9PC1nhO8IlomR6vXBREhEyJo47FkQJZeY=
X-Gm-Gg: AfdE7cn0RYC6lFCk5beB119Kq6ivzDLZo2A3/auecWLbYJkLGnINSy3TMa/Qskbfxwy
 CgtND1E1r0NcGwRWWB2ZMoeEPGzQJyVBHCj0QtcGHf5zDw0mQJZYOKzXSfiIkGWOQryROgHChE8
 vmUOcNvjbPVWzxSgUsB+YU5JaIqyrhS1cA1CTBV/lBiZAPLfQGhADeRZYz2BKJwoX5TP2O9xuoM
 w7eIFrPhERvgWYAAsExY2PlGsZjKvs0/muWDizcnC3K9SV4WMjGLFf+JFo9+GJXw3o085Ofye3K
 EbJMdhVH0mO177dRCwWRwgy9JEi8mPoZSMCKtfp0Gz3YCkx5nQjAUSWyAAKkQb4f2500XnxOFxY
 lyCEgXofoMAmjCxAlyFcFa8kSpLZepxoHlznzs/+VOMNQHnIwZOZysWFLsup5SvdMCEaSOHLStf
 hlqZT40ytffDFgLePHoO/C0hS0nQu1BDamiyrbKltoqJ4RwHzk
X-Received: by 2002:a05:6830:43a7:b0:7e9:dbbe:5af9 with SMTP id
 46e09a7af769-7ebd0046109mr8112330a34.31.1783695150680; 
 Fri, 10 Jul 2026 07:52:30 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com.
 [209.85.167.181]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2631dfsm6482268a34.13.2026.07.10.07.52.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 07:52:30 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-49c86d1d21cso426336b6e.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 07:52:30 -0700 (PDT)
X-Received: by 2002:a05:6808:c3f4:b0:496:11f1:f2b5 with SMTP id
 5614622812f47-4a202007753mr9756848b6e.10.1783695150115; Fri, 10 Jul 2026
 07:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-guest-panic-unhandle-v1-1-6adfb6d4221e@ooseel.net>
In-Reply-To: <20260623-guest-panic-unhandle-v1-1-6adfb6d4221e@ooseel.net>
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Fri, 10 Jul 2026 23:52:18 +0900
X-Gmail-Original-Message-ID: <CANTT7qiAidmrEPD=S7F4s_JNvFYL4cY=CWLbbfuJgOM0syqMbQ@mail.gmail.com>
X-Gm-Features: AUfX_mwSWH_Sd1f0Xuv3kZHDs_waThqZKSdJLzxJdpePxRaV9PhpOQLdXVn6g3U
Message-ID: <CANTT7qiAidmrEPD=S7F4s_JNvFYL4cY=CWLbbfuJgOM0syqMbQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: panic the guest if an unhandled exception
 occurs
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.43; envelope-from=yisooan.dev@gmail.com;
 helo=mail-ot1-f43.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ping

2026=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:56, L=
eesoo Ahn <lsahn@ooseel.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> It's worth cleaning up all resources that the guest taking and to quit
> if an exception in el1 could not be resolved.
>
> Otherwise, the guest will get in the infinite black-hole by
> unmodified pc.
>
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> ---
>  target/arm/hvf/hvf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 8b902c6882..4358cf90e8 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2533,6 +2533,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_v=
cpu_exit_exception_t *excp)
>          cpu_synchronize_state(cpu);
>          trace_hvf_exit(syndrome, ec, env->pc);
>          error_report("0x%llx: unhandled exception ec=3D0x%x", env->pc, e=
c);
> +        qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>      }
>
>      /* flush any changed cpu state back to HVF */
>
> ---
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> change-id: 20260623-guest-panic-unhandle-4921d2aa69fb
>
> Best regards,
> --
> Leesoo Ahn <lsahn@ooseel.net>
>

