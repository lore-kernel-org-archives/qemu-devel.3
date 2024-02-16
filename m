Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44707C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rawOF-0006Rv-Et; Fri, 16 Feb 2024 06:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rawOC-0006R5-9T
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:28:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rawO8-0005pY-QO
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:28:19 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d944e8f367so18045805ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708082893; x=1708687693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rovsq2nfqJJdx+AvqY9mkBjuzC63inbVfu6PV0NEN7Q=;
 b=gN7nRMOIhMFyh+n7gdYD22ge4Mru1PJa2r/1qO/2NNTRwljkg3IkCgKDB4d90CXfaV
 jWoSHbC/+hHQ4yus+2b0iKbrOL47hvx81+YT+HeSBuE79trq+Wgu7Q21DDKHgTzYIzE+
 Eilb6jGkyj9WCEovJcGnozaVQJfcDk4Pv5y1rKLYxIAQZijGciILAzFlBSr+4CocpSkJ
 X09ANyVj+xZGh3Buxb4xdz0oNGE2MMCNxWnrPlfwOMKWYWsn29x69/sAx5Rv9FRMnrou
 UlX6+vn04WdwkIri7eR3a/lJCQVJGwFn65WIJTPcxqa9BMESfwFynpVzXscSwwLfMDNK
 G6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708082893; x=1708687693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rovsq2nfqJJdx+AvqY9mkBjuzC63inbVfu6PV0NEN7Q=;
 b=jE2CiOYa7JhOarGqG9SflqzWPzeZa3Uz1IiEdG5YUj1ZTspHDCSwN8CKpISyqZyLLw
 IwsKAySV0hcZzeNilar0KkZfrch7xwhvSgTVPB66bhXfUjPMYx0tN5o5+AszOOBKiXtI
 zegO/To+oMm/rIrobY5hb5TxIlnSFJzJ60WxjLYRJr2TpMvO568iBlpTvd7R87lfVvvd
 li8KqcKIX1MqyQ5jNG2rnnmjFmqSqVoofsaZrsDph+zj1yl0TQ9V26wpzQBS/sqHsmhx
 EcAnOjQ61HtW3eevuEBaHRllBGGZiTTttPGN7HWVjVMuTIVxo0kGrybKoA4RvEoTKPtG
 sfbg==
X-Gm-Message-State: AOJu0Yx5sTZoqttot09NTMkNnluaLpymyTBvBczmHs5JRqMXzDHbRkBn
 Z6xexeMoQLW7+L3uN3pTDO1Mpu8Ek1CHc0AZcjtQENaerEk1cmLvZmyP9FLUFrJi/371yNyG8qK
 c
X-Google-Smtp-Source: AGHT+IGGxpcZz1ThsPOxaoT+98/Y7UbfM4TAUX8rZ+54ItrgqNdrqU1+mWZn1VlhGW21vHrkYvqkcw==
X-Received: by 2002:a17:902:e54e:b0:1db:b69e:fb35 with SMTP id
 n14-20020a170902e54e00b001dbb69efb35mr214201plf.0.1708082893258; 
 Fri, 16 Feb 2024 03:28:13 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 z10-20020a1709028f8a00b001db7709b322sm2774053plo.298.2024.02.16.03.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 03:28:12 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/3] riscv: set vstart_eq_zero on mark_vs_dirty
Date: Fri, 16 Feb 2024 08:28:03 -0300
Message-ID: <20240216112806.997948-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

Hi,

This is my shot to fix https://gitlab.com/qemu-project/qemu/-/issues/1976.

First patch ensures that every vector instruction that changes the
vector state will call mark_vs_dirty(). Second patch is a trivial
simplification.

Third patch is where the bug is solved: check if 'vstart' is zeroed and
set vstart_eq_zero accordingly. 

Patches based on alistair/riscv-to-apply.next. It can also be fetched
here:

https://gitlab.com/danielhb/qemu/-/tree/vstart_bug1976_v1


Daniel Henrique Barboza (3):
  trans_rvv.c.inc: write CSRs must call mark_vs_dirty() too
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
  target/riscv/translate.c: set vstart_eq_zero in mark_vs_dirty()

 target/riscv/insn_trans/trans_rvv.c.inc | 28 +++++++------------------
 target/riscv/translate.c                | 22 +++++++++++++++++++
 2 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.43.0


