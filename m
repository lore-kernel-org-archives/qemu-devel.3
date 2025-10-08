Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1515CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 12:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6T9y-0008Dp-23; Wed, 08 Oct 2025 08:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6T9v-0008DQ-Dg
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6T9k-0005F4-5y
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759926023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u9MZlKK3amMBVGYoPuQqZRR6yCLDHaXkMyO0F1RodFM=;
 b=CNKRJl5pFKKWEybsrzOrXCG+W3oDqsy+oJMrpPPXPZhHIaGVjg6K8z2BNbs1aHNasZ1bBR
 X4e1RO/TF5texzbhpwRbZbdWcTTVNwF7shDsEAj7qvrcYpsER0rFBN2Zmj7+SfdMk0SSGj
 rfG1ZduaxmY/KUV0OvxcCU2iTsb4Zko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-edHye8mwOzyknkTprYQ7sA-1; Wed, 08 Oct 2025 08:20:22 -0400
X-MC-Unique: edHye8mwOzyknkTprYQ7sA-1
X-Mimecast-MFC-AGG-ID: edHye8mwOzyknkTprYQ7sA_1759926021
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ece14b9231so4175027f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 05:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759926021; x=1760530821;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9MZlKK3amMBVGYoPuQqZRR6yCLDHaXkMyO0F1RodFM=;
 b=Kt3FO8Kz5mL0nUgNiSWLdgI78WOVFEF5mts2/ypOYw4VtROmUCzd7XpHuevulB9UY5
 rye3qsCYLrAJX2J8aaGSZr7o+OfxtC6TZkeACmU/ovg3ij7IIhfclprWtwv1BnFw7sb7
 Iw9udsK/QXYqaLj5f3lnOJAJqAMuByd7x+BkfsoVkV4P9r/FOqSFQy/SLxTZD8O6ws4Q
 YjoLr7WrwLd3nx3+72lJCQRnOqC4PY8eXEx6Sn4y7YxGQpDOwJ8uciMZFBiCbToAb45b
 ia98psFMzQB7gESnLIBW6XCFyjhp01EBLJZ3k442fQzd6huYl77hdO445KECr/bYoXI5
 E5DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVio7uSojr6jNanVkWYm3+KF97TSUwwngL561O3q4GZSea2nzo8ySsLGomtA4Lth+ntu3KyKERQIwkM@nongnu.org
X-Gm-Message-State: AOJu0Yx+hRZUq+jFy5yeZyc5FjVIN8R5Sglsr3GJswuDbHAtyDcWmbFf
 J4lj0SiVuXokb7A3bNUNLZENZcwffeFaPKEgvYVq9Dm00pHgUI80JpVNGORGYyuvvEJoLM9M07k
 4L2wlMFZjTolXX7caqvEhm2O1il8brKG9JWJVvMzMsMJYZNm2d1+Gfsfs
X-Gm-Gg: ASbGncs4ZkyEsqKk0J56lRZZ5dDer14P2EUz/ytPePATj4CmV9KuJXvnPWP5X0W6YDI
 cdrrWtUtNmrGmFIN4mlPF/pSihjs2fN5c5zEfI8fXtzgl7P9OoRPUxg2GP9YL9sEav2n2STL5sW
 sVUGueckin8H0Jk/7qQonePuuOxio2bAocHoDdaldrG/ffHu8rhr+86MW1L/EPMEs3+KB2zFCLS
 wW7TlN3mdrR2HqFPDy5clcsoorYdQ3JzKhv/pafOAHU35DWxBuh7aJDgae1FH2wGpVYp9uWxkik
 2OMT0HsScYZEFj18oHGtEegwQUWu7GclcR5vfIfsPpZQyQ5EN4JBeFgA5opyILXYCjX82eNfutF
 eUWpOZyMfHw==
X-Received: by 2002:a05:6000:2485:b0:425:8133:ec6c with SMTP id
 ffacd0b85a97d-42666ac634cmr1734431f8f.9.1759926020987; 
 Wed, 08 Oct 2025 05:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc1pMmb/UZLe6E38WNM19mPH+uBzNVHy7vWzHludhuerAZZwx99dpip3/+h0Qm773ktgb20w==
X-Received: by 2002:a05:6000:2485:b0:425:8133:ec6c with SMTP id
 ffacd0b85a97d-42666ac634cmr1734377f8f.9.1759926019569; 
 Wed, 08 Oct 2025 05:20:19 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm29557551f8f.34.2025.10.08.05.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 05:20:19 -0700 (PDT)
Message-ID: <6c7fc08c-df3f-48a7-ac95-0b35ed982aef@redhat.com>
Date: Wed, 8 Oct 2025 14:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/s390x/sclp: Do not ignore
 address_space_read/write() errors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20251007015802.24748-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251007015802.24748-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07/10/2025 03.58, Philippe Mathieu-Daudé wrote:
> If address_space_read() fails, return PGM_ADDRESSING. In the
> unlikely case address_space_write() fails (we already checked
> the address is readable), return PGM_PROTECTION.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20251007014958.19086-1-philmd@linaro.org>
> ---
>   hw/s390x/sclp.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index d7cb99482b2..8604cd305e5 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -305,6 +305,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>       SCCBHeader header;
>       g_autofree SCCB *work_sccb = NULL;
>       AddressSpace *as = CPU(cpu)->as;
> +    MemTxResult ret;
>   
>       /* first some basic checks on program checks */
>       if (env->psw.mask & PSW_MASK_PSTATE) {
> @@ -319,8 +320,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>       }
>   
>       /* the header contains the actual length of the sccb */
> -    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
> -                       &header, sizeof(SCCBHeader));
> +    ret = address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
> +                             &header, sizeof(SCCBHeader));
> +    if (ret != MEMTX_OK) {
> +        return -PGM_ADDRESSING;
> +    }
>   
>       /* Valid sccb sizes */
>       if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
> @@ -333,8 +337,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>        * the host has checked the values
>        */
>       work_sccb = g_malloc0(be16_to_cpu(header.length));
> -    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
> -                       work_sccb, be16_to_cpu(header.length));
> +    ret = address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
> +                             work_sccb, be16_to_cpu(header.length));
> +    if (ret != MEMTX_OK) {
> +        return -PGM_ADDRESSING;
> +    }
>   
>       if (!sclp_command_code_valid(code)) {
>           work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
> @@ -348,8 +355,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>   
>       sclp_c->execute(sclp, work_sccb, code);
>   out_write:
> -    address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
> -                        work_sccb, be16_to_cpu(header.length));
> +    ret = address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
> +                              work_sccb, be16_to_cpu(header.length));
> +    if (ret != MEMTX_OK) {
> +        return -PGM_PROTECTION;
> +    }
>   
>       sclp_c->service_interrupt(sclp, sccb);
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>



