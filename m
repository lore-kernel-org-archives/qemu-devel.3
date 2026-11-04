Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B596086B9E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=O2wRVHmS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgt9-0002mq-Gs; Wed, 04 Nov 2026 14:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsq-0002Rr-E5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:57 -0500
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgso-0002Rh-Tx
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:56 -0500
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-33fb4680717so1919911eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821373; x=1794426173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=egO2OJef4ZNU2KrVZAHkDjhpGUTTfDSJpXL1CWafa5o=;
 b=O2wRVHmSK13bmF/ogfmYUjLD/Ju2xd2QtbwiHDU7a2uNWdqZKXeo3zTqIR1tde+BR1
 hEs4CFqdZhhuXOhyVH69NEM+x/JYs/PBmMnVlJ2wo6m/f6iaQR8q0ZkOcrMJCOJym9R+
 +QZ8jvhkP/kBM+GJ+tBVWj4KtprLHTbNvQ3gxkoVfMw8q0U+DfjdyfwBHa/XfpAtQZPH
 exg+2WUklogJbFdxMFAke6+6g6IpxICN3Kq21s7ZOQ+BbJKrOf+a9VkWZHPXEGI8xyYV
 IYyO12x6NnFwj8RJAezyLDmVProyN5R7hzdO6Az+cAx1NbWI6MnSeKnDJbiN4wxQqQDG
 5xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821373; x=1794426173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=egO2OJef4ZNU2KrVZAHkDjhpGUTTfDSJpXL1CWafa5o=;
 b=TdwC+xd7Xsl61XuZqLQeq8naJYF4tZAMN+5d0hD1RJuFZr8qN0raLmydexqVLnXBtG
 ZKOHfSVYgI1JpKeftFM6MeKagGPqcyBIrtpCVrxqfvciTy0eyEaW4h+mLaPkiPBMj+ww
 Ib9xpI8HtkbRcKXtcId8EGb2xUBAyWje439+4LE/3NHQL8VprapsaPoEEoGksaoDR3Cq
 0O+Dq5qyW3Unyjku1on1je88Dt/2ETnh0xk3S0PuCz9SAVS8rQ0T7FI6qweTBdm65T17
 gj+FxJeLlFHLZqFPSyt5F1hmzfTbEoKhxfwj9e+4fFxYxBDV5IMLKIz7SYvcml5CNCjV
 F0Sg==
X-Gm-Message-State: APuU4Z/8zC7/DDFsbQxi/NMBjgHG4mYScXm9bRSiiCBSKIpIxwJkKMus
 nO1zlsnGSm8R/rV5Xv83fGILE8VsIz3QzHsRh1AfIh5a7i/w9Oq+BWNYtEKcy54osnQ13eu3iCx
 Z00AHJH/8CBJM9copOCjH32vLMqoA3eaygehQw2eXbrEWBq+/rmZFXZvquZsZE4dYD4V412Anh/
 k6vQbTRF2UfUSFEytlKphzR2D/5sUOFmAR0hJik2HB7A==
X-Gm-Gg: AYBFou3cIINdMy72Fexp5EH/tJbG/A1YoZH5ZrsOyEtAseLTlrow/IHu+x6QkQKu9UH
 wSR1g5cFTVL0WDxtvo8NDOnrUzbDGVtfL5sh239vN4hoNCRs4/Jv8LBbTJd/AUdVL79B2NO8mkM
 30MIsMkR1UMPNfKK1NHLkCWYOKzJ+YDrV1c8JIfxzMnsIfB0iq/r01Wm/UgolCg4U0bGixNZYYT
 AH3XaSVQoxpVs6Xo2wkmj3kU6a/Af5jN6IdEO0RCvhB2Pu40tKxbOymvH1kF9duZDqdDqKf4fil
 gqEOI9YUabkoV4au6Ayk4F/kecXhibZoq0sbSxV9Q4B2jj4jKcHesOpBYpip28B0iIpEFmS7qNP
 18CEOQio3w8Krm55SPelScZIbDJVZj2rPWrdZCZNUE+oV926BOhQTNsuCidiucz+Gri++VfBTQ+
 Qygpw1/DlHiFrsiJPO3t864OOue//s57bLfzK1aB7o7KRPkAj0fRh0Bz40xpp0WR5+DEhBzEuhT
 oq40jaUIkYpovZvuTjuGieFedOb+CgSdu0Zq0wShK1p+ykclDdmHWWrrx3zSfF35hci/fub8h5i
 GX+nz61LBhFUoCNzdH1s3ckbsZNYvo63/teLZigs7rAR8RRfwHYh505TFcJklCbtmmSH/cDqU9Y
 uEto/jeAcKeNa/m6BwtG/NATKMkrLGw==
X-Received: by 2002:a05:7300:4353:b0:369:fc93:eda5 with SMTP id
 5a478bee46e88-36a42434630mr36437488eec.39.1793821372727; 
 Wed, 04 Nov 2026 11:42:52 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:52 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 12/38] target/riscv: Add implied rules for Zvfwdota16bf
 extension
Date: Thu,  5 Nov 2026 03:41:27 +0800
Message-ID: <20261104194155.679241-13-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add implied rules to enable the implied extensions of Zvfwdota16bf
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d6e2b07c401..2d905a99d68 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2873,6 +2873,15 @@ static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfwdota16bf),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvkn),
     .implied_multi_exts = {
@@ -3070,6 +3079,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED,
     &ZVFHMIN_IMPLIED,
+    &ZVFWDOTA16BF_IMPLIED,
     &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED,
     &ZVKNG_IMPLIED,
-- 
2.56.0


