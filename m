Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435ABD637B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBKAc-00063K-4U; Wed, 13 Nov 2024 15:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBKAa-00063B-VM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:40:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBKAY-0000fQ-R1
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:40:56 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4319399a411so69562135e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731530453; x=1732135253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XBrny7brqYPGuwyBoIrvOJjrseneM5YdI96AGvGG1x8=;
 b=u/3RR6N5ICFsF4UhSlTxy+ZvFX86YMcju7tW2NUksz7yotDAWDbMDwPFi7N7UKZxdy
 OG80pld/bKgHrT2Prq/XVRDOASmvJT1oVVHrJzuo2wSpzvzzR3tSsSMe9IWxd0/JUJp2
 JuwA4lNG3Ymug/MQ3IpPDOAE4GwfzTbOW4nQvRoy5YKRhFT19E5L4wVG3e4YAh6iBava
 C2G4R75xm+qDeLMUu4vGtdHXwbhCTMnHUU6vcwpH3Ek8256oAZgEbs5B1EPPrCMU/rfV
 7Q1LEdPDkh6m4NFj1MZgJg1dqqiL+d0Q1rACnBfiEeSgpSvffIzQPbO34K/EKHdamOVu
 1h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731530453; x=1732135253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XBrny7brqYPGuwyBoIrvOJjrseneM5YdI96AGvGG1x8=;
 b=Vb6fRsTMaNPq5xs7GZ++DyZ9o47euqq+m1ldPkvYnp2Ib3uuln5LrW74GdUtvzcUSA
 ypRRQAi+lSvDgocVR+voOtaF5hIEuSk03UHD026jKXN08f0sehs4mGR8SYl83Z3gs9CY
 GEPT/f8mW8Ogk5L+guR/rgWlMPtyFVxb/+CB8supTdeFeEbrY2fTLSQu8IEZ9aSSGy4N
 PTNPhMzw26wRjidYG6UYejAl4MAy/Dg2sfNpbEycoglyzd8M31BsCflDnmTxrBGoK8uf
 lsEt5aDv6qehC7TyOotdKWKAMDt0Cyc8QQOalSoXMhN2lDobXmCjStbWLcThxgC1ZwNo
 XBnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJcVOKjQocrocWo91h9c+AiNWRttRdTwd8dtnlw7BKoxVpN5MTpVOCciPi/rWuS+QFxKVYN4FVDjCZ@nongnu.org
X-Gm-Message-State: AOJu0YxPdsUHqcH9Mc2qcs+kjG8lbk1PcvTs/VGJQw8C/KgCmspZIXUu
 1S94JS00LmQW+nx4eOgxCeajNXt0ra1lWZGGE89ImsRsuItVokZIjHVamWdiLv8=
X-Google-Smtp-Source: AGHT+IGYe2xFCx8zVi5SHj61aJLM8xRhGXMj2quJjrEDhQEl9QXsizo9hX7MjxbnFlTV4NBUtbrKwA==
X-Received: by 2002:a05:600c:5493:b0:42e:75a6:bb60 with SMTP id
 5b1f17b1804b1-432b7508b8amr198199865e9.19.1731530452672; 
 Wed, 13 Nov 2024 12:40:52 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea7c3sm19722192f8f.80.2024.11.13.12.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 12:40:52 -0800 (PST)
Message-ID: <f7ff08a4-30f8-47f6-a3e8-a1cb4e996ee7@linaro.org>
Date: Wed, 13 Nov 2024 21:40:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/2] migration: fix-possible-int-overflow
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas
 <farosas@suse.de>, Dmitry Frolov <frolov@swemel.ru>
References: <20241113201631.2920541-1-peterx@redhat.com>
 <20241113201631.2920541-3-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241113201631.2920541-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi,

On 13/11/24 20:16, Peter Xu wrote:
> From: Dmitry Frolov <frolov@swemel.ru>
> 
> stat64_add() takes uint64_t as 2nd argument, but both
> "p->next_packet_size" and "p->packet_len" are uint32_t.
> Thus, theyr sum may overflow uint32_t.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> Link: https://lore.kernel.org/r/20241113140509.325732-2-frolov@swemel.ru
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/multifd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4374e14a96..498e71fd10 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -623,7 +623,7 @@ static void *multifd_send_thread(void *opaque)
>               }
>   
>               stat64_add(&mig_stats.multifd_bytes,
> -                       p->next_packet_size + p->packet_len);
> +                       (uint64_t)p->next_packet_size + p->packet_len);

I am not familiar with this area, but quickly looking I can't
find a code path accepting 4GiB payload, so IMHO this hypothetical
case is not unreachable. My 2 cents (I'm not objecting on this
"silence this warning" patch).

>   
>               p->next_packet_size = 0;
>               multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);


