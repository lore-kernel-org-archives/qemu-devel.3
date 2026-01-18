Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C8CC98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxK-0008J7-Di; Sun, 18 Jan 2026 17:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxI-0007zj-9s
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:08 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxG-0001bn-Oo
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:07 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a102494058so22845135ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774145; x=1769378945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cyYL4DVaKa33AbZpjE1YQS7WRtchLKWVUrU1QN8V2g=;
 b=YyVtVg5wUMi7A6/rmNNS221NcLzH5rKQ/JhFjTKUAD3A5NCfSD2FOJ16wRieUFoZ0s
 IE7hwhnzGzabLKG2S9KdWbAwuukgpxPm7pJZmCs/bRWvEwhAZpja7HYzHDb0zBdoa1VG
 hwwumqiYZLw2x4kSKZAUYvtvrMmsuNHzk4z3qF/A2fYVBKvNMrhI8V6qLzas9hDchNDm
 gEmzZDFtp2pKCuVAXMsJmwk6Dn6/AQ3nostlDpWeXO0FtHC7AmiBaI78ezovL7i+eb9w
 vzgB9HRvyii9BZpbDjCGVvgE1iXP+sYSlserqFf5hosE2byRGOAc4P3zyS48rE7U0t3T
 g+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774145; x=1769378945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7cyYL4DVaKa33AbZpjE1YQS7WRtchLKWVUrU1QN8V2g=;
 b=aZkz+fwurAoGWWFgn/W7v07Mbrvm4wLojEP9X8JoveE9sD738GjqFgKcroxDLRtWdW
 6t92/BpKtIz/6RTUxSblF4pWiVbCtu02+DyFgQoeAf+UQu06+GXjZqdg/3Gm7d4Ka8r2
 zWpFOdlA8yQ3Zhb1jYjjfSOmTbqqou6iBDHAcg42bEa1/QRX2yxmzZItZ8Bf9njvwf13
 ztCfgJ2R+z3JCjiHAbuRB5+3VBKW/rG6oMZWAXse+y+v29o0BNX1Ibwfov6w79s30TgC
 xeZQ8t0TlUYPQzw87/MmIDMX7yoYbs+p+QrSI2woDrik1Q92v0OlktJDSUBB2WtB9mCI
 hUBA==
X-Gm-Message-State: AOJu0YxeP7AiqHKKxPiE2YeqbkEv86B803KgBCxguO6CYobrodAu+n3Y
 zUdRFNLHnn0yDULSvUocdRxkXc9rvQehO5K9JeHxMGtqHDHItHKgHWcvXFjh0BQ68deMvnPYBm9
 QfB1/9rB3oQ==
X-Gm-Gg: AY/fxX5CGVN38creUrYkI8DCBf6r+HgVn2h3nHwF+2afg6NXV0Oh1skOUQKleShSl0t
 ZoIYEacIeBnyzbQtco7vsmesYOrt2iHwBAD1YKZDdtaSRgq/82RVo9TQimY+ObBK+H3ZxnNFp02
 I4Z1g4305SsGK3Rq6o5NaAWoc0MuH9h69TZYaJjYYne9d/1Lg18CnWXe+NWAPqTyB2UFsbq7jaq
 4iFVYGZGfavG7nyP8vQuhVtZCI3xSGs8pW81GQZ5VjTWMUvnwsjQopVCXcYt6GSBr/WaAKfbjhU
 kcOqZhm+I9k2yih4zjlPmHMyo0QtP1Oy4/wtwDJ0JS6bO8Aihsk1YdBUb4moBw0k8ZB6BQc645A
 DIPSLsWl7jSw2fujetZVLlgQrLSdZtap5DBx1FnJKeu/ut49Juh/edJGzjKVnOrb1Cj04G1tfbg
 RE65LmYIGrkK1bvnBpeGsgjOCapPW1
X-Received: by 2002:a17:902:f686:b0:2a0:e5c3:d149 with SMTP id
 d9443c01a7336-2a71780a3e3mr79236195ad.23.1768774145138; 
 Sun, 18 Jan 2026 14:09:05 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 43/54] linux-user/hppa: Drop CONFIG_ATOMIC64 test
Date: Mon, 19 Jan 2026 09:04:03 +1100
Message-ID: <20260118220414.8177-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/cpu_loop.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 356cb48acc..e5c0f52d94 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -83,20 +83,8 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
                 uint64_t o64, n64, r64;
                 o64 = *(uint64_t *)g2h(cs, old);
                 n64 = *(uint64_t *)g2h(cs, new);
-#ifdef CONFIG_ATOMIC64
-                r64 = qatomic_cmpxchg__nocheck((aligned_uint64_t *)g2h(cs, addr),
-                                               o64, n64);
+                r64 = qatomic_cmpxchg((aligned_uint64_t *)g2h(cs, addr), o64, n64);
                 ret = r64 != o64;
-#else
-                start_exclusive();
-                r64 = *(uint64_t *)g2h(cs, addr);
-                ret = 1;
-                if (r64 == o64) {
-                    *(uint64_t *)g2h(cs, addr) = n64;
-                    ret = 0;
-                }
-                end_exclusive();
-#endif
             }
             break;
         default:
-- 
2.43.0


