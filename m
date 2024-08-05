Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06B0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 07:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sasXa-0008Hw-OW; Mon, 05 Aug 2024 03:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sasXY-0008Gw-HS
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:54:00 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sasXW-0004e3-Jo
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:54:00 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d9e13ef9aaso7221868b6e.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 00:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722844437; x=1723449237;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F1mG8lUGWXEpebCiFpH6qM5dInW31EtodQquCTR1D2I=;
 b=r2Dr5QHsXYNAC2kNLLukc1BQDmDLIM8mXxKwf085elBqq4D4zCDb+k/6ho0fxYLBLt
 h3fcxm8tNroCKKCy5EtOMLlU1aVU/6MNJ6tLHWCL3seDvI9rQPCT39SQswuRCUuPgqSR
 BnYtv0QlN3GHLJSLMe2/KoLLIqYP7yooy+hFljHrA+CIB+oY3IeBxYvnqhD1f8ftn6BK
 wI8UWEtjyh6fQxJNZrBqHkyuVPD1ApNX/OVw48fBxux3QiCmTM3tqYRKEimQtmHRQxE9
 FO1t4THaGmTXlmFeGEhw7pQ+eL2slGE4ro9uNV/oiUwvaSqSZO/dLCUdU6fQuCtDt6Rf
 ehow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722844437; x=1723449237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F1mG8lUGWXEpebCiFpH6qM5dInW31EtodQquCTR1D2I=;
 b=GRN2vX68S6Bjsdj0bvlBfzaVbyhOQ2XnnTW535lUbgnuk711ckNdEO6GGfRphTaWzh
 qVVU/zRApPcddlWupThpMGpGFC+/oiXuNQQj/BW9CZR1ncGExdOGYyA+Hw206LBREOXN
 EtScrCR3bOfDlxHHhDK1yda65ZQB7Sbl+4t6U1OYAOOonRM10EwKHIE1tNU6jz2V2iX5
 ZYqQDQNdB14+MTRbNAlNlPNuSVjIfju/9nOMFshVf6/3gDuwgy7GgA+I6V3leNQPJCaD
 46dDowjeZcrbIeAkETUXE0lroLGcGXEq1iZYu5Ky9kMZrOSXEGVMjggKuCpDDB6RcHNz
 Y08w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLbjnKkOWO3T/IIh55GWEysZFUOM9NpLK6ReUkBI5Q8mocHaQWsRc5a69SZKSYsFGWho0+OaEWJik+YwUuTIsSUY4bsj0=
X-Gm-Message-State: AOJu0YzaPdELQfutjZUqB+fDmqnzBcT56HrKpXZvhyLTY+J8ghA83AfN
 qvlZdXNb16o+EKF2y1CUk5nNiCJgiFL+sO5tBdtmdKfNDoV+R7ZAS0ohdEonmHI=
X-Google-Smtp-Source: AGHT+IHVOjRqO7ZiZKMVtqGYO/ig0LjmhRnvtXsTXCJGAi8V+Gik7b7Ma9bsbVJnKJRQx/5lswh8zw==
X-Received: by 2002:a05:6870:910e:b0:25e:f4e:da53 with SMTP id
 586e51a60fabf-26891eb0564mr13399819fac.37.1722844436668; 
 Mon, 05 Aug 2024 00:53:56 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec010b4sm4893381b3a.27.2024.08.05.00.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 00:53:56 -0700 (PDT)
Message-ID: <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
Date: Mon, 5 Aug 2024 16:53:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n> <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n> <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n> <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n> <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <20240805032937-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240805032937-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x230.google.com
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

On 2024/08/05 16:30, Michael S. Tsirkin wrote:
> On Sun, Aug 04, 2024 at 03:49:45PM +0900, Akihiko Odaki wrote:
>> I suggest disabling all offload features of virtio-net with 9.2.
> 
> Yea ... no.
> 
>> I want to keep things consistent so I want to disable all at once. This
>> change will be very uncomfortable for us, who are implementing offload
>> features, but I hope it will motivate us to implement a proper solution.
> 
> It's uncomfortable for users.

An obvious alternative is to set cross-migrate=off by default (I dropped 
the no- prefix because no-cross-migrate=off is confusing). I don't have 
a particular idea whether cross-migrate should be on or off by default.

This is a trade-off of safety and performance. In general, I believe 
safety should come first before performance.

On the other hand, disabling offload features is a breaking change. QEMU 
also has -only-migratable option; it is more consistent to make the 
additional assurance for migration opt-in instead of opt-out. Finally, I 
see migration across hosts as an advanced feature, and perhaps it can be 
justified to make it more like an optional feature.

Regards,
Akihiko Odaki

