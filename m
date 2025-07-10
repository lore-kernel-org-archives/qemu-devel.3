Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95770C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsxw-0006cq-MN; Thu, 10 Jul 2025 11:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZssm-0002GR-Np
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:08:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZssk-0006F3-QA
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:08:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so1090302f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752160096; x=1752764896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BUnCbiv5ercKFDLix/SpHhgaXGyJI31mUZMLa6N7LrA=;
 b=gEqmZPMzSa5hV0MMqcsmt6Xcrx61G6ABYS7/4EfIltjoI9HeQFhMR4ibjXB2w31yp5
 LsmyiXoOPyHDjCsj8GV33Or4HJfUiheOrdRsP0Ge2ygjS/NlZ/sf55rKBY9hcb4U2CnF
 li8EU8T0fGQvxMwwwlmbc/7UmE2jlFmETdvw3Q2CPrT2dCde+mUKxbumnHnTLdu7KTh7
 00WMPkV+eWwepETPZUzdlIecgDq1+R7W0IUfNJYg4WnNj6jVzkUZCJrdAG3JuDJzmHym
 Ntot4JmJw3ZsKDzBSZ4et5hvy9Yttbq8A7La/gm1wNIKQXlCzLeBw27SVKVN3Wcs3A93
 sxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752160096; x=1752764896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BUnCbiv5ercKFDLix/SpHhgaXGyJI31mUZMLa6N7LrA=;
 b=EkyEQKDVk40xdmkaha/4C8dY7Ujlcb41rjHR2ZOntkXRn5EJQQ+q4bdRmKp14UO+9G
 H768JLfXHb3hShzP9DLy3f4jEHbkf96QUXMh7/z6fZgIJq2ZDM/Q01O6NEWyIdqbmfU/
 uPdQeKju9y83DgP/B/p/lYg60FrAAuc+9Pio7150auU/nAbr/cgy7O8oDGfULjcgrb+S
 XFMSHFD/PlB1dB6xUIbiLfX8OgjHqe5pQC10HHfdHFKt9cnExx3rN/u2XvZRLL+Aims2
 XiCgrb+NYcGvE8Czz1pUa6VliBWuNnvcR1mCO8k9zneNfuhSbWhDBXlDJPp/pP2sSbPo
 zwqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuSi9cJYCqFkLb1ext31QYYk1O2WAbxkZb6jOVWdd8rrFvmqSJzGk+BRGu5+Bi57AeR3RM02g4Fe3p@nongnu.org
X-Gm-Message-State: AOJu0YwApy7SM3sLedKzNEtjgeDsjEB5YwpEOzrVL9HGJvsVGtiZ0qrs
 lxIOibYNDjvPLPg9SWBEXbqfpEcBHigq67XpzqSuRLK+/X305TOHeZDxzRvojfBSOg2OlnGmmAw
 6BjXXQ/Y=
X-Gm-Gg: ASbGncui/cZQVqgmK3KAGfSc5y8iDjVrurqLQpZM6kNkvMWIeGaqcIBF6nCIpIkioFX
 5PkeLwQ91gu1vbNz8zTj16mLvVrH+ngQCqzvpI13S5Es4AYz/ipLkiW6CfQ0U8kHWXSY/EmGbio
 fpgoiRNTTSMU3hyWpNXJAO0ycPWFvT6hrKXWUJvNagUP2xLi9nuJ6hxd4Ttq3J2AC2TE1y+AtA8
 QxBzITO2upp00Z2dFPHmuXBdiFhb8mCGFVuFUsdFNc8/jCXUZR4DDbvEn1roSs4yOSGWwk6yRaG
 1zTKi2tQQUUdR82TSWwK3mxjCBDgnavfHbpj2Rzxo2XQbhu/7uIVcsLG0JutE3163ApdiSbARFa
 vCa7PS7IrNjZEw/MFfysTFDy/Vfj8jQljtLv/yF71heHosV/T
X-Google-Smtp-Source: AGHT+IG51proW1nIh3+i54V89a4RmdZnJASDqpaQtl5/2wr4Qnbm4r7BxjnUOuoRcU0/hiL/Yx858Q==
X-Received: by 2002:a05:6000:4803:b0:3a5:8cc2:10aa with SMTP id
 ffacd0b85a97d-3b5e45242edmr5391525f8f.32.1752160096108; 
 Thu, 10 Jul 2025 08:08:16 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d77asm2148856f8f.58.2025.07.10.08.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:08:15 -0700 (PDT)
Message-ID: <32fc392c-7380-45c6-96bf-44e57d459dae@linaro.org>
Date: Thu, 10 Jul 2025 17:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto/x509-utils: Check for error from
 gnutls_x509_crt_init()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250710144417.1187478-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710144417.1187478-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 10/7/25 16:44, Peter Maydell wrote:
> Coverity notes that in qcrypto_get_x509_cert_fingerprint() we
> call gnutls_x509_crt_init() but don't check for an error return.
> Add the missing check.
> 
> Coverity: CID 1593155
> Fixes: 10a1d34fc0d ("crypto: Introduce x509 utils")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   crypto/x509-utils.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


