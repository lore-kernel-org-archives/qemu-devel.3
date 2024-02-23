Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13981C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdQzS-0003MT-LR; Fri, 23 Feb 2024 03:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdQzR-0003M3-1X
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:33:05 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdQzD-0006uZ-5z
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:33:04 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso82102a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 00:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708677169; x=1709281969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uq2awk8nJO2BrLl428ae84YlkT7Ql/QRWd4SAtS9N7o=;
 b=l0NqPI6/rMIH3/9WQgbHOT2bO6yQkvh4aI6UVN4604XuEyTbWVdrdzNEyAXKbIRm+9
 6T4Z8oWcNEzarh+6VV0qXW8VRjdL2f3sVELyB0vZkqgh0ZrvAZmiBDoWDX/QwSBDjeY9
 N14na4NnbiMtm/Kh6rWg/HtaqLFQrbWVHru8lgPZ2RpMBG4GhFczoZ/4HPHC+l61Bj+r
 QyK5/cmBMv8TqQWrz1pbmXY8wGbRMvDbeybQm/g9M9njtjl2Ue4TrW0dhu0WKbXfF0sg
 axlhGfZRq77kJihH9kb5CZeueRw2zsWjkt4njY+VFFO9WGd6wYfOZ9oiOVjHaPhCvTkK
 sPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708677169; x=1709281969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uq2awk8nJO2BrLl428ae84YlkT7Ql/QRWd4SAtS9N7o=;
 b=OcP8fKftkp3G9Hr6u3G1eKaE1J/OfxGXl5Bn9XSf8igIG2/0Sr3qrWRTzv1+bTItqR
 PmwvAIyUzTdDDE7LT6NM6WEPmsFYMRwpFxLxH5GAjMdA54mtIIik1lc7lcp5LDKUfnkY
 rS7WzSHV7nhUNktt58nPp/Uus35Y5RMW9LEmlBfg7OahEW7RFYqiVvXBf+mABiwfTvDC
 YM2y8IQqW7+en8zProe+Ctc9CXkiMp+0dru84FqY0FKoj0VO8Sl9LarVdrOE5sqnha28
 wYwtgFIWhWG0EZuHlJ+CmjXf7+fo/Rv6GqqV0hFG4SXplG59SftHPqjNuPZGKkISOIHJ
 6nmA==
X-Gm-Message-State: AOJu0YzlYznq93Qc2UhrN4eomNBAxP8l6LljEtJGASN1Rpp3RHgwW/I5
 tE1xmhroywvzBaCRWH0FEF6DL8R5PGsOhNDTCBVFrqQ9JDwISH3lcFWGjKnbvAv8xDHHyyFM1oK
 uxww=
X-Google-Smtp-Source: AGHT+IHvWa2zlzbP1Yi4jmgq9IZrsMcgkXaIsuKhBDVifB4CmqgzuWhbdRtrWveRIyjDPssIj190Rg==
X-Received: by 2002:a17:906:4813:b0:a3f:a3bc:1444 with SMTP id
 w19-20020a170906481300b00a3fa3bc1444mr716138ejq.54.1708677168956; 
 Fri, 23 Feb 2024 00:32:48 -0800 (PST)
Received: from m1x-phil.lan (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 wn2-20020a170907068200b00a3e6f22f21dsm5294894ejb.54.2024.02.23.00.32.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Feb 2024 00:32:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] target/ppc/mmu: Silent maybe-uninitialized error in
 ppc_hash64_xlate()
Date: Fri, 23 Feb 2024 09:32:45 +0100
Message-ID: <20240223083245.80175-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Initialize apshift to avoid a maybe-uninitialized error:

  C compiler for the host machine: cc -m64 -mbig-endian (gcc 13.2.0 "cc (Debian 13.2.0-10) 13.2.0")
  C linker for the host machine: cc -m64 -mbig-endian ld.bfd 2.41.90.20240115
  Host machine cpu family: ppc64
  Host machine cpu: ppc64
  ...
  target/ppc/mmu-hash64.c: In function 'ppc_hash64_xlate':
  target/ppc/mmu-hash64.c:1154:15: error: 'apshift' may be used uninitialized [-Werror=maybe-uninitialized]
   1154 |     *raddrp = deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, eaddr);
        |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  target/ppc/mmu-hash64.c:947:14: note: 'apshift' was declared here
    947 |     unsigned apshift;
        |              ^~~~~~~

The call chain is:

  ppc_hash64_xlate -> ppc_hash64_htab_lookup -> ppc_hash64_pteg_search

ppc_hash64_pteg_search() either sets *pshift or returns -1,

ppc_hash64_htab_lookup() returns if ppc_hash64_pteg_search()
returned -1:

  1068:    ptex = ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &apshift);
  1069:    if (ptex == -1) {
  1070:        if (!guest_visible) {
  1071:            return false;
  1072:        }
               ...
  1087:        return false;

So IIUC this "uninitialized use" can not happens.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I had this in an old branch (2 months old) I just rebased,
and don't get why nobody else got this error yet.
---
 target/ppc/mmu-hash64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d645c0bb94..cd1e0c13c8 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -944,7 +944,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     CPUPPCState *env = &cpu->env;
     ppc_slb_t vrma_slbe;
     ppc_slb_t *slb;
-    unsigned apshift;
+    unsigned apshift = 0;
     hwaddr ptex;
     ppc_hash_pte64_t pte;
     int exec_prot, pp_prot, amr_prot, prot;
-- 
2.41.0


