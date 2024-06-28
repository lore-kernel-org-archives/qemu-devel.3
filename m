Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227F4C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5gr-00034t-F7; Fri, 28 Jun 2024 03:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5go-0002eF-Fa
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gm-0003Gi-Q3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-421f4d1c057so2197715e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558391; x=1720163191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kx/xpSwqNNbWf+vNm/3cxS62PiRf/NP5lc+BI6XCrgc=;
 b=WV3Ee0wY06oNpxu2snE2EnIB/aF71IOeiY3Uft5UldoNW4c4inGsoz+n5H9FQ1Vmdr
 JWkoc9QA/Kh+UL4Jx3J40fDVNZfhQCYRfc9ELxhiNXOb8eXJqzJmQScqbG/4Kt7DP18z
 T1P7Qx4BW3gMIosqN4u0GNQUP2gHJNYWjemALyMKEQtwmICNK8g7kodOQ3kCAb0pWaVY
 rqfKL+fJtIyzQOFN9Z8jwp037KIY/SHkd7GH/16dwLdTY7fsRVUHr2tMWkbbA1DxoUAR
 waQ71rzSVizn18zEa/hD6WA+3iT/DU4PQDbZxt85IPXU0b/54zMl97R7dBmvOMQtmRx5
 A6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558391; x=1720163191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kx/xpSwqNNbWf+vNm/3cxS62PiRf/NP5lc+BI6XCrgc=;
 b=QriRraooiyCqkImxVQvxJLKcIH1H/0bUVlUS3MKRODzRdTGxKa8d7lyMF7YotQwFhM
 I5NNpExXlJX4RVCFlIUmCmHbG5W4sprZDKsh+UCCVY1Tg2t43mduQUVeikgWVeaqZMxM
 Xh/BFuPf2RDE9I3ZOrpGPs71dXvReZyQsO0YHheJU+Hie9QranBY0DRdUkrt/WXUSq6n
 esC3DmIuLtaXFFEaA9Hg+9S/vZIjlT8myq7RRXUB5T5G3ufjAkHPADt3IijwrS6bno1c
 rE4S1+NunHC/4CnDzcgtP4nA6D1FVBVgbqMJHKFHP/kDtTQWSYqZGrpcQfgcBLSqbJAZ
 WjTg==
X-Gm-Message-State: AOJu0Yy+aQgkfbKwhJUcyrqDcZZdDX4eQnwIPjyZBBqh4I+RRHd3VLhW
 4fSdrfB7vqQZzOpCicu1i3qzUsQg8VcWjQSax50ur8DTm1fpLtGpjD2Pb6SFHTuO9RpnZ3MZ06n
 COqc=
X-Google-Smtp-Source: AGHT+IHld6UYOWtlkYr9ak8roMxCXQLnff9ME0tkRFAAhR6wCnAmwIf2RX+NdIqujIqI7wJPe3pl7Q==
X-Received: by 2002:a05:600c:4889:b0:425:5a26:a12c with SMTP id
 5b1f17b1804b1-42564510fffmr26456725e9.13.1719558391212; 
 Fri, 28 Jun 2024 00:06:31 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103e5esm1325302f8f.108.2024.06.28.00.06.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 43/98] hw/sd/sdcard: Register generic optional handlers
 (CMD11 and CMD20)
Date: Fri, 28 Jun 2024 09:01:19 +0200
Message-ID: <20240628070216.92609-44-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 097cb0f2e2..74aa38a442 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -243,12 +243,12 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                              [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
-        [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
+        [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
-        [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
+                                            [21]    = "DPS_spec",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
@@ -1161,6 +1161,14 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+static sd_rsp_type_t sd_cmd_optional(SDState *sd, SDRequest req)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: Optional CMD%i not implemented\n",
+                  sd->proto->name, req.cmd);
+
+    return sd_illegal;
+}
+
 /* Configure fields for following sd_generic_write_byte() calls */
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
@@ -2279,7 +2287,9 @@ static const SDProto sd_proto_sd = {
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
+        [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
+        [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
     },
 };
-- 
2.41.0


