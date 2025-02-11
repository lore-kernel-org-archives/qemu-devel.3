Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9E7C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thstS-0002xg-UR; Tue, 11 Feb 2025 11:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thstI-0002xG-CA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:13:40 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thstG-0000yF-4e
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:13:39 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dc5764fc0so4390780f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739290416; x=1739895216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KGqldNwFIhB9ujlMAnc3Z8kCs6IlQj3MKUbPAMTaMxA=;
 b=tEVXqIJOyYMfp3xJweajvr1Q+yBGxQF+vYxkCHxkGmSdpUhzmTpsIZW0IGgRdODHv9
 lj+CALujd7PoH3d98nd/LYMTE2ASSNRjZNRBY8m6DZB/cyVQFiT+QgIQ2BKmDND27pVP
 A7JQrttfyGNOI99counYWPTm0bliHFl+nbvKIGZPe14nJy5ytOjfHRgFXECjb70S0zld
 tjMTGXvdDDIx3elv8lQ0E7CewL31OS0sFeOdqwSLzj+A+AscVGzda+q6M5kjAmJnNtAc
 P9wMnuoibTwB5wqAGW679+wkmvs088WRnypW39Pepk9HXHJt05+ZESScSVpO63aMUXDC
 t2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739290416; x=1739895216;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KGqldNwFIhB9ujlMAnc3Z8kCs6IlQj3MKUbPAMTaMxA=;
 b=W22IUlob8gPuJ+/YodPHEnnq+jBeLLiY5fy4v3ryy9/zAqrZDTxhcpZSykmmp+EZik
 fSE+2eEHeADReNGqE94JpIJFFrmET8sB+TG/wVMq1in9k3bPIaK9qY/FzoL/vObAK9BJ
 PaHsi7rfc+OZ1XlZZ6Ow4vQxIA/Ocr9ANys2yYKE2Qgpkn1lJQ3dqs/Qw3mjLwJ5aBI7
 ba29x2SrUEQFa96li+f4TiscMziayjDcYc6zZEd7/9QvibYgOKMtjdRh6XXXglE18iRR
 3x39py2qAmb7WMeCbZHahUO2EtWtbnF4Q35jpLtxCSXiH5i3XKP1Xt3ODfCad87MQPrz
 qrSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhGsuDPBeeTdW0IdpYN3GzIhBaOQCzkzRodS+SmHz13XXvMLJ7Zkerix/+IX/top01QIIMFv7FS/5q@nongnu.org
X-Gm-Message-State: AOJu0YwMuXrlV8XEr7uslx28I27v8GLxrleyGbX47fiDhOEo0LwMKObQ
 AHHDIK2rFx2xBEhStaixN6QAiNGroum3HGTpzY6SbQsouCH1/YWYSUl3Nlylbzq+VnpPbuNzvId
 Q++E=
X-Gm-Gg: ASbGncvBcdGPNF672cX6QLgeThVmmH4dP4NQJ950iw0KTidIGDqRAt36QbPAuARNhAc
 YDQehaZnXFFpz1MUV8QfL3W7sfp8VxqJOhhHOLwoTGdSpQf7G/c6mZSTZk0IL4eEiMjSyswQL6b
 arv+0A+p6wW5ImjL0d0Ckmg8h+/7lYbZ+Gi9ebLGhj/psHt6bPUAucNEYI2uwfBJeV5hrAZYBY8
 9pHXyKjQ2nHey0EdSuMsyfvqA0Bu2PYQDaaX5kpu9YyuhYOvfmlZ/fCyD37GGiKrZKhKi6tVDI2
 ZHTjQxiyF3fRCql1lo+LjOQK1DjMticwojNtJyHs0S0A4E91CLJIBkeUEjM=
X-Google-Smtp-Source: AGHT+IGNnndkADTnd17pddj65BXNiFC0Cu37B+sUdXggpeN+Q9zLNom4gOLNeyuEMZs5t+H0Ep6Xow==
X-Received: by 2002:a5d:4c4e:0:b0:38d:d603:ff3e with SMTP id
 ffacd0b85a97d-38de9280c11mr319502f8f.21.1739290415699; 
 Tue, 11 Feb 2025 08:13:35 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43935c4f4aasm108896115e9.22.2025.02.11.08.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 08:13:35 -0800 (PST)
Message-ID: <97794727-4298-4770-bb86-c66bda7605ca@linaro.org>
Date: Tue, 11 Feb 2025 17:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: Don't corrupt error_code with unknown
 softfloat flags
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250211130626.3940412-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250211130626.3940412-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 11/2/25 14:06, Peter Maydell wrote:
> In do_cvttq() we set env->error_code with what is supposed to be a
> set of FPCR exception bit values.  However, if the set of float
> exception flags we get back from softfloat for the conversion
> includes a flag which is not one of the three we expect here
> (invalid_cvti, invalid, inexact) then we will fall through the
> if-ladder and set env->error_code to the unconverted softfloat
> exception_flag value.  This will then cause us to take a spurious
> exception.
> 
> This is harmless now, but when we add new floating point exception
> flags to softfloat it will cause problems.  Add an else clause to the
> if-ladder to make it ignore any float exception flags it doesn't care
> about.
> 
> Specifically, without this fix, 'make check-tcg' will fail for Alpha
> when the commit adding float_flag_input_denormal_used lands.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I guess I forgot to run a 'make check-tcg' for all targets until
> I was getting around to queuing the FEAT_AFP series :-/
> 
>   target/alpha/fpu_helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
> index 63d9e9ce39c..f810a9b6a47 100644
> --- a/target/alpha/fpu_helper.c
> +++ b/target/alpha/fpu_helper.c
> @@ -476,6 +476,8 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
>               exc = FPCR_INV;
>           } else if (exc & float_flag_inexact) {
>               exc = FPCR_INE;
> +        } else {
> +            exc = 0;
>           }
>       }
>       env->error_code = exc;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

But (pre-existing) it would be clearer to not use the same variable
for 2 distinct things. As a preliminary cleanup:

-- >8 --
diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 63d9e9ce39c..d1a17b71423 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -455,26 +455,27 @@ static uint64_t do_cvttq(CPUAlphaState *env, 
uint64_t a, int roundmode)
  {
      float64 fa;
      int64_t ret;
-    uint32_t exc;
+    uint32_t exc = 0;
+    int flags;

      fa = t_to_float64(a);
      ret = float64_to_int64_modulo(fa, roundmode, &FP_STATUS);

-    exc = get_float_exception_flags(&FP_STATUS);
-    if (unlikely(exc)) {
+    flags = get_float_exception_flags(&FP_STATUS);
+    if (unlikely(flags)) {
          set_float_exception_flags(0, &FP_STATUS);

          /* We need to massage the resulting exceptions. */
-        if (exc & float_flag_invalid_cvti) {
+        if (flags & float_flag_invalid_cvti) {
              /* Overflow, either normal or infinity. */
              if (float64_is_infinity(fa)) {
                  exc = FPCR_INV;
              } else {
                  exc = FPCR_IOV | FPCR_INE;
              }
-        } else if (exc & float_flag_invalid) {
+        } else if (flags & float_flag_invalid) {
              exc = FPCR_INV;
-        } else if (exc & float_flag_inexact) {
+        } else if (flags & float_flag_inexact) {
              exc = FPCR_INE;
          }
      }
---

