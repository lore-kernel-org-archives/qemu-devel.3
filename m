Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7B606B2C4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=NuFOuFiA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgt4-0002iV-5u; Wed, 04 Nov 2026 14:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsd-0002IJ-J0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:45 -0500
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsZ-0002LW-Qz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:42 -0500
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso1853283eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821358; x=1794426158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jJ0xIOcIwfU1eBAuLqk68fHdggoXZy15gka4tDDukY0=;
 b=NuFOuFiADn21O/uVMDO5M13vo9GIw7UXHpGjA6VgdCT9fNAnxZyxPLwshMjaXAyt3q
 fbQsi4LZk9v6GYzZlH3gL6+nWNpoCfxOvNyuA9O/yOyOIbyCdK7HARAyOE9Vntbyw6RP
 2m+m3J53w8CBJ3Zx1xZ+QpNs7Mntw1QIU4sswG5CXjgQ3tElb/z9+9kYuiEHUI37j9pe
 I0z6dbklYwPWPBJjGvYjeOgtJ0LbUTnnVoYgApSlG/8MBMQpzD35ZL8ec5PKdcn58y1O
 r8P7VRaiQ/fqbbLXNhuUPw+ocWQu8ONrGMgZYB5MT1xpKArpjL9KuxiLRhKxYK6OyT2g
 v9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821358; x=1794426158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jJ0xIOcIwfU1eBAuLqk68fHdggoXZy15gka4tDDukY0=;
 b=cvq+QIYEAWMV8/TsLds5H84RtuKbXJTwtqnT0sqtoLd0S0yB5vSJjusos7TA99beA2
 rglfLBDyWLN8xNxrAHZS2zmVJF1llhrQS4B9eYYBEFxT8xvbZvI3pA3FjDOJJ9+KuRs0
 tFTCfNdr6AWomgwCqtg21zxzQsI+A73bQLj38ES0nfQEhPckY9NhsojfgJx+99TKqxMf
 hyjgmi3pYUY+1Ulr0bxzOP/dbo2E1VOEKZrYzl0+yh1/Fjvl2PAOoFsbH0ec4YotLFHr
 5aYRKzss/s7Pu6JQ8nbL/3IoNmO3mji1u0Kma5+An693gmF+IlaJA90FBzikFuOGtkCx
 FtOw==
X-Gm-Message-State: APuU4Z+cYtxNUvuTqlp+1wCCNvkjzlisAfFHRmRKmIY0kEyW5YxkoB4k
 cw7pBHWJtOdBjsxkif09XUlgHruOILadaNa765ClCRBmUMFdgMQuXdgb2xzOZNZXpSr4DyBQm/z
 JT+68oSigywcVWNnvcOCqkUCL74UnzQh/wxl767OzNM/1JYlqX8EPOUTbQXxjoKIiYJAhze6AyX
 WJHLmFxVz1g/iyD9LsaHY9Drp/ngWYFWjdBsGwGrVPYg==
X-Gm-Gg: AYBFou0qZLaVrg0spxY/89bSx1cEpcCKOc4ydjRGz9UcSUqAe//sWxvTQMuKtBrSM/+
 kzuX3f9HzL7SpzHUEWljWmjmpXzaj36LD+abZYZ8LpmwqHMvEEt5+fzDhrmSgflk0rUFNxoxdAE
 SEo0VmvoZ8foRzj+Tvp5dVMEAOKqycWzBVLEkNT+Gw1kFoV7Y9QhQc36rBbLlS7423CyN3oHQOr
 fBmCP2UwjhxDIHqZJ082czmnKNA27zUvqnUMra5lZCLI9GAfJN2QJTaC1gQOv4PCZxJK+4avQbo
 xNoWnAF0vXpEB7Z2gRVJGDF9EIuUZ7bksM2GNd1ympO27FJ8nAX3intlFVCn6uXTtyZxCB8jqWh
 HEkLDZU6Vi5oU9K7fP1dyP8nHG6wD1QNhcCPS+bV4zcgGQw4anjm7TAO7xxrxxU2wi9zjVxJ737
 9nihoyq4hokI7mPrPdYldxUkNv0OizNnw99dm/CQS013mY6B5ZupCxY3xGGAciNKa0emUAQip2Q
 x+9YZJNJ3ySHaZOfdAZEUny7Ya1hO0N//FDs34eoH7gUqjLrftVI3i8DoHqvH4I4ulFr/QSkFBe
 RzBQ4tRdY0LtwLXlB6v6ywSq7RlbXv0kE4psG7wBpmkYPvsW+Cn2pJGJkzmUUPBuanglbbQhSks
 +OhF7wLWptnDgQ0B8QpRlKx98eBRG
X-Received: by 2002:a05:693c:2512:b0:369:fa7c:aee9 with SMTP id
 5a478bee46e88-36a423f54a1mr24401899eec.19.1793821357983; 
 Wed, 04 Nov 2026 11:42:37 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:37 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 07/38] disas/riscv: Support Zvqwdota8i extension
Date: Thu,  5 Nov 2026 03:41:22 +0800
Message-ID: <20261104194155.679241-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds support of Zvqwdota8i extensions:
- vqwdotau.vv
- vqwdotas.vv

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv-op.c.inc | 2 ++
 disas/riscv.c        | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 425473ee61b..ec767ccbf8b 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -770,6 +770,8 @@ OP(vnsrl_wx, "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vor_vi, "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
 OP(vor_vv, "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vor_vx, "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vqwdotas_vv, "vqwdotas.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vqwdotau_vv, "vqwdotau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vredand_vs, "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vredmax_vs, "vredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vredmaxu_vs, "vredmaxu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
diff --git a/disas/riscv.c b/disas/riscv.c
index ca0d6e90b37..2acded0c915 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2634,6 +2634,12 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 29:
+            if (((inst >> 12) & 0b111) == 0) {
+                switch ((inst >> 26) & 0b111111) {
+                case 38: return &op_vqwdotau_vv;
+                case 39: return &op_vqwdotas_vv;
+                }
+            }
             if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
                 switch ((inst >> 26) & 0b111111) {
                 case 32: return &op_vsm3me_vv;
-- 
2.56.0


