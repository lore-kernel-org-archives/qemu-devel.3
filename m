Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF6AC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 12:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVscZ-0005PQ-3m; Fri, 02 Feb 2024 07:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVscX-0005P9-Ik
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 07:26:13 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVscU-0006RV-JJ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 07:26:13 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51025cafb51so3176977e87.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 04:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706876767; x=1707481567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtYHIKsaHeZlAB4m2nyixG3ImoxTIbOIOT4XAQ8CMj4=;
 b=KjFYZNM8ii8Aeb1hMty51y1zauSRmgZgaNUNM5+mb8bHn/v4Wldg3WQuTVz3iTSJN8
 Z40tPhZa9NcJrVQdz3ggRrWCsROCcLYTUzXQe6BLDAFQKI5iO9fooOGIJpbWaPoGsFBC
 KBdEb29Mw8cK6PwM3EtGf14R3rHSBAjACt2smAzr4UJTFS5CAoOBs72msyzQT+vZRV5Z
 d7JOZ4KzRq3yGx+QfiTj14uWl4xCSKdRbCIhC11/IXJJGZwz2/jw7BxQgVbQds5heyt5
 9EMy/9disBaE18ie5fVJp+R6eDWcmFsCFzheGohRsDtSbY1SDYYsqWMuCjm6T14ovEhR
 CGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706876767; x=1707481567;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VtYHIKsaHeZlAB4m2nyixG3ImoxTIbOIOT4XAQ8CMj4=;
 b=N01xFxvYVmn0H/EhYOS7DIkQqHTXOFTWBs3C+quOoTgQnX3c3LssSAII7RHW33Jb00
 VuU9yxv3qRm4CcUWF5MJqqdBobtwxdpu83dDt7lqwpuZ5kBOHW70IxK6P16UivVBZejX
 QzcQeu21ZWZGUecnq5+PgFiU+okMXxB/lbl/OdpUm7TkL8U1SRUGxUglVSY0nyROA4sb
 IqKh8og4ZP2syoqVuEA1YK5yBWB3fgEHuddEXFqsKkyMU+yVqoZi91hnUPedeFdxBDit
 gWbpU+fnn7NkcY47vftqr8Q+ASISgH2I41EZOUF/9MH3TYyKQE0v/o/yEdIVcGuJpOsg
 3Sag==
X-Gm-Message-State: AOJu0YzOFyvH1d85fZnikt3zjNVEfdgTRi9Fq9XzNREaq7aROVjb3SVh
 F0HlbaitpwgOedY4dOqTbH0hjcroOXF5VO9CfJVt4gnUscPhy5JwSQNaCq3tD9w=
X-Google-Smtp-Source: AGHT+IFhAB4Mjbd/rPpOJ2+LjTQEZafxPiBETCFPam3R+W0+J0AzzHgNC03VOuOAo9CH/OZdHJqrjg==
X-Received: by 2002:a05:6512:3b9e:b0:511:2ce3:1f30 with SMTP id
 g30-20020a0565123b9e00b005112ce31f30mr1540003lfv.32.1706876767471; 
 Fri, 02 Feb 2024 04:26:07 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW4dZKCc4HTDLAOjdndmbwNgsB6AXpif3Yx8W/WWn9lGLkyhcMj4yg/g4ctG5lpNq7r6SlGE/fWwN8wQi19NTRb8zKDfBUFC6m1FhaLTZr22fya/+4ou2A0DLGHmPaHcZux9dJ1OHcbR7zTwD4fJCJWHq7Hchp6xNDT3wHU2Q==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o7-20020a05600c510700b0040e880ac6ecsm7374000wms.35.2024.02.02.04.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 04:26:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A94975F9D3;
 Fri,  2 Feb 2024 12:26:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,  qemu-stable@nongnu.org
Subject: Re: [PATCH] linux-user/aarch64: Add padding before
 __kernel_rt_sigreturn
In-Reply-To: <20240202034427.504686-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 2 Feb 2024 13:44:27 +1000")
References: <20240202034427.504686-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 02 Feb 2024 12:26:06 +0000
Message-ID: <87a5ojjbmp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Without this padding, an unwind through the signal handler
> will pick up the unwind info for the preceding syscall.
>
> This fixes gcc's 30_threads/thread/native_handle/cancel.cc.
>
> Cc: qemu-stable@nongnu.org
> Fixes: ee95fae075c6 ("linux-user/aarch64: Add vdso")
> Resolves: https://linaro.atlassian.net/browse/GNU-974
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/vdso-be.so | Bin 3216 -> 3224 bytes
>  linux-user/aarch64/vdso-le.so | Bin 3216 -> 3224 bytes
>  linux-user/aarch64/vdso.S     |   4 ++++
>  3 files changed, 4 insertions(+)
>
> diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
> index 6084f3d1a701316004894fcdd739c4e1e0463b68..808206ade824b09d786f6cc34=
f7cddf80b63130e 100755
> GIT binary patch
> delta 121
> zcmbOrIYV-SKI4pu2Kk&{7{Gw#%fuBAMC1c?^>~k}v|avdxNjSSLfftVb3bgJ!|2S&
> z_-6A1CJrVZc?IUH8G;R$7#SF@Om<{a*v!K!&BXX-vIe^~TWO|cva$K*Om;sOMw`hy
> ZxXl@VO#Z-a&zLdUfXALuXmSCM0s#EKC)of1
>
> delta 116
> zcmbOsIYDxQKI4Rm2Kk&H7{Gw#!^9O2L>8U?-5V_M@!kH(Sx4vJn|*ujLPgija~Pc&
> z8DDIEz{J5c`3;N8W)W6tCdL<&4cM*OEF8_<v%@zRviq?xT1-B`ZO-^%@(*r%#)Qch
> RJocPi5ThAdCO2?N002V6C;<Qf
>
> diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
> index 947d534ec1899740edbd6921da6bc6e70e2ecd09..941aaf29931193300de1f6209=
7867c282a7e0c74 100755
> GIT binary patch
> delta 129
> zcmbOrIYV-S2IGv0n)#exSQx<I%fyAxMZTVBQ(04AP_*V|Vxp|@=3D@;x8zb9;-!)U|E
> z_-6A>CVnO!c?IUH8G;R$7#SF@Om<{a*v!K!!o>JyvLd?^n`3BUW_royOm=3Dq`Mw`hS
> dxy>1WOn%92&zLb;lgFM@hy!9z%j7~Xc>tTxDQW-!
>
> delta 108
> zcmbOsIYDxQ2IGW@n)#d`SQx<I!^DNpMK&+G&+g_}w9WI@dn@@euKVesZ-h6`VYFdn
> ze6jf^6F<}BH!LcfMOa0c7+*}*WOrgKEO1Fl%G+GX?#{w!F?lDqIpc@PAGz%r6DAw-
> M*fVlXF62=3DM06owo?*IS*
>
> diff --git a/linux-user/aarch64/vdso.S b/linux-user/aarch64/vdso.S
> index 34d3a9ebd2..a0ac1487b0 100644
> --- a/linux-user/aarch64/vdso.S
> +++ b/linux-user/aarch64/vdso.S
> @@ -63,7 +63,11 @@ vdso_syscall __kernel_clock_getres, __NR_clock_getres
>   * For now, elide the unwind info for __kernel_rt_sigreturn and rely on
>   * the libgcc fallback routine as we have always done.  This requires
>   * that the code sequence used be exact.
> + *
> + * Add a nop as a spacer to ensure that unwind does not pick up the
> + * unwind info from the preceding syscall.
>   */
> +	nop
>  __kernel_rt_sigreturn:
>  	/* No BTI C insn here -- we arrive via RET. */
>  	mov	x8, #__NR_rt_sigreturn

You could have gone the whole hog and done:

  nop	// Mysterious NOP

like the kernel does ;-)

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

