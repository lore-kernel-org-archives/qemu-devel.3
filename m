Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E2EF55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 21:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyylN-0007Fo-RR; Sat, 07 Mar 2026 16:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyylI-0007Eh-Mq
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 16:00:36 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyylE-00044E-Pb
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 16:00:36 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ae46b9c70dso28511735ad.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 13:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772917227; x=1773522027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sn8xR95BCfCbpDAarv9xVrassA+wyb4hh7tq0u4v5eY=;
 b=y29susAUcP71a7zfAcLvfcgD59wfaoHZRfSegPEPsysrYKLy6xrE1YXBOSZYQJQpsK
 eBEtwkZpIBW09U0dvlnKekFmHlFSaZxGDS5neTXRECQH9f5V00E5zOFjhsxF5B4F1h5F
 W98QtS7/GyaAl3KvIM5YA75ydInP3ZbBA02/touigd6Go+RzBh7awApPUnRYCFrPrMdB
 +kOWWYNQrVOUCGZ5BgAdnlyvMkuP8PGXoen0eXpjz4AYgJ6BGT0kwrxNoKth7zMpCiJJ
 2kgZN6VdVns8puyNnhToYn/PgXSLgZFiQk7nBU9Ciiorm+vSsCsZnvanYszBum/4LdMV
 T5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772917227; x=1773522027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sn8xR95BCfCbpDAarv9xVrassA+wyb4hh7tq0u4v5eY=;
 b=upwU9KiacduaVaOSRKEaKpVw0raX+wH9cYznYUFwEAYAOXw9lK4U82Dg+z5A1RqMNc
 Ffnjh6eEODQw0BiUL0O9F2YupPdEhdKVrplQycKxZPQ83Qq9npH2DLTHzsgAs4Ymp7BF
 5hQ/SmExWcqmj1cAd6xB4tWqEPpcueBgPZ9mLIDBtTB/b5JRu79G0+Tt1XTeWYW/CL5J
 TOhZng9eH5KG/7nIcJIIM9+zvLo8qw1jUrCG/b1yxZxi2zAtfMjqPh9Wf0JpdQpmI6vz
 JyLUxFBUYWthJOB96Lu8skReeTq5vpTOhxjvsc6wq9bFFAHNAXtruTN1Kdpu3c7I8fCx
 RQWQ==
X-Gm-Message-State: AOJu0YzlAThKyGXPcb0y3JCYGbsVBdaasP96v1WOIHQKl+0SM2ItTVqr
 mktWZ/NIOxpPxNh3E3EF/iJazasWdAGqElpEE9VPMjLNP5QmcW/RCH/nLndLnNVSmrksKUxDfqv
 rFuQl
X-Gm-Gg: ATEYQzwfTO5WR9HzCzn51GwRd8Fj6JgVAyqCfnriNegJkGVaesJ4+MC1NLfxWNHy3w6
 WaC0vvXPVp8E29opZZZGG8YOh40BipOERvlc6m/fUONk0EFAkTVD1VwiPkzSU/67hWS6GvT+Ipp
 uUSTm2O2Q9QzX49mDlG9X/OFdcKHb/oKDCEYxLNz5CUJ2tCGn6teRN88no+ziibTQtmmUytz8G+
 Ouh0H8wYfC1WYMggXcO3Eb+uzCMqererUIh1dQt6bUFLmWNsjnwM44TfRMfDUmvnJLXCw+8nh6v
 lJ3MUp3jLE0RDVi2VOZWGRlnbL+aTEhvXPe0bPMEGWOpr3nXO3AlKBij5UE9AT5e28ye4rWaLWH
 d7FY+TMAM/227GaKT75sDH0RkVWSqWKWNYvHt/BmELEx885awYi8csAR+NbIFbNd3CjxS/VCqKR
 Igm4XsLFv3cDvxOgaNZvgLicWPV1Pjq0I9hbDvZU+O7pCQY3mkb4Wl6MRfjCzS4D/93O4dkexn/
 mmV
X-Received: by 2002:a17:903:384d:b0:2ae:54e3:9299 with SMTP id
 d9443c01a7336-2ae75c2a9f1mr108708665ad.21.1772917226679; 
 Sat, 07 Mar 2026 13:00:26 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83f8cfb0sm79975935ad.67.2026.03.07.13.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 13:00:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/2] contrib/plugins/uftrace_symbols.py: ignore zero sized
 symbols
Date: Sat,  7 Mar 2026 13:00:20 -0800
Message-ID: <20260307210021.878274-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307210021.878274-1-pierrick.bouvier@linaro.org>
References: <20260307210021.878274-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

When using llvm-addr2line in replacement of addr2line, it will output
zero sized symbols, which can shadow other binaries depending on where
their location is (happens with arm-trusted-firmware and its different
binaries). Thus, ignore those symbols.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260306051553.2778652-1-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace_symbols.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 7d79b81cdec..02d1221228c 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -45,6 +45,8 @@ def get_symbols(elf_file):
             continue
         addr = int(addr, 16)
         size = int(size, 16)
+        if size == 0:
+            continue
         symbols.append(Symbol(name, addr, size))
     symbols.sort(key = lambda x: x.addr)
     return symbols
-- 
2.47.3


