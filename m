Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75225C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIIV-0005wK-Ja; Fri, 08 Aug 2025 04:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ukIIN-0005nT-UW
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ukIII-0007ti-SD
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754641062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MNFOHjhfFN7oqWZpjOmYPpeif9n8vBjG1FMAEXmITiI=;
 b=W0y5kJTlnBrgJv4iz+HRfJTsuh5JRA2bOBEcErzcuGq4eSfdjTwpINGCxVOOQcHbZ5d7YG
 OmFLhrvsjwkBOropG0JJzFcsMZ9p4c2FQZ3YnRnOzfIdxYwxD2vhR9f8y45G47g0dw4uIQ
 Ktsz51FL3/TV4kbgNy1/efAafn5VraY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-NC_cybQ8OU6y90XyGo9hGw-1; Fri, 08 Aug 2025 04:17:28 -0400
X-MC-Unique: NC_cybQ8OU6y90XyGo9hGw-1
X-Mimecast-MFC-AGG-ID: NC_cybQ8OU6y90XyGo9hGw_1754641048
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e82b4ed799so164276485a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754641048; x=1755245848;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MNFOHjhfFN7oqWZpjOmYPpeif9n8vBjG1FMAEXmITiI=;
 b=l0MeLpAqlL7c/hwMJc72rk3gE1u1IkKfxibho/SLpclg1H4gYUH3gxm1IUfXvUekJL
 CZWbixtfnfgiJEoUVCgaBLGiehmaKLYY2ssACxah6Bui5BvDNowEJOq5nX4cd7hOm7HC
 igqZAI4kqlVgFUt4nSe75f4HO+s0NWgeXqjvS6KDT4ZCMeBr2sjAX2244Xs5mm60RQSs
 iclsc766eNI4MAa/Na+qskoKbakpRFVJH797W6KxNIiUJBm1Vumcx+uy22VjdVHtuc0Z
 vl3dL2AVwIvDMFgtKYLK5aMlQV8duVEKhEgKHrdSIgBoiqjCFLHZ8Kxx8Ha2CNZR+ZVv
 7PDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMl2zDYTBjFEXivxf73nWF7eQ3vBe91k7MbfahIvW6uN1Qd5iO4hbt/QiIQ+DfxP5Fa6xffaKROOnb@nongnu.org
X-Gm-Message-State: AOJu0YwlZM0wio89whBwL6cQkJjTrfJPKmRcvtxrTuH1mGjvbzVhU0zp
 sOUwxEXHLsUBBBS8b5N1mhJUA608apxOql8NqwW4dDBgveyALSJ8wL7Fou9kZZbvkdPkYc0Qn66
 EOEsV+gXT8FORcYLvgx/6i4TT2dW85aDNiv4ea+w4094ULzEg3NUq4Wyf
X-Gm-Gg: ASbGncvbHo0i70gNgspB2uGOP1TR7sRFSzMTO5VxYwwmeiKxM5NU91HsJR0Io37QIKS
 HLf6aXPX1ik1CF2mKJgdGc40E/Mknxfj0OAOg+nzbTmrIoCtWi6hlurT70mhEJCgK8aH1J3qzzk
 SqljkDPKxc1zK88jy62ep/KJUUv6zmjBx9C7pidatWRMkcSB5AXCxql7sUwcfT4ay17WdpbHcmo
 B04d0zMeksPWvimhVDRQF/UZ12qxZbbEUsb1fiM10LDcwi3R47uRAibOsIpHEW+REcq5GgLn2vg
 NTeN8QMcA07xYZMOIBDaJIr24NL9vEuzD9RrSg/VrnSKPipoDwNaY5i2VTAwzu7nRgoGKRs6nD1
 sMg==
X-Received: by 2002:a05:620a:2590:b0:7e8:1747:62b4 with SMTP id
 af79cd13be357-7e82c65cf16mr312195585a.20.1754641047722; 
 Fri, 08 Aug 2025 01:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC5e1MLs2s2GsbmLz5sqTFIOw4Ob5OxoF8mD+HZJLc1E1KZlHtt7TlssftVPKHaTUy+WxI1g==
X-Received: by 2002:a05:620a:2590:b0:7e8:1747:62b4 with SMTP id
 af79cd13be357-7e82c65cf16mr312193285a.20.1754641047197; 
 Fri, 08 Aug 2025 01:17:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f752aa5sm1087612485a.75.2025.08.08.01.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 01:17:26 -0700 (PDT)
Message-ID: <3b1fcc0a-6ce7-4639-a17c-34d640745c20@redhat.com>
Date: Fri, 8 Aug 2025 10:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/50] ppc queue
To: Michael Tokarev <mjt@tls.msk.ru>, milesg@linux.ibm.com,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>, Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
 <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
 <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
 <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
 <4468aea8-b8cc-4313-abbe-8a5f58a35adc@redhat.com>
 <6afc919bdb18166a71a2dba1a3862709629d5e08.camel@linux.ibm.com>
 <a9d36b56-2954-4a48-aec4-09657a2295b2@tls.msk.ru>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a9d36b56-2954-4a48-aec4-09657a2295b2@tls.msk.ru>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 8/8/25 08:07, Michael Tokarev wrote:
> On 06.08.2025 23:46, Miles Glenn wrote:
>> On Tue, 2025-08-05 at 22:07 +0200, Cédric Le Goater wrote:
> ...
>>> These seem to be interesting to have :
>>>
>>> ppc/xive2: Fix treatment of PIPR in CPPR update
>>> ppc/xive2: Fix irq preempted by lower priority group irq

I added :

   ppc/xive2: Reset Generation Flipped bit on END Cache Watch

>>> ppc/xive: Fix PHYS NSR ring matching
>>> ppc/xive2: fix context push calculation of IPB priority
>>> ppc/xive2: Remote VSDs need to match on forwarding address
>>> ppc/xive2: Fix calculation of END queue sizes
>>> ppc/xive: Report access size in XIVE TM operation error logs
>>> ppc/xive: Fix xive trace event output
>>
>> I'm still not sure that the benefit is worth the effort, but I
>> certainly don't have a problem with them being backported if someone
>> has the desire and the time to do it.
> 
> I mentioned already that 10.0 series will (hopefully) be LTS series.
> At the very least, it is what we'll have in the upcoming debian
> stable release (trixie), which will be stable for the next 2 years.
> Whenever this is important to have working Power* support in debian -
> I don't know.
> 
> All the mentioned patches applied to 10.0 branch cleanly (in the
> reverse order, from bottom to top), so there's no effort needed
> to back-port them.  And the result passes at least the standard
> qemu testsuite.  So it looks like everything works as intended.


24.04 operates correctly with a "6.14.0-27-generic #27~24.04.1-Ubuntu"
kernel on a PowerNV10 system defined as :

   Architecture:             ppc64le
     Byte Order:             Little Endian
   CPU(s):                   16
     On-line CPU(s) list:    0-15
   Model name:               POWER10, altivec supported
     Model:                  2.0 (pvr 0080 1200)
     Thread(s) per core:     4
     Core(s) per socket:     2
     Socket(s):              2
     Frequency boost:        enabled
     CPU(s) scaling MHz:     76%
     CPU max MHz:            3800.0000
     CPU min MHz:            2000.0000
   Caches (sum of all):
     L1d:                    128 KiB (4 instances)
     L1i:                    128 KiB (4 instances)
   NUMA:
     NUMA node(s):           2
     NUMA node0 CPU(s):      0-7
     NUMA node1 CPU(s):      8-15

with devices :

   0000:00:00.0 PCI bridge: IBM Device 0652
   0000:01:00.0 Non-Volatile memory controller: Red Hat, Inc. QEMU NVM Express Controller (rev 02)
   0001:00:00.0 PCI bridge: IBM Device 0652
   0001:01:00.0 PCI bridge: Red Hat, Inc. Device 000e
   0001:02:02.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03)
   0001:02:03.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
   0002:00:00.0 PCI bridge: IBM Device 0652
   ...

A rhel9 nested guest boots too.

Poweroff and reboot are fine.



Michael,

I would say ship it.


Glenn, Gautam,

It would nice to get rid of these messages.
   
   [    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
   [    2.270794918,5] XIVE: [ IC 00  ] Resetting one xive...
   [    2.271575295,3] XIVE: [CPU 0000] Error enabling PHYS CAM already enabled
   CPU 0100 Backtrace:
    S: 0000000032413a20 R: 0000000030021408   .backtrace+0x40
    S: 0000000032413ad0 R: 000000003008427c   .xive2_tima_enable_phys+0x40
    S: 0000000032413b50 R: 0000000030087430   .__xive_reset.constprop.0.isra.0+0x520
    S: 0000000032413c90 R: 0000000030087638   .opal_xive_reset+0x78
    S: 0000000032413d10 R: 00000000300038bc   opal_entry+0x14c
    --- OPAL call token: 0x80 caller R1: 0xc0000000014bbc90 ---
   [    2.273581201,3] XIVE: [CPU 0001] Error enabling PHYS CAM already enabled


Is it a modeling issue ?


Thanks,

C.





