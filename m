Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A341C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFBF-0000pT-RN; Tue, 21 Jan 2025 09:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBE-0000o3-28
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:36 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBB-0003A7-Gt
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso4678811f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469472; x=1738074272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/u41E4nMIW/k62qEE4hRVrm65mo7EuY+EqapQU9Sik=;
 b=hdRG8NAwx/JOXaaOpiwGB4OlVWvJSoossnRi/N+krSUE/Ejw4X22V0QQEpigXwz9V6
 Ao3Kr4drLiK7Wpv5G8nIVdYxtAfgTKukn2dKH6IqmPaOksKpYEOgV7U7o0aFV3rnDUFw
 G91R0vjGkfHhsFeF0aX7z53n+JBQVX+Eu2PaqIpimHGEV3/B+1QdjM5zx+3Rc5WFlqvh
 J646EZa1IvCyL/io4/h48lCpLUE2VFkbVKSigpebuKQbOuxBRvdmufRwXrAUoXni/U+z
 GOAXOtBeFXrakyJCb6g1cH7Za69cBpMt5ONkWMirlxzGCKJAiCfH1O5hpCLo11+ucjRi
 0xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469472; x=1738074272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/u41E4nMIW/k62qEE4hRVrm65mo7EuY+EqapQU9Sik=;
 b=uLr5ocrT7BATajJkNO5Nij3HXKF1W8324adbmjFe50d+xKoFiCHyfRJgQEmPTqoRgs
 w62INdbS+dKWR7tL8IBCcL1LB+MKbn4DL0ltX9AX8Y9ccvDSLfhOjHImM5ktnZAkS1wK
 U0TH+SVxBzcuPCp/KZytcr2628eoKZ08wALIaq9nABHZZvvIMUaoX0ftdl17uhnGb+fs
 mTaEV3nciQ0TLdbPIdtu1LHXKzcIfF67wvpXs3iA6d5FmpsTXff/47pMJhOxgNhglshz
 h2anBfM5O3x5n4mdR6vXzF7rHy2VKbB3mw3fG8IAJcHQWVu7saxPtCRX3lLDST9wZS0E
 0XZQ==
X-Gm-Message-State: AOJu0Yw349XmIPC0hG+avwMV3izj/crUS/b8dmD5QneC/QSz3IX//JjR
 d/g3ovqm4YSWDc5axaEIH6MknrsBybl8tx/+TDhBgfkqs/vgkfWWn3a3wA2vA5xBWkz6+O6/9eM
 CSSI=
X-Gm-Gg: ASbGncvOpDGB2sigkxg5TpQXmUDnSpEZ6n9Lvrb2JYawl6TX7Moe0NzglGixZnEAFko
 taglmHTZybjjR/lgzpkZZ6VmNPowzaydiYe6arry3uHOYD8gw0S5A8hyfM7WukoomXCZNDnSv2I
 //ha2AuZQpSNqnPuOWNnlZ8njostKySesVT+7A4XNBlevm0/PG61Q8LX++GS8xZIQ2d1mvyNarl
 /O9+seSLa8KyVYEcErX9TojEaMtBm3AzjgNMkNwDrd8oR2qApel1QdYRpx2sn1C5/Gmidr77knx
 NTk+bwB16ZFzSwkcJKGEcbBghv14dQlY5XDHxioR4K7y
X-Google-Smtp-Source: AGHT+IFirpz56U4iOszGwu97M/SwfxkHVWS84L1btC1WZ+Nhb7WV4UBqSxqleLsMwTaP1uwWgNLU7w==
X-Received: by 2002:a05:6000:144e:b0:38a:88bc:d57d with SMTP id
 ffacd0b85a97d-38bf56562e1mr14596922f8f.2.1737469471577; 
 Tue, 21 Jan 2025 06:24:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389040854bsm185820005e9.7.2025.01.21.06.24.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/28] target/avr: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:23 +0100
Message-ID: <20250121142341.17001-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8a126ff3222..8712813f3e2 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -200,6 +200,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps avr_sysemu_ops = {
+    .has_work = avr_cpu_has_work,
     .get_phys_page_debug = avr_cpu_get_phys_page_debug,
 };
 
@@ -232,7 +233,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = avr_cpu_class_by_name;
 
-    cc->has_work = avr_cpu_has_work;
     cc->mmu_index = avr_cpu_mmu_index;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
-- 
2.47.1


