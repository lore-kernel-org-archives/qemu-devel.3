Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0459BCFD34D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 11:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szDZz-00076O-LX; Fri, 11 Oct 2024 07:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szDZy-00076A-Do
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szDZu-00073g-IU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728645181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C47oi+p/U14aTwO300CpbdGtBMf6xzPszQtxxdH6ifk=;
 b=MpEMMcgqta/dh57BfrsCib+LeiYbl+ox/P9rfzoMY8Nh22Gsps04pReg4r0k/VwyzWa/yS
 iaLMdcOnF07hgDxRwddtdYlskzEKn3aCXjMcbZD3YdICTOGG4VqUTN5NaTAE/uuzHEUe4j
 3vJGMzv16aVVmgZvABGyztnq93ryDvk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-aIZQ0jLWPU23UNk7ltdGXw-1; Fri, 11 Oct 2024 07:13:00 -0400
X-MC-Unique: aIZQ0jLWPU23UNk7ltdGXw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2fb3110b82aso4866441fa.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 04:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728645178; x=1729249978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C47oi+p/U14aTwO300CpbdGtBMf6xzPszQtxxdH6ifk=;
 b=kLZ0cSp+HPVM9olV3A/tcnTdm8PiWwI8tW45mtX2nzRt3+xIBTdereO8WGZ+43B7HU
 5y7XVAQI0B/UpXbqTKGw4VMP8zzD7sN0y02VBVQAI7wxjOsb3EiwwlZgzEzCV3X6kWwI
 g6JB6NrDpaQ5glSME2aaiS0hqvW4nDJ1ARDMT2IJYHEML4ULoZnubfBgK6oOMErnLKXa
 TfOOEuHQAKr+QdW1Ab0tEo7UG4Ssy8QkvkXe39+vVHM5MawoZ21B3m/7SBkaBepjwoOQ
 WMqa2wGSGcYN99z1N1n0KikqUtUXuy0mjCra6iiOjFAiZI5uYGK5k+FAFfd52CnrRP70
 X8yw==
X-Gm-Message-State: AOJu0YyuE0Mk1PZL0bdnXL6Yo97ri4PArX3/nW1hRzno2dZwbw2c+A1K
 qr4vG6zaJFlnG1hTVwBWsujNGwqNRSVZ+FURUuVS+J/reOrBKC5lJXERPtvP3vi9GOKyGHAu3ug
 dKgbXkEWTXB878MojnlCL2mJXTD8/rBr5RUWNuHSfDiRhi5m5ue0Po3pamSfvtUpIjeoY0fJm6Q
 D3ZvwaYZSLdDIwtcLkKwvdRZgvFpSKo5ZgytNCEP8=
X-Received: by 2002:a05:651c:551:b0:2f3:f4e2:869c with SMTP id
 38308e7fff4ca-2fb32b242ddmr12744961fa.44.1728645177917; 
 Fri, 11 Oct 2024 04:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1COeZhZy9aOy7ENEf+NpEn8qbRm08p8dbK7DAwkdrN3hVBqaf+fPJNGwx1lFZmMTMWvuDYw==
X-Received: by 2002:a05:651c:551:b0:2f3:f4e2:869c with SMTP id
 38308e7fff4ca-2fb32b242ddmr12744651fa.44.1728645177272; 
 Fri, 11 Oct 2024 04:12:57 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c937293d10sm1819484a12.79.2024.10.11.04.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 04:12:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 2/3] docs: avoid footnotes consisting of just URLs
Date: Fri, 11 Oct 2024 13:12:48 +0200
Message-ID: <20241011111249.47530-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011111249.47530-1-pbonzini@redhat.com>
References: <20241011111249.47530-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Replace the footnotes with inline links whenever the footnote text
consists of nothing but the URL.  While at it, make the link texts
consistent in the surrounding areas, for example avoiding usage of
"here" for the link's text.

In the case of acpi-bits.rst this fixes a build failure with Sphinx
8.1.0, because the FOSDEM link was duplicated in the paragraph and the
new version is a lot stricter about unreferenced footnotes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/testing/acpi-bits.rst | 26 +++++++++++++-------------
 docs/specs/rapl-msr.rst          | 25 ++++++++++++-------------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/docs/devel/testing/acpi-bits.rst b/docs/devel/testing/acpi-bits.rst
index 78aeb6aa3c4..764e0ef51a5 100644
--- a/docs/devel/testing/acpi-bits.rst
+++ b/docs/devel/testing/acpi-bits.rst
@@ -30,15 +30,20 @@ OS modules are generally written using low level languages such as C and
 low level assembly machine language. Writing test routines in a low level
 language makes things more cumbersome. These and other reasons makes using
 bios-bits very attractive for testing bioses. More details on the inspiration
-for developing biosbits and its real life uses can be found in [#a]_ and [#b]_.
+for developing biosbits and its real life uses were presented `at Plumbers
+in 2011 <Plumbers_>`__ and `at Linux.conf.au in 2012 <Linux.conf.au_>`__.
 
-For QEMU, we maintain a fork of bios bits in gitlab along with all the
-dependent submodules `here <https://gitlab.com/qemu-project/biosbits-bits>`__.
-This fork contains numerous fixes, a newer acpica and changes specific to
-running these functional QEMU tests using bits. The author of this document
-is the sole maintainer of the QEMU fork of bios bits repository. For more
-information, please see author's `FOSDEM talk on this bios-bits based test
-framework <https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/>`__.
+For QEMU, we maintain a fork of bios bits in `gitlab`_, along with all
+the dependent submodules.  This fork contains numerous fixes, a newer
+acpica and changes specific to running these functional QEMU tests using
+bits. The author of this document is the current maintainer of the QEMU
+fork of bios bits repository. For more information, please see `the
+author's FOSDEM presentation <FOSDEM_>`__ on this bios-bits based test framework.
+
+.. _Plumbers: https://blog.linuxplumbersconf.org/2011/ocw/system/presentations/867/original/bits.pdf
+.. _Linux.conf.au: https://www.youtube.com/watch?v=36QIepyUuhg
+.. _gitlab: https://gitlab.com/qemu-project/biosbits-bits
+.. _FOSDEM: https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/
 
 *********************************
 Description of the test framework
@@ -148,8 +153,3 @@ Under ``tests/functional/`` as the root we have:
 
 Author: Ani Sinha <anisinha@redhat.com>
 
-References:
------------
-.. [#a] https://blog.linuxplumbersconf.org/2011/ocw/system/presentations/867/original/bits.pdf
-.. [#b] https://www.youtube.com/watch?v=36QIepyUuhg
-.. [#c] https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/
diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
index 1202ee89bee..aaf0db9f91b 100644
--- a/docs/specs/rapl-msr.rst
+++ b/docs/specs/rapl-msr.rst
@@ -9,11 +9,12 @@ The consumption is reported via MSRs (model specific registers) like
 MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are 64 bits
 registers that represent the accumulated energy consumption in micro Joules.
 
-Thanks to the MSR Filtering patch [#a]_ not all MSRs are handled by KVM. Some
-of them can now be handled by the userspace (QEMU). It uses a mechanism called
-"MSR filtering" where a list of MSRs is given at init time of a VM to KVM so
-that a callback is put in place. The design of this patch uses only this
-mechanism for handling the MSRs between guest/host.
+Thanks to KVM's `MSR filtering <msr-filter-patch_>`__ functionality,
+not all MSRs are handled by KVM. Some of them can now be handled by the
+userspace (QEMU); a list of MSRs is given at VM creation time to KVM, and
+a userspace exit occurs when they are accessed.
+
+.. _msr-filter-patch: https://patchwork.kernel.org/project/kvm/patch/20200916202951.23760-7-graf@amazon.com/
 
 At the moment the following MSRs are involved:
 
@@ -92,9 +93,12 @@ found by the sysconf system call. A typical value of clock ticks per second is
 package has 4 cores, 400 ticks maximum can be scheduled on all the cores
 of the package for a period of 1 second.
 
-The /proc/[pid]/stat [#b]_ is a sysfs file that can give the executed time of a
-process with the [pid] as the process ID. It gives the amount of ticks the
-process has been scheduled in userspace (utime) and kernel space (stime).
+`/proc/[pid]/stat <stat_>`__ is a procfs file that can give the executed
+time of a process with the [pid] as the process ID. It gives the amount
+of ticks the process has been scheduled in userspace (utime) and kernel
+space (stime).
+
+.. _stat: https://man7.org/linux/man-pages/man5/proc.5.html
 
 By reading those metrics for a thread, one can calculate the ratio of time the
 package has spent executing the thread.
@@ -148,8 +152,3 @@ Current Limitations
 - Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at the
   moment.
 
-References
-----------
-
-.. [#a] https://patchwork.kernel.org/project/kvm/patch/20200916202951.23760-7-graf@amazon.com/
-.. [#b] https://man7.org/linux/man-pages/man5/proc.5.html
-- 
2.46.2


