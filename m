Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E3606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JFrrkWNA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLpcG-0002Rv-Ld; Tue, 27 Oct 2026 18:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLpc3-0002Qz-Ql
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 18:25:49 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLpbz-000391-M5
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 18:25:46 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6de2f213b7aso233429eaf.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793139942; x=1793744742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AHEdzxP53w6gXeHKfqR1/SqMcsr59rLohwICBaccrbA=;
 b=JFrrkWNAsBt/ep07jcKgZtN0aM3lqAV27Cj78D0xK6LF2RF9xrnohoxQ3nrpzC6Wom
 8KmFzpKS0CvZA7qgYRt9KGE+nRFMoQfX7aR/0ukSqHC9x+YbAU4f+i7E7sp3X+8w8qIK
 43TfOOQIaiJt9KkLiTOlO+VREO6inVi7VCXdv6QFSUK2+Tg18XeX+OoVtG+aoDyuOCHZ
 HyUQM80wN3rZxTmpNo9qCH+zr8ENjsuwQswC7Ni+h0fMZxwVsPaUzjtGM87ilgbEXQ17
 Qw6rRuPMvHpMftfvJHmSudwoBAtvg3FBGSlvDtpTu4eMMV6SprnSzWBLLA3QQetS7+jZ
 YBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793139942; x=1793744742;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AHEdzxP53w6gXeHKfqR1/SqMcsr59rLohwICBaccrbA=;
 b=TzZ1rDgldz9BjArenc4iT3xEJ2NSj5rfJn3gvtoMtAG+/HVHdSPCxDN7at18MVRCRY
 K1itoSTP7DG+j9W30a+QzWm72CL5ovbAkMTAJ9/XRvZR9YLl/n8xuncDA3/Y7ToI8GF/
 xiT2vr9BP034QONIx/0HSbvFFsQY16roh/k20kA+xn+Af5Tm/cJ3PAF3Hq9AVP5aSGIO
 GJEwnehR9NGuMFBtMb5OZugAxJaQhpgTkZI0emBWb6Cv/J9EqU3yztOKRbM/3LteiGDV
 PGg4S+NXN1FVGe9RUPU0GMQddW/5+/6QQ0CxjoQ2Pmp5Fr9qTxhNHqtl+AnSHEaLu/an
 SE4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzu1RADkHZGFanLmvoI2pY2Im8+6m4SS/csr6g2bQ23zZTuNIRahBjp/BETk4jWruAoHcR7m0DMMfux@nongnu.org
X-Gm-Message-State: AFq9FYLLwYhAX0Q7OyJqYqKaCyqLdLCikhfvHv5ytGmBjazcp7LaCPk6
 SnMKDAlLeSNpop0yTDqdScFAeLJAl8kOCejGxKQeCoPgbemzWr5C+RIRwAf8t0X1bDw=
X-Gm-Gg: AYBFou0oiBhMkuZqLOV+ohQMz9+qpA60LUtrxmvSetlxs7vXhp9Gro8COtNH6Abb4wT
 xMFrEnC6Dff4VaFokkl31ojUM6xAvBtqAkloknLrRivWGvnsYR6fCHfH91VaGmgH9gHTxaIK5UE
 85IjnSUOMhvdxttXXhFJXFnhDYQkB2MicCHJMUkgsBMeU6szJIIjhgF515ifarCx4xyGGNXBN73
 PO8R85dFy3i1XKP+T4jp+YQQV53vUJ8QyHQQQGthA43cS7z1K58oo5t5rYY8CT4L3paPolcSBGX
 PR2htA0ZcINpVKSjFYjT0vQgD8AOIqFao/cm6P4x4vY7zkgLgTsfZIj/JVk0xbbO/dX7gXbkcqu
 ntduHTKq2pnQEHTC33hLT+MUhc8F6XURx48UPLjw4L8x0z5nGy/fqycg+5vggzsltLTCG2Upfcr
 h25lhH51eYqCQcuI1iD2Ht+BPQiFRriVWQt/LZHnwVlrXR3nEKh7MOv5zi73F3Ds/LwdCo2CPRG
 Ym8O65HxSOuy1m54SSKFDKxXTLv6H1TaY5yCgHJen1qEQTnsFlumblUyb/LxLMfpgD1Yds=
X-Received: by 2002:a05:6820:f00e:b0:6f6:61c5:d929 with SMTP id
 006d021491bc7-713ee668f41mr337378eaf.38.1793139941644; 
 Tue, 27 Oct 2026 15:25:41 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b793fe7csm1055007fac.15.2026.10.27.15.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 15:25:41 -0700 (PDT)
Message-ID: <3b159884-d374-42a2-a940-91dcd6576af7@linaro.org>
Date: Tue, 27 Oct 2026 17:25:39 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] s390x queue for 11.2
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20261026140153.2072253-1-farman@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261026140153.2072253-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 09:01, Eric Farman wrote:
> The following changes since commit 288b6c9e78913401fac4880b3281ce431540b8df:
> 
>    Merge tag 'pull-nbd-2026-10-08-v4' ofhttps://gitlab.com/ebblake/qemu into staging (2026-10-19 10:54:44 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/efarman/qemu.git tags/s390x-20261026
> 
> for you to fetch changes up to 2ddae8799cc52591846f3a0a901a77e2284f8751:
> 
>    MAINTAINERS: Update s390 boot reviewer (2026-10-26 08:10:58 -0400)
> 
> ----------------------------------------------------------------
> s390x fixes/features for 11.2:
>   - Implement resizable vt220 console
>   - Deprecate dependencies of deprecated features
>   - Reclaim DMA slots during, for example, guest reboot
>   - MAINTAINERS updates

Applied, thanks.

r~

