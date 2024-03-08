Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BBFC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYA0-0006r6-OJ; Fri, 08 Mar 2024 06:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9q-0006gX-L0
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:59 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9m-0001cz-Vj
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dd70a43f7dso868155ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896373; x=1710501173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snb/WRfkioHftYdFrqU99dLAHxtfkwWfF+Km0NPB5xQ=;
 b=hHPKz7nLBcaCnFycq/UZcx1iawU6WgtdR5OSiIPeUp45yTAo+mI5T2mMZU8dUnyH75
 HOzjto8J5xWLJ9uYOm8HIcQu+0jm69v+UMTmouRe7dI7P6AR7UEMsSem1VDChNGp6VuH
 AfxSRFcKlZMCtMxtAC1DSGBXL0XgD3PbbzCXmtSCJx8SP0I6EVbMCsGAEpe/HMdkgTFj
 91WLD2st28kiLlYi9sSlPEELSy8VjT8oNB8gMVokEaGxXcDnrx4jHhjKG9aUxyGP5j4X
 nVpIgn+HzlMH3rgprN6WNjBIKE1FbWG5TWCxOyiX2xarzsvdzFMGv9WfY4LlsdlxqI5Y
 eftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896373; x=1710501173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snb/WRfkioHftYdFrqU99dLAHxtfkwWfF+Km0NPB5xQ=;
 b=kTD3jVs18wfll9yeP1Zmj7bHidKRkTr2SakD/h76hTsUTN1jtLt8oWjryGT5tslOWn
 msFVgBPcQw4phbZKMlP2yjS0qNETloqjwQqKfznZdUBXVNg0gxkJSIEg0gDlVJv7Wj6H
 YErNdobOkqvARzTZcnaT1cK9JD2NM5o13HIJsB94QDj6JkCzeCtp5H89sB3g6rFHB4En
 t6h95Fp3qh77ddldFN/Tji6RjyULcdMyWdSkGl2quy3RLCJL+C6DBOYc5UOlCvqxBm2g
 ekon2SFFRfcu8ikOvkarhDDm2JU/Ez+ea423Lo/cBEvYhFH9arcTWfwn5Ig9yc9P2DMN
 SL9w==
X-Gm-Message-State: AOJu0YzA/TgA0nMa9QDOEW8CdRXKmyQ1E6HiRIHLyFrS8uDUPu/SFSuG
 BwWcZxAL6TdBpoqEY6rBd86XdPA35KHqycDs/LZwjTIWbciwDZxZRI98u8RL19hdZg==
X-Google-Smtp-Source: AGHT+IE/jUCXc/r9AQdi/7knRTJChLVJ7Eu67HaEjXRrEHWZuI6BEqiNOiPrsohdRTTamZnkyK8nvw==
X-Received: by 2002:a17:902:ec88:b0:1dd:911:19b1 with SMTP id
 x8-20020a170902ec8800b001dd091119b1mr13929252plg.19.1709896373247; 
 Fri, 08 Mar 2024 03:12:53 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:52 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/34] target/riscv: Add missing include guard in pmu.h
Date: Fri,  8 Mar 2024 21:11:33 +1000
Message-ID: <20240308111152.2856137-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Add missing include guard in pmu.h to avoid the problem of double
inclusion.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240220110907.10479-1-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 505fc850d3..7c0ad661e0 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -16,6 +16,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifndef RISCV_PMU_H
+#define RISCV_PMU_H
+
 #include "cpu.h"
 #include "qapi/error.h"
 
@@ -31,3 +34,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
+
+#endif /* RISCV_PMU_H */
-- 
2.44.0


