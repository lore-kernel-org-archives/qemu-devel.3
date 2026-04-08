Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C9A10F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYWP-0006j6-OA; Wed, 08 Apr 2026 15:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAY6y-0007Oh-ET
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:48 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAHnG-0006U5-7r
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:33:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b2494440f3so19623895ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 18:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775611997; x=1776216797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2PmDTemLx9BZhTY1nlMucO+h0NhE/77kvX20kSZB270=;
 b=Zh0ZGQhwvVjmBAdkpF/63M2u1q+jrzd7hGBDV9X4oXg+GH78ljLGxhYrJk4/B5VkER
 Crt+uIlCwSBCy1Tg2FN1PbLbkoyL1t+N+Pa0jy/1rK1+4SVaFBoVS6namzclD0l1qUbY
 4TG+A8R1TgRHXlazNK4E+vJN19gfTt7Be0r8mlMzz3DdGPJNXja5Kba1CG3fxBkpOrAI
 2fJOpk37beuzjbLqmOqNdSwlZ4hapHPMrmqi/8AGjW2t/m9yy7PNJZNa7gWyCwFXuKsa
 8hkskHftyxXorzYZGrXewOP+WWYTZGdMzyhAh+r5OzbnSxCnIIHSZjGzaAoXHQ5gOAz+
 DAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775611997; x=1776216797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PmDTemLx9BZhTY1nlMucO+h0NhE/77kvX20kSZB270=;
 b=XfESCCKXry23/iKb9PMl8LHVQaw8l+Q+OCagW7JcnCw4FcQqWUs/mTlvCYjQLYD++v
 jTikul+Qwvkho5g+DdYL4sS7Teb502+YDh7AQO0Os099zxorksMlhlp4IvS/B43zVz8m
 dsjygV5/HIBymPZgBK8dEd2Mrz2tY3KeefdWhLX+AiyKI6UNKp6JIgU8z3GrXclZpc4K
 dZ3SmPjX5xR5U2ovHHw4Be3DeMz2Cs2xUTokU3xMGbQXTZSZ2cqE9JWsHWu5OslF2ht/
 SMlPshnyd7p6QogCGwvwTvdw/fWP+65f615EdAoYWJPy/TPKt5gOB1qi8osLu4MiaoTp
 jHBw==
X-Gm-Message-State: AOJu0YwuUiNGOuqHXf9BGnXIYpDAuvL18XvQYbB7jlpQf2mbE7K2PUwH
 Lo0lZ6Rq6N8QDSo4dDM0dN58OG5nO1dFfkKK/iq00nrTRPVKafY/bVv5CcMYnU+1dn/ZLWK299V
 HdGyx5DE=
X-Gm-Gg: AeBDies3SHq6XL5sSxOKMH0gJ3NIVKlgP3reM5h1Y88bPuujQdmKLY++ZGGiOFi9U0V
 Pf2P64mCCx2P/EUB+qsIR9P91MtJOr0BwsUTf79GW0Ekcf07CIN0rlXBgxaVnQN5LQ5uKpnQSZt
 Bb2gT3L8erjzLGfl79s4Su6D56rIEiKvsUTBY2KeNOShfROyb9x6FTCRaUSFd8Ezrz2AGMyeu8E
 pfXi65pezKM/nbHMZU4AbbiPbGBlG+YJ4pK7CO9V/RcjHkjjT55ph06PyeoOotPCgJpuSR/Zjwa
 mn6gaABL9zpdEJ1jp6grNw0/k0NYHUReWS+s5qYcubiGaZOso1sz0ECE7HAkERHV+FG+nrt4mLP
 jiSOJgQMeuH9yuB4H/dxr2Q3v7upZCPvSeYrysDjdaav5dHNxDIwckIwFH4ffVTfcQklNena5d6
 IkGVuzt9GRMW+I+QcMRhEAkwJUEFMX3f+Qi1ep8ytOXt6xYhIn/O471Tic
X-Received: by 2002:a17:903:2ed0:b0:2b2:5091:1c26 with SMTP id
 d9443c01a7336-2b2816d8626mr213112325ad.22.1775611996003; 
 Tue, 07 Apr 2026 18:33:16 -0700 (PDT)
Received: from stoup.. (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2745c480dsm238277395ad.0.2026.04.07.18.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 18:33:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 0/2] target/arm: Remove bswap_code
Date: Wed,  8 Apr 2026 11:33:07 +1000
Message-ID: <20260408013309.56122-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Based-on: 20260407222208.271838-1-pierrick.bouvier@linaro.org
("[PATCH v11 00/21] target/arm: single-binary")

Eliminate the last usage of bswap_code, fix a little bug,
and drop the now unused function.


r~


Richard Henderson (2):
  linux-user/arm: Improve get_user_code_u32 and usage
  target/arm: Remove bswap_code

 target/arm/cpu.h          | 16 ----------
 linux-user/arm/cpu_loop.c | 64 ++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.43.0


