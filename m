Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAB3C0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 17:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdXwe-0004cW-Rv; Thu, 30 Jan 2025 12:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tdXwX-0004Y7-Fz
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tdXwV-0000yb-Tt
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738256582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bfgt8miLEvmEJe4gjJtXIFBmltvv0Vs8icMg+ADIw2c=;
 b=ZYMz9I3LX8b5fAyr/NbWfKME0b9Uy0mkooBHmE6OUZmastubhnlR7utrLbzbjmOoJnaAFX
 8zlgsGqLrbgqs4GyxLpsbMS7Dyyd1weCQZuPfnSkZoYNZUwv8Gf2R60DMmqoHeaGVU8ZQ6
 TgIEKf9rIn0TYfX7ktiBrAc7E0ykFuU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-2GcFETWXPNuE3xTsT64Idg-1; Thu, 30 Jan 2025 12:03:01 -0500
X-MC-Unique: 2GcFETWXPNuE3xTsT64Idg-1
X-Mimecast-MFC-AGG-ID: 2GcFETWXPNuE3xTsT64Idg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so8763535e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 09:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256580; x=1738861380;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Bfgt8miLEvmEJe4gjJtXIFBmltvv0Vs8icMg+ADIw2c=;
 b=fDz8DqqxNx63fZlucOuWm4vIhHe7dk5XSjtUWU0/8Ane8z/4R1rekswu0j+W8eQaqA
 e0VLw3IA4NVJoj7cru1of1OKRJGQIsAZu9F58sM6uglkMbRun9n6pqhSm8DKausWp1gG
 AdQ0gOswwY3k965eDgvm2b1sRi7404RR8yG5TlV03E2J+NOCGHL532MNVPkMhrPWLu9V
 vkA1j336jOde87fYxgity6Y6tnBYa6VcXyzieilk4N9T6oxMvk0DjsUp3PerVVhtWxP8
 XcUqMOB8joa1uMNGIbQ4+RCNu+M/3eJz5CG35wfSC/wR8s+cLwWIGt2cpIBZ+3vfu9VH
 I8sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/8mtfju+YNiPzFT3Ogd4PMvOF6wFpmvYUcmWhumKCDHCPQfpwWDQvIkjI68t47mvtM+YEmI0kTe9K@nongnu.org
X-Gm-Message-State: AOJu0YxLCXJ/tY2fMB3UWk8jB4BjKIGJtbMvij22et+k6BnnqkxyrS6W
 ogCFxRgouDzvW9w+48wVsZIfER2A3kIzrtZSCXKZ1s5OoWL4DsEPpdEAWf4tvrEjuRZl7Ykc8BR
 jAahn5yyp8a3Sg7ksEeskAHUk5AkEqeTeOaxWkLuig4KzUuPXJD8j
X-Gm-Gg: ASbGncsB6KLPgsgQTCxsIn4Tiz9FnmG0mUY5OEOy4gKOT+mBVNw0FEFWC0apj5SSO/8
 YuHDwGbrYQtP3VgFKkjiYdYZA/x2HQjpXkYyXTdwRJFzFZTkELvjwu1gow3k3plFfMx47e4iLFE
 MNWFqdhXXkpEBBcsYpWwgFWaVRCsyBmh6mb6k/uSdJhade4Q+RQjizfOUQiDpy9HS+PlWaYa/iE
 KTr5cK3PjoLJcThkYpeGBIsGuwn5SfykqjKMDx0jT/DCzK5sRy8B0vZWaNiMUf5km7yGn0XZC8d
 TM2GcAHsB8n2d/+ZT+68UJqBCT/ca3Pw7KhpgIH+iWsU3AyceJR5VCh62QblVQAiXorK17GWtRq
 k82ColC856vhP4qwtvXep0GW/rYgUO3Us
X-Received: by 2002:a05:600c:3b0a:b0:434:f753:6012 with SMTP id
 5b1f17b1804b1-438dc3cae6cmr84005325e9.17.1738256578457; 
 Thu, 30 Jan 2025 09:02:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJTMrJ+ZHtudEDY2UKFWTpuA46TyGJOceK2DiZsUkzLx3bBPGALFfhAxo0D71GP+vwZHTzQA==
X-Received: by 2002:a05:600c:3b0a:b0:434:f753:6012 with SMTP id
 5b1f17b1804b1-438dc3cae6cmr84004615e9.17.1738256577933; 
 Thu, 30 Jan 2025 09:02:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c713:3b00:16ce:8f1c:dd50:90fb?
 (p200300cbc7133b0016ce8f1cdd5090fb.dip0.t-ipconnect.de.
 [2003:cb:c713:3b00:16ce:8f1c:dd50:90fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81a39sm63674615e9.35.2025.01.30.09.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 09:02:57 -0800 (PST)
Message-ID: <ca2c2d71-e4c0-4ed2-afc0-04f21df1f82d@redhat.com>
Date: Thu, 30 Jan 2025 18:02:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] accel/kvm: Report the loss of a large memory page
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <20250127213107.3454680-1-william.roche@oracle.com>
 <20250127213107.3454680-4-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250127213107.3454680-4-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 27.01.25 22:31, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> In case of a large page impacted by a memory error, provide an
> information about the impacted large page before the memory
> error injection message.
> 
> This message would also appear on ras enabled ARM platforms, with
> the introduction of an x86 similar error injection message.
> 
> In the case of a large page impacted, we now report:
> Memory Error on large page from <backend>:<address>+<fd_offset> +<page_size>
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
>   accel/kvm/kvm-all.c       | 11 +++++++++++
>   include/exec/cpu-common.h |  9 +++++++++
>   system/physmem.c          | 21 +++++++++++++++++++++
>   target/arm/kvm.c          |  3 +++
>   4 files changed, 44 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f89568bfa3..08e14f8960 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1296,6 +1296,17 @@ static void kvm_unpoison_all(void *param)
>   void kvm_hwpoison_page_add(ram_addr_t ram_addr)
>   {
>       HWPoisonPage *page;
> +    struct RAMBlockInfo rb_info;
> +
> +    if (qemu_ram_block_location_info_from_addr(ram_addr, &rb_info)) {
> +        size_t ps = rb_info.page_size;
> +        if (ps > TARGET_PAGE_SIZE) {
> +            uint64_t offset = ram_addr - rb_info.offset;
> +            error_report("Memory Error on large page from %s:%" PRIx64
> +                         "+%" PRIx64 " +%zx", rb_info.idstr,
> +                         QEMU_ALIGN_DOWN(offset, ps), rb_info.fd_offset, ps);
> +        }
> +    }

Some smaller nits:

1) I'd call it qemu_ram_block_info_from_addr() --  drop the "_location"

2) Printing the fd_offset only makes sense if there is an fd, right? 
You'd have to communicate that information as well.



Apart from that, this series LGTM, thanks!

-- 
Cheers,

David / dhildenb


