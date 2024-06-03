Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C89C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE76L-0007Xk-GS; Mon, 03 Jun 2024 08:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE76E-0007Rg-EP
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:47:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE76B-0000QT-Ie
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:47:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4214053918aso3904145e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418857; x=1718023657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2nm0+/6xX/ZOx6oKob8AyaKy3xj3w2769d0XEcDzBLE=;
 b=o8l5FLmMZXTCj/Hl9bkI51uWSSCRYnlpT/aRom6GX5rKdJOStZR1njjCUJ5lo/UJCo
 kFIVmGwEt5v8MlCjUjrbb6O52nxEiHKsKLKVREowE/4YuhjgQaLpfsFRFLngd2OHLx05
 bOU+BG9r60HICxjS2LA8ZfGT7je0EkPkviz4dTqhsHPDG66qfN8ZIfI26JcWtHkYjmuM
 5b6FWFCx9t4ySSGwA3fvbZ8TLfb7dZ6bAnUSFU2S5Px2DzX2x/CZVCi5PO4jqYkbNKdh
 9ZDZeeBCBuefPp6d1makk1oA05i/+MtBVvc/1Io7sLK1W0uvBqxV7LX7JetcoWQx6XsN
 Xr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418857; x=1718023657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2nm0+/6xX/ZOx6oKob8AyaKy3xj3w2769d0XEcDzBLE=;
 b=pipZ5FlWUIbRgrrqvD77JoU0n3UtOhm2wGa2zqcKO63RXV7wevW6x9oPqJfBfYLI/+
 nYGLkatotmoOnQs3Pyd10Lkq39dw0IhxDins+GrWfN9Thz78RHhzP6HGJ/JNdMYKAuE7
 Q9H9Q0yhC/KU9P1LsZe/KyCi9VXa/HkYIFTr+X/uVGyVcvRcC1iNooN9G6rp/HyPBieG
 inF+wBUtyhLAXJpDGeZErINfHSe3abj9Hdf0Z8C4xa1Q9pIZnQbWaPqDWNk67KLyzPn9
 7G0cfTYXIlAvGDmMRfhUzHqp3BL41vOT6XYB3YoekJun5rui6Bc5ulFr3HLYHsynrgwq
 bk3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWElXiqSBZ+vLWGjwHhOMw9UUZWP6CWtELUg6NtSctVsfJRP7cJSJXMEhq6yJspcglDgOsoGGiuvO4/d4jQCemwvNw8Wlg=
X-Gm-Message-State: AOJu0Yx821BB7A6Jr8Smu/iLe6naBeU32aMbxnaR3bFZkcFnnQphEZ/X
 VNdJ8W+map2+u9Gq/nqESaJFBE+1k1jZ18gZwYYA1LgRdvYLZ/GSX6zkCkNcAik=
X-Google-Smtp-Source: AGHT+IHv/LN4GCaL0Zj9xEm6MRRaFOZbRvvE1y5ltu596ORAUKuBOhyxYFt61tLgNZ8w3I5NFg4rsw==
X-Received: by 2002:a05:600c:19c9:b0:420:2cbe:7ee8 with SMTP id
 5b1f17b1804b1-4212e0443b7mr61224275e9.6.1717418857035; 
 Mon, 03 Jun 2024 05:47:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42138c41becsm64480035e9.30.2024.06.03.05.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:47:36 -0700 (PDT)
Message-ID: <988e580d-6121-4f7f-b7b8-d12cee39be35@linaro.org>
Date: Mon, 3 Jun 2024 14:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cpus: a few tweaks to CPU realization
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530194250.1801701-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 30/5/24 21:42, Alex Bennée wrote:
> The recent IPS plugin exposed a race condition between vcpu_init
> callbacks and the other vcpu state callbacks. I originally thought
> there was some wider re-factoring to be done to clean this up but it
> turns out things are broadly where they should be. However some of the
> stuff allocated in the vCPU threads can clearly be done earlier so
> I've moved enough from cpu_common_realizefn to cpu_common_initfn to
> allow plugins to queue work before the threads start solving the race.
> 
> Please review.
> 
> Alex Bennée (5):
>    hw/core: expand on the alignment of CPUState
>    cpu: move Qemu[Thread|Cond] setup into common code
>    cpu-target: don't set cpu->thread_id to bogus value
>    plugins: remove special casing for cpu->realized

Thanks, patches 1-4 queued so far.

