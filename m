Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42490C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiBEu-0002cn-M0; Wed, 12 Feb 2025 06:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiBEs-0002bu-Nl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:49:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiBEq-0002px-Qr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739360947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PZNpFVnsh6lshbKMRE5Z9zohd8VxnEo1QVzFiZkw9iI=;
 b=CprXHWiCT1q/vRhsQDcci38m5/XaZpSv3Eqo+kLP3qFaW0qeDqmPDhR3qgUbI14ghVs4sn
 /mqrO+PnmbDQ3gFODLk8xt+AHJntRPK2fyh1aaOrf/jyJH3nlABOajErme3E8arli2J5k1
 1GX7nwo9fiyf2qfGUJYS4i1ooHGbfpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-UcjStJuxMRq2y4WhGRwX_w-1; Wed, 12 Feb 2025 06:49:05 -0500
X-MC-Unique: UcjStJuxMRq2y4WhGRwX_w-1
X-Mimecast-MFC-AGG-ID: UcjStJuxMRq2y4WhGRwX_w
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438e180821aso37878345e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360944; x=1739965744;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZNpFVnsh6lshbKMRE5Z9zohd8VxnEo1QVzFiZkw9iI=;
 b=MjltgBx+3ozxrh6vCMKWs7qSj3KISYOsB2M8EeV+OjmxC/S6CfVFk9cKgAK9mOPFQV
 RhlqC65X93FmiHXD04RAmbpBCo3ngjQWEhlEZKwAQLO4QScvjhRn1oyNaU1SHrAna4An
 ao+1Rxvy+p5IAJHK0DUGaMi+csmcmTKrQ4/S2qqfRT8DZqoPJJfRN+xN4JF48f3UrRPQ
 B5G5VRYZSIA57NpfgZfO+vvl1IYpAw9ya3F0AyRdDzjMbdf+ay40/lNDjd0RMia7/awu
 nHTRBSyQcavs6zPPT7Fqkfisi7yGznX8bqPOoOZ2nXT+crKyOjjqYzDcJ/794pVqZhap
 ZypA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYkamP2Ur3oy8gQ5FZu0GeTDsx7X/L/lqsyQNWJ8Pn83G9KnskKw6wrYVFNnZni8caG2F1F2lA72Ng@nongnu.org
X-Gm-Message-State: AOJu0YyQM4jxr7RlhRDlFe6TCgI2xexzhTDKtyPwvhf895YNCApKHAcJ
 wFENEmPVhI/YgvQOra4+1PWqDX1KH0YzCu8Hv1EpvwQKDIWqIKInel/aY6/EF3q9CRq3RHFXs/I
 atsqGPlD/WYJK16YG8wP9c0jFj0k7wkqkwNQ8OAk/o3KrTY1zQZq3
X-Gm-Gg: ASbGncs8DOsRY2fqxkAPrHD7EwIqx1fJ97A5iEXpKmSS5ilKAuUvoCYWdn6fhZngO4U
 QfFDMVN4ldIiXb+cr6s6hAkGC3zvTbLKpPQF2v6WImWuHGqN+GqDXHhNv7tioF6Jex8B+7HFBhe
 KWHfZ4AyRLk+QTIrlqfF3ARZQtJ0Vwu7AsUmJe0CpM7y95X7MdmIyFCWRQOHB2KW7LIn3AjyiPO
 2jyHXzfcEyrPWfPBOXze4/VvNLm36Y1TMQVsb+jvekNccX4xLAGVdlklyLoivpF6F7jPEJuUwK8
 RyXOOlHrkHNdZvtHc/kXZVQkXxa/W0lS8w==
X-Received: by 2002:a05:600c:19cd:b0:439:54a5:dde9 with SMTP id
 5b1f17b1804b1-43958188eb8mr27738215e9.13.1739360944604; 
 Wed, 12 Feb 2025 03:49:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFziqHSPG25YcITjJ0Upnjl4tVLReP52bqy78JryMjoVLeSi8TWNWQk994XRes6k7ILuOabqQ==
X-Received: by 2002:a05:600c:19cd:b0:439:54a5:dde9 with SMTP id
 5b1f17b1804b1-43958188eb8mr27737985e9.13.1739360944207; 
 Wed, 12 Feb 2025 03:49:04 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04cd53sm17806975e9.6.2025.02.12.03.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 03:49:03 -0800 (PST)
Message-ID: <86753d5f-c9f8-4107-91f3-4477fe44cc73@redhat.com>
Date: Wed, 12 Feb 2025 12:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] tests/functional: Avoid using
 www.qemu-advent-calendar.org URL
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-8-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250212112413.37553-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
> Avoid fetching assets from www.qemu-advent-calendar.org
> website, prefer fetching microblaze assets from GitLab servers.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_microblazeel_s3adsp1800.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
> index c382afe6bfa..5bf94d88dd8 100755
> --- a/tests/functional/test_microblazeel_s3adsp1800.py
> +++ b/tests/functional/test_microblazeel_s3adsp1800.py
> @@ -18,7 +18,8 @@ class MicroblazeelMachine(QemuSystemTest):
>       timeout = 90
>   
>       ASSET_IMAGE = Asset(
> -        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
> +        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
> +         'day05.tar.xz'),
>           'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')

You'd likely need to adjust the sha256 sum as well since I repacked with xz 
instead of gz ... but according to Eldon, the original download should be 
working again, so I'd suggest to drop this patch for now.

  Thomas


