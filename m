Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E00C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTDq-0002nw-V8; Wed, 13 Mar 2024 14:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkTDp-0002n2-Ex
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:21:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkTDm-0007vn-CD
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:21:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e6c38be762so32334b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710354057; x=1710958857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rH1IZxFnTB29OgOKliVMKa8CVeUZ97GXo3gLLU6YFSU=;
 b=Mm9DwHJp26QoRo5twDnoUap3DfaHJcieTQy/+k1CBFa1CiUqyRZOv9KQSHbKMko1ha
 KQwAz1b/5WWw0JWfZBN86cL4Yj7/ONWgUQtBfTQisQaCc8LmlHdp9AZLVtBstabWAmlm
 kkC00uNqEzBG19q5iImhMSectOchhv16ZJbHUefXJAZy+UwMDBrXDJo2vWBdanMyCkmI
 WZoASDksuqXjTkr1E80/BevUTpvIXMWsKftR/isveRgjGdPFiGlUOzVKV5eTAfGaSeF4
 EERpNtw04MdTtgDoy/zADmXnNfROO78kcA0QptqWt3wVmS7wElu07OTZz8SDQBDL+ifj
 rb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710354057; x=1710958857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rH1IZxFnTB29OgOKliVMKa8CVeUZ97GXo3gLLU6YFSU=;
 b=Jc5JmLnam1+HFeciQM9p66CitziCiDBaP7M2cFq9cd02OcI+ClaEG9E49R3N7Ge9mm
 368xBKGEE64OAukyuJvF6sP8vdfDStMrFuF6Vu3jMW61cfaB9+a9mNgiDlWVY4acAtIm
 D292fc5M5HoN+ONM00NOU8l9FzciGCwUiT3oBK+m51l0nymW1IRSgIykTSCFC7PqgylR
 ca2TwR3EnHW8BVDEC7kh0x9QreROI4HxUvO5VqsXBF4BZQQQpyiB274yEscD/UZqlvbx
 uJi5kjNiACNzJp7i7cTrY3IChsbycAWSYcfUM4LUUcKok0O1RhJDoQmIdcVkXFsrgsTD
 nhGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVARyyPTkr4A9JmEzeASQdjXGmQNdSgD6dt+DXR8mMZcCLMovoWr5PMrq3ThUz0rKF6iVt11RjRRSZECiz3/HERik1eXkE=
X-Gm-Message-State: AOJu0Yzo5Ye1aIX6kewL+ADxVO2s5ZvcbzQGHfGxOW0eAbwhJOioGYoC
 qHHBOhU/wOjhXywuzOphTSwD+YSSBKlhf/EyNwBdKzSKt9bIDb6CW8TjZa9+iZYD4cL0PcAisA3
 Zk9c=
X-Google-Smtp-Source: AGHT+IG8p2fAkQShZAzBFqaNHGI+t7NIpwu2LFoPwzU6SbjWH0AB/r72vVl3C8gGI5e+JQt5lxDDjQ==
X-Received: by 2002:a05:6a20:2d0b:b0:1a1:4766:5b1a with SMTP id
 g11-20020a056a202d0b00b001a147665b1amr2474279pzl.1.1710354056912; 
 Wed, 13 Mar 2024 11:20:56 -0700 (PDT)
Received: from localhost.localdomain ([49.37.251.185])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a62be16000000b006e6a16acf85sm3457528pff.87.2024.03.13.11.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 11:20:56 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v5 2/3] target/riscv: Expose sdtrig ISA extension
Date: Wed, 13 Mar 2024 23:50:08 +0530
Message-Id: <20240313182009.608685-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313182009.608685-1-hchauhan@ventanamicro.com>
References: <20240313182009.608685-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch adds "sdtrig" in the ISA string when sdtrig extension is enabled.
The sdtrig extension may or may not be implemented in a system. Therefore, the
           -cpu rv64,sdtrig=<true/false>
option can be used to dynamically turn sdtrig extension on or off.

Since, the sdtrig ISA extension is a superset of debug specification, disable
the debug property when sdtrig is enabled. A warning is printed when this is
done.

By default, the sdtrig extension is disabled and debug property enabled as usual.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2602aae9f5..e0710010f5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1008,6 +1009,10 @@ static void riscv_cpu_reset_hold(Object *obj)
     set_default_nan_mode(1, &env->fp_status);
 
 #ifndef CONFIG_USER_ONLY
+    if (!cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
+	    cpu->cfg.debug = 1;
+    }
+
     if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
@@ -1480,6 +1485,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
+    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, false),
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-- 
2.34.1


