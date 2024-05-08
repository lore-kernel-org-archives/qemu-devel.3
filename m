Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F31C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 04:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4YlC-0000I6-7w; Wed, 08 May 2024 00:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s4Yl9-0000G3-Ie
 for qemu-devel@nongnu.org; Wed, 08 May 2024 00:18:27 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s4Yl6-0008JM-R0
 for qemu-devel@nongnu.org; Wed, 08 May 2024 00:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715141905; x=1746677905;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Et9LDUjAoJfJWqbCQk5T4r9yxQDevWwlglwqSn5X2VI=;
 b=Wz92KGH6CG9iDJNmO4UzdRE+1L8kMkcm3ACekCDgrH3HRzEw8cYxAhuz
 SNmbGZADiHtGaCxlZpL6Fhe6vgmCy4stmOFmt/NMAh2iLrwLTSeiJOn+j
 NKlBm7+mfqxpMQb2oOp5gxnA/T5AEfsNAfeIikZsKcKH5pNCVHX+08Cfi
 RQRSRWtUEVF95yyhSSp+AUE3hJDlu0bbS7y/IskvkthwIFBn4dmzXl2ds
 QfPUv5f4yIgACu4Kt1+0+rFW6Y+YMIXMY5XStIdUDR79P/IFK4yEGI9/c
 uYaXTdPt4QoRPczp7Eu7OPKVSJ/4Zh5KlyLv3KQCvLY2xJxG7wS4Xv++s Q==;
X-CSE-ConnectionGUID: /4mOvDCJS9K9ziU4Ze56mA==
X-CSE-MsgGUID: VNEZ9YOiRYWzF4TdHOWRZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22372044"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="22372044"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 21:18:21 -0700
X-CSE-ConnectionGUID: s6jswCxJTp2Rzc3sGypSlw==
X-CSE-MsgGUID: X13gBac9T7Wvo7QSA9uo1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="28616464"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 07 May 2024 21:18:19 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] scripts/simpletrace: Mark output with unstable timestamp as
 WARN
Date: Wed,  8 May 2024 12:32:29 +0800
Message-Id: <20240508043229.3433128-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In some trace log, there're unstable timestamp breaking temporal
ordering of trace records. For example:

kvm_run_exit -0.015 pid=3289596 cpu_index=0x0 reason=0x6
kvm_vm_ioctl -0.020 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
kvm_vm_ioctl -0.021 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60

Negative delta intervals tend to get drowned in the massive trace logs,
and an unstable timestamp can corrupt the calculation of intervals
between two events adjacent to it.

Therefore, mark the outputs with unstable timestamps as WARN like:

WARN: skip unstable timestamp: kvm_run_exit cur(8497404907761146)-pre(8497404907761161) pid=3289596 cpu_index=0x0 reason=0x6
WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908603653)-pre(8497404908603673) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908625787)-pre(8497404908625808) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60

This would help to identify unusual events.

And skip them without updating Formatter2.last_timestamp_ns to avoid
time back.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/simpletrace.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index cef81b0707f0..23911dddb8a6 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -343,6 +343,17 @@ def __init__(self):
         def catchall(self, *rec_args, event, timestamp_ns, pid, event_id):
             if self.last_timestamp_ns is None:
                 self.last_timestamp_ns = timestamp_ns
+
+            if timestamp_ns < self.last_timestamp_ns:
+                fields = [
+                    f'{name}={r}' if is_string(type) else f'{name}=0x{r:x}'
+                    for r, (type, name) in zip(rec_args, event.args)
+                ]
+                print(f'WARN: skip unstable timestamp: {event.name} '
+                      f'cur({timestamp_ns})-pre({self.last_timestamp_ns}) {pid=} ' +
+                      f' '.join(fields))
+                return
+
             delta_ns = timestamp_ns - self.last_timestamp_ns
             self.last_timestamp_ns = timestamp_ns
 
-- 
2.34.1


