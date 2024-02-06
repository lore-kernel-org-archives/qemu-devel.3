Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B17DC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHci-0003DO-Cc; Tue, 06 Feb 2024 04:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXHce-0003D2-FH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:20:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXHcc-00040x-IM
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707211205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xdDR0GBbsh2GEWjU5UFnaSaTsJ328zKl0I89wiKHJ58=;
 b=JY6HJTN3W6B4bvHB6Wjrmrs5zhH5fJfJoRZutuh/PWaU3PwNtzvx/khpJpHae4f89CHbvy
 k2O/12Fk1W6PJryFHNvgYc3ZupHz/I1sxnf6WNd8kICGAiqqAAQjhSddZNCqK18vJM985s
 FOWqrxpJAURCyRbzIDtdFJXwYXZ7ryM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Wo1boa4hOFSOBiNbAjpESg-1; Tue, 06 Feb 2024 04:20:03 -0500
X-MC-Unique: Wo1boa4hOFSOBiNbAjpESg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3120029877so43177066b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211202; x=1707816002;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xdDR0GBbsh2GEWjU5UFnaSaTsJ328zKl0I89wiKHJ58=;
 b=uV76eAbaxzAEd9HYe7sjfC7j+aFMKsNRHEpBebkUkWlsC03bP0j985zN7ALBHhciEI
 HK5dt0BxCbaClTJvqrYqsQh6in+0RyH+r7l0Ee7khWcjb4MtZ6OEHISn5j26eL82m487
 3VPoncFoou6iVPzXL0gjXVATwfUVqaVIftgaHR8UmjyG51YOBF3S5k1ccvyNy98tG4f9
 /kMJvmTmccm2htdKHPMHj6GC0pskgqoWef1pj09RSR6pF1NLH4+PJZu1cGIS+JhbcYyV
 xsli+u53BFvZCtrznEqYuF1a1PpqOL9vo8zjW58ifIFTv31Vwp9paVZyeGv2r+x3ZFBT
 S63g==
X-Gm-Message-State: AOJu0YzvtNsc4uQrYw2LzsEzrBqEFhkSnfjUu7HdSvEex5tNmkaBovCS
 +Xqh5KXfdfbclga5dKj545XLkTjt42O16a0gCcaTIfxUrYRioogjLljEbqF1LYZGd7orICphD4M
 Z3qlurXvQpS+nUtpLrvcoacSR0ZOYWKIoZ4BxXGDKNajSPyeB7Ozg
X-Received: by 2002:a17:906:4750:b0:a36:802b:2639 with SMTP id
 j16-20020a170906475000b00a36802b2639mr2397913ejs.11.1707211202540; 
 Tue, 06 Feb 2024 01:20:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf4ZZPyTmE1uQIlfOXUucyrK9BnrTtLmJYGE+FBZHbkrZfL3KEeh+obG9S8yKfHq/qFT5S/g==
X-Received: by 2002:a17:906:4750:b0:a36:802b:2639 with SMTP id
 j16-20020a170906475000b00a36802b2639mr2397903ejs.11.1707211202222; 
 Tue, 06 Feb 2024 01:20:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWo5zF+drwz93WyT6cQpcXKw9lPkl9pffFTDGtNGoLmHMf3FyPt75Y+yYGI+OotFRJEtKmlUaTkyGNO9NzOz1Er79/pFiLDhmqDO+badJpDbZ3cy2Le/5M78/YPQ6+UqB2rxZGFXMprSadqx/oEaSbXiH/SVcFNOBZLnUnQROAO6hSHSA==
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de.
 [109.43.177.145]) by smtp.gmail.com with ESMTPSA id
 cw1-20020a170907160100b00a317ca8b422sm923353ejd.92.2024.02.06.01.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 01:20:01 -0800 (PST)
Message-ID: <387d27bf-2bdb-432a-baf1-19fb0d026045@redhat.com>
Date: Tue, 6 Feb 2024 10:20:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/cdrom-test: Add cdrom test for LoongArch virt
 machine
Content-Language: en-US
To: maobibo <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20240205021318.3759925-1-maobibo@loongson.cn>
 <678324f1-2b8d-45a1-aea8-03c187f069d1@linaro.org>
 <e0052a77-d6b1-fee9-a179-d7074132304f@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e0052a77-d6b1-fee9-a179-d7074132304f@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
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

On 06/02/2024 03.29, maobibo wrote:
> Hi Philippe,
> 
> On 2024/2/5 下午8:58, Philippe Mathieu-Daudé wrote:
>> Hi Bibo,
>>
>> On 5/2/24 03:13, Bibo Mao wrote:
>>> The cdrom test skips to execute on LoongArch system with command
>>> "make check", this patch enables cdrom test for LoongArch virt
>>> machine platform.
>>>
>>> With this patch, cdrom test passes to run on LoongArch virt
>>> machine type.
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   tests/qtest/cdrom-test.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
>>> index 0945383789..c8b97d8d9a 100644
>>> --- a/tests/qtest/cdrom-test.c
>>> +++ b/tests/qtest/cdrom-test.c
>>> @@ -271,6 +271,9 @@ int main(int argc, char **argv)
>>>               const char *virtmachine[] = { "virt", NULL };
>>>               add_cdrom_param_tests(virtmachine);
>>>           }
>>> +    } else if (g_str_equal(arch, "loongarch64")) {
>>> +        const char *virtmachine[] = { "virt", NULL };
>>> +        add_cdrom_param_tests(virtmachine);
>>
>> What is the default device used, virtio-blk-pci?
>>
> yes, it is. For virt machine type, the default type for block device is
> virtio interface, and it is defined at function loongarch_class_init().
>     mc->block_default_type = IF_VIRTIO

Ok, then you might need to check whether your patch still works when you run 
"configure" with "--without-default-devices". You might need to check with 
'if (qtest_has_device("virtio-blk-pci"))' whether the device is really 
available in the binary, like it is done some lines earlier in the arm case.

  Thomas


