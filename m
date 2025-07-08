Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FFDC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFKN-0003cj-B6; Tue, 08 Jul 2025 16:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZESt-0007k2-Pk
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:59:00 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZESr-0002lt-UO
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:58:55 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-60c6fea6742so9941574a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752004732; x=1752609532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3HsYTLj5EGS3LIX+JzyfOQ8PUo130XOAvWfkSjLItdQ=;
 b=F27+2sn4kDlv1DDXbe5JInZeZjtr5hBt64PE/HyydP5yV7pxpprZZ07pfzMG8jQqyx
 /2sIT89UU88hya8otOALGxsVryRm/63UGvFzukttiUP28o691byyJbTg5MVEitLhBOeB
 /A8Uk2fO9lQ8UHMXaT7i8wq4vtx0lFlSp5B6iCDgPw6/hIgxqmAAS7R+rZAJTCx6CzBX
 lRlCbIDU/Sjp80c/cudc47fZww1aPHvih/58uNTBE602k+4NC9QbbWVe92KTWW9fLg8r
 rWDhWv9sa5qOEH2mqLMTjmZXV95BFoPYMrqYJnjJOrI7X6B+27S37+lwAHiiL3oQYQBA
 B+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752004732; x=1752609532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HsYTLj5EGS3LIX+JzyfOQ8PUo130XOAvWfkSjLItdQ=;
 b=WcUy5zqf7BCswvRnA8GGcZ6YMk/qaTyV0gkHiufkod5wSCYKn5/KSPylkW3FPHDVJx
 8bHd70HAurB0FKxbvM6mdEsFX+6YiMZ90APvhvZ93TMwFa1tDwAHy6CAY7EI8Up8Jhr8
 GtmYFFvV6P7vJqJodlOP+6hFgsDQGK6JDPOl0Z8s9KDIjA623yefFf+pmKeM9UoBCmiQ
 LKjeHKURhOT2gLhMfUlexd7OvUDX+fzEVJQ9/yLO1uLJSLMF1I5/JKi9fFeRRJfRO5rx
 469XhEk3DRmOVY3hCgqwbFH13MAdkq27Z6GQ8uNoXnEr9PVdUC//qSPUTI8q9K79+J7a
 Cp/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMAoPZXYPPrCcg7vvuYKJrhGxtGi4hB0XzcfzUEeWqmcjHiKm1nl41cSNkDyTXbVW18qDs4i37vmrQ@nongnu.org
X-Gm-Message-State: AOJu0YyvAtAZv+H6rISPjWS7YHRTc5rOFMqEBBLsaPrgu7boiKlB4kad
 Gb6Ew4JlBcg5YYqn40kSFEMRpNw1VcN1tV5JeiBB2PKPINDEzj0y/Zzr4G3d80zdmExl75x0RpL
 UQqz9
X-Gm-Gg: ASbGncuDMhZjInI34igbSsl7T9yt6jX7omMELT8iZksr3fejaP6lEnHAzgk0yOhUyxk
 NNKOlI9F18lGLIXtkO9eO+ridvjmeCjYeDlqz3RUccMrM2ned/jk8+TUKU/dfip1VcefqUQiXkQ
 AVXH/q5I15zQdS2dN29cO+iuwCWC3kofv7awGDanq4U9l+MYbEvTeYnvsyBMCKZN8jmGcBrPdd5
 pfW0h3JH44/Xu3v+8QN9ICpsIYdAhs3jWNwfvQpyCMKekbml8jY+diKHTFRVBI4jnryZNr5a6Bi
 REXouLf0wTIo3fzEzoQAv6XKWbdUmzBPCMv1sFehB8+FZsHWsqd93ZhwhNWpxitoBVEB
X-Google-Smtp-Source: AGHT+IH7zJde7I8fbcPdzlEJEgC+vFaRV9u7yJkZcHsXc+sVNVghZbtval3q9/JwE3wy5rU8Hts/jQ==
X-Received: by 2002:a05:600c:64ca:b0:453:9317:8aa0 with SMTP id
 5b1f17b1804b1-454ccce358emr27822845e9.32.1751975561259; 
 Tue, 08 Jul 2025 04:52:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd4a68ebsm19731255e9.39.2025.07.08.04.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:52:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 0/3] hw/intc: handle GICD_TYPER2 for KVM GICv3
Date: Tue,  8 Jul 2025 12:52:35 +0100
Message-ID: <20250708115238.667050-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

The GICD_TYPER2 GICv3 distributor register is one that is added
for GICv4.1; previously this was architected as a RES0 location.
Our TCG GIC doesn't implement GICv4.1, but for KVM the kernel
might support it.

This patchset:
 * makes GICD_TYPER0 reads not trigger a bad-read trace
   event on the TCG GICv3, for the benefit of GICv4.1-aware
   guest code
 * migrates the GICD_TYPER2 register value on a KVM GIC,
   so that a mismatch between source and destination
   can be caught by the destination kernel

Note that I have only very lightly tested this, on a
host which (I believe) doesn't have a GICv4.1.

Changes v1->v2:
 * fix comment missing bracket
 * fix reset handling so this works on GICv4.1 hosts
 * move get/put code to be with the other GICD regs
 * new patch 3 to drop a barely-used debug printf macro

thanks
-- PMM

Peter Maydell (3):
  hw/intc/arm_gicv3_dist: Implement GICD_TYPER2 as 0
  hw/intc/arm_gicv3_kvm: Migrate GICD_TYPER2
  hw/intc/arm_gicv3_kvm: Drop DPRINTF macro

 hw/intc/gicv3_internal.h           |  1 +
 include/hw/intc/arm_gicv3_common.h |  6 +++++
 hw/intc/arm_gicv3_common.c         | 24 +++++++++++++++++++
 hw/intc/arm_gicv3_dist.c           |  9 +++++++
 hw/intc/arm_gicv3_kvm.c            | 38 ++++++++++++++++++------------
 5 files changed, 63 insertions(+), 15 deletions(-)

-- 
2.43.0


