Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B08606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=faIAIbuG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a6sUjh2k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRlhl-0000x4-PO; Fri, 13 Nov 2026 02:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xRlhk-0000wm-GN
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xRlhi-0002tu-IV
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794554889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hWC7ZcItK7oCRdeG/C6Dqs96qpyRu69W0ivat+AHdGY=;
 b=faIAIbuGDlyuBOpWLqs4XnNb8+h4txp62/KGqmQvBFe75153GK1MZRI2GFTDPYm4MtQKl/
 giu322C7mGZZezEsioF4x//i1+dd3NkAgH3n6b5nf7rteEUjCQTAitXY9H2z1sEYXHn4av
 HqaLQpB+PTNXXzezuGWZMyopAtKSkrE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-ASeG8WJSMbSjxpfGlackrQ-1; Fri, 13 Nov 2026 02:28:07 -0500
X-MC-Unique: ASeG8WJSMbSjxpfGlackrQ-1
X-Mimecast-MFC-AGG-ID: ASeG8WJSMbSjxpfGlackrQ_1794554886
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4afef353dd2so4790165e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 23:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794554886; x=1795159686; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hWC7ZcItK7oCRdeG/C6Dqs96qpyRu69W0ivat+AHdGY=;
 b=a6sUjh2kN6plHh3oy5OR6GVGWpRy2L7J8x/47Cv95+la0/+2z/HynltJmgfHwBStDL
 Ikz7tNgM6Q04Bn8GHR/twKw+SBt9i0mZahLC9vRdcRxJfNip03LCtDEUvPbm4Gqje2fQ
 YQ9X10uy7WXmdjdEwZKsrB5Hlmrs1gV9h0gxMNAf1B3EapjPGhvQpOPnprOdLnxRQj5f
 aCJYMNeGGyldNQ1i8wtfCty/EhpKd73bP9GS+J9WEjaUBSKfhHFjRn68w1JznloFDpAy
 fiVKmGU6c1SkO9uPA3du5vz0nzg49tyOom35WorV8ABowhGudaL5hgJ+QVtb6IFZseYm
 yiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794554886; x=1795159686;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hWC7ZcItK7oCRdeG/C6Dqs96qpyRu69W0ivat+AHdGY=;
 b=l1AgcSAEXIFSMDMg0dUhsPdxRGflVXp7mtdKFSVDcAILj3l96Rv4gE1qauZZuyVkhX
 nTbx/ur/a0uDPCNq7OvxmWj59QS0hqPpoLgiABMSeIBnVXVPY+Jyv+wbdxqwYs8to3ZG
 IS8ax7TbOPDSaksMdTM0KHhaUoIg0nBB+np5xbnr4OXH3LO1H9OfPXsOJVd89wcVUrZ9
 q2+lzEfZYZqXWUN/2B7ypjbucAuz0tMEdDj6j/bldTM3S/Bz/3hvg1pNKhqnFhjp9ZZm
 jh70sKtqL8tf6ecQ1wqy0oKxe/HVFYR7v+qZ0j3cIz4DbBqWQSgVswwIKF4DJu2ScA1K
 eGLg==
X-Gm-Message-State: APuU4Z9YzPrpQHaY9JwkchR/9NLXu7gmFcPRkdbIs2MdeCJ9MNwlyRwH
 2UBZUYciDM/n0xswL9uFpj0DU98/x+uT52FYR9GMiPjLCP7wfBinBvtpmBDu4a7pXb0LEGD83Md
 iEDqMDzjgJZozlIgHPYLR8RxKp5HMjKekXGJTuvjF6l571vCy6yLLSkRq
X-Gm-Gg: AYBFou1Lowuhyh+x/YUvM3abRSfKuzKB68eoVGxiELc+Je+lZSAOCXqLIGTmnGe435l
 YUjrRMONIH7IgWGGO0utfZqRnOnQksCrd8z/UIZWuBIO3pH0pAiflZos+7l/+alQkEULeBCFKar
 +oBy07DAiA3Vf3pZynvnyrzG072Ja/8yel4gLjsyHsRv15MEkN3FY9hQdB5vkBHmIlpBS6NhWRi
 GqEkGcYYuai/Turcj62CVeExeNzxMP5gNk/xVsS+WJ40E+GryoioXtsy5VaxhmLf3o+JH7S3jyk
 1rKLRdSUBry0OPntDNJ4Pk84D0WsFECOSfdNpVSn8Yl9Z7nKyRaUlPGCKFZ6jNwjWlgCxQfQP7u
 YP43B0AuYZGdYvSAzFeBQuQhMAJvScTu6Cc8bkC0aeXKl
X-Received: by 2002:a05:600c:1d0e:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4bb55a7f5f3mr30858115e9.32.1794554886129; 
 Thu, 12 Nov 2026 23:28:06 -0800 (PST)
X-Received: by 2002:a05:600c:1d0e:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4bb55a7f5f3mr30857755e9.32.1794554885722; 
 Thu, 12 Nov 2026 23:28:05 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e252f7fsm139344495e9.2.2026.11.12.23.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 23:28:05 -0800 (PST)
Message-ID: <0a8f5087-4979-4ea2-83fd-33e48d060801@redhat.com>
Date: Fri, 13 Nov 2026 08:28:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/vhdx: Add alignment checks for region tables
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>
References: <20261112092201.74651-1-thuth@redhat.com>
 <avW12msUi9dongBJ@redhat.com>
 <f9993d4e-eb21-413f-b2da-9b9f3052bfab@redhat.com>
 <avXnABKy0_QCP3fY@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <avXnABKy0_QCP3fY@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 12.11.26 um 17:19 schrieb Kevin Wolf:
> Am 12.11.2026 um 15:48 hat Thomas Huth geschrieben:
>> Am 12.11.26 um 13:49 schrieb Kevin Wolf:
>>> Am 12.11.2026 um 10:22 hat Thomas Huth geschrieben:
>>>> According to the VHDX specification:
>>>>
>>>>    "The FileOffset and Length fields specify the 64-bit byte offset and 32-bit
>>>>     byte length of the object within the file. The values must be a multiple of
>>>>     1 MB, and FileOffset must be at least 1 MB."
>>>
>>> This requires that the offset (not length) is at least 1 MB...
>>>
>>>> Thus let's add a sanity check to avoid that bad things could happen later.
...
>>>> diff --git a/block/vhdx.c b/block/vhdx.c
>>>> index 8013a90a1a4..21270988b5a 100644
>>>> --- a/block/vhdx.c
>>>> +++ b/block/vhdx.c
>>>> @@ -566,6 +566,16 @@ vhdx_open_region_tables(BlockDriverState *bs, BDRVVHDXState *s)
>>>>            vhdx_region_entry_le_import(&rt_entry);
>>>> +        /*
>>>> +         * According to the VHDX spec, offset and length must be multiple
>>>> +         * of 1 MiB and length must be at least 1 MiB.
>>>> +         */
>>>> +        if (!QEMU_IS_ALIGNED(rt_entry.file_offset, MiB) ||
>>>> +            !QEMU_IS_ALIGNED(rt_entry.length, MiB) || !rt_entry.length) {
...
>>>> +            ret = -EINVAL;
>>>> +            goto fail;
>>>> +        }
>>>> +
>>>>            /* check for region overlap between these entries, and any
>>>>             * other memory regions in the file */
>>>>            ret = vhdx_region_check(s, rt_entry.file_offset, rt_entry.length);
>>>
>>> I'm also wondering if the check shouldn't be in vhdx_region_check()
>>> instead, which we're already calling here.
>>
>> I considered that, too, but finally decided against it since
>> vhdx_region_check() seemed rather about overlapping regions... but if you
>> prefer, I can also move it there.
> 
> There's a comment at vhdx_region_check() that could use an update then,
> but the name vhdx_region_check() feels generic enough to me.
> 
> But this is not a requirement from my side, just a thought I had. If we
> both had it, maybe that means something, but you decide.
I had another closer look, and vhdx_region_check() is also used to check 
some BAT entries for overlap - and those have different requirements as far 
as I understood the spec. So I decided against moving the check into that 
function in v3:

  https://lore.kernel.org/qemu-devel/20261113072336.46309-1-thuth@redhat.com/

  Thomas


