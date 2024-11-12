Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A6ED597A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 20:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAxek-0001KP-Jx; Tue, 12 Nov 2024 15:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeV-0001HN-9C
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:23 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeK-0008T0-5L
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:10 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7f450f7f11dso2111039a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731443884; x=1732048684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=83DOC5EhuvVszgMTN5y3DcTwu/SHcyPUnQNhN45Z82Q=;
 b=E25HWWBJ19L+TGiF3FS14SyQ8PKWmI621OIVxI2RahoTaw8cdN60OtHf/Kg8eBl+AG
 p+aBqEOIwMxmGgTDyOw3zfKNQSrZfxxmySD6dI2oDA3YVb8+NGrFdptAC2+YPKs0CUfF
 BPryxGzeGAfGWpLWZhj30WH5hzPBs7xhKbPB1QjPYJoXumVWxfuqVIvC8dbHRfRbAJJI
 KwgMBlNZmfZMKIarifamThW+LLdnwByzDEhSwKBPhKZ8FClmbJeBHintXp3MJ9Duaeaz
 ruZHn6QxTM+UYCVs7C7NqDIjrNbaRyKDyloeQTtjWZOyQGSCtS7Isx7F8xKCq69QIRLV
 TZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731443884; x=1732048684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83DOC5EhuvVszgMTN5y3DcTwu/SHcyPUnQNhN45Z82Q=;
 b=xCGvS9gEtGwJBovSUxjMOVJ5zJbCGNz2tR0sgOWobQpWSpq7WLtn9rFvw8TMThIQed
 8epOw8Tg/skkn+WPriTUOKsSPTu/pEINsCHsvTUUIPXAsDvH/XqIIUpyEk6yFsfvtK6Q
 1NoKJYMvcTqa3hxqKMnXTsts3Vdw8ppsP79lVk+3FtmZ1aLcP3OuVKRhQ5d7mEt+60Ji
 mJWSpCLMc/cVPQlU2j7XQ/U35KoBkp6JDoz6tqBjCFW9dN2Y7vuz3zreBtBl5XCO3hVQ
 00BSiuXpfS5iUAR7cwZ4LejxjWOGtqJKeh7kF5cJVkCNKon+LYecWZrcgNsmPhGytYYJ
 vgJA==
X-Gm-Message-State: AOJu0YyFAqxxD6kNfmCQR5vwsJ+kddSwHPpqeTFZkqu9UjtSvZOqiT/W
 gpOswgP+8/k7GFIWcK0lRPxMAvIbC+Flqrb/C2mChgCVbDuCgMG+brLa1AgSNTsadtGd3pittj2
 v
X-Google-Smtp-Source: AGHT+IF1Rh/aeP1HttI7mUohCu3+WfDPCKReXgPUVahQpVgS22r+LUJ0yFTSZgLsBx/k2fPB7n5UXg==
X-Received: by 2002:a17:90b:1d89:b0:2e2:c15f:1ffe with SMTP id
 98e67ed59e1d1-2e9b14ce798mr23715683a91.0.1731443884472; 
 Tue, 12 Nov 2024 12:38:04 -0800 (PST)
Received: from stoup.. (wsip-24-120-228-34.lv.lv.cox.net. [24.120.228.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3894192sm9860a91.21.2024.11.12.12.38.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 12:38:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] linux-user/aarch64: Reduce vdso alignment to 4k
Date: Tue, 12 Nov 2024 12:37:54 -0800
Message-ID: <20241112203757.804320-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112203757.804320-1-richard.henderson@linaro.org>
References: <20241112203757.804320-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/Makefile.vdso |   5 +++--
 linux-user/aarch64/vdso-be.so    | Bin 3224 -> 3224 bytes
 linux-user/aarch64/vdso-le.so    | Bin 3224 -> 3224 bytes
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makefile.vdso
index 599958116b..c33a679c0f 100644
--- a/linux-user/aarch64/Makefile.vdso
+++ b/linux-user/aarch64/Makefile.vdso
@@ -5,8 +5,9 @@ VPATH += $(SUBDIR)
 
 all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
 
-LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
-	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
+LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
+	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
+	  -Wl,-z,max-page-size=4096 -Wl,-T,$(SUBDIR)/vdso.ld
 
 $(SUBDIR)/vdso-be.so: vdso.S vdso.ld
 	$(CC) -o $@ $(LDFLAGS) -mbig-endian $<
diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
index 808206ade824b09d786f6cc34f7cddf80b63130e..d43c3b19cdf6588757f2039f2308a8bce21aed9c 100755
GIT binary patch
delta 50
zcmV-20L}lH8JHQ6tpWfLk+0bl<zcO@sx8Bk2RT5)R`<=5QB@Vnvz!6X1qOFSFiLP%
IvvCI}1uUl&oB#j-

delta 50
zcmV-20L}lH8JHQ6tpWi6k+0blA5kqX4aFpe)BQ2Nwg4c8+P|Ifvz!6X1qO9#Ib$<7
IvvCI}1^-?Xy#N3J

diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
index 941aaf29931193300de1f62097867c282a7e0c74..aaedc9d85e568d5dadc9c394e9c4459f1f0c8c88 100755
GIT binary patch
delta 49
zcmV-10M7rI8JHQ6sR9rHk*nPlH6|OK!ah4~>4vUoZ1rE*XtsXbvz!6Y1qE4ha#lpM
HaR(;_22&J+

delta 49
zcmV-10M7rI8JHQ6sR952k*nPl^~i=KtbcHFtl42<9TUsw2PpfHvz!6Y1qD@cX=ik^
HaR(;_8o3m&

-- 
2.43.0


