Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEEAC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 14:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOI7M-0000ul-54; Mon, 01 Jul 2024 10:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOI7G-0000uP-G9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:34:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOI7E-0004Je-CY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:34:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42564a0d3ceso19693115e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719844485; x=1720449285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ynjIqe5R3l8zL5WqlRiE4jEgv/2Fvrfx8u8G29P+1EA=;
 b=uUOGnWlT9iicMhD1nGY5+1ZpWfa+pnMfIJjd/kE1aeRvcBGOTXOHw1lKbuSR+9lrgs
 Gk3inO3ifZ7FPNNUW6fA50LS8U7WP3RocfBMkKNXQmSa/g+urW636IBjotvWxy/xLKhp
 1E4vQUuY6vGxuJS/qxfss6+99ZTiWEKlIEfnL+5U+anVS6OYbe92FbwWlhuaeLM9c0cJ
 r4/eAuJ0LFxiH5hLSDRfMBZDf6ESF62apwosW2RCHiqg8dBENze+FP+lpiWyGT10TPiV
 PiJnlj7gZn0RaNN24N+c47oSDBPQSImjgYgBWBxA6+JbvsqYNwizvyTFXpC+5QMCb/Rr
 bnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719844485; x=1720449285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ynjIqe5R3l8zL5WqlRiE4jEgv/2Fvrfx8u8G29P+1EA=;
 b=loiUH8a0bJgUyFBXvGmnbGhtaDYlL84SST87T6kPLgh8Pk2HQzmdyxudMNjvB/AXgn
 mMDoJ+JLmeh+aUU9TyMTLt4apujT2HOmfun84pz+SwiVDGCFT0KZIGOgXgzI132PbjQr
 zCNyg1PgrV3KXigwo7pb+wzQwplB8Qp+rKulwNv6j99o+iaG9YLB5c8wp1XCh+0dXUip
 C4HAIx+RZMlNqfERmazsQNP4xwZxkqn2mzgHPU0GHEMUUN0rr5t1ifNpwqyDB5mncj1Q
 G9JbyTmGyUG5RrvBAWd0Y0ihZriuM4PrFc4lDujcXMxo/I1Vhfw0tW4xBJgZO8T8Ih82
 QvjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGmDsYM9E5QiaFl7wl2QgMsXFzhutrQ/QsPOB0VpC5b8FCsPy44DzZc46tufxr1ekTBXe+pfldHg7Z2lOkfkXhjuC56G4=
X-Gm-Message-State: AOJu0YxTEeDVO882dMJVHXwl1n2aVgvktjkvVMFVtUqMogowRaZ9dh6F
 GmRrCDsXB+X0r4YsWJUghkw3kJoaxEt70cbrsiGNx5G8kuPmXb8ZUepp9y54Q8LiKvZPt+pfnG9
 C
X-Google-Smtp-Source: AGHT+IHPUcd0xTyokv8Nt3eJx4BygdAhFWeA7dCd6IGg1hSoKa7x2t9F4NlC45GrYisSlDRfQU0twQ==
X-Received: by 2002:a05:600c:1585:b0:425:7b77:e943 with SMTP id
 5b1f17b1804b1-4257b77ea48mr34283835e9.14.1719844485095; 
 Mon, 01 Jul 2024 07:34:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c1018sm154938995e9.40.2024.07.01.07.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 07:34:44 -0700 (PDT)
Message-ID: <5e0c57ef-d06d-4cdc-8d5b-3adec8263c5f@linaro.org>
Date: Mon, 1 Jul 2024 16:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] system/vl.c: parse all -accel options
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
 <20240701133038.1489043-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240701133038.1489043-3-dbarboza@ventanamicro.com>
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

On 1/7/24 15:30, Daniel Henrique Barboza wrote:
> We're not honouring KVM options that are provided by any -accel option
> aside from the first. In this example:
> 
> qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \ -accel
> kvm,riscv-aia=hwaccel
> 
> 'riscv-aia' will be set to 'emul', ignoring the last occurrence of the
> option that set 'riscv-aia' to 'hwaccel'.
> 
> The previous change guarantees that we'll not have mixed accelerators in
> the command line, and now it's safe to activate 'merge_lists' for
> 'qemu_accel_opts'. This will merge all accel options in the same list,
> allowing the 'qemu_opt_foreach()' callback in do_configure_accelerator()
> to apply each one of them in the Accel class.
> 
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   system/vl.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


