Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D44FCFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTHm-0001KW-T9; Wed, 07 Jan 2026 08:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHZ-00010R-LT
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:05 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHY-0008RG-99
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:01 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so17448135e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791338; x=1768396138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJT9/Fz1DKFflJUDbix19L+27ce9cn0U0DoKqxhNjvg=;
 b=pYQH22wk1ScK00JtvkefhauCFia++IREeXK8lFWgUvHiIHbhEjtGdGsNA/pIJmEAJw
 cUnsDZrUdPSqJgoeMis5vt+uBsNl+hD16XVbT4XOkE/UWCkR0MaJTotpEpxOqlk8IZeK
 McxHYNL1VRFHMdbXXaXm+Kpzt6SnPQ0vwVk1giVPkwxP7qQBVHqSfOoKirctF+rToSAk
 5SVFuAVrVyGFxhoABQvG5Z9tNs3Zr/sVGDrrd5GJwWVyrNCYqf8sDiZ71FYVUNOPoG/v
 iHKF/1mcZh3ZmV7b7GeFdXzIckU3FLyRp1dxyxZBCIyOCwCUEeAUQKB5sh4mhnNskQff
 znLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791338; x=1768396138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NJT9/Fz1DKFflJUDbix19L+27ce9cn0U0DoKqxhNjvg=;
 b=foL7Er/otD+/hNmncwQmMTSmAoTFC1OjIyAPXXFrcGxYH/YAxjuzckI0Rr6mbggRne
 2h3SbyQBV2DN+rZ+J8fm41iK3XaqZbxxbJBgKF8BwDmk57BvSUwJGKnwrcEDsgxFckOU
 qqKxiQ0k29MQIlfbhM9IH81sBFzO533lbJ77cRFe9yOBqwXohmkAQvvV1YlUrBeRiFHh
 W/ta3eU39Pdd1qyIqgCqk/KXBDDS6ZmuFVEfLrd3JBxwy4+rvAshJ1LxsOPYcAPXyGpQ
 VIX62UoCFfruUKWbXqlVKJYKBS869VBbU8pdx2uM3BQGkCVCR4FtmPayF+mYUpnf+Dhd
 04rg==
X-Gm-Message-State: AOJu0YxrrkbBlN2M3NB/WXIK7zLFoRRRenuEnP0ZZn+lVH31vYBAB92u
 5Cd/mWmNXbztZkqimUJ6XmmFxe83fJXV7kT75bhJgLfSxS3E3IXsYCsRALTjaICbUTVDLE6XTb4
 Mvn/1f8nBCw==
X-Gm-Gg: AY/fxX5JYT7Ti0zVNmu1gUEff3+bwcRBYfnoMXkbO55UtAFJeGamCWk5o0dhNy/ogj3
 VmxfIZobM5fuHjkq3BjEYVm15lLzbRaCuEsZXrDQBkqZmxGncjFRg9JiFJiHSRrzDvQBbc1RNGZ
 L1RSvlRIvJNS2TNjq/bb9FJma2N0C1ym8Js5mhOEx7eFjxSo9q4+ZapAkrA87bNyZebsEiiu9NZ
 BhMOD9dIMv1veKkhmqUdzmV6wI/nXHLHFkZFiKrTVDxl69D4doyvHZoCxoZIy2Cdh9EpRBb4Hx8
 BuThSlCoUb/jtajY13suMYLFAKLjDEpJy0pqsTSPeu1Zw/j1tW1l1IWfHaOfMjxKIoH8GXGdflx
 uAKzoJTYyu3yCmejjpm2s6UigFFy+ni9bk9kpmyfltDox3DKb68QnmBDQDNc3jIJ7lYZ/EaOjS0
 u8uOurgJw9OgWutx+RO10C65nfgNWMVYVSpaOniMDvplV6AdYhm/6dsoZOTu6j
X-Google-Smtp-Source: AGHT+IGyYy5bQKimbZCunnZTD2OgD8hYWA+Rt5Qyp+v73adTlEuxLZOuy2mYYtm/4Kf2rms+Hon0uQ==
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-47d84b0b303mr27018715e9.3.1767791338342; 
 Wed, 07 Jan 2026 05:08:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6ef885sm96948515e9.9.2026.01.07.05.08.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:08:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 07/18] target/s390x: Pass vaddr/hwaddr types to
 mmu_translate_asce()
Date: Wed,  7 Jan 2026 14:07:55 +0100
Message-ID: <20260107130807.69870-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

mmu_translate_asce() translates virtual address to physical one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 9ee1d778876..ccb53e99ebd 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -122,8 +122,8 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
     return ret == MEMTX_OK;
 }
 
-static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
-                              uint64_t asc, uint64_t asce, target_ulong *raddr,
+static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
+                              uint64_t asc, uint64_t asce, hwaddr *raddr,
                               int *flags)
 {
     const bool edat1 = (env->cregs[0] & CR0_EDAT) &&
-- 
2.52.0


