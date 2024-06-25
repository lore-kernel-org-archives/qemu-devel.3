Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6F2C30659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzOI-0000Ci-3Q; Tue, 25 Jun 2024 02:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOB-0008GJ-Ab
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzO9-0005dC-MA
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:47 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42189d3c7efso56282325e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295844; x=1719900644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uU8msdfI4FBbYYSxzgmdaaqhmtNKe2zgeh42ZfcMs0o=;
 b=GatTWml4m5ZLmjyEyDSV3UPo5zFfadDGOTt9lhrPn3dwsvp1KY6FEufVnpR/xdMEfD
 vCIZK9HK8wp0c2pSoI1aH10HMVrmdAExL2qdIpPGRjyac8VvP/PfMqgHo7+c9ORncXtk
 MErqLwCLA6GZD+bRgBbAGwYOp8TvZvPn+oa0u+h3N8CCkeLNsva2AWrdN46zRPogbc6e
 rOLsni7FNVJ3YdJbVdMncakhQYIITYDCRUT8rTNsi0NpKWLkbruJjNLKNlZaYSwusWRX
 LOtOypQeWVDnrPZMaobS793lEBjgII6OWGo7otiB7Y9n1+r7bojdJWBmpdPz/b8AdRJe
 SmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295844; x=1719900644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uU8msdfI4FBbYYSxzgmdaaqhmtNKe2zgeh42ZfcMs0o=;
 b=wWWCXo6M8mt2rnuMoUM+W3tyuUUaoN4304MKTMsCFLe5yyevri4dPgMnqgoO6vWrry
 Mh9uNW2ntFtt7rzMKHfNNy1d5BYDS8PiqNKmfod65oiIkLmohQq9+10STAKDFZd49iO2
 EpFyoA0e5T3wJNk7s5BfBdqTF9/ocBQYnfZ08NyYwbTJfOMck8lmA7dEM6DfWfm1nzOG
 p2JlAWIfe+BhCixeFqkaBvofpIW2gM+svfDWuC+y3a0Nqm6uFUuNtpvfc3l0t+ZuZKnP
 IDDI1G2SccOtRs0SUUbkYr9flwGnvFh4Zyw8NoE/F6ezKL0tkN8IRMhdYs1dbUkQSKBg
 2q/g==
X-Gm-Message-State: AOJu0Yw9g5LLLq/FJvDZ6ENIWR1EwRtBXRSVMZ7TX75oUHPc2gkTDpL2
 vkgdYHWQaCAWy6NXY9Om1AEgkUf1XEabOZEb4RH/ODOMhRf8zbSXw+WmdqqeSDYXqjk2XmQfOVF
 e
X-Google-Smtp-Source: AGHT+IEQX7noy1synhblTSoxNbfXczeShx3yEU/gGbPMqgRvoETfNdLb9MXJgdKwxTN8t43Zf/xTuA==
X-Received: by 2002:a05:600c:5692:b0:424:8dba:4a43 with SMTP id
 5b1f17b1804b1-4248dba4d52mr51090685e9.5.1719295843947; 
 Mon, 24 Jun 2024 23:10:43 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481910f64sm162488035e9.34.2024.06.24.23.10.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:10:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/11] hw/sd/sdcard: Duplicate READ_SINGLE_BLOCK /
 READ_MULTIPLE_BLOCK cases
Date: Tue, 25 Jun 2024 08:10:08 +0200
Message-ID: <20240625061015.24095-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
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

In order to modify the READ_SINGLE_BLOCK case in the
next commit, duplicate it first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 346bd657a7..9aaa78a334 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1376,6 +1376,24 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
+        switch (sd->state) {
+        case sd_transfer_state:
+
+            if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
+                return sd_r1;
+            }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
+            return sd_r1;
+
+        default:
+            break;
+        }
+        break;
+
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
-- 
2.41.0


