Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED00BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsQO-0007aQ-T5; Wed, 18 Dec 2024 06:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQH-0007ZF-2f
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:41:02 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQA-0007um-7x
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:41:00 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2167141dfa1so5972085ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734522052; x=1735126852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ul9OmMmNncJxsT3etvbDtuzsNQUV/Abcq80OE4i3YE=;
 b=E413wdg5MdnAvpYvu4HidieaDaKX4MVVl/SnJTCSshDw6zDvMevp1UH53CCvryWEgP
 +mKuvFrNiCD5Dlw2OohFySQ36fEnww/ebDHGfgWIzqZgMtxp+2QA665vh2nkqTNz2Izu
 dgV1vzOWTHzpkVFs3lshNbJUQY6oXGLZFPqumCfxBpVcNpioRteyC29J3XXlWLXNyrps
 SPhngIZ183vzTMHT8blOGTRGEfiNaFjVRpXeeU9NC7tlwQJ15CEVwBg4Syf9zUagpa0U
 p3YC/OXoXcsH+p+KvhM5tCBDQnx/mZ+CaOnx89xdPSb+/f9nzuOuKnFwBXH+EJMxyVBZ
 6Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734522052; x=1735126852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ul9OmMmNncJxsT3etvbDtuzsNQUV/Abcq80OE4i3YE=;
 b=RD1CRouV93DwBn3pGs9i8KtCa5uoAgFtb8cCDiDglKvBcyLmSHTr5TYeinWaW3tGYo
 FeIlHg1W5FikPP3nU6qBqssexk6E3bkN9Mcc9eX6WgwEDTEQzt/1Pwj0d5WzAj89pW0i
 +ZwV/d05WNgKLAFNxZocvGqxl/xuhelm+Lk9byjRky/GTT2aGzMCZXF6nvJHkbhsln64
 LiOlxoVYi7bStZT+R4lOHbimtCW9EMDu3bjU3QdYrG4NuPxmFmXFOLeBtoBlkOuG9Cvi
 C0NMcBPvfKHX7R2hObHYsuANYMeIwqy61qxGfx4wOPhYz0kU9wxWFxyNSKFgun/7SImf
 iUOQ==
X-Gm-Message-State: AOJu0YwlqmJ8uoVZCtVyV8/jJqupPW9p/sr0EkUqbDvr/P1DMRv/CN1W
 tZNRGt2ACh/V/4lIgdjAu1tmsV8cNdrDy4NtWspVWmvF5VIRP5lBoaVvM1NnOuARB1k06g0AQbE
 E4ds=
X-Gm-Gg: ASbGncs68Jd4xkhKHOqSzo++1rlCcC8E/3kVYYsjjIq3x6m7nHktU+6TAlISb9gI6WT
 PN+GwTas9c3DU+/pMsPTfoYMo9iZYd8AGG77WhL2brS6NrX3mXKr7XtTcIkgeK3yGK/eacxyn7q
 xX5e5lb6tTcsn/iLAeaLagbG9I86w+Zf+VJzCh4gDOxq3XVdQTWwY3NiXrmRtWlci6UK/j+hFQs
 rCF/m+1TBdpa4kko4yI8Rxtwc+Ci3VLOgS5OPGCXQou5olzssOqGegBerHM6KTrr8elt1+BSrd2
 4w==
X-Google-Smtp-Source: AGHT+IGVuyeyLF/ffMo9xj5H7d7cZNiu3A7t7rKsg5LWgAHz6Z9r4NxNnNTLJRBQU6HZ7Sx5u6kNHg==
X-Received: by 2002:a17:903:8c6:b0:215:3998:189f with SMTP id
 d9443c01a7336-218d7283495mr37959335ad.6.1734522052028; 
 Wed, 18 Dec 2024 03:40:52 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb447sm74462285ad.68.2024.12.18.03.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 03:40:51 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 3/9] target/riscv: add shcounterenw
Date: Wed, 18 Dec 2024 08:40:20 -0300
Message-ID: <20241218114026.1652352-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
References: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

shcounterenw is defined in RVA22 as:

"For any hpmcounter that is not read-only zero, the corresponding bit in
hcounteren must be writable."

This is always true in TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 332 -> 346 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 58bb5196a8..7091eb683e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 4f231735abad925435c3cd052e6641b1b4187278..460808d017baef93ccdd8fd8d1d4722edefd3b86 100644
GIT binary patch
delta 55
zcmX@Zbc=~A$iq1#ijjeV(RCu10qYM2Muztj?N@PUB<Gjrm82G>=9N!;ZarC%QJKSl
Lk%7UAk%0jK&9M)4

delta 43
zcmcb`bcTs5$iq3rhmnDSk#8cG0qZLUMutZd?N?3wW;xk_QHeu|k%2*nk%0jK|2PU)

-- 
2.47.1


