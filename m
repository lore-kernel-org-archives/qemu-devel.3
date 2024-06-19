Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893E0C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 07:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJq1E-0006ff-D2; Wed, 19 Jun 2024 03:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1sJq17-0006ey-Uz
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 03:46:07 -0400
Received: from smtpnm6-07.21cn.com ([182.42.151.156] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1sJq15-0004qU-7x
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 03:46:05 -0400
HMM_SOURCE_IP: 192.168.137.232:0.2145086880
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.137.232])
 by chinatelecom.cn (HERMES) with SMTP id 341809C184C;
 Wed, 19 Jun 2024 15:38:11 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-67bdc54df-b7md5 with ESMTP id
 82988acf0f364c8aa11b097a9ab8c1ce for elena.ufimtseva@oracle.com; 
 Wed, 19 Jun 2024 15:38:15 CST
X-Transaction-ID: 82988acf0f364c8aa11b097a9ab8c1ce
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Message-ID: <4485ad60-45b9-4499-8f89-830c6e67decb@chinatelecom.cn>
Date: Wed, 19 Jun 2024 15:38:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, qemu-devel@nongnu.org
Content-Language: en-US
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
From: Guoyi Tu <tugy@chinatelecom.cn>
Subject: [PATCH] docs: Fix title format errors in the multi-process.rst
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=182.42.151.156; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
---
  docs/devel/multi-process.rst | 8 ++++++--
  1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/docs/devel/multi-process.rst b/docs/devel/multi-process.rst
index 4ef539c0b0..223f878139 100644
--- a/docs/devel/multi-process.rst
+++ b/docs/devel/multi-process.rst
@@ -185,7 +185,9 @@ Another difference is that in the vhost user model, 
a single daemon can
  support multiple QEMU instances. This is contrary to the security regime
  desired, in which the emulation application should only be allowed to
  access the files or devices the VM it's running on behalf of can access.
-#### qemu-io model
+
+qemu-io model
+'''''''''''''

  ``qemu-io`` is a test harness used to test changes to the QEMU block 
backend
  object code (e.g., the code that implements disk images for disk driver
@@ -587,7 +589,9 @@ described below attempt to ameliorate this effect by 
allowing the
  emulation process to communicate directly with the kernel KVM driver.
  The KVM file descriptors created would be passed to the emulation process
  via initialization messages, much like the guest memory table is done.
-#### MMIO acceleration
+
+MMIO acceleration
+^^^^^^^^^^^^^^^^^

  Vhost user applications can receive guest virtio driver stores directly
  from KVM. The issue with the eventfd mechanism used by vhost user is
-- 
2.17.1


-- 
Guoyi

