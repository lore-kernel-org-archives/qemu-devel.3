Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96605C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 06:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTx8Y-0007dC-6l; Tue, 24 Jun 2025 02:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTx8T-0007bl-2P
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 02:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTx8O-00086O-OR
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 02:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750746474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gfnAkgi0MpkMFnH0sstCKq0ZQvham9aRSuxNOfK2hFA=;
 b=DUhn/WgBSzWvpOb1MR9Zdqo/nIEi7wD2YwbzZQjatZf+lGC6GBd3QNHEMzE6AsDSm8XyCl
 YcnGypgel70OCjTmlsAIxMPXpa5g2ArDvOgNKBevHDXpmZGmZCNfXNc5ondwPK3jTWgLox
 BNo1LX+sk9TKH8RbGYtNDSIEJgKdbgM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-9LtRk70iPkeoqiXfrtepgw-1; Tue, 24 Jun 2025 02:27:52 -0400
X-MC-Unique: 9LtRk70iPkeoqiXfrtepgw-1
X-Mimecast-MFC-AGG-ID: 9LtRk70iPkeoqiXfrtepgw_1750746471
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a579058758so2095036f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 23:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750746471; x=1751351271;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gfnAkgi0MpkMFnH0sstCKq0ZQvham9aRSuxNOfK2hFA=;
 b=F9N94TauEuM43qMFBbwySBn0jwqSt56pdf6Ok1qh34zifrtcoIxoz2loE5cYHNwABl
 YoIcaG38j1i7KMaonG6Gs+kuMp7L3saHEr4/CViUHcGVG9om/F3ErmI0mtU/WpCf2pbr
 wJgVW4Zr7v9g+AenGTy7yRYeebaTuuDky4Or6kkEFsTEDiqTQZTzsfhOTMuG0wIVe1QH
 MrMuiLeGIA4cVVmHeaXFy7HceDcCIG5LAf+uMg/31moqeBtzyZkm+Zdcd8mCbdOK9Sdz
 HJs+xBF3eCUEIFcHTW02t14Jxj1hpEd+nghRw6+uFEZf5HfMpWUiOl/Y2KkyAwyBEt1F
 dnTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqFVOxgLglYTcCFTyJjykRNWFWnrrFWeWJBQcQEF0o8rGndl91p9yp35UBqOh/2id/yGgo/LQuBoTx@nongnu.org
X-Gm-Message-State: AOJu0Yy2orv2r8eTJnPvmriMHFRK8SzUuLtfOTBcy0c1Idv4+NLJjjhi
 mtpixulkzWoXEWWVPze6cKTCtcBL8jl9poOGT3pjVzYTiqn19OGqNHTHicBPOI5SwiqqqBk0qLJ
 gkw0/fizaXFgF1ZbtIFNhlG0u0qX0WXhrX0alM3QvKU6lw/xklvBzCnnL
X-Gm-Gg: ASbGnctIwJLRFGTSO2pU9mtbOCZKSsdxcaeP1T7j9967l9/j/gFtg4jP+T4zIPz6+/E
 fLC2T2kZoFCvDxHzdvs9/TuNkzX3FE1o72uOtnwqogH+JPE2tLLM5yq7VVq5/mWaS34sM0RJhL3
 AmSDnFI/3h5P+oVYqZs/3SVlzf7IQ3uytodfOiGEQ+sJsj0gYCRtgbCHjlnz+m5TMS8n/tl/i2J
 6biotgvUJ0+J43wA22cZT0dsDKyX/TDm36VXvqEUqHpqbVHz2fq0STrYgFtgk9eU15QNXLRoey+
 NT14gGHtR/jBRrSEnGR1O08PCYqOfjqlIJC/EroKChhCRP3nj+c/kNzgHBoz+80=
X-Received: by 2002:a05:6000:2012:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3a6d12a8ed3mr11961624f8f.24.1750746471065; 
 Mon, 23 Jun 2025 23:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcb0KNJNOGtH3eP15CKD56LdXNsZ6WkWzTfx2ewX7mU0/Fx58IiGpWRckr3eWQameoj6HExg==
X-Received: by 2002:a05:6000:2012:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3a6d12a8ed3mr11961603f8f.24.1750746470600; 
 Mon, 23 Jun 2025 23:27:50 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8c16sm163637125e9.19.2025.06.23.23.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 23:27:50 -0700 (PDT)
Message-ID: <4e95f3c7-8748-4cf5-ac21-78cf653bfd40@redhat.com>
Date: Tue, 24 Jun 2025 08:27:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/s390x: Use preferred API call for IPLB chain write
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 philmd@linaro.org
Cc: zycai@linux.ibm.com
References: <20250623201216.721130-1-jrossi@linux.ibm.com>
 <20250623201216.721130-2-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250623201216.721130-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 23/06/2025 22.12, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Replace a recently introduced legacy API call with the preferred API call.
> 
> fixes: 0927875 (hw/s390x: Build an IPLB for each boot device)
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 2f082396c7..f2606303e6 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -399,8 +399,16 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>       uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
>       uint64_t len = sizeof(IplParameterBlock) * count;
>       uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
> +    MemTxResult ret;
> +
> +    ret = address_space_write(&address_space_memory, chain_addr,
> +            MEMTXATTRS_UNSPECIFIED, iplb_chain, len);
> +
> +    if (ret != MEMTX_OK) {
> +        error_report("Failed to map IPLB chain.");
> +        exit(1);
> +    }
>   
> -    cpu_physical_memory_write(chain_addr, iplb_chain, len);

By using address_space_memory, you're basically open-coding 
cpu_physical_memory_write() here. That does not make too much sense. If I 
got Philippe right in 
https://lore.kernel.org/qemu-devel/469f3e5a-897a-4456-bd02-185435129ec4@linaro.org/ 
, he rather asked about a device specific address space instead. However, 
that ipl device does not have its own address space as far as I can see, so 
that request does not make much sense here (unless I missed something). Thus 
I'd suggest to drop this patch here.

  Thomas


