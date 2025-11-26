Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8905D1038A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAJZ-0002um-BL; Wed, 26 Nov 2025 02:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAJ1-00019z-CZ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:51:18 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAIy-0003Vu-MY
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:51:14 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-429ce7e79f8so3604158f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 23:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764143469; x=1764748269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zf2/DQz7xbz75Ga4VE+1UrE/H7U/K6rZF3lvRiigioE=;
 b=dNYUgpL+6t5OkopKmQnlpBLH383u8IgRHX2Z3X7IBtAcINB6aX/A/c0QFzsLc+5l9f
 kErUuMtPLQw1qemI2JWXsssEBZj7yrbbUUBgTNfMKoxUMrsObHXFNQq+yCzJRaXUpJHU
 wbQun7onKB8yM1hHnNOtlFhbXdb+iBtpBI/P2fkmUjsgAWbPp6sXBcdkyr5H4hahCadh
 MnYNpe5L+7nL8JORY58GoG1D7lFnVOH/XrN7RCSLGPsiD9GQSMY56TrNXiJ5jZBmCz6r
 o4NBGsk2TIyhUr5l5/3eN+327zrTcoh24PtNnvhfUCCN+1j6eXpuxzqiVb2nHPVd06Gb
 pY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143469; x=1764748269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zf2/DQz7xbz75Ga4VE+1UrE/H7U/K6rZF3lvRiigioE=;
 b=GXgZ/hlC5uHS9IT2VorT2ETpOkGV+hak+Zn2f2qrZqoFJ8xdzvhWWuMNbgiO51elVS
 yJpYJP7KfIc9wvjUIfY37SjZhkv9Ddi4462T9TZRoiq/S5Qjb+kHZz5667cfZMMTGLIZ
 7A3qEchNkj5SGe4bRa0gTeCSuxKAImUezam59Y3Ghyv/PGSzsZILS96RTycSus14Cfbo
 WCp4IA75Q9IctqX+qSD/GAyqma5S2Dyfmdej3+UYP7w+/ICzCMXKid5EYwkwa0gZmPvG
 WuC0a8bG2y8Vx3ASmanYMxSvFVxEqG/AoO+pq7Q1l2YLfE7QeZkDp7kPpapowbO1a9ui
 j8cQ==
X-Gm-Message-State: AOJu0YyJr2BAHCip33ZqfiqxbD+NKKzdFrvFazHtfMfbSEkz2OSmp8/M
 UGlWn93NUPXcZwsqKtyfAG+Qx7YDVGUFQEWVHDqV8qrAsFYYxgV1zA8nfgWxjMLEprO1edgVG5z
 rGGJDKLh8Ag==
X-Gm-Gg: ASbGncsjVvwDL5cHdUsjIPz7LaWG525pXB8x0EgmXsm+muLI7BF3CccKYOG5FCptl0J
 D+1F35sTv3uQZT2WrAUEbzH5eadhpIGznbRt4AiYgmxJiT++zweNu1I2IfJqFwHU6FTODZRywpN
 jEJk7fUFdN+096MFasGe6rQ1E1v90J45fgHBnRur7Now/4PSAZeLhsiiMnZqma3vRIRiq/9s65U
 1R9gEMN/QV68IDLrv5grGWjjOQrYD+ZSRAPBCo8URamIkk33TS3mVpK0Lp/+n9lw99vvT9twfYU
 oNE8gLsYBV6BtwTB386y0IeAg4UE5o06lh5H5Tui/ICLnXgdknxApHt22+yQa7uNZ3i0skd5sp0
 r9tauEGZQKvptbasbYOItCc5+I46nA+n4o8wM3E1PYdWqAnNomBj4Jn92tciHYaZuhzQRmWYLtl
 vgx/YwoiJHFo3pm+y4DUwNq7GFo8fnf9i//JryWzGoEO/t1pg5NlHHX18h3bEd
X-Google-Smtp-Source: AGHT+IF9UFMs11pheKIleB48AlqgchSP5g/McDqBrMdOp71M/+1OkSC3CDqosBbyUcgDRP0TCabO1w==
X-Received: by 2002:a05:6000:1a8b:b0:427:23a:c339 with SMTP id
 ffacd0b85a97d-42e0f20434cmr6071384f8f.14.1764143469438; 
 Tue, 25 Nov 2025 23:51:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm38620987f8f.34.2025.11.25.23.51.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 23:51:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH-for-11.0 v2 09/12] target/sparc: Use big-endian variant of
 cpu_ld/st_data*()
Date: Wed, 26 Nov 2025 08:50:00 +0100
Message-ID: <20251126075003.4826-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126075003.4826-1-philmd@linaro.org>
References: <20251126075003.4826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

We only build the SPARC targets using big endianness order,
therefore the cpu_ld/st_data*() definitions expand to the big
endian declarations. Use the explicit big-endian variants.

Mechanical change running:

  $ tgt=sparc; \
    end=be; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c63eb9e036..bd0257d313a 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1228,13 +1228,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
             ret = cpu_ldub_data(env, addr);
             break;
         case 2:
-            ret = cpu_lduw_data(env, addr);
+            ret = cpu_lduw_be_data(env, addr);
             break;
         case 4:
-            ret = cpu_ldl_data(env, addr);
+            ret = cpu_ldl_be_data(env, addr);
             break;
         case 8:
-            ret = cpu_ldq_data(env, addr);
+            ret = cpu_ldq_be_data(env, addr);
             break;
         default:
             g_assert_not_reached();
-- 
2.51.0


