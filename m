Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BE606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Slm5PH+F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOu1a-0001Tp-93; Thu, 05 Nov 2026 04:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xOu1U-0001T7-DA
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:44:44 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xOu1R-0008Pp-0U
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:44:43 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so256951f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793871877; x=1794476677; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hMD+5cZf1lc0fXUnrJe8/OruuWHi0aOyw6bbqJ8NCbo=;
 b=Slm5PH+F3dnca07k/EUzSGJSSwpaI0d4PrGbK1iR7UXWoqL92sW+A/Rq5pz7IFvaER
 DGmrkAUatxInWWhjm731wqjCGulfcXFiQW6astu8cHxA9RiKQxb/ot2YzxaW3g0+nJbr
 RZAmLZmsMIZVSPcLrV8RZjO7a3/OlW1H4tOXTcxYTinLVjLUgvnAawIOudqQfbQWMeGU
 49Y198k1+6yB+jNewUszMk2TfU5QQMagD4fJTXtIoKmyeJlQl6V/ybyUyy22yuChut/j
 VRUuldCjCJP+mjc8WLOEccD04pC0adWl7++z+rVHMI4RqRnDYNx0sC539xNC9uWXSjpv
 F9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793871877; x=1794476677;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hMD+5cZf1lc0fXUnrJe8/OruuWHi0aOyw6bbqJ8NCbo=;
 b=S1S228O80HwnHudCyLJqoZuhWVxLRAO1YWa0/WjBUzryLss63wJk4yF0jpAm407O1W
 FKys0VNV0ywVWyhZ193ABYWAgLmRO/u5OqMv6d219lmbpnncyfIfF8vJc4Ftg+4EGFAv
 42Gr7lf+8RhQNG6NLmE73wCk/bEa2wFQAKHT1jV7LKxipwtP+VlXa+g32I5Ge+FnSNSZ
 VKVMbtbZpjBDKxb7YHdlIt7CGAxjXTFPjA4OYHZpdJdLr5pdO6dD9o7BVKpfh7DJ9Z5a
 E13PZHwLJokBpL1a/5X9kTZlDjwZgNIkB71GYJVdplUEulztrK8quNNPEIJHybR12VEv
 JyLA==
X-Gm-Message-State: APuU4Z+QO4cz2B0wHO8EkvG/9Jpgm4Mzh0BFUBLTUWGqDxjCUG+CwkHE
 wyxtvbnYlVFH+j2RbHxIGt8Bq5ZLDKFer6tOa5OLY78dG9I0eE2CIdvkRkVjI1nQ4Uw=
X-Gm-Gg: AYBFou0ePJhC3xY8tP9bn3vRF5vI7hrPEOuBRYBjcQAZbzZvoRc1t9uq2q2TiyqlGXm
 S8DSPyDKe86dyNNX7Pct1XRTss8s8OAz6KHr+n8H6b4GRgiUzPTKMOCTqwxQejCenvMI1MSdXtj
 wTIabC/pThuvey/85tk9S7/7PzfewmK+QjwCwJkKdXVqvT9lWiaKfw5jr01TwOxiV2HpZW8HJzZ
 cZ4ZEnO4oDEcnRbNXJ43uwiqKl8/wHv5PyAf458uwhzH/fxiGaHrNlHNMzg8KBAMsHoWBbBNlOU
 JOalhnDesE0O8sYFb8jHa9mZ1D6pYXNqRz/P1oTKN1+aUGnA0nlWrK350GiPe0z5045elgkUfZ7
 auHQyndi/Ppj8JpMeqDRmHNc4wLDoxp48teMvqmXJOElX/G/4zdU6Ur4RJVTL1+TkYVw56cq9hs
 aYQVr4R2JQVnMfbWgN0DkoxMcFxk8OszpzRKx5fPAQ65Y5IWEwJrG1Q/RXgTYnDNO7In9TJP3sh
 ggfZLi0/N+UTyYuepJ1IJnHXW59c2VyoKxsOYMVViNRrnCd/5QJxAOg5mhpKLGuIQJCvP2/xP5g
 jiA+JOcxv6dgM40D2nwCB/7gndMnb8se8cKDjCGqeWwqkA9sr6OZYveriG0ehGGYGS+ZXvMP0Ep
 WaoY3I+MqrDIvROlSmyyy3x/3nSa8h9y0MzN/gWvUmbqAcsPdA34/NILyKJE+uj/bDuGIU+dKOq
 o7pEBNNEQYIw/s8ZkFFowpY9ouxwCLAXBAWkUwljbjMuVIGy9P
X-Received: by 2002:a05:600c:c170:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4b55cf2fcfcmr33528285e9.7.1793871877441; 
 Thu, 05 Nov 2026 01:44:37 -0800 (PST)
Received: from satan.lan ([94.66.192.55]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56f5e65c8sm51500815e9.12.2026.11.05.01.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:44:37 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 05 Nov 2026 11:44:32 +0200
Subject: [PATCH] target/arm/ptw: check XN for ARMv6 in get_S1prot()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-armv6-xn-check-v1-1-fbeff926e692@linaro.org>
X-B4-Tracking: v=1; b=H4sIAP9P7GoC/x3MQQqAIBBA0avErBtQQYOuEi10nGqILBQiCO+et
 HyL/18onIULjN0LmW8pcqYG3XdAm08ro8RmMMo4rZVFn4/b4ZOQNqYdOcRo1UDe+gAtujIv8vz
 Daa71A9fshdVgAAAA
X-Change-ID: 20261105-armv6-xn-check-ebdd507ca5ab
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=CMQ/ElNoMou01q47s1nmPtmNWEwtljcd2wE57FrhP2U=;
 b=owEBbQKS/ZANAwAKAXcpx3B/fgnQAcsmYgBq7FAEXemRIWd7+U92DRkYMy0MshrFaVl7YkgXG
 KiNMcq4uu+JAjMEAAEKAB0WIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCauxQBAAKCRB3Kcdwf34J
 0HVMD/9s0kAZV/EQSu6Tq0n8A625xWQzwb+THOLOTWzignB08mCeFeIGj6TELkFkEmU9bTFTvdP
 1Ni8r+XFAYVpq3HKce74PofWRHDwYXBv3pToBds8D3JOxptU4Qkd56471HaesdcgGdLssKiAxiv
 DWda8mTlgr12w9nyLgVsX8ukRDqqefW/ZWRvQ4C8G+MgN7g1f6nZ7OFqDVgs6gY/nnyEhZnUKLI
 JSl+s840IrzNA3bsLWyfiJhpodc7+3cPRUbIo1xhS9NdGXiHrR5MpDr3Ub4QnQm01xMgFNrfyNo
 XPL34n/vv7/AI2ombVFekjr3C6VA6AvR8gQEbrzkxKj49r4VcYc6UuiM5aw8VO8hg5/z4lw9e9D
 Pc57XBXUWo9fwMNYDX2bLNY28lwnvAEYSFD0BXGyc7K+NkTICuXnLzcqwJl2ZAyK+D5B0C2kSob
 tMltfNscb1+0A80QJddneUEbfAJuCp2Sm3x1LanPo+pymsAFJSiReP1Mh9b+QnHfbGskYrh3ZI8
 XhjoSRyzLPxrVtjWRNBYE/6RpsBxO9xHk97lEMXxNeeHVuLA9QONlz4a0nIz9GSA6XdLxt+hKvE
 ff2ipF5WANuI49w+ormSf6GbtXryYprHjLsOtOXfNc3WfjzSzsuuYBJpwtAkrICIvGOfFvJ+YyL
 N51F70IGowAJvnQ==
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For the ARM_FEATURE_V6 case, it seems like we retrieve AP and XN bits in
get_phys_addr_v6() but we don't check the XN bit in get_S1prot().

Change the `if (arm_feature(env, ARM_FEATURE_V7))` check in get_S1prot()
to `if (arm_feature(env, ARM_FEATURE_V6))` since v7 implies v6.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4367
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2e67d02493bd463cfd2d31ecf1316272ac3f1d99..b8b22b014e0574340a85abe73f3d9611d2360219 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1595,7 +1595,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         if (regime_has_2_ranges(mmu_idx) && !is_user) {
             xn = pxn || (user_rw & PAGE_WRITE);
         }
-    } else if (arm_feature(env, ARM_FEATURE_V7)) {
+    } else if (arm_feature(env, ARM_FEATURE_V6)) {
         switch (regime_el(mmu_idx)) {
         case 1:
         case 3:

---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
change-id: 20261105-armv6-xn-check-ebdd507ca5ab

Best regards,
-- 
Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


