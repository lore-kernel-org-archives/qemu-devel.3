Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB11C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTy3D-0004TC-7c; Wed, 17 Jul 2024 02:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTy2w-0003u6-Hm
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTy2s-0008Ui-Os
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721197304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SIobQkcNtH8oJernFOFUl4iP8rEQRWKxbXGxLNm8Xxc=;
 b=EPtRJ+ipkuL1KeKKv+bvZt9Ivk1iXArIhiDNP/RD/aWy6IQZnaBSCDYTDrqiZfO2mIzU0U
 4IvDuKkbKEVAkYi+7LJtB0O61CBJW61A4dfVsVXxF9A8YBdkUU6aSQ9GxFDVNu1vm+LiTF
 ekIgpgqIYCyUXB9XNzqxzSxzbgAN2bI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-nPJq8SOoOlqmfMPKLOd_sA-1; Wed, 17 Jul 2024 02:21:40 -0400
X-MC-Unique: nPJq8SOoOlqmfMPKLOd_sA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42725d3ae3eso47137545e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721197299; x=1721802099;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SIobQkcNtH8oJernFOFUl4iP8rEQRWKxbXGxLNm8Xxc=;
 b=wDQz8WncL63uj14fL8UqTbZgm31hYm0G1qwyOJCKjl2RFVsg86lblWByk/Ltlve8Vo
 HsqGgfvx3z5V1r4FzZwpBXqYhQiGfM7X4Dt+m5o62/eP9u/7X3Cg3PNF7LaKTVoiC+kZ
 4jOpSPruQTnOsS1Fe1nHNIOsEHrUHnzsg25oR7uvc0TduqEEHVPoaFeyYthJl9Yc7Ouq
 cUi8Y1O6jD1N4xF5f+H7wyLPzjonGwQRItffEosLpas0Xxf1lE2mixqjGk2p8QjMTjm5
 5d820Aq4y6aekHoVnlMtybgPlDEf4a+JlTya1FvUJrUY6YaJTTfEvWEAAdgiqxuzqD0j
 vIEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ri7w0+rZm1bSRODJrMmFs2XjXR1a3FEso7kZgg1oTT7vL1/fKTNnSEhIS6IyJ2hWxUAtlE6sz3ynD3mWqwTwuMCzUuI=
X-Gm-Message-State: AOJu0YyoHCcUNnp8qY4nrU+2EEtroQ4WetZa5dZgntpQzM6nuiLTFUmH
 /td9ZjwDPIa6JblRKpBdqZzxYhh9whGXyxXqqusXTwBKeERCEeR/2qBB4bilL/ymjmI8IZWjabT
 fYjqLr8dX+dxukP2S78Hf5zMe1ZiIKWF4l+ELdqvKY9QA6pLo+4Zg
X-Received: by 2002:a05:600c:46d0:b0:426:5b22:4d61 with SMTP id
 5b1f17b1804b1-427c2cd0f32mr3709275e9.22.1721197299303; 
 Tue, 16 Jul 2024 23:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+02qaofCRkz48fi6p0OLmyZMclQ+DULac9JWRInJl1/XQvT5uMh+2ZCC32PDKB6kb/w1xIw==
X-Received: by 2002:a05:600c:46d0:b0:426:5b22:4d61 with SMTP id
 5b1f17b1804b1-427c2cd0f32mr3709185e9.22.1721197298885; 
 Tue, 16 Jul 2024 23:21:38 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccdffsm10879420f8f.54.2024.07.16.23.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 23:21:38 -0700 (PDT)
Message-ID: <2caf3193-52da-4bb2-955a-a44191fbd97e@redhat.com>
Date: Wed, 17 Jul 2024 08:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
To: John Snow <jsnow@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <CAFn=p-bMXm9qCD0hWiikyOmagFRryCZWrTx8xne9+x5j0QeNYQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-bMXm9qCD0hWiikyOmagFRryCZWrTx8xne9+x5j0QeNYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 16/07/2024 18.45, John Snow wrote:
> On Thu, Jul 11, 2024, 7:55 AM Thomas Huth <thuth@redhat.com 
> <mailto:thuth@redhat.com>> wrote:
...
>     - I haven't looked into logging yet ... this still needs some work
>        so that you could e.g. inspect the console output of the guests
>        somewhere

FWIW: This is now done in the next version of the patch series:

  https://lore.kernel.org/qemu-devel/20240716112614.1755692-10-thuth@redhat.com/

> This has spilled the most developer blood of any other problem with the 
> Python-based tests. Be very careful here.

Apart from 1:1 copying the functions from one __init__.py file to the other, 
and from setting up the logger so that it writes its output to a file, I 
didn't have to change anything. It currently simply seems to work.

> I still have a prototype for replacing QMPMachine with an asyncio variant 
> that should have more robust logging features, but I put it on the back-burner.
> 
> Avocado tests are the primary user of the QMP Machine interface I hate the 
> very most, a multi-threaded buffer-reader that works only by the grace of 
> god. If you do go down this path, I may want to take the opportunity to 
> abolish that interface once and for all.
>
 > I think simplifying the console buffering will help ease debuggability.

Feel free to do improvements on top! I think it should be easier now when 
there are no more complicated mixtures with the avocado test runner.

>     What's your thoughts? Is it worth to continue with this approach?
>     Or shall I rather forget about it and wait for the Avocado version
>     update?
> 
> 
> I'm personally ambivalent on avocado; I use it for the python self-tests as 
> dogfooding but I can likely switch back over to plain pytest if that's the 
> direction we head. I don't think I use any crazy features except some 
> asyncio helpers i advocated for. I'm not sure what pytest's asyncio support 
> looks like, but I have to imagine as the premier testing framework that it 
> has *something* for me to use.

There's no more pytest harness in the next iteration of the patch series, 
just the need for pycotap for TAP output. Console logging is completely 
independent of the test runner, I'll simply do normal logging to files there.

> My only ask is that we keep the tests running in the custom venv environment 
> we set up at build time. We have some funky post-hoc initialization of 
> avocado that allows us to use internet packages post-config for testing 
> purposes. If we move to pytest, it's possible we can eliminate that 
> funkiness, which would be a win.

I still need a way for making sure that pycotap is installed, though, so the 
venv is still there.

> I'm also not so sure about recreating all of the framework that pulls vm 
> images on demand, that sounds like it'd be a lot of work, but maybe I'm 
> wrong about that.

It likely does not make sense to rewrite the tests that use these cloud-init 
images (i.e. the ones that depend on the LinuxTest class). But we could 
likely simply continue to use avocado.utils for these, without using the 
avocado test runner.

> Tacit ACK from me on this project in general, provided we are still using 
> the configure venv.

  Thanks,
   Thomas


