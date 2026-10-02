Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B72CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdqn-00043K-Uf; Fri, 02 Oct 2026 10:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdqm-00042x-9o
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:00 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdqk-00084Y-MN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:00 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747ec6188so38741075ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790949777; x=1791554577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Be871saR1XVOAkSBDix+tWYc58ahQYkpdPiioZWc30=;
 b=eD203e5rg08mHYrJBjSE/KAf6gwHmMEdEeVvzQTxvI7ek53ci2M3LjVTby+EMSLJHS
 Z/UuYi3NrNyqN1WOT7x1cplBjE7xtuc5TRmdfWXBXfcr9xU6e1HpaQG/ILTrV4fkntIp
 xxWw6kdBQnb1zIdWOt7AAD7kSyYjcUv0CvzVWbfPu8kUiFHgiCWcHurDDIptSzaKXPWE
 lzqbQuePrH+0RYNxd8ol/sUtnvN3HCbHYEWJXVTnvHawwJ/Gwn5x1ahqUzs9PXEtKV8u
 CYk/bgCaOYFQu2tTfk+8RHYCGmO2ripvjiDZm9YRrVL5EhXMdeQT4kV8FzsgAGbRhpeK
 dovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949777; x=1791554577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Be871saR1XVOAkSBDix+tWYc58ahQYkpdPiioZWc30=;
 b=MgM8a/bp5CNCppZETNAjh0/XzXaInHa+Eyu5BzNOyomFk8pxdNEHPH45VKWKyiW02s
 ylqSLO6izE37kKxnPPc4Pu1bX4eBCm/mBk19NjRCYsaRhchmYL+pjA+uN3wm42vs92SR
 RytDsmummeTLzqAlnw/Da/MpG3tjjhPgVlRGPT1yNaWYQXLWg4M8MREOUrPntDpNcnLq
 jaksJTs8poX+hYRDV5v8oQGNZWzLjvJxzFWQIYjTWM0C9L8XAVuGRBOQ31wdkd/CUtzP
 4JGJS5oQ5dFZRRRT8uMCWwnkZu5K5/4QTMku30TbS0XA5RC0gkK02NIxP14StYjFRQex
 ag4g==
X-Gm-Message-State: AFq9FYLDJfhGEwlUUhwuzuVPvuJa6zRN7znklzFnauPCyQ0t3kIcO5Ul
 0Ms0YRbE1KnmYqxc8CkCEs36Mxqo316XQcMC0kiHPs5kUGSv+tMGrtuj0C7kGNWI
X-Gm-Gg: AYBFou2X4kf8cwH3YIrDry+xUIF8My8XrtQdtlxFjH1kGUAouOzfHhP0V+6pZKhWiU6
 YYokDEyAtIl3yMIU17XfxP/gd0w4/uTQyNXMyYWyXcAQXd68ho3xJTzJgR87flRoecN2Gm8a+L1
 BOOIczDmtlK7myF/qlbKQ5mjERqyt6Q8qZ3Q++Gh971dDaEBEFmcF9izZ8zW95hV7fX/Op5Pz3l
 1l5keTyFFdLJVj3TxeZNegb151e8yGKMds5uiSrQlQY8ZTf88Sfzxvktv7sjz3w4PUTcrRvLSZh
 29CfNwNemGcJJLoO4LTaEDM3j1JJ7brwk8y2J0km5Wx73hj3Jh8DF2+Do4fholexT+F3qvtYX05
 yylsS/J3H3OOT/zu81NyW8WWzZVrkBaZvYUb5uUHVP/tS+R7aDnEZYCFD/zyuET6Ej9VL5UnKAb
 QwRsbAdUt/pIopJS+e4BjWbNnoCrtoRHGs1rE3nqlUVNmUPo5Y8bo5UYJgK6bKUP8ID2TdxSnlR
 bHq9LKdnWbz6EkV
X-Received: by 2002:a17:902:f685:b0:2df:89d3:1b6c with SMTP id
 d9443c01a7336-2e49a109cc7mr26730775ad.5.1790949777033; 
 Fri, 02 Oct 2026 07:02:57 -0700 (PDT)
Received: from dt-VM.localdomain ([101.207.27.235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f723a77sm7996165ad.71.2026.10.02.07.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:02:55 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 0/5] Fix integer handling issues in k230_gsdma and
 k230_decomp_gzip
Date: Fri,  2 Oct 2026 22:02:40 +0800
Message-ID: <20261002140245.30214-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi, all

This series fixes integer overflow, truncation, and underflow issues
reported by Coverity in the K230 GZIP decompressor, its qtest, and GSDMA.
https://lore.kernel.org/qemu-devel/5fc57f49cea0ac3542128d0e2208edd6d7484f7e.camel@wdc.com/

Thanks.

The patchv1 series is posted in:
https://lore.kernel.org/qemu-devel/20261001022223.8633-1-dingtao0430@163.com/T

Changes in v1->v2:
- Split the original k230_decomp_gzip patch into three patches, one for
  each integer handling issue.
- Remove the modifications "ch" in patchv1 3/3, which is now patchv2 5/5.

Tao Ding (5):
  hw/misc: fix calculating output address overflow in k230_decomp_gzip
  hw/misc: fix calculating input address overflow in k230_decomp_gzip
  hw/misc: use hwaddr for the k230_decomp_gzip input address
  qtest: fix k230_decomp_gzip test integer handling issues
  hw/dma: fix k230_gsdma integer handling issues

 hw/dma/k230_gsdma.c                 | 4 ++++
 hw/misc/k230_decomp_gzip.c          | 6 +++---
 tests/qtest/k230-decomp-gzip-test.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)


base-commit: 0a1ebd448b38afaa118597cbb633dbec24ef74d3
-- 
2.43.0


