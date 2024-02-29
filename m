Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1DCC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfeNl-0004Vv-K8; Thu, 29 Feb 2024 06:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rfeNk-0004Pb-Bl
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rfeNi-0002lQ-Nz
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709205317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r8z7s7ssE0ScOeWYuylVMOA2StBDf+TPMrHoNA0BGl4=;
 b=c72CMeXyo/zYWFkNoYQLoMJuiRcxj7Aq890q36GPbjacuo0vKXvpZylTrvRK+e13Y/bNeF
 dNBP7HeQvnU0AQkAMWr9XGlBne3pWAoFTNo32bKk1+brSSSWsgrbTXlJaz+RmZqHzTnPHc
 wV2+Q4aVc1jgiXZA9hgHIctVkxH2UwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-VUfzleu0MgmzivNfVYJTrQ-1; Thu, 29 Feb 2024 06:15:15 -0500
X-MC-Unique: VUfzleu0MgmzivNfVYJTrQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40e40126031so4479145e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 03:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709205314; x=1709810114;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8z7s7ssE0ScOeWYuylVMOA2StBDf+TPMrHoNA0BGl4=;
 b=l5Ka7dJ66cV8j3ug8DoYkrqP283JNFRedtjL7XpkvSfVfj5rNUoSaVb4oEzm5FP+xy
 mcyUjbQwHWRR+27SS/mBq2pY89Gwr42mlud40yzcO2cdPsM2mFC4YhpV3whBxbl5w34j
 pZ9yO6vCuEFFbo2wwsKkdYXYo0X5zW799M8pr89ve+h+dYHIV+HmYZlPHlccmWsOSOOh
 J7Oy9niZL9kYgBAvZhuRWRF0mZrije4FH5jq2SS1mwiOc36v+8znH8GdDhk+2s8BY0O7
 NSFMJ74BaawSgxNmg+ckkEIYB+tN9oHFelSCZieUkSsNPUvPcWjNrx1RUfkqziJrD4RB
 9h+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI2+7uNz/MedKO2H/Evd6sS6FkNsqM5Tf3JGYX91t13KnC9XPR12lcUsogX95vAc0eD/YcpRdXDme8LGPYy+j2iv5S0zI=
X-Gm-Message-State: AOJu0Yz1iWBxnITyv8IBfOxU75NfCrGVUtN/tTWGe5I7sXPxHrL7RqyZ
 wshXOHRTR2lG+g/9cqq3wZxjdikfzZ4UkhhTlQeVvRKSTrluWuaRi9rMEIm7Q4BmP8ESEnDI1Mn
 m2ej0BSqvRdknM19babALjgxPh0crBwKtY14UnciF6MifrVEOhbBM
X-Received: by 2002:a05:600c:4ecf:b0:412:952d:3c6a with SMTP id
 g15-20020a05600c4ecf00b00412952d3c6amr1804553wmq.13.1709205314729; 
 Thu, 29 Feb 2024 03:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEuXyAGQ1CuUAVfi4VnIzEY7RAIPR+Kk+8zOjHN2dMOtYrMMPwji1ZbdFfe1dh1uIr0PferQ==
X-Received: by 2002:a05:600c:4ecf:b0:412:952d:3c6a with SMTP id
 g15-20020a05600c4ecf00b00412952d3c6amr1804532wmq.13.1709205314338; 
 Thu, 29 Feb 2024 03:15:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:fa00:74f2:89da:ed65:8b50?
 (p200300cbc707fa0074f289daed658b50.dip0.t-ipconnect.de.
 [2003:cb:c707:fa00:74f2:89da:ed65:8b50])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a05600c128f00b0041290cd9483sm4773822wmd.28.2024.02.29.03.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 03:15:13 -0800 (PST)
Message-ID: <d4f39fea-bf1c-4177-a41d-afd1236f0a3d@redhat.com>
Date: Thu, 29 Feb 2024 12:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: Fix format of the memory-backend-file's @rom
 property doc comment
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240229105826.16354-1-sgarzare@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240229105826.16354-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29.02.24 11:58, Stefano Garzarella wrote:
> Reflow paragraph following commit a937b6aa73 ("qapi: Reformat doc
> comments to conform to current conventions"): use 4 spaces indentation,
> 70 columns width, and two spaces to separate sentences.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   qapi/qom.json | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 2a6e49365a..db1b0fdea2 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -668,19 +668,20 @@
>   # @readonly: if true, the backing file is opened read-only; if false,
>   #     it is opened read-write.  (default: false)
>   #
> -# @rom: whether to create Read Only Memory (ROM) that cannot be modified
> -#       by the VM.  Any write attempts to such ROM will be denied.  Most
> -#       use cases want writable RAM instead of ROM.  However, selected use
> -#       cases, like R/O NVDIMMs, can benefit from ROM.  If set to 'on',
> -#       create ROM; if set to 'off', create writable RAM;  if set to
> -#       'auto', the value of the @readonly property is used.  This
> -#       property is primarily helpful when we want to have proper RAM in
> -#       configurations that would traditionally create ROM before this
> -#       property was introduced: VM templating, where we want to open a
> -#       file readonly (@readonly set to true) and mark the memory to be
> -#       private for QEMU (@share set to false).  For this use case, we need
> -#       writable RAM instead of ROM, and want to set this property to 'off'.
> -#       (default: auto, since 8.2)
> +# @rom: whether to create Read Only Memory (ROM) that cannot be
> +#     modified by the VM.  Any write attempts to such ROM will be
> +#     denied.  Most use cases want writable RAM instead of ROM.
> +#     However, selected use cases, like R/O NVDIMMs, can benefit from
> +#     ROM.  If set to 'on', create ROM; if set to 'off', create
> +#     writable RAM; if set to 'auto', the value of the @readonly
> +#     property is used.  This property is primarily helpful when we
> +#     want to have proper RAM in configurations that would
> +#     traditionally create ROM before this property was introduced: VM
> +#     templating, where we want to open a file readonly (@readonly set
> +#     to true) and mark the memory to be private for QEMU (@share set
> +#     to false).  For this use case, we need writable RAM instead of
> +#     ROM, and want to set this property to 'off'.  (default: auto,
> +#     since 8.2)
>   #
>   # Since: 2.1
>   ##

Ideally, we'd have a format checker that complains like checkpatch 
usually would.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


