Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26623C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 16:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0ODf-00011I-H0; Fri, 26 Apr 2024 12:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0ODV-00010b-V0
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 12:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0ODR-0003wZ-Qe
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 12:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714148064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7oMfUBQLh1cBzkgz/wm2Ont80JLtAaMYJtjIZ78W/ms=;
 b=eRBmXqSLnlR4B+z5mrmReuIQ8Z2J46UQeQkCdkxcn2ugQ5pOnSbmyNcX3z1zcj53omwdCQ
 zRdrIUifZ1aMo+ktXvdN5GWscLx/cI8eLfjYJ/WAsBi+c7E8NotBU0qPkAZQUIffqY+kLe
 NQ/rHUzh/JE3BytPUR4HJpjKiWUM090=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-dssTbpBSPzOLl8kUxG7S0w-1; Fri, 26 Apr 2024 12:14:22 -0400
X-MC-Unique: dssTbpBSPzOLl8kUxG7S0w-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5725f45da8eso204792a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 09:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714148061; x=1714752861;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oMfUBQLh1cBzkgz/wm2Ont80JLtAaMYJtjIZ78W/ms=;
 b=Q5F0N/R9SAJli5pXuCyfwuDNKiidHPfPg3VLhbiGf+sHgIIkmmHDvVcIFwOeiYEWf/
 6bF6yYZGY1IIYxMcW5/BT3J+rU7nmTKZycJr+FusCZlbd0zCK38rfOMh+ZKH6iV59H2K
 ucsEnYjHonzuzhTEu85yCZCXSGoGDJCUvFovT7G4sVWpIkHq7//UX6T88H4dt8dXd/SP
 XijlN0r4ukjGyPXiEQ9TRuNtL7I0wziK8ZcgfRrRCZwl0eAbwAYETSPdw6+pwE7pdeNG
 F7dT0D9fjtFDwrFr9LxLB6iMBrmxvGiVLdPhCzbeCRQux3PVgH4tn5dKTDnBvqTEZTVD
 iXpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD9Fa7SH1NZpArSabJ4ggVy4agSV8DVazI7pqdMpPwCRvHZBmrN+oj/KF2VjdahCfK1bGJFJAJZjXCk3bZNvrKiUsrDqw=
X-Gm-Message-State: AOJu0Yy3x3wkzWxMDmvrI8ttevAHrTxl2V5KO+UI91yKohLMpwv+N/eD
 mDkm36oE80bI6h2IZQHBFdEADwDxcLyMDua7LeUHisxvHFy/C+j5KF2UzmIsp2bhPp53aUE8pqU
 dSUhKEhg6LzXYPPfYwTt1kd37/b+6zPv3h3V4MXj6w5qR5hp8iVQA
X-Received: by 2002:a50:9b49:0:b0:572:4681:8c1d with SMTP id
 a9-20020a509b49000000b0057246818c1dmr2143725edj.9.1714148061161; 
 Fri, 26 Apr 2024 09:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6WEXag118m71sZafaapxDNficWCSTuBUs5if+iE+9Vg+JgDYdQ6M6OWeYGGReUDtp+nvxeQ==
X-Received: by 2002:a50:9b49:0:b0:572:4681:8c1d with SMTP id
 a9-20020a509b49000000b0057246818c1dmr2143712edj.9.1714148060858; 
 Fri, 26 Apr 2024 09:14:20 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-20.web.vodafone.de.
 [109.43.179.20]) by smtp.gmail.com with ESMTPSA id
 i8-20020aa7c9c8000000b00571c1df911fsm9647428edt.37.2024.04.26.09.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 09:14:20 -0700 (PDT)
Message-ID: <5d8ff86e-2b55-432e-885a-7bae91f483dc@redhat.com>
Date: Fri, 26 Apr 2024 18:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/cirrus: Remove the netbsd and openbsd jobs
To: Eldon Stegall <egqac@eldondev.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240426113742.654748-1-thuth@redhat.com>
 <CAFEAcA_gEyBXecGXP3x=uLJQTaE9=5Ubf0bGeSALskTfFoNQ6g@mail.gmail.com>
 <5b79efda-2774-4e76-8bb2-a1d70e8bce2f@redhat.com>
 <ZiuwOYf07wcLRa5O@localhost>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZiuwOYf07wcLRa5O@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/04/2024 15.46, Eldon Stegall wrote:
> On Fri, Apr 26, 2024 at 02:47:20PM +0200, Thomas Huth wrote:
>> With regards to NetBSD and OpenBSD, this is not a step backward since these
>> gitlab jobs were never run anyway (they could only be triggered manually,
>> but hardly anybody did that AFAIK).
>>
>> If we want to have proper support for those OSes, I think somebody would
>> need to set up a custom runner on a beefy KVM-capable server somewhere where
>> we could run the "make vm-build-*bsd" commands. By the way, are Eldon's CI
>> runners still around? IIRC they were capable of running KVM ?
> 
> My datacenter had a power outage recently, so I disable my runner, and
> haven't prioritized bringing it back up until now. I am glad to get this
> going again, I'll look at it this weekend.

It's not for me to decide, but IMHO it would be a great possibility to run 
some additional KVM-based tests (like the vm-build-*bsd tests) in QEMU's CI!

> There should also be plenty of space to build *bsd VM's. Do pre-existing
> upstream BSD images have an nocloud support so that we can build from a
> stable updated base? Sorry I'm not super familiar with the BSD
> ecosystems, but happy to try to fill in the gaps.

QEMU's test suite comes with a handy way of doing tests on OpenBSD, NetBSD 
and FreeBSD: If you've got a KVM-capable Linux host, you just have to type 
"make vm-build-freebsd J=$(nproc)" to build and test the QEMU sources in a 
FreeBSD VM. It will automatically fetch and install a VM image for you.

  Thomas


