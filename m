Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDE3E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnI0C-0000ML-2r; Tue, 03 Feb 2026 10:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI07-0008TE-FF
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:36 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI05-0002RF-RU
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:35 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so61145135e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131252; x=1770736052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jGqTvkEMHveJWI/zuGw9XswRbOgb7CrfuDpUK6fNXzI=;
 b=OQbYSHFjW3U/ZumSfgSUw0NAht/lEuEg+PxDk5wmpLspjUnleazvAdA/9SHsSjY32R
 VNkY9LyYb+0mvaM71AeT5e+BKcfS0iamvclM0dg1p8p+ileY9rJqv/QsPfAP2T//rTcH
 8NsAkDj1vHOnQG2Fn9RZc5GgKwNlaBUrWVKXmMBEDgin/HPS8KRi35UmSJ0A8W/uLkS5
 JJ9w82RoTRx3Axb25DJiLGY4cAxj3LQjnJYj3g18X+D/vul8u+efWQMhgpSvR7D99Fu6
 s+Pxkh/QuZBd11/DApMdDYZrTF9B+m3ioHFOkja0UnlUDUCtvyKsuLG1/Qhwidmz0n4+
 EeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131252; x=1770736052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jGqTvkEMHveJWI/zuGw9XswRbOgb7CrfuDpUK6fNXzI=;
 b=iiC6LFhO2vURWRUGTiryPiJhrxH/C7QDtlK49PG4rtNV4bv9pwj7zjIUuEfN2X2S+6
 Y6cyLDkt0hr/D2uavvPRfOKe8+uLWA4sYVkpC/Ivtolq2jBGvi4Ex1Lc/bP9WdD+xHla
 jjVCu8TqygLyUomZLmPs5R2HIeMOyfmBSdPCJfReoVGLohQRnewPf2hhC5/qvoT/ONxf
 5cXIdBI8BKoNGjQn6HzWAWNOXYvavjLRwBmG9qwv43fR8PR/fqvGcN1FwaD0uVeXl4QD
 mQvIblkzOVm8rVUBmVITPSXByRg5yKvsHQBQQK2jeXq55SRsH1THBzEpi9zi4rq/O3S8
 1gOQ==
X-Gm-Message-State: AOJu0YwxJbkMpHcwzIXld9eGGkYfTk3L4nnOHnf14zhHO0O4FAVmxT++
 SwsVOrPP9Xxqgleeyora573NoAK3jECB8as3kyDoTgcfgAhJbLh4ue6I1wbXcR/IKE2oHigFGd9
 RqHZXwxQ=
X-Gm-Gg: AZuq6aKPMrObwyiFIyWSp/OvpNEyPlWMuB2RJAzuPbbKX/gMy2/DdXooWTW782LTP7A
 GeWRweqEwVDyNG+wpEqAWTv0mX33QSkoNkxJJP/018/t2Qrgo1fydBqrdN+VDTyVSn3PNmx7/FY
 nwxK5qejrLXAQK/LvcN0Xcpth8kZdkwJltCVan1NEDMHp1qEzyabCY+li+XafkfwKbg471RIuhn
 pXBUr9a1xsfKdguzXBcDtw2pa6JVOmzILI4GscEYaf2N1oAzl0yCgGRUFKYPn8ra3R+DzV68WuX
 OQgA50vUYRYmiPHe24bClgJsYkrm1foxfSCh2fF61jZvdZXioz/Cu8wTJzXoRMOCR0yJbo6AY0M
 1CwwtdQ/2U7n5bX2iyw/3Nznoo1CEk5tV/NJ4hmbft0D2wSTWerzivWZ2OWqS4l0GJbPlaX9DXx
 jeMRyruQhHVgs66ZM84UpkkmF5VnFnxTnJ8oYdCElHf329T9jHwAZDmdX+pxbC
X-Received: by 2002:a05:600c:8b12:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-482db44e7f7mr203730775e9.5.1770131251833; 
 Tue, 03 Feb 2026 07:07:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830512e0edsm73669135e9.7.2026.02.03.07.07.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:07:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/30] target/arm: Have cpu_isar_feature() use a const ARMCPU
 object
Date: Tue,  3 Feb 2026 16:04:30 +0100
Message-ID: <20260203150436.71907-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The @cpu_ variable is only accessed read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202222412.24923-3-philmd@linaro.org>
---
 target/arm/cpu-features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a7ca410dcb4..f7b14373407 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1643,6 +1643,6 @@ static inline uint64_t make_ccsidr(CCSIDRFormat format, unsigned assoc,
  * Forward to the above feature tests given an ARMCPU pointer.
  */
 #define cpu_isar_feature(name, cpu) \
-    ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
+    ({ const ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
 
 #endif
-- 
2.52.0


