Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615BDCF58D1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 02:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLu3f-0002ii-85; Wed, 19 Nov 2025 21:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1vLu3d-0002i6-Ag
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 21:06:01 -0500
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1vLu3b-0007aW-Iw
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 21:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1763604351;
 bh=ERZJL79SjhR+JQZ/QIpJhbs4+rNSD8l3AAKWiy5U7Ws=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DsWhy8nbd0derpQ/Na9p4byhLXhZ27hi0i6a9yWk7mR6Jw5iqta/EAhOwwbVgAGXD
 O4p1ZnbhotQ2dw5zNNcmRdLYil1xN2MDLNAbX5LFdTacwc/Z9IEOA9v8+Y2hKZgXLI
 0usTw+zTbUUjZYdOsdKhvP2AG8r/0bd1dr/smCJ1pxhBYY1JSi1r5VM3X3swHb6aSA
 O/SmM1QQUy8jOTqaaFvTf9GGpzE1qtml0Iytx29krwrfNKFjVPJeJAL53zym6cGDi9
 RDkHGSOmpg+mnuYrXXJ0jqxgTaaJPc4eb0MG6KfsNGmsrYUKZhiDAOiPachajie2FB
 EwcYrM5M8xIHA==
Received: from [192.168.1.114] (220-135-139-18.hinet-ip.hinet.net
 [220.135.139.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 469942812;
 Thu, 20 Nov 2025 10:05:51 +0800 (CST)
Message-ID: <69fcacc5-6804-4f76-8ccc-9e1e11cd38cb@sean.taipei>
Date: Thu, 20 Nov 2025 10:05:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] contrib/gitdm: add more individual contributors
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-10-alex.bennee@linaro.org>
Content-Language: en-US
From: Sean Wei <me@sean.taipei>
In-Reply-To: <20251119113953.1432303-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks for adding me to the list!

Acked-by: Sean Wei <me@sean.taipei>

On 2025/11/19 7:39 PM, Alex Bennée wrote:
> I'll only add names explicitly acked here as its quite possible people
> are using different addresses than their company affiliation. Let me
> know if you want contributions mapped to a company or academia instead.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
> Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> Cc: Tomita Moeko <tomitamoeko@gmail.com>
> Cc: Julian Ganz <neither@nut.email>
> Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Cc: Sean Wei <me@sean.taipei>
> Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Cc: Phil Dennis-Jordan <phil@philjordan.eu>
> Cc: Jackson Donaldson <jackson88044@gmail.com>
> Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
> Cc: Roman Penyaev <r.peniaev@gmail.com>
> Cc: William Kosasih <kosasihwilliam4@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Tanish Desai <tanishdesai37@gmail.com>
> ---
>   contrib/gitdm/group-map-individuals | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
> index d7116f5444f..4ac0f99b87c 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -42,3 +42,17 @@ shentey@gmail.com
>   bmeng@tinylab.org
>   strahinja.p.jankovic@gmail.com
>   Jason@zx2c4.com
> +amarjargal16@gmail.com
> +soumyajyotisarkar23@gmail.com
> +tomitamoeko@gmail.com
> +neither@nut.email
> +ktokunaga.mail@gmail.com
> +me@sean.taipei
> +roy.hopkins@randomman.co.uk
> +phil@philjordan.eu
> +jackson88044@gmail.com
> +weifeng.liu.z@gmail.com
> +r.peniaev@gmail.com
> +kosasihwilliam4@gmail.com
> +linux@roeck-us.net
> +tanishdesai37@gmail.com


