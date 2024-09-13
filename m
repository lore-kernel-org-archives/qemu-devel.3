Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B10FC6175
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spCjV-0004w1-Ck; Fri, 13 Sep 2024 16:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spCjU-0004sP-4g
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:17:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spCjR-0008CN-BW
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:17:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so17752315e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726258648; x=1726863448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RrFTSCRMPB/7TLsNgU/5mtQ4X7taIImwgvSv/A5GqEQ=;
 b=ABqGfGOgz/6NZHVlrLCqvIAVzld//aNcQk6dOqXje04T6Qp7hePACgpdxSCX1Cyvrh
 xVkNTHUl5EeFDsw8UnfiqjltBWZ+ALHQV0T+TM0uUMP29GgtVV2ElPEzcJsY8zhgz1/L
 a9j66o30HldcTNg6NKVVjpdHP0t+V3Xq4RSu8qhb9clcHn699uT9iKARqNyotSiWwMEr
 pfzPzrKF6VShCNjpCKvXIlek0nOXMjefD8H0NKYBl81EUuQxEqwo7XdX9CTkE/C0h17l
 HPVAIaiBKEsOFCyDV9++qqi1omugVelsRp7Mm9Sv6ysDtUpaYiMeqih/j8ikxQ2BP7Qx
 OX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726258648; x=1726863448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RrFTSCRMPB/7TLsNgU/5mtQ4X7taIImwgvSv/A5GqEQ=;
 b=ERR9d4RkP2JEE9Xm/N6jkEh5jIA/zb4DWNZi9AezwU+5UP58XvK7DYcfGzsNE1PJbC
 DsF7kZ4AyZnhZKO/PABla0c/6d4x5rRv2RBXMHXHfKAEfK1ZL58qBIa7IuYEfszoN+e1
 L4iIManidM9g3dearlOM98qJb3pcED6iyDYR6hlwaOw6+vYMk+10PVbdbEiYvjBzXS8e
 Gy4CEw0ilD8jFWqic564buRdKn0BHhqfp/zdnmwmKV+p52a0pxD2B9iFcDU0qFc2xSUV
 aih0SIe8muLVKgJmzQU2l+q08ReOaECRkNDPH8MBBc5OgBtUYKqfa0TwKhjEJ+MnYHud
 YV8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8fyZ8VzGBjqqPrfp1Anl5vT+5B4l7ElKsZ4uuRNyjJYfeIf2JWLApAnQnHYCDqcNzLd7s/neCE8c5@nongnu.org
X-Gm-Message-State: AOJu0YxEVQjopN6EwqK5q+kkln4wKjqB0U5PDba0iz52/Q0Oi/3i5VGO
 bESMT8oYKciK2plRYQmzsqLCD4BcwHexkS1t13HsLc7sss04F67fnXVlZFZhoXE=
X-Google-Smtp-Source: AGHT+IFnKpg7fS9XBL3jW7Bk/q0wdHYNliVOHi4z94tuv3nDsPS10uOeOkQ7o1coK1Z1I34ugfMyUg==
X-Received: by 2002:a05:600c:4689:b0:42c:ba83:3f00 with SMTP id
 5b1f17b1804b1-42d9070a483mr42806555e9.1.1726258647459; 
 Fri, 13 Sep 2024 13:17:27 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-243.dsl.sta.abo.bbox.fr.
 [176.184.39.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b189986sm34846215e9.29.2024.09.13.13.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 13:17:26 -0700 (PDT)
Message-ID: <b8aa454b-3006-4621-9692-6a1c16dfdbda@linaro.org>
Date: Fri, 13 Sep 2024 22:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] plugins: add plugin API to read guest memory
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 devel@lists.libvirt.org, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Rowan Hart <rowanbhart@gmail.com>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
 <20240913172655.173873-17-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240913172655.173873-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/9/24 19:26, Alex Bennée wrote:
> From: Rowan Hart <rowanbhart@gmail.com>
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20240827215329.248434-2-rowanbhart@gmail.com>
> [AJB: tweaked cpu_memory_rw_debug call]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> vAJB:
>    - explicit bool for cpu_memory_rw_debug
> ---
>   include/qemu/qemu-plugin.h   | 32 +++++++++++++++++++++++++++++++-
>   plugins/api.c                | 20 ++++++++++++++++++++
>   plugins/qemu-plugins.symbols |  1 +
>   3 files changed, 52 insertions(+), 1 deletion(-)


> +/**
> + * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
> + *
> + * @addr: A virtual address to read from
> + * @data: A byte array to store data into
> + * @len: The number of bytes to read, starting from @addr
> + *
> + * @len bytes of data is read starting at @addr and stored into @data. If @data
> + * is not large enough to hold @len bytes, it will be expanded to the necessary
> + * size, reallocating if necessary. @len must be greater than 0.
> + *
> + * This function does not ensure writes are flushed prior to reading, so
> + * callers should take care when calling this function in plugin callbacks to
> + * avoid attempting to read data which may not yet be written and should use
> + * the memory callback API instead.
> + *
> + * Returns true on success and false on failure.
> + */
> +QEMU_PLUGIN_API
> +bool qemu_plugin_read_memory_vaddr(uint64_t addr,
> +                                          GByteArray *data, size_t len);


Align is a bit off.

