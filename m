Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4E0C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5ep-0002ix-3l; Fri, 28 Jun 2024 03:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5el-0002BD-LN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:27 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ej-0006oh-Lj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:27 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52cdf579dd2so266624e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558263; x=1720163063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/dkdp8a0v1eDrwEVEV8e/ROv9nmNjtoGPC9rjoBe3Zg=;
 b=mJLjo3cQ2EIa8sWyLFnEbyAbd5JwkzS+E3vW0fvop9ZHV8zELsai+3nRygEXitMBLt
 oykR7EiNVlyGLHHNB14LCGs3nW+FvNMXnBXLctMZH3NmKMOCnH6y/2rP/chHJG5VSH9K
 DYUaikNrj/ji9NtZ2YrGO40jG2PxckdW1h2LJ1QTNfXoQ7eIiAjTnPBxmiz/7Sg2i4SV
 fjwvs61CFx5V0CYi29IJj7UO+hhWRkKl3JIeTbARK2E8nVAwL2t+vMgnX7YwGDGuLNnB
 cv0HH9DZRcrIQfBnEQMdwaolSdkjE00x2Zl4AbX+XgGxxUUNwSuEkAxPK16teVY4GCad
 JBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558263; x=1720163063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/dkdp8a0v1eDrwEVEV8e/ROv9nmNjtoGPC9rjoBe3Zg=;
 b=UGH8nl9Ha8RHfxRWL2NKymBlXKkYveRD1Z3fOP5zNqqFpqg7ul+dgWBbj/fSOv2iRm
 YotGhE9aCg+TrnoCBg6kY/aN6tx1hoN3y2lL8lSKOoSQkwPjKgHMJARopLThMJoyYZmn
 M3/B2hEMdnBBDslpVDOsaxslppUyY2A7isxQDNAJ7o34M0b99VPYTG9y3UwwV/yZ5t0G
 5+acVt8KimCapB+EvQWJSszSIhORejxK+KQzXV1WhKgflqVXRyMBhS0dKE/64Z5QyqaM
 G14JA1CtO1VLN69seDW9Q5CxAeA8xM9tWDB2CSitThFvALGDTG/nwr9joNEQKO/sqcJg
 iaVQ==
X-Gm-Message-State: AOJu0Yy1blZTH8Hy5ULBrf3BeDqFblp+PmcN494ge3Mn9G3Hfi16TskV
 nlAuOZeiScfppJquaW2k4W2EHdbl9bVI648ToSRNUqDV5bZEBcQIhTwt8XahwQhmW+3XAMvcykd
 n6ZU=
X-Google-Smtp-Source: AGHT+IExuK1NYkhJEsNLssT96RQvRK25Yb3Y2yTgqfAGeVZa4tV3KwqU2spnEws4sOTLNawRVWSFJQ==
X-Received: by 2002:ac2:5dcd:0:b0:52c:9824:2780 with SMTP id
 2adb3069b0e04-52cdf82618dmr10265867e87.64.1719558263542; 
 Fri, 28 Jun 2024 00:04:23 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256f55c4b5sm5365505e9.43.2024.06.28.00.04.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:04:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 18/98] hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and
 sd_generic_read_byte
Date: Fri, 28 Jun 2024 09:00:54 +0200
Message-ID: <20240628070216.92609-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

All commands switching from TRANSFER state to (sending)DATA
do the same: send stream of data on the DAT lines. Instead
of duplicating the same code many times, introduce 2 helpers:
- sd_cmd_to_sendingdata() on the I/O line setup the data to
  be transferred,
- sd_generic_read_byte() on the DAT lines to fetch the data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d85b2906f4..1a8d06804d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -142,8 +142,10 @@ struct SDState {
      */
     bool expecting_acmd;
     uint32_t blk_written;
+
     uint64_t data_start;
     uint32_t data_offset;
+    size_t data_size;
     uint8_t data[512];
     uint8_t vendor_data[512];
 
@@ -1083,6 +1085,29 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+/* Configure fields for following sd_generic_read_byte() calls */
+__attribute__((unused))
+static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
+                                           uint64_t start,
+                                           const void *data, size_t size)
+{
+    if (sd->state != sd_transfer_state) {
+        sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd->state = sd_sendingdata_state;
+    sd->data_start = start;
+    sd->data_offset = 0;
+    if (data) {
+        assert(size);
+        memcpy(sd->data, data, size);
+    }
+    if (size) {
+        sd->data_size = size;
+    }
+    return sd_r1;
+}
+
 /* CMD0 */
 static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
 {
@@ -1920,6 +1945,20 @@ send_response:
     return rsplen;
 }
 
+/* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
+__attribute__((unused))
+static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
+{
+    *value = sd->data[sd->data_offset];
+
+    if (++sd->data_offset >= sd->data_size) {
+        sd->state = sd_transfer_state;
+        return true;
+    }
+
+    return false;
+}
+
 void sd_write_byte(SDState *sd, uint8_t value)
 {
     int i;
-- 
2.41.0


