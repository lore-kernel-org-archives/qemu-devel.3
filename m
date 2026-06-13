Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1235CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUep-0006Vi-UN; Sat, 13 Jun 2026 16:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUdm-0003oG-O3; Sat, 13 Jun 2026 16:07:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUdl-0001qP-0K; Sat, 13 Jun 2026 16:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381069; bh=fDOrCK2N6Pl6NIhKkdpC1+NkBaVzNlosKwWDNcpyHwA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JuWNck3W6v8Kqc+2cTdH8KQfYG4ggmEmOqV2Odrmg5ITXynBhua8J9qM3p5V5hxcL
 Z8Yt8wjgOBIVcCXutZBPiQwmOfKBeWgBZwiDxk+JGkY4QOGLix3r2LkoyM6eec4kVw
 jgzAxmYREI+y8Kx2nRt//hO4a2ZzmMxUx9lQFurF7dmH/5NEG2Dj5tUIslTUdq+lR4
 U++b99+826p/9W/8F1MUHTgYnU3U2nmzXWJIZU0zQC9ibZeZQ5xvCwWPh/LlIvYrK7
 8Clf5QUlkGt4GDNURJMrUZe7CzZrVWm0MA+2g2qCOM/2g323aQK6Egtb7khF5pLAF3
 9+/D1K4Jl+C4A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1C79B1B6E89;
 Sat, 13 Jun 2026 23:04:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7A41D3CE8EB;
 Sat, 13 Jun 2026 23:04:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 33/61] hw/net/rocker_of_dpa: Check group ID pointers
 are not NULL
Date: Sat, 13 Jun 2026 23:03:16 +0300
Message-ID: <20260613200411.1808021-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In of_dpa_cmd_add_l2_flood(), we use rocker_tlv_parse_nested()
to fill in a tlvs[] array. If the guest command is valid then
the entries should be pointers to TLV data items with group IDs.
However, if the guest gives us bogus data then rocker_tlv_parse_nested()
indicates this by leaving the tlvs[] entries NULL. In the other
places that use this function, we check for this before using
the value, but here we forgot, and the result is that QEMU can
crash:

#0  __memcpy_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:331
#1  0x00005555574f7137 in __asan_memcpy ()
#2  0x0000555558106792 in ldl_he_p (ptr=0x8) at /home/pm215/qemu/include/qemu/bswap.h:278
#3  0x0000555558106755 in ldl_le_p (ptr=0x8) at /home/pm215/qemu/include/qemu/bswap.h:311
#4  0x00005555580f85ed in rocker_tlv_get_le32 (tlv=0x0) at ../../hw/net/rocker/rocker_tlv.h:114
#5  0x000055555810a8ad in of_dpa_cmd_add_l2_flood (of_dpa=0x506000082e38, group=0x503000b4e440, group_tlvs=0x7fff68702c20)
    at ../../hw/net/rocker/rocker_of_dpa.c:2032
#6  0x0000555558108a74 in of_dpa_cmd_group_do (of_dpa=0x506000082e38, group_id=1073741824, group=0x503000b4e440, group_tlvs=0x7fff68702c20)
    at ../../hw/net/rocker/rocker_of_dpa.c:2115
#7  0x0000555558108730 in of_dpa_cmd_group_add (of_dpa=0x506000082e38, group_id=1073741824, group_tlvs=0x7fff68702c20)
    at ../../hw/net/rocker/rocker_of_dpa.c:2135
#8  0x00005555580f66ec in of_dpa_group_cmd
    (of_dpa=0x506000082e38, info=0x514000072e40, buf=0x5070002356c0 "\001", cmd=7, group_tlvs=0x7fff68702c20)
    at ../../hw/net/rocker/rocker_of_dpa.c:2194

Check for NULL values and return an error.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1851
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 8526b7d6b67beda0c83e4a8aec1449475fe5dd65)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 262ceb35f6..005a29e6c1 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -2024,6 +2024,10 @@ static int of_dpa_cmd_add_l2_flood(OfDpa *of_dpa, OfDpaGroup *group,
                             group_tlvs[ROCKER_TLV_OF_DPA_GROUP_IDS]);
 
     for (i = 0; i < group->l2_flood.group_count; i++) {
+        if (!tlvs[i + 1]) {
+            err = -ROCKER_EINVAL;
+            goto err_out;
+        }
         group->l2_flood.group_ids[i] = rocker_tlv_get_le32(tlvs[i + 1]);
     }
 
-- 
2.47.3


