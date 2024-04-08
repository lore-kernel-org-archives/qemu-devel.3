Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AF9CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 01:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtdr4-0003LE-L0; Sun, 07 Apr 2024 21:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtdqp-0003B2-Ap
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 21:31:15 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtdqb-0007kI-6C
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 21:31:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed0938cd1dso1952562b3a.2
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712539853; x=1713144653;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0wyg4Mx126IuFIAjTQ1f6hmqaxbkg6PvV/7GN3Yip/Y=;
 b=H4UW3AOphv3WjiwrZ697e4BFeSqF3cy7RwjjIIiv2NkywjPMGAa0nJ8uS539mHNHPI
 QInPx6kVQFg63EhH7BVhIyy22K6QVyIt1FdvY/LybEer2GOQCw+18Gdu1tSw0OmOYhbE
 13kkN9YP1t931LqXo2YEM1A84ZZYiyMwMF+rk1SGHwi3JbGwLzDFa7R3Q96O4WaD9kKA
 QLcOQpGtKSRN77xMVFuwfYQgLeg+jLZcDUZRi1312iiRCUd2uqCmsQ1/LZgpxXtzG50a
 ZFWidVf0MIJGOK7j/5ElIakjQ/F0bUzURU/fS0A3ON7oltUUkTrkJ229SK8b1wFOLa4T
 lzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712539853; x=1713144653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wyg4Mx126IuFIAjTQ1f6hmqaxbkg6PvV/7GN3Yip/Y=;
 b=CG+fhs0tHbkBtt6/JSIb70aqqGjk1uR5lSl+eghp/mq1ggdnfiernxfXc3xG2uNRgl
 C8sgMGmVi0hjhL0e7kp749W/5ifRsCbgxrsZBeCYfhK1dABIuz7s2vY4XkxPYgUblrPV
 UNjtRUX8rLb0ztWruh1teSzBd8LmXynadwM2fHRz4k1Wgs7g5TPDMchzzXMwG04petxc
 V3WaBelleJWdvhGzrR5VFHqHB2VeoATVMxTZFHnocym6Rhb4Xf5M/dXWIKBEgwCttLpZ
 nsNy+3LtB0SJnu336LCEK4cdmJbG8v5DKpQdYNA5F+rruJlnZyn8fn1sYk9IEvT1+Ad8
 nqRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH1UMzRr7e3dC6aVeEF2iqTu1fZjISvlFDAQFwv3DexzfTC6IczS66q+WVwtFn/cq9xKZ14+JAAP3ZZYfg3ochWx7g9+I=
X-Gm-Message-State: AOJu0YwBBjtcNv9HJ/cPaLxzHCeXJa4IBw0e5IBiQXTONBffIzdBAs6N
 Nh7NqdRDe1PdbFjTCeeAl7kNyiY970XXEvlhSozeZ6osM2LZt/89z2lKJxa9tGA=
X-Google-Smtp-Source: AGHT+IG0BvuriinHWaa8w1TDyBqgZ3S+0+j3rIVh0gbIdunj3edMELn2u7G2+QINwmRrh9IcY/2vAA==
X-Received: by 2002:a05:6a00:4f93:b0:6ec:ff5e:7e66 with SMTP id
 ld19-20020a056a004f9300b006ecff5e7e66mr10056025pfb.1.1712539853422; 
 Sun, 07 Apr 2024 18:30:53 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a631205000000b005cf450e91d2sm5000207pgl.52.2024.04.07.18.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 18:30:53 -0700 (PDT)
Message-ID: <8010b335-4b46-456e-bf6e-c191cdc34964@daynix.com>
Date: Mon, 8 Apr 2024 10:30:51 +0900
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Od=KUTHnikVBA7iWfdFPJ=T7hbJrSu4zwCiB_Q1P-Sz+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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

On 2024/04/08 7:09, Yuri Benditovich wrote:
> On Wed, Apr 3, 2024 at 2:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The peer buffer is qualified with const and not meant to be modified.
> 
> IMHO, this buffer is not so 'const' (although the prototype states so),
> it is allocated in net.c
> btw, another procedure in this file also modifies the buffer
> (work_around_broken_dhclient)

Right but it has a FIXME comment.

> 
>> It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers without
>> virtio-net header support.
> 
> Does it mean _this commit_ prevents enabling VIRTIO_NET_F_HASH_REPORT
> for peers without
> virtio-net header support? Where?

No, but I meant that this patch fixes such a problem.

Regards,
Akihiko Odaki

