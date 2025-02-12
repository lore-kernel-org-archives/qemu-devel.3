Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AC1C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiB43-0001P4-OZ; Wed, 12 Feb 2025 06:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiB3u-0001N4-Dc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:37:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiB3r-0008Qt-0u
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739360264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fdAx9belAf6W5/OTtK5Mrt9oS3V2UprySoa1u+ILRdA=;
 b=P6x14nfHOKhipJ0Dd7ibJ4cujdW7PT9Ugdlb2s8N5RB7IlCGCHDAOOFxyJOXq0lJlQAwJ9
 cwr0127/3topYlXVxz1IcCPNgNYtVUdwdpJGhNRIVaeibmFerpBRyblluG8zbQgDQMn32O
 uOEaKDr/3cWdJj4htG+fPbYF7j+KmU8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-G3gHQuwTPLulhW0E29YTow-1; Wed, 12 Feb 2025 06:37:42 -0500
X-MC-Unique: G3gHQuwTPLulhW0E29YTow-1
X-Mimecast-MFC-AGG-ID: G3gHQuwTPLulhW0E29YTow
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38ddf4fa345so1790668f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360261; x=1739965061;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fdAx9belAf6W5/OTtK5Mrt9oS3V2UprySoa1u+ILRdA=;
 b=QLdLgPlXEmN8ZA8xgvJ22a+QrL4nY/K8+KPq74VLjn0tsKdkOc1OAoPdZx6TWy9YRj
 wGNxAneM81fUdTfOhIaPrHQVeaLjfpsG/5CoMYFZHfmfML8/E4ZtIOUnw9I78Zquyfni
 ST2XecDj42t+AqjUTp9Dx5j2W2TD4TrLv6CGm8Byp8m3X0uu3U2M5NKDKBbWE8NQrCJj
 iIWkDEduAHXCFGioIgZ0lsBNnYTsx/Sou+fzP+TjM5ev+yUSupRrvkaB1sBwqBuPKto/
 H1IY4ltU3JfWO/cQXB/yEZSD+YjENsj6hJQ4oGAvJ24Cvzaubw3+AwWP/omAlTu+Ph4v
 reKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyR39Yiftc+pGD6XJ48FFCqUap6/LTuzlXKQfjK0BjPVUHaLHZPsnq61RBJ9cb3jmzgPAH4uy514MS@nongnu.org
X-Gm-Message-State: AOJu0YzwwC2BghiBr5w7zEyNs39df1/q13AvkWdME01vaWKp32BQ90Yq
 ykOLUucZOsx8ks8sdwHiAG586sPF+3zEdZx6TnAubkt63XrqPi5fRcN0XQCQPvn0MOlXxdqdQTm
 kjYSRsMbx3NsJNtiY6Yy9JLMF2YKHhGihtZlc0yY6hWciur5cTeVt
X-Gm-Gg: ASbGncsZzv8FfmqnIrSuIxOvwimOG1IW/ptjR/pZlMCBCxqWYV0K+1Jk13nGg2g3/lC
 +19upyTvy6jeWcMPWOKk2WoFxau44gZO0Nn0+9m7k1cmiEVgDdsj1gd37jyOL/cWldjlWPs0ztx
 93cuTBTeU2uE2qyzAbW4r2VRUBinObAZgA80sD/S2jRms6NiA4mKMIZD+Tf7p+mkc67X6CV335a
 2JadQGuXRCMBZDPulk7uLhGCkAG2u/uQzwDXGxc0po/FPUEbYHTBXOWr2ZeJJ35bpJ5d0hBGpW2
 XRwZKaXJmIiZlvuaztDGD+xVF1aXzuR2dA==
X-Received: by 2002:a05:6000:1887:b0:38d:d69e:1326 with SMTP id
 ffacd0b85a97d-38dea25917emr1984522f8f.9.1739360261608; 
 Wed, 12 Feb 2025 03:37:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlFC6J/cuJbi5s9mo0Cj8OHoQL1hf7dLhicQRKIUADg1ueKyFbiVob+EsgUpMBByyc4bN7IA==
X-Received: by 2002:a05:6000:1887:b0:38d:d69e:1326 with SMTP id
 ffacd0b85a97d-38dea25917emr1984494f8f.9.1739360261094; 
 Wed, 12 Feb 2025 03:37:41 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcaf3e4bcsm14209303f8f.41.2025.02.12.03.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 03:37:40 -0800 (PST)
Message-ID: <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
Date: Wed, 12 Feb 2025 12:37:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250212112413.37553-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
> Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
> Endianness can be BIG, LITTLE or unspecified (default).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qapi/common.json                    | 16 ++++++++++++++++
>   include/hw/qdev-properties-system.h |  7 +++++++
>   hw/core/qdev-properties-system.c    | 11 +++++++++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/qapi/common.json b/qapi/common.json
> index 6ffc7a37890..217feaaf683 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -212,3 +212,19 @@
>   ##
>   { 'struct': 'HumanReadableText',
>     'data': { 'human-readable-text': 'str' } }
> +
> +##
> +# @EndianMode:
> +#
> +# An enumeration of three options: little, big, and unspecified
> +#
> +# @little: Little endianness
> +#
> +# @big: Big endianness
> +#
> +# @unspecified: Endianness not specified
> +#
> +# Since: 10.0
> +##
> +{ 'enum': 'EndianMode',
> +  'data': [ 'little', 'big', 'unspecified' ] }

Should 'unspecified' come first? ... so that it gets the value 0, i.e. when 
someone forgets to properly initialize a related variable, the chances are 
higher that it ends up as "unspecified" than as "little" ?

Apart from that:
Reviewed-by: Thomas Huth <thuth@redhat.com>


