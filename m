Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052F9F36BA8
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 03:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB2lM-00062e-M0; Thu, 09 Apr 2026 23:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB2lL-00061v-87
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wB2lI-0002Ad-0I
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775792546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NwfDZpCsHi9F5cF5ZWuT52Xnv7ONvtyTnR6haZym7L8=;
 b=Dpc3hAF/lGYhp/x6cBUQSxBG4AS01xrsNbdIvHFJxsN7F3W0JPZT57eeg/9VTI/qFUVgoP
 EIcxDy5MVqUOBosINBuPSNCCC+J4EWbmjPJj5Z4QF4kKnIOa+wQ5aTd7HmagWXaUM2nis5
 qr9jqmqT2cN6S85tcd8cg1I06sAoJuo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-WXQDtfqrOl6xThROLQeSRw-1; Thu, 09 Apr 2026 23:42:24 -0400
X-MC-Unique: WXQDtfqrOl6xThROLQeSRw-1
X-Mimecast-MFC-AGG-ID: WXQDtfqrOl6xThROLQeSRw_1775792544
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b630753cc38so2633232a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 20:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775792544; x=1776397344; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwfDZpCsHi9F5cF5ZWuT52Xnv7ONvtyTnR6haZym7L8=;
 b=rWRiepqWLFT88TkrmU65PWMtw8A1gbDZiR8ID4CRB9P9Z3/7D5egZQfsMjNaKP7CQO
 XuDt0BNDFzL/dsB0pnFTzCGe2KGeMEzx4Kck7aZKTo4bbflxrRVFK/0+VgbnQIL2AIO6
 mwnq1GjSijjBpc3CC02EbJ0GeAfLhWjAw048psSFlPAdanKfhcAA3KwzRkqxeZzknoJS
 GIaI1FdIvahKLDhyxuyMyyGumn2X4lW4NOYZshQhal8hYHx+VcYgt7B58TXcxZevvHnt
 SuDk8o0xcAoMevvrJz1+U5QjtJ2MqR/120NxRyeJF0kdxp4K1OguLRqdSG5Er2welt/I
 1rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775792544; x=1776397344;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NwfDZpCsHi9F5cF5ZWuT52Xnv7ONvtyTnR6haZym7L8=;
 b=emdWRgcyT6Oggljjw0B3yQfsFpo2IKlEeWTXJMQlRQi0M8NP8UriNcLjDOCrfp6ccz
 HPjrf9iEhThSpQQLKOGB7aYyPYPYJXry65SQwIIbCGHWJq0ziOHjWDWAal7I7afCIRiK
 NI4PJqP/nefUfIaiMzbykUwXclPmuf+ZyGViBBSK2bBqijP0aot4lLiHMpXpw6cg07C5
 w18l0ZGTvjWvCjmQiHzQrj7MpaGxtyKSj5HR+RUjnnuikY2zFnoY6cnAiRbtogyCCZNN
 578CyQECbYDBsW6Y11rt8BClS5tB+CUUL2DORyWdgeCZWqz8LcBIIhhuGPgwMnVwk8/2
 nzRw==
X-Gm-Message-State: AOJu0YxnJwcNHsPZvlQTcBJqKcsY7X651aqxHtUNwhH+mekHQ5dqT7wc
 Adf28Xw42UzAL75HptXks//FyaC19kS5OmvCcKLD6M6AvYl+Tucxl7x3M1TyJDCnrMxzFMVYCJT
 UEF2C9eEXREAVzl2ln7LsXR0k6CPvKqyx5B7RkaiS4ftvMnswcWHW7unQ
X-Gm-Gg: AeBDievbBT07pe7MJlpBl+G6zMbv6ka9cEIndncQg0v+HO2x/R4AQMl1G5NnLAqBCjI
 UgPq2nYEU/aju2NTjTE9Irhs6UI1ygzol/EiibgzZ/xb3Lh4+A3YTYEbZ8ViIHCyEQubimQ0k7s
 3Yjt71046itJtZ180eXXg3sCIHUONGAk3gWMeW7125haTy/C3D9bX7e0dQzuKbm9GELqyVBKZUm
 Cw/O7GyrTdD+X8QI3NNedpxnn9w8pPv5UYufMK1GR/Bbaj0DMVWIeRLcI5cuNh1tItiivSmKrvX
 SCoXVLSGlQXSqJRCdfB0D/0p+7XYTIeKVz9mUDxPpApmfP0WbM6dkyPAxS5jUKEg2SdaVpIh1Ro
 0pwJmJRQQjdKCnZtuCKHDl7qVAqe+ycm7M69JqaBHQLvx/JFN3h0SEZHGt2d52578Amj3qkIHgx
 Q=
X-Received: by 2002:a05:6a20:9389:b0:398:7a23:2779 with SMTP id
 adf61e73a8af0-39fe408bfa5mr1777448637.52.1775792543551; 
 Thu, 09 Apr 2026 20:42:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:9389:b0:398:7a23:2779 with SMTP id
 adf61e73a8af0-39fe408bfa5mr1777409637.52.1775792542980; 
 Thu, 09 Apr 2026 20:42:22 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79216fd6edsm948082a12.3.2026.04.09.20.42.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Apr 2026 20:42:22 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260409161042.55281-1-harshpb@linux.ibm.com>
Date: Fri, 10 Apr 2026 09:12:07 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0822D91-E199-4FEB-B1AA-28652D0F3453@redhat.com>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 9 Apr 2026, at 9:40=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>=20
> When kvm_cpu_exec() returns EXCP_HLT due to =
kvm_arch_process_async_events()
> returning true, it was returning before releasing the BQL (Big QEMU =
Lock).
> This caused a lock imbalance where the vCPU thread would loop back to
> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.

I am not sure I understand this. Seems kvm_cpu_exec() does expect that =
the caller holds bql before calling the function. Where is the lock =
imbalance?=20

>=20
> The issue manifests as boot hangs on PowerPC pseries machines with =
multiple
> vCPUs, where secondary vCPUs with start-powered-off=3Dtrue remain =
halted and
> repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each iteration =
held
> the BQL, preventing other operations from proceeding.
>=20
> The fix has two parts:
>=20
> 1. In kvm_cpu_exec() (kvm-all.c):
>   Release the BQL before returning EXCP_HLT in the early return path,
>   matching the behavior of the normal execution path where =
bql_unlock()
>   is called before entering the main KVM execution loop.
>=20
> 2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
>   Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, since the
>   loop expects to hold the BQL when calling kvm_cpu_exec() again.
>=20
> This ensures proper BQL lock/unlock pairing:
> - kvm_vcpu_thread_fn() holds BQL before calling kvm_cpu_exec()
> - kvm_cpu_exec() releases BQL before returning (for EXCP_HLT)
> - kvm_vcpu_thread_fn() re-acquires BQL if EXCP_HLT was returned
> - Next iteration has BQL held as expected
>=20
> This is a regression introduced by commit 98884e0cc1 ("accel/kvm: add
> changes required to support KVM VM file descriptor change") which
> refactored kvm_irqchip_create() and changed the initialization timing,
> exposing this lock imbalance issue.
>=20
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM =
file descriptor change")

I do not think this is the right reference. The above commit may have =
exposed some underlying issue but is certainly not the cause of it. =
Further, as we have discussed in the other thread, the changes in that =
commit are not even getting executed.

Personally I think the core issue is somewhere else. I am not convinced =
this is the proper fix.

> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
> accel/kvm/kvm-accel-ops.c | 4 ++++
> accel/kvm/kvm-all.c       | 1 +
> 2 files changed, 5 insertions(+)
>=20
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 6d9140e549..d684fd0840 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
>=20
>         if (cpu_can_run(cpu)) {
>             r =3D kvm_cpu_exec(cpu);
> +            if (r =3D=3D EXCP_HLT) {
> +                /* kvm_cpu_exec() released BQL, re-acquire for next =
iteration */
> +                bql_lock();
> +            }
>             if (r =3D=3D EXCP_DEBUG) {
>                 cpu_handle_guest_debug(cpu);
>             }
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..00b8018664 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
>     trace_kvm_cpu_exec();
>=20
>     if (kvm_arch_process_async_events(cpu)) {
> +        bql_unlock();
>         return EXCP_HLT;
>     }
>=20
> --=20
> 2.52.0
>=20


