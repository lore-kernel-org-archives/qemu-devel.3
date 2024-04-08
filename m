Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5EEC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtk6D-0001gj-Em; Mon, 08 Apr 2024 04:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtk6B-0001gA-8q
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:11:27 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtk69-0007dF-J0
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:11:26 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6ea1ef7d234so83010a34.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712563883; x=1713168683;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=abxadZhVJiYA+6AGhau2X9pVDfQcCNTlNle+5WdTacE=;
 b=SFUD+AHupIQevrYJvRH1bGaqEqrsksF/x9qzCxfM2phzUda7TCyyQVpaimihPdAwhh
 7dlvsmJT4efCbvOt3m/pNI9of6wH8n3egpi2hUOM7nHk6G+E7oUbUt5awyaPy7PPSF/I
 KibBfLdCsUAMsMxjgF9vd8Ec4izndExVcsCauhUXotK6qU5+LJ5nHqYchux2NkmgzrYw
 AIWIY9k6RLGRDx9E5QID8q3yb/gnFC73ZrrMN+g/Mu2yZ9tjl9LOL5bCUkYJmfrhvt01
 8Z+y8PlKOZ/0ZZ2mRs+5QDC6oY0pm3OBinbCm3Dm7yMZCtrLBxaT+2uVzFaV81/t4zKJ
 aTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712563883; x=1713168683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=abxadZhVJiYA+6AGhau2X9pVDfQcCNTlNle+5WdTacE=;
 b=aPIAvozfcaPA9v8DtRf5F7UA4xau1sP4rjxbm44SISaev9DZC5ywswCG9obgsCyAL7
 SOuzMEPX9CGUYBFSLGovk7q93fDfPHKvuiSnJK+b5zFkwSgtx2JSJsmBZpeEBQ0Vt2Xh
 OMd+0d8f62ter0DVux02pi3yxRbZWelG3Q/hy22tKNiICTheE1xYBGAJr8dNsYjqlMhy
 WPAHy4GXmT2vP4GJGt/ZBuEPmwvyrD+C/ZMg4hw9xCrFYki1favRyoeOojd6f7yXdmyI
 IcQa3GsbtwJj0E8WWmTkJxXWwEhoS/QfHB/qd/QIQnnSjAmx6V2lp7tvHEb0QIb/8GP5
 JzpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ6U5hTXyNAZWAXLZ9oWS+1/+AUIR2wYZcAwzQUXlU+AWebQgI35lc8JKuNXdNgPsyIM2QKH7Clgxd+2cxkUYeORIN4wg=
X-Gm-Message-State: AOJu0YwpcVbaqZIjjFyF/fyIpGdWa8r5hR6OdbFZu6RraGEJui7WswJF
 nQqzEIVNrtbII1zyHmrcnQXEdurwMsOMvAhJxGEySuw1nCHZTG7v5IlbdWBWUa8=
X-Google-Smtp-Source: AGHT+IGVwDf6hLRsoylqtJsg1QpXLkCeyGGmsWCKVE5hsroL2jxyKNw+NVz3/ZCLZcbUIjr7Iy+MDw==
X-Received: by 2002:a05:6808:1788:b0:3c5:f4f2:3eb6 with SMTP id
 bg8-20020a056808178800b003c5f4f23eb6mr2544623oib.32.1712563883675; 
 Mon, 08 Apr 2024 01:11:23 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 k30-20020aa7999e000000b006eb3c2bde43sm5892294pfh.205.2024.04.08.01.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 01:11:23 -0700 (PDT)
Message-ID: <b10e8b4d-b73c-4464-a5e1-883812b40899@daynix.com>
Date: Mon, 8 Apr 2024 17:11:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/20] virtio-net: Do not write hashes to peer buffer
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
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
 <ad692cbf-1963-4051-9b24-50c3599c3f7f@daynix.com>
 <CAOEp5OeNHRdvJ7U2TFs4ZQaNFZHzDg5+_84AfLfb2kDFrfYPGg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5OeNHRdvJ7U2TFs4ZQaNFZHzDg5+_84AfLfb2kDFrfYPGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32a.google.com
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

On 2024/04/08 17:06, Yuri Benditovich wrote:
> On Mon, Apr 8, 2024 at 10:57 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/04/08 16:54, Yuri Benditovich wrote:
>>> On Mon, Apr 8, 2024 at 10:42 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/04/08 16:40, Yuri Benditovich wrote:
>>>>> On Mon, Apr 8, 2024 at 4:30 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2024/04/08 7:09, Yuri Benditovich wrote:
>>>>>>> On Wed, Apr 3, 2024 at 2:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> The peer buffer is qualified with const and not meant to be modified.
>>>>>>>
>>>>>>> IMHO, this buffer is not so 'const' (although the prototype states so),
>>>>>>> it is allocated in net.c
>>>>>>> btw, another procedure in this file also modifies the buffer
>>>>>>> (work_around_broken_dhclient)
>>>>>>
>>>>>> Right but it has a FIXME comment.
>>>>>>
>>>>>>>
>>>>>>>> It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers without
>>>>>>>> virtio-net header support.
>>>>>>>
>>>>>>> Does it mean _this commit_ prevents enabling VIRTIO_NET_F_HASH_REPORT
>>>>>>> for peers without
>>>>>>> virtio-net header support? Where?
>>>>>>
>>>>>> No, but I meant that this patch fixes such a problem.
>>>>>
>>>>> No, it does not. Such a problem does not exist in the master, the
>>>>> hash_report feature
>>>>> is silently dropped in such case:
>>>>> https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L816
>>>>
>>>> Well, silently dropping VIRTIO_NET_F_HASH_REPORT is not different from
>>>> preventing enabling VIRTIO_NET_F_HASH_REPORT, is it?
>>>>
>>> But how is your patch involved in it? Should this line be removed from
>>> the commit message?
>>
>> In the master, VIRTIO_NET_F_HASH_REPORT is silently dropped, but this
>> patch will change to work without dropping it, which is worth to mention.
> After applying this series of patches the VIRTIO_NET_F_HASH_REPORT is
> dropped _the same way_ as in the master

You are right. I forgot that I dropped patch "virtio-net: Do not clear 
VIRTIO_NET_F_HASH_REPORT" with v7. I'll drop the line in the next 
version accordingly. Thanks for pointing out that.

Regards,
Akihiko Odaki

