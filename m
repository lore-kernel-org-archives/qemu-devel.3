Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE750F5140F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPLc-0003Gd-En; Fri, 06 Mar 2026 02:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLT-0003Ex-6x
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:36 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLR-0007m4-LK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:34 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82989744ee0so1424225b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 23:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772781092; x=1773385892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTk7Tk9WP/zMZlQp66wDxav6fYDPL0KXwlM2E2GIdnc=;
 b=UbNiPRP0eSKeCqGXrIv6dpalKn9Z39hemBXPBWHz1bW5W0Gita7pbdoY/v5tLzIrFj
 OX4DAXknHI2kNOO++TOb7ysE7EiUN4Jt/um8C6/qe6b/304prolFwkMmlNKzvS7do9e8
 RYEVwfTe9LlMSPb/bUEDlnwmp4Iqws7lSJf+qsWR6RLTM8tC9QB79zMF4kg7dKt6Qfst
 O2MJyJgzyysXivGJzK/XqRLLcVtQ80KvUTWullCe5lp6ovqT0boOOs51cRfW0CW4YTa+
 h6QKOwaPUX6+X1Gns/UKYSCFW+MV8uKNJ2YhSlK31WoYi9L5qo74dFUdtWM66Libcupi
 ZTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772781092; x=1773385892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bTk7Tk9WP/zMZlQp66wDxav6fYDPL0KXwlM2E2GIdnc=;
 b=kVgE6vGYTKSwUpVheiDTTJxP1jHbwtWljaXS5JXpgXEvt8uzaw1SM3S9v8DxsOTrq5
 JLoaYfR2ZxgxGpVbSrSu5lU+nBYcTfeVDKnu7imszbISwDnSejaFSa35jFdQ+fmVun0s
 lINBqGJusnuaRxFzroZhbvcsVtwZBP6hb4sdhHNk+0g7pURgMSkUkuioD3ErxcQbzfOv
 jI+V/F+A4wroFKSMLNs/U17SnC3hPlQRNP/PrmDAInVbDUKdbgmO7xfddvPR/LV8RtxQ
 1ICy7lihODenzw2/ftgmGs+18oFyzZyhkXgjg2zRqt1nlG7bbSakr1AvUpuYnRZ2HGOA
 IFvg==
X-Gm-Message-State: AOJu0YwL5FySjxiLOFpAXujg9tJQ1tswr1Q70Katom59pLdv2rWJ74bV
 Fvsivv2ZCJPUvhPZ3cX24rc36z4apT5y7nBrKZwXQU/XdgpvL/jWGUPCoRM9Vzqgumdy0akYkks
 9cIY2zBQzMy0DnUEjyabIwDxDEJdE164Ne5+fnZcUVjcyj7WNuzFcUoZTyr0Fwc1xB8uZ9EHkGD
 2xUmHYdxyYUB+g6cLvDOb+sERtLlXBXZM+ZUu4060OguXb
X-Gm-Gg: ATEYQzyMtKM7ND8eXYrUYkgLqe8g4H/T7iBvyuJ12grbDs68q6++egIuvf2FbaXBWe4
 QrNshHqlvunk+QC2pfoAIOyvFMdDqlqt1F++Ynxk2quVFbXh7LslupoEiri0+jfcx10LNu0SqtQ
 JEuijndVuOpTVOtXQsufrZDhelUibgTpY5CmKF5aMTmg/dsfM8kmOLCPjcq0srYHBCDD0Zhju8L
 orblKKcGC3qPYVZDUizw/zVfYtmWzfYpXi0Ug1S4t3GHt7ucaba9GOkImdnpc7VfDVh+CJFxO6h
 9+xyaz3fyXzETrlVh/9todezmu+QdMBJWj73lgXfZlAKHmIJcjXK/lokKxkb1rw1JPafeObgY/a
 BGjaJYjlFjmtr5thYvDq0wi0ELeOic1hjurjL2EJYA1eLX6KzAef2Qw7AIrYl3x0bP9Lb50EnbZ
 n5QJXmd/5kGDSeL6QRh8Eh4vxS/XUWs35P7ZN7zTFuXcuRqb+Hm2izRPYTFt2d+bXWLpuQW5kle
 TdQkwzhk65u6UkMzjRGe0NlBsl7NVfonqrQVA==
X-Received: by 2002:a05:6a00:249b:b0:827:3e19:574a with SMTP id
 d2e1a72fcca58-829a2f14307mr949536b3a.42.1772781091994; 
 Thu, 05 Mar 2026 23:11:31 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4636c74sm956093b3a.12.2026.03.05.23.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 23:11:31 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 9/9] target/riscv: Expose Zvfbfa extension as an
 experimental cpu property
Date: Fri,  6 Mar 2026 15:11:04 +0800
Message-ID: <20260306071105.3328365-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306071105.3328365-1-max.chou@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 376517755e..73cfcbdf6f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1379,6 +1379,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
 
     { },
 };
-- 
2.52.0


