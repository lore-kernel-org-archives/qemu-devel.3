Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB08C3DA64
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 02:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXAuz-0003K3-0E; Thu, 25 Jul 2024 22:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sXAuv-0003Gs-1f
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 22:42:49 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sXAun-00046M-VQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 22:42:48 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a1fcb611d9so1676502a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1721961754; x=1722566554; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:from:user-agent
 :mime-version:references:from:to:cc:subject:date:message-id:reply-to;
 bh=HQrEHAw2w3X0Rmq4aF4QWcIfl8C9f/lH3/kcA1EBIWg=;
 b=gWoBiQWbK/UJGvdBxQd8DoTQInhZ+nZk5CoGsPmVh/4SZBP/EvXBxZz3BaKHLuBu9e
 CnMG3rAGrL4W3pUr0KcImwnfCXdaIwk3GLJFsmdU5HUw+7iRSHGGO9MTK2fsdv2yZQUT
 pJWTyabXH1f1jvSUn67pUn/VRZaL79FikXEshsLHOjKg8irA0PFjIpB+7Ms2c4yWacRl
 nvpR+BuaVqyv+KFU/PrRTCGkV8DUO4j2HLGdsB633CRYiAusjLaHSE9vZTgT9M7I1FYl
 0P6WwXbQmyaXgVYk3sm75v+cALjfjaCvNH6sL0WwFzAE5MQgVLY/dtu1jSwppf+w8nST
 4sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721961754; x=1722566554;
 h=cc:to:subject:message-id:date:in-reply-to:from:user-agent
 :mime-version:references:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQrEHAw2w3X0Rmq4aF4QWcIfl8C9f/lH3/kcA1EBIWg=;
 b=VnvsqZXlqUzTZyhHSe5zyx8temY/RBBHTHVwJKjWDAvGGx7lrrJ8/toxZvRVG6FQr4
 9GCj31S1KSZrKR3vuZsI3qPKkC2TNL0PWeWrzPAK4k4smG+yD5e7mB2gLBTdjNr84OgZ
 +jxOG/AMI6OZPDO+gI638U0KjrBtac32GcGC9312t8PFKCE3xC6MQYm8uYOnCegLTYpN
 IQ+Lzn+ZiXNr5cPZYPn4xmk5Zoc4MzBJHwxpt+ssTH2Yx1uNKAxdr62pARgEr08VQ/WC
 X2ayZRmsM0P7tyx+K88UhM2JpryL7U95bbycUy/6j/KVeGiBBdZ9SZLfqE/uzWHoTl5z
 tpPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDpc1rYG10kuu23Ksb5t5vqRVmKOvvoU+6lHKTfo7rlop+12rREVtag50OeGS+fE6AqA9Hna2jXgWRStJp8p3y1za87c8=
X-Gm-Message-State: AOJu0YzFhNfEASnFAXtyJxAiEv+tYar35B5/PTRCrMiAQdn69S6TFbaO
 yTXS4J9nzrpF8SkC4s1GbwCBRxm2OE4/Tx20OCqmghd/mjHikQQA83frLkFB9+7Ct5FpuwufS7G
 lpJUuiPFCrvGqVQ/sFCLoH0Prhq6NAq4hBVOdvg==
X-Google-Smtp-Source: AGHT+IG4NCF7k3hSBIHjPllwmXRuNAcRr7LilGH2JRejwIUhwlQuPx0feugtOLs5w1lW1+wipqgSgxEXVsKJ7dySqbE=
X-Received: by 2002:a05:6402:2356:b0:5a1:aa6d:9469 with SMTP id
 4fb4d7f45d1cf-5ac2ca7a600mr3068699a12.38.1721961754352; Thu, 25 Jul 2024
 19:42:34 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jul 2024 19:42:33 -0700
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <ZpT1ZnOjx48_6q0j@cormorant.local>
 <58383d65-83df-4527-81e4-b4d12c409b22@bytedance.com>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
In-Reply-To: <58383d65-83df-4527-81e4-b4d12c409b22@bytedance.com>
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
Date: Thu, 25 Jul 2024 19:42:33 -0700
Message-ID: <CAO5cSZDc9_o4=VZRDFA-CXAkF12r=v95zhNQ0gBM0NHExgkbMw@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] hw/nvme: add reservation protocal command
To: Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="000000000000af779c061e1d7686"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000af779c061e1d7686
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

```
2685 nvme_status->regctl_ds[i].cntlid =3D nvme_ctrl(req)->cntlid;
2686 nvme_status->regctl_ds[i].rkey =3D keys_info->keys[i];
2687 nvme_status->regctl_ds[i].rcsts =3D keys_info->keys[i] =3D=3D
2688 reservation->key ? 1 : 0;
2689 /* hostid is not supported currently */
2670 memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
```

Klaus, I think hostid(2685) is stored locally like cntlid, i
can get cntlid by nvme_ctrl(req)->cntlid, but I can't
find a good way to get the host ID(2670). So I add a comment
"/* hostid is not supported currently */". Could you give me
some advices?

And using spdk as target will not fail, but it will show 0 at hostid
at present. The relevant tests in qemu are as follows=EF=BC=8C

```
root@node1:~# nvme resv-report /dev/nvme0n1
NVME Reservation Report success

NVME Reservation status:

gen : 1
regctl : 1
rtype : 0
ptpls : 0
regctl[0] :
cntlid : 0
rcsts : 0
hostid : 0
rkey : 6
```

On 2024/7/17 17:03, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> Hi,
>
>
> Thank you for your support.
> 1. I will add a guide on how to get a simple test at next patch.
> 2. I think hostid is stored locally like cntlid, but I can't
> find a way to get the host ID. Is it correct to get it through
> qmp_query_uuid() method?
>
> Using spdk as target will not fail, but it will show 0 at hostid
> at present.
>
> On 2024/7/15 18:09, Klaus Jensen wrote:
>> On Jul 12 10:36, Changqi Lu wrote:
>>> Add reservation acquire, reservation register,
>>> reservation release and reservation report commands
>>> in the nvme device layer.
>>>
>>> By introducing these commands, this enables the nvme
>>> device to perform reservation-related tasks, including
>>> querying keys, querying reservation status, registering
>>> reservation keys, initiating and releasing reservations,
>>> as well as clearing and preempting reservations held by
>>> other keys.
>>>
>>> These commands are crucial for management and control of
>>> shared storage resources in a persistent manner.
>>> Signed-off-by: Changqi Lu
>>> Signed-off-by: zhenwei pi
>>> Acked-by: Klaus Jensen
>>> ---
>>> hw/nvme/ctrl.c | 318 +++++++++++++++++++++++++++++++++++++++++++
>>> hw/nvme/nvme.h | 4 +
>>> include/block/nvme.h | 37 +++++
>>> 3 files changed, 359 insertions(+)
>>>
>>
>> This looks good to me, but two comments.
>>
>> 1. Do you have a small guide on how to get a simple test environment
>> up for this?
>>
>> 2. Can you touch on the justification for not supporting the remaining
>> mandatory features required when indicating Reservation support?
>>
>> hw/nvme *does* compromise on mandatory features from time to time
>> when it makes sense, so I'm not saying that not having the log
>> pages, notifications and so on is a deal breaker, I'm just
>> interested in the justification and/or motivation.
>>
>> For instance, I think the SPDK reserve test will fail on this due
>> to lack of Host Identifier Feature support.

--000000000000af779c061e1d7686
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi,
<br>
<br>```
<br>2685    nvme_status-&gt;regctl_ds[i].cntlid =3D nvme_ctrl(req)-&gt;cntl=
id;
<br>2686    nvme_status-&gt;regctl_ds[i].rkey =3D keys_info-&gt;keys[i];
<br>2687    nvme_status-&gt;regctl_ds[i].rcsts =3D keys_info-&gt;keys[i] =
=3D=3D
<br>2688		reservation-&gt;key ? 1 : 0;
<br>2689    /* hostid is not supported currently */
<br>2670    memset(&amp;nvme_status-&gt;regctl_ds[i].hostid, 0, 8);
<br>```
<br>
<br>Klaus, I think hostid(2685) is stored locally like cntlid, i
<br>can get cntlid by nvme_ctrl(req)-&gt;cntlid, but I can&#39;t
<br>find a good way to get the host ID(2670). So I add a comment
<br>&quot;/* hostid is not supported currently */&quot;. Could you give me
<br>some advices?
<br>
<br>And using spdk as target will not fail, but it will show 0 at hostid
<br>at present. The relevant tests in qemu are as follows=EF=BC=8C
<br>
<br>```
<br>root@node1:~# nvme resv-report /dev/nvme0n1
<br>NVME Reservation Report success
<br>
<br>NVME Reservation status:
<br>
<br>gen       : 1
<br>regctl    : 1
<br>rtype     : 0
<br>ptpls     : 0
<br>regctl[0] :
<br>  cntlid  : 0
<br>  rcsts   : 0
<br>  hostid  : 0
<br>  rkey    : 6
<br>```
<br>
<br>On 2024/7/17 17:03, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
<br>&gt; Hi,
<br>&gt;=20
<br>&gt;=20
<br>&gt; Thank you for your support.
<br>&gt; 1. I will add a guide on how to get a simple test at next patch.
<br>&gt; 2. I think hostid is stored locally like cntlid, but I can&#39;t
<br>&gt;    find a way to get the host ID. Is it correct to get it through
<br>&gt;    qmp_query_uuid() method?
<br>&gt;=20
<br>&gt;    Using spdk as target will not fail,=C2=A0but it will show 0 at =
hostid
<br>&gt;    at present.
<br>&gt;=20
<br>&gt; On 2024/7/15 18:09, Klaus Jensen wrote:
<br>&gt;&gt; On Jul 12 10:36, Changqi Lu wrote:
<br>&gt;&gt;&gt; Add reservation acquire, reservation register,
<br>&gt;&gt;&gt; reservation release and reservation report commands
<br>&gt;&gt;&gt; in the nvme device layer.
<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; By introducing these commands, this enables the nvme
<br>&gt;&gt;&gt; device to perform reservation-related tasks, including
<br>&gt;&gt;&gt; querying keys, querying reservation status, registering
<br>&gt;&gt;&gt; reservation keys, initiating and releasing reservations,
<br>&gt;&gt;&gt; as well as clearing and preempting reservations held by
<br>&gt;&gt;&gt; other keys.
<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; These commands are crucial for management and control of
<br>&gt;&gt;&gt; shared storage resources in a persistent manner.
<br>&gt;&gt;&gt; Signed-off-by: Changqi Lu=20
<br>&gt;&gt;&gt; Signed-off-by: zhenwei pi=20
<br>&gt;&gt;&gt; Acked-by: Klaus Jensen=20
<br>&gt;&gt;&gt; ---
<br>&gt;&gt;&gt;  hw/nvme/ctrl.c       | 318 ++++++++++++++++++++++++++++++=
+++++++++++++
<br>&gt;&gt;&gt;  hw/nvme/nvme.h       |   4 +
<br>&gt;&gt;&gt;  include/block/nvme.h |  37 +++++
<br>&gt;&gt;&gt;  3 files changed, 359 insertions(+)
<br>&gt;&gt;&gt;
<br>&gt;&gt;
<br>&gt;&gt; This looks good to me, but two comments.
<br>&gt;&gt;
<br>&gt;&gt;   1. Do you have a small guide on how to get a simple test env=
ironment
<br>&gt;&gt;      up for this?
<br>&gt;&gt;
<br>&gt;&gt;   2. Can you touch on the justification for not supporting the=
 remaining
<br>&gt;&gt;      mandatory features required when indicating Reservation s=
upport?
<br>&gt;&gt;
<br>&gt;&gt;      hw/nvme *does* compromise on mandatory features from time=
 to time
<br>&gt;&gt;      when it makes sense, so I&#39;m not saying that not havin=
g the log
<br>&gt;&gt;      pages, notifications and so on is a deal breaker, I&#39;m=
 just
<br>&gt;&gt;      interested in the justification and/or motivation.
<br>&gt;&gt;
<br>&gt;&gt;      For instance, I think the SPDK reserve test will fail on =
this due
<br>&gt;&gt;      to lack of Host Identifier Feature support.</p>

--000000000000af779c061e1d7686--

