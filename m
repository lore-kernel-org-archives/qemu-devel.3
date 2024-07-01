Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609D3C30659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGc5-0001DJ-83; Mon, 01 Jul 2024 08:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGc4-0001Cs-1F
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:58:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGc1-00070y-R7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:58:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so21353275e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719838708; x=1720443508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZVbTYC2kXo6At3lEjeThUtvNXyBQZV9FZqSxcaXEzRA=;
 b=hxINozCumahpTBlpUBN5TtT2qNvSMOWa3vR0nyJ7vmLk4xFMF9mQXI0r0tXjtsf0D6
 ly6S6oQ1nRMDm1tNNF7CVdoPISJwN7jrriKAgCbUV9smpXuN+x9wLzgzZX97Dg1qKElo
 P5V1OJXp18uz0wfpzmvVLccChqwQuoT5/jAeG8nJT+IZtqOW69qioMzzxmaNPgA/GvlV
 osmORZhCbp+H1l1BVEEk6uAur2w6MqX68hVzdbT1rl/8eAsCmQ4VdB6cJcuX9lkecBtZ
 3JvZ58wMVf+QGboUEHb7IwzjHFM1w6mqduPZpueFxE/67Vrqr/AhUuzhzs6End9a8e2m
 cRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838708; x=1720443508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVbTYC2kXo6At3lEjeThUtvNXyBQZV9FZqSxcaXEzRA=;
 b=BtnyeklszsqxbFazatXX5kHxkr+/mKuQJtKnAT7UX7QmlRVz6Py6UcYVNvlaIHrk+r
 2IkS3MhmWZj20x2I3venX4ndxM9rSqy0qrrM+V1AWc/bK8LavUF4h2F77xaWtZwPY+/3
 B2FPSoxSDnOrrqXVKSk42YPx9YugskSfDepUMUP3W8VOOZYIi2TwubudpyMrlmXscEb0
 /fT+XaLcwnrh0ba4Y8JXW3fpYTJi11dMwxethYa7RJv3H33q8EKERK3idp1xpxavVVun
 9qy4yqf7Qr861tH+WrchattmFA7WkLwtCrLdjddpHpz6oKpP1gnP8QqYAK210abpEvW/
 5K1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO+RFBZkb+TSMFBrbz3kcTwfPmCklnvG2NVh0/ECJTijdL5OM6hdq9r0ppNGaIFo6AvOczKIPDhIa2D49NZ4Ap8U3lLIc=
X-Gm-Message-State: AOJu0YzeOS6FaWftTWpa5rZwZELdU9CxeJbBnFBrlJ4O5cnOOoyxmGzZ
 3C2TwkE9IDGAPCgsL6Yzx+XvJaq3sVlNGfzvF6P6Lz2KYJeNqcnrzioAwi2SkIA=
X-Google-Smtp-Source: AGHT+IGZAPK2mHh/wb3ty13iMRX2AQgmDtLTlCL8Dod6Xrl0PfvoJ/LFc9KdF+UJUIbH1RfJwblRTQ==
X-Received: by 2002:a05:6000:18ac:b0:364:6c08:b9b2 with SMTP id
 ffacd0b85a97d-3677572159amr3906217f8f.45.1719838708457; 
 Mon, 01 Jul 2024 05:58:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d00sm10002249f8f.99.2024.07.01.05.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 05:58:28 -0700 (PDT)
Message-ID: <d94a47cd-d77d-4eb9-a66d-17c3be155101@linaro.org>
Date: Mon, 1 Jul 2024 14:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] hw/i386: convert 'i440fx' machine definitions to
 use new macros
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
References: <20240620165742.1711389-1-berrange@redhat.com>
 <20240620165742.1711389-7-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:
> This changes the DEFINE_I440FX_MACHINE macro to use the common
> helpers for constructing versioned symbol names and strings,
> bringing greater consistency across targets.
> 
> The added benefit is that it avoids the need to repeat the
> version number thrice in three different formats in the calls
> to DEFINE_I440FX_MACHINE.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/i386/pc_piix.c    | 219 +++++++++++++++++++------------------------
>   include/hw/i386/pc.h |  26 +++++
>   2 files changed, 122 insertions(+), 123 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


