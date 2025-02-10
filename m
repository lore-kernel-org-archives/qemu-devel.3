Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819ECC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQzk-00016P-06; Mon, 10 Feb 2025 05:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzd-0000x6-Bb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:21 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQza-0001fK-C9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:20 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dc1dfd9f2so2658386f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183176; x=1739787976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMveWtKIlfL6uuWpVkSZWRAB3s97sFlGFregYh5GkmE=;
 b=jKEufxgWLKDojuqVzpE9POnoSUePUhnsSWiUb7URJSwR4zv0GZrmq0ISa2Tq/+sKvB
 D7w7kEl+tskIyGFmtP7JrE0gD8Ze1ihyOzvpS0b7mDEv4zl39aN5N4nrQyiEKFIKQqax
 k3p/Ma/ZRvp2G4qgFemhX52736Jvv6sLE3YLc+olHFcAwPpOSDFxf8Y472t1lQu3cEfV
 BI5GqpoW7TjLjrto51aE3yl7mfFwiHCBfN0cHKrT3f7OmooqFGrIa46kTuGWis3ogqc6
 i1Rlv3iSiV0yOraX1lOXaEWv9gsgdRpLvn+FSPDuHAjVt/74ZwRTEBjPLh5zlWLiZ9CS
 OZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183176; x=1739787976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMveWtKIlfL6uuWpVkSZWRAB3s97sFlGFregYh5GkmE=;
 b=FUcq2fqlKFn3547ToWiapPmAWIjYLsGrgt/mO7uwqP5FDCbpCjfBfM/jjQrr6Qy6XG
 XHuiqml71he0OrJL0dom9XEp2NDyP/+6zy/xIOV/Lz/aYcfSqU/3CgizVvH5Pm/a5AUt
 D9REgUHz2svnWIZsUzHVT8l0uUxHat8hLNZsfFmYn86HiuNlH0RRoi2HmFT0ty+EgFbL
 4FctvHXn0o3cUY5EUiChp08XZbxKTLZOb2yq5YDqvBLNxcODLXAMDp7z3oYM82knXtQ4
 Ro+quo+Pe8BISSuQXS/pAxR2+E/qTjkkUlZJH631LRjf+aa1mioX57mRDh6HFU7409Wo
 5Y6A==
X-Gm-Message-State: AOJu0YwbN6e0t96v24G0aDvJu4CrzmvNl/Xj8k0i29VwccWqt0mmRmJW
 n5RRlh3n7iTVy4HoKCzZ2FYD3ZKX+4P/QKFeqLayqPJXsG70ba8dC9nqEtmWZnJ/AEhUbFLH521
 xfgg=
X-Gm-Gg: ASbGnctgD3whWHugojC3LTLoin86C5qINQCDFz9t81MtE2rBPInz152yo18bMeeM3lw
 SRsjHZx0oYwpX2biesA/SWh9OcAPFO0R0BmSbBMPR9VHqhn5Dzu0US+gyaj/kwDNeAp8MIQSR0k
 HsBXRP70cBI5L8Ln3SUtaCgf9qGC6SId5DvLYcmQkpB7xz05anm1LoGS6w7zeaaOT0+Yvx0G7rI
 OZH07LX4BpN2NepRM6O7SUEV5F/rRTb0H+gtw+WnGz2nefCFn6Gmn2UcINwjZbTN6NSv7WGz7yh
 j5aIeNuVY7L0ChSFOjoQsL69sEJ3ahys9xegrfia03tlh1QLRRcI++c91zYJxRBfsENQ/jM=
X-Google-Smtp-Source: AGHT+IFB3wOGF7jGqzaACMQmtCljrIb3uWxcR9oGOvBFozxjEzPbr48ZkEDjCnV1Y2CgFwwwbyiTcA==
X-Received: by 2002:a05:6000:2cf:b0:38d:e02d:5f4e with SMTP id
 ffacd0b85a97d-38de02d5fdemr1304313f8f.5.1739183176360; 
 Mon, 10 Feb 2025 02:26:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf44f3sm179880375e9.29.2025.02.10.02.26.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 02:26:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/10] target/sparc: Constify SPARCCPUClass::cpu_def
Date: Mon, 10 Feb 2025 11:25:56 +0100
Message-ID: <20250210102604.34284-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210102604.34284-1-philmd@linaro.org>
References: <20250210102604.34284-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
---
 target/sparc/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index dda811503b5..462bcb6c0e6 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -574,7 +574,7 @@ struct SPARCCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    sparc_def_t *cpu_def;
+    const sparc_def_t *cpu_def;
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.47.1


