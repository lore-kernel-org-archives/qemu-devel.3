Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7B1C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5K3-0002rr-M5; Thu, 06 Mar 2025 02:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq5K2-0002rW-D9
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:07:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq5K0-0000pJ-HJ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741244825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wExwSt28zXgiRRui6EN72KKAkoulKkK207Co0yn9ynk=;
 b=hGUMs949Mctp2OVYUUd8X1UkHaeqxStPD0KR3JEwgQRaF2grktOzxz/y+mkue+4M1gRL27
 jN4GrEkH1BhvCSQvsLxGr0lpjLYLsb0dHfxrqrp07mwSt+H6LvM4hU7vjGDIxJythqNjXn
 imxgDAogVO4qCEWJ1ftcbN7dDsHzX6A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-HBXOHdOqOD6Yz8_JgrCTDQ-1; Thu, 06 Mar 2025 02:07:04 -0500
X-MC-Unique: HBXOHdOqOD6Yz8_JgrCTDQ-1
X-Mimecast-MFC-AGG-ID: HBXOHdOqOD6Yz8_JgrCTDQ_1741244823
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39123912ff0so130074f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 23:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741244823; x=1741849623;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wExwSt28zXgiRRui6EN72KKAkoulKkK207Co0yn9ynk=;
 b=BiBXWgoIDmc+tGUOzS7TIgMGY7E7VmskZowPG0iXp/cld+7jYG8Rpy0vSxOL0V/8vY
 xnkhkDhjmxJNZjO+LZWz9NCS6/BLLzqB/C7Rv8BL1zni3saRejXJlN0bRPFKTxu75nui
 BRpdGvo6/KDKclZFEJerXuBbpTz0lc1U2t4bEkIgK7ALRIt2qwRbyvTr49QBL1U3Qusm
 VYEee7gotVOIpHMlfyAwIdoWjMjYJ19OERoZ5HX10JSAWqlpDnExr0KnkdAI3s2IzMPA
 VEA/bRsgcPfvogX6azTyElI34muHKGT5NXHR8UjgwS6YWuCMCk9Y6JLyQua/Ii/MMDBH
 Tofw==
X-Forwarded-Encrypted: i=1;
 AJvYcCValbuLpR+PJfdo0rIvBRGJfIeuBLf4109WusAXN/Sh7qLvBnf+ecblFzdueOylqrhl5CwrzZKyk8bJ@nongnu.org
X-Gm-Message-State: AOJu0Yx5rd959RBcapPyw5GdmN0ZV/53vaG9XdoHERgS48llROKRLgjy
 0Py9nrnDTSrZBXLt9t372eJKeOC+SeRvkpNhdXfgtJS/4Vjadsp1FT/r+/t0V4doprMThZewdTM
 eqwFh3xA+J9uxKfaldMsmz94hCuxYGv86ITrmjl3w5CrYTNrFg6il
X-Gm-Gg: ASbGncvLolZpi3MrSJjHB9QoTaWRTBxVH7u3pTqJ1xGqpqtR7fPhXiiaR36unDYeVy2
 fGRy1N8BNEIVkTE6//S4bt6JE3HGozxMR7T1eTPiyuO2ukCQzKgQsY6pGzbLi1q/CqNVQubJOOO
 lsb63tNAKVDwLViCnfALImqgBnuFIrMd0tLdC6z4rSIRMBqeygbxQkGJfvjXRk5h5E0GWaYNBO/
 AvdB0fhvhwSOzr0WnhmdKDOP8iQ5bHvf5ZRbx1lTyt6D8X1qKaXFmsDgJFmqKRYWe+Xp1mRw0mD
 Np9pFISjdISoBtbDucZH+Lq6dscaTThy10zLrSzx7NnmM/M=
X-Received: by 2002:a05:6000:2a6:b0:38f:2ef1:dd2b with SMTP id
 ffacd0b85a97d-3911f740b80mr3894369f8f.22.1741244823081; 
 Wed, 05 Mar 2025 23:07:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+cqeq7iQZZzsrytVxUi29sGII74Q9uklg4ePJ/AJAzBnEeCxcgtD4KvLIoA8+mARaYc2P4w==
X-Received: by 2002:a05:6000:2a6:b0:38f:2ef1:dd2b with SMTP id
 ffacd0b85a97d-3911f740b80mr3894352f8f.22.1741244822699; 
 Wed, 05 Mar 2025 23:07:02 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2e89sm1019060f8f.71.2025.03.05.23.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 23:07:02 -0800 (PST)
Message-ID: <85f61970-665f-4519-aaa6-ae267948a982@redhat.com>
Date: Thu, 6 Mar 2025 08:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add missing 'Asset' type in function test doc
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20250306060706.1982992-1-adityag@linux.ibm.com>
 <4a96e43a-a4f3-4b24-8ffe-63b5da01f82b@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4a96e43a-a4f3-4b24-8ffe-63b5da01f82b@linaro.org>
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

On 06/03/2025 07.44, Philippe Mathieu-Daudé wrote:
> On 6/3/25 07:07, Aditya Gupta wrote:
>> Seems 'Asset' got missed in the documentation by mistake.
>>
>> Also fix the one spellcheck issue pointed by spellcheck
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   docs/devel/testing/functional.rst | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/ 
>> functional.rst
>> index ecc738922b7c..50fca2a0291e 100644
>> --- a/docs/devel/testing/functional.rst
>> +++ b/docs/devel/testing/functional.rst
>> @@ -251,7 +251,7 @@ Many functional tests download assets (e.g. Linux 
>> kernels, initrds,
>>   firmware images, etc.) from the internet to be able to run tests with
>>   them. This imposes additional challenges to the test framework.
>> -First there is the the problem that some people might not have an
>> +First there is the problem that some people might not have an
>>   unconstrained internet connection, so such tests should not be run by
>>   default when running ``make check``. To accomplish this situation,
>>   the tests that download files should only be added to the "thorough"
>> @@ -274,7 +274,9 @@ the tests are run. This pre-caching is done with the 
>> qemu_test.Asset
>>   class. To use it in your test, declare an asset in your test class with
>>   its URL and SHA256 checksum like this::
>> -    ASSET_somename = (
>> +    from qemu_test import Asset
>> +
>> +    ASSET_somename = Asset(
>>           ('https://www.qemu.org/assets/images/qemu_head_200.png'),
>>           '34b74cad46ea28a2966c1d04e102510daf1fd73e6582b6b74523940d5da029dd')
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks, queued!

  Thomas


