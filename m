Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3980D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3Si-0005TY-I0; Sun, 11 Jan 2026 16:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3Sg-0005Sq-V3
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:59:02 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3Sf-0003uz-Ah
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:59:02 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so59098995ad.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168740; x=1768773540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwX2WyW0Mkw+5cxrd/3E0Z7rlg0VrOsm3MpTq3nX9Jc=;
 b=Qjih0D0/ajr2WtVjp0BX+pUjXuCI20SzO58GPUk9bsU4nw6h7fGPLjGtggUEy/FCP5
 qGzPayUubHQPOBiLHuSO2aNj0EX9IEWa9Ajif/zhhtoRVNHUrqmSQVyzK7GZGjgQtIEp
 V8sy3tMBqcgb7gJXYhJ/J/BRpZCGhHg2Ih6kHY+6/hvH362cbDdZI6WqmY2y9C+1xoqE
 vwUhk9K2HPGteUklFzFHWjhs1ULWB/X6ldTt0+5z6S9lvzqWLorCKZIs0Zxkyvac7i/8
 Rta9CH8DHQCSFCTEEfz5TA2eLdDwnYg3up9SDedY66lV9Rdm+61gtGmQNhX49aPQSHg3
 2byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168740; x=1768773540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JwX2WyW0Mkw+5cxrd/3E0Z7rlg0VrOsm3MpTq3nX9Jc=;
 b=F8PLvAvsyZVm33t3Vz996T04wowOb7/0ttiiiYlr3GpyogrM6b0KZvfnXBJAElnWos
 oorYMbsABlCbYygzZnT90pJ6R8X+Ik3wmTn4NeYAV4iirSiIcdN0jkE93Uyh4JCgsiOy
 SQlcuNCuAuYebEIrIq9iNsQeDzwTqd8tXob6SVluGOW8JUej6PJe9CUN06W3Aoqqe37E
 Ffqw9miqMthDhattfTQLGQ21pBTLgNmQAfQAFHqH+sh8/XXh9tBvpf41CtIS4JuKgFue
 tEEd74TLjhGaVVIIh76qKO0p1b451Nb9+TIgDe82OPUwtaJMewZOoyhIFcKNijoDvPib
 e3MQ==
X-Gm-Message-State: AOJu0Yw9IV0RElOPjQSoW8x6VSl4zGXjEEN8MzO7mY23C90M2ONzTWSu
 uwq88FzhIqGmzyCZU6zsLR4dL+ObZov+arkb35WTuIPV2Y172+lWretcpZyoV42nUW6pNBlpsgw
 dSF+T2wA=
X-Gm-Gg: AY/fxX7jOOxpsl980bqjO7V5F0iYNsx+2q7QfeusjuSQqfWZU8IkYbmrg+h+f0NAF8V
 +Bg6MDubXdnLO3FJRyA6vPTkj47jgPz8Yjq062e4ujsVrj679QGuA/jCBIpZ+XloIifpzPdaE3Y
 VCMvqGPDf2rDsokwOjB9cPtKKeXVIqJ12PTw6car51QokHQWiewvdA3IvgbpMqidrEEh9gi/MJE
 vH+g10Fcf9f7TyoYMoXMY7LKJWKLkdiSDJDNym9z/XdooExJgWLQN3VcS3F8CsEwTdatoPeZ/9p
 KOaRaCS5hRjd42lHUtgRdTIKUswFpJ5hSaZ824wvE6OSRqU5eNKAEg5XoVMiXZXjlgkAvfM9bOx
 MselMFCGkPPIJtKbgCpQOFpioEgz3u0D1/gaCO4q2ucBQUHxIroHu8GjF9DURY1dMs/jEmKlpPx
 BchMoCVr+fjo3sO8s=
X-Google-Smtp-Source: AGHT+IECdf/uHoYtjvvADcML59CoClcUke3Vf6d9mwKkNdZL5seZ2a1fhqD7QCZ9wxnGVypLVhSUoA==
X-Received: by 2002:a17:903:2f8a:b0:24b:270e:56c7 with SMTP id
 d9443c01a7336-2a3ee4137cdmr161464095ad.7.1768168739898; 
 Sun, 11 Jan 2026 13:58:59 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 13/13] meson: disable libatomic with GCC >= 16
Date: Mon, 12 Jan 2026 08:58:18 +1100
Message-ID: <20260111215819.569209-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

Historically it was required to ask for libatomic explicitly with
-latomic, but with GCC >= 16 apps will get linked to libatomic
whether they ask for it or not.

This invalidates QEMU's check for atomic op support for int128
which explicitly does NOT want to use the libatomic impl. As a
result with GCC >= 16, QEMU is now getting linked to libatomic
and is activating CONFIG_ATOMIC128. This in turn exposes a bug
in GCC's libatomic.a static buld which is incompatible with the
use of -static-pie leading to build failures like:

    /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/16/libatomic.a(cas_16_.o): relocation R_X86_64_32 against hidden symbol `libat_compare_exchange_16_i1' can not be used when making a PIE object
    /usr/bin/ld: failed to set dynamic section sizes: bad value
collect2: error: ld returned 1 exit status

The newly introduced -fno-link-libatomic flag can be used to
disable the new automatic linking of libatomic. Setting this in
qemu_isa_flags early on ensures that the check for CONFIG_ATOMIC128
still works correctly.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260108141407.2151817-1-berrange@redhat.com>
---
 meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/meson.build b/meson.build
index db87358d62..56df08c10e 100644
--- a/meson.build
+++ b/meson.build
@@ -445,6 +445,15 @@ if host_arch in ['i386', 'x86_64']
   endif
 endif
 
+# GCC >= 16 automatically tries to link libatomic for all programs.
+#
+# QEMU explicitly does NOT want to use libatomic for int128 types.
+#
+# Later checks assume we won't get atomic ops for int128 without
+# explicitly asking for -latomic, so we must disable GCC's new
+# automatic linking with the new -fno-link-libatomic flag
+qemu_isa_flags += cc.get_supported_arguments('-fno-link-libatomic')
+
 qemu_common_flags = qemu_isa_flags + qemu_common_flags
 
 if get_option('prefer_static')
-- 
2.43.0


