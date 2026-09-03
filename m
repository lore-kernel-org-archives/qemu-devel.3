Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5347C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24se-0006Ga-F3; Thu, 03 Sep 2026 06:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sP-0005nh-N2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sN-0006Yf-NV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHE1v327174
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4+tQhWxttEbmnMB8F0bWj+Xxz+Cc9Lzqzfqz7/+hjpg=; b=hBkOXqCWQiyqwBPS
 e/kRXIDQyYrmb4O3Cl4KjOsW643L1ynxhdWqUSTyV3ZLYeOOoMBiiO9+RPTIfKMb
 nZOyr6Itb01EAmNC4cj3pOyxuTgk43OHkJ22ko47geL2XrPVancpfwHs25JUAGyI
 Hs4/Qu4HBerPG34A9IS9drQz42Qgv0pOJRFLhPuaq7wtVXNgG0IuwetFGCiyrf+X
 Ew3DoJxAevPuPrZ2mj8JuD/kGnl/o257aU6vmW5YbvYiJm4dWvPQBlDL+KOnB9Dy
 Y9WJL+XF/afTdBxdJBFqjvilQWV4hLQ12BCQcC76GO6Yxg1ilZuNVZxhelCK+T3+
 /72yvQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekgtg7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:40:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-933023a5980so487750585a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432058; x=1789036858; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4+tQhWxttEbmnMB8F0bWj+Xxz+Cc9Lzqzfqz7/+hjpg=;
 b=VDxdJwG6o+JPWU3yrElVbdsx9c+ZJA23jpFKE2uyR2MJDEqc2W+TDs9+uYt82btxYB
 K3D5VSTWMheybkx8cVYLnC3hajmK9APkxm+c2A64YrHAH5xjVhbRFBrO617dWSUMUzYJ
 4c3kkgppU1X/DtpfgF1hMffc1othct4qPgReBBCxVNfw3xrR0QjlOoljP9hse+yNYAT+
 1mY0V9SoZXA/VwLV2GhQxI0EWhKJdSi81MAUvKO+tZIKWp//dOIKkKY3hJ8iAD54r5S2
 iMUIzpXC22txFOfqmktuKW1Hiw4eG/R8x2C0oBFV9H2tkQGFIyccHABNSOKgXXUsgyhl
 AxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432058; x=1789036858;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4+tQhWxttEbmnMB8F0bWj+Xxz+Cc9Lzqzfqz7/+hjpg=;
 b=paffH931gr7MB/0Vpm/mWNou39Dm3K1N0QIiUS4HdlWN30QE6R7XVF10Gpr99NLjET
 ThzDZ+HAXKsZzNPnmGqrT0uY9JtBd4pGs02B/eYPKqvC/OWpXAGgefO2r5VSqkToJvKl
 XgOFb7uNd4S3fw3J9MTYgi4I9KjV+KndGfCBG0hd1Tev7RcGiDD49wY75pPmQZkL3bMl
 ENld45qvtQOcxYsMEiPzdPrLfyyumqaIzcCKOr7exDoJnRCAAbhg72cBgKivNF6My1c7
 3Yq096oWEXUgKBQk2/WhO1sEKZRIHPMDmUyM8gErjZi6MyajYyW9wqpqX/7xGzzEwJE/
 lX9g==
X-Gm-Message-State: AFuF++k8rAPt6SAnQDdb+JyS/YYhWN+LmFnr9mfla3mmVnK6pC0Pi/7g
 6YM+JBnu4Irthsno8H8ikDF2ExJ8qO/5JpkxYOXNSPVSLq2MEHmGbWvog3unh9UDLeubXQ4e0Xz
 MjOILGS7Q9cBFBmYnf1j5Kg8cA4tLNi4eyLuS6MUXMGhzGHY2LynPYGIjke/NZRZ6TA==
X-Gm-Gg: AYBFou2CEpnt31sbgxRpbrIFLhAwstL5WD6BQv1Y2tizwbGmyLZ4V9rFLyX5Eg2nwdJ
 n2l2WHd7x5SrsMrIbDXFt9E7t40mLcMf+dHf90LC8u/xfMCVVJxw/6APDwG4fbww5+S1hv/Vgba
 idDYMUgOTHX0ZfVsepRHWP4TzmBbrZwNadbuiL0k72HuqlGYmyp4gdzPoMAgDh/DLnKqUKf4OQb
 G72+DNgP7aa279k8f1Z3Bpjgvm65CAk8ZFV8RJpCYXEH2hIkbQayyDl3VPp6v2jcqAA+BOUfo4s
 ryR/tjqZhoOmwc+zonmzU6DKduEBrg77IxZmM5+aSDg47/2ySmfAwbPa1+VnkJFYlbANe9jG3PI
 OCpIt8AFYJbc+qzg15D/vdChH4HkqdST8YzOgcZBV
X-Received: by 2002:a05:620a:d8c:b0:92e:ef09:f8f3 with SMTP id
 af79cd13be357-93960c91ccemr1287826385a.2.1788432058100; 
 Thu, 03 Sep 2026 03:40:58 -0700 (PDT)
X-Received: by 2002:a05:620a:d8c:b0:92e:ef09:f8f3 with SMTP id
 af79cd13be357-93960c91ccemr1287821685a.2.1788432057578; 
 Thu, 03 Sep 2026 03:40:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e7315bsm13149315f8f.7.2026.09.03.03.40.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:40:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/51] hw/sd/sdcard: Register device ops in drives without media
Date: Thu,  3 Sep 2026 12:38:55 +0200
Message-ID: <20260903103936.62355-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZX7yiwFUeo83m9sr5GnjDButvU-UKB87
X-Proofpoint-GUID: ZX7yiwFUeo83m9sr5GnjDButvU-UKB87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX4RJNmFQ586DS
 tNoG+RPC8hOhcedvrasQc8YYkdBgk8e12XWnLYQHaufMYxolkyrSS7xRMDrO1D8063zOklSlzvZ
 K6R738cSePt6XXAyLQX50qzZmZ5Q8RaOARsyaKqwmKdSZyv97TSgbeNKNGxncKDFI6VWmha90vf
 73BopIkN5+H8bi1cjICKpQIUpLiKvbVADotyOYok6luYW9w+gv3k2Jgbsy5DFBpVY1Hdlqv2Fgh
 PViGnJV4qcCgkX9H+GjuOrAmXYtdwndh4AAuENZ3oH0bz81VLRDVf3w9H5mfsV/taCSmDO83a8u
 lRcOQII3zWOjfvZ+L0MsU+Jw9Ghuyinl1hq0YiyBr38S8k+zoJqKBQY0EHE1bPPXRWqfkt5L+/j
 Uzbp1PKvtOJV94c7LiIHUxvjM13hY2LCtw1xNqVW7AHhTUKo9k0z71g3qJ3rN1VNMUsCIxM+zrQ
 PXk9X1fBbXB79DWOLUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX1Q4sLM31vRCB
 0CDUkMXjiF9Lphx0cKkINdPt1eAo+TmTw0/TjaXNE7pW9t9vBI1szzoSX7hQeotir9rGc16bjCz
 I2jyj/gZbl2cdeerS0PTC7e5Hgkwgjs=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a994eba cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=V2sgnzSHAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=WMtZ8JWQ2dOPEG_3IIAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Z31ocT7rh6aUJxSkT1EX:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Alberto Garcia <berto@igalia.com>

Commit a362b19a39 ("hw/sd/sdcard: Fix size check for backing block
image") accidentally moved the blk_set_dev_ops() call into the new
'if (blk_size >= 0)' block in sd_realize().

Because of that, if a drive is attached without a medium then the
condition is false (blk_size == -ENOMEDIUM) and blk_set_dev_ops() is
never called, so the drive is registered as having non-removable
media:

  $QEMU -device sd-card,drive=sdcard0 -drive if=none,id=sdcard0
  (qemu) change sdcard0 sd-card.qcow2
  Error: Device 'sdcard0' is not removable

This patch moves the blk_set_perm() and blk_set_dev_ops() calls
outside of the 'if (blk_size >= 0)' block so the device ops and
permissions are registered when a drive is attached.

Cc: qemu-stable@nongnu.org
Fixes: a362b19a39 ("hw/sd/sdcard: Fix size check for backing block image")
Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260723205847.137001-1-berto@igalia.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 674ca09b49f..b1b3b1226a7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -3100,7 +3100,6 @@ static void sd_blk_size_error(SDState *sd, int64_t blk_size,
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SDMMC_COMMON(dev);
-    int64_t blk_size = -ENOMEDIUM;
     int ret;
 
     switch (sd->spec_version) {
@@ -3118,32 +3117,32 @@ static void sd_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        blk_size = blk_getlength(sd->blk);
-    }
-    if (blk_size >= 0) {
-        blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
-        if (blk_size > SDSC_MAX_CAPACITY) {
-            if (sd_is_emmc(sd) &&
-                !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)) {
-                int64_t blk_size_aligned =
-                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
-                sd_blk_size_error(sd, blk_size, blk_size_aligned,
-                                  "multiples of 512", errp);
+        int64_t blk_size = blk_getlength(sd->blk);
+        if (blk_size >= 0) {
+            blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
+            if (blk_size > SDSC_MAX_CAPACITY) {
+                if (sd_is_emmc(sd) &&
+                    !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)) {
+                    int64_t blk_size_aligned =
+                        ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
+                    sd_blk_size_error(sd, blk_size, blk_size_aligned,
+                                      "multiples of 512", errp);
+                    return;
+                } else if (!sd_is_emmc(sd) &&
+                    !QEMU_IS_ALIGNED(blk_size, 512 * KiB)) {
+                    int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
+                    sd_blk_size_error(sd, blk_size, blk_size_aligned,
+                                      "multiples of 512K", errp);
+                    return;
+                }
+            } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
+                sd_blk_size_error(sd, blk_size, pow2ceil(blk_size),
+                                  "a power of 2", errp);
                 return;
-            } else if (!sd_is_emmc(sd) &&
-                !QEMU_IS_ALIGNED(blk_size, 512 * KiB)) {
-                int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
-                sd_blk_size_error(sd, blk_size, blk_size_aligned,
-                                  "multiples of 512K", errp);
+            } else if (blk_size < 0) {
+                error_setg(errp, "eMMC image smaller than boot partitions");
                 return;
             }
-        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
-            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a power of 2",
-                              errp);
-            return;
-        } else if (blk_size < 0) {
-            error_setg(errp, "eMMC image smaller than boot partitions");
-            return;
         }
 
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
-- 
2.53.0


