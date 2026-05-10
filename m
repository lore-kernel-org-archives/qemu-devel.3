Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E159CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgH-00069o-4F; Sat, 09 May 2026 22:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgE-000692-Hc
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:06 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgC-0002yd-Ql
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:06 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so1645387a34.0
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379242; x=1778984042; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uvnFQCXHEy097J+U1NUH1ixb08fX5jBONyYik2NH3Mc=;
 b=ndJMmiabP2YSLL6z2KesNC2P0ZsYoVIPJyq6CMInmAqFRZzVDTqKTq4gvzSylaIZaK
 Hyedjy6ejZIsMK+1owi7kMqzicX0Ait20lDm7Uk0QURtDGbgmUpnK2tF1ZWjpfweLmw1
 e5Y7mh6C+WUpaVEubWWGth/lRpL5/HVOGLE0ly005dY4wjLIlxLgFhCF1LA9oGWv3LMV
 tgqMjGLrmZAooWJRkCRXYr2BUX9gNJWlxQG3/+p7rK2RTaq6FMcxphgeUlmeX7sp6sYR
 Bsca5Tj5KA5Nuil4uLQCHnERbGpq4AZUNwvDHlF2rMeZNG16FsZUDFB0hD5tpYy2FIPI
 dJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379242; x=1778984042;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uvnFQCXHEy097J+U1NUH1ixb08fX5jBONyYik2NH3Mc=;
 b=BskerG1Lxqcs7Ms5l8xhPXocGhgz3II54tIxHYgk4MvmFRFu50k5313j6umLbKocXw
 r32gvX+KZVNfhMzosTff+bMuuhIY1fGotiIHap6UhJsqoMDwXN9XNSH1gbjnY4luDpaa
 EHKNVi1rqp5zrlhTPXGo+3FcpTB2inlIgltHoKeugfA9u1Lt8Yb/zC30wxVZ9ItdUcMT
 H19GN/GVm/S588ZVYE12CrYj0PxJaf+fmunwd3ZKYb7i/rkJ1sv1UGrFTCm6Zv8VpvVv
 eGqaSmV4t7ttekxwhwpZcsJED3S9JMRSwOV8Qm3NEMH0DtVbm8Qt2JXvde2GVZUKgzbf
 LvHw==
X-Gm-Message-State: AOJu0Yx9bacJoX1q0T0SsaEf+dYr+ha/NWPoAL0zJ52dfu1E2iv0a+3Q
 DYCYCq9n+r2NWXWfn1N9gmyVYKdwHwdpMJomXV1dLR7KoGtXZ5NUltumiW0s8cke
X-Gm-Gg: Acq92OH9EQR4fKfWs26CYTsXEAfF4rrHcgYs6D1CdPJa/3O6EMD3FBqMDfcpmXHIQI6
 p6SH/G0zyLDT3ju2xU3JWp+7IbDFgoxE6QzV6NaTMotBJ3jxhAuyf4w8uxLicKVpj6fFcXEZRnd
 yWauQXhyYQ3dbjtaZ2wMnf+34U8FHnIyoEYdG9boGKM4GtOuPTflbcY/+pUwa08kjTWxaN/J9ix
 /jIda4dsn3IEpLtN3C8XnHfi3HTzA6ubuS63sW62+bZ/6lVfRyJRNks6zDJ8lxsVWJJO2YeUPLy
 X2A8n5mkXskX7H2xEO9tKt9RhvMYOr4rt6dlBJkUVXzzJsNb9Gr0nmTRpNqPN96dLcw0lVyVTze
 y+rWQREER/jGWM85auKSpDI03iMxysg+4EC/YC7AQrfkVNwRooMYejuqN3RG5Vkr3ePQS93Pk9o
 V+y9nKGX1ucutWW5Vs47Lh8FY2wmLrXRYh8Hpsm5jk8p0ZDlZuVrT/1J7e9I0uu26V9lB0hpX9i
 VvzrHhxVNL6rAtoQyDqGJQ1u6yQDPmUmovy1nfXE6ktuTztSfsMlH3VrYx5p7qZ16QrgJiX1qi3
 dM0=
X-Received: by 2002:a05:6820:16a6:b0:694:8cb0:4efb with SMTP id
 006d021491bc7-69998c91a22mr9693857eaf.8.1778379242342; 
 Sat, 09 May 2026 19:14:02 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:33 -0600
Subject: [PATCH v4 10/32] target/mips: add Octeon LWUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-10-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

LWUX performs an indexed unsigned word load from base + index and
zero-extends the result into rd.

Add the decode entry and route it through the common indexed-load
translator with MO_UL.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LWUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a755075e8..db7d5f55f0 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,5 +50,6 @@ LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5a189c6484..c93eff59a5 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -166,4 +166,5 @@ TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0


