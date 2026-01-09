Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9DDD26D83
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 18:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veH1J-0000BJ-Sn; Fri, 09 Jan 2026 13:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veH16-0000Ar-4S
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veH13-0003E0-0p
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767982515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uEo2KtfbrULvmy8Avbqwnqa7VpkKDwgpSMC5zGp9AvY=;
 b=cUv1+aoKHtqypkxU8BV/IY0ocsVetQaCiPfSZLFR4o1BnLu9zwNuaUpIof66r65OuYQhlS
 uExK5v79Mxc2Az8GZtzIj1YNqEa6KrLCrAhjiXVWz5Tc16HC4fRRVaScDHkZP5VwO5V3wm
 ETCldOQ93pW6F1mlQlkG7eyS886s6/E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-soNpwUDTOnSIlBROzSe9Rg-1; Fri, 09 Jan 2026 13:15:14 -0500
X-MC-Unique: soNpwUDTOnSIlBROzSe9Rg-1
X-Mimecast-MFC-AGG-ID: soNpwUDTOnSIlBROzSe9Rg_1767982513
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6509eb7c54dso4324268a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 10:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767982513; x=1768587313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uEo2KtfbrULvmy8Avbqwnqa7VpkKDwgpSMC5zGp9AvY=;
 b=Njgrw4qx39qx1ILbvRawdfj6gQ/WF5GaB6zB85Gs02lrfNdNJ0mk8quyQYLv4qGh4M
 KPUCYCZnnDVFIee1RbLWaRH710CfQaKMn7z+IBmgVga2mzWRRfr/21ezULgKfQit8oIW
 JS/pFexMN3wVYq6NblTZbm4JBzDwswLktpmo356NLac2riy0OaUlU3c36eoD3+rDfFKY
 ulIFgX/oZXhIjXaYQl6ZAYrIfrCCga6xlP+9sJE7Uz21MZPDrVWfmJXV/rNeGHmz1OWp
 1iyDIqHBknkwfrgGNhEwrwFTXaejhYcGbZqdvlBI5kSawMNE2H9qA3P6MlpYncUPU9Tj
 zhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767982513; x=1768587313;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEo2KtfbrULvmy8Avbqwnqa7VpkKDwgpSMC5zGp9AvY=;
 b=GYLGH7S25GHP9BoCe4Aj6fs2CMne0wQ89iSs1GK7giIhjLqLBG7o6wym1oWWBlvzrR
 77tvfMFgLgijQj3qENi+6nxTyYL5raizQDWs/M1WmGsWD73wPs+g+DIbLEMSIl8Yq+ox
 EDyZN2ZmhkVHh2JNkQ9n3vleKiZt+RA82mvHmDwt9/PZf9M38ZX9b8f5tIp9SdP5DbYS
 GmFQ5tRfMcji3E8IhUhkrLAqeqxUNF/A0eSymmAFDknqFbyY86IieJPnzCua0Gc7m5By
 kZYIXGpjBzh+krFCdR7Ri/op9B7DirVDOykwn342yTC7IchVL5Ny/Cm6vA2KeC+wy+PS
 hqQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU2TgiK50lklxhtl8wzIGKPlmNqy8nwTv2v2jCabLPW7nAhTmaR3ZlsVk+eVpErW7UPh64PKHLeUYD@nongnu.org
X-Gm-Message-State: AOJu0YxUst6+QatRvLOoNlhPxjWDQ4+TNEWW3LMUJ+3JaOmWRmpzzXwC
 cqEIPIcopixblDzj/3BfGrbMSR8856G05e1O3/u74q1fdDExl5XVcvyTsS1HarIjGqstYkKzwdy
 7GBzEoD93oxd/GW1FrMrXDOCGzNWH6LBw2y6mDUAlnHZSRABWHaypi5QV
X-Gm-Gg: AY/fxX6q21aLxXe4oPNzQMaM0R7ZKblMfhv9OOEDKoyb3/dFO7R0QEdc3VDjlreRtm6
 0bM7BiAiApNw5BvrII4lIqUE4PW16BhwhGBFyVnINULPQsxzPqARoUwTrVmDg/s3//XMoM0l+5a
 NCLFr5VYDiZJWLm6SAmKwj6BdAc1RvlGvO7E874tkrppeZa9TtCfbTr3QQ4/IIiS9C8W0hL7P4b
 FGGENx5YeYNzlwjLhC+BPKDy46cArXcq2SwNA1GNOqfb7J6kPaReX14J1lRrE9VmUdt6sOsjXKO
 DLXEkbelBPnaLePzAorOhhywOHUiVWP0duTa6Or8Nkd44BvVhI3bsHuEVqsinCSUEReflFxgo2p
 z8SUQoxU=
X-Received: by 2002:aa7:c1d9:0:b0:640:a9b1:870b with SMTP id
 4fb4d7f45d1cf-65097e0740dmr7251155a12.14.1767982512871; 
 Fri, 09 Jan 2026 10:15:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/Ka7OnJyCDkHK1jve7QKBJftYDPd+odaCaVCHxxlArRnvDSel68uQjFCt5qQPRA9gTjC6ug==
X-Received: by 2002:aa7:c1d9:0:b0:640:a9b1:870b with SMTP id
 4fb4d7f45d1cf-65097e0740dmr7251129a12.14.1767982512520; 
 Fri, 09 Jan 2026 10:15:12 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf667fcsm10765944a12.29.2026.01.09.10.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 10:15:12 -0800 (PST)
Message-ID: <6da947aa-7fe1-4e97-a707-2fa3f462a0f6@redhat.com>
Date: Fri, 9 Jan 2026 19:15:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/29] s390x: Guest support for Secure-IPL Facility
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-17-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-17-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Introduce Secure-IPL (SIPL) facility.
> 
> Use fac_ipl to represent bytes 136 and 137 for IPL device facilities
> of the SCLP Read Info block.
> 
> Availability of SIPL facility is determined by byte 136 bit 1 of the
> SCLP Read Info block. Byte 136's facilities cannot be represented
> without the availability of the extended-length-SCCB, so add it as a
> check for consistency.
> 
> Secure IPL is not available for guests under protected virtualization.
> 
> This feature is available starting with the gen16 CPU model.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
...
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index 33f01f85bb..f13d2ac9fc 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -136,7 +136,9 @@ typedef struct ReadInfo {
>       uint32_t hmfai;
>       uint8_t  _reserved7[134 - 128];     /* 128-133 */
>       uint8_t  fac134;
> -    uint8_t  _reserved8[144 - 135];     /* 135-143 */
> +    uint8_t  _reserved8;
> +    uint8_t  fac_ipl[2];                /* 136-137 */
> +    uint8_t  _reserved9[144 - 137];     /* 138-143 */

Should that be "[144 - 138]" instead?

  Thomas


