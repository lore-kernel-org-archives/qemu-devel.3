Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0F2CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfF4-00052k-Qw; Mon, 08 Jun 2026 15:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWfEY-0004Oj-EY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:02:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWfEV-000730-Nl
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:02:02 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c0c32f6ce1so31617105ad.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780945317; x=1781550117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aL/zGgGMRbrmeH7TvjWkcp9in2Xst6VrugdRc6i3AcE=;
 b=lohGjHVC96PIf5eJXzplirLU5mFReZ6MryiEqlYUTwQpZ5UA7zgVF1HBc/okPAH3dc
 j2Rdwnhz8fDy876KtGikYds7jPkUaNCG2nVLlB3hdHTs29OAPAcaATUTHlv1iePsncvQ
 vTerWbISNLXzloJ/NF5JpU7cZnPex1D/ncCtHfuTP/CaHji22GE7fhJl6cPmfuYtjqa9
 yONoLcP3mPiqqT1VfpOFl3IQnOzHTHewzZRNHQqT1DJJQ703UX0v7UKZFneV4XzTA+ha
 rr3iktiQhSPTpNQHyq3KIHSAhpuEsqTocwqZagTtF/u1cDU0g4tnrmKuCsDSMztDKmKb
 TBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945317; x=1781550117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aL/zGgGMRbrmeH7TvjWkcp9in2Xst6VrugdRc6i3AcE=;
 b=LuDtXTmlu5vbLrOc3gfQN/+jem7eJX5VvSFuahNOCqO/KYIM2MK1/1c69Ewi6DKzJa
 fqj08/kNYC5K6TYuVE9i9ZV/M+K/aYoMbvcMNznlG8lICp+Gy+BuNuoFDABmgDBkGfjI
 V7cjvi0pgNCpIuRJDBQdR11oXJgm+Gt+pEniOQ9p3u6s2OKJ4MEG1WL5Zdyd+un4CW9A
 ZB22SRKBAskDJYr5ObZ2P6jTxL6Cr7CyEhBlUlrEMWo0KQD0TKw0dPab/H5fsUqG082a
 Unv2UqoPgcUsoMLAFhvRZlcsg+q+9b2OstvK208nZ9TOIkIutbwnhFJ+/nOn1Yqz0s3m
 sL7g==
X-Gm-Message-State: AOJu0YxZotsEWoUYxBMTqxt8q2btYqSIx79SPWAMctC/gRV58KLhoOCv
 Oox6DAcBn8teD0DMVl9gKIGScyD0kq28MSLpG/5sDTPrdmrOtrtIPB70lnwkOvMjch0y8iILuO8
 x8ikFCyw=
X-Gm-Gg: Acq92OEK4JX8Ls+RVex8ljMltJ7qeelwuW07itXB9PWg+Lhda5KUNszN3Z3YX6KqySo
 lIZ21T+Y4Mfl1/t15d2kAzGXCutgdlRcxD92pQsZVLjS5iD/yvDLTfELu5/hCGlv9ZpY34byvu9
 jg+fUpPM3nR3dJxqI/Ug79prCYzN5AXfq7wkk6WUxQciA/JJQ265zQPUMg5FCjdS0IITT2llVIb
 /7PVbF8Sv+a260lrgltNjzmlIbt1DmPw65rCk1JUPPzGogy4SdUe5+9D1Yxg6XqCDb2oa/zjn/Q
 o+QlF6EB1rNsNONqNmPtk/NzQc0Kvu7uGFlBjxFHgTN9sdBH08U0Jd7xN2iwbI321dIC2RpQ9IA
 zvrC/ofC3XIVdcAi9fLA2H1eD2xl8Bt4CMAkw5vXGKTKvR/ACuZdSFYJTJIypoYvsA3S+PJR/fF
 /3A5+CnUOGY8kQY5y4V0t5lurC+XL2fyI1WgFxMaw=
X-Received: by 2002:a17:903:37d0:b0:2c2:5446:30f1 with SMTP id
 d9443c01a7336-2c2544635e2mr83067265ad.14.1780945317051; 
 Mon, 08 Jun 2026 12:01:57 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c24edbb49bsm60900875ad.38.2026.06.08.12.01.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:01:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] fpu: Handle all rounding modes in softfloat-parts.c.inc
Date: Mon,  8 Jun 2026 12:01:53 -0700
Message-ID: <20260608190155.637067-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Fix up some unusual rounding modes.

r~

Richard Henderson (2):
  fpu: Handle all rounding modes in partsN_uncanon_normal
  fpu: Handle all rounding modes in partsN_round_to_int_normal

 fpu/softfloat-parts.c.inc | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.43.0


