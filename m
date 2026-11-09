Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49680606A33F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QD0pdU+2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQ0M-0007Gq-8q; Mon, 09 Nov 2026 09:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ07-0007AJ-Lx
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:38 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ05-0008AI-FC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4919a880834so544886f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794233131; x=1794837931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u1p3xLhUQaiHmwfqrKKk2BE2A9rmOTSYS3imI80QnJo=;
 b=QD0pdU+20hNwJMw4Hjs0UNedNpEAqQQ9C7VseX95rgZ/oRBax1As3CV78Cmffn5Xdt
 wlYJGOSx9QyyV6e/Z8cy5GgaL8RpvsbkXEKZrcBHtwp3vLaFtq0pMwAuPhEIDEtAlLGJ
 C2fdqux4bSYtEBC4D+CXOw7bHT9yaxRimrZ9uzRy1CLQx+9uQW67veTJ1Zu0UC+IrHI0
 +KRQ5awC0XpS6cpNCyHoIyuTZWWYGy3G8XDJVoTK456QB22lOydvQUEu/AkGYeV9PZwI
 q2uu1myYVucr/YI68kYq1ahklkk7ZkoOQZbExOCG1dJ7l2dlgFFTEaThr6OjvkYUObxL
 daqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233131; x=1794837931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=u1p3xLhUQaiHmwfqrKKk2BE2A9rmOTSYS3imI80QnJo=;
 b=209M0hxW69wVCwDLAg7XOD36yqyT7gEimxy6e88y0bEgvFl3CDGR7nDY1E8a1S5t35
 SHlaOq82bKg9I+mcUE9fFuPvwkESBFciUHYrgn8x1EjAtx7EGb02DCUBoyUykDqBMlA/
 bTMbo0WPNpDf4/Q6XG8G5Sqn2BX18eClXl6my+5+HIIj+cp2nf3MtrI1YTx/ZSL9QwY2
 nsQJn+3ArVsnPf8oq0jnqPBt4eLvS8e0F76IXUW3ziftJp+VbsJ4lfgNlwHw8zd6Mldb
 6t6jzMNhu1N81yieZs4Vy20vo5OzONEOzx9PFpagw4BJUxK1T0yQ7mqWdjGrLJZrQfwS
 CKNw==
X-Gm-Message-State: APuU4Z/hurH0VsRZngV3o2LraKna5mYmsR1mGXPYMA1oJDQzLkoLsC+L
 2XJm9IWHpVFQV9i+H9zhtM59wFUVpI+7UDnZmXxDte8fhub+U65XPdYrFU3u6P8coxEOeOT/Cfs
 yG2YlfRY=
X-Gm-Gg: AYBFou32zy8u+74AaPBGmTtCEMmLcltIf8zxngjkDThTpWAgtSs69tfY/hKQC1RHyQQ
 QGn71RwfIFvsFPMdRyGXq9cy8j9piYdVqtkFTxfZORUcVRHqUkE0I0vbT5BjQpaFccomF0F6g8B
 LbWpY3xLJ8sU5WBgTab1D8zckEN0DCK4OVT734NmqxS02whvmQTz0o6dD6VZbjIsEQtjD+c6arZ
 vLvKJaRjilfs36e+5B32IoGBUeNmy4slEKF6gC1wTi5mEAIshq3969JrW+zxaYE0MQe1ztbut43
 SInL6C2Tt1I99dYrGoDTvSNn7kC/vaSGMd2k99rrRe2tz2jbGQrULGbDiyv8qgvyfT4PzeBdhl1
 +eA6sVnhNltvqaTRfhkk1ufE9BtN/txkc6Sz9KdLveMfqIcgJZHw4bCCc+yjbYl/0PYd6p/uDeD
 KPWam2t+/nznMTcIqAu5IgOrp+BVy9ZH+b+TyCn2iKHs9AD0rZC/HiVwVgI+C/OXx3Nldgsz2F0
 z3NCBhszCJEvM6ZPRTj3p+gm66iN3x/sygf9lVXmhdxCXeK8MDuhciKswz+riC7mdujEj4knR/W
 VpYJqcjTduWQaNkChzz3q9tRia8sA8MC+ZejSOUgFauOvVQQS9uZynPG2BvSnC9cxfxnQBfSaAL
 UExHU15Jshgv6nEHHK1Rn14ZHd2zExdEzEDU=
X-Received: by 2002:a5d:64c5:0:b0:48e:20ed:d5e7 with SMTP id
 ffacd0b85a97d-495897722d1mr8870381f8f.34.1794233131416; 
 Mon, 09 Nov 2026 06:05:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm11184750f8f.27.2026.11.09.06.05.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:05:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] arm/cpu: fix GIC v3 flag for a64fx
Date: Mon,  9 Nov 2026 14:05:19 +0000
Message-ID: <20261109140523.240161-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109140523.240161-1-peter.maydell@linaro.org>
References: <20261109140523.240161-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ferdinand Schober <schober@cs.fau.de>

The a64fx CPU model wrongfully set GIC bits in the
processor feature register (ID_AA64PFR0).

I traced this back to e31c70ac04001df5e540b79843834277e283fa71,
where A64FX got added.

This bit is supposed to get set conditionally in id_aa64pfr0_read,
depending on whether or not a gicv3 is present, from what I can tell.
Qemu picks gic-version=2 by default, while v3 gets advertised due to this flag.
Recent EDK2 firmware accesses ICC_SRE_EL2 in this case and crashes.

Clear the GIC field, as the other CPU models do.

Cc: qemu-stable@nongnu.org
Fixes: e31c70ac0400 ("target-arm: Add support for Fujitsu A64FX")
Signed-off-by: Ferdinand Schober <schober@cs.fau.de>
Message-id: 20261103145254.1543907-1-schober@cs.fau.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a6352e6307e..e46cdd31676 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -505,7 +505,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     SET_IDREG(isar, REVIDR, 0);
     cpu->ctr = 0x86668006;
     cpu->reset_sctlr = 0x30000180;
-    SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
+    /* No RAS Extensions, GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR0, 0x0000000100111111);
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408);
     SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000);
-- 
2.43.0


