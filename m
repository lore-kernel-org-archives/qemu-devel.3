Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69630C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdQV-0006IR-3p; Tue, 29 Jul 2025 02:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugdQ7-0006Bi-7j
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugdQ4-0004ch-Dl
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753768951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WfXtAYdxA4LRSArY5LnfvzTAAzBXpwk9Sr9JAAQd+y8=;
 b=MErhiE8cXyhPr985pNuHKAlyLiOq4xlnI0XpJ5bsA7RqWBICnF5JuDuy+HvGnO6tmx7YRZ
 ZWURtFYSR0///bvV1V7OK9ke2wBlkzY8/etwxXbf/U/2mbbzBAOrUxXRpCO8sYF2d/LgEi
 Z+4a6r0SSC8sZEDD4c2z9Ik8RDl7Zrk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-haxuk0fmMQylbenNGENjnQ-1; Tue, 29 Jul 2025 02:02:29 -0400
X-MC-Unique: haxuk0fmMQylbenNGENjnQ-1
X-Mimecast-MFC-AGG-ID: haxuk0fmMQylbenNGENjnQ_1753768948
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45639e6a320so20995825e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 23:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753768948; x=1754373748;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WfXtAYdxA4LRSArY5LnfvzTAAzBXpwk9Sr9JAAQd+y8=;
 b=iiCBK+2E3AddCEvmH7IS9a8Ss/5gQVWs0ZR3/sH+tkThkwCwRQucTjWJ9hYxetagfH
 41H0qaEheS5VpWd8fZ7qwv14qaT1umeUMrndMPDn9fg+R3S51LmioI5Gyz2tANzMKnW/
 +jP/cqr8uhh8rE8XGpVxkcKxo7RWMGvskJ2wLuMaMa6VFI5NEhUq4byTYuRF73gLBca/
 oP0HE3hRVB9svVPVgTOH5gZbWcjStFqTMbaUJVMEwhiU+cqcGMm0KUCTV1RBlubNh8mH
 zlPc7WyjzfB/PPZfvp4ywZas8B9Yz+W81PfAAT6y0wX8WPbHc5HAlQAn1OqO1uOVZPeK
 FeKw==
X-Gm-Message-State: AOJu0YySGxpeO9TYdQH6X0lLAsjjyesRs3uWOwrMclsC9ffIHY8oP+Ah
 SUcQ1Q2203KJFZydT4Lu7Sj4sYxTaJC2poD1kXiY6S9b18930DhkDsBukywl5SoSVffJGOhIFuN
 FqoTFxYB10RVY5jbwvUx8lHy0tRWP1ZFGIDrwTQJBU27mqswxGEBubRZl
X-Gm-Gg: ASbGncv6u+58Jdu7Z/AmHdpu415j1DN7GZFfIzLsfJFGvmkuIlVohSotXgXY34PDR/2
 eNBeLN/NHK2sTpbUZrd2cs2t+l2zrhAO5CkTQELl+bH8K/X9ofhiMsstiIL7V7oTKEiixCkn1Hy
 dxTrnB1L35zRuGo9D/XyoDzM6R9ot0seR7BUfOClboVvG4yopumtcHrS/6foWbZ/omOMdz2cB4T
 pcnzKfga62pGPl16aBS2WMBcOnEwOeXgdy9OC2wYy10uCUrRmsfr9B7JoJX+MUi2vLiWQ42b4FP
 CFa/pkNh86ofF/4SN83m7aKU+4Hodayzz0BmVQciJGIHZUto8T5XIv8nADrYpPldjQsxk3/W8pA
 EZeg=
X-Received: by 2002:a05:600c:6812:b0:456:207e:fd83 with SMTP id
 5b1f17b1804b1-458762fcfe9mr120839025e9.4.1753768948206; 
 Mon, 28 Jul 2025 23:02:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7YwyguB1i7w2K9gCERmKq+WuCGtXQIE/LbfMT8lxKBbMxcoE3hpxaf5R50HBJ7MMliJByYQ==
X-Received: by 2002:a05:600c:6812:b0:456:207e:fd83 with SMTP id
 5b1f17b1804b1-458762fcfe9mr120838665e9.4.1753768947694; 
 Mon, 28 Jul 2025 23:02:27 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-093.pools.arcor-ip.net.
 [47.64.115.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7819039efsm9160899f8f.11.2025.07.28.23.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 23:02:27 -0700 (PDT)
Message-ID: <1501b69c-6920-4319-bd8a-550243cb3daa@redhat.com>
Date: Tue, 29 Jul 2025 08:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: Fix ubsan warning
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-trivial@nongnu.org
References: <20250728173016.314460-1-thuth@redhat.com>
 <aIe5E5NaMCGhoiLZ@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aIe5E5NaMCGhoiLZ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 28/07/2025 19.53, Daniel P. Berrangé wrote:
> On Mon, Jul 28, 2025 at 07:30:16PM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> When compiling QEMU with --enable-ubsan there is a undefined behavior
>> warning when running "make check":
>>
>>   .../qga/commands-linux.c:452:15: runtime error: applying non-zero offset 5 to null pointer
>>   #0 0x55ea7b89450c in build_guest_fsinfo_for_pci_dev ..../qga/commands-linux.c:452:15
>>
>> Add a check to avoid incrementing the NULL pointer here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   qga/commands-linux.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>> index 9e8a934b9a6..caf7c3ca22b 100644
>> --- a/qga/commands-linux.c
>> +++ b/qga/commands-linux.c
>> @@ -449,7 +449,9 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
>>           has_ata = true;
>>       } else {
>>           p = strstr(syspath, "/host");
>> -        q = p + 5;
>> +        if (p) {
>> +            q = p + 5;
>> +        }
>>       }
>>       if (p && sscanf(q, "%u", &host) == 1) {
> 
> q is always non-NULL if p is non-NULL, so this is safe, but I would be more
> happy with this changing to 'q && sscanf' to eliminate the indirection.

If we agree to do a bigger change here, I'd rather drop the "q" pointer 
completely and use a new integer variable instead, something like:

     int offset;
     ...
     p = strstr(syspath, "/ata");
     if (p) {
         offset = 4;
         has_ata = true;
     } else {
         offset = 5;
         p = strstr(syspath, "/host");
     }
     if (p && sscanf(p + offset, "%u", &host) == 1) {
         ...
     }

WDYT?

   Thomas


