Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4B3C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSp-0001X8-9Y; Fri, 02 Feb 2024 00:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSl-0001Tl-NS
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:43 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSd-0001uS-4x
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:36 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso1574254a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853094; x=1707457894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhzLuFE6ppEoB9HS2thFYeCAmUg0HDDP2UuzU+1BEtw=;
 b=YWJwQaqUGG9/Pdi9n/oxDcu9xArWNDKB9jSAE3GpviaybjFCPUPeu+Ota9Ps2u6B5y
 NVjW+Hy/t6LAy/zG+gsg03aBYl/1XNCthRa6rfVCZjekeOactX7LEmiNt6QwxBlEocaG
 wlADygSZatgDYGLAKDrw7SE9W5KB+xc9zUVOMPCXkCsO2t9iA3MPxcQYHSF/9ayB8R4M
 Q9xdclevjE4sIxkZAVDulANYJHy4TRaA/OR3eHOvd1/1FdmQXZlUIGODv+C6q6i3q+kn
 JodiOmzzO88DOKJTxp4plbx6RnuYhtXnRypexHl53Mq34JNaLZ/es2+OzTiaX1KVrrUQ
 7tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853094; x=1707457894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhzLuFE6ppEoB9HS2thFYeCAmUg0HDDP2UuzU+1BEtw=;
 b=gJemvN/DarsmzHJ8P+8TXEj+4bMug3TBRzPiiujSjJD49Wu7XmlW8roIIWdaGRVZ/z
 ZDqAdGzVdayeeiKpEaUZ4L/YEkahexa3zm3+uuchiiZw4ZneTEyQqdGmFjpjOjvg/Ulq
 zXGrnMDDN9Gh72ZqzyvDdCnfIaDKRTVa95Qv87koZrupUtpxuaP07X3itmht4eNdEs48
 KMxJ9c2xY73+5VGecE8zQo7n0Qi4XLqPKdOEepemrCpFVjuVkMkXWA6KCqTzT4lIIddR
 ndE4EQZIE+m1W+K7vfioAIwV65rDCbqs7/OodBEUNNuOp7AvOxZ7A2jNeWb4NAnHg4Zn
 Iuiw==
X-Gm-Message-State: AOJu0YxyLiRKb2rmA6lL6lTwYBAbnaec3/IGun6CPo3MHUlcoe4Sn5+f
 URoysphe4C4FPN1WBjMrQx8Vsd7GW2cHy0MLMiDxqJ9DZReiyTgb8ZdC3b99JeQUaEgLnB/zlXZ
 swLI=
X-Google-Smtp-Source: AGHT+IEQ5ur0SDJGpEZGK38nwTFwOsuQq5IoG2dpLXJ8pschrEffkAaIJt3U7RahC3AD4AlZSWFgJA==
X-Received: by 2002:a05:6a20:c61e:b0:19c:b3ea:27ba with SMTP id
 gp30-20020a056a20c61e00b0019cb3ea27bamr6570462pzb.52.1706853093781; 
 Thu, 01 Feb 2024 21:51:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWlKY66yzftTQ1Yd01vuQCQGZeRwDkPucpH7hbRPPsDjGVBYMZljz8PJKhNRKYtM6FGx4wL0MWXS/2Z6mfQ5gngog==
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/57] target/riscv: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:50:03 +1000
Message-Id: <20240202055036.684176-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8cbfc7e781..be21fa09c6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -867,6 +867,11 @@ static bool riscv_cpu_has_work(CPUState *cs)
 #endif
 }
 
+static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return riscv_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 static void riscv_cpu_reset_hold(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
@@ -1810,6 +1815,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = riscv_cpu_class_by_name;
     cc->has_work = riscv_cpu_has_work;
+    cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
     cc->get_pc = riscv_cpu_get_pc;
-- 
2.34.1


