Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289D1C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlSp8-0007F5-Ug; Fri, 21 Feb 2025 08:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlSp6-0007EU-OR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:12:08 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlSp4-0005MD-TR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:12:08 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f2f783e4dso1761726f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740143525; x=1740748325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DjJ3WRWsUIvpInaS1jW9lGpQyT1bUvWawECrMpVX5vs=;
 b=pjWAhA71+u+0YzauFol9mgYXDfcQvD84S4II8AKrwSTUGiRhUVd1ryocRmdVWXaIaJ
 gHBWJhMweEeMkTcDUKpTeTuK1LkbMUcOOC0Oa7Wg1b9dG31t+gKs55NByNuXneFUIgHd
 TpFHMKnKMpSfQzSAXIrGP6kfFo29DHjY3NpmXg9FgevDWJBxYzwfd3C30RPcBcLSCa/p
 SOalLp8yrlD9xLUKjGYqAotR/su7xfKbLcjTTCxenL9UbYFW2j42if9xCp81feUBA2MA
 n98FyInUYqlMXve6dmpmSfxEZmi1wkqfrAsVwpJmzPMtxC7IV945qA8cy0+ek1zj96sW
 +6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740143525; x=1740748325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DjJ3WRWsUIvpInaS1jW9lGpQyT1bUvWawECrMpVX5vs=;
 b=rjpD/e3u+NBPtgc71zDuFY+PRVdjEYTrBmY1UeEjKpmAhBmO0hoZ446FjOEeSnrozv
 4SGDESanGzImEzdnPyIqlABjyjYtbSRdJANO8RgJSeMNRBDp05bV7fSaiVF9/niIOZdj
 eVcisvZG5lWtsFcdGWHTTW5gojyZgwBiFyXVEsWtXyS8j40Kpeag8ZFgnCzwgzOukdKt
 JkFu3FQ9zpg6WmKN8GpdH3NNl6fbJVNOLU2Cx0JtER8gimElHJ+2WoKlU2Eh2rFG0XjR
 f2SEBn16IV5mT1cdeZaMYiGk+5np8K6qLrx3MjPTcTIeCdDVdzsaBmdZSGF0odAgGbao
 xFZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj/qRanqrQ8Ydogoa9tzjKS6/HaZDUJv0LzoVvjfGruurjEVMipOxX2UdHnrg1dQ7i7pr9Bl5b2/GJ@nongnu.org
X-Gm-Message-State: AOJu0YzJOB+Gq4qAb80vfBYIZbGFbp6MdgZgAA2hyj33cbBOF6XZ1OB9
 BUf3X8IalBI2rTmSFuWU7KtndZZvb8j4cBz+2RX7akk91h5veYHSIgLxOA/WsJM=
X-Gm-Gg: ASbGnctjtt3IqqAXKRGgqOlH+0osFLFuZa48FZkhyf2O64xQHyAwszRkuIb0KfB0clu
 CK9uxeJlBJylWSrncVopPr/69SgvolWTuXBpn54DNyrAR9xrv5RdiBiYphy7T6LlPurbQcxvAGr
 4hxKJVhM/xWNETFANUo/Nlz8EKKeXHpQ4a9Fr/t3AaPkYl393FovhU+9KixO6BxHGu1wb1yJrUy
 iFWGxvPkgJIcSh2xPRrmz2uEeNo+LwZ10m90Vifjf+gjmMQ+tWyl8VMaSwhaWRtJXGqDa/2QOsb
 On4bfOptRDs84e9c3scxOYe8D3eFxSREJhWi9Kn22UFc6mALt2LZISBIqk/KMK36GzQ8Lg==
X-Google-Smtp-Source: AGHT+IGWtO8Vc5SdbP71QrsVvsyLAwJc2/wELZPHaNpeUDsQstu2MdJ5mYnb3enDmSvWOorFaokfKQ==
X-Received: by 2002:a5d:59a9:0:b0:38f:4f07:fad6 with SMTP id
 ffacd0b85a97d-38f6e7561e3mr2321728f8f.5.1740143524756; 
 Fri, 21 Feb 2025 05:12:04 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d65bcsm23529734f8f.65.2025.02.21.05.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 05:12:04 -0800 (PST)
Message-ID: <999fbc69-aa91-4b7f-b0ab-2270b89d0f5a@linaro.org>
Date: Fri, 21 Feb 2025 14:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] fpu: Make targets specify whether floatx80 Inf can
 have Int bit clear
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-5-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 17/2/25 13:50, Peter Maydell wrote:
> In Intel terminology, a floatx80 Infinity with the explicit integer
> bit clear is a "pseudo-infinity"; for x86 these are not valid
> infinity values.  m68k is looser and does not care whether the
> Integer bit is set or clear in an infinity.
> 
> Move this setting to runtime rather than using an ifdef in
> floatx80_is_infinity().  (This requires us to pass in the
> float_status to that function now.)
> 
> Since this was the last use of the floatx80_infinity global constant,
> we remove it and its definition here.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   include/fpu/softfloat-types.h  |  5 +++++
>   include/fpu/softfloat.h        | 20 ++++++++++++--------
>   target/i386/tcg/fpu_helper.c   | 20 +++++++++++---------
>   target/m68k/cpu.c              |  4 +++-
>   target/m68k/fpu_helper.c       |  2 +-
>   fpu/softfloat-specialize.c.inc | 10 ----------
>   6 files changed, 32 insertions(+), 29 deletions(-)

Passing float_status argument to floatx80_is_infinity in a preliminary
patch, this becomes simpler (to my taste...):

    4 files changed, 19 insertions(+), 18 deletions(-)

-- >8 --
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index dd22ecdbe60..e1732beba4f 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -332,0 +333,5 @@ typedef enum __attribute__((__packed__)) {
+    /*
+     * Are Pseudo-infinities (Inf with the Integer bit zero) valid?
+     * If so, floatx80_is_infinity() will return true for them.
+     */
+    floatx80_pseudo_inf_valid = 2,
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 1fa759779ea..1c8f3cbb78d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -963 +962,0 @@ float128 floatx80_to_float128(floatx80, float_status 
*status);
-extern const floatx80 floatx80_infinity;
@@ -1001,6 +1000,11 @@ static inline bool floatx80_is_infinity(floatx80 
a, float_status *status)
-#if defined(TARGET_M68K)
-    return (a.high & 0x7fff) == floatx80_infinity.high && !(a.low << 1);
-#else
-    return (a.high & 0x7fff) == floatx80_infinity.high &&
-                       a.low == floatx80_infinity.low;
-#endif
+    /*
+     * It's target-specific whether the Integer bit is permitted
+     * to be 0 in a valid Infinity value. (x86 says no, m68k says yes).
+     */
+    bool intbit = a.low >> 63;
+
+    if (!intbit &&
+        !(status->floatx80_behaviour & floatx80_pseudo_inf_valid)) {
+        return false;
+    }
+    return (a.high & 0x7fff) == 0x7fff && !(a.low << 1);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index df66e8ba22a..56b23de21fe 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -112,0 +113 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType 
type)
+     *  * input Infinities may have the Integer bit either 0 or 1
@@ -114 +115,2 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType 
type)
-    set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero,
+    set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero |
+                           floatx80_pseudo_inf_valid,
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 73789e97d77..8327f727861 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -240,10 +239,0 @@ floatx80 floatx80_default_inf(bool zSign, 
float_status *status)
-#define floatx80_infinity_high 0x7FFF
-#if defined(TARGET_M68K)
-#define floatx80_infinity_low  UINT64_C(0x0000000000000000)
-#else
-#define floatx80_infinity_low  UINT64_C(0x8000000000000000)
-#endif
-
-const floatx80 floatx80_infinity
-    = make_floatx80_init(floatx80_infinity_high, floatx80_infinity_low);
-
---


