Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A62FCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtw-0003Lr-At; Fri, 08 May 2026 11:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt5-0002dY-2q
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:11 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt3-0001ek-Ig
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:10 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so897815fac.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253188; x=1778857988; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uvnFQCXHEy097J+U1NUH1ixb08fX5jBONyYik2NH3Mc=;
 b=XuyumCsajueBXXWcZ+4hJQyyjJPAZcmMoE9cGwCICF5sgj4Y9OKzpq8QykISDzpUwC
 c1bHVr6tjcllVSlyXYD3EqP+t1JzewW1JiayElTMHwSRRXv53xTwqNJX9Y5Jv3J+yZuo
 FurgvYFXmgNeKib9PpdELHRk5TjZl345eQbWMko1ZO6/K3Nu7f/3pDkEoMcRylNpgvt6
 ECrkmiAKS9fYp+hDl2bSsKTgKFOutuLGP3LsGetCd7HNQQROcyv0wrFblWDgoOnDKoed
 AcWHQ+VgaXuAjacjmsnnPWwizZzSjbb+xZ81T8KsaaEACAg8e5HFIuj8FRIGsyfRQN6g
 E0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253188; x=1778857988;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uvnFQCXHEy097J+U1NUH1ixb08fX5jBONyYik2NH3Mc=;
 b=Te9AwTw4K90krcYxYhi+H1mf873GGftMpYfze36nD/Q+3xIkS5Opzsxx7IlSmVshZL
 X2vPYMf1AyB38yqczgXgc6qaDpnK3AzGww3EggZoh7UizKvtSPNfWp3fFCiFud5l6yqo
 46UOdEfuE6odLATRAxnBMeYAvotx19Zf2Zbfg/3mf1q7fRMJ+lbdOA247rAio83jWSea
 dOk4LwatJCAPgoJOrnx3DQCv7M+s94LPEhyaYidmEqLywQ2OvSm8aMX5Xvt8In6PHsOF
 rVnDN5AZkYUOpuiP2xXEf6lStZGVnUCzcFVMRbIP6YAIPMcLzQXtWAfquSqR3BM0EMzS
 ltUA==
X-Gm-Message-State: AOJu0YyFMxxyLKOTdN/nsYk4hJw5UK/8XN8kXOSp5jo7Fi3mMomRlIv0
 LS5MgbKsaP1uWmhhF015meFkCm7jnSRUdSHrNnBMHH9AW68B53/t0BLgzHLuWw==
X-Gm-Gg: AeBDiet1c2qPIHypE3zCdArVH3j7kbTmw+9qOwNAC4hJMT101U202BhJLkoTxPSDeah
 lna4MJe3JuhdxTBdQ4l7qdPk7/dZEsvsFMnUa7zTSBMNm/vkOvNJ139aekZC3jxWSummG7BFLLd
 3KBx6WlctHyZ9EkJKeu0ggyX5p6mzGBOcfuEVYmJ5Vy3WTjc71C5k4ZYRMwXvz6Ao5DGP0dc64w
 ear92AgEgpi3oK9qneJ/jV3lLofYS+0Jv4mBmcA/+KkSklTYTnh/wQwgtOL9UA+GPsg2PJ6Luhj
 wecSBkxVkp2krVP8LTS0kIw42jRCagBq/VS9g1ztzjqB3ebX/g0XxNgUcddB0MVEXHhb1HBK+pn
 Uy2R8NwgqL8l3481Ga2T2kz1ffwsILC873JNLeMuB3oo7PbV8vAn8gRW8ioZJOFlCB9+MhAP7Pd
 WWUWy1xXUYDNRbyvNu9RlFpx7aibfdPtd48w0wK0I++K8iu2OQDb3uTl5+WRIm3L0OzOARZ9rH6
 3ZQcZed5zJLmFO+VRvH5nCO43TCMVVPNcK0giKqLpREjmAqNyeJEG12i7w9sXMEuT6cadqSPM21
 pC4uICbd9NCAkTkGz20/yajDzs/64KpOnlJXShxiwTdimu88qqLI6kNmmoNdX34O6LNnxL3aJrT
 52KmMLQ==
X-Received: by 2002:a05:6870:c69c:b0:423:9228:7d37 with SMTP id
 586e51a60fabf-434f588f648mr7435994fac.16.1778253188171; 
 Fri, 08 May 2026 08:13:08 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:10 -0600
Subject: [PATCH v3 10/32] target/mips: add Octeon LWUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-10-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x29.google.com
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


