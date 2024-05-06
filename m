Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDC4C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 14:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3zJb-00028N-NS; Mon, 06 May 2024 10:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3zJZ-00025W-Tg
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:27:37 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3zJX-00076V-LQ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:27:37 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34dc9065606so1095226f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715005654; x=1715610454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zT4RPlaD5jss6vTGWuTScCxPlXsg6hIOVMrR/E/CAuc=;
 b=gkEWWKpoznGAsIS/MJdmscNK8xSsUZ6jf2oNZJyclnVgKrI8rpLATlwoZLqTAatZJn
 Q9mwRm8bMcYdkxsq7CQPlfb4EdtPh5EbxqC3tiYSqaQf1kJ8qwAX5ZVVm6lDdIHaotZc
 fZBDdiDYoLTlR/256OnGiqqeHYXCHVwN9N95LL0vb56ELngh9BMjPr4mUdgCJSf9WfbY
 APFtCkMZHkuo0kJHI+4+7rzpVEyfDpAOuxk71jXzpTSRfPu70acDZ04qRORS3mdwAqsD
 dRJtRVrP8PUqk8c6EWQJbKvoPUL1W/fdKWkoop8OGOt2JQef3ZW+anzwUHABOVAiyI3m
 jD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715005654; x=1715610454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zT4RPlaD5jss6vTGWuTScCxPlXsg6hIOVMrR/E/CAuc=;
 b=R3EEowL3QdsvltTJc/5uzB+yvKCvw8ZUZ/UkONnwgma4K2RlGL34uJUEtxJ5v8QR4B
 2Y80QCNBxR4KgR3a9kOQYJaaCwjSkt0/9Me0JNzWd9oVN8upxiKJgb/l5zkVuJU5eJiI
 rlJkLQbkvxnq0RuWvamstLNxJSpMP347MyPsxrmIwpkb/evCI8pjROdmibQVDnD0ID5I
 XDaMb2qpcYjGZeDXW4mNw1tUExCqXCwVLebLgaBAN6d5GYPshqeaGC3ysNnBE3F6tjVk
 BmsRgR6WYqEiWR6l5fdfvO9TvphNNKVYAFBemDtkNOrNfbGkR4C31y1dm8QrZ7QOwa7M
 M60w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuqZs9zlykTZWFqP0IhozUb/90d6GBe+ELY6yS4SKmBw/4RYYr3MBqX8aQj7X012mRWD/Q6fONf75mLlm6jQWpr+HSpO8=
X-Gm-Message-State: AOJu0YzA8bJF8ssg07C0BpnWXSXZkZU/pN3TltH8776EsdMclvKO7I1C
 6wUPSE8OwIqVx2+hhPlBSxFOla3oqvRVgyW3MNrnsvoRTje2OKUmqn2sH3skmQpRUdcc3SmSjKI
 r
X-Google-Smtp-Source: AGHT+IHpYQ+WBpq76l1RlkBIo6bNklDYdyCtgIwHQbKiQ3qETBL5zZv2ICvYvAwHBBP1iddDCKy5IQ==
X-Received: by 2002:a5d:4206:0:b0:34d:85f4:9485 with SMTP id
 n6-20020a5d4206000000b0034d85f49485mr10741103wrq.7.1715005654156; 
 Mon, 06 May 2024 07:27:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 k3-20020adff5c3000000b00349a5b8eba6sm10764513wrp.34.2024.05.06.07.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 07:27:33 -0700 (PDT)
Message-ID: <783fdb01-6fd4-4619-95d1-9a87fbee0676@linaro.org>
Date: Mon, 6 May 2024 16:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Make it possible to compile the x86 binaries without
 FDC
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
References: <20240425184315.553329-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240425184315.553329-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 25/4/24 20:43, Thomas Huth wrote:

> Thomas Huth (3):
>    hw/i386/pc: Allow to compile without CONFIG_FDC_ISA
>    hw/i386/Kconfig: Allow to compile Q35 without FDC_ISA
>    hw/i386: Add the possibility to use i440fx and isapc without FDC

Series:
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>



