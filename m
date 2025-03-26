Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54113C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 06:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txKYe-0002Hc-N8; Wed, 26 Mar 2025 02:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txKYQ-0002FH-G3
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txKYO-00060Z-1s
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742971674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MHsBP6r47peNLj1UeCBKHSKAg+/3FPH4X9f9Eti/NPU=;
 b=RsfbPXkXbhhtDW/N9/yFsAsHrn61qBe6/sAVjhAKlWkyq+34a/mltKrbtXYakfUXvZd2JP
 hp9ljjJi8KDyEwJXdS40dlgPMS36542Feq5c9d389LFfoSXUx/ea+ZoVAX30cTWStH7AN4
 m5DYqGeUN+TEzAJPGh/bpmt3L+VQrL8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-HQNvOM6GOKGvvCOjqJUm4Q-1; Wed, 26 Mar 2025 02:47:52 -0400
X-MC-Unique: HQNvOM6GOKGvvCOjqJUm4Q-1
X-Mimecast-MFC-AGG-ID: HQNvOM6GOKGvvCOjqJUm4Q_1742971672
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso2635588f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 23:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742971671; x=1743576471;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHsBP6r47peNLj1UeCBKHSKAg+/3FPH4X9f9Eti/NPU=;
 b=ssWgTgPhGMiPS9mVI2FoR4y1ZK05XoujWD2Bj0ElgHtkkYZuMi/pufDQ4cGkfGMkjp
 u9oWmnsw2qazgEFOKuchNRXfdaEcpMY1/3u52bDm3BaBkS28RN0p1f+LbGZI3Gllk45D
 1Zku8fSBBpB4LIMGVAYwl3QvDnBaPp/bnNXn1Y81X9wSni9BYcXpcKDTvuETFoVsTKUf
 IMGS/9Tv+boF0psyAMTEIvc476UcFJMWl1g5aXuIxC4uj6e0olQjBDyx16xclRGevimA
 HLRRwt4nqF9RSFId6m8bZK1jh4x0v9npqiSnuboBBcE1nOU4BIBuHPvNUtJzU0iyhW3x
 /cqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRS7qm83UjL0ed4VaVy8Za2veGbhuwVLiq6xLWoTP13Vshzw62cYqSsmNV1VfM92T+sIEUlHFIbKx0@nongnu.org
X-Gm-Message-State: AOJu0Yzdk/bfPbQIRhO1+jCWLs5ykRZBEttqCunb0Qgn5+JPBJ+WpGUH
 ef69qyTuXXX8yWb38oeBqp2jnUsTb1mnNE2KD9loK6kl/5l5H+za9KKrs0hkARxVgg/8ve8w3T0
 xbzPFmeCTw9uYPFObscwdhFz/+sxyZGhWow9cgmNX0fz2MXfdSXme
X-Gm-Gg: ASbGncuOXlsVYifVq1W8k+QO67TjF1FvTHZmHAqFWgolk6Sr3e6MNvTTGG/zj3aN2Uc
 iK33fzanW0r0XSmiPF/yigkmvygrZLUR4GfZaU39aEjmrK87ywurgUbKU2DmhdXt6Idp3OAEx0H
 /0kcZiB1CXVuXRcp9WdEgCAVaOILVZ/RHIK87SprOYinEZn4Ao6wXVkK27maunVFqiMC3Wv35Sc
 lipjcLO9dzLdpqF5MzA9euhxGOw8cm0URzgugsszf4qUjTYNoTU3bjMJtkeWWxu4QtpGZWTC5iN
 +CSpisyXI1Ticl5fvdLXHrlpP8jbZK2WeuzjzK1kkcCQAYM=
X-Received: by 2002:a5d:59a2:0:b0:390:e535:8770 with SMTP id
 ffacd0b85a97d-3997f8fed26mr17742273f8f.14.1742971671535; 
 Tue, 25 Mar 2025 23:47:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENnUEmbX92+zz76cSQnPi6UL8v54YbiNqRVd812Cgg7N6wvDSucbCVqRZIQcrlUHIcuygh/g==
X-Received: by 2002:a5d:59a2:0:b0:390:e535:8770 with SMTP id
 ffacd0b85a97d-3997f8fed26mr17742249f8f.14.1742971671096; 
 Tue, 25 Mar 2025 23:47:51 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-49-206.web.vodafone.de.
 [109.43.49.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efcb1sm16137858f8f.94.2025.03.25.23.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 23:47:50 -0700 (PDT)
Message-ID: <892797b6-8d2f-4234-840f-e36ef94b0701@redhat.com>
Date: Wed, 26 Mar 2025 07:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 01/12] hw/audio/wm8750: Categorize and add
 description
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Samuel Tardieu <sam@rfc1149.net>, qemu-block@nongnu.org,
 Patrick Leis <venture@google.com>, David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250325224310.8785-1-philmd@linaro.org>
 <20250325224310.8785-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250325224310.8785-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/03/2025 23.42, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/audio/wm8750.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
> index 8d381dbc658..6c1bb20fb75 100644
> --- a/hw/audio/wm8750.c
> +++ b/hw/audio/wm8750.c
> @@ -721,6 +721,8 @@ static void wm8750_class_init(ObjectClass *klass, void *data)
>       sc->send = wm8750_tx;
>       dc->vmsd = &vmstate_wm8750;
>       device_class_set_props(dc, wm8750_properties);
> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
> +    dc->desc = "WM8750 Stereo CODEC";
>   }
>   
>   static const TypeInfo wm8750_info = {

Reviewed-by: Thomas Huth <thuth@redhat.com>


