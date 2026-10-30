Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BBA606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V1QdWjNq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhlV-0006F6-Io; Fri, 30 Oct 2026 04:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlO-00069v-V7
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:05 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlM-0001Mb-VD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:02 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-18cdcfc05ffso548837c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348099; x=1793952899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1G58KDvPaxDf1pbDbbJqX1WIkHSLAs8rb9t3XK2KfZY=;
 b=V1QdWjNq2DIszNRvb4uD+SkbCjIDTJBuU64KZyYO8hkabH6X8ZIV1wDdZvtFhkjW2u
 8tMez2wIqVIfXFxMUTQKqRv+EmHKl5q2yLt7HKx5RCbpzUms8KCZjTO+GjVr+jEZFaV5
 Oz51hrXqnAWWSx9JDLjn+pDBhhVVg0H3GX44zJxMrsBq3CD0KWAIhrmj5uG4Oo5b9zDI
 no773pzso6v0nsQfHP0x3xCKEoLYvMzy9L1pt9fWpq9xgUlVVBHmffrdE0QNXSH29Vas
 lCL8QhYbbCJbhyio5mSVsA3y/D8MpBQrlhYJVyJE9BApvL+iGxf+8BHF2UAQnIY++oNZ
 HxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348099; x=1793952899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1G58KDvPaxDf1pbDbbJqX1WIkHSLAs8rb9t3XK2KfZY=;
 b=1RQRsbmD+4gUQb2nLu9MUpfX+klX+Ml/MLTlGBqOGOf7xb9CZJN4lokgKGuFCQnjfB
 Mr/zMxUNauBUlunsKbutgGTcHyPkwFuODSRN9Oc2V4M5qdr2V9Cx0iyZXIvOTZLFbTt1
 dAufuLYwBocuGhIur/S6dwnJuDSQ2Ue0dnXju3MHipcVDhsHNkXNAVhJMbu3PCwfa6uv
 IoT9i2dxQOynZgmKbbSefKYz+Ne6PCZ8AKH+NLQWZjgABT9omWK2vi1ptwJb/C1fMQO5
 JBAwVHBMHcAx7TlulK8kTa5ZNPRdvZXlUnEvM5sOjVup0YXK0AAwPwvLEl9vMvDzQtk9
 /9WQ==
X-Gm-Message-State: AFq9FYLkKUF/Lko1KlYbzrMaEkqyW0/WhifOKlmTFhxiUFHNNNjvWrUo
 LUOq7sAtPAfNlZhZsKViHsRyqL5tnZwtvhgAt8jgy4iXcodC7Y0CjDvO/lgW9w==
X-Gm-Gg: AYBFou0Uyn4iNBNGBUBbUKTfIyfaKCK/1CkemX+TrH0bSf6QcM1xgQauLuBwk11tFrI
 ak7xTT3oiOiOfGjR03Cr4eoJiouUMZsu94Q5bbhd+ezv97FXuUwMtIbRMEkDrtj2La2UMIF63nE
 jkm1S2kAABNFAVZs/8nbHn8vQs4SDS2IB4GwLHXXgOvLlcINMEezcyx3vrGxpVop7aZfIZenK99
 tjLsCornhyEgvntyGpAtLzIlNUVH9nhM0lalWD5Xp6AZDZRywrBTJiCgBBLDTWkIGGQwVNKUFLx
 l2fR5tNsOcF7khW/C0D6UtORbD/UNtL9KqRutd9skEEL5Dw+E5qHo4eftOoll4nwg+YtoWFowvM
 JaAOI4qBnuOlyhjHU3TL/D4XroNIPax4lEmVFbJPWBgvnOafkv6HltaPUITqiHERT3Q4GZEzgjn
 Vp5XihsbPLLDXyFHreTm8fcUz/qyzpD6ac31KTn/VhlRmNQ7t0o3HGpRT1ZA/I4k+jrio6nqbUN
 HxCenm9153fSM5NOyHvoP3cT03UF93v6NDPPHBF7ejzT+pMuSygomGn5HBFDfv8dIxEC4PfrpCS
 BgplENb/Wecrf2i3hcyJnbCXyzeB0DD6Wd15IFwxD1u6IYZ3oHXOKiSju5/Oo921Cg==
X-Received: by 2002:a05:7022:5f0b:b0:168:3243:c91a with SMTP id
 a92af1059eb24-1ac5bbb966fmr2250904c88.13.1793348099282; 
 Fri, 30 Oct 2026 01:14:59 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:14:58 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 01/12] hw/ufs: Add support for REPORT_LUNS SCSI command for
 Well Known LUNs
Date: Fri, 30 Oct 2026 17:14:27 +0900
Message-ID: <397086dd554e75fca27ac7b9ff9b5c51818fdf62.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: dridiha <dridiha98@gmail.com>

According to the UFS specification, the REPORT_LUNS SCSI command can query
Well Known LUNs by setting CDB[2] to 0x01 (select Well Known LUNs) or 0x02
(select all LUNs).

Currently, the UFS emulation layer lacks handling for these CDB[2] select
report values, causing command failures when guests attempt to report Well
Known LUNs.

This patch adds support for handling CDB[2] values 0x01 and 0x02 in the
REPORT_LUNS command, returning the appropriate Well Known LUN descriptors
in the SCSI response payload.

Signed-off-by: Hamza Dridi <dridiha98@gmail.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c         | 44 ++++++++++++++++++++++++++++++++++----------
 include/block/ufs.h |  3 +++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 5905c49fac9..ee4bb75361c 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -218,33 +218,57 @@ static const struct SCSIBusInfo ufs_scsi_info = {
     .cancel = ufs_scsi_command_cancelled,
 };
 
+static bool ufs_append_lun(uint8_t *outbuf, uint32_t outbuf_len, int *len,
+                           uint8_t lun, uint8_t lun_msb)
+{
+    if (*len + 8 > outbuf_len) {
+        return false;
+    }
+
+    memset(outbuf + *len, 0, 8);
+    outbuf[*len] = lun_msb;
+    outbuf[*len + 1] = lun;
+    *len += 8;
+
+    return true;
+}
+
 static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
                                    uint32_t outbuf_len)
 {
     UfsHc *u = req->hc;
     int len = 0;
 
-    /* TODO: Support for cases where SELECT REPORT is 1 and 2 */
-    if (req->req_upiu.sc.cdb[2] != 0) {
+    uint8_t report_lun_cmd = req->req_upiu.sc.cdb[2];
+
+    if (report_lun_cmd > 2) {
         return SCSI_COMMAND_FAIL;
     }
 
     if (outbuf_len < 8) {
         return SCSI_COMMAND_FAIL;
     }
+
     memset(outbuf, 0, 8);
     len += 8;
 
-    for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
-        if (u->lus[lun]) {
-            if (len + 8 > outbuf_len) {
+    if (report_lun_cmd == 2 || report_lun_cmd == 1) {
+        ufs_append_lun(outbuf, outbuf_len, &len, u->report_wlu.lun & 0x7F,
+                       UFS_WLUN_MSB);
+        ufs_append_lun(outbuf, outbuf_len, &len, u->dev_wlu.lun & 0x7F,
+                       UFS_WLUN_MSB);
+        ufs_append_lun(outbuf, outbuf_len, &len, u->boot_wlu.lun & 0x7F,
+                       UFS_WLUN_MSB);
+        ufs_append_lun(outbuf, outbuf_len, &len, u->rpmb_wlu.lun & 0x7F,
+                       UFS_WLUN_MSB);
+    }
+
+    if (report_lun_cmd == 0 || report_lun_cmd == 2) {
+        for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
+            if (u->lus[lun] &&
+                !ufs_append_lun(outbuf, outbuf_len, &len, lun, 0)) {
                 break;
             }
-
-            memset(outbuf + len, 0, 8);
-            outbuf[len] = 0;
-            outbuf[len + 1] = lun;
-            len += 8;
         }
     }
 
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 4a614fbe526..f4a3371bcea 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -835,6 +835,9 @@ typedef struct QEMU_PACKED UtpTaskReqDesc {
  */
 #define UFS_EHS_OFFSET_IN_RESPONSE 32
 
+/* Most significant byte in the Report Lun response for Well Known LU */
+#define UFS_WLUN_MSB 0xC1
+
 /* Well known logical unit id in LUN field of UPIU */
 enum {
     UFS_UPIU_REPORT_LUNS_WLUN = 0x81,
-- 
2.43.0


