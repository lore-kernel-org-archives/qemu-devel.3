Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A57EC52D6D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 04:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sapPx-000204-VM; Mon, 05 Aug 2024 00:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sapPt-0001sL-Sh; Mon, 05 Aug 2024 00:33:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sapPs-0002s7-CL; Mon, 05 Aug 2024 00:33:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd9e70b592so69196605ad.3; 
 Sun, 04 Aug 2024 21:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722832430; x=1723437230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFh++sirQMd0IziYGfZguvCAoQpy8TlaQ+1xWpZVDi4=;
 b=cWqcppaJY+/lUZ7InxljBpOb0tWsLilia/Bf9MQShk76RrBG2YgtjUI79h+xdiNA1D
 mpDdb+aZ/n7kP8sq/d0xfGdqceK9sZJULsLvDk+UOr2etrZ/GHb9X9O1f3HxM+rdgyPO
 aaXf+ZInzTBQrBgz1EpNoXjpGJVEC3iT3s3FQFAMVsUzNV78Tr3qvM+7uRyjyWVtLAJg
 EBiHhTI5lB/d7MrO0phGIRG2VyNjoYEphEmUZMbFRiUiYrkABX9Nuy9F75enQFYcwoZL
 70oinKlHb8dGvCGdqST8siIVojDsZ+3sWtvi993+Kcc1uyDU8L2puWRKjFgt4tS0WUgJ
 yYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722832430; x=1723437230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zFh++sirQMd0IziYGfZguvCAoQpy8TlaQ+1xWpZVDi4=;
 b=a4zmWcjn0OL5GSVyM8RH0uQpjOAOViZEChNaqq7BIOYigtH459wumvSx6hl2/8d671
 P7LgrShlck32EBwEuoN9kZ2BcI+Ce1cNQenARapWizvl2zV91vI/yT5eviTtjP/q3cB/
 zx1G8opEcRxYtoIqkRc4jUXovBtyUbU29VWMd+8Zgt0GkOx+epWPUKTNLdDckWu+hG0T
 ZNgHUFznUqG8hLpnNtfkDWCyKsqix0GiFSfgjZY7NyHrASfhdHdUO0a47FuZVKN/1nnx
 dGWTzUHkfi0tSpv0Mu7KO53Mno8d84N58/HXrCysgoQtq8tmoI6FOK6p/yzHXbqguFM7
 uYMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8aDqSZTnRWRmY0MG6QqZbptetvAjB1tSSrV5c3SRpPrclzddn8Sptr4MDqubQHGMfPImd3vWG95Bj+vOnnXwGiwl/WEk=
X-Gm-Message-State: AOJu0YwB6XNzwtlI2FomB433C808TOFR+OGxzAEg32OOigBuCFmizmTE
 JpI8ks6n6OGDFi04Rhz/Z+IBV7tPU7K48BtTVzmDxsvypHo81BY4+rvXBYJ0
X-Google-Smtp-Source: AGHT+IEFchAv5lJ9qA4ZIis62NaxwN+E0FnMbTjOJM1cdn7PlDo98m0g/XE7+ckuirB38H4nIXG1QQ==
X-Received: by 2002:a17:902:d501:b0:1fb:9b9f:cb38 with SMTP id
 d9443c01a7336-1ff57421f08mr105985905ad.46.1722832429881; 
 Sun, 04 Aug 2024 21:33:49 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f29cd5sm57420725ad.56.2024.08.04.21.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 21:33:49 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, zhiwei_liu@linux.alibaba.com,
 Alistair Francis <alistair.francis@wdc.com>, atishp@rivosinc.com,
 bmeng.cn@gmail.com, qemu-riscv@nongnu.org, alistair23@gmail.com
Subject: [PATCH 1/2] include: bitops: Add mask extract64/deposit64
Date: Mon,  5 Aug 2024 14:33:35 +1000
Message-ID: <20240805043336.72548-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805043336.72548-1-alistair.francis@wdc.com>
References: <20240805043336.72548-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Based on the RISC-V get_field() and set_field() macros add
mask_extract64() and mask_deposit64() bitop functions. These can extrac
and deposit values into fields using a bit field mask directly instead
of a length and shift.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/qemu/bitops.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 2c0a2fe751..dd26f4a6b5 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -409,6 +409,22 @@ static inline uint64_t extract64(uint64_t value, int start, int length)
     return (value >> start) & (~0ULL >> (64 - length));
 }
 
+/**
+ * mask_extract64:
+ * @value: the value to extract the bit field from
+ * @mask: the mask bit field to extract
+ *
+ * Extract from the 64 bit input @value the bit mask specified by the
+ * @mask parameter, and return it. The value returned is shifted
+ * so that only the bit field is returned.
+ *
+ * Returns: the value of the bit field extracted from the input value.
+ */
+static inline uint64_t mask_extract64(uint64_t value, uint64_t mask)
+{
+    return (value & mask) / (mask & ~(mask << 1));
+}
+
 /**
  * sextract32:
  * @value: the value to extract the bit field from
@@ -511,6 +527,25 @@ static inline uint64_t deposit64(uint64_t value, int start, int length,
     return (value & ~mask) | ((fieldval << start) & mask);
 }
 
+/**
+ * mask_deposit64:
+ * @value: initial value to insert bit field into
+ * @mask: the mask bit field
+ * @fieldval: the value to insert into the bit field
+ *
+ * Deposit @fieldval into the 64 bit @value at the bit field specified
+ * by the @mask parameter, and return the modified
+ * @value. Bits of @value outside the bit field are not modified.
+ * Bits of @fieldval above @mask bits are ignored.
+ *
+ * Returns: the modified @value.
+ */
+static inline uint64_t mask_deposit64(uint64_t value, uint64_t mask,
+                                      uint64_t fieldval)
+{
+    return (value & ~mask) | ((fieldval * (mask & ~(mask << 1))) & mask);
+}
+
 /**
  * half_shuffle32:
  * @x: 32-bit value (of which only the bottom 16 bits are of interest)
-- 
2.45.2


