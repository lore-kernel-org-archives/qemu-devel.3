Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2264DC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRSP-0005YU-52; Mon, 11 Aug 2025 08:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRSF-0005UA-24
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRS8-0005Lx-W9
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754914592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XCq7j1WCpi2/CqooxK+xDiWtrvdUz+f2I/m7J9WE0QA=;
 b=Vz0BdExuxDGTiYBSaqTN4UAQN5R/9zIu1U2sFDO3NcGpHd2zOpDkTIpbnpADjCun3fS3qG
 98jODqIJIFO8rF1BLHfW5m2NwOG4PLAbVL7WY1TsrGO1TntbJBVLPpmASWlK7o67lSnivg
 Ioq2xwyXd1oYaR2rH7jKsH4YKrZR7rI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-vMr7Ci-TODOBP9p5GcwHrA-1; Mon, 11 Aug 2025 08:16:30 -0400
X-MC-Unique: vMr7Ci-TODOBP9p5GcwHrA-1
X-Mimecast-MFC-AGG-ID: vMr7Ci-TODOBP9p5GcwHrA_1754914590
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b076528c4aso47266381cf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754914590; x=1755519390;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCq7j1WCpi2/CqooxK+xDiWtrvdUz+f2I/m7J9WE0QA=;
 b=ZPmLBTQJNlA9juwv7gD9ixw3Wc7v3qqsAE9FfqhyVuz4TvTspyVxJmpDJA/IN9BfUd
 T5ByV3GpSf0b0NBe8G7iPm+IQ49Rz+atPbNvxV/4PIYBdKbAX/3n6gRYC2nBELCFkB9Y
 LL3Zdy925Iq1KVDTJFrHUsKB+lTtfsppyGpJg8weoEG0LkPpXu6MYsvFMWyj7WVpOKYK
 MLZlhrtDlaiwYzLewmucO6lv2TMTXlsdnH8ZymBt5fnTgYM9ZOT+wjujv0UFfSB/BEIT
 YiIMO6T8AtgvV882hNCfcogvVDnAo/ijiwMFV0WPlV5Pp9RQPe14jY6lkMA9I2CbxK4i
 xH1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV12X6AxS5AEak23CPL2AmXCIugC+In+j8vAKBdzSEz6Z17rPB3frRxbQiwAV97Duxr06kF8CppH6YK@nongnu.org
X-Gm-Message-State: AOJu0Yxi4+//hX3z/zY/3X4hTSsNaThUM/raxwrIfpwNE5JhXp8pA6Lj
 bx1ZQ+6UcrRZF72MICD1NhxKTJLWnWqaiM+pv/1p2iruZY8hwqkWTsYg8zIpU2zks/19vsFUBL/
 zeJhav0RcpKXXOwKG46cvCLweogPwg5KNVPTNH//VzZ1SsoDA1cdpC9x/
X-Gm-Gg: ASbGncutc/78MiMG5e52ISDnp83k9lT6EaiJAI0WI1gAfjO3wdf/5LMOCinCYnHRhqb
 Gi9aIKzhcexCkGKMmH6MIfWiWCyzjQDQDnjEZmubK8dUpmc33OhqcYi3izCjJKdhDxGA7C8HNOb
 Qt2mdRVI+IoPs1CD/3JhBDre1PRtFXToX2VFkwE1HzjiA+cww0Px6k5d0ecEThex21gSxTmqBC2
 URvQ2270fhSVEFBVGWVZWf6BAytscY3O1vGMIL3WSjFW5/m7q7f8lG3GGdmX2fqWBvrfZnrUnTE
 bc1hNEDeTHXJ2OUyh31G1fGYnjI8mtDP13Us1dwt89nRkTwynw7Yv42VL13ybqLkLGM5eXqa+X7
 AgQ==
X-Received: by 2002:a05:622a:15c7:b0:4b0:6b56:a8b1 with SMTP id
 d75a77b69052e-4b0aedd93f1mr148900541cf.35.1754914589899; 
 Mon, 11 Aug 2025 05:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn2uqE8RvUScPfR+pfzOkHImXlon3RW0Bdq5B6oQgnSJTcZX318ejtnrTikdPTDzyTosoPBw==
X-Received: by 2002:a05:622a:15c7:b0:4b0:6b56:a8b1 with SMTP id
 d75a77b69052e-4b0aedd93f1mr148900081cf.35.1754914589403; 
 Mon, 11 Aug 2025 05:16:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b061be8c43sm108764691cf.12.2025.08.11.05.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 05:16:28 -0700 (PDT)
Message-ID: <90e4fbed-a763-4f02-9752-210bf49d3970@redhat.com>
Date: Mon, 11 Aug 2025 14:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/7] Power11 support for QEMU [PowerNV]
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
 <baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com>
 <yo6uk5z6dlq4jlk5hsaoyhymozdpo6ijpq5bz4fipkf5ftws4b@um57vsttgf65>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <yo6uk5z6dlq4jlk5hsaoyhymozdpo6ijpq5bz4fipkf5ftws4b@um57vsttgf65>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/10/25 08:56, Aditya Gupta wrote:
> Hi Cedric,
> Sorry for the late reply, I am on vacation this week, will try to look
> at this, but reply might be late.
> 
> On 25/08/08 02:32PM, Cédric Le Goater wrote:
>> On 8/8/25 13:59, Aditya Gupta wrote:
>>> Overview
>>> ============
>>>
>>> Add support for Power11 powernv machine type.
>>>
>>>> <...snip...>
>>
>> Booting a PowerNV11 machine crashes QEMU. See below.
>>
>> Are you testing with petitboot kexecing a distro kernel from disk ?
>> Please do and also start a KVM guest. Please check your tests.
> 
> No, I ran the qemu functional tests, and few boot tests with different
> options.
> 
> The functional test already attaches a e1000e device, somehow that
> didn't trigger the same error that you saw (maybe the kernel used
> doesn't have support for that device).
> Will add a test to try petitboot kexec scenario also, so we don't hit
> these kind of issues in future.

I run a multi socket config :

   qemu-system-ppc64 -m 4G -machine powernv11 -smp 16,sockets=2,cores=2,threads=4 -accel tcg,thread=multi
     -kernel ./zImage.epapr
     -initrd ./rootfs.cpio.xz
     -device pcie-pci-bridge,id=bridge1,bus=pcie.1,addr=0x0 -device nvme,bus=pcie.0,addr=0x0,drive=drive0,serial=1234
     -drive file=./Fedora-Cloud-Base-Generic-42-1.1.ppc64le.qcow2,if=none,id=drive0,format=qcow2,cache=none
     -device e1000e,netdev=net0,mac=C0:FF:EE:00:01:05,bus=bridge1,addr=0x3
     -netdev bridge,helper=/usr/libexec/qemu-bridge-helper,br=virbr0,id=net0
     -device nec-usb-xhci,bus=bridge1,addr=0x2
     -device usb-storage,drive=usbkey
     -drive file=usb.img,if=none,id=usbkey,format=raw,cache=none
     -serial mon:stdio -nographic
   
See :

     https://lore.kernel.org/qemu-devel/3b1fcc0a-6ce7-4639-a17c-34d640745c20@redhat.com/

> 
> Regarding KVM guest, iirc we can't start KVM guest for PowerNV yet right
> ?

The QEMU PowerNV machines support emulated KVM guests. XIVE
is a key component in its support, as it controls the wake-up
of the virtual processors.

The QEMU pseries machines support nested too, both implementations:
the initial on OPAL systems and the most recent v2 one for pHyp.

I believe QEMU PowerNV machines support nested KVM too. Never
tried that though.

C.


