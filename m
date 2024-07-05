Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3DAC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 18:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPng5-0003Mj-TH; Fri, 05 Jul 2024 14:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPnfu-0003JM-9P
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:28:52 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPnfq-0006u7-3L
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:28:49 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3d921528dc4so317044b6e.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720204120; x=1720808920; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6tCTDhXAJL83d802zKbywfrsm1o/ipzHiT8fek1nNLk=;
 b=g4D6tI+R2DYM/0vPbPrxCASO0sZ0wWaKnIyhgQ7Kcq+lqkxd8RBT+kaF6VBevKDVtq
 y1f+bIbKdz3QK3MX1n/51aH5HqsfQ5KDnHBkOV1t8TNcQZjs7H9Sqt4R8U9Z1h6QK6UU
 vF0kt3HkkJRNU8fpeWsOpIhHLInxbKW1qlPiIxdFrehQT9j11Jm34P7J5f0xmoiFquGm
 kmivnW8w5COoP36YmSHE6CGLSFnfd6IGNeKGQDJWKFBpRgzZ5XfVtV25fQ/RMTEira6S
 zXFeQi29tXs7HDpT1Kz2s/NTH8mwujA4YPQBbJdbsgrftUj2R7iVjdRhI7jakdi3c0dy
 xcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720204120; x=1720808920;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6tCTDhXAJL83d802zKbywfrsm1o/ipzHiT8fek1nNLk=;
 b=Aqp5jeyen5ZHA5pIG7rm/dmRqZ2D4oJYM4uPPQDrXg27YXagsECvAttwB1SejsOPnI
 cgjsa8k9IyE2D/Z5O/mP9Utj4poIEnLiU8jzTF3tLKNrPI0fFk7tqLiI7BHbGTmSJpQF
 7oanmdKddeCZ74l9BbUMjVnjhQPzZvadRS9+xbf33aRBkXbqGkbt8/lFj2558rJrvMcl
 1t6QyoBxdop8+AsXkuAMmYVAqeAaCVWP0diu4YOuY/72In5f1MgH80lBHpsjeIgRHiho
 iiSeNSsWA1nShCgmT3vxZdTJBXOX2SpLAZ7ivaGIvC1Je2k6N7rqKWWCfIM/HAK17n7s
 YK0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Hzb0ui3P/hYp22p9X5xovE+uwghpJ6ISdbOlhDXNoelZek+vzLAoI45fQrKuO71170l+MZ0lenxogP/XRatHDGKZiao=
X-Gm-Message-State: AOJu0YyV6y2nleH5Ok0zNBJjHc2w0W3wbHpWLfHceevRBKpZXG6rPc9h
 h4CJ9Av2Tf39uWw12uVJW5a9+//ygbB9jhgTGWVXUmlQWsMlwuygMJzsYX+fxtI=
X-Google-Smtp-Source: AGHT+IFBry7HRKBXE6zr0K5r29iu9xD7a/k8y7Z1A0hap4qp+pRFqxZ2wJfWi43dDFHyxkT9RLTTdQ==
X-Received: by 2002:a05:6808:1312:b0:3d6:a032:f614 with SMTP id
 5614622812f47-3d914ea9b0dmr6019341b6e.50.1720204120264; 
 Fri, 05 Jul 2024 11:28:40 -0700 (PDT)
Received: from smtpclient.apple (ec2-54-152-246-50.compute-1.amazonaws.com.
 [54.152.246.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514984b6sm70643471cf.68.2024.07.05.11.28.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2024 11:28:39 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
Message-Id: <8E9B92DE-5576-48C9-8878-3F750DA116E4@bytedance.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_2C82ACD3-D8A3-48C6-983E-F565A2ACD356"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [External] [PATCH v3 0/4] Implement using Intel QAT to offload
 ZLIB
Date: Fri, 5 Jul 2024 11:28:25 -0700
In-Reply-To: <PH7PR11MB5941064312077F74CE235E45A3DF2@PH7PR11MB5941.namprd11.prod.outlook.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
References: <20240627223445.95096-1-yichen.wang@bytedance.com>
 <ZoRSA4naaje878PK@x1n>
 <PH7PR11MB5941E373F92A78EB5A7E4FCAA3DE2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZobBeWWyf5aHGROj@x1n>
 <PH7PR11MB5941064312077F74CE235E45A3DF2@PH7PR11MB5941.namprd11.prod.outlook.com>
X-Mailer: Apple Mail (2.3774.600.62)
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_2C82ACD3-D8A3-48C6-983E-F565A2ACD356
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jul 5, 2024, at 1:32=E2=80=AFAM, Liu, Yuan1 <yuan1.liu@intel.com> =
wrote:
>=20
>> -----Original Message-----
>> From: Peter Xu <peterx@redhat.com <mailto:peterx@redhat.com>>
>> Sent: Thursday, July 4, 2024 11:36 PM
>> To: Liu, Yuan1 <yuan1.liu@intel.com <mailto:yuan1.liu@intel.com>>
>> Cc: Wang, Yichen <yichen.wang@bytedance.com =
<mailto:yichen.wang@bytedance.com>>; Paolo Bonzini
>> <pbonzini@redhat.com <mailto:pbonzini@redhat.com>>; Daniel P. =
Berrang=C3=A9 <berrange@redhat.com <mailto:berrange@redhat.com>>; =
Eduardo
>> Habkost <eduardo@habkost.net <mailto:eduardo@habkost.net>>; =
Marc-Andr=C3=A9 Lureau
>> <marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com>>; =
Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>>; Philippe
>> Mathieu-Daud=C3=A9 <philmd@linaro.org <mailto:philmd@linaro.org>>; =
Fabiano Rosas <farosas@suse.de <mailto:farosas@suse.de>>; Eric
>> Blake <eblake@redhat.com <mailto:eblake@redhat.com>>; Markus =
Armbruster <armbru@redhat.com <mailto:armbru@redhat.com>>; Laurent
>> Vivier <lvivier@redhat.com <mailto:lvivier@redhat.com>>; =
qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>; Hao Xiang
>> <hao.xiang@linux.dev <mailto:hao.xiang@linux.dev>>; Zou, Nanhai =
<nanhai.zou@intel.com <mailto:nanhai.zou@intel.com>>; Ho-Ren (Jack)
>> Chuang <horenchuang@bytedance.com <mailto:horenchuang@bytedance.com>>
>> Subject: Re: [PATCH v3 0/4] Implement using Intel QAT to offload ZLIB
>>=20
>> On Thu, Jul 04, 2024 at 03:15:51AM +0000, Liu, Yuan1 wrote:
>>>> -----Original Message-----
>>>> From: Peter Xu <peterx@redhat.com>
>>>> Sent: Wednesday, July 3, 2024 3:16 AM
>>>> To: Wang, Yichen <yichen.wang@bytedance.com>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>; Daniel P. Berrang=C3=A9
>>>> <berrange@redhat.com>; Eduardo Habkost <eduardo@habkost.net>; Marc-
>> Andr=C3=A9
>>>> Lureau <marcandre.lureau@redhat.com>; Thomas Huth =
<thuth@redhat.com>;
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>; Fabiano Rosas
>>>> <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus =
Armbruster
>>>> <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu-
>>>> devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
>>>> <yuan1.liu@intel.com>; Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren
>> (Jack)
>>>> Chuang <horenchuang@bytedance.com>
>>>> Subject: Re: [PATCH v3 0/4] Implement using Intel QAT to offload =
ZLIB
>>>>=20
>>>> On Thu, Jun 27, 2024 at 03:34:41PM -0700, Yichen Wang wrote:
>>>>> v3:
>>>>> - Rebase changes on top of master
>>>>> - Merge two patches per Fabiano Rosas's comment
>>>>> - Add versions into comments and documentations
>>>>>=20
>>>>> v2:
>>>>> - Rebase changes on top of recent multifd code changes.
>>>>> - Use QATzip API 'qzMalloc' and 'qzFree' to allocate QAT buffers.
>>>>> - Remove parameter tuning and use QATzip's defaults for better
>>>>>  performance.
>>>>> - Add parameter to enable QAT software fallback.
>>>>>=20
>>>>> v1:
>>>>> https://lists.nongnu.org/archive/html/qemu-devel/2023-
>> 12/msg03761.html
>>>>>=20
>>>>> * Performance
>>>>>=20
>>>>> We present updated performance results. For circumstantial =
reasons,
>> v1
>>>>> presented performance on a low-bandwidth (1Gbps) network.
>>>>>=20
>>>>> Here, we present updated results with a similar setup as before =
but
>> with
>>>>> two main differences:
>>>>>=20
>>>>> 1. Our machines have a ~50Gbps connection, tested using 'iperf3'.
>>>>> 2. We had a bug in our memory allocation causing us to only use =
~1/2
>> of
>>>>> the VM's RAM. Now we properly allocate and fill nearly all of the
>> VM's
>>>>> RAM.
>>>>>=20
>>>>> Thus, the test setup is as follows:
>>>>>=20
>>>>> We perform multifd live migration over TCP using a VM with 64GB
>> memory.
>>>>> We prepare the machine's memory by powering it on, allocating a
>> large
>>>>> amount of memory (60GB) as a single buffer, and filling the buffer
>> with
>>>>> the repeated contents of the Silesia corpus[0]. This is in lieu of =
a
>>>> more
>>>>> realistic memory snapshot, which proved troublesome to acquire.
>>>>>=20
>>>>> We analyze CPU usage by averaging the output of 'top' every second
>>>>> during migration. This is admittedly imprecise, but we feel that =
it
>>>>> accurately portrays the different degrees of CPU usage of varying
>>>>> compression methods.
>>>>>=20
>>>>> We present the latency, throughput, and CPU usage results for all =
of
>> the
>>>>> compression methods, with varying numbers of multifd threads (4, =
8,
>> and
>>>>> 16).
>>>>>=20
>>>>> [0] The Silesia corpus can be accessed here:
>>>>> https://sun.aei.polsl.pl//~sdeor/index.php?page=3Dsilesia
>>>>>=20
>>>>> ** Results
>>>>>=20
>>>>> 4 multifd threads:
>>>>>=20
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |method         |time(sec)      |throughput(mbps)|send =
cpu%|recv
>>>> cpu%|
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |qatzip         | 23.13         | 8749.94        |117.50
>> |186.49
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |zlib           |254.35         |  771.87        |388.20
>> |144.40
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |zstd           | 54.52         | 3442.59        |414.59
>> |149.77
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |none           | 12.45         |43739.60        |159.71
>> |204.96
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>=20
>>>>> 8 multifd threads:
>>>>>=20
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |method         |time(sec)      |throughput(mbps)|send =
cpu%|recv
>>>> cpu%|
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |qatzip         | 16.91         |12306.52        |186.37
>> |391.84
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |zlib           |130.11         | 1508.89        |753.86
>> |289.35
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |zstd           | 27.57         | 6823.23        |786.83
>> |303.80
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |none           | 11.82         |46072.63        |163.74
>> |238.56
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>=20
>>>>> 16 multifd threads:
>>>>>=20
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |method         |time(sec)      |throughput(mbps)|send =
cpu%|recv
>>>> cpu%|
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |qatzip         |18.64          |11044.52        | 573.61
>> |437.65
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |zlib           |66.43          | 2955.79        |1469.68
>> |567.47
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |zstd           |14.17          |13290.66        |1504.08
>> |615.33
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>    |none           |16.82          |32363.26        | 180.74
>> |217.17
>>>> |
>>>>>    =
|---------------|---------------|----------------|---------|----
>> ----
>>>> -|
>>>>>=20
>>>>> ** Observations
>>>>>=20
>>>>> - In general, not using compression outperforms using compression =
in
>> a
>>>>>  non-network-bound environment.
>>>>> - 'qatzip' outperforms other compression workers with 4 and 8
>> workers,
>>>>>  achieving a ~91% latency reduction over 'zlib' with 4 workers, =
and
>> a
>>>>> ~58% latency reduction over 'zstd' with 4 workers.
>>>>> - 'qatzip' maintains comparable performance with 'zstd' at 16
>> workers,
>>>>>  showing a ~32% increase in latency. This performance difference
>>>>> becomes more noticeable with more workers, as CPU compression is
>> highly
>>>>> parallelizable.
>>>>> - 'qatzip' compression uses considerably less CPU than other
>> compression
>>>>>  methods. At 8 workers, 'qatzip' demonstrates a ~75% reduction in
>>>>> compression CPU usage compared to 'zstd' and 'zlib'.
>>>>> - 'qatzip' decompression CPU usage is less impressive, and is even
>>>>>  slightly worse than 'zstd' and 'zlib' CPU usage at 4 and 16
>> workers.
>>>>=20
>>>> Thanks for the results update.
>>>>=20
>>>> It looks like the docs/migration/ file is still missing.  It'll be
>> great
>>>> to
>>>> have it in the next version or separately.
>>>>=20
>>>> So how it compares with QPL (which got merged already)?  They at =
least
>>>> look
>>>> like both supported on an Intel platform, so an user whoever wants =
to
>>>> compress the RAM could start to look at both.  I'm utterly confused =
on
>> why
>>>> Intel provides these two similar compressors.  It would be great to
>> have
>>>> some answer and perhaps put into the doc.
>>=20
>> Yuan,
>>=20
>>>=20
>>> I would like to explain some of the reasons why we want to merge the
>>> two QAT and IAA solutions into the community.
>>=20
>> Yes, these are very helpful information.  Please consider putting =
them
>> into
>> the cover letter if there's a repost, and perhaps also in the doc/ =
files.
>>=20
>>>=20
>>> 1. Although Intel Xeon Sapphire Rapids supports both QAT and IAA,
>> different
>>>   SKUs support different numbers of QAT and IAA, so some users do =
not
>> have
>>>   both QAT and IAA at the same time.
>>>=20
>>> 2. QAT products include PCIe cards, which are compatible with older =
Xeon
>>>   products and other non-Xeon products. And some users have already
>> used QAT
>>>   cards to accelerate live migration.
>>=20
>> Ah, this makes some sense to me.
>>=20
>> So a previous question always haunted me, where I wondered why an =
user who
>> bought all these fancy and expensive processors with QAT, would still =
like
>> to not invest on a better network of 50G or more, but stick with 10Gs
>> ancient NICs and switches.
>>=20
>> So what you're saying is logically in some old clusters with old =
chips and
>> old network solutions, it's possible that user buys these PCIe cards
>> separately so it may help with that old infra migrate VMs faster.  Is =
that
>> the case?
>=20
> Yes, users do not add a QAT card just for live migration. Users mainly =
use=20
> QAT-SRIOV technology to help cloud users offload compression and =
encryption.
>=20
>> If so, we may still want some numbers showing how this performs in a
>> network-limited environment, and how that helps users to migrate.  =
Sorry
>> if
>> there's some back-and-forth requirement asking for these numbers, but =
I
>> think these are still important information when an user would like =
to
>> decide whether to use these features.  Again, put that into docs/ if
>> proper
>> would be nice too.
>=20
> Yes, I will provide some performance data at some specific=20
> bandwidths(100Mbps/1Gbps/10Gbps). And add documentation to explain=20
> the advantages of using QAT=20
Just want to add some information here. So in ByteDance, the current =
generation server is quipped with 2*100Gb NIC. We reserve 10Gbps for =
control plane purposes which includes live migration here. So it is not =
about we are using =E2=80=9Cgood network=E2=80=9D, it is about not =
normal to use full bandwidth for control plane purposes. Hence we do =
have a requirements for QAT/IAA in these cases.
>>>=20
>>> 3. In addition to compression, QAT and IAA also support various =
other
>> features
>>>   to better serve different workloads. Here is an introduction to =
the
>> accelerators,
>>>   including usage scenarios of QAT and IAA.
>>>   https://www.intel.com/content/dam/www/central-
>> =
libraries/us/en/documents/2022-12/storage-engines-4th-gen-xeon-brief.pdf
>>=20
>> Thanks for the link.
>>=20
>> However this doesn't look like a reason to support it in migration?  =
It
>> needs to help migration in some form or another, no matter how many
>> features it provides.. since migration may not consume them.
>>=20
>> Two major (but pure..) questions:
>>=20
>>  1) Why high cpu usage?
>>=20
>>     I raised this question below [1] too but I didn't yet get an =
answer.
>>     Ror 8-chan multifd, it's ~390% (QAT) v.s. ~240% (nocomp), even if
>>     46Gbps bw for the latter... so when throttled it will be even =
lower?
>>=20
>>     The paper you provided above has this upfront:
>>=20
>>        When a CPU can offload storage functions to built-in =
accelerators,
>>        it frees up cores for business-critical workloads...
>>=20
>>     Isn't that a major feature to be able to "offload" things?  Why =
cpu
>>     isn't freed even if the offload happened?
>=20
> Yes, it doesn't make sense, I will check this.
>=20
>>  2) TLS?
>>=20
>>     I think I asked before, I apologize if any of you've already =
answered
>>     and if I forgot.. but have any of you looked into offload TLS
>> (instead
>>     of compression) with the QATs?
>=20
> I'm sorry for not responding to the previous question about TLS. QAT =
has many=20
> related success cases (for example, OpenSSL).=20
> =
https://www.intel.com/content/dam/www/public/us/en/documents/solution-brie=
fs/accelerating-openssl-brief.pdf
>=20
> I will send a separate RFC or patch about this part because the =
software stacks of QAT=20
> compression and encryption are independent, so we discuss them =
separately.
>=20
>> Thanks,
>>=20
>>>=20
>>> For users who have both QAT and IAA, we recommend the following for
>> choosing a
>>> live migration solution:
>>>=20
>>> 1. If the number of QAT devices is equal to or greater than the =
number
>> of IAA devices
>>>   and network bandwidth is limited, it is recommended to use the
>> QATZip(QAT) solution.
>>>=20
>>> 2. In other scenarios, the QPL (IAA) solution can be used first.
>>>=20
>>>> I am honestly curious too on whether are you planning to use it in
>>>> production.  It looks like if the network resources are rich, =
no-comp
>> is
>>>> mostly always better than qatzip, no matter on total migration time =
or
>> cpu
>>>> consumption.  I'm pretty surprised that it'll take that much =
resources
>>>> even
>>>> if the work should have been offloaded to the QAT chips iiuc.
>>=20
>> [1]
>>=20
>>>>=20
>>>> I think it may not be a problem to merge this series even if it
>> performs
>>>> slower at some criterias.. but I think we may still want to know =
when
>> this
>>>> should be used, or the good reason this should be merged (if it's =
not
>>>> about
>>>> it outperforms others).
>>>>=20
>>>> Thanks,
>>>>=20
>>>>>=20
>>>>>=20
>>>>> Bryan Zhang (4):
>>>>>  meson: Introduce 'qatzip' feature to the build system
>>>>>  migration: Add migration parameters for QATzip
>>>>>  migration: Introduce 'qatzip' compression method
>>>>>  tests/migration: Add integration test for 'qatzip' compression
>> method
>>>>>=20
>>>>> hw/core/qdev-properties-system.c |   6 +-
>>>>> meson.build                      |  10 +
>>>>> meson_options.txt                |   2 +
>>>>> migration/meson.build            |   1 +
>>>>> migration/migration-hmp-cmds.c   |   8 +
>>>>> migration/multifd-qatzip.c       | 382
>> +++++++++++++++++++++++++++++++
>>>>> migration/multifd.h              |   1 +
>>>>> migration/options.c              |  57 +++++
>>>>> migration/options.h              |   2 +
>>>>> qapi/migration.json              |  38 +++
>>>>> scripts/meson-buildoptions.sh    |   6 +
>>>>> tests/qtest/meson.build          |   4 +
>>>>> tests/qtest/migration-test.c     |  35 +++
>>>>> 13 files changed, 551 insertions(+), 1 deletion(-)
>>>>> create mode 100644 migration/multifd-qatzip.c
>>>>>=20
>>>>> --
>>>>> Yichen Wang
>>>>>=20
>>>>=20
>>>> --
>>>> Peter Xu
>>>=20
>>=20
>> --
>> Peter Xu


--Apple-Mail=_2C82ACD3-D8A3-48C6-983E-F565A2ACD356
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On Jul 5, 2024, at 1:32=E2=80=AFAM, Liu, Yuan1 =
&lt;yuan1.liu@intel.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta =
charset=3D"UTF-8"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">-----Original Message-----<br>From: Peter Xu =
&lt;<a =
href=3D"mailto:peterx@redhat.com">peterx@redhat.com</a>&gt;<br>Sent: =
Thursday, July 4, 2024 11:36 PM<br>To: Liu, Yuan1 &lt;<a =
href=3D"mailto:yuan1.liu@intel.com">yuan1.liu@intel.com</a>&gt;<br>Cc: =
Wang, Yichen &lt;<a =
href=3D"mailto:yichen.wang@bytedance.com">yichen.wang@bytedance.com</a>&gt=
;; Paolo Bonzini<br>&lt;<a =
href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;; Daniel =
P. Berrang=C3=A9 &lt;<a =
href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt;; =
Eduardo<br>Habkost &lt;<a =
href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net</a>&gt;; =
Marc-Andr=C3=A9 Lureau<br>&lt;<a =
href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a=
>&gt;; Thomas Huth &lt;<a =
href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt;; =
Philippe<br>Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt;; Fabiano =
Rosas &lt;<a href=3D"mailto:farosas@suse.de">farosas@suse.de</a>&gt;; =
Eric<br>Blake &lt;<a =
href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt;; Markus =
Armbruster &lt;<a =
href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt;; =
Laurent<br>Vivier &lt;<a =
href=3D"mailto:lvivier@redhat.com">lvivier@redhat.com</a>&gt;;<span =
class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>; Hao =
Xiang<br>&lt;<a =
href=3D"mailto:hao.xiang@linux.dev">hao.xiang@linux.dev</a>&gt;; Zou, =
Nanhai &lt;<a =
href=3D"mailto:nanhai.zou@intel.com">nanhai.zou@intel.com</a>&gt;; =
Ho-Ren (Jack)<br>Chuang &lt;<a =
href=3D"mailto:horenchuang@bytedance.com">horenchuang@bytedance.com</a>&gt=
;<br>Subject: Re: [PATCH v3 0/4] Implement using Intel QAT to offload =
ZLIB<br><br>On Thu, Jul 04, 2024 at 03:15:51AM +0000, Liu, Yuan1 =
wrote:<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">-----Original Message-----<br>From: Peter Xu =
&lt;peterx@redhat.com&gt;<br>Sent: Wednesday, July 3, 2024 3:16 =
AM<br>To: Wang, Yichen &lt;yichen.wang@bytedance.com&gt;<br>Cc: Paolo =
Bonzini &lt;pbonzini@redhat.com&gt;; Daniel P. =
Berrang=C3=A9<br>&lt;berrange@redhat.com&gt;; Eduardo Habkost =
&lt;eduardo@habkost.net&gt;; =
Marc-<br></blockquote></blockquote>Andr=C3=A9<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">Lureau =
&lt;marcandre.lureau@redhat.com&gt;; Thomas Huth =
&lt;thuth@redhat.com&gt;;<br>Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@linaro.org&gt;; Fabiano Rosas<br>&lt;farosas@suse.de&gt;; =
Eric Blake &lt;eblake@redhat.com&gt;; Markus =
Armbruster<br>&lt;armbru@redhat.com&gt;; Laurent Vivier =
&lt;lvivier@redhat.com&gt;; qemu-<br>devel@nongnu.org; Hao Xiang =
&lt;hao.xiang@linux.dev&gt;; Liu, Yuan1<br>&lt;yuan1.liu@intel.com&gt;; =
Zou, Nanhai &lt;nanhai.zou@intel.com&gt;; =
Ho-Ren<br></blockquote></blockquote>(Jack)<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">Chuang =
&lt;horenchuang@bytedance.com&gt;<br>Subject: Re: [PATCH v3 0/4] =
Implement using Intel QAT to offload ZLIB<br><br>On Thu, Jun 27, 2024 at =
03:34:41PM -0700, Yichen Wang wrote:<br><blockquote type=3D"cite">v3:<br>-=
 Rebase changes on top of master<br>- Merge two patches per Fabiano =
Rosas's comment<br>- Add versions into comments and =
documentations<br><br>v2:<br>- Rebase changes on top of recent multifd =
code changes.<br>- Use QATzip API 'qzMalloc' and 'qzFree' to allocate =
QAT buffers.<br>- Remove parameter tuning and use QATzip's defaults for =
better<br>&nbsp;performance.<br>- Add parameter to enable QAT software =
fallback.<br><br>v1:<br>https://lists.nongnu.org/archive/html/qemu-devel/2=
023-<br></blockquote></blockquote></blockquote>12/msg03761.html<br><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite"><br>* Performance<br><br>We present updated performance =
results. For circumstantial =
reasons,<br></blockquote></blockquote></blockquote>v1<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">presented performance on a low-bandwidth (1Gbps) =
network.<br><br>Here, we present updated results with a similar setup as =
before but<br></blockquote></blockquote></blockquote>with<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">two =
main differences:<br><br>1. Our machines have a ~50Gbps connection, =
tested using 'iperf3'.<br>2. We had a bug in our memory allocation =
causing us to only use =
~1/2<br></blockquote></blockquote></blockquote>of<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">the =
VM's RAM. Now we properly allocate and fill nearly all of =
the<br></blockquote></blockquote></blockquote>VM's<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">RAM.<br><br>Thus, the test setup is as follows:<br><br>We =
perform multifd live migration over TCP using a VM with =
64GB<br></blockquote></blockquote></blockquote>memory.<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">We =
prepare the machine's memory by powering it on, allocating =
a<br></blockquote></blockquote></blockquote>large<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">amount =
of memory (60GB) as a single buffer, and filling the =
buffer<br></blockquote></blockquote></blockquote>with<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">the =
repeated contents of the Silesia corpus[0]. This is in lieu of =
a<br></blockquote>more<br><blockquote type=3D"cite">realistic memory =
snapshot, which proved troublesome to acquire.<br><br>We analyze CPU =
usage by averaging the output of 'top' every second<br>during migration. =
This is admittedly imprecise, but we feel that it<br>accurately portrays =
the different degrees of CPU usage of varying<br>compression =
methods.<br><br>We present the latency, throughput, and CPU usage =
results for all =
of<br></blockquote></blockquote></blockquote>the<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">compression methods, with varying numbers of multifd =
threads (4, =
8,<br></blockquote></blockquote></blockquote>and<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">16).<br><br>[0] The Silesia corpus can be accessed =
here:<br>https://sun.aei.polsl.pl//~sdeor/index.php?page=3Dsilesia<br><br>=
** Results<br><br>4 multifd =
threads:<br><br>&nbsp;&nbsp;&nbsp;|---------------|---------------|-------=
---------|---------|----<br></blockquote></blockquote></blockquote>----<br=
><blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|method =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|time(sec) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|throughput(mbps)|send =
cpu%|recv<br></blockquote>cpu%|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|qatzip =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 23.13 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 8749.94 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|117.50<br></blockquote></blockq=
uote></blockquote>|186.49<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|zlib =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|254.35 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;771.87 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|388.20<br></blockquote></blockq=
uote></blockquote>|144.40<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|zstd =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 54.52 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 3442.59 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|414.59<br></blockquote></blockq=
uote></blockquote>|149.77<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|none =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 12.45 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|43739.60 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|159.71<br></blockquote></blockq=
uote></blockquote>|204.96<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite"><br>8 multifd =
threads:<br><br>&nbsp;&nbsp;&nbsp;|---------------|---------------|-------=
---------|---------|----<br></blockquote></blockquote></blockquote>----<br=
><blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|method =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|time(sec) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|throughput(mbps)|send =
cpu%|recv<br></blockquote>cpu%|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|qatzip =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 16.91 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|12306.52 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|186.37<br></blockquote></blockq=
uote></blockquote>|391.84<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|zlib =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|130.11 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 1508.89 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|753.86<br></blockquote></blockq=
uote></blockquote>|289.35<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|zstd =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 27.57 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 6823.23 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|786.83<br></blockquote></blockq=
uote></blockquote>|303.80<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|none =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 11.82 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|46072.63 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|163.74<br></blockquote></blockq=
uote></blockquote>|238.56<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite"><br>16 multifd =
threads:<br><br>&nbsp;&nbsp;&nbsp;|---------------|---------------|-------=
---------|---------|----<br></blockquote></blockquote></blockquote>----<br=
><blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|method =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|time(sec) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|throughput(mbps)|send =
cpu%|recv<br></blockquote>cpu%|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|qatzip =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|18.64 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|11044.52 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
573.61<br></blockquote></blockquote></blockquote>|437.65<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|zlib =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|66.43 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 2955.79 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|1469.68<br></blockquote></block=
quote></blockquote>|567.47<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|zstd =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|14.17 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|13290.66 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|1504.08<br></blockquote></block=
quote></blockquote>|615.33<br><blockquote type=3D"cite"><blockquote =
type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|none =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|16.82 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|32363.26 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
180.74<br></blockquote></blockquote></blockquote>|217.17<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">|<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;|---------------|---------------|---------=
-------|---------|----<br></blockquote></blockquote></blockquote>----<br><=
blockquote type=3D"cite"><blockquote type=3D"cite">-|<br><blockquote =
type=3D"cite"><br>** Observations<br><br>- In general, not using =
compression outperforms using compression =
in<br></blockquote></blockquote></blockquote>a<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">&nbsp;non-network-bound environment.<br>- 'qatzip' =
outperforms other compression workers with 4 and =
8<br></blockquote></blockquote></blockquote>workers,<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">&nbsp;achieving a ~91% latency reduction over 'zlib' with =
4 workers, =
and<br></blockquote></blockquote></blockquote>a<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">~58% =
latency reduction over 'zstd' with 4 workers.<br>- 'qatzip' maintains =
comparable performance with 'zstd' at =
16<br></blockquote></blockquote></blockquote>workers,<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">&nbsp;showing a ~32% increase in latency. This performance =
difference<br>becomes more noticeable with more workers, as CPU =
compression =
is<br></blockquote></blockquote></blockquote>highly<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">parallelizable.<br>- 'qatzip' compression uses =
considerably less CPU than =
other<br></blockquote></blockquote></blockquote>compression<br><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">&nbsp;methods. At 8 workers, 'qatzip' demonstrates a ~75% =
reduction in<br>compression CPU usage compared to 'zstd' and =
'zlib'.<br>- 'qatzip' decompression CPU usage is less impressive, and is =
even<br>&nbsp;slightly worse than 'zstd' and 'zlib' CPU usage at 4 and =
16<br></blockquote></blockquote></blockquote>workers.<br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><br>Thanks for the results =
update.<br><br>It looks like the docs/migration/ file is still missing. =
&nbsp;It'll be<br></blockquote></blockquote>great<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">to<br>have it in the next =
version or separately.<br><br>So how it compares with QPL (which got =
merged already)? &nbsp;They at least<br>look<br>like both supported on =
an Intel platform, so an user whoever wants to<br>compress the RAM could =
start to look at both. &nbsp;I'm utterly confused =
on<br></blockquote></blockquote>why<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">Intel provides these two similar =
compressors. &nbsp;It would be great =
to<br></blockquote></blockquote>have<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">some answer and perhaps put into =
the doc.<br></blockquote></blockquote><br>Yuan,<br><br><blockquote =
type=3D"cite"><br>I would like to explain some of the reasons why we =
want to merge the<br>two QAT and IAA solutions into the =
community.<br></blockquote><br>Yes, these are very helpful information. =
&nbsp;Please consider putting them<br>into<br>the cover letter if =
there's a repost, and perhaps also in the doc/ files.<br><br><blockquote =
type=3D"cite"><br>1. Although Intel Xeon Sapphire Rapids supports both =
QAT and IAA,<br></blockquote>different<br><blockquote =
type=3D"cite">&nbsp;&nbsp;SKUs support different numbers of QAT and IAA, =
so some users do not<br></blockquote>have<br><blockquote =
type=3D"cite">&nbsp;&nbsp;both QAT and IAA at the same time.<br><br>2. =
QAT products include PCIe cards, which are compatible with older =
Xeon<br>&nbsp;&nbsp;products and other non-Xeon products. And some users =
have already<br></blockquote>used QAT<br><blockquote =
type=3D"cite">&nbsp;&nbsp;cards to accelerate live =
migration.<br></blockquote><br>Ah, this makes some sense to =
me.<br><br>So a previous question always haunted me, where I wondered =
why an user who<br>bought all these fancy and expensive processors with =
QAT, would still like<br>to not invest on a better network of 50G or =
more, but stick with 10Gs<br>ancient NICs and switches.<br><br>So what =
you're saying is logically in some old clusters with old chips =
and<br>old network solutions, it's possible that user buys these PCIe =
cards<br>separately so it may help with that old infra migrate VMs =
faster. &nbsp;Is that<br>the case?<br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Yes, users do not add a QAT card just for =
live migration. Users mainly use<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">QAT-SRIOV technology to help cloud users =
offload compression and encryption.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">If so, we may still want some numbers showing =
how this performs in a<br>network-limited environment, and how that =
helps users to migrate. &nbsp;Sorry<br>if<br>there's some back-and-forth =
requirement asking for these numbers, but I<br>think these are still =
important information when an user would like to<br>decide whether to =
use these features. &nbsp;Again, put that into docs/ =
if<br>proper<br>would be nice too.<br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Yes, I will provide some performance data =
at some specific<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">bandwidths(100Mbps/1Gbps/10Gbps). And add =
documentation to explain<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">the advantages of using QAT<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>Just want to add some information here. So in =
ByteDance, the current generation server is quipped with 2*100Gb NIC. We =
reserve 10Gbps for control plane purposes which includes live migration =
here. So it is not about we are using =E2=80=9Cgood network=E2=80=9D, it =
is about not normal to use full bandwidth for control plane purposes. =
Hence we do have a requirements for QAT/IAA in these =
cases.<br><blockquote type=3D"cite"><div><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite"><br>3. In addition to compression, QAT and IAA also =
support various other<br></blockquote>features<br><blockquote =
type=3D"cite">&nbsp;&nbsp;to better serve different workloads. Here is =
an introduction to the<br></blockquote>accelerators,<br><blockquote =
type=3D"cite">&nbsp;&nbsp;including usage scenarios of QAT and =
IAA.<br>&nbsp;&nbsp;https://www.intel.com/content/dam/www/central-<br></bl=
ockquote>libraries/us/en/documents/2022-12/storage-engines-4th-gen-xeon-br=
ief.pdf<br><br>Thanks for the link.<br><br>However this doesn't look =
like a reason to support it in migration? &nbsp;It<br>needs to help =
migration in some form or another, no matter how many<br>features it =
provides.. since migration may not consume them.<br><br>Two major (but =
pure..) questions:<br><br>&nbsp;1) Why high cpu =
usage?<br><br>&nbsp;&nbsp;&nbsp;&nbsp;I raised this question below [1] =
too but I didn't yet get an answer.<br>&nbsp;&nbsp;&nbsp;&nbsp;Ror =
8-chan multifd, it's ~390% (QAT) v.s. ~240% (nocomp), even =
if<br>&nbsp;&nbsp;&nbsp;&nbsp;46Gbps bw for the latter... so when =
throttled it will be even lower?<br><br>&nbsp;&nbsp;&nbsp;&nbsp;The =
paper you provided above has this =
upfront:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When a CPU can =
offload storage functions to built-in =
accelerators,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;it frees up =
cores for business-critical =
workloads...<br><br>&nbsp;&nbsp;&nbsp;&nbsp;Isn't that a major feature =
to be able to "offload" things? &nbsp;Why =
cpu<br>&nbsp;&nbsp;&nbsp;&nbsp;isn't freed even if the offload =
happened?<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Yes, it =
doesn't make sense, I will check this.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">&nbsp;2) TLS?<br><br>&nbsp;&nbsp;&nbsp;&nbsp;I =
think I asked before, I apologize if any of you've already =
answered<br>&nbsp;&nbsp;&nbsp;&nbsp;and if I forgot.. but have any of =
you looked into offload TLS<br>(instead<br>&nbsp;&nbsp;&nbsp;&nbsp;of =
compression) with the QATs?<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">I'm =
sorry for not responding to the previous question about TLS. QAT has =
many<span class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">related success cases (for example, =
OpenSSL).<span class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><a =
href=3D"https://www.intel.com/content/dam/www/public/us/en/documents/solut=
ion-briefs/accelerating-openssl-brief.pdf" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">https://www.intel.com/content/dam/www/public/us/en/documents/solutio=
n-briefs/accelerating-openssl-brief.pdf</a><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">I will =
send a separate RFC or patch about this part because the software stacks =
of QAT<span class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">compression and encryption are independent, =
so we discuss them separately.</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Thanks,<br><br><blockquote type=3D"cite"><br>For =
users who have both QAT and IAA, we recommend the following =
for<br></blockquote>choosing a<br><blockquote type=3D"cite">live =
migration solution:<br><br>1. If the number of QAT devices is equal to =
or greater than the number<br></blockquote>of IAA devices<br><blockquote =
type=3D"cite">&nbsp;&nbsp;and network bandwidth is limited, it is =
recommended to use the<br></blockquote>QATZip(QAT) =
solution.<br><blockquote type=3D"cite"><br>2. In other scenarios, the =
QPL (IAA) solution can be used first.<br><br><blockquote type=3D"cite">I =
am honestly curious too on whether are you planning to use it =
in<br>production. &nbsp;It looks like if the network resources are rich, =
no-comp<br></blockquote></blockquote>is<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">mostly always better than =
qatzip, no matter on total migration time =
or<br></blockquote></blockquote>cpu<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">consumption. &nbsp;I'm pretty =
surprised that it'll take that much resources<br>even<br>if the work =
should have been offloaded to the QAT chips =
iiuc.<br></blockquote></blockquote><br>[1]<br><br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><br>I think it may not be a =
problem to merge this series even if =
it<br></blockquote></blockquote>performs<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">slower at some criterias.. but I =
think we may still want to know =
when<br></blockquote></blockquote>this<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">should be used, or the good =
reason this should be merged (if it's not<br>about<br>it outperforms =
others).<br><br>Thanks,<br><br><blockquote type=3D"cite"><br><br>Bryan =
Zhang (4):<br>&nbsp;meson: Introduce 'qatzip' feature to the build =
system<br>&nbsp;migration: Add migration parameters for =
QATzip<br>&nbsp;migration: Introduce 'qatzip' compression =
method<br>&nbsp;tests/migration: Add integration test for 'qatzip' =
compression<br></blockquote></blockquote></blockquote>method<br><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite"><br>hw/core/qdev-properties-system.c | &nbsp;&nbsp;6 =
+-<br>meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;10 =
+<br>meson_options.txt =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +<br>migration/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;1 +<br>migration/migration-hmp-cmds.c &nbsp;&nbsp;| =
&nbsp;&nbsp;8 +<br>migration/multifd-qatzip.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
382<br></blockquote></blockquote></blockquote>++++++++++++++++++++++++++++=
+++<br><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite">migration/multifd.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;&nbsp;1 +<br>migration/options.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;57 +++++<br>migration/options.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;&nbsp;2 +<br>qapi/migration.json =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;38 +++<br>scripts/meson-buildoptions.sh &nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;6 +<br>tests/qtest/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;4 =
+<br>tests/qtest/migration-test.c &nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;35 =
+++<br>13 files changed, 551 insertions(+), 1 deletion(-)<br>create mode =
100644 migration/multifd-qatzip.c<br><br>--<br>Yichen =
Wang<br><br></blockquote><br>--<br>Peter =
Xu<br></blockquote><br></blockquote><br>--<br>Peter =
Xu</blockquote></div></blockquote></div><br></body></html>=

--Apple-Mail=_2C82ACD3-D8A3-48C6-983E-F565A2ACD356--

