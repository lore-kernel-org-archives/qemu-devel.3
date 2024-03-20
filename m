Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7201ACD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqM6-00067X-2V; Wed, 20 Mar 2024 03:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rmqM4-00067B-Ey
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:27:20 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rmqM2-0003e5-C8
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:27:20 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e88e4c8500so169155b3a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 00:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710919636; x=1711524436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vHmP197HNIY43njjRMMv051Cf2V1bu6JAqTExjVI5cw=;
 b=mupIP5EfPFGk8bVIAZk6oXT9sGiPbv4pkQVMzxPT3aHylqCEULQPzK1glP9J/i1fEA
 Mu5nITiMpEr/dcKr74jUMsAzVLyBbwE+zbIzzAKNlIVQYHkgEhmRfi+TaR6dN++Y4Arn
 nPKAIMAyVUTdQRmAoW+7BTIzGeN1iGi64cTQPzSa+5JaCqqJGnKINprZD36O867XbHDC
 KUNO35uYg6v3xlLqd/etKQppGRlHHzuKx62KiOBUsZ9C8+KuambDzMUKrSh93gUJ3uPP
 3Wf7+Kn0RyTan9wSNrx9TO+8BvyX0URW3emKD91KA8/n7o2jNcMxw+ZocmYEokSc7ioX
 jGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710919636; x=1711524436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHmP197HNIY43njjRMMv051Cf2V1bu6JAqTExjVI5cw=;
 b=RPRXnXP/BGpofBTcivHoefcn2NVwpMb59UGtn/MG8hoLeiUqirGMzOSGtDggnumzXJ
 NWc+o2OuoVQGabTjabdCZAA/96zQjzOV92GXJgHGsl3DVjJut+De5RSQpFCOeCMGwHmy
 tWKUzJsytr+O2TAljG/hhfDRfkxLwfivZyXZlPP1Wjj/Wt6F8SL9/In3AoWqVOYz+6+8
 /14ayehOcuOVYi4jm5jp/hwit+mhr0QG3tWyHwygg23X94Ffjsk1bn+Iqo4UYnnuSpKQ
 wsXLCCc6XKaRJOGCwmxsl3ywmEFqlGMMzEMvuJ3EXTA2ZFz+/uN5SLCfZy1QcT7F3oP/
 RZmw==
X-Gm-Message-State: AOJu0YzvAiTdBrvGj8/FVCOmUGI83CSLQUQ+f9nG3cvYjwJnUF8eky8V
 xQ/zfjGumDm/UKyDJt6gWxP21QSpuyZUQltuJGhSGT1EPkGqTmJ2fEK+wDHDseUbpUlS0dA03h4
 WjDC1x031PmVE9R4KrlWaxAFm9gJ7Us459WEZnJgikMtyvf7nZXPiQ62C5esEsCl5WtR+B4BVZn
 mI6/45nn1Qa7zEO4Zu+nMQ6A2CnDYFqqu0/NyvzA==
X-Google-Smtp-Source: AGHT+IEu68aIIGO6UyBjDjtgpbXPheSht3HfQqeee0ji6Q+t1n6IItDl04/OuAu3DffM/B8bfT4ISQ==
X-Received: by 2002:a05:6a21:2d84:b0:1a3:7ca4:e3bf with SMTP id
 ty4-20020a056a212d8400b001a37ca4e3bfmr2448892pzb.20.1710919635730; 
 Wed, 20 Mar 2024 00:27:15 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 p10-20020a056a000a0a00b006e6b45debe8sm10811376pfh.78.2024.03.20.00.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 00:27:15 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>
Subject: [PATCH] Fix fp16 checking in vector fp widen/narrow instructions
Date: Wed, 20 Mar 2024 15:25:01 +0800
Message-Id: <20240320072709.1043227-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When SEW is 16, we need to check whether the Zvfhmin is enabled for the
single width operator for vector floating point widen/narrow
instructions. 

The commits in this patchset fix the single width operator checking and
remove the redudant SEW checking for vector floating point widen/narrow
instructions.

Max Chou (4):
  target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v and
    vfncvt.f.f.w instructions
  target/riscv: rvv: Check single width operator for vector fp widen
    instructions
  target/riscv: rvv: Check single width operator for vfncvt.rod.f.f.w
  target/riscv: rvv: Remove redudant SEW checking for vector fp
    narrow/widen instructions

 target/riscv/insn_trans/trans_rvv.c.inc | 42 ++++++++++++++++---------
 1 file changed, 28 insertions(+), 14 deletions(-)

-- 
2.31.1


