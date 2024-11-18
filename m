Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987F4D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD13d-0007Cm-4t; Mon, 18 Nov 2024 07:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD13R-0007Ay-RI
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:40:33 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD13Q-0004PQ-68
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:40:33 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso38152891fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933630; x=1732538430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vrrBpQ8Kpr8m3E9Zz4Q+QkaIEy4fbssbjT9rl1j42Yc=;
 b=HOarN7C3tLYEsk4209SZJlrwkjKQPImtGBsFXvcnetRnKw+cGMg9MSGdNSaaJy3PEH
 v9XLA426lS1Sc5ktVZJ7IlzRjO5LKaI21P3zij1sUbJM8MCxm4b4kdAfsrgj/D0ZxrWK
 vpn7pIXSpqoZHs6gcRPmBNzpKw4izHybCWsVHP4VXknO2MRpaDATv9BI5JxQ5IsyTnp8
 IgFEOHoqmkF0ZrBTVira5wdVpExY04AHX77OFVEH7L8A6NAxTbRU1wranxeWLszs0M1t
 ql7wEqOyUH2lhXpJ6HBfxEqr2qzq4JAnI/7VlUukHDHJTeqSsqR6AH2JrukXspVYetT+
 50Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933630; x=1732538430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vrrBpQ8Kpr8m3E9Zz4Q+QkaIEy4fbssbjT9rl1j42Yc=;
 b=UYa2iHQqT4lJHT5x93eEBv5Ln2/9VXY+No0b9oVHvmp338PpOFRC28HT3LqzQSb08Q
 Xr+NK3OFBCNwO1jYmccTeJ2pjv+7gyx1RvaPJfE+Qx+FkV/4WRH+W6kipYS4CRkyoCEO
 jpnmkqTucnSi6O63qEZPGqWr5MVpTUYrJw693cDB2iDUq16VZaFJadqZ/hAK88/eLM/S
 9FaUAb1/edjQRUKIHlHRi/LMrKd2FUobHG92RlY8ri9p79sd+M9nxfgu05kpuDIqnGkA
 5AmlfFHRa0Lc+b0XVLIQE9IhzdVcQl5De5BCBIFMZ3cA72Cc/GfjPXA7w7EZjjAD6WVG
 ElPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw7YLL8pAXWr6KsAV/hgu8BtxZgUfLQHYa/Xvyhia1mCtZt5ROB4vzLFMxxbkg55DSfljdv2wQ+bUv@nongnu.org
X-Gm-Message-State: AOJu0YyozLCdittzkxyuSWVIssb9uIta6tdqQBzbaeGM2D/jwp8iaYTi
 xeTi0VEcOhTlniVIvFolcf2mnWqUaIWhpgVI7OkCFq0PsYlLHfUyqFEl7oEbjbg=
X-Google-Smtp-Source: AGHT+IGhE7k2sTc3sg2FZDvDw7KfJZT/RRJweTAZYmpRqx6/ty76f9hSKxlu+OvZFHaJo4cTm4rREA==
X-Received: by 2002:a05:651c:1514:b0:2ff:7d27:8069 with SMTP id
 38308e7fff4ca-2ff7d27821bmr12027561fa.14.1731933630379; 
 Mon, 18 Nov 2024 04:40:30 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df271b7sm533723566b.41.2024.11.18.04.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:40:29 -0800 (PST)
Message-ID: <aafe4d02-0b09-4b63-988a-c0ccfbdfc5bc@linaro.org>
Date: Mon, 18 Nov 2024 13:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] net: Make ip_header struct QEMU_PACKED
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yuri Benditovich <ybendito@redhat.com>
References: <20241114141619.806652-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114141619.806652-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

On 14/11/24 14:16, Peter Maydell wrote:

> Peter Maydell (2):
>    hw/net/virtio-net.c: Don't assume IP length field is aligned
>    net: mark struct ip_header as QEMU_PACKED

Series queued to hw-misc, thanks.

