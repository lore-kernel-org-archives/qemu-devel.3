Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B89C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc8m-0002si-E8; Tue, 15 Jul 2025 05:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc8E-0002S4-V1
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:39:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc88-0000ba-Qa
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:39:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so4018497f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572357; x=1753177157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tGMzW+lshV6oA0yX3X2fOTQ54wPnqJzVK95rtJ7Fqiw=;
 b=OMI0fdmORO5k3GG2OiPwmyf/qwQUhQLPGnJU0RWN+YIikzVaVg4g1X7rs7NwqofrgL
 SUe93DO2YKtqDZ/Nq1qlEeQNg5ibmejLrXpsSKPb+mJ9Hd7ls4OTcA6sG70KfpKd1nKF
 CHrFdjfU2x99Eeog4WnPhNTl/NM84AfkOze5jKSQM56cGXgbpgsu2ZEy1uNbUR3jahT2
 LFkkHwfmx30a/idopnbUvJq4T7Wc04bXQfxrhiX/pbS+QcxQKveB7BR0O3yZmOyR8FUw
 aSBgNVkrwuPDywrKjJ7vJZgtZZotv1qOmZp1uQNCcJRoqHHMlH+DjBNRQcpUPoCe1Xpb
 jl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572357; x=1753177157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tGMzW+lshV6oA0yX3X2fOTQ54wPnqJzVK95rtJ7Fqiw=;
 b=YgKnB2qjOP01Dzt/u0MV1In5cjq0BgM2xCsTMWA/URIGkx2LkcFQKFxd+Gl4g5isco
 eSIQg2vpygCvHzdSmD4cGH+sodg7Ex9UtmWzh7iabcjPw7jxvvDrmYCtl191wv9tqzhO
 Cx1TrZChLzfQLHDKrPloZulRO6/0tAb9Ul342BRYL/XAlq5WIaGDA698VF2Sit8uDDAe
 6d5pPeDBS85Mr6f6juLpitpi1ATG8dwssBLLRTgEdEYGeUaSoPp6WeSmp8GaOFMm7pGI
 XMqJSdS0EaPdCS8SXhGzB+YkFOk2UfF0algS94cqjX+0rBQNjUqCWttNB6UtR0RGAbNY
 XkEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyF7qNszE72m/FTZ85vduvHtkEudZ7AVhdYAm0crO05L7pQy3yqSw+dQoymcpTfnoJAS2imdrMuKZ+@nongnu.org
X-Gm-Message-State: AOJu0YwEv//AndCwO31L3DGyLbtp1pO2lat2ZxrNbxxPnDi7hJujnYLx
 EF/dPTL99m76bMrYq9bLKCE6l27BtrTx/WLOte7OEcpAkRhTkk0YWX1lYajnOHKQdqM=
X-Gm-Gg: ASbGncu+nfWyRAF27/9vUZ5xne3cdYZFTqLGZyigwocYl3gDc6SUTECTDgtPjBuUAfr
 rUdUx5pb43mgIS0puMPwXLl30/n0HRsHpnB5oIfHmtDehtXpDhAkNkTSkdJzfifs9RAE5nqqWjL
 3kQ/fewWp42r7LJnFygAGkHIPZTM+n5yHhBbOMLb3/tpxE2R2Iyq2++KCQvHHHKftEgzqzxvFli
 dWDhST6Nldz0Lc/TDvVVlS+a/tTTXztc5vsbJvkiSDrRtgRNyMVc9B/T8mGcO1qz6FIfMpwO5Ac
 ldQ6SaRZ4kvQTeTveyeGJCfsbkhfISyJnlZyLUAJSiOyKQP9HRw5w2QfjciPl4LmbXJGxDem/f6
 N9aAamf+qdw9HV1FSUz9NBCHZeNAc2RgHAuBxliWUGVK96YfI9PTEQrLJCMamJeZ0OFJVWm8=
X-Google-Smtp-Source: AGHT+IE/lwaKV5R3ZE3XjAAqJx7K0JHtqe+/oaCe35kzUKN+f/1ZEuPiPABxAgpE8SOmbUDoMZuBJA==
X-Received: by 2002:a05:6000:2386:b0:3a4:f7af:db9c with SMTP id
 ffacd0b85a97d-3b60a1c6b8fmr1770131f8f.59.1752572357358; 
 Tue, 15 Jul 2025 02:39:17 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc91d8sm14411929f8f.42.2025.07.15.02.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:39:16 -0700 (PDT)
Message-ID: <8875e019-701e-44d7-aa49-b11ec2a77137@linaro.org>
Date: Tue, 15 Jul 2025 11:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] vfio/vfio-container.h: update VFIOContainer
 declaration
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-3-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715093110.107317-3-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 15/7/25 11:25, Mark Cave-Ayland wrote:
> Update the VFIOContainer declaration so that it is closer to our coding
> guidelines: emove the explicit typedef (this is already handled by the
> OBJECT_DECLARE_TYPE() macro) and add a blank line after the parent object.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   include/hw/vfio/vfio-container.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


