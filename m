Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DEEE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 17:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKhWd-0004Wz-D6; Mon, 09 Dec 2024 12:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tKhWY-0004WZ-Ei
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:26:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tKhWV-0006DS-Ua
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733765178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x8i0rbEfmPksPaG+WJLav6nnscfUpR7J14SxVMEZbQs=;
 b=DIaVC4jzEoURJTT54bNsHuiR34tzdEOO4MY9I3pGCibd+8pCzU+rX0TJJim8HBmu82A60K
 4oVU36yjSwb+EASPNqcfh1CdhQ1jS4eLcgtwyvDQ6HkSGwXSf1BqSToGLQaySI3pvuxZ/+
 iM/1jZtPYgIuSZmzxQrVnpjB+r7k9Wg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-Una0V-N1NYShp1SJv8pOTQ-1; Mon, 09 Dec 2024 12:26:16 -0500
X-MC-Unique: Una0V-N1NYShp1SJv8pOTQ-1
X-Mimecast-MFC-AGG-ID: Una0V-N1NYShp1SJv8pOTQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434f3398326so7332145e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 09:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733765173; x=1734369973;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x8i0rbEfmPksPaG+WJLav6nnscfUpR7J14SxVMEZbQs=;
 b=MR8C+j66sJh2QqUGgMJnoHPx1iMb5CFP2RYDTnCInd9f2pW3naWhFeMe7Q/LZ93gXq
 cOMc5pLrXyW2s0C+ju9BOHWR+TYv1d+U8xGNB1XzvXmq496l5wseeWlvx3qZ0rUN4eFe
 x+Gh5yTrO0sY0XTyaGAG1wC7+hmUIDp5Xp5Yd/MOpbeiSxytg6/680QEPm5ApqhEu4qk
 pBSGGaeBmc0u/obuvO8Nvlm9FDd5AWI9rOWUDjsUIM5NTk9HuAsfFvbCy3cPgRaLOOU6
 cnkwgFl2M7+9WvBBen44EaTuLvSPLM7fFGd+qFAfsozbC+nPRYDadHJvCq6YiEtC8c+y
 C2SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGwmB0kzIasOrf+tAGvbnAzt9GKpjLqXaUp8KIxP2PsN2zTwLb4LtXAItRQs3WM7omZUNo0h77Qta7@nongnu.org
X-Gm-Message-State: AOJu0YyOSS59nkj/o8eM/I74C/sQgtNkJCuJXPDmMmNiWlnkRGVXg7BW
 Z1Woudma+xs9LSeEAEV5rosH+A3bQNHND4F6V2t2Ivvh5xUpBJKo6lTbz+el54x+hUaMCYb6X5T
 NVp44F6fCAYjsKO7qLo6sDZkAUFoKAF+/dk+4ogvfNNfESdtbEta0
X-Gm-Gg: ASbGncvqyKhY9GreYZkyBKMwZXVyAg+nTDPOjK6vZEBWKI86blKfPujyb1F0oNdU9yq
 qAL8Xdc5lEBgQMbA114y8JhbYf4cGms28G1U6/4+2pXi11qEAF/RsTMjRgkF+O86aaIMOoa6S9i
 MyUrADO9aGFD3nlwCLl+8+NhCtM1XjZL4NelAskpJvGCYLs/XGkR2rAyzQ9cIFcyAdZcrCEqG76
 QcTKX0aVHkeBuGzvi4AYJ5b6O7+c5swrritR4mrZMSrndc7Ud+qEdT4eT9zp1skD27HzX45BdJD
 Zdc=
X-Received: by 2002:a05:600c:3ba5:b0:434:e65e:457b with SMTP id
 5b1f17b1804b1-4350215de80mr2038925e9.3.1733765173565; 
 Mon, 09 Dec 2024 09:26:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/fLUPTxuoSTeL04FVTmFx0BxQtB4efQE8SMuKbHWkXNbWnAYpbBxHPm5BYjf3csrjryVQpA==
X-Received: by 2002:a05:600c:3ba5:b0:434:e65e:457b with SMTP id
 5b1f17b1804b1-4350215de80mr2038715e9.3.1733765173174; 
 Mon, 09 Dec 2024 09:26:13 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-52.web.vodafone.de. [109.42.49.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da0d26a3sm164546605e9.1.2024.12.09.09.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 09:26:12 -0800 (PST)
Message-ID: <2d9f4096-b2eb-4af1-a0be-f985bf36f136@redhat.com>
Date: Mon, 9 Dec 2024 18:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] tests/functional: Convert the intel_iommu
 avocado test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, eric.auger@redhat.com,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20241206181728.1241169-1-thuth@redhat.com>
 <d07f4ade-716c-4d58-b6d9-a95b4ffe58ab@redhat.com>
 <7e81c4a2-cc76-4d8c-b14a-fd008eff0c09@redhat.com>
 <Z1az26HxcIHVlB-d@redhat.com>
 <4fa944df-ddf2-48be-bbb0-7b24f63263e6@linaro.org>
 <Z1ccrYDMVLo9vZF6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z1ccrYDMVLo9vZF6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On 09/12/2024 17.37, Daniel P. Berrangé wrote:
> On Mon, Dec 09, 2024 at 05:31:37PM +0100, Philippe Mathieu-Daudé wrote:
>> On 9/12/24 10:09, Daniel P. Berrangé wrote:
>>> On Mon, Dec 09, 2024 at 09:26:21AM +0100, Thomas Huth wrote:
>>>> On 09/12/2024 09.12, Eric Auger wrote:
>>>>> Hi Thomas,
>>>>>
>>>>> On 12/6/24 19:17, Thomas Huth wrote:
>>>>>> Convert the intel_iommu test to the new functional framework.
>>>>>> This test needs some changes since we neither support the old 'LinuxTest'
>>>>>> class in the functional framework yet, nor a way to use SSH for running
>>>>>> commands in the guest. So we now directly download a Fedora kernel and
>>>>>> initrd and set up the serial console for executing the commands and for
>>>>>> looking for the results.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>     MAINTAINERS                                   |   1 +
>>>>>>     tests/functional/meson.build                  |   1 +
>>>>>>     .../test_intel_iommu.py}                      | 119 ++++++++----------
>>>>>>     3 files changed, 51 insertions(+), 70 deletions(-)
>>>>>>     rename tests/{avocado/intel_iommu.py => functional/test_intel_iommu.py} (41%)
>>>>>>     mode change 100644 => 100755
>>
>>
>>>>>> -        self.launch_and_wait()
>>>>>> -        self.ssh_command('cat /proc/cmdline')
>>>>>> -        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
>>>>>> -        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
>>>>>> -        self.ssh_command('dnf -y install numactl-devel')
>>>>> I understand you cannot use ssh yet but the bulk of the test was the
>>>>> execution of the dnf install meaning we lose the main substance of it
>>>>> through the conversion.
>>>>
>>>> Ah, I see, so this was exercising the virtio-net device with the IOMMU ...
>>>> and I already wondered why there was this "dnf install" at the end without
>>>> doing anything with  the numactl-devel package ... (a comment would have
>>>> been helpful here)
>>>
>>> FYI, I find 'dnf instal' to be a *highly* undesirable thing todo in
>>> our test functional. Its performance is highly non-deterministic
>>> depending on what mirror you happen to get sent to, such that it could
>>> easily push us over the timeouts. It is also susceptible to periodic
>>> broken mirrors, and instability around time of Fefdora EOL. I can't
>>> remember if it was this test case, or a different one, but I've seen
>>> problems before in avocado with 'dnf install'.
>>>
>>> If we want to test working networking, then can we arrange for something
>>> more simple & targetted to run, with better worst case performance.
>>
>> Could we use 2 virtio-net interfaces inter-connected and stress with
>> https://linux.die.net/man/1/ab ?

The problem is that this tool is not available in the guest image by 
default, so we'd need to dial with "dnf install" during runtime again, 
relying on the availability of a third party server... so that would not be 
any better than the "dnf install" that was in this test here before, I think.

> Do we actually need to stress this ? IMHO for a functional tests we just
> need to prove that the device is working at a fairly basic level.
> "wget example.com"

My current plan is to start a HTTP server in the guest ("python3 -m 
http.server 8080" is your friend), and then to download some megabytes from 
the guest to the host to see whether we can transfer them successfully.

  Thomas


