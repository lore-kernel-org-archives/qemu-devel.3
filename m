Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D4ACD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjec-00012P-GR; Mon, 08 Apr 2024 03:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtjea-00011r-J8
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:42:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtjeY-0002ls-Rn
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:42:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso29297595ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712562173; x=1713166973;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uLk8OVVlz8f3D/hwm9nTtvWq67frGqJMheqp7UEeozo=;
 b=QUve9royEMgs8fKpv1Eklr0xyPrB3XTZOAC5Cq1RgYnk+dvsUla/tC4UWHGAcdMjvp
 fmJ6OYZGgqH3LNSgprL79xbaycbM7L7e9lg5zVKbtRZRal0DwDQog9c7j4PfNG6hmgLe
 AkxboeHJzhDKCM1/m8BWuv5PZ/2TyyKTD+GOwRuLn0zw8YbN7GGr0wvUiBKMBlwqNlGV
 0IzYPuieemMbQyQdpMj79CrzxiFq5QKsZfS9N+jM3T4HF8GX/B+vW4QxQ8ebHRx7PMm9
 JPMuZI/YqWgL8Ei49OzOMcc6iccyssHtw8p9KjuPr+Q/ZepU4sIxjI6gTdoDB0AcSR1i
 bKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712562173; x=1713166973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uLk8OVVlz8f3D/hwm9nTtvWq67frGqJMheqp7UEeozo=;
 b=Tk/EexQp9VKkLO935ienDzAiRiiVhs/8AncjCjGAtRfPMO8XEoWiCLbin+9SsNJ2uj
 83TiudUzfL3+JwlH53C0W/lZgwJFMHBOXwm44Z+nQnlKbnnOR82uGmxDgvWFLNg6Fwtn
 9MEwMeGjNRQ+zZLQXdpl5I3dxc5MrM8DagRyPsB5fKx9PRkbireKgsNf8MH7VT04WCyI
 TgwzDC5z3LyLoppKSVz4DW3YkiS1eN3K5rkmrnJZzDUJ70cHqn/jg7YclL5atIqwI6oC
 NqdVO7ILL+V+Exkiqm5Vgzh805AfWKSnDFzqg60ZrpV6xy4YNvx30V54pms/O/Dh5RMH
 XRyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaeQd/7acjgLSdPvXN5WI3Ol9TSQvZAmT5fUbrFHta1Fj1E1HRZRtQifleDivCagcwmzN2/NvMXnOtpJDxea0iP4evL5c=
X-Gm-Message-State: AOJu0Yza/2O8txd37SllLfxGtX5ChS0Ffb2W+Sp6BrrUCS41PEQRhj4r
 B2aafdKO+JRGI8J/5qFAmr8HqUOSQMLS7vvrgwDAwwTii5Db9B2foIkSc9q3Jpc=
X-Google-Smtp-Source: AGHT+IGr0GBfWd55mMIpQ8gg2cChM0YesJD7xhjC3ioVkYCdU0JnBGq35CZ6rDwfqtkUYkAsVBCNTQ==
X-Received: by 2002:a17:902:bd43:b0:1e2:61c9:85de with SMTP id
 b3-20020a170902bd4300b001e261c985demr7837609plx.4.1712562172829; 
 Mon, 08 Apr 2024 00:42:52 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 jc2-20020a17090325c200b001e28d18bd52sm6266893plb.232.2024.04.08.00.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 00:42:52 -0700 (PDT)
Message-ID: <d2213191-9b16-4716-a311-97751ba670ad@daynix.com>
Date: Mon, 8 Apr 2024 16:42:47 +0900
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5OeHJR=EeZ=yLovSD9vUPt-zRNKLo2k_fNZPP3W-eX4Fiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

On 2024/04/08 16:40, Yuri Benditovich wrote:
> On Mon, Apr 8, 2024 at 4:30 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/04/08 7:09, Yuri Benditovich wrote:
>>> On Wed, Apr 3, 2024 at 2:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> The peer buffer is qualified with const and not meant to be modified.
>>>
>>> IMHO, this buffer is not so 'const' (although the prototype states so),
>>> it is allocated in net.c
>>> btw, another procedure in this file also modifies the buffer
>>> (work_around_broken_dhclient)
>>
>> Right but it has a FIXME comment.
>>
>>>
>>>> It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers without
>>>> virtio-net header support.
>>>
>>> Does it mean _this commit_ prevents enabling VIRTIO_NET_F_HASH_REPORT
>>> for peers without
>>> virtio-net header support? Where?
>>
>> No, but I meant that this patch fixes such a problem.
> 
> No, it does not. Such a problem does not exist in the master, the
> hash_report feature
> is silently dropped in such case:
> https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L816

Well, silently dropping VIRTIO_NET_F_HASH_REPORT is not different from 
preventing enabling VIRTIO_NET_F_HASH_REPORT, is it?

Regards,
Akihiko Odaki

