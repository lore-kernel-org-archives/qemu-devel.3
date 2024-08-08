Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB0EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 11:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0vj-0000Ev-8i; Thu, 08 Aug 2024 07:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sc0ve-0000ED-K2
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:03:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sc0vb-0001B0-R2
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:03:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso8115375ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723115010; x=1723719810;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xwCLiokYQTVowjjBoiKqclBzmzN2TUx1h4Y7MXtvNhc=;
 b=ZZSfoqpcdAsC2PUQYeEqEcG1kiDU8Kbt0Zx2hgWhu/riuevMvAYoau0xvYwC/hqAls
 QBsVMZD30w2nQEaYZkXa5gFDbkrz3sNKvd5aVzLNcnFY8ANjHwjm2lAY2xc1085c3Gnt
 YzdHyBEb0PDKrZOHW5Vfz4eh4xZKkzSIw45z+zIh08vAQmNDKBxae5RNk+9VjGob9Pnh
 XyVRoXHuOMy86dn/V/6H5XnCkOm5HEQG53N+BojMcnDP85RMIQ+c4M64orIQYTb5iCEt
 41QtPrF5tzPay1HE8tFlqsxww/4sf8BuB8qDn/71yCierFzC4lOXq6veCs+AN3qGIMEy
 444w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723115010; x=1723719810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwCLiokYQTVowjjBoiKqclBzmzN2TUx1h4Y7MXtvNhc=;
 b=DHZ8gg5tDFgDotvhDAsD675q8T8SBVx6cIaVi8MQ91IowD3yy9D6S/+Sc5xlQSPvGC
 2gO8lybrRPvDfWAttkoqCaWm3pvkDeGUN1HxGEnIqzg7MdtnzLzGhUVu0y0vMCpEpDeO
 uw2ZSkfpmqZUIQvDHTOS5WRCOzZUsDzNSDNsegD22Ie5/jRKcsIMEjMTuowtaTfx25i2
 tAwfFS7ccMcdTEvaFqElPGYDD+gcNe38k1+qnzu6RgrYIGeDcHp0rw3OxMKiYa7MUeS3
 //bsM6V3NTfLi/Uh++dlgTb83vPUQlMzH6H1/vxFYWoLCvDyFN53VbwclbjjWv1c5Csb
 9ifw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNe9MVJNuDYGi0OpE3IZFwuE2dvuDX/H625Q5gj2MZfQFqoRTsR94ypfBVj9astquecOQ1s7IaX8apRXDXDBWW9kDDTvE=
X-Gm-Message-State: AOJu0YwAMig9Wo0qdKhMdN7uWSwhFpQ8TVDTu9VHcgHtqaNUQeoYArX3
 05+NWqa0RjyUrS9C+FHDh9uk117/dfw+sx9JUTQbqX3u2W82jMr/URSxSTp3OQ4=
X-Google-Smtp-Source: AGHT+IF2gO9SBpLe85dUd42w9coOxw9Bzbrw7ndFowD1dPScdvGbElwsljzkIILLvf4drYVhm7wmAQ==
X-Received: by 2002:a17:902:fc4d:b0:1fb:a38b:c5a0 with SMTP id
 d9443c01a7336-200952632d3mr15022775ad.31.1723115010183; 
 Thu, 08 Aug 2024 04:03:30 -0700 (PDT)
Received: from [157.82.205.232] ([157.82.205.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592af83fsm121578925ad.295.2024.08.08.04.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 04:03:29 -0700 (PDT)
Message-ID: <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
Date: Thu, 8 Aug 2024 20:03:25 +0900
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
References: <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240808065339-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

On 2024/08/08 19:54, Michael S. Tsirkin wrote:
> On Thu, Aug 08, 2024 at 07:52:37PM +0900, Akihiko Odaki wrote:
>> On 2024/08/06 22:29, Michael S. Tsirkin wrote:
>>> On Tue, Aug 06, 2024 at 04:35:44PM +0900, Akihiko Odaki wrote:
>>>> On 2024/08/05 19:08, Michael S. Tsirkin wrote:
>>>>> On Mon, Aug 05, 2024 at 06:37:58PM +0900, Akihiko Odaki wrote:
>>>>>> If cross-migrate=off, QEMU can still migrate on the same host (checkpoint
>>>>>> and restart). QEMU can also migrate across hosts if the user ensures they
>>>>>> are on the same platform.
>>>>>
>>>>> What is so special about checkpoint/restart? I guess we hope that
>>>>> downgrades are uncommon, but they are possible...
>>>>
>>>> Downgrades will not work with cross-migrate=off. Users who want downgrades
>>>> should use cross-migrate=on.
>>>
>>> We also don't know that upgrades do not disable a feature:
>>> can happen if e.g. there's a serious bug in the feature.
>>> Basically, this makes the feature too fragile, in my opinion.
>>
>> We can do nothing in such a case. Whether it is on a single host or multiple
>> hosts, we cannot support migration if features once enabled disappear.
>>
>> Regards,
>> Akihiko Odaki
> 
> It does not follow that we have to do something, and this is something,
> therefore that we have to do this.
> 
> This is just a reason not to handle checkpoint/restart any different
> than any other migration.

Whethere it is checkpoint/restart or any other migration, I expect 
platform features won't disappear from the host(s); we can't readily 
support migration in such a situation.

When platform features won't disappear, for checkpoint/restart, we can 
enable all available features without disrupting migration; 
cross-migrate=off will instruct that.

However, if we are migrating a VM across hosts and the user doesn't 
ensure they are on the same platform, we cannot enable platform features 
even if we are sure that platform features already present on a host 
won't disappear because some hosts may not have features in the first 
place. We can set cross-migrate=on in such a case to disable optional 
platform features.

Regards,
Akihiko Odaki

