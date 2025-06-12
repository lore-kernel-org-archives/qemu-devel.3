Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283B8C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 04:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPZfp-0003sc-UE; Thu, 12 Jun 2025 00:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPZfo-0003nh-3g
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 00:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPZfm-0003Wu-2e
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 00:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749702975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2ZNfETzhcu1K83ZxhFHRw4jS5b7unnj4iNKgwqdNYIY=;
 b=RGxZYv2V20USXGaQfjum4kiKxrCBd9lG1GRR7k7d+hTVEbnfdsEQkd90AXwJtiayIvoYIR
 qAstNeYLaomdBxn5UEkWL4fl2hlUL94yhLBZamwia4ovZH1gaxTUwVBY7ENDb1lg8ZcCB5
 xNAF8h38vzsEI2TwVKY4i31NnasmJaE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-cLUbbYWmPO2WlUHhpLuXww-1; Thu, 12 Jun 2025 00:36:13 -0400
X-MC-Unique: cLUbbYWmPO2WlUHhpLuXww-1
X-Mimecast-MFC-AGG-ID: cLUbbYWmPO2WlUHhpLuXww_1749702972
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso223004f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 21:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749702972; x=1750307772;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ZNfETzhcu1K83ZxhFHRw4jS5b7unnj4iNKgwqdNYIY=;
 b=nnefZlMrCJ1h/VZAeJPN36bBatPDKKMNuF7hmAV2o5HYg2auihkQggetPpSIO8QOo2
 9b3ieXZrFkF67QEfKqLkJkoIbkY+gvq/PLBbbmjHb7fBGu/Vw3xgWcX3T9Vr0E9zE+dZ
 mzfr7PXAENm0FuY31A2bHdviurdDl3VBHZ/R8l3oaX+hH2YLgEQ4uGgKetOR0kMDKTGG
 Tm4JD4i1Rl0ArlHwWUx5UFgXICRf8DcnuBfSBiDKFBWa6WkRaDpo8d6ApluFXhmI1ch/
 KUM9cBgh0kdfCQA7amH5rV35ikswXZdjuIm+f3EiWviGoEsJ+FfzbZ29TDCduu7OBBg5
 Nl3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaNLaWCKuF9clg4coGbFBCgOHP7mICkDfBG0ao6MDgoz6DmNwGJoeqJ16B7PNK+SPtmgflbWV6rvbU@nongnu.org
X-Gm-Message-State: AOJu0Ywh5Kmy2HlTnh/GdurS7N0BdqubIYTt/m4z26TvFWllbSYC45Ef
 IbcDzdaKl6Zv4ejP2wI2MBA8UtIYvMC3sYtKPiO77oV30RJr3+bk1Zz4B2XZAaQgXAb1vkOErDf
 aatwA4UsjU86Rf2W/cxSKvH0XMvKgXZMlnWcUl6sphpJITtv5wy8h0luq
X-Gm-Gg: ASbGnctjxJVGHwBDoBAY+IpmusS0OGfbjsh4IIPPmD6dHbQ7baxpGMaMPhFZN9F1H+N
 eppNXGA9odfsxjUz7Y/RI9YJfmp4Xbpa5xQdm7JH/1YLEPdS/WJW0l9crOFr0BJBk4YhajbbA59
 sros1zHKsfIH43x6wdU0Ow1ZDV3vQupViAjz+LNcOFjrvRPZHoahAXk1Dxk93ypXf8dlmVHfhNS
 JEz337Rlz3G7ESqi6aAPi5L6/3hufM0Zs3XyIUZEY2rWGJiQ2niEGuW3qrVbExxLWBT6/KAydAq
 ks2546wEmoKW74dv5u2qZNNwtYD/HM+6QEnZgLLhtjICgI/p4nZuvDyJknr97Fo=
X-Received: by 2002:a5d:584b:0:b0:3a5:266f:e6fb with SMTP id
 ffacd0b85a97d-3a561374b1emr1025011f8f.44.1749702972159; 
 Wed, 11 Jun 2025 21:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtjuW/4HpwubZ02aMqDKxbT6cImJ7QeN8d5WCDEwRc8xlGG5VnjrvAWF2XNCC1JuujdYwWsw==
X-Received: by 2002:a5d:584b:0:b0:3a5:266f:e6fb with SMTP id
 ffacd0b85a97d-3a561374b1emr1025000f8f.44.1749702971789; 
 Wed, 11 Jun 2025 21:36:11 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-115-122.pools.arcor-ip.net.
 [47.64.115.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e2354fbsm7671705e9.15.2025.06.11.21.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 21:36:10 -0700 (PDT)
Message-ID: <4dd4bee5-7098-4f24-a81b-3935c58a6d9c@redhat.com>
Date: Thu, 12 Jun 2025 06:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250611075037.659610-1-kraxel@redhat.com>
 <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
 <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
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

On 11/06/2025 21.09, Stefan Hajnoczi wrote:
> On Wed, Jun 11, 2025 at 2:36 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 11/06/2025 09.50, Gerd Hoffmann wrote:
>>> The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600c40f:
>>>
>>>     Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://gitlab.com/kraxel/qemu.git tags/seabios-1.17.0-20250611-pull-request
>>>
>>> for you to fetch changes up to cba36cf3881e907553ba2de38abd5edf7f952de1:
>>>
>>>     seabios: update binaries to 1.17.0 (2025-06-11 09:45:00 +0200)
>>>
>>> ----------------------------------------------------------------
>>> seabios: update to 1.17.0 release
>>>
>>> ----------------------------------------------------------------
>>>
>>> Gerd Hoffmann (2):
>>>     seabios: update submodule to 1.17.0
>>>     seabios: update binaries to 1.17.0
>>
>>    Hi Gerd, hi Stefan,
>>
>> I'm now getting this when doing a git pull:
>>
>> Fetching submodule roms/seabios
>> fatal: remote error: upload-pack: not our ref
>> b52ca86e094d19b58e2304417787e96b940e39c6
>> Errors during submodule fetch:
>>          roms/seabios
> 
> GitLab CI didn't detect this, probably because the tests don't build
> SeaBIOS from source and use the binaries instead. Given infinite CI
> resources we should rebuild all ROMs from source to catch problems
> like this one.
> 
> I wanted to mention this in case anyone wants to tighten up the CI to
> catch these issues for SeaBIOS and other ROMs.
> 
>> Looking at
>> https://gitlab.com/qemu-project/seabios/-/commits/master?ref_type=HEADS
>> there is a problem with the mirroring:
>>
>> "This project is mirrored from https://review.coreboot.org/seabios. Pull
>> mirroring failed 4 months ago.
>> Repository mirroring has been paused due to too many failed attempts. It can
>> be resumed by a project maintainer or owner.
>> Last successful update 4 months ago. This branch has diverged from upstream. "
>>
>> Could you please fix this?
> 
> `git clone https://review.coreboot.org/seabios` works on my machine,
> but I manually clicked the "update" button and GitLab failed again.
> 
> In the GitLab UI there is a button to add a new mirror repo. I thought
> maybe we can delete the old repo and add a new one, but the push/pull
> direction dropdown list is disabled. Maybe that's because only 1 repo
> can be a mirror source for pull, I'm worried that deleting the
> existing failed repo will leave us with no way to add a new repo that
> supports pull.
> 
> Does anyone know how to go about fixing this failed mirror?

Maybe do a manual push --force to our mirror to sync them again? ... but it 
would be good to know how this could have happened at all - maybe seabios 
force-pushed their master branch at one point in time? Or did we commit 
something to the mirror that was not in the upstream repository?

Anyway, I just noticed that it seems to be working now again - how did you 
fix it?

  Thomas


