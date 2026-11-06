Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E9606A336
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FzILv28S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPHBo-0006oS-SX; Fri, 06 Nov 2026 05:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xPHBn-0006o7-U1
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 05:28:56 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xPHBm-0003gf-2O
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 05:28:55 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso5147155e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 02:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793960931; x=1794565731; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KAxviWtuYTHpGEWf/8+F2NHLKC1IJZACgumU54qEog4=;
 b=FzILv28SEN+Q4yPkT8mT2hTzV7GRwuC1pQxNRgY7abElTB7sEG43iX2s1dXkXTYDev
 cZY7jhmRlIP+of9LgNp9RBsNaaHP0+FIxcBPHC2EeGmL8pgIIn84uBj4YShNEwIoxsTH
 SnKNK9rxcpUlwzpOPioovmGOwOHhbH1zcs1I0IcQ77c1lMhz50D9i+gKUMwn/a808DFY
 rE/h7r8A6xsVHIBZ1ppHc/z70IMMhua8/k3Lqv2OYq0bHVivofGCiRKN0bVf66Q+qwQF
 d7dW6BMXfQVVRejGEtj31Dt3fy8k3g+11zStzwn/KUNs7M9Q6baLhv/+Iagyxiz5lrjK
 EU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793960931; x=1794565731;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KAxviWtuYTHpGEWf/8+F2NHLKC1IJZACgumU54qEog4=;
 b=LlBeGRgaMUOIxd4scGSJSia/5+l2JCs5fCzOpgELHgaWVrDjBz9zAKqZZErnEAYh9i
 g53nh8ae2WOyaFaTNi5ryvnWmY1G4DOB1EiO1DXrskXzYC55z4zOp3QmfMNAV1rXJWsy
 F28otAq329tywFwYLinXYHIrfJFm+femcKNzdUXrabCeSTKabgwPlr3BPHRQz2RXb0eK
 MqZrZzU8ofYL3f6Dqjlh9240n8onrAg/Gwn39KMxINf5twl7T2FKiGnHQ1K0R8CjXqXu
 qrHEb+NGB8+HTFWYwke4kvXIU8ef64J6qkOLxm3axHE01b604wrbs5QzLbKbyjth0BpM
 obuA==
X-Gm-Message-State: APuU4Z9qv2XBChpQiT2eAY+ShPiw4TnTP8x0mGPRVEJ9jC56oWVG3Akt
 b3sCW2vb3AoA6L86qhRpVG2lwjhBjcYTd7P8bFsYZcu+cEzOKtqCM4FO5/qIEjoIzPk=
X-Gm-Gg: AYBFou38F8rgocmfj0UMrJ+26wEjXRWiEZ2E8luDATFN2NQSdBTbqoaKT18nKdiSpC7
 VfLI+Kq0jINiWFqSSkmPat4zX2GEwyiAqBdKIGF9mfaiAA2W9r2yJFwvneZeFy8y2y1IL0PVgSl
 i2bYsFeI/Rw0LALJGum2P+2Oo622WXbzKOupq8XLBRiflqOHGzhyfY3QhYtkqBNAqQe+lmrj8ZL
 oSPe0QGCDB4LBIbEigI/XuR2nHglQg7oktGmDyE/GVc6PGHo8aJf5646U5fWHph9vB0s01D1/gp
 0gB5jg9erlyPJi7oZqGjHkYlJE/loIIMAtaaP6gi+8c6XvfFZwoAVmD/eubcZKw2eY1mMJPfNcu
 IM9sTP98ZenztC5nSw/wYDWx0HRCCtuWN0dvdnsLvKDdJA64HNVCzizvNBLbXZfb9eSrGSc8iBP
 JGKoF00gZLXJJUi5MQhyRxjs4E/EXawY/ZRH6ebfyftRYAzsThh+/nh7Tu4V6YuxDdNvwaOSZ+q
 9mxjXzd6Pnq/75+m7Y2Zez99TYgzU9EQ/WvtVHvhAovkJiACF1Fiwipg0NtXWteJhIi4p1Q5p3P
 mjeIUcAARYcTtJOAwZ9LHg7bDIXdYA4z5HJOxUBa/sVrDpR2niPru+CvYbebxRLB8KxWZ2NnJ4v
 T141xS8+lCWmYFy9jBwDC/hcna1OWhdW+LoGKvM+Yg08dZG1aVvIZogpa2SijaZmdd5xcd+WYOq
 kFytgVdVj07WwbwkJPzj6O6vegxDehB7dRu8XluqDJG2zUYp2g
X-Received: by 2002:a05:600c:3e05:b0:4b5:2c72:651c with SMTP id
 5b1f17b1804b1-4b6dd54b67emr32476695e9.5.1793960931477; 
 Fri, 06 Nov 2026 02:28:51 -0800 (PST)
Received: from satan.lan ([94.66.192.55]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcc6sm235825535e9.2.2026.11.06.02.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 02:28:51 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 06 Nov 2026 12:28:49 +0200
Subject: [PATCH v2] target/arm/ptw: check XN for ARMv6 in get_S1prot()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-armv6-xn-check-v2-1-1291bb77a6c2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOCr7WoC/3XMQQrCMBCF4auUWTvSBBqpK+8hXSTppB3URCYlV
 Ervbuze5f/gfRtkEqYM12YDocKZU6yhTw342caJkMfaoFttlGo7tPIqBteIfib/QHLj2LUXbzv
 roJ7eQoHXA7wPtWfOS5LP4Rf1W/9SRaHC4CiEXhsyvb49OVpJ5yQTDPu+fwGKZlqwrQAAAA==
X-Change-ID: 20261105-armv6-xn-check-ebdd507ca5ab
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=brcLX+sBR0r1Owh/lnG6zBTtcsEn3ab5Y9R5N49j5lw=;
 b=owEBbQKS/ZANAwAKAXcpx3B/fgnQAcsmYgBq7aviHuxcJGnYF0R+3EHKJ+0+aIHGGAiDG+Tod
 Z5zL29bUYOJAjMEAAEKAB0WIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCau2r4gAKCRB3Kcdwf34J
 0KIaD/9jmrZA0hr8SDk7zNW4g9n+kqy1dohhr8hYPYxYFgl1UDWey21BLcrotrhSD76/lN0Yamy
 UlDOGPd3fItuiusXWiFFqH82xChcUyrWVRrmXaN4NYlM6tmXTyt43bdYGAZdG7YekkQa4arctrk
 DrmxcTpgbwjOCw+n85+67PuDFOACN070TozXPjd1cuoJFEtZzFpDY9vBzG0fV44wy+xzb1S4tBD
 luV6ivw5SHKOGezOG9Wo1/8NNyo56AuFSF6FxEZW+1BPuMmTpUouXLzWp9admvEDiyz5UEDS5NF
 cq3gtV9N9538cOoKB2FlVvAdxWzu2JWe7CfcDfVDjsw0fRgcv7Th48YQ2RVSkb981lC2e2f0bfo
 jTYbwK3h9kzaSsbqk7EnReutSq5aw0znfxvtH+sN+4rSDkKeOfVRBfNh1DktAd6owZC25uMkccG
 dKzKBl5dIcxF732tT82ZlkpAgvc1odE9R0j0Hni9I/q41zQSaBQscWqAxUdd2xBLcaww1BgBCVl
 wFliJR03urlBJFdaiw/082GwaZuqC3ugQAepcc5Rckwsuf9hydj/5Nl7PF81t/4l6mipWuV0z1P
 xZQX183kR7X32sga5h0q4zXPiiLd4IYrBzfJxd7Wfho0DImkL24iyHfOktRR6GdfSk4Et3bCLMw
 jGdGPqYYtsrjFcg==
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For the ARM_FEATURE_V6 case, it seems like we retrieve AP and XN bits in
get_phys_addr_v6() but we don't check the XN bit in get_S1prot().

Change the `else if (arm_feature(env, ARM_FEATURE_V7))` check in
get_S1prot() to plain `else`.

Fixes: d8e052b3876356 ("target-arm: get_phys_addr_lpae: more xn control")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4367
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
- Change else if to plain else (thanks Peter)
- Link to v1: https://lore.kernel.org/qemu-devel/20261105-armv6-xn-check-v1-1-fbeff926e692@linaro.org
---
 target/arm/ptw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2e67d02493bd463cfd2d31ecf1316272ac3f1d99..e36d2ff9383914d565af54a868943d705405d34c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1595,7 +1595,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         if (regime_has_2_ranges(mmu_idx) && !is_user) {
             xn = pxn || (user_rw & PAGE_WRITE);
         }
-    } else if (arm_feature(env, ARM_FEATURE_V7)) {
+    } else {
         switch (regime_el(mmu_idx)) {
         case 1:
         case 3:
@@ -1613,8 +1613,6 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         case 2:
             break;
         }
-    } else {
-        xn = wxn = 0;
     }
 
     if (xn || (wxn && (prot_rw & PAGE_WRITE))) {

---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
change-id: 20261105-armv6-xn-check-ebdd507ca5ab

Best regards,
-- 
Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


