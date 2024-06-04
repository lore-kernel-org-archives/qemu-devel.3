Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB70C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOJW-0005I1-56; Tue, 04 Jun 2024 03:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEOJP-0005D3-LU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:10:27 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEOJN-0000SQ-3k
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:10:27 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c19bba897bso3964889a91.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717485023; x=1718089823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GTd7iSqY+2K6omhWKf9ip5yUDCYSOtXHjx/sKNx+FFs=;
 b=Dfh9tRe+AiAXqw57l/8jx8CXbAOnrEbA41vMkpWSFaN5OqImauc3GIiQk97EYTjSsl
 C3kveBsySxd9qVv+En2kEnpLXrKoKf2BqhK2yWSp/O3OV8BgDVJ095GQpSlYfk/Q1KOt
 mO2RWtH3NHyskgagl+lH0TGE7nb3yWUBzbtrJg17dl6GArRwUpEnQN+o0Ja66On4mWwp
 i9q/f3hudU0IE8hd60RwI7ZtNkYhjaTH2NPHdiVPf23fMzsjy8EyAYdKmlncu2e7ZyF2
 oEEnDIv2G6F7jj07e9tWsUuQqWv732So73xpeVLv4foT3fPdlcTNtzNpBOBSNkCdFcXQ
 dVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485023; x=1718089823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GTd7iSqY+2K6omhWKf9ip5yUDCYSOtXHjx/sKNx+FFs=;
 b=gck7k/M947wH4PemqzRC5B/vdmzzq2fUwPipIoT5lGTvjXG8d5JeXpgOCFHVP923aQ
 WOWR9+blfTtADbqELJn8IofhUoGOiJ2pwYcUlUN84Xl/aIWwURMBs7BqH9/Scos7y8Z7
 Q0f+q6d+Qz+iuHQm1pxaSeosc3La6d4WQ9cgCBXoWifkbhdczZLoD+5w7mfHVIGheAmy
 7IE7QY8/Bi6dnuyVlUAXHnUbZAV4SZl2ndSdwnc+aL68bQg16mlwWU0q0rxKSrYhFMv2
 8aUXVRkC33MI/nPbHhDhl6vEVqYTZtabZ3Dt23YUsMxETxc+ZVOczeI5hZlf3hXmlmju
 siJA==
X-Gm-Message-State: AOJu0YzCN7Le8Pz15F8wvU2Xg4Gl7utjHdaN17o/M9OFXR2ame2pFyGP
 lrWQfTbJo9ztqIwn2M7oEaWtkuWOVngSzZ0I8eMSMi7tmizHRN2YtZQaLjNv/FB3dVNt5yChk5z
 hPouN8EK/eSUvT6wTfB25UAZpvmjOHb9ppjDjntZMdi5bJhFhax+gpCPc+nAM2z4M/FVuMuIbEB
 nLiOCNfV/qzLBNq+ev7JL6sa3FNzNogVLqZH0=
X-Google-Smtp-Source: AGHT+IEc8YChFGXhtlTncs1wQaNEk8JezE0ddEBEFVt1gXzSX++KyXecYneCLrVrXjtA5uyLz1ACLw==
X-Received: by 2002:a17:90a:db42:b0:2b4:fe80:1b1b with SMTP id
 98e67ed59e1d1-2c1dc5cd183mr8783856a91.43.1717485022768; 
 Tue, 04 Jun 2024 00:10:22 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775d68dsm9237943a91.6.2024.06.04.00.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:10:22 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v2 0/3] hw/dma: Add error handling for loading descriptions
 failing
Date: Tue,  4 Jun 2024 15:15:37 +0800
Message-Id: <20240604071540.18138-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=fea.wang@sifive.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The original code assumes that memory transmission is always successful,
but in some cases, it gets bus-error.

Add error handling for DMA reading description failures. Do some
reasonable settings, and return the corrected transmission size.
Finally, return the error status.

* Add DMASR_DECERR case
* Squash the two commits to one

base-commit: 915758c537b5fe09575291f4acd87e2d377a93de


[v1]
base-commit: 1806da76cb81088ea026ca3441551782b850e393

Fea.Wang (3):
  hw/dma: Enhance error handling in loading description
  hw/dma: Add a trace log for a description loading failure
  hw/net: Fix the transmission return size

 hw/dma/trace-events     |  3 +++
 hw/dma/xilinx_axidma.c  | 33 +++++++++++++++++++++++++++++----
 hw/net/xilinx_axienet.c |  2 +-
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.34.1


