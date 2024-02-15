Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE536C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV75-0002NI-C3; Thu, 15 Feb 2024 01:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6v-0002Jv-28
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:42 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6t-0005Td-G8
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:40 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d8aadc624dso4184415ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978038; x=1708582838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8e59UVGjA+rf7vDiYDlVPV0vb6j37PsuKcjN1UFSiz0=;
 b=m6dM743nvCBONtmpXoTrg98ube4wBIS/1gKtxfx3gVz5jGnSFjMZcvEIX90u6Bi40b
 NKgfUan9q6KpdckTTYBQiWxy57lFN6i0eSK1gXCuNFSpBwqf8oKEzEmsUa1F2DIghhws
 cSBN7Vlh1b7GAXIxmu+OZPrC5Ej5wQzYw6B933EYhl7KYxwHezKHXQRrnWe3LKGmCm2l
 z3b5uGHq8Nk3kArITyPE0bKIKi/qPoy+kELXwgxF8chmc50ldy6KgD7qlMUB4pStrkip
 uPCF735JclVbccypzr8B0f9GLr/knPKdB55iNph3kTZDBPhDXSe20JfQiYgYrJ4GdcqE
 MNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978038; x=1708582838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8e59UVGjA+rf7vDiYDlVPV0vb6j37PsuKcjN1UFSiz0=;
 b=kj98B+e4kgiaCzZL/H7RlcoQB1WRyIW5cGL69L9uFUfPZvO/f9vjvYB6a2SoOigxo7
 vF/2sJsCZ9znI+Bav5N08gSqygvjyR9cq8GXitRfzWAOdn28oWMmE0Z1CLYuZuQvLrZu
 3L0zzDwAv8lCKCa9iWSW+d2/IibCukAMcIdrCK7Yab8usI8KLLgFepP+2TK3xjhaUmUT
 ceh1nYKHtyqHSAqngDMGXYxDcwSwDvgODYGab08+KDeOD0Q29APtjZTk4HdgZkwtunl3
 FQYxjWjJy/UgQfF41GfTO94gH34+mCV0Rh7mxNzBFJCTa6Utx6ZGE1Z3qRGILPurfsU+
 v97w==
X-Gm-Message-State: AOJu0YwewvCyWBucBV1D7AwDkMMjNVleLdbV0m2j2X8GXSVN26qxP18b
 0WbL8sc7EjG9cu+0HZwmSu1umzsCwflC27XdH9AfZIDiMFD5Fygx3Pp5Q9RWP12vMEQY2yocmYO
 9
X-Google-Smtp-Source: AGHT+IGOPl7aLeb+RTsbvuqH8pWpd8f3a0w1l4a3JBWEDz1RjmGBP8n9D8UKg29DE749eB5plPmV+w==
X-Received: by 2002:a17:902:c40c:b0:1db:5093:5e23 with SMTP id
 k12-20020a170902c40c00b001db50935e23mr1026511plk.28.1707978038374; 
 Wed, 14 Feb 2024 22:20:38 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 12/36] hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
Date: Wed, 14 Feb 2024 20:19:54 -1000
Message-Id: <20240215062018.795056-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The size of the allocation need not match the alignment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-13-richard.henderson@linaro.org>
---
 hw/tpm/tpm_ppi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index 7f74e26ec6..91eeafd53a 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -47,8 +47,7 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
 void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
                   hwaddr addr, Object *obj)
 {
-    tpmppi->buf = qemu_memalign(qemu_real_host_page_size(),
-                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
+    tpmppi->buf = qemu_memalign(qemu_real_host_page_size(), TPM_PPI_ADDR_SIZE);
     memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
                                       TPM_PPI_ADDR_SIZE, tpmppi->buf);
     vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
-- 
2.34.1


