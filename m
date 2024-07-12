Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6304C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJ7x-0005dn-Cg; Fri, 12 Jul 2024 12:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7s-0005VP-6G
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:28:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7q-00020g-Fq
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:28:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso14943725e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720801677; x=1721406477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5v0lhbhFJNzaNnnpGempJ4TqJKsskD8Q6hiPRfCwH2w=;
 b=FoUvpwCgymd4jAGYwOFijW4fwywDFil/AvJIhW048fZWmuK2ZIuqPZ/6NFWbL2kd7M
 iVMukrjmvzeC3qGTjoQu+umPT1TwtndM2eCym1OfDJprwYM1yLdwaGrFiWH3VQAOl3QF
 mNG9QoSKwh3xikgkFSnbJZ2I0AstlXyItOpZajJ8Js2mHXeOmpKmWTylAIJqRCBKlz9m
 sQ/rGtf2HMHhKmDc2ZN0HPMspUW7quOvCxXXVqNM0XoPDcLcB07Zrwz2Cawx3P5uux2n
 JdFa+xN1/FT9+74EGilX24wudXxhuxm1jCKVMYuScmBLKhZGL9+mpwj6m8omYVH0ocdJ
 MwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801677; x=1721406477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5v0lhbhFJNzaNnnpGempJ4TqJKsskD8Q6hiPRfCwH2w=;
 b=EFey2NFapnSOzhNms+h8SsMMm3eOwiR+EJuqduf/DLW9lkh9yqsCA76O1rnz4xFmO6
 nIwAt//lCtueHSY/k8W562+TBbWEmYreN1S1u1WSz0tDPpvImr2pSYSzm4lm87A7pP5o
 D8FSGOd6ZF5sbUS6tCOCVHTu4r84coZAFCnxNhkz8gJx9eMPLBSvLO/Xa+dIf148uPwY
 uthNWcni2PJpGZfHp8hO0YRpai5O8qC++Vxnd/YX/w0reNd+p5aZWX5zq93qdqBKEFN/
 7QRvBpa9WWJC3FqJLIFw2AtINc/n/bfuTDyJeTV94XDBpOJN2+sOySNGnm3L9T34VmFS
 heuQ==
X-Gm-Message-State: AOJu0Yx2e7fX908JQH/uRUq5RsOcTqGH80OnKez1JEenUzCGbAIr7HyE
 v4Pw1soasDcFjeL97wyyyl/eSxl+GIlAty8O7Mt1dYfR9Ybpn9Lz0n2Kvm9AO1I/bmSep/DHYVj
 2
X-Google-Smtp-Source: AGHT+IFJhVcxE37ANc4Ze8cxtlRBTbKGC+8MnZHxSqUP25dZhi5uR74aQayjgqxsfdadsv+l19BItQ==
X-Received: by 2002:a05:6000:ec4:b0:365:f52f:cd44 with SMTP id
 ffacd0b85a97d-367cead8fa4mr7617932f8f.57.1720801677685; 
 Fri, 12 Jul 2024 09:27:57 -0700 (PDT)
Received: from localhost.localdomain
 (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr. [176.184.54.152])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa06desm10619430f8f.76.2024.07.12.09.27.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jul 2024 09:27:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH v49 06/11] hw/sd/sdcard: Add emmc_cmd_PROGRAM_CID handler
 (CMD26)
Date: Fri, 12 Jul 2024 18:27:14 +0200
Message-ID: <20240712162719.88165-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240712162719.88165-1-philmd@linaro.org>
References: <20240712162719.88165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 09077f0154..a90612af58 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1568,6 +1568,12 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 }
 
+/* CMD26 */
+static sd_rsp_type_t emmc_cmd_PROGRAM_CID(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
+}
+
 /* CMD27 */
 static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
 {
@@ -1917,9 +1923,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 26:  /* CMD26:  PROGRAM_CID */
-        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
@@ -2478,6 +2481,7 @@ static const SDProto sd_proto_emmc = {
         [20] = {3,  sd_adtc, "WRITE_DAT_UNTIL_STOP", sd_cmd_unimplemented},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [26] = {4,  sd_adtc, "PROGRAM_CID", emmc_cmd_PROGRAM_CID},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
-- 
2.41.0


