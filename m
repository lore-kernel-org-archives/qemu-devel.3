Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3336DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 09:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauAT-0008Ag-5k; Mon, 05 Aug 2024 05:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauAN-00089t-Hd
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:38:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauAJ-000579-PJ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:38:10 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc569440e1so90271255ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722850684; x=1723455484;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJkQ1sRY+Itmok22E1caBwWfviwvd2cn6fHjm33ctvc=;
 b=e37PAaTwRylS9LigcbNZipSHDcM2F09iN6ldANU78DWJOSaoI0g2i7xp82tBi+9f9z
 XZYQ91I66JuM+Afw90X3jzCQheCWL1pMmpnhzV8Bymxv/VhZOnRSTn00yQx1lILqF1Fz
 xiU/De8mgZQJnMfyHDA+Y7Xo7CAWXTrGluG71pNDSDADkpOnk4fNjjq/1nFkZRizX+2l
 kO/PYZedPrHaEhRzICOWYo2ZtL6RSoKeuOl6BmODiVyPMbGXdCoVwB8EBFyY/5bNxX8R
 8xZYczaL4GAiz05r6daiNoN298xZhKtK+/CG9SHUJmVU79oDlD/e4SsejrC82mugy6NC
 kGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722850684; x=1723455484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJkQ1sRY+Itmok22E1caBwWfviwvd2cn6fHjm33ctvc=;
 b=gGtaab0b1fMVNG77BSmV4ox22QmRNw4zN+GHP9B0zEo5nnZVL/Z+WvE6A8tYhITwWU
 Qtno3iEGSqbVxH0WnHK2BLsSPScYEk8/YCAm4fvlQ6zRmkrI8gTrNkQeQlZcqo8KseDL
 YhRbCMMmQzQcFqtEJBI95A4ts37/7UnBma3NkmP7tDIYpaqG21Cp1p81JcxmJUiYhO5O
 65fbXYFjBKTqoRLjQhJ+nHWhu5cbayCNn6B4Hg4Jq713tlVXOoo8Mgg2Ag0a0Ri9W0F2
 Bvn5Cdt2vhKCQRxMJTUSSF9nivDEFpFEwzC3NQmp3fNhKYXN3dHkfsHi4PheHAYsDiYH
 oAIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDdBcZVw9ob7VVwpyZjBFXJKWKvKFJJpCNhnMWk9sJJ0Do1I3WxQMreIylJIvKDmbxYJRWz8Li/f7lQvd2G0K9q5ou+L8=
X-Gm-Message-State: AOJu0YwQevgLPPb0qfNz1v+l2gffxU+N3tqEHHbtyMbmh6DJFNyTZJaH
 wEEaIb+Ia0ikN8qsDC+tt+f4rFGTGQKI7HRf71impIsZY259pYhmzDh1fIBvQpBplbuOV0TNktw
 IJww=
X-Google-Smtp-Source: AGHT+IHavl2LNaCpaDiOqCm1GFLHmL24ng/klBuBoKzW4RFJAHSNlS8Ct+2qzDyh1ECUuolI9Su2Ig==
X-Received: by 2002:a17:903:228e:b0:200:668f:bfd5 with SMTP id
 d9443c01a7336-200668fc11cmr42410395ad.21.1722850684190; 
 Mon, 05 Aug 2024 02:38:04 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f19da0sm62913005ad.60.2024.08.05.02.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 02:38:03 -0700 (PDT)
Message-ID: <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
Date: Mon, 5 Aug 2024 18:37:58 +0900
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
References: <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com> <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com> <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com> <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240805041650-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

On 2024/08/05 17:23, Michael S. Tsirkin wrote:
> On Mon, Aug 05, 2024 at 04:53:52PM +0900, Akihiko Odaki wrote:
>> On 2024/08/05 16:30, Michael S. Tsirkin wrote:
>>> On Sun, Aug 04, 2024 at 03:49:45PM +0900, Akihiko Odaki wrote:
>>>> I suggest disabling all offload features of virtio-net with 9.2.
>>>
>>> Yea ... no.
>>>
>>>> I want to keep things consistent so I want to disable all at once. This
>>>> change will be very uncomfortable for us, who are implementing offload
>>>> features, but I hope it will motivate us to implement a proper solution.
>>>
>>> It's uncomfortable for users.
>>
>> An obvious alternative is to set cross-migrate=off by default (I dropped the
>> no- prefix because no-cross-migrate=off is confusing). I don't have a
>> particular idea whether cross-migrate should be on or off by default.
>>
>> This is a trade-off of safety and performance. In general, I believe safety
>> should come first before performance.
> 
> There's no actual safety issue here. You can't migrate certain configurations.
> So I don't really understand what "cross-migrate" is supposed to do:
> fail migration in 100% of cases?

"cross-migrate" means migration among hosts with different platforms 
(e.g., different kernels, vDPA devices).

If cross-migrate=off, QEMU can still migrate on the same host 
(checkpoint and restart). QEMU can also migrate across hosts if the user 
ensures they are on the same platform.

