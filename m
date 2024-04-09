Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDFCC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 17:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruFCG-0006uC-OU; Tue, 09 Apr 2024 13:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruFC2-0006tU-1d
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:23:35 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruFC0-0007O1-Er
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:23:33 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d8129797fcso80932631fa.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712683410; x=1713288210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LBzddX7Em7kinVA6DEHn/HF9siAcyzpdmt+TEBKRpr0=;
 b=lTycx5JvgfYY4iCVvtFWNBDI/TGOzDH0bwQPYhNGCNirkG9+BRUai7GnXQHxh5ByMG
 TpbMdmkBFbrTJ82f1h82Phod3dF0XPykGxLF3KB9XXbdjUBUz7dTm3PQLds6ofoJ1ZgQ
 eVJXLjiqVchRvnVTJJqFksMMxUJxIwNgla+F8qioUxv7yKusUc1N3P+sYakY6+eVyIzU
 2oFXKKR3VBZ2C/NXqKFMNe1+MVmRyD9zNaWKWrMp6wVm2Csr22WVFKTDDJ07Ui+zP5VU
 hCkREht1/AN0nzCZROYS0kkTXLZGb73jAQaLTuToRytC1ZVzDM8gs5X74CDCJJfn4522
 c8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712683410; x=1713288210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LBzddX7Em7kinVA6DEHn/HF9siAcyzpdmt+TEBKRpr0=;
 b=CrX+wQ5wmGiEVdcPj4j8ytOEm6A/9HjbPjznyhaJt8XVHL/6QGf2uVGdZfPIchkfY4
 Sjtgpnx+bJ8oYB+fo5ZQ6/j/FeC05QnqSoDyTS5mcMLg5L2wfapdd44g1Ityb7DUQ06b
 y66gfH3Fi1g16241ALroIrBoX1KtfNfLfd2pabtViT1JWykvmJfBSrzujheLgxz7PBtb
 0eq6NGNcKGi5i6ZslByV+4pPO4aqmVwlNWzduFbtwIhRUhYMOzWpFnfTTVPjgt72fqOY
 zLiRA/lonkjdthxdH0Hy9RNpQNPUnGcozFu1jmyJr1y5NDtXNJC3wgHGqOu3bdIIlRyK
 iBEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/zTxAdgpsmRmSX4uO/qmbCEd+j90fhdkyQbTuxbl7gVc5DL+MKH4Rpu5G/qqqFFjtSaWbV3ANmnnGIZXXwiwIJJ+mMcA=
X-Gm-Message-State: AOJu0YygfOPiORfyuOblawUh8uOAjOqabggeK0fEe5g3MP68tbSrGEK1
 Yznm9g0sUzqzMLZf8sXYWNT291rnSF5wCzsP1Oxp+vKkKa5iWTRlbzji/mOfwp8=
X-Google-Smtp-Source: AGHT+IE42nAZXrOqK7nnoyZV3JGtvKimKpRKKs2deAkX1DP8i1NRnXXQ1gMP4m3NTVTZoINQyH7zhw==
X-Received: by 2002:a2e:978d:0:b0:2d8:57a4:968d with SMTP id
 y13-20020a2e978d000000b002d857a4968dmr319681lji.12.1712683410022; 
 Tue, 09 Apr 2024 10:23:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a05600c350600b00416645e7e47sm9396068wmq.13.2024.04.09.10.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 10:23:29 -0700 (PDT)
Message-ID: <37129ec0-3cec-4fda-8ae8-f26e3312affc@linaro.org>
Date: Tue, 9 Apr 2024 19:23:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 03/19] target/i386: remove mask from CCPrepare
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240409164323.776660-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 9/4/24 18:43, Paolo Bonzini wrote:
> With the introduction of TSTEQ and TSTNE the .mask field is always -1,
> so remove all the now-unnecessary code.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 81 +++++++++++++------------------------
>   1 file changed, 27 insertions(+), 54 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


