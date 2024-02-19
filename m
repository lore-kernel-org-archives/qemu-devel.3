Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F4FC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 12:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2nQ-0007HB-UQ; Mon, 19 Feb 2024 07:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc2nP-0007FG-RO
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:30:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc2nN-0004GE-Ma
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708345852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VSCc2QNoFcJELXqmpDhHL/xq4OpHC+dcJEmWP34szRw=;
 b=SlB86MUmbCkZdYj42myXceqonhw4KyDn9SMjfayIDxzCuozT8e2KTV3yBCUFTjT9KTn0C9
 dZGf8xmqoJ8Vvo4zjEWq6KQmRteQ9vdXeozCOFh1S3CYQ/OiBLv6XfOmNGD8IKejXgWYhe
 rrQ0rM/uLmeU6k8lX6Q2uxqqgYL7U5M=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-t9WFttbrNnCVyYf-5SqSlA-1; Mon, 19 Feb 2024 07:30:50 -0500
X-MC-Unique: t9WFttbrNnCVyYf-5SqSlA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-214d5f2e79dso4958146fac.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 04:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708345850; x=1708950650;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VSCc2QNoFcJELXqmpDhHL/xq4OpHC+dcJEmWP34szRw=;
 b=IrxezoUreOLegRvjGkFAIQ8CDyWWCVZnBa6VBGqR6WQPKnhFeIfEvgRLBMyAP7pkXB
 6RqdKBHwS/svVFizTkG/CPHF1ePJjF2k9QRjiQRKTpnKebWrv4F9RRmaYfiUwiFO+1X5
 Nb1zeomYqVevRXAE2rmpJbsMUg2bXDq1axm2FlpuL++oOBTzVk0Na3LHG6Cr1LBpvNSy
 2iA1c7nxIn4CpYVxOiswu17oJ/jW4KctFiYXlfSq7GevD2TcdKqs46xYETib/n0w37Sl
 pXTXQ09f1Zl7bQmO3KhQqfElWcCSu4Tiyw7F5oWvlEDceb54Lc7FxKG/eAoMuWOHOFDB
 awmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+pk1kE9K0LWXmA02CfugYhZ8MmeQ7hTuvP7i9nGUuMeXEfXTkAiajdJA0fyWFRahLV1zC1b/OXh/Pbrsn1CYEnxZMoZY=
X-Gm-Message-State: AOJu0YyHw8BjLtEVe37YBIlD8sz7LyckmVA/YpcjVNggAjfSreaJ/oYa
 6Ag01pmxgf5yFaogZ2tAYeFU9Dc+xUDW7Nuw/0HFeu3ZZHc471xAVMHsT4BzS4ShyrJERrEKLoP
 REdmF0zafWz1u5yQXeVM/Om7/Nzq2tWYrwxcgWQQxHSRvlkB6gf5n
X-Received: by 2002:a05:6871:410b:b0:21e:ea67:c73 with SMTP id
 la11-20020a056871410b00b0021eea670c73mr1318782oab.52.1708345849864; 
 Mon, 19 Feb 2024 04:30:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzerGULEz1e5kZoWwiF1w8NHJQnaOLmgMjN4NHR3Q6UAXp50U3eRSJRqgXIX4Kr5PAY4Pf5w==
X-Received: by 2002:a05:6871:410b:b0:21e:ea67:c73 with SMTP id
 la11-20020a056871410b00b0021eea670c73mr1318760oab.52.1708345849556; 
 Mon, 19 Feb 2024 04:30:49 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-48.web.vodafone.de.
 [109.43.177.48]) by smtp.gmail.com with ESMTPSA id
 y17-20020a05622a165100b0042debe709dasm2492113qtj.79.2024.02.19.04.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 04:30:49 -0800 (PST)
Message-ID: <359e3bf6-bd94-42e5-b8e7-06b41805fd03@redhat.com>
Date: Mon, 19 Feb 2024 13:30:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Fix boot-serial-test when using
 --without-default-devices
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20240219111030.384158-1-thuth@redhat.com>
 <b56a11d4-ef54-64ae-76ef-25c600255b59@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b56a11d4-ef54-64ae-76ef-25c600255b59@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 19/02/2024 12.37, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Thomas Huth wrote:
>> If "configure" has been run with "--without-default-devices", there is
>> no e1000 device in the binaries, so the boot-serial-test currently fails
>> in that case since it tries to use the e1000 with the sam460ex machine.
>>
>> Since we're testing the serial output here, and not the NIC, let's
>> simply switch to the "pci-bridge" device here instead, which should
>> always be there for PCIe-based machines like the sam460ex.
> 
> It's not actually testing PCIe but PCI bus but I think that does not matter. 
> PCIe on sam460ex does not work yet, I've only implemented it partially to 
> pass the firmware init but devices attached to the PCIe bus probably won't 
> work. I have some patches to improve that but not yet ready.

Ah, ok, I looked at the Kconfig file and saw the "select PCI_EXPRESS" there 
that got selected by PPC440 (which gets selected by SAM460EX), that's why I 
concluded that it must be "PCIe-based" ... I'll drop the "e" here.

>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> tests/qtest/boot-serial-test.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
>> index 6dd06aeaf4..e3b7d65fe5 100644
>> --- a/tests/qtest/boot-serial-test.c
>> +++ b/tests/qtest/boot-serial-test.c
>> @@ -156,7 +156,7 @@ static const testdef_t tests[] = {
>>       "Open Firmware" },
>>     { "ppc64", "powernv8", "", "OPAL" },
>>     { "ppc64", "powernv9", "", "OPAL" },
>> -    { "ppc64", "sam460ex", "-device e1000", "8086  100e" },
>> +    { "ppc64", "sam460ex", "-device pci-bridge,chassis_nr=2", "1b36  
>> 0001" },
> 
> So if you want to check if PCI bus works then maybe there's no need to add a 
> device at all just look for the sm501 display chip ("126f 0501") that's 
> soldered on the board so it's always created even with -nodefaults and 
> should always present on sam460ex. The -device option just adds a device 
> that appears before the sm501 and stops the test there. Not sure if this is 
> testing more than looking for a PCI device created by the board code.

I was considering the sm501, too, but I thought that we might test a little 
bit more if we check that cold-plugging via "-device" works, too, so I'd 
prefer to keep it this way.

  Thomas



