Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B431D49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1EX-00053t-Sy; Mon, 18 Nov 2024 07:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD1ER-00051C-QU
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD1EM-0005oz-IC
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731934309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cu9lCfTManBUYLtu1mCcaNFpYgh+mZXSShhYu+si83Y=;
 b=LB46yy4JP+gaU/HkdkXbY2UVwX/ibf5o2zpZjFXWplanVNZNcpt2UcbZpuQPuC67fSj2/3
 p/RAXjMuFWLJEGtlOLAL5lhL2ntU8WsuUJjlhO0S4b2FPbi+rIBikxHQoN0wlqFLpU3SVM
 1xCeS/nZxfRzoqtIFk+lO3uJS8Q5t1c=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-MvL5RIcBM7OMKNdArqEHmg-1; Mon, 18 Nov 2024 07:51:47 -0500
X-MC-Unique: MvL5RIcBM7OMKNdArqEHmg-1
X-Mimecast-MFC-AGG-ID: MvL5RIcBM7OMKNdArqEHmg
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e38100afa78so6935077276.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934307; x=1732539107;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cu9lCfTManBUYLtu1mCcaNFpYgh+mZXSShhYu+si83Y=;
 b=org8BxeTa1y0NLt76xeM0a2SmZHQjwCKxlLXFlKFluXB5d8yKJhMdjFHeyFVInKer0
 FYd3TF7Vp/UQ0wq7+0gxp6+b2PXefA9yTR4KILZQDvY8KUSS7pqO4ckpkHlpy5oBQJeb
 ICZDCiE9DUoFdoCjpREi/xlPT4FJ/dJWJ6G85uoNsw8zoeO3YXSD4WCW+RXV3fC/StYq
 5K1RcPEkUCez/Y7DzQbkB6E4GXA4P6zjZUxAtXLpxmaPL2ihbtO6Wq8W7ckMXaFvaDFK
 xm41qntPvmWvxeLXKt031MJ0uALJiKM5s5MJlzfoV9AV5UpthNyDGeyJbtv6SPy1cGqm
 VLHQ==
X-Gm-Message-State: AOJu0Yy+TA8ilVhC97ivTvGQqJaEH03pfPiqIPf6UjX0iTbq/UiG7VBs
 XpE1B/6axnyl2ZlUdhSyFCkt91TkYebKFcbTGX3pXHBRdW2dL3RH+sF8psNqagyofKq6ZMoqhBl
 U0/n35706TPolkHt9WeVtz/rrtDJRi0pgh3kaquILBLW1pZHThCFv
X-Received: by 2002:a05:6902:124f:b0:e2b:9790:835f with SMTP id
 3f1490d57ef6-e38263c64e4mr9586661276.34.1731934307386; 
 Mon, 18 Nov 2024 04:51:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHesbHLJbv2Px7ehKpAvHzogcoMDPc6LxH+j/2vVahwpIMcbHhu35Ai9kL4vBmEe0EPlj7+YA==
X-Received: by 2002:a05:6902:124f:b0:e2b:9790:835f with SMTP id
 3f1490d57ef6-e38263c64e4mr9586647276.34.1731934307128; 
 Mon, 18 Nov 2024 04:51:47 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-145.web.vodafone.de.
 [109.42.48.145]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35c9845ebsm477747585a.12.2024.11.18.04.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:51:46 -0800 (PST)
Message-ID: <745c8df2-1821-4083-86af-9331f0c40bce@redhat.com>
Date: Mon, 18 Nov 2024 13:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tests/functional is eating disk space
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <CAFEAcA8hHMj0718haB_uZhE-LQF4W9PYrL-na0iznp4ueDsq7g@mail.gmail.com>
 <15635bd3-97fa-4c11-9427-c615d1b57dd1@redhat.com>
 <CAFEAcA91Kb4foyXJ3hcbqKXkHKae12yO=HcFYSUCFKS0AEG+oQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA91Kb4foyXJ3hcbqKXkHKae12yO=HcFYSUCFKS0AEG+oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 18/11/2024 13.49, Peter Maydell wrote:
> On Mon, 18 Nov 2024 at 12:10, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 18/11/2024 11.57, Peter Maydell wrote:
>>> I just ran out of disk space on my dev machine, because:
>>>
>>> $ du -h build/clang/tests/functional/
>>> [...]
>>> 11G     build/clang/tests/functional/
>>
>> That's indeed a lot. I only got 6.9G in my build tree for all targets ... I
>> guess there are some stale files lying around, so as a temporary mitigation,
>> just try to delete that folder (it should get recreated the next time you
>> run the tests).
>>
>>> The new functional tests seem to be eating disk space.
>>>
>>> Even the build tree I have that's just arm targets is 7.1GB.
>>>
>>> Could you have a look at what's happening here?
>>
>> I am aware of the problem and got it on my TODO list already... I think we
>> best should set the "workdir" to a temporary folder that we can remove once
>> the test has finished, that will automatically delete all binary assets that
>> the test created during its runtime.
> 
> Can we provide some kind of option for "keep the temporary
> data" too? That's sometimes handy when you want to manually
> run the QEMU command the test used as part of debugging
> a failing test.

Yes, I was also already thinking of e.g. an environment variable that can be 
used for controller whether the stuff should get removed or not.

  Thomas


