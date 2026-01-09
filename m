Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D59D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6gp-0001oC-FO; Fri, 09 Jan 2026 02:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ve6gm-0001mj-Us
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:13:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ve6gj-0004vD-S0
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767942817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RZb7596LX8AwpniZKcpolyIgrqfZ5WC5piRVhMy+MEU=;
 b=QXbxbqT+LHAE5ogSSt19YPj3ZLJx/g0my6n1+5Y7Q5srhk4LdSgWirmPl7PprLEI/kuGih
 YJ7Yr4iGsqh4+9Eq6Vb2laFVBwQGLkWqFToGMjrXy0o/P6s0N1xftxdWoLAykjnHlw2E8J
 F0gGEw7wryxcVMuzbOVqyqW0PmN7fjQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-FKdu1tyFOBSlb9wAXJV_WA-1; Fri, 09 Jan 2026 02:13:33 -0500
X-MC-Unique: FKdu1tyFOBSlb9wAXJV_WA-1
X-Mimecast-MFC-AGG-ID: FKdu1tyFOBSlb9wAXJV_WA_1767942812
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-64b735f514dso4916834a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767942812; x=1768547612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RZb7596LX8AwpniZKcpolyIgrqfZ5WC5piRVhMy+MEU=;
 b=QLJDIrD2EmdU2e3KRU3JaOrjtGP3m6MzWoqxpa8vEYfQcwVU0Bu5XoVLC7GW62ICle
 Y7N59S936xfoo/zkboNXRcl1Ag53pMSRs9cZbflicDzDQHIIVsSSDj8GJV+JbOBgCR4O
 gk/w67lIzLN02BCPgBOKIYLHTP5HrUiTMRj6Pnm2EpBh26VrFh+40zp4eMO84jDH4foX
 dn30M/MC6wOpbE472zGPvd6d0Gc1gq0nWNSuA/vB1u3u5sdRdAkYi3kYMngn9XsZmo02
 D7/CIuIRBzLnsHANaWOqKoDeLJyqba2fijJIz8cpgCn2kKhDSNpHk2ScaZxOwx7T52Tj
 FnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942812; x=1768547612;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZb7596LX8AwpniZKcpolyIgrqfZ5WC5piRVhMy+MEU=;
 b=KyTfICPaTJh5Pru8agRXMAa7EcYHu0xKzRgWhjVElr1JraRT/BRW+dNQnSmiHOBAxE
 vVl+4SzN6P9UwEaUz3FlxkvBQbHzxrM9+fgfanhvCBDUIJU6KH/C3PvX9Rl4OYH7Q9hM
 wMW3RG65nsmrkcVPRKaq8ex82EFhKqXkQzH7jnVPB3rH1PYB5suzdFQtAgk+htJCfjWe
 dBJtT8DpHy4BQ2U58kn9E07Etnk4pinGU2JBJIFayyUU8VAAPvALhbiVbEjCS/p09vKh
 nJeByOS3BzwZlmwCNtFXPrrJvZvkPqkBMv1YWriiAoQDtNcPl87A3TngEMGT5C0mIbMn
 nRKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7pIDLsz37yCv+KwmoeRrcMssizxTPpeETjt0e8U48lsADlAx/DmWUmOqQv+OZtS4qRl8/cTUh0Sji@nongnu.org
X-Gm-Message-State: AOJu0YyoDbNZCQlOY1fS6ZDKRo6U1+EXgTIXmlejSFSzVXVVfPqAe7dw
 Z5/2uv8q+9lhpWCeHtWeP1GnND9wtgXAPxMQJkYXNCOlFbviJMc5O1xj9FboPJu7r7hMZOfE47h
 AZQRRPG0P8JbolIyqf5XQAHb7VjgHliyH+fiVgNYrOo0XFZRFvm/Ob/+H
X-Gm-Gg: AY/fxX4kxv2E//cj8lajN0GLZ8jRyi2Dj/qRnu4TQG6saufbmiFV9hmivnrJ5cDDlEU
 eEDKruYt0lewNtCmh3scbqmBTSBT8imWPDTb8SsFO3QDUH4Tq3bZp+kTX2CPM1J1d3X3Pn6ewYv
 l3sZfpLbVmR2X2/NRWos6MFc1//vlyfe9BAPjraBvJj+lpLHdToDZQx6d73pNoGf31hlhAW3KCz
 EDP51UkoCtMyhCmoVLfhrv3JL9IdJzXqY5y1LCPojFAgyzKL2X2+c3fBSs1gCVXxANuwXIRtbZX
 ASUK1uM2rPZbu+UXDr+31xfFZSgaCYPzSbTxDFBEWw4eR6cvvqI6Q4CM5Sf1wsM8dOlu5eP8fUb
 o94xBtGo=
X-Received: by 2002:a05:6402:13ce:b0:64d:1a0f:694b with SMTP id
 4fb4d7f45d1cf-65097de79a8mr7615189a12.10.1767942812106; 
 Thu, 08 Jan 2026 23:13:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzSS3Rt/xU0fD+W2RHMA5PbQM5mvdzqmNHJmGCEQKrMmLK7nNp+5Y0Edh1ZwUz2R5DhyzuqA==
X-Received: by 2002:a05:6402:13ce:b0:64d:1a0f:694b with SMTP id
 4fb4d7f45d1cf-65097de79a8mr7615156a12.10.1767942811650; 
 Thu, 08 Jan 2026 23:13:31 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm9547490a12.0.2026.01.08.23.13.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:13:30 -0800 (PST)
Message-ID: <646a8d17-633f-40c0-a5b1-b69d7ed4abcf@redhat.com>
Date: Fri, 9 Jan 2026 08:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/29] pc-bios/s390-ccw: Add additional security checks
 for secure boot
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-22-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-22-zycai@linux.ibm.com>
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
> Add additional checks to ensure that components do not overlap with
> signed components when loaded into memory.
> 
> Add additional checks to ensure the load addresses of unsigned components
> are greater than or equal to 0x2000.
> 
> When the secure IPL code loading attributes facility (SCLAF) is installed,
> all signed components must contain a secure code loading attributes block
> (SCLAB).
> 
> The SCLAB provides further validation of information on where to load the
> signed binary code from the load device, and where to start the execution
> of the loaded OS code.
> 
> When SCLAF is installed, its content must be evaluated during secure IPL.
> However, a missing SCLAB will not be reported in audit mode. The SCALB
> checking will be skipped in this case.
> 
> Add IPL Information Error Indicators (IIEI) and Component Error
> Indicators (CEI) for IPL Information Report Block (IIRB).
> 
> When SCLAF is installed, additional secure boot checks are performed
> during zipl and store results of verification into IIRB.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index c1c5bc682a..8733254cfb 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -206,6 +206,12 @@ static bool secure_ipl_supported(void)
>           return false;
>       }
>   
> +    if (!sclp_is_sclaf_on()) {
> +        puts("Secure IPL Code Loading Attributes Facility is not supported by"
> +             " the hypervisor!");
> +        return false;
> +    }
> +
>       return true;
>   }
>   
> @@ -218,6 +224,402 @@ static void init_lists(IplDeviceComponentList *comps, IplSignatureCertificateLis
>       certs->ipl_info_header.len = sizeof(certs->ipl_info_header);
>   }
>   
> +static bool is_comp_overlap(SecureIplCompAddrRange *comp_addr_range,
> +                            int addr_range_index,
> +                            uint64_t start_addr, uint64_t end_addr)
> +{
> +    /* neither a signed nor an unsigned component can overlap with a signed component */
> +    for (int i = 0; i < addr_range_index; i++) {
> +        if ((comp_addr_range[i].start_addr <= end_addr - 1 &&
> +            start_addr <= comp_addr_range[i].end_addr - 1) &&

Instead of comparing with "<= end_addr - 1", please simply compare with "< 
end_addr" instead. That's easier to read and avoids bugs like wrong 
comparisons in case of end_addr accidentally being 0 (so you would get a 
wrap-around when subtracting 1).

> +            comp_addr_range[i].is_signed) {
> +            return true;
> +       }
> +    }
> +
> +    return false;
> +}
> +
> +static void comp_addr_range_add(SecureIplCompAddrRange *comp_addr_range,
> +                                int addr_range_index, bool is_signed,
> +                                uint64_t start_addr, uint64_t end_addr)
> +{
> +    if (addr_range_index > MAX_CERTIFICATES - 1) {

">= MAX_CERTIFICATES" without the "- 1"

  Thomas


