Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B557F3C245
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZw3-00076y-Ad; Mon, 09 Mar 2026 08:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZvy-00073U-HH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:42:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZvx-0003lJ-3M
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:42:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so134306025e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773060123; x=1773664923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=da2ioy25HaB1GnONVpf6nJPTsqEjhDEGkyov/PEJ+Jw=;
 b=k3XVhSOmNGvYSMy7xf3DLm8JCNw/q21i1QM3Z5us04cL8pULessVUxWg9dqRWXUZlu
 b/jBQ8l2mi5qmd2tZ9y98dKl4RvTHRVmacGB2mLDHHgCR4QvIMqyDgUMxqNn88RlS9DT
 MOe0+mXla+eAEZ2DbJtWqq5QNrckBLFMCAhepSnitHvhodhPPIM5cI9Yn9puz5F1ceuC
 sHhjSYo5AWp6hb8w7wUgMwycsfwi6QpWQA7rEeM2DSxQzwb5h9S9Ey84+Aiwg/Pj+xgm
 mTAY/D1r35o/rBgC58iXnucXnkhrLBPwBIuSLrq4gkWFHbwzcDkgAal84C+I2ot3Zgpi
 fI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773060123; x=1773664923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=da2ioy25HaB1GnONVpf6nJPTsqEjhDEGkyov/PEJ+Jw=;
 b=YcQgYpNyrbg3mn2oDRlJmtvZf2ZG7CWVe6Oo/O5x04YeHNb9muduR7c/fI61L7QkW4
 HskciKRVP4Ju0rXocUHrPDy/eM1Y1Wf+zLFpbKwcQ6Lm2mwcLzdUYvN1s3dOlaThm4SA
 3WbvOhrGSJDN+eM/aiVcs8Fbjrc+04r26uIit+5uqIb/tZncxnK/BbWBYdSGNNOFzHD6
 GmSdNFXIWym/lZ6txdv11UtoYaiS9WY6BXWOQTLezVlzSu7qaWYRee3+MXITm6IuPb++
 KsvyeM+jD77T9lpVdyyjG0KXdTV5f72gASWzTwJGdcXoHCdoRcsWiCiB0hBhb3b4mjM+
 4Kew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxC6TABpW+amVSXsY5ZPVIBNSs6CpzUHvzI892/yDUvG2I5r2UMXXo6D+wKr17LiX8f0PUxkvAoeZn@nongnu.org
X-Gm-Message-State: AOJu0Yx0j6NahncHbecA/m/qwCySXLp59Dovi4ur0Kk2yolHkAJcR1or
 CPoC1lptct3h+xrcpd4ywCOGh25d5YAG/JfCtwt5MUQD6VJSk4w8XvDO9SAse6HNX+/vbd5uz9j
 S8aUcqTg=
X-Gm-Gg: ATEYQzxR4BfvBtepjMy/AAZBvxI+Dk0qmghigYRRUEJk7Lu+/+eyUvWNKCzv0ZzxlNl
 DmybQcL9alpWuQuyh6ZcMBd32ZKc6Ml+N7q5H3VvwG7KqL1R98jgn9CvSDys1Ic2bK4EhOxRldg
 UBvDapo91i+B2JamiKVTnh7oERXNUvhNs+HhiEtnMsHuvCJxdiHjxtOy7d+dD0rLiKSeGpm4BBl
 dbQTsOCXGCgA1Q4wp+HBsKmhPhckJiPp38ms0rO631uqEeqmVGSivaBLBRNlXljeRImmI7DaRCZ
 NoS4RHNbOC6802GmTZ089Sny0d9VNpKAwWWd+kH4d0z7/45/+9UkmJkOGKyPw6FyJ+KAd8XCno1
 k/Ae6z2+nVkVGUONxRFgR1eNJCSI1ZgcyhZ9iCm19lFTx7lEG7/JRJ7KM+o6TjdxQZXgZr6JX0+
 ma2iaNEuAWeK0OcIeaVbp5ks6ozHWwza0pGjOrsaZAlZODw0KJXjL6nNa8iSQBsbRGEA==
X-Received: by 2002:a05:600c:4ecd:b0:485:3c2d:d02b with SMTP id
 5b1f17b1804b1-4853c2dd2e5mr39810945e9.22.1773060123410; 
 Mon, 09 Mar 2026 05:42:03 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3d98asm29472462f8f.30.2026.03.09.05.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:42:02 -0700 (PDT)
Message-ID: <b109ef5e-5fb4-40e4-a85c-68ba5f744c24@linaro.org>
Date: Mon, 9 Mar 2026 13:42:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i3c/dw-i3c: Fix memory leaks in error logging paths
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Nabih Estefan <nabihestefan@google.com>
References: <20260309093838.364126-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260309093838.364126-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 9/3/26 10:38, Cédric Le Goater wrote:
> object_get_canonical_path() returns an allocated string that must be
> freed by the caller. Use g_autofree variables to ensure that memory is
> not leaked.
> 
> Resolves: Coverity CID 1645550
> Resolves: Coverity CID 1645553
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/i3c/dw-i3c.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

