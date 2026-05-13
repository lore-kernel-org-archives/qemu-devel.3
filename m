Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830E1CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 03:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN0fA-0005B6-GD; Tue, 12 May 2026 23:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0f8-0005Aa-2H
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:53:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0f3-0006r8-7Z
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:53:33 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c801b30188dso2727498a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 20:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778644407; x=1779249207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3kJdKS+0aBBrr66fg3mLbkrfD2MUCjxc0E2Dg4ZHfI=;
 b=EyyKs5Si5+uWJCHcpwwxfHlTyZsvhF3kcdiin5KWrFQnU1cMfByYhrDGWhUZMrDVJ7
 gSgxlVX8sYvOlK60RhwpMEgOSVy7JYyQQY9NzwV0PPRbaTAwO1rYoxk3M/WtzYYI58nb
 gcp/2C/NqCun7wS8DNYSyqTtQnVv1V0X84KvWB70m/i0bPHbZAk7LHkORhXttsvHjSNh
 aUKsWiGfkRK0MtHuTEoTgN+rorBqBZRUHncBwpmkaUW6Gj826tnmXcLXDaSBrclGbZaJ
 jiL9NyBg8avOoM+ezvlysK7A5ulxKLONuuYZcqeo0Sv6v2S6msKJSKkvMA1o3VMt/XHf
 XKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778644407; x=1779249207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d3kJdKS+0aBBrr66fg3mLbkrfD2MUCjxc0E2Dg4ZHfI=;
 b=g0qKKQSyXkHteCjIdsNR3Nwn6LncMnL9s7Ur8mwcZNpsAv9ssGMDUiHsuJYt3hJVIr
 2w67/pz42kXsp7WCKpAprSnv0+oPZB718REMqwZZPjFbXxTs8G92uxmfpPvKpphbcXkW
 tq26dcwZgAhWjgf7JPvRu7d7OhwbcxZXBO4j3D3Muz1dpE2jc3oTGnWW1eGcE0SvtmP/
 fFSLmoc04u3DFK/mBW1TPycYc0QQtfaP1nwaO1wMeoOe8jnvXX1sEvrf4Gs0gQIHbyh3
 kjC0GSt3beA57masg6zpiqGHhm/GNXLMJe/NS1D3BOc2rb5Lr4b/CjorjDHeFzrz/3xi
 YUgg==
X-Gm-Message-State: AOJu0Yz1LNYLObX43w0ZljkGOfeFfzFRpgCg5o5AWIY+hjZFHmXHhDla
 5hlU3P3gP3aG4VThW/wB8yB/6oOIw1fExM7PfXaO/4+Fz/96wqxHGwYuk+iZTDlcWBYaO5xxA9m
 qlq51A6BozlIdETqPJi25bnZ+Ls4kVTlAUHQ5Zg765rjRPreAUPv8+SJQFUN+O49t0qSUnoHmkS
 //ayJTnszbVUkVvRRFC/uUg2HjHWehKHf5erH8ETzLtRHnA1Yf
X-Gm-Gg: Acq92OH8oaY9QWD/9h4zxhE9AwMS5jglhzPN09dXxFDGtL5pxzj3Qm+wb71dkYz+JI9
 JAOlyCqqe9T+e+pMRqntDsLO3kC5BVw8X+CRumIMAHKpkaZutVp+fIlrVIbfzkwr7NJcct5MFqQ
 AkKgXKM1OYC43hSEGke4iEAmu5YZosK5V67YW0Qv3D826DIw6+goPKZY2vs2kpM1Fh7RKaFeNyW
 MNlmInuiOeZY/wran3Z08Ii4niR4NFryvYFsWxhoO8Jiqnn9eE/SkTUKil3fQOu83jKrZaFpmrl
 /T6/H0D8knE3Il8d6KIUIi4ElIYgkhijcNSk60R3+R6L4+XrlcAoYizkus4kqjogA03gThndzUz
 q0EBsBPBzgXj0QGAblQnHhYiOVsEG9tA3sRRXscur74cB3dMywLCOmORXLG2aZNCoJlsYiMriQw
 VFxYFy23Od/6V9ngV1MSAu1+fOlunt7ehKL97ZG2zgticm3rrQBQ==
X-Received: by 2002:a05:6a20:3ca3:b0:3a5:8542:61a4 with SMTP id
 adf61e73a8af0-3af81472f16mr1467150637.25.1778644407007; 
 Tue, 12 May 2026 20:53:27 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbdfb0sm24317872b3a.45.2026.05.12.20.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 20:53:26 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 4/4] target/riscv: Expose Zicclsm extension as a CPU
 property
Date: Wed, 13 May 2026 11:53:10 +0800
Message-ID: <20260513035310.3764218-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513035310.3764218-1-frank.chang@sifive.com>
References: <20260513035310.3764218-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52e.google.com
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

Expose Zicclsm extension as a CPU property to allow user to turn on/off
Zicclsm extension.

Zicclsm is set to true by default to be backward compatible with the old
RISC-V QEMU design.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 468055ee090..2456963904d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1327,6 +1327,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
     MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
 
+    MULTI_EXT_CFG_BOOL("zicclsm", ext_zicclsm, true),
+
     MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
 
     MULTI_EXT_CFG_BOOL("zca", ext_zca, false),
-- 
2.43.0


