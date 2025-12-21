Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BBCE66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 06:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXCvb-0003r5-7t; Sun, 21 Dec 2025 01:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vXCvX-0003qo-6X
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 01:28:23 -0500
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vXCvU-0000bU-W2
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 01:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Mi
 oDPCbOUNRhBZrsBihTau5yza+HqvX7L3FNZI1Tnw0=; b=GSPsUge9sIrwYYbV8b
 xefR0ZuIARYRuSSWWOMZQp0ZM0Qlt7UUERrvVra2K5noAQW44VuQSHaFYLarfdpV
 nUWkYSMzo057QEHhCG+vTBhXm0Lb2w16BrIsOECjDXWpICcJYj4NN+3IQgMIP2pb
 EY8YpCeTVhAILaM3yEW+uygWI=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wAnZxJXk0dp_jcXBg--.4436S2; 
 Sun, 21 Dec 2025 14:27:37 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: cminyard@mvista.com, peter.maydell@linaro.org,
 strahinjapjankovic@gmail.com, Alano Song <AlanoSong@163.com>
Subject: [PATCH] hw/i2c/allwinner: Add missing state data
Date: Sun, 21 Dec 2025 14:27:34 +0800
Message-ID: <20251221062734.100559-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnZxJXk0dp_jcXBg--.4436S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW8uw1UWry5WF4fWF4UArb_yoW3WFg_uw
 n5Cw18Wr95K3WagF4rZa48ur4Ivw18Krn7Ja1xJF4xCr1kG3s8G39rKFZ5WayxXrs5KFnr
 C34UuFyYgr9rKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRd-BCPUUUUU==
X-Originating-IP: [240e:36a:140a:ca00:8783:3fbb:4dfd:5dd0]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9hknO2lHk1nzEwAA33
Received-SPF: pass client-ip=220.197.31.2; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hw/i2c/allwinner-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i2c/allwinner-i2c.c b/hw/i2c/allwinner-i2c.c
index fe887e1c6a..728b7e622f 100644
--- a/hw/i2c/allwinner-i2c.c
+++ b/hw/i2c/allwinner-i2c.c
@@ -419,10 +419,12 @@ static const VMStateDescription allwinner_i2c_vmstate = {
         VMSTATE_UINT8(xaddr, AWI2CState),
         VMSTATE_UINT8(data, AWI2CState),
         VMSTATE_UINT8(cntr, AWI2CState),
+        VMSTATE_UINT8(stat, AWI2CState),
         VMSTATE_UINT8(ccr, AWI2CState),
         VMSTATE_UINT8(srst, AWI2CState),
         VMSTATE_UINT8(efr, AWI2CState),
         VMSTATE_UINT8(lcr, AWI2CState),
+        VMSTATE_BOOL(irq_clear_inverted, AWI2CState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.43.0


