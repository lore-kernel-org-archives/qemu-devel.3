Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EAAD66BB2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 21:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVyxO-0000Af-QO; Wed, 17 Dec 2025 16:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyxH-0008St-1w
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:07 -0500
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyxF-0004ZB-EL
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:06 -0500
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2ae24015dc0so1081337eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 13:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766006463; x=1766611263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6rMJ3udbgIpgAiy6d31R0Vx2kkWCqkcA13MTheL8sQ=;
 b=lnrjSTETKHTBsLS0MyHE5yt+7v0flwHb8IGz+AnCfNU6B+6QsTROZNyWjzxKErAQYF
 Zq/ZaKxyDGfxXfEGYIUWCoqfnhqt6rNFvF5cXChb4sfBUG+pfo5XvAll80xfXlLePBxs
 IaKuQdnpmQP6s+vn4k2QytsmQUsthDmJk8HcASVw2WmOheh+B+n1lqlyLopu1GOs9CYC
 FSVwZYBhEnpCP22mtHUNQybY9CB/5KGPS6vJGC37qfSibPV2u/8x+0dn5KRcnmvJGQx7
 s92xjRVEO1DtI7lGEAig+7bheqdXuSqs877tZDdETvWlpXaHHZHzARjFHcmDuUA8/qLJ
 fvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766006463; x=1766611263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P6rMJ3udbgIpgAiy6d31R0Vx2kkWCqkcA13MTheL8sQ=;
 b=dDt3/juqM5gZQ6huenF4k3vMTEPjRQY1YmM0bhqAkS2Eb4Hg9X08i5adEoVSw4rycN
 ZyjYfYQYrEhi5aCSXAkPgQf6RVoddy/n4bc5HoTPNvwrmx4A9reZIAXLqd0EuXUrwdCX
 bQnNf/NpavRhE5aUd4kS6TCrGByRicbdXqOoXMlXr8SwuvqpLEcpYbX2fy21Cyh31Li/
 /NtHd+X7yg+2mhOigs+U06xYRtD3SLDHe0lugQ6nPDYLmvzLSZ/V05iIE7rqb5Geflap
 EqsZcJDV/NojZYT8rdhDGPQwrDcx8Q1XUC4ZSx4G1ucZknARqz4rtC2RaMQ0qrBrdAff
 h8ow==
X-Gm-Message-State: AOJu0YxwUu+abK2wgQVKviWgI9qOh4JkfDXpKlJuKMrnJRxdpagamfhT
 dO9c7XN6mCP/Yqr2+8TFq295sX7hkZSKRnwfFUCGV1cWCAjgsbb/rMUCnQQED2dGqW+c6Vw9A3v
 hWYkN
X-Gm-Gg: AY/fxX7MdyaIfLMjiRe6dUXCssd1sgl7X46olpwwU4YPMNMreK//QapSdSTv+AUFeEr
 e4ndbXT4ReicX/tpd3XFUIL8aqaaRQ6xViQRzZ8gBvBB4M56mvN4/H7bOZignL13AFwzBR1SpLl
 YXT6j9gnaxyLO99JIAd5kTiGKNHaHrobQkVvocZZ4Phm0Kj8whXUPP6WiKm49y2o0tCbGlrmgz7
 iVoitCPph9P8yFwVnbNzZ9WWda/62r8yVdctuKoXWUk4vQ79O8Z2ablpTeB8SoexsQqmyav0YTZ
 slnMzxTcKMHhFmQJPhwkt4WQkduF7dDzIsOEqfPNUXp6I51rmhe/gfvxtYLxK44/Toz6yY42/K0
 zvm+ubmVKfql7Nzkyv5ZCZOfL1Uri8V4+yFc5nbPRZ9lwOUoE0jG0u+ZTTlbat5PpWoM2LhEDPc
 46m1Qz07MBaHhJSoE=
X-Google-Smtp-Source: AGHT+IFrBbbLfgFSt3ipKNQ1FyQche183dMsWRyOxuuFRtR7CcPIeqi++oKWDmhkqCsx96QI4AKtcQ==
X-Received: by 2002:a05:7022:ef13:b0:11f:3479:fb72 with SMTP id
 a92af1059eb24-12061938261mr763402c88.6.1766006462582; 
 Wed, 17 Dec 2025 13:21:02 -0800 (PST)
Received: from gromero0.. ([191.8.216.160]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12061ef3383sm1852476c88.0.2025.12.17.13.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 13:21:02 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 3/6] target/i386: Add a _MAX sentinel to X86ASIdx enum
Date: Wed, 17 Dec 2025 18:20:15 -0300
Message-Id: <20251217212018.93320-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217212018.93320-1-gustavo.romero@linaro.org>
References: <20251217212018.93320-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-dy1-x132d.google.com
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

Add a sentinel to the X86ASIdx enum so it can be used when the total
number of address spaces is required.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/i386/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1..783ad66d74 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2600,6 +2600,7 @@ void cpu_sync_avx_hflag(CPUX86State *env);
 typedef enum X86ASIdx {
     X86ASIdx_MEM = 0,
     X86ASIdx_SMM = 1,
+    X86ASIdx_MAX
 } X86ASIdx;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


