Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7350DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 10:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXHrl-0006Oh-Ap; Fri, 26 Jul 2024 06:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXHrj-0006O9-BP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXHrh-0002y6-1i
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721988475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uHqi2zrTisDRAKg6rGPjVXWI2ssiOWcg5KB8G7UfoK0=;
 b=L2xgis//CiujeKjgwtRFv5Hsw9l4NBKOGEyzU0DSYWqpRPwrAYYTP2i/12fyKdFjWJFa/P
 2OjltwYI/PP/zyB67KVk2jRlzuE1MvxdHVY0sLBU9PCUIf3DEmXymfdBakcS1oTTHFb9kX
 ckqd2XPZ6VTlpS1FLEAVsN84am76+fc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-kv7lmlfCNxONKyn4zDf6bA-1; Fri, 26 Jul 2024 06:07:53 -0400
X-MC-Unique: kv7lmlfCNxONKyn4zDf6bA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef2907e21bso9452831fa.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 03:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721988472; x=1722593272;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uHqi2zrTisDRAKg6rGPjVXWI2ssiOWcg5KB8G7UfoK0=;
 b=gM4P/zq/Ces4MQWcOOyzEFCXosE4vRiDBmsRHtXyYBTCaFtlLvYoO44WyY0aRMtArm
 omYSReEyyxgo43rmRyTsba4Qp05qhCaTufHP77f/BprdxEXFV0N5AhitdTlh0FbAHdNG
 f1Os9HyPyyWAMV+X/d+/Q/c6dEuHjic+ZGmASLdjbEk7QQXqlEtim1kkrHX6fod65vbv
 JtF8VcbJ+yTii5tdzAsx9HvqxJTroWXf/YKEyLbfVmRT9gufa5E/V7hXBRXaE+xWUxAp
 U4vbm5wBp6SxV7zobfiqvKk8kYLouXXIOfdU8+qwNG7ya4cNCrQTM5uZfwkTcVHUu2Ty
 DaXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUT+HWhfjUHFNNLPiHUZNnm30j3yj2E9gR+W3yaEnxVNAFZJLIbAss/3Ei9A8Le8GdtUB39BML1+kM7xNnsycwE7tw8a4=
X-Gm-Message-State: AOJu0YxqwvKENSrcYE+lnMSpgEWJG5vsOR+diFQzVxHYzvHZaxTIxOLN
 Gdxvrin4KKU/2hyrEAcrzPjXXXiLGPxljIgARqxNyt/MVP9Tv1BASSMicZOK2EWNgrhHbj79LN3
 nVwwlnV7PCH6EutWY5C/xNX8HdKALJmuSMwbH788RYHkkzkfRrBET
X-Received: by 2002:a2e:bc25:0:b0:2ef:2638:48cd with SMTP id
 38308e7fff4ca-2f039dbab7fmr45056641fa.30.1721988471967; 
 Fri, 26 Jul 2024 03:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxx1Ot2lOoiaD4tbGE35sUSSQrezvkQ4nxhdPVsyJ3MWGQiVQdxFHP18YshP9zYyNckV/DlA==
X-Received: by 2002:a2e:bc25:0:b0:2ef:2638:48cd with SMTP id
 38308e7fff4ca-2f039dbab7fmr45056191fa.30.1721988471476; 
 Fri, 26 Jul 2024 03:07:51 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280fa9a30csm1825095e9.30.2024.07.26.03.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 03:07:51 -0700 (PDT)
Message-ID: <e6022904-7656-4f88-9cac-3c40a55c24e6@redhat.com>
Date: Fri, 26 Jul 2024 12:07:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] Convert avocado tests to normal Python unittests
To: Cleber Rosa <crosa@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <CA+bd_6LbLbR5hEqUhn5Vutf1k5HsB4Zg=qYF-Tq_pOrxDeWo1A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CA+bd_6LbLbR5hEqUhn5Vutf1k5HsB4Zg=qYF-Tq_pOrxDeWo1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On 25/07/2024 16.21, Cleber Rosa wrote:
> On Tue, Jul 16, 2024 at 7:28 AM Thomas Huth <thuth@redhat.com> wrote:
...
>> There have been several attempts to update the test suite in QEMU
>> to a newer version of Avocado, but so far no attempt has successfully
>> been merged yet.
> 
> So, we've seen in the past an attempt to update Avocado from 88.1 to a
> regular release, and the troubles it caused, including a revert.  My
> take was that a LTS version should be used, but during this time,
> Avocado experienced a rewrite and having it replacing the old
> implementation in a production level project such as QEMU was tricky.
> Then 103.0 LTS was released, and there was extensive work to test the
> QEMU tests before that release was cut.  Additionally, there was
> further work, but unfortunately not posted yet, to make use of 103.0
> features in the existing tests[2].   I've tested on GitLab with tests
> running in parallel, cutting job times in 1/3[2].  A side node is
> that, because 103.0 is an LTS release, it will receive the needed bug
> fixes and updates that we deem necessary, including things we find in
> QEMU tests.  In fact, 103.1[3] is in the works.

  Hi Cleber,

thanks for the explanation, but we really need to replace v88 rather *now* 
since v88 does not work with the latest versions of Python anymore (there is 
a work-around on Fedora fortunately, but it's completely broken on Ubuntu 
24.04 as far as I know). So even a single-threaded execution with v103 would 
have been better than waiting forever for your update to land. The problem 
with v88 being broken has been raised a couple of times already, but it's 
incredibly hard to get a response from you Avocado folks, so with hardly any 
help from the Avocado side, and nobody on the QEMU side being really 
familiar with the Avocado stuff, and with the meson test runner being used 
by all other subsystems in QEMU already, I think it's best if we continue 
with this series here.

>> Additionally, the whole "make check" test suite in QEMU is using the
>> meson test runner nowadays, so running the python-based tests via the
>> Avocodo test runner looks and feels quite like an oddball, requiring
>> the users to deal with the knowledge of multiple test runners in
>> parallel (e.g. the timeout settings work completely differently).
>>
> 
> Now I believe we can be very much in sync here.  I've thought for a
> while that there's no reason for Avocado to cooperate or be compatible
> with Meson.  There's no reason why users can't simply pick how the
> test gets run.  In fact, with the new Avocado architecture, you don't
> even need to run "avocado" to run an "avocado-instrumented" test.  You
> could pretty much run "avocado-runner-avocado-instrumented" with the
> right parameters through Meson.

Ok, good to know, we could maybe use that eventually for the tests that 
really require the Avocado framework (i.e. the cloud-init based tests).

For the others, as Daniel said in an earlier mail, it's much more convenient 
if you can also run the tests directly instead, without such a layer in 
between - that makes debugging way easier.

>> Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
>> classes (e.g. based on cloud-init images or using SSH) really depend
>> on the Avocado framework, so we'd need a solution for those if we
>> want to continue using them. One solution might be to simply use the
>> required functions from avocado.utils for these tests, and still run
>> them via the meson test runner instead, but that needs some further
>> investigation that will be done later.
> 
> So, I believe this type of higher level testing is something that
> needs to remain, and even grow.  Speaking for Red Hat, I see the
> movement of QE contributing more Avocado-VT style tests into QEMU
> itself.

I didn't really see such a movement in recent times yet ... Could you point 
to an example?

>  This means way more libraries and features that go into a
> common set of utilities and features (more on that later) than it
> currently exists in avocado.utils.
> 
> This brings the autils[4] initiative into the picture.  We're about
> 80% done with the project structure, and after that, it will be a
> common utility project (such as the cloudinit and ssh) which can be
> released automatically when the maintainer votes (through GitHub) that
> a new release is needed.

autils sounds promising, but I just had a look at the repository, and there 
does not seem to be that much code available there yet, so I guess it will 
take still quite a long time 'til that's ready?

  Thomas


