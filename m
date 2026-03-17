Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CE7FB5EAC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 03:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2LZ2-000432-Ie; Mon, 16 Mar 2026 23:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w2LYv-000422-5n
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:57:45 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w2LYq-0007a0-KT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773719860; x=1805255860;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2DQPR4kp4Oe9Za7Cfq3DjztWi966J9lLwn0a14wa8dY=;
 b=Cu0+ZEEAGvAT6ml/uYePFlv4C3kCFs43T/Sa1cjJ2BMUgaA6BojvTAuD
 JvS/i7lOuzIh8/19ez4++N9gqkAPVK4Hn2bo6GOnT4AAfbbf/OrfBu0a2
 s4ZCYkwTdBNY6H8pi4bXS0Q1I/eGOo+Gigt63pbwXSri7E1/uQu0Ukp+l
 J2mJS4MbQ8h7dpiKhS+DqQgh5cRqRhzL9r/IIuzdXFkhMWHbIBg9ZVxXP
 /qcvWLLqN4BKY6KhfGRnffPYAF5d6kLtqXeQ2t6WpeQZb8+H5yTyrnG7T
 G10gu4tLdwkpdcAQb/gECIVnzWq9snGitE5prdoi0OeMMGDrxE4cHGki3 w==;
X-CSE-ConnectionGUID: 6Unh9d1RRrSMmUV/X2p5UA==
X-CSE-MsgGUID: Ds1mynAURg6YmhWLlEKPeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="100200003"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="100200003"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 20:57:36 -0700
X-CSE-ConnectionGUID: yQQDLNWmSpOUOKOY0xMTOA==
X-CSE-MsgGUID: KaZtZ/yFTT+IcTVizIEQNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226252125"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 16 Mar 2026 20:57:34 -0700
Date: Tue, 17 Mar 2026 12:23:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PULL 04/41] pc: Start with modern CPU hotplug interface by
 default
Message-ID: <abjXUtJNrcmSFUP4@intel.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
 <20260212144244.22579-5-pbonzini@redhat.com>
 <CAFEAcA-O4g5ZrRdK1s5kBjMfRbWhPnD0hLZwhpVHVHVbE7LKdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-O4g5ZrRdK1s5kBjMfRbWhPnD0hLZwhpVHVHVbE7LKdQ@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+Philippe & Aurelien

(And seeking Igor's input)

> The problem is that the vmstate_cpu_hotplug VMStateDescription
> that is being used has a NULL "fields" (it is the "stub" one).
> This used to be OK because the "piix4_pm/cpuhp" vmstate had
> a "needed" function that would return false for Malta, so we
> never tried to use the stub code.
> 
> What's the intention here ? Shouldn't we still have a "needed"
> function that returns "false" for the cases where we would be
> using the stub version of vmstate_cpu_hotplug ? Otherwise we
> would be changing the migration data. We can permit a compat
> break for MIPS boards, but the commit message suggests that
> this wasn't intended to be a compat break.

Thanks, this is my bad - I didn't realize it would break Malta. The
"needed" method looks necessary, but previously making the "stub" one
depend on cpu_hotplug_legacy=true also sounds a bit not proper.

Maybe in the needed() method we should also check whether the board/
machine supports CPU hotplug: check mc->has_hotpluggable_cpus. IIUC,
Malta doesn't support this.

> In this thread Fabiano suggests a fix which is probably OK
> if we want to take the "break migration compat" route:
> https://lore.kernel.org/qemu-devel/CAFEAcA9BzSp9F8yv4eZv5eeUM4JXSy9T-QnRr_UbJZpNmhtHyw@mail.gmail.com/T/#m6f4a672ddfa8a0a34dfdf9b57bb04e529ab5c9a4

I think Fabiano's patch is a clean solution. Or I think there's another
option: we can bring needed() back but check mc->has_hotpluggable_cpus
instead, like acpi-ged/cpuhp did ().

Igor, what do you think?

---
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index bbb1bd60a206..5c7dfb2c69db 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -184,10 +184,18 @@ static const VMStateDescription vmstate_tco_io_state = {
     }
 };

+static bool cpuhp_needed(void *opaque)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return mc->has_hotpluggable_cpus;
+}
+
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "ich9_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
+    .needed = cpuhp_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 43860d122780..9b7f50c7afac 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -195,10 +195,18 @@ static const VMStateDescription vmstate_memhp_state = {
     }
 };

+static bool cpuhp_needed(void *opaque)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return mc->has_hotpluggable_cpus;
+}
+
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "piix4_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
+    .needed = cpuhp_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, PIIX4PMState),
         VMSTATE_END_OF_LIST()




