Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD283C5320E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 05:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfYDf-0000n6-8y; Sun, 18 Aug 2024 01:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sfYAp-0000Vy-No
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 01:09:52 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sfYAm-00086o-H4
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 01:09:50 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d5b1e33fa8so2069854eaf.3
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 22:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723957787; x=1724562587;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+VmZtAurK5BZp3Wo9KpHrlMa21eSaefLw++XZLPg5kw=;
 b=tjv3ZkuSzscRMIG+eCsveFgS4ylD+yYJsEhFTgweQnFfzo6z/cjiyuu3rkHUvttKQW
 mzhLjx8zwWmGUlEDNl7wIBE9Yz8jEu+45cplJP9EDmT9arXgFgaalwUDxtkZZKojzlSV
 t4YBB5FrVyovvHW91THB8F3DECoTeUaYudOJ/XD45GrO6aLg6L4fc7sgCwPkSrN7uaBM
 LjmjXHBTpWjDTW/gES5wHSpToyKeGupDfJn/FYStLmv9QLxd7yAjK4Ibqvj+QOR5QxuA
 Zj7WLpsHyQ6sMvfdlGwhZmujsHPC2P/oNL1xKLVzqc35rgsUH8N6DNopMlvgKsdas0fG
 yJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723957787; x=1724562587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+VmZtAurK5BZp3Wo9KpHrlMa21eSaefLw++XZLPg5kw=;
 b=Jf/V1qnkJi0amc5uHtM2V9TGkdLsmP4lo4SigHmAqoXusHyouOMnIiBNz8nmej06jt
 9YLJ6ptUeKbqDqYKeXpfmIVon0iY7I1AOvCCbK+uu+FKqrV2EoFhbbWt3FyOu9qcnvBg
 ngaLzbif6Af+SBWTzn6LiPHbY9tCU+UYIkkltSUEj+ADKU9lohedZHuP8BVARYv8Po19
 uT9qX0b5MdK+tFYr5MOMNT6JoLFXAR07GXJ53BZ56jlv8puTnKtoGemuLksS2aVyvR7q
 xE5MSqo6nbR+jtqFGUybVY5gtJ66Dv7vztsmJYBv3RUZJqSOqBPS/4DCKJVHsYb0eOMq
 NqTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjmGLb3ou+5lVra8rz8wMtZDOIbGBmc/teacyPzqJKBtEtzJrqGBpjYiZUAQmR23oqKzafd3pl1kab2wyVcxCXfePO7CU=
X-Gm-Message-State: AOJu0YxurFrPgbGS+n4hHcKS3PiQuGF1qMbkFXPg8WUP06wGwmMRzHun
 z1pBL317Oap83Gn5jzFiB2dEx+A0tAEodkMGVSZKWY6A5k3Ww4ugWV9EEemzGLw=
X-Google-Smtp-Source: AGHT+IHBue/sKdkKf8UeiCSRoFkevoI4PUj0lHQNJRYdzcwobgE6/OdnF0kJHofeVI/KT0IM8lk0vQ==
X-Received: by 2002:a05:6358:7f13:b0:1ad:14ec:a002 with SMTP id
 e5c5f4694b2df-1b39331deb6mr1054842755d.26.1723957787022; 
 Sat, 17 Aug 2024 22:09:47 -0700 (PDT)
Received: from [10.100.1.231] ([157.82.128.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b61a71fbsm4768171a12.9.2024.08.17.22.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Aug 2024 22:09:46 -0700 (PDT)
Message-ID: <15263e84-bec2-4d11-ac29-2861cc772bf2@daynix.com>
Date: Sun, 18 Aug 2024 14:09:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org> <ZrTTCIpXLmW8c5Kv@x1n>
 <20240808104559-mutt-send-email-mst@kernel.org> <ZrTjaZPyjDuJZK36@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZrTjaZPyjDuJZK36@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/08/09 0:25, Peter Xu wrote:
> On Thu, Aug 08, 2024 at 10:47:28AM -0400, Michael S. Tsirkin wrote:
>> On Thu, Aug 08, 2024 at 10:15:36AM -0400, Peter Xu wrote:
>>> On Thu, Aug 08, 2024 at 07:12:14AM -0400, Michael S. Tsirkin wrote:
>>>> This is too big of a hammer. People already use what you call "cross
>>>> migrate" and have for years. We are not going to stop developing
>>>> features just because someone suddenly became aware of some such bit.
>>>> If you care, you will have to work to solve the problem properly -
>>>> nacking half baked hacks is the only tool maintainers have to make
>>>> people work on hard problems.
>>>
>>> IMHO this is totally different thing.  It's not about proposing a new
>>> feature yet so far, it's about how we should fix a breakage first.
>>>
>>> And that's why I think we should fix it even in the simple way first, then
>>> we consider anything more benefitial from perf side without breaking
>>> anything, which should be on top of that.
>>>
>>> Thanks,
>>
>> As I said, once the quick hack is merged people stop caring.
> 
> IMHO it's not a hack. It's a proper fix to me to disable it by default for
> now.
> 
> OTOH, having it ON always even knowing it can break migration is a hack to
> me, when we don't have anything else to guard the migration.

I think neither of them is a hack; they just deal with different 
scenarios summarized in [1]. We need apply a solution appropriate for 
each scenario, or we will end up with a broken system.

Regards,
Akihiko Odaki

[1] 
https://lore.kernel.org/r/770300ac-7ed3-4aba-addb-b3f987cc6376@daynix.com/

