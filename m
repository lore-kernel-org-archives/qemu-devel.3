Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A486BC54756
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJSG-0004eD-DA; Tue, 20 May 2025 05:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHJSD-0004c2-Ja
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHJSA-0004oZ-GA
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747734004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gATNAu7ZaadwF1TzbRuFg48isk0ebmMKwiLvZUYxRLA=;
 b=e6HXQaxLVLnFYHuqMcmSzEMIZiVlB2snvEqtX/1Q2gaVomU58En4iJDWqcPHOgX1nV3PfN
 Ms3sEl1g1OGVpI62Ky10omQU9OLAB+9s1zXzIR3lQvAo00BgpSUTZIk01m8jEdVhh+sfbI
 NIkB66PtNdzpcg52+ZUki2P547aYeZo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-RI7H4mi3PBSegO9yE8ZaSQ-1; Tue, 20 May 2025 05:40:01 -0400
X-MC-Unique: RI7H4mi3PBSegO9yE8ZaSQ-1
X-Mimecast-MFC-AGG-ID: RI7H4mi3PBSegO9yE8ZaSQ_1747734001
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a375938404so1067801f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 02:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747734000; x=1748338800;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gATNAu7ZaadwF1TzbRuFg48isk0ebmMKwiLvZUYxRLA=;
 b=w9fQJqmoM1bI0QAyPSxOhqLuSARTvhe26KqEFeEfpXjN2kmrmoQjMK89avYk2X5Gn9
 ZTu7ulYntGAOkcuSSMBNLNrPC3PdbXfJS3X99dL11tsmKTEApenrU4/Nx6E2aympzX8b
 tLut/JzwPQ/pAScXl7WbiQVrZxo3AIh0RZfqQGbAKNea6KFVo5tZIC/yfU2JLAtd0ErI
 BcHhflQQBMYWvQYdPrreIgsRFiqDfysez3FqS/XWyzSq8LVGNIIq2ZhePgYCvkgFn6Qx
 fzVQs7xIHZ1N/92MPENva3ybQtu73hfxugQvjMC7PQzLY97vwfGphYaYykUD/+xncyl3
 6AUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP8eT4ZczdAptY/5Q4W+Q1c4zIcbe6d99MFnqwIN97fUWP8Sw7MOekqw4o7XB2+zqBD3Mq+/8xNC2t@nongnu.org
X-Gm-Message-State: AOJu0YxXhzDrX87dmdFlkKhD6pnTlZjITCNnPf2+IaRPl5IVeDvWNeAZ
 M5j/zI5UGiQCuOgnOUVCt8YVBgIzVAiXm2C4IdGabdRB3Y5eLQx+n2hxO0gm2ZZnYg9trJVEaze
 GEz5Gycn1iQk+FGAn44iw6fcPkKC5YUR1KzUVjuv+aJurwT3PP5Lcjhnq
X-Gm-Gg: ASbGncsw7HIzqKj+/NEOKxP5UwBYw+A1jPlawtdAPLdIj0bW5Yea6rc19VlPvo7H8Lb
 7dI87jSAhqdwDxWFzZT2jYu/DACBESwQDzrJrLjwevI73ufVXh20rw/ABUJc7mR0FfeShwgohJe
 2UNSz6EaKX9aRf+UCWeZEnoAZaAO4k2T5pVc1cll8qSEWDQQRvcmNG8uPiAcg12qskYBJKf2RHe
 IExSyvaZcqcesIGZEDvlKswalmK+SlKOoz2eKyHMOn2MJZkR0w9BIkaieCHonTbP3HjSNR94bC0
 az7E4S3A+3LTZk4hdlV3KNsxYTtGCUpMFlOfsE0B6vk=
X-Received: by 2002:a05:6000:1862:b0:3a3:5568:b8ca with SMTP id
 ffacd0b85a97d-3a35fde119amr11749271f8f.0.1747734000596; 
 Tue, 20 May 2025 02:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVdCKgkzzYfH2vLn1c9cQCVVlQqQrmU3rLH5rZ7vqfEq2MHGyBlx+OaLXBPjrF8wVtfowGOg==
X-Received: by 2002:a05:6000:1862:b0:3a3:5568:b8ca with SMTP id
 ffacd0b85a97d-3a35fde119amr11749239f8f.0.1747734000143; 
 Tue, 20 May 2025 02:40:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8896dsm15595678f8f.73.2025.05.20.02.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 02:39:59 -0700 (PDT)
Message-ID: <fe6f9936-6d9d-4df7-953a-3ff76e58f024@redhat.com>
Date: Tue, 20 May 2025 11:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/25] pc-bios/s390-ccw: Refactor zipl_load_segment
 function
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-17-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250508225042.313672-17-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
> Make the address variable a parameter of zipl_load_segment and return
> segment length.
> 
> Modify this function for reuse in the next patch, which allows
> loading segment or signature data to the destination memory address.
> 
> Add a comp_len variable to store the length of a segment and return this
> variable in zipl_load_segment.
> 
> comp_len variable is necessary to store the calculated segment length and
> is used during signature verification. Return the length on success, or
> a negative return code on failure.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 485b55f1bf..3dd09fda7e 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -613,19 +613,18 @@ static int ipl_eckd(void)
>    * IPL a SCSI disk
>    */
>   
> -static int zipl_load_segment(ComponentEntry *entry)
> +static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>   {
>       const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
>       ScsiBlockPtr *bprs = (void *)sec;
>       const int bprs_size = sizeof(sec);
>       block_number_t blockno;
> -    uint64_t address;
>       int i;
>       char err_msg[] = "zIPL failed to read BPRS at 0xZZZZZZZZZZZZZZZZ";
>       char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
> +    int comp_len = 0;
>   
>       blockno = entry->data.blockno;
> -    address = entry->compdat.load_addr;
>   
>       debug_print_int("loading segment at block", blockno);
>       debug_print_int("addr", address);
> @@ -662,6 +661,9 @@ static int zipl_load_segment(ComponentEntry *entry)
>                    */
>                   break;
>               }
> +
> +            comp_len += (uint64_t)bprs->size * ((uint64_t)bprs[i].blockct + 1);

So you're doing the multiplication in 64-bit here, but comp_len and the 
return value is only 32-bit ... that sounds like either the multiplication 
could be 32-bit only, too, or comp_len and the return type should be 64-bit?

  Thomas


>               address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
>                                            (void *)address);
>               if (!address) {
> @@ -671,7 +673,7 @@ static int zipl_load_segment(ComponentEntry *entry)
>           }
>       } while (blockno);
>   
> -    return 0;
> +    return comp_len;
>   }
>   
>   static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
> @@ -685,7 +687,7 @@ static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
>               continue;
>           }
>   
> -        if (zipl_load_segment(entry)) {
> +        if (zipl_load_segment(entry, entry->compdat.load_addr) < 0) {
>               return -1;
>           }
>   


