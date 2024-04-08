Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEABCD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjsa-00052Y-FM; Mon, 08 Apr 2024 03:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtjsZ-00052P-L8
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:57:23 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtjsY-0005BB-07
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:57:23 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2a2d82537efso2176255a91.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712563040; x=1713167840;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qaHJPs8/hmT0asebxrkdkG04cUvbPKIz/HeZMSEv+tI=;
 b=XG8GFVQKq70sEm468q1O+Sa7sBcjDZykPU86fjwiTmQaytolOxEOdDI66zpsOOJVeb
 K3z41EpfyILgCj7U52myPHlpLeU26g/Undq5CzP3xwwusiQD792e1sdIarLNnWGvYfEX
 ScCG0syoxeOi4sKKpZbVk3QlG2pVa4VvD+GKmUkQGK+xsHoFkBbdbYFz9SpyrAdB+rxp
 cdmZE8Ss9/pnI5X8JyfuUnMIz/sKdl54Ec1Bfndcb32bGE2Ay2Fv+Dsv4RvENtYO9PrF
 WDZbdHkcfdfhjfPpyDt/uvwRiLmryrU4jwKUMaTciLI52BxI1OgFOBVxoxoL8h3C70Ka
 /JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712563040; x=1713167840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qaHJPs8/hmT0asebxrkdkG04cUvbPKIz/HeZMSEv+tI=;
 b=g3Slh7g+fzD+pHEM9KZ69jw3nDF979mNogcxlHUf71PnRlWI8ygKoSFdoIpbwfJUiK
 R75leJ8rfYzvkx41xVqXAbMURXFiii3AC4JVxg3orVhEd1SIoZcVhQjb8duajzp5l906
 ruZdCl140Nn3ofhvXa+XQhSq+MJsDG8LQCYA5DsrLlrTJWehNqv21dPG9Jgm0hTK0D5H
 H8dDBts3CqwZhJWxYRBtRciDZGACUc9jjDSPQgsVRZecmMwyAPHl4mktwVu9EsRz2q3r
 eC5nnV58ONw94l40i1huqIJVf3HbqPEv9LaUzWV4HbRDSLXgAHYdppmf6vOnfhYp5QYY
 zIig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD2rrONE4YAwG+WwzlLJvqcGNjYmSDeRGgC8gdun2cXn+xe28fKbZ0w3LYPsE/gDdL3x2hGjUfm5z5gwjpJ+qyIDXmxYQ=
X-Gm-Message-State: AOJu0YzS5dFvftlrx4ngiqD8hxflPjYs2oVKndU6uxhjzAwKKlDZTV7B
 peyZBUYOCkw9VYcoHHIUr/L/QCENGMyatMZnZAn+VboMeZUhOF0q1WLJUNpbH7Y=
X-Google-Smtp-Source: AGHT+IGRZZ+RPH2x4OGGDRTbN1IflpoV+ypsEx/Z2fXYj3nnM7+TxnmSZWNlwGIbSgHZZ+aQKcVTNA==
X-Received: by 2002:a17:90a:d907:b0:2a4:739a:23c4 with SMTP id
 c7-20020a17090ad90700b002a4739a23c4mr7503697pjv.35.1712563040460; 
 Mon, 08 Apr 2024 00:57:20 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 mm15-20020a17090b358f00b002a058af5e12sm7682191pjb.12.2024.04.08.00.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 00:57:20 -0700 (PDT)
Message-ID: <ad692cbf-1963-4051-9b24-50c3599c3f7f@daynix.com>
Date: Mon, 8 Apr 2024 16:57:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/20] virtio-net: Do not write hashes to peer buffer
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-16-c6d87e69d38b@daynix.com>
 <CAOEp5Od=KUTHnikVBA7iWfdFPJ=T7hbJrSu4zwCiB_Q1P-Sz+Q@mail.gmail.com>
 <8010b335-4b46-456e-bf6e-c191cdc34964@daynix.com>
 <CAOEp5OeHJR=EeZ=yLovSD9vUPt-zRNKLo2k_fNZPP3W-eX4Fiw@mail.gmail.com>
 <d2213191-9b16-4716-a311-97751ba670ad@daynix.com>
 <CAOEp5OcNkBr4aRzjFQhgsOTmMmO3aPQH2tQLvGcs__=jUVa5sA@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5OcNkBr4aRzjFQhgsOTmMmO3aPQH2tQLvGcs__=jUVa5sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/04/08 16:54, Yuri Benditovich wrote:
> On Mon, Apr 8, 2024 at 10:42 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/04/08 16:40, Yuri Benditovich wrote:
>>> On Mon, Apr 8, 2024 at 4:30 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/04/08 7:09, Yuri Benditovich wrote:
>>>>> On Wed, Apr 3, 2024 at 2:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> The peer buffer is qualified with const and not meant to be modified.
>>>>>
>>>>> IMHO, this buffer is not so 'const' (although the prototype states so),
>>>>> it is allocated in net.c
>>>>> btw, another procedure in this file also modifies the buffer
>>>>> (work_around_broken_dhclient)
>>>>
>>>> Right but it has a FIXME comment.
>>>>
>>>>>
>>>>>> It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers without
>>>>>> virtio-net header support.
>>>>>
>>>>> Does it mean _this commit_ prevents enabling VIRTIO_NET_F_HASH_REPORT
>>>>> for peers without
>>>>> virtio-net header support? Where?
>>>>
>>>> No, but I meant that this patch fixes such a problem.
>>>
>>> No, it does not. Such a problem does not exist in the master, the
>>> hash_report feature
>>> is silently dropped in such case:
>>> https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L816
>>
>> Well, silently dropping VIRTIO_NET_F_HASH_REPORT is not different from
>> preventing enabling VIRTIO_NET_F_HASH_REPORT, is it?
>>
> But how is your patch involved in it? Should this line be removed from
> the commit message?

In the master, VIRTIO_NET_F_HASH_REPORT is silently dropped, but this 
patch will change to work without dropping it, which is worth to mention.

Regards,
Akihiko Odaki

