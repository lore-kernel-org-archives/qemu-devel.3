Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02A3C4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOg5-000259-I9; Fri, 09 Feb 2024 06:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdW-0007bo-IY
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:44 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdS-0000uD-LT
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:36 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e0518c83c6so526741b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476488; x=1708081288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IO41j0oXhlMR5wVsqGAyByLINIm4VmbCDcDESGIYuqk=;
 b=SBq1S4xZxo7gPUuEcTjvZOyNM+G/pqTmWEVX9iCLkRVcYca23dN+b2RvbOk+EpJ/44
 OzHhl8KSfK0MLRsjxtIXRtkF4v3m/ITyYbF6G0N3EW9mt4P2O5JRSgtG8JMyD6kI3Qyb
 cnWgOqPI5F9pdyJJA+CzuPOsCerzsJ3a4w7u7LHztPF3JZXMe5Raz+qNaHd7sde++WLd
 gKSVMEWRx2sWWxyWP7Sg3BUgCK/KKT7woICZwz1NkX2dq3d1ngJz4tOFiXNn4DIBc1oi
 paOy6qsTatoL94F1UB0YdFRm5HAfYt9B/Rf/C7oT6vAK791ZBFLIHLfQDkH68PCMvhN3
 ZR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476488; x=1708081288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IO41j0oXhlMR5wVsqGAyByLINIm4VmbCDcDESGIYuqk=;
 b=HlyqI/DXfWL51gfvD5xctsNZIVyrOG5wrDLXqlcU+Aupza69nfZ8u38FhKRAoAYhS1
 J9VoZWyxzGHTL2W2icfPuoegTxDFGSGenMo8koszGi9bG+IOzbUS/Hr5HMbKp2GTT0xh
 tTbLBYX3kXcb8b2Tw12s0/nO718t5iG+a8YgpR4Zgnbmaew+n4EQHpoSU4Ar4SQVFf/C
 GGlB9Y0rXKbkhNbkU5R/vd56wsIa35fI0k5WuMlA5cPyiPLrqI8inVxZQuzts9i97Z+K
 l4IjpXa9LGjPIzkICn3sv8uV9zWR2MjZhrSnMveTNkNgcC1JUhey3wz0TN2SwHrjuiIL
 kxtw==
X-Gm-Message-State: AOJu0YwGqP4FdJ7tUYjPC1afdPZfWZeKHELZ9thXKokmifRaf5UAeSyS
 d0ivaEXkCCmv29dMCdHtHSNEBhNRQSG7TpDvAJQ2614upoH5P0AlqDUdL0FPhJYr4A==
X-Google-Smtp-Source: AGHT+IEqp0JTyO4X3NafDheZkSuwT7WClcbFpszVAEx1E3DtaOiAurYhbg8KxP8694cIYkKjmR2VKA==
X-Received: by 2002:a05:6a21:9217:b0:19e:34ea:36ab with SMTP id
 tl23-20020a056a21921700b0019e34ea36abmr1668281pzb.16.1707476488325; 
 Fri, 09 Feb 2024 03:01:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVa4HrWZYgkMrvUh401nf0uffcFVDvcExVN9MfFSHn128kbqPl/h8COrpbfFmVsGEB0GanvLEg5a1/N624BZLeeODs41xk//Xr/AHrmoseFqgt+drDt8lWBugnwz9Eev/uRUEB/DSfmLQg2WEsTxN/VXSDKRp1U7Y0OQj3ICtu3TFqEVkY=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 56/61] smbios: function to set default processor family
Date: Fri,  9 Feb 2024 20:58:08 +1000
Message-ID: <20240209105813.3590056-57-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Provide a function to set the default processor family.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20240123184229.10415-3-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/firmware/smbios.h | 1 +
 hw/smbios/smbios.c           | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 7f3259a630..6e514982d4 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -295,6 +295,7 @@ void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
+void smbios_set_default_processor_family(uint16_t processor_family);
 uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length);
 void smbios_get_tables(MachineState *ms,
                        const struct smbios_phys_mem_area *mem_array,
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 647bc6d603..c0c5a81e66 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -989,6 +989,13 @@ void smbios_set_cpuid(uint32_t version, uint32_t features)
         field = value;                                                    \
     }
 
+void smbios_set_default_processor_family(uint16_t processor_family)
+{
+    if (type4.processor_family <= 0x01) {
+        type4.processor_family = processor_family;
+    }
+}
+
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
                          bool uuid_encoded, SmbiosEntryPointType ep_type)
-- 
2.43.0


