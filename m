Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747AEC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZIx-0002VY-9G; Wed, 24 Apr 2024 05:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzZIv-0002V4-LK
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzZIu-0007A4-7w
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713952358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Pi93RCB7e386nX6NGUjxXw3F5yXnr8W5em1y8VkGNgs=;
 b=GFI0CgVhp9UtY0GnK9A5pYcn96Qu33hOma+YkCPajapi9Eje0KEy0oLuQoSa6EKcw90P4Z
 UfBqoyTFUY9I28R8FBO5zV/zCUZ+jiRFTNYg+DNl4r1tDXq56bL7K4S0n16J5DBO2lzX/+
 xeIrv2wC7KZqloxGTFql8RSzGC/BlBs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-ogSNu8abO1-25QefmdO0fg-1; Wed, 24 Apr 2024 05:52:36 -0400
X-MC-Unique: ogSNu8abO1-25QefmdO0fg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78ed2a710efso972811785a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 02:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952356; x=1714557156;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pi93RCB7e386nX6NGUjxXw3F5yXnr8W5em1y8VkGNgs=;
 b=CFoh/DEh67HthxxoEw5ATeQM8PjxxFKYyayJVH/2hnhNVJrImmK5dBC0xJtFWt6WwE
 i1d9pYexqzVXspxDQpZEGNgyEEAY8D+WmqF/g5J/OU6obReyYEDKlpDnsxcRO5CWKNgI
 OAiS94qXgpbXPSyDea9N2hnrkzdeyzsS0naUrSM6xItM8JP8psnwBcVRT1czFeSI03bV
 Vy70IE5Fn8rT92X1Zj2fj7EvKgG45S7KdDTwur22ejxlcyY8GHxLtx+iiAJFU6NEv4Gm
 Lghwhhtn+bLUmDx8OoBxd9XS1cbv8/eCxX2ylr2v7qeObEFiYiKE2Cb5AFHx3MkB67UA
 pFHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxgf8w5cDb5ODxXXvCvztzt0ToCrjDq2YgIoEscoBlwlbjGhQPq9mBAl8SAS8QDRFPKVuYMBObbAVmlnXm8msk4S+ZR0w=
X-Gm-Message-State: AOJu0Yzpxf6+7VbJLYIERxinFV3Qo0RRAxEM/SP/NsMl0N6nZcVFaZ1o
 ug+RIdGzy+xU2ciNGFZypZ3F+qrmcGuVEQisbLsRlvJBlSg3VsIa/46g46Miw6EJY5EPvXT+DeL
 kfDYh7G21I5VONaDkJGjXgru8+OwjlVK8fE6Foaz6RyzmT8EIysvT
X-Received: by 2002:a05:620a:4d18:b0:78f:964:49ee with SMTP id
 wa24-20020a05620a4d1800b0078f096449eemr2282723qkn.48.1713952356413; 
 Wed, 24 Apr 2024 02:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcvaQdnUrmNWZwmha820rWFX7FRmtUi2d3yfz+WU/yn0X/2vLiumoYyvfDXBDYQTtDGbtIQg==
X-Received: by 2002:a05:620a:4d18:b0:78f:964:49ee with SMTP id
 wa24-20020a05620a4d1800b0078f096449eemr2282709qkn.48.1713952356144; 
 Wed, 24 Apr 2024 02:52:36 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-130.web.vodafone.de.
 [109.43.177.130]) by smtp.gmail.com with ESMTPSA id
 1-20020a05620a04c100b0078ef8c994bcsm5995365qks.105.2024.04.24.02.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 02:52:35 -0700 (PDT)
Message-ID: <488595a9-8302-413e-9b54-081492533804@redhat.com>
Date: Wed, 24 Apr 2024 11:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] checkpatch.pl: forbid strerrorname_np()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 alex.bennee@linaro.org, philmd@linaro.org, mjt@tls.msk.ru,
 ajones@ventanamicro.com
References: <20240424094700.453356-1-dbarboza@ventanamicro.com>
 <20240424094700.453356-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240424094700.453356-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/04/2024 11.47, Daniel Henrique Barboza wrote:
> Commit d424db2354 removed an instance of strerrorname_np() because it
> was breaking building with musl libc. A recent RISC-V patch ended up
> re-introducing it again by accident.
> 
> Put this function in the baddies list in checkpatch.pl to avoid this
> situation again. This is what it will look like next time:
> 
>   $ ./scripts/checkpatch.pl 0001-temp-test.patch
>   ERROR: use strerror() instead of strerrorname_np()
>   #22: FILE: target/riscv/kvm/kvm-cpu.c:1058:
>   +                         strerrorname_np(errno));
> 
>   total: 1 errors, 0 warnings, 10 lines checked
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   scripts/checkpatch.pl | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7026895074..be0982246d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3056,6 +3056,10 @@ sub process {
>   		}
>   	}
>   
> +	if ($line =~ /\bstrerrorname_np\(/) {
> +		ERROR("use strerror() instead of strerrorname_np()\n" . $herecurr);
> +	}
> +
>   # check for non-portable libc calls that have portable alternatives in QEMU
>   		if ($line =~ /\bffs\(/) {
>   			ERROR("use ctz32() instead of ffs()\n" . $herecurr);

Reviewed-by: Thomas Huth <thuth@redhat.com>


