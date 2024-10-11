Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12065D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4W-0001Bd-KC; Fri, 11 Oct 2024 13:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4Q-0000wP-Eu
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHeI-0007HW-8P
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfhsGNsaqM9wxDXFff8BXw/V55q8RaN7jwv0zZZjFLo=;
 b=c34Cvvl4YTZCJkgvNAjwdZsso0CTt/aRRjYoMEya65RcRRgi7YR7wWKM/0nWHuY3whzhnv
 GllR4Y7cLXxYqTm2k2bZ9lumjdbe8K3Z10Yzb2mVWCAwTWsMVLLGrCnhmPiwad6O6p6swM
 wM9pU6NbX7RgcoR1EdTee8oJ9vmmcLo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-epkQlto-Nv2xa03X3PMyTw-1; Fri, 11 Oct 2024 11:33:47 -0400
X-MC-Unique: epkQlto-Nv2xa03X3PMyTw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-53691cd5a20so2100407e87.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660825; x=1729265625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfhsGNsaqM9wxDXFff8BXw/V55q8RaN7jwv0zZZjFLo=;
 b=Pehbmi6C39DJqOHoo+Ce0tjWZCqRfoxeEO/sP2avR63gwvuOo+UhMIgdvUH7gIpFGj
 f/sz5kwbqmkSTU9waGB74yToTQwlPQ+BQl8cfNUFt8Zu8B69OcSnq9KNRwmXsOuh+uv9
 BkYr62Cf3aqe8Klvqq6sjaOsnbT5BTA3pQWwegESXUfr4fm9+Z/nyLybbGgIa4AO0zJm
 mIabac0bLGByHddoKGfOCCwyz9WvHS9Pa+xNpKKjgv83NYM+fXg1s47nXwsNs4OmoTZo
 jyb3Kgrm6uJhnG1aTr3LuQ5ECUgHeBlVPplqL8FfuGehpYXNqydOPOVgcdFtntOSj0/m
 9zZA==
X-Gm-Message-State: AOJu0Ywn4SwlmSDoQAkXFRSJ3bOK44206fV0f7DSQkouMM2r5nBDeuky
 7HtXIBJl9hl9yYH6R0lulQn7T1xa1cOkDHm5SkPnBfJ7V7w5d8BIXnYpVc8wFVeWGYYJNKaVKvw
 2pGv/mXO8ckhnnjkg4XSdehPrC1viX0GPyrr/n3sbBxrd5RECtc2JebtaByIwK7pxrAvrIQ9mLD
 a6RjM3QFF9YttCPJfFaYlksBNeg1mhvE/eskAx/rI=
X-Received: by 2002:a05:6512:3343:b0:539:948a:aadb with SMTP id
 2adb3069b0e04-539da552df1mr2043762e87.42.1728660825191; 
 Fri, 11 Oct 2024 08:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrcu0tWijA/3+gvmB+CGED6zswP+C0YKq8/AD3IEUbLbcW3hC0BpICG3wH+uP48kbhQ8aLBw==
X-Received: by 2002:a05:6512:3343:b0:539:948a:aadb with SMTP id
 2adb3069b0e04-539da552df1mr2043733e87.42.1728660824555; 
 Fri, 11 Oct 2024 08:33:44 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7ec56d8sm226391566b.17.2024.10.11.08.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:33:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 17/18] docs: avoid footnotes consisting of just URLs
Date: Fri, 11 Oct 2024 17:32:25 +0200
Message-ID: <20241011153227.81770-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/testing/acpi-bits.rst | 26 +++++++++++++-------------
 docs/specs/rapl-msr.rst          | 25 ++++++++++++-------------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/docs/devel/testing/acpi-bits.rst b/docs/devel/testing/acpi-bits.rst
index 78aeb6aa3c4..9a4d716ebff 100644
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


