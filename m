Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AB9C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Msy-0008RQ-SZ; Thu, 17 Apr 2025 06:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Mso-0007sU-SC
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Msm-0003WG-Gn
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:13 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso511960b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887249; x=1745492049; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vQTsKrAn76+UasM8uqjd/nLkuCgMzLsX/xbV+gpdXKA=;
 b=I9+Q53nHVW8rYoQtt/fhjN3DE5MD6jM5TYEzDWKQGVWTDhANcxPTXjLiqumgdMo7Dx
 M/fPW0HrtdjOO8JoJuHLUEciAUYGPPIv1J09Vcj6oJNiPQKK57tgfSJ3ad9hEIRi3Yxk
 SfAVFCcpoHuakta427pMKn+Le2DhJjAX/UpSNo90qohO4ekf40ofyvN8dRPRcxYgqedV
 qhHjopERl0LlKh9cXraIj6o8TgjXz0Oz34cH0TdRJKdEdZRgC5q1gEY77qSYUvrxUWMf
 lXJqXf15lkXJNJl5AeVigSSv1nISzSIw3ZV0Vxfj9GGUtJD3SGkxHfahhVid4HIcQ5jz
 nadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887249; x=1745492049;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vQTsKrAn76+UasM8uqjd/nLkuCgMzLsX/xbV+gpdXKA=;
 b=hJqRhDiGqdeEYCCd/Wx9sjMlEqzi3eYFqzFqGaCLBpBPcD2s+MdUZHd90BSxJhjtYo
 OF/HdvLs9g5mHQ/basvEHehBc63VequHXbIRakJMag/sLhIX9pr5CbfxoU+Vx2njbZXS
 Egu1F9ChbSDhEdQIarHXnRJU+YgfB2RzXqAobOkOJ6v04TNhKQErcyUz7KfRoF2VQ0sL
 KLfh/bGG2rJqbxMEsxLt0IVBbW72/TTY5qE2EUBqrrU+cTuKxBdx7gwDprQp7+Vsl5sk
 FgkNc45sPRYd94aoURC0Sm4chfZJzMzA8aEVKWWAqxvmh/Seu7/ln2QpDfXv4uVB4V4i
 dRaw==
X-Gm-Message-State: AOJu0Yzn4JPM36Kvxd5aXsEbfMGrPEpPaCKN7VlfjC5y714oZkgvj3Yk
 WtZjehckEMOiXGwYFvSUHlCIEzbb7ED3SBSK8aAAsnXQ8nwku/7+uE28fgYkPNRn1me1i512qHi
 ZBxVik6d2wR1X1Q+FJb5jckV9P8Rx6Ktfw/SG2daiNd7kb+K6KiPUlknYUad+b60IsD8ESowQFl
 8K/WzEkgA5gdTxP3YDSnFe/sJWncg02MG9VQ==
X-Gm-Gg: ASbGnctu2y8zapclrvAIWNuusxYxJiY7xP3J3+JLknHIzUZ2bf9/mjFBiOUqJmjDn0P
 fc4PmHxddjmcgrFLi78rnpudauue49yevM9Vow1bNoZQzGLnKUFmyf6xiatkk9EBmhc8RLFr//z
 gMrUmBKzPArU6a/uaAbLZNCbErCwnZ1a0L5l0se8ylM9GJwEWAhwpUtqWAtv4nHzXXEScdfuLNd
 rKtvs3pFMcYcFE/0fhqmPi6g/8ECs5tPWw9JoDZgXwuesX7BFpbMN4twpQT5DKlmRcfdpEuAhSH
 SN339KHcIRNy6qgkpbydLHjaAu8logMdenSCrvMjV/eBIFfW2y0LtSiL/8Xv95s=
X-Google-Smtp-Source: AGHT+IEekOeXlJxQgqE9ZWPX/+ewPT7W/wX1P7lgDnVNwXejZ1pv1ga4HdqDy4pgWILsWxLishEcHg==
X-Received: by 2002:a05:6a21:150b:b0:1f5:97c3:41b9 with SMTP id
 adf61e73a8af0-203b3e4ffe2mr7406779637.5.1744887248819; 
 Thu, 17 Apr 2025 03:54:08 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:54:08 -0700 (PDT)
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
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 12/18] target/riscv: Expose CPU options of WorldGuard
Date: Thu, 17 Apr 2025 18:52:43 +0800
Message-Id: <20250417105249.18232-13-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x431.google.com
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


