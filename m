Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12234606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NyO4aLH1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XYcBrB4d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxSv-00030R-PA; Thu, 05 Nov 2026 08:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xOxSs-0002zk-OO
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xOxSp-0002sE-NH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793885106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qoCjT2ZjZgRh4U31vgefv94Mf66dAjGhbOd9UDoULYI=;
 b=NyO4aLH1zfHKc9S6+n17SxlBLxePsWaD5t1DuQLkJtEJ5m2hWL2l/C2WDZt5z1fv5S4Ac+
 9F6fG8HuhSQBBITFgpbSSvrgYAuX0sdjbOg0WRX4G6uLAFWhrwjjE+aAW85TIflH4DDLZe
 vKZyVlifK0sRXC+AxHFofKO2MP7t0PM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-30m-HpeNNxOGWWEl_vILnQ-1; Thu, 05 Nov 2026 08:25:05 -0500
X-MC-Unique: 30m-HpeNNxOGWWEl_vILnQ-1
X-Mimecast-MFC-AGG-ID: 30m-HpeNNxOGWWEl_vILnQ_1793885104
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a80bd45e1cso10568665e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 05:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793885104; x=1794489904; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qoCjT2ZjZgRh4U31vgefv94Mf66dAjGhbOd9UDoULYI=;
 b=XYcBrB4d3flho5/yJAKE9iLP2DE9Hc09uRmR94XoBZ7buaLsB4uByNhkqB7Lp9soOT
 W2u6cxwGM5oiNmRNXoj6PcfF4gJD9d4nK3/uE7KRWeUgbB40Wgq2cSBq1IoYV5+bbAGG
 67AtmNKhteTBDvhGWCMG3c7AUmqQm42meTcNlk+IMnFDCT2vbM6tdFG/tQLhITum0grr
 /MN3JusTksVjVzolT8E0v72/jjTU/l+qwRDykU7wzIr3K8sSL3ctl9vJgMhJdR4GEpOH
 1AnPsAO/9sjn3i/rCwrn37zRZt0rWdEjdVG1MT5n+uYti3Fk/O799nVf6Bc12gCSm31M
 bRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793885104; x=1794489904;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qoCjT2ZjZgRh4U31vgefv94Mf66dAjGhbOd9UDoULYI=;
 b=kL2MN2+5G9kfEK0esI3XHjUchh5RIVvjU4oNwFHaGRRh2KkxZOvZsPO8FJvPuv4X3L
 4QqHIwOoJ4hu5Qgyiz9tccyGQvos3Ytu1wtnZcM5U8QRn2EdV8Afrtpx5ZQ6g5aPnF+Y
 gstJdBRuCOl6mgHRHqMB909wnkJ4G+Sr7AMWeTMUkB3e0Wg2o/XEv8hUt6liJppIUJIc
 sqXx+7JthL9v7dkozFnfPHP5Cd+0lFU6+7FOxrErfYv8g8Omy0KT+8YTTt4LY//iXTXZ
 9N5+kxCF/1ILF8pJzS14HQoT1eEms62eNiydawo1gWBdt+wiCUe6iiaFZ1tw5N5tcr65
 2X+g==
X-Forwarded-Encrypted: i=1;
 AKwUvByhwhjAA10mML1kzbYx4fyGsSZUI+3g+zMhuqRXCzYxcA9vNlbpMJyn9Q41olxCPHyPGcjjxoC+0NFC@nongnu.org
X-Gm-Message-State: APuU4Z9sFq3PKhxKfApcW1rcgxbCS9h5klv/HlKeofUUkEjuKs9ybxNg
 97/nAsoNxFYAWAcwVZhvqubDTk3+KlxO8J1qVgj6HCk2WY1dCDO7wyPALxStKlRKtasNWbtgKeU
 rj0GxtUKCas45Vh5540u/CqyMGg0yzQctqrHmVPIYw63TnveraTE4ONFd
X-Gm-Gg: AYBFou11VvdimveXEDT0sPJRE2bldiG3ZiDSg++Xy7u+2ckFQay5/hhl1mwAae7H4Ui
 0SzeNQjo2HwNyFauNeOhKYFrBy0m8OSgTip+4Xw/DbMxjQOh35+6fstMiF0I0uYi5luY5YCO3cM
 W5ZV4NzKjjRBdiBfhjmiQbOyIVM3u6iAgyofKfzwac3/IEcn43dvsswD4gOLr7zMBKf0lzQCODZ
 UQZqz+c68mxQAOpKWxHQQeugzGpfWG/pkSoCKrrSP8BVGRhJgFkHEwrKcqQLMWl9T7heT+ghZJj
 Q8iEOkm17x8555RbRI+7IekbtuqWQKJE/ZAj2vT5LkW01bOsRgVsoBdYcN/BjMcQ0KO/qR+cB74
 uXlxe6xqA4Mg3fKNGgnTUqB5ThwQukTDjGh50MiDTqSUnbb9S+Y2cUeRQNv8RQ54GxxbyiWSpH8
 KEahjAPokDqw==
X-Received: by 2002:a05:600c:a4e:b0:4a7:76fa:87e9 with SMTP id
 5b1f17b1804b1-4ac187a766bmr416873965e9.21.1793885103809; 
 Thu, 05 Nov 2026 05:25:03 -0800 (PST)
X-Received: by 2002:a05:600c:a4e:b0:4a7:76fa:87e9 with SMTP id
 5b1f17b1804b1-4ac187a766bmr416873365e9.21.1793885103234; 
 Thu, 05 Nov 2026 05:25:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:1292:d530:6448:8ad:27f1:8b49?
 ([2a01:e0a:1292:d530:6448:8ad:27f1:8b49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46538sm62497105e9.5.2026.11.05.05.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 05:25:02 -0800 (PST)
Message-ID: <23c28380-a70b-4b8a-bef6-78582af02139@redhat.com>
Date: Thu, 5 Nov 2026 14:25:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional/ppc64: add pseries virtio-blk
 hotplug test
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
References: <20261103141938.41147-1-anushree.mathur@linux.ibm.com>
 <de7816aa-98c6-4c9a-8420-b937f94cd8a1@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <de7816aa-98c6-4c9a-8420-b937f94cd8a1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 12:14, Chinmay Rath wrote:
> 
> On 11/3/26 19:49, Anushree Mathur wrote:
>> Add a functional test that hot-plugs and hot-unplugs a virtio-blk-pci
>> disk on the pseries machine.  It runs with TCG, and also with KVM if
>> KVM is enabled.
>>
>> On pseries a PCI device added through QMP is only enumerated by the
>> guest once rtas_errd (ppc64-diag) handles the RTAS hotplug event and
>>
>> runs drmgr (powerpc-utils).  Neither is in the buildroot image used by
>> the other pseries tests, so the test uses rootfs-hotplug.ext2: the same
>> image with those two tools added.
>>
>> The test boots with a second PHB (phb1) present so that the guest
>> registers its slots, adds a null-co backend, hot-plugs virtio-blk-pci
>> into phb1.0 and waits for /dev/vda, then unplugs it and waits for both
>> the QMP DEVICE_DELETED event and /dev/vda to go away.  The root drive is
>> used with snapshot=on so the cached asset is not modified by the guest.
>>
>> Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
>> ---
>> Hi all,
>>
>> This adds a functional test for virtio-blk hotplug on the pseries
>> machine, with a TCG and a KVM variant.
>>
>> The test boots pseries with a second PCI host bridge (phb1) present at
>> boot, hot-plugs a virtio-blk-pci device into it over QMP, and waits for
>> /dev/vda to show up in the guest.  It then unplugs the device and waits
>> for the DEVICE_DELETED event and for /dev/vda to disappear again.
>>
>> On pseries the guest does not enumerate a hot-plugged PCI device by
>> itself: rtas_errd (ppc64-diag) has to handle the RTAS hotplug event and
>> run drmgr (powerpc-utils).  The buildroot image the other pseries tests
>> use has neither, so the test needs a rootfs that includes them.
>>
>> I am sending this as an RFC because that rootfs is not available yet.
>> It is a new file, rootfs-hotplug.ext2, which I proposed for the
>> qemu-ppc-boot repository next to the existing pseries images:
>>
>>    https://github.com/legoater/qemu-ppc-boot/pull/5
> 
> Hi Cedric,
> 
> I heard from Anushree that you do not plan to accept PRs in the above repository going forward.
> 
> If you're okay with it, I'd like to fork your repository and maintain 

Sure. please do !

> it for future PPC test development and usage.
> Please let me know if that works for you.
Thanks,

C.


