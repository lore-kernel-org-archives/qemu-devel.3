Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA15C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRp2d-0000el-C4; Thu, 11 Jul 2024 04:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRp2X-0000TH-LM
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:20:34 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRp2V-0008Q1-Ik
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:20:33 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so6218751fa.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720686028; x=1721290828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rZb6MZxPLqmnG6/rKpQkcPYiaf+PZ+T+sPxcipVcbRs=;
 b=c/HGTebMCy4LV6F9YqC9Q00bZjgN0JRZ/2AFGh5QiXZGXtGvJqvxi9OMVBhGMB+BPP
 TxFRANAhvjAs2lqfAda698S8prXUuXPlDQ7pSsgBtdP1My+rFJb699LwnnPIsA5HwzdF
 ELL9VKN79hQ5cKCV7GYKXea+xh/FkVD3UHYDS0O3v2KvYyYr9Hk324mWVPmQinG0KdQW
 WyDNwLt65aJkR6VuB3gty3mZB7lR0vVPQPpV8XiPKuyphmoqsLnvbcqLNQX+xLRqL3l/
 HNm3Aw795neo/FEK05R25nCa5g2P0CkTNvHnbQ3hUzbcAR2JX158YsZ/L47eNlX9uVWB
 GgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720686028; x=1721290828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rZb6MZxPLqmnG6/rKpQkcPYiaf+PZ+T+sPxcipVcbRs=;
 b=dtXFnXSTg+hEeTozfhUcrpXCeRgLrGrXXbmp/0csGRx/7I5HkloOmFDxr9F1eHCgI3
 571+FbnaFYhSFCkSwQ7fncRFyMQd0S6Q074FEO/HbEPhpGiPeGnv54zGIhZgXpCeNzUD
 srrE5SnUHvI3ojRD+KgReKdtrPOFljAYnwFDbKffSSoDkRF6wQMhHpr/LsaenjVBwddX
 0Grb62zb2JXPhavVcle4ObwTvP3VKDYBIXei/Z7zCPj+Vmc8dkVUC6qrM+omn7s3RZ9X
 pYKDloH3jgOAX9oXPkmbxzYJyEdQc2kQvVIcB8JimDiEhZkLHox6akL/lVPPZT8pKwjh
 RYNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ7EFdHSEEZwOE6/RWwluC45EM7NF2Y9uJwhKoOBTVa9y7goAppD85KFAnHAhTZqcgQoiUy7wwvHL9+/i0HWZsB5e/I1I=
X-Gm-Message-State: AOJu0YzM5n8hUuXp20TaCu+96keIPx7qcvk8tEgvbtxUkL/YE29jb3dP
 DXjWDj6ub0pOcvMzUzo571AEfadwtZ5A5MXxgQLxacyDT33ALiGpEseuJegFSfk=
X-Google-Smtp-Source: AGHT+IEsXJevRnbRWYTIWw9q7cnkOONVUcPqfTjwLreOqWLNfFrty2I68FwlrdSFAClJvghM5nTJhw==
X-Received: by 2002:a2e:9ed3:0:b0:2ee:bc9a:9d84 with SMTP id
 38308e7fff4ca-2eebc9a9fc4mr34174371fa.7.1720686028235; 
 Thu, 11 Jul 2024 01:20:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.207.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736304sm106904765e9.34.2024.07.11.01.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 01:20:27 -0700 (PDT)
Message-ID: <5c0fe60c-040d-435f-8718-aa9334a8ee10@linaro.org>
Date: Thu, 11 Jul 2024 10:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-snd: check for invalid param shift operands
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <virtio-snd-fuzz-2416-fix-v1-manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <virtio-snd-fuzz-2416-fix-v1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

On 11/7/24 09:38, Manos Pitsidianakis wrote:
> When setting the parameters of a PCM stream, we compute the bit flag
> with the format and rate values as shift operand to check if they are
> set in supported_formats and supported_rates.
> 
> If the guest provides a format/rate value which when shifting 1 results
> in a value bigger than the number of bits in
> supported_formats/supported_rates, we must report an error.
> 
> Previously, this ended up triggering the not reached assertions later
> when converting to internal QEMU values.
> 
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2416
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/audio/virtio-snd.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


