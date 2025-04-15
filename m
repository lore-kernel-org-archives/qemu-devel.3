Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86344C369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bRL-00043o-J3; Tue, 15 Apr 2025 04:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQq-0001j1-Au
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:14:19 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQm-00023E-Ko
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:14:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2279915e06eso55495275ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704829; x=1745309629; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vQTsKrAn76+UasM8uqjd/nLkuCgMzLsX/xbV+gpdXKA=;
 b=Aev5kIMeBJjGbd9x5xnKZs6vbe9+zv8id7sa3gu5sI/5NtxkoqC56FNDWyb+rUkKHG
 CtaBBKTsSsQ2uvYtwKr6UdxLw87n3cWYuRpP+jAw+FE+xVfWorx5POi6xG4hkhDgC4L9
 y8dvJ94lcXkyr+ozF5vQ8USPwAgx3TXs3gWqFG7pPjYCmUA8zHtb2nGjPTF+Z+SCYJfA
 Vk95kQpxS8uajGpnpF4bB9XV0YoBL7mPM/9eFfLCpZ8BSzsfqZi0NeJtf1idyLvEn7Mr
 w2/OvLTTD/0nE2OlloKNTi1oaQka729+KIyVUl5ZcaUq2olbZiKj2RMmT6HPf9mTMPZ8
 Ks7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704829; x=1745309629;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vQTsKrAn76+UasM8uqjd/nLkuCgMzLsX/xbV+gpdXKA=;
 b=Q2fs5JqlB0gku6LZ/vm3c2N5DZUMVw2OBPbWzMHkL3xXmFOebjsItC2Mpu1DSBixJ5
 w+zlP/NF2Mp6fcpsG2+exaKm9avsrh2y5HK4c299b/UzOjCynKk63QCURFQuJqFXgux4
 iKFtWv6TnZByXTfXI4++cAuCpVUkOlaSWiqDxyDW3/nXREChJy/vjxNoJ1CCeyDOWatw
 rvwQpm1gy4ZEZpJHHkUtE+9A5olioiy4fpm48rLflLyjXjDoZAIg46toliNI42jsuNNB
 lmo0wOHwvNwGIfxaAuNydnYSqV9pjcoDpEfYLqRqeqewjjX+MKPLVM/5m5BhoNu8d6x/
 Oe4Q==
X-Gm-Message-State: AOJu0YwaLSFZ8s2xiwuyBKgi+3Jlp3N+iJF8vQCNHcx/6h6kYOwIhHVs
 ZB7/oaAyLvmto5EkeTknhj0L6x1iXT2XFK+3x/ydoAsKOc5k9mgKpyJ4BRQJ88E79Qy5PGLK5Pb
 eLg1NczwWtIKNZo6lXHQ7CEmm3nv3KUaVOSWd9CtQhOAt8Nnls0YbTNwzduAarNtdFuyu0smaoA
 oE1RxiYgw23I/aNEabOJXarXnyIIOZFDgJiA==
X-Gm-Gg: ASbGncuAy7MF55WAPMeksaFydC/Ns43xc+KItuV8e6Txld9q7TT4GtIHuSIUy7hD6dY
 8JlZPKAarCJjCdpQWeLSnnTgmf7DTp61mCkE8Jxf+Kg30VhKMO2soMq1I6uA2lomydE3G7iPbq2
 BtmAmRfOPIS3GKf/rjvhL9EYZ8rZy7kCzDbS5mUqelsVi+6AycJAaZasyZ1qiSExBgsI1McgUd0
 69bPYp5mTUL1K+OyxV1/nafh1ACEAo+xVEI03mmEFsdAv2Ctkh+Cx69Co81xDjCjPNoUfRwY+Q4
 C54RQm1FprUuJj1ab7KiGHT0cWZxAPZwmD+ICPWqqBOw0zQikxFmtczvs1hu/V9WcgDh9XVIpw=
 =
X-Google-Smtp-Source: AGHT+IHSKmtUmM0cx77bUlNhCVJTM5OCuq0sLiB+4Qtfpk2UnOWoC52+bpicZUzaIloz0hmGRdKKXQ==
X-Received: by 2002:a17:903:120b:b0:223:619e:71e9 with SMTP id
 d9443c01a7336-22bea4958ffmr199862585ad.11.1744704829434; 
 Tue, 15 Apr 2025 01:13:49 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:13:48 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 11/17] target/riscv: Expose CPU options of WorldGuard
Date: Tue, 15 Apr 2025 16:12:25 +0800
Message-Id: <20250415081231.21186-12-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x632.google.com
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

Expose WG CPU extensions (Smwg, Sswg, Smwgd) and WG CPU configs
(mwid, mwidlist).

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1aba6dd853..46df970fe3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1742,6 +1742,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
 
+    /* RISC-V WorldGuard v0.4 */
+    MULTI_EXT_CFG_BOOL("x-smwg", ext_smwg, false),
+    MULTI_EXT_CFG_BOOL("x-smwgd", ext_smwgd, false),
+    MULTI_EXT_CFG_BOOL("x-sswg", ext_sswg, false),
+
     { },
 };
 
@@ -2975,6 +2980,9 @@ static const Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
+
+    DEFINE_PROP_UINT32("x-mwid", RISCVCPU, cfg.mwid, UINT32_MAX),
+    DEFINE_PROP_UINT32("x-mwidlist", RISCVCPU, cfg.mwidlist, UINT32_MAX),
 };
 
 #if defined(TARGET_RISCV64)
-- 
2.17.1


