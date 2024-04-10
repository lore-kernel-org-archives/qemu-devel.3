Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18247CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruTvP-0004MN-Mp; Wed, 10 Apr 2024 05:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruTvH-0004KS-CB
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:07:15 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruTvF-0004QT-Oo
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:07:15 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e2b41187aso7932634a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740030; x=1713344830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NriZmIpCo4uoERl+xoL5Cx3n0zsn0xUBPJoSaJ2NnDE=;
 b=orSiPDq4oDOO/DxZh+dnW4ENDaY9FTQSimiN8nf0JikM5QPNWLHOkDNsIReV3vDscG
 u7Qd1fQHIaLFHd4gdOZv2jgA9OdToLbil+n+ul63sKYT4GpsVJtZdS6NesbIk5asm1M4
 1HMz4MrPmp0lfoaqJdFDQUXOfY2E62q2YnVOOZ7IWUGw+gafdCphkUCdpQZuTjuFZJAO
 NcsdRNMhBdc/vo4MRRfx14h91Mh+JO4LKdr3ndkOnCTth4/DwJuL7EUxdKsgCizwZ+oW
 NI2EzjX0ocpwD0lGMM6Mu1HEvO3/qdy1bhWGKYIoT8HXK6QkyXFeCOy/OKlzQoJe8scV
 D6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740030; x=1713344830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NriZmIpCo4uoERl+xoL5Cx3n0zsn0xUBPJoSaJ2NnDE=;
 b=e6VS+9aHr1QLHAQ66WI6iqjPudOFCjc/fIEtF1CYe2tcuIzW2pIISHqIvssSDoC5r3
 PIDkT54CEcwq8pwnB5Xk4VqgbmO3uOBTbR7eZAttCxlWd5y14XtoRIYE1wIbwHeNyqhe
 VFSPRP41cywIG3sik/nxF01gprW618pLS1Wynt7yWEauIQCm3GCwJo1caqLJFT5935Td
 BSD62dR2FdWVuZK/lfZ2QCi+6zYUQrixI1VBs+sqjdpQEPPVgDscKhoPLf5U71PLArk+
 AB3nd2b0cJAfTjHPiuuyOawYNPBcqmRc66mn0yK0J+ucgER2RQojV7QHen5UWyQsBVh/
 7joA==
X-Gm-Message-State: AOJu0YxtTFT07ZRUF5Go80Vt3UVAtJNR3gbfpWS3vzBujvAN6MKnISOC
 DRKKRrYGEYxYpf5ESVDohGWKM9M9PxNTOXn/W1MR6fDzC8Y/aZVj5FFCv+XZ/B5oPemrCgIDCJU
 Q
X-Google-Smtp-Source: AGHT+IEgBFrKCVvR3Bq3FH36CL9SBdh8NOqRRd/tFghiRUnaYkxfuj2BcYdFCPpXGfvvI2GHT+Go3A==
X-Received: by 2002:a05:6402:5008:b0:56d:c77b:4f0c with SMTP id
 p8-20020a056402500800b0056dc77b4f0cmr4787037eda.2.1712740030065; 
 Wed, 10 Apr 2024 02:07:10 -0700 (PDT)
Received: from [192.168.69.100] (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 f14-20020a056402194e00b0056e72c4a330sm1709815edz.41.2024.04.10.02.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 02:07:09 -0700 (PDT)
Message-ID: <f5d59a3f-a808-43b7-a270-5b1263fa2482@linaro.org>
Date: Wed, 10 Apr 2024 11:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/virtio-snd: Remove unused assignment
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240410053712.34747-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240410053712.34747-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 10/4/24 07:37, Philippe Mathieu-Daudé wrote:
> Coverity reported:
> 
>    >>>     CID 1542933:  Code maintainability issues  (UNUSED_VALUE)
>    >>>     CID 1542934:  Code maintainability issues  (UNUSED_VALUE)
>    >>>     Assigning value "NULL" to "stream" here, but that stored
>            value is overwritten before it can be used.
> 
> Simply remove the unused assignments.
> 
> Resolves: Coverity CID 1542933
> Resolves: Coverity CID 1542934
> Fixes: 731655f87f ("virtio-snd: rewrite invalid tx/rx message handling")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/audio/virtio-snd.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Per IRC:
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks, queued.

