Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C23FC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 10:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSCq-0004wO-B3; Tue, 05 Mar 2024 05:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhSCf-0004cN-1Q
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:39:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhSCc-0004kD-SN
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709635158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AuVhreoTkzzsDO6HM6fhgM36zoMFVM/2uztQypsqkf4=;
 b=a1SX7AZPMxHFeKCa8xcah+LxqycJT/ruVUBxZ5ocb+aYhAB467UhcEOCp5KdLfT77IvCCB
 TAdMJyQzqS+5gESL6qklvG6SvWiSJMkv0Z9TwrvHJRQsc5kGzh0x1c+FpOSWWYYXMzL6bM
 kYLwXnPyM6EXTHKA3pkVhrYYt08qIxc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Ii8TvDkwPk-qdvXDn4jeFA-1; Tue, 05 Mar 2024 05:39:14 -0500
X-MC-Unique: Ii8TvDkwPk-qdvXDn4jeFA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42eeee47028so20663381cf.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 02:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709635154; x=1710239954;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AuVhreoTkzzsDO6HM6fhgM36zoMFVM/2uztQypsqkf4=;
 b=TwxbG0esWyyr9xxGEKz84Y3w9Zk8HLd4w1DIMf7yxFVYti09KX9xqf9Y2WINbvns1e
 Wky4M5PCKxElYSPwFRISrdZ/+A0lJE91lOcEPoUbPksgZxxClUySqr6ZdWXyyC/KYCWa
 0sap2RnX8yNtPlLaV5k84oWI6hpY3SFpnSrZT84fi1taY4dS29RbvUBcfKhvJ3URdF9Q
 ieKdemPQyH/hz6tXATXVLrpdKu46LLnAQpl111Bh40n1HGTIbTCPJ+pwsuZvGa8hv3UJ
 k0xgGEWEJYZbnw79eHlAWF8bVdqr6tnGXJff89enWdNwI/hJQBszukXd+NMQUGWN6IPO
 z8ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh7aeLg+KQtg1ZKN0yF8w5vth//zh0dRuF8XabbikCBJ+VFdRkIRpGjWNhB0J6HQx1bipSW/ZLWzusHu8INrdOKs2ypTA=
X-Gm-Message-State: AOJu0Yw68pqevKXOAr8zOJtjtAL8wFVtJ+HMnDapUhZLxIIOQGkMgk24
 +Bt6QV5nAJrZAwsgqr+9rsDKUn2Fnu3yILtQCRjQl1ejb9VdOnNopOS6f7TxHvgJvCUOt+0Nowk
 bG/COo4nfR1TBu5BD9jdqPiU8JdGrU2TVOUwNRr86gaieXD8sdV4v
X-Received: by 2002:a05:622a:1709:b0:42e:eba2:fac9 with SMTP id
 h9-20020a05622a170900b0042eeba2fac9mr1641387qtk.19.1709635154503; 
 Tue, 05 Mar 2024 02:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhnJNnkK9MKix4oy89MRemWCJHYK0c/Ol75EZM5Fww7lB/qvAi77zNCWLbd+bwf8ypca1PqA==
X-Received: by 2002:a05:622a:1709:b0:42e:eba2:fac9 with SMTP id
 h9-20020a05622a170900b0042eeba2fac9mr1641375qtk.19.1709635154194; 
 Tue, 05 Mar 2024 02:39:14 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-243.web.vodafone.de.
 [109.43.178.243]) by smtp.gmail.com with ESMTPSA id
 i24-20020ac84898000000b0042edfc2c608sm2917307qtq.2.2024.03.05.02.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 02:39:13 -0800 (PST)
Message-ID: <86d80d62-8c82-4ec5-ab67-50c83041f979@redhat.com>
Date: Tue, 5 Mar 2024 11:39:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20240304130403.129543-1-thuth@redhat.com>
 <CAFEAcA8rac2nEzrVWUWfRHAWYLmC6dSDMK=j6msD_SdPpn6ZtA@mail.gmail.com>
 <3262c873-b845-4286-a71f-a53b96bbc8a9@redhat.com>
 <ZeYNQdqW2bBA4gNL@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZeYNQdqW2bBA4gNL@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 04/03/2024 19.04, Daniel P. Berrangé wrote:
> On Mon, Mar 04, 2024 at 06:11:58PM +0100, Thomas Huth wrote:
>> On 04/03/2024 17.56, Peter Maydell wrote:
>>> On Mon, 4 Mar 2024 at 13:04, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> The macOS jobs in our CI recently started failing, complaining that
>>>> the distutils module is not available anymore. And indeed, according to
>>>> https://peps.python.org/pep-0632/ it's been deprecated since a while
>>>> and now likely got removed in recent Python versions.
>>>
>>> This doesn't seem to be sufficient to fix the macos CI:
>>> something in glib seems to still be using it.
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/6313212803
>>>
>>> [281/6553] Generating ui/dbus-display gdbus-codegen with a custom command
>>> FAILED: ui/dbus-display1.h ui/dbus-display1.c
>>> /opt/homebrew/Cellar/glib/2.78.4/bin/gdbus-codegen
>>> ui/dbus-display1.xml --glib-min-required 2.64 --output-directory
>>> /private/var/folders/xc/tpssff9959345bnqq4c6tlww0000gn/T/cirrus-ci-build/build/ui
>>> --interface-prefix org.qemu. --c-namespace QemuDBus --generate-c-code
>>> dbus-display1
>> ...
>>> ModuleNotFoundError: No module named 'distutils'
>>
>> Looking at the glib sources, I think this has been fixed here:
>>
>>   https://gitlab.gnome.org/GNOME/glib/-/commit/6ef967a0f930ce37a8c9b5aff96969
>>
>> The fix will be in glib 2.79, unfortunately homebrew still seems to use glib
>> 2.78 ...
>>
>> We could maybe temporarily work-around the problem by disabling the dbus
>> code in the CI job? Or just wait for homebrew to update the package?
> 
> File a bug against homebrew. IME they are very quick (1-3 days) at
> putting out fixes for things like this, especially if you point them
> to the upstream solution.

Ok, while I was writing my mail, I was looking at https://brew.sh/ and 
didn't see a link to a bug tracker there ... but now I realized that they 
are simply using the github tracker, so I went ahead and filed a bug there:

  https://github.com/Homebrew/brew/issues/16823

Let's see how it goes...

  Thomas



