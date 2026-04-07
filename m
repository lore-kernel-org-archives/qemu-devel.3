Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC420FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXg-0000L0-8q; Tue, 07 Apr 2026 14:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wABUM-0004Gt-Rs
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w9xlb-0004Sr-DA
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 00:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775535017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNyif/tdJApRc5vtWDyZe5DQdJz8xXLQJt4vpi3vnuU=;
 b=DHPuk3x/YoBDLtjy/RqwitFeOoXCcyY5NaZr4oIjig/VMqzLVPPBbmX7Ffctla4hxDovpF
 aiGb71ZVijwQTVk+1b/1d4JnYuXkcSKtRmRGvqw5IrbD9iyHfD9ee1oVsQsNn3d1zK8650
 8Ru6k8pPZ0yaCqi9oQnzIsMLXKcQNis=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-qUIOHRFHMgmUr5FZsMTR7Q-1; Tue, 07 Apr 2026 00:10:03 -0400
X-MC-Unique: qUIOHRFHMgmUr5FZsMTR7Q-1
X-Mimecast-MFC-AGG-ID: qUIOHRFHMgmUr5FZsMTR7Q_1775535002
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82cf0130d17so2711269b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 21:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775535002; x=1776139802; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNyif/tdJApRc5vtWDyZe5DQdJz8xXLQJt4vpi3vnuU=;
 b=Eau5WuRDZRsVxrG0HyhvpomJRiHDmJvnERaBXOJrPxPIE6AiX0FtbBUUqMlvDz5L+K
 mXrCnXoOvBWw1L8suEfeE/4KkT503y+zzhR4est9VUr6oglAbxKgfovvC+A+Xmu+ygik
 l8IyVOZpCyV2mk03tOgbtNLe4Lj7Tbd/afy2TwWwPthGREzPwbQbH9Bfy1jwffnaueZX
 SCYbBsW1ktlCf4KbITht99zl8SdU+cTmicA2HkiQGZjDCY7NRCJb16Xzlp//K3fWFC5f
 dJ+ETGyh+pXCqX8BJ/KmPekDsd5WqFbQMkDolaej2IJDV1R4wrm31eJ7dbEKnvu8jE5q
 1SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775535002; x=1776139802;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zNyif/tdJApRc5vtWDyZe5DQdJz8xXLQJt4vpi3vnuU=;
 b=Y8q6Y05qyJ3sm76GtnWdsJUpehjZEa4aeeVAfkVU3aVZtx9YPXIo07BoLueccH55fG
 UZ6PllA8fF/5+6YbQOPXdqT6+qRkUVEvxftlunq9KV9OlV1SlfHOH3UC1gP68Arrfs0P
 /XhGFaX8UsR6axJ8Y7AzDez0+jRjX9iM+JFSMavzJMKa5VbSoiPL4gJmEoErH/LaHYie
 BIp6+qbUqcmqFLm8SvHnnK85bfhiTS0kbOiGCTAZNj4n7eg8iHE5S3I+1KsZqcz2iNlz
 Ui15eWM5TtdSQbMsdPsPqofML4soAScQphb+9WpzTNctln0UPpWiReMjFecGBYtGGyAh
 p1ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCX26mGKEKp4DNMa2+y+gu05dVCHVzDM5nIF/ZoZgxvkNNTg3LOHLrloTWgFoDcz54iy2msHsZHWtkzd@nongnu.org
X-Gm-Message-State: AOJu0YwC5kW5+415o6CKhRUd0RYFyxeqncGa+E04BtrEkIwdFSIzDDea
 zM3gtAb6dbwK3R62nWOofV/zEm1XpPfJ3qjDPIN6bQct3KgGsbCyTRwivTq7Y0iyexb+GXx/mlU
 lUCdgTHWdESTXJnWSSNJUPMtbX3K/o+YDj4gJGBaAV2nL0d1YwxE6bLIo
X-Gm-Gg: AeBDievSLVp6mc9KeNfDvMEsfB7g+GrGGMoChgWxa9DJNeEkCXSXAxJpTckDyrroRdo
 yxfu27W64eCh9f2XYxtDTTObBs5yI0N3NTCm5Eaj2v7SzfR0k3lS/DvdnWUERK3NErwvUQWlrJ1
 7QqWU1GQAb3433C7oMr714hyx1wt275yHBzeT1w1Amuke2t4wkM1KS9AdJJKZyo+JzQS2vCn+aj
 IPymT/maKSxJXk18Q8/uzjCFk20zthVXD5RGtviUiwuWAH7DfqKuCUdqkqnGtw1Qeho9Nlm98Uh
 h9tz2mCEga1ETD1zACS4FYR3YB7HBlV1WqAREHUl6cz58CjCRgMCCYCrghdZ4+kdY2XycgZczgf
 c3z3qUOrZ3lASZ1VTjvyVWZrP2qsvCoPfwdOfnPx5MH0qK6D489a98bxDaYOKRrXkMoN7/UpMn7
 c=
X-Received: by 2002:a05:6a00:198d:b0:827:2eff:a29e with SMTP id
 d2e1a72fcca58-82d0db72b9fmr15749188b3a.34.1775535002022; 
 Mon, 06 Apr 2026 21:10:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:198d:b0:827:2eff:a29e with SMTP id
 d2e1a72fcca58-82d0db72b9fmr15749127b3a.34.1775535001497; 
 Mon, 06 Apr 2026 21:10:01 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b60199sm14410460b3a.25.2026.04.06.21.09.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Apr 2026 21:10:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ab72cb8395bcc2b1f489c5611bb7c00d@linux.ibm.com>
Date: Tue, 7 Apr 2026 09:39:46 +0530
Cc: Pbonzini <pbonzini@redhat.com>, Qemu Devel <qemu-devel@nongnu.org>,
 Qemu Ppc <qemu-ppc@nongnu.org>, npiggin@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1014F925-4992-459B-B5B4-E6CCAC7FBC02@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
 <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
 <ED4A083D-2B96-468A-BE77-211E9F3FA88D@redhat.com>
 <7bbeb3cb105934e95bf1a5356cfc4613@linux.ibm.com>
 <7ACBCD63-B759-47FD-824F-0327726E47F6@redhat.com>
 <35f6361f69ef4f09f80bd915f3460a28@linux.ibm.com>
 <B2B682DB-1467-4C42-AF74-346BC61DE31B@redhat.com>
 <526d7172f3933baf913bf4b105a6fa9a@linux.ibm.com>
 <9794AFF9-DFD9-48D0-B4EA-7745ABDED6F7@redhat.com>
 <DCB3A7E9-412C-402D-A4C9-EA558CD1FE29@redhat.com>
 <ab72cb8395bcc2b1f489c5611bb7c00d@linux.ibm.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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



> On 6 Apr 2026, at 2:24=E2=80=AFPM, Misbah Anjum N =
<misanjum@linux.ibm.com> wrote:
>=20
> Hi Ani,
> I've completed the testing you suggested. Unfortunately, the SMP hang =
still persists with these changes.
>=20
> Changes made:
> As requested, I reverted everything in stubs/kvm.c and the related =
changes in stubs/meson.build, include/system/kvm.h, and =
target/i386/kvm/kvm.c. I also commented out the calls to =
kvm_arch_supports_vmfd_change() and kvm_arch_on_vmfd_change() in =
kvm_reset_vmfd().
>=20
> Test result:
> The issue persists - guests still hang indefinitely during boot when =
SMP is configured.
>=20
> Git diff:
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index cc5c42ce4d..04b9cbe7c9 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2622,11 +2622,12 @@ static int kvm_reset_vmfd(MachineState *ms)
>      * bail if the current architecture does not support VM file
>      * descriptor change.
>      */
> -    if (!kvm_arch_supports_vmfd_change()) {
> +    /*if (!kvm_arch_supports_vmfd_change()) {
>         error_report("This target architecture does not support KVM VM =
"
>                      "file descriptor change.");
>         return -EOPNOTSUPP;
>     }
> +    */
>=20
>     s =3D KVM_STATE(ms->accelerator);
>     kml =3D &s->memory_listener;
> @@ -2659,10 +2660,10 @@ static int kvm_reset_vmfd(MachineState *ms)
>     }
>     assert(!err);
>=20
> -    ret =3D kvm_arch_on_vmfd_change(ms, s);
> +    /*ret =3D kvm_arch_on_vmfd_change(ms, s);
>     if (ret < 0) {
>         return ret;
> -    }
> +    }*/
>=20
>     if (s->kernel_irqchip_allowed) {
>         do_kvm_irqchip_create(s);
>=20
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 5fc7251fd9..0dad0079ed 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -456,8 +456,6 @@ int kvm_physical_memory_addr_from_host(KVMState =
*s, void *ram_addr,
>=20
> #endif /* COMPILING_PER_TARGET */
>=20
> -bool kvm_arch_supports_vmfd_change(void);
> -int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
>=20
> void kvm_cpu_synchronize_state(CPUState *cpu);
>=20
> diff --git a/stubs/kvm.c b/stubs/kvm.c
> deleted file mode 100644
> index 2db61d89a7..0000000000
> --- a/stubs/kvm.c
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/*
> - * kvm target arch specific stubs
> - *
> - * Copyright (c) 2026 Red Hat, Inc.
> - *
> - * Author:
> - *   Ani Sinha <anisinha@redhat.com>
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -#include "qemu/osdep.h"
> -#include "system/kvm.h"
> -
> -int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
> -{
> -    abort();
> -}
> -
> -bool kvm_arch_supports_vmfd_change(void)
> -{
> -    return false;
> -}
>=20
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 6ae478bacc..8a07059500 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -74,7 +74,6 @@ if have_system
>   if igvm.found()
>     stub_ss.add(files('igvm.c'))
>   endif
> -  stub_ss.add(files('kvm.c'))
>   stub_ss.add(files('target-get-monitor-def.c'))
>   stub_ss.add(files('target-monitor-defs.c'))
>   stub_ss.add(files('win32-kbd-hook.c'))
>=20
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 524b5276a6..3dfd9a5974 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3389,15 +3389,6 @@ static int kvm_vm_enable_energy_msrs(KVMState =
*s)
>     return 0;
> }
>=20
> -int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
> -{
> -    abort();
> -}
> -
> -bool kvm_arch_supports_vmfd_change(void)
> -{
> -    return false;
> -}
>=20
> int kvm_arch_init(MachineState *ms, KVMState *s)
> {
>=20
>=20
> I've also tested with the latest QEMU build from master, and the issue =
still persists there as well. Could you suggest what additional =
debugging steps I should take to help identify the root cause?

Since you mentioned that 98884e0cc1 is the root of the problem, the =
intention is to bisect within this patch and find the problematic hunk. =
You reported that reverting a major part of this patch did not make a =
difference. Maybe you can try reverting the following refactoring too =
(in addition to the reverts above) and see what happens.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0d8b0c4347..cc5c42ce4d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2415,11 +2415,9 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
=20
-static void kvm_irqchip_create(KVMState *s)
+static void do_kvm_irqchip_create(KVMState *s)
 {
     int ret;
-
-    assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
         ;
     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
@@ -2452,7 +2450,13 @@ static void kvm_irqchip_create(KVMState *s)
         fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
         exit(1);
     }
+}
+
+static void kvm_irqchip_create(KVMState *s)
+{
+    assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
=20
+    do_kvm_irqchip_create(s);
     kvm_kernel_irqchip =3D true;
     /* If we have an in-kernel IRQ chip then we must have asynchronous
      * interrupt delivery (though the reverse is not necessarily true)

If reverting the above still shows the issue, then I think 98884e0cc1 is =
not the root cause of the issue. The issue is somewhere else as we have =
tried reverting almost everything from that patch except implementation =
of kvm_reset_vmfd() which as you reported isn=E2=80=99t called/executed.

>=20
> Thanks,
> Misbah Anjum N <misanjum@linux.ibm.com>
>=20
>=20
> On 2026-03-18 15:00, Ani Sinha wrote:
>> One possible thing to try is:
>> Revert everything in stubs/kvm.c and hence changes in
>> stubs/meson.build, include/system/kvm.h and in target/i386/kvm/kvm.c
>> introduced by 98884e0cc1 .
>> You will have to comment out calls to kvm_arch_supports_vmfd_change()
>> and kvm_arch_on_vmfd_change() in kvm_reset_vmfd(). Since
>> kvm_reset_vmfd() is not called anyway, not should make no difference
>> if those calls are commented out.
>> Let me know what you get after doing the above.
>=20


