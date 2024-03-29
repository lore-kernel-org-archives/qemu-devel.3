Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A92C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlK-0002c0-KX; Fri, 29 Mar 2024 18:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkz-0002Xl-RP
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKky-0003WW-BL
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e243ccbffbso283835ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751487; x=1712356287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPcM7F+bIMm+kpOtGS43p2VNPDZH3BZ56mw6e1fyEkk=;
 b=txzeo8Il11JmWps6LjORNB7JrGAPN8jnYbCWQ4yx46bh8g+j2PrZs3B07MPs6U5ak9
 ASpbWKcmMa/9PDP1PbskxLrPLyKQzLJ7WpzAwfE9fojcpbD8fKkLyO83alpy0EPOELgP
 F6xEL2Kh1+5sN+OrbHsW/dAhFK6aSyPW07v18FC6yDPMpps+Hps72va0KiRb+E5MtgwO
 Y2pSDdH1c1fZe3MfnRbUbznI6lxQcO9nH3qGwVf4lODZV+6iItTFM92Zo5RyB35zSzlb
 3IG+mEUCJ8+IDJ8OqUDHZwJTb8v9LCAWz+dPFhWWkEU9F8XpLAlVlaOp7xzONAPL2MAx
 oFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751487; x=1712356287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPcM7F+bIMm+kpOtGS43p2VNPDZH3BZ56mw6e1fyEkk=;
 b=X6ef3rG855Z4Znbx1Sio1F2V8PcSrqaxwEGCkJGmslbAIChRiJzramfWilYqinpqjg
 LbKNFeuIvxC0Ja2APcz/AxiA9AgAjQCN63fk2T720xNdMEO4CpzAkNcCmJetKwQ8VBit
 xgMwyYKQV8TcKvmu1PNttIuyTlnO0rFKhNP59zNQeliIAW6SDmLhqhTThf8gRuZ0Ks9h
 ERJry/vTBj/Qm8X+7mKEmrPxJIRq1wasTI+ZgLoXK8zTZYw07DWBLdATGUibwO9qX8Lo
 /EbVnxCm1ph+vt+96E36IBSmjqtsZdEO17g4kqE+YAsDuZKCY5ywdDGxU7t+cjqUN0wL
 5vZw==
X-Gm-Message-State: AOJu0YyFFPdk1oNWt83F0vR1Hj77F+j8ytsPmW7OkNAX6IGt0J6XDBND
 68x7OFr7/OedUxbb33zX6zKeocALPHXSbI+8VtCtRbzfO7/MMurjyhnXdUNbSapeM6x4u4Koaa3
 d
X-Google-Smtp-Source: AGHT+IGfaSCSHzixvDrzuy4wFSPTQ7LegI5x/qe5cHjPlkIiUB8NjCpNSR8z9MMM9GPQXISyxKgdGQ==
X-Received: by 2002:a17:902:e495:b0:1e0:afa0:d515 with SMTP id
 i21-20020a170902e49500b001e0afa0d515mr2767567ple.29.1711751487100; 
 Fri, 29 Mar 2024 15:31:27 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 09/18] target/hppa: Fix DCOR reconstruction of carry bits
Date: Fri, 29 Mar 2024 12:31:02 -1000
Message-Id: <20240329223111.1735826-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The carry bits for each nibble N are located in bit (N+1)*4,
so the shift by 3 was off by one.  Furthermore, the carry bit
for the most significant carry bit is indeed located in bit 64,
which is located in a different storage word.

Use a double-word shift-right to reassemble into a single word
and place them all at bit 0 of their respective nibbles.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Fixes: b2167459ae4 ("target-hppa: Implement basic arithmetic")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e041310207..a3f425d861 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2791,7 +2791,7 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf_d *a, bool is_i)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_shri_i64(tmp, cpu_psw_cb, 3);
+    tcg_gen_extract2_i64(tmp, cpu_psw_cb, cpu_psw_cb_msb, 4);
     if (!is_i) {
         tcg_gen_not_i64(tmp, tmp);
     }
-- 
2.34.1


