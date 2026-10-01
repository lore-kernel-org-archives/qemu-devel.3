Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BB7CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 03:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC7iA-0001pa-Hh; Wed, 30 Sep 2026 23:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xC6Rz-000627-D2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 22:23:11 -0400
Received: from mail-pj2-x2b.google.com ([2607:f8b0:4864:39::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xC6Rx-0002Pg-SJ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 22:23:11 -0400
Received: by mail-pj2-x2b.google.com with SMTP id
 d9443c01a7336-2e2d2bbcab2so9326345ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 19:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790821387; x=1791426187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=25/d1dCfiKxBdZddH9o9DF4FktZi+IUyeXrIT2DnE6o=;
 b=VLpMtR8i1T8+M6b5ewBvXKFpM3+fobl5e2tdTPG10gBW1zfO0EImoVQ4oFrP8Nyx/E
 Jsm2H/CxFS5zqOnRVuDDN96npXg5hos7C42H9hXZNTjMKaANHTA8C3I9bGEBDM4k6WzY
 /1zZ/zaN5Xd6ZLr7+gLI7QjlxBfqEIMnwhiVQcCwPqAzlVFydM/bwop3clsu3PE/ThVu
 Y+ERcc2yDiGYh3A9lkFaRPQp8ePbkzSTY1Ds4qrQbflHeiSEFkDEo8nQqoCGhb15WWM4
 1F65tyt+bcc5X2JkLKss2NBDV95ExUI41LkiZHdOryAYJ3ObuRHMlyDRkJv9pifmEhkd
 gflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790821387; x=1791426187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=25/d1dCfiKxBdZddH9o9DF4FktZi+IUyeXrIT2DnE6o=;
 b=ABixtokSfV1p15gK+rHI6SrLeOR5lCimvVexVtZfAohDU0/lms2wKXICk2gg9Liias
 TMVZQjGBYKS1d0Xn1P7LLlOmGHj9Zj8xFWG5fLR0GY4yFGe0lR97hoH1MmUqmAmm3+uj
 vpThxpGcoGOUXnyyYk6v9NEuTzJonbRdE+mQtL1s36u80MiHpJQ+b32QoacZu1EUagaH
 nw9DSOMVahPeHix66spGl0fu3ZgEM/CaMKKbRZzsI5/eSk8zmFbZT7fheNGfC0veqJwl
 Poa2VkpA6nmLNinZ34UzPgXWlwqeCbVJD6HrWnXXasDIhSu4ol+7wBBoFZm96LTsDCC/
 0nlg==
X-Gm-Message-State: AFq9FYJVR/AWeOLN2dw618CFX1Bmelt4+RiL5widawcaJ0Vb5S0Kk44h
 dagSkxC6kCktcdYvd3+icf1mGet3Ssnf9HpdIE/f7jkowORULCiTrRNl+9RIfyQN2iA=
X-Gm-Gg: AYBFou1H25XYqT3bBYDV5FjAjEWxwtQtaYnZ5IJEmo5USJqu48qa+fUkmqS3dB/yybf
 hZlT6+xDZLzu/nv1xqkRalwzlcOSijV3gXS06Oz3bGYX+vk+x44yLjmK0PT3rjgF6p5IPuV8i52
 qavrH/t28pYOzFz9mhiGw50tzK6j3DgdtstOqcCPnpQzxQ1cn1ubbNkveNQGIASCN/M5ZOmp89m
 9hT7rvwfBKv4m3MzzkKKEr+z5urivSRw9TxxTA55NZt7D0e9zhfXDZQQ6j/GCxhsztQW59EnEpn
 D4kQG5/is2un5yP5MfEdEppSWmv2yBaGIyVlFzni6l2oOkYnk3yHnxUfWRYYzFMPFxnEVuGfrBk
 B9530bksiDMKFF9rAq385/0DLwFAM0lNNWNPgtiIUC/djyM7WpeU0clGoUp39JeZRtvp/AVe1NV
 VgKJQPs0faZbkM3lNU9WH3RZRlDWt5QI1fEZMXYlOBfktQLzRjGi8YD5MmCa/JzUs89eSfS6UAD
 DnzS0heOPepbBV6jLS+Js+EFjw=
X-Received: by 2002:a17:902:f712:b0:2dd:ad74:6d1d with SMTP id
 d9443c01a7336-2e2e4b8a668mr30239625ad.26.1790821387403; 
 Wed, 30 Sep 2026 19:23:07 -0700 (PDT)
Received: from dt-VM.localdomain ([175.152.37.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e300b8fd4csm3943635ad.80.2026.09.30.19.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:23:07 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Tao Ding <dingtao0430@163.com>
Subject: [PATCH 0/3] Fix integer handling issues in k230_gsdma and
 k230_decomp_gzip
Date: Thu,  1 Oct 2026 10:22:20 +0800
Message-ID: <20261001022223.8633-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2b;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Sep 2026 23:43:52 -0400
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

Hi, all

This series fixes integer overflow, truncation, and underflow issues
reported by Coverity in the K230 GZIP decompressor, its qtest, and GSDMA.
https://lore.kernel.org/qemu-devel/5fc57f49cea0ac3542128d0e2208edd6d7484f7e.camel@wdc.com/

Thanks

Tao Ding (3):
  hw/misc: fix k230_decomp_gzip integer handling issues
  qtest: fix k230_decomp_gzip test integer handling issues
  hw/dma: fix k230_gsdma integer handling issues

 hw/dma/k230_gsdma.c                 | 6 +++++-
 hw/misc/k230_decomp_gzip.c          | 6 +++---
 tests/qtest/k230-decomp-gzip-test.c | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)


base-commit: 0a1ebd448b38afaa118597cbb633dbec24ef74d3
-- 
2.43.0


