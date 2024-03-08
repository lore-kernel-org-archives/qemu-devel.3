Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E19C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVUB-00014M-6Q; Fri, 08 Mar 2024 03:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1riVU6-00013O-0T
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:21:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1riVU4-00008h-6T
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709886097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qe3uHvS98U6bvHb4ZBc40mvrolVqMc9tr9vMaDR4D0E=;
 b=NU9sTkKnHFKwNV6kb4bcn56Z6wFmiqyi7vNcD5I1sOnPnZ6fo0ZkRcq7yXaUN/Lwsjt52a
 oVvYS6/CmmUSq9aG4c47N1LMe9lYBbsYPCc7NnmbQNVOMc79TCi5mYd1kGTc8BhKUm0uIO
 hE0sPy0EJeAEE0IIWk4C6sf65FMuLIg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-VN5Sk1IzOvCEL6h1O2xYPQ-1; Fri, 08 Mar 2024 03:21:35 -0500
X-MC-Unique: VN5Sk1IzOvCEL6h1O2xYPQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42ed6809154so47794371cf.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709886095; x=1710490895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qe3uHvS98U6bvHb4ZBc40mvrolVqMc9tr9vMaDR4D0E=;
 b=sT49QWEmOElbQhh+aqEaXy5djTJ/b4xXKVJOf18T/4rQ3wJ87z669hiMA1LNsJEoLT
 mPWdGhAP0SsrgwmVij5Y4HqoZuk7Z0hCp5kGJxesNVucHVRfmv+9Jv9TFlqYrMFd4KNn
 /RjoKS6RfHC9GflH8nvv9XWPYEEY/szJ618dCdexuAn5jznnM+1/UBRLK7d88U91iy24
 OeOn5ncgD1WOmxnprRkQH8x/9XMDexiKV1IkVkqWAKy86CrCijDYuj8fmDBHrDUexjjJ
 xO3TIT72qQLW3+EzeDXvzFEgkUOLne3cVTlEs+0h9mCeNbDiQ2C1k56Zfk84pLVD0W4g
 ulJg==
X-Gm-Message-State: AOJu0Yx/Qh+HyHW3q+b4OwDc3fNtyxWdlHgHWtGJcnRoU+XPPmrk2PRI
 hEM/Q4TtycBHTMy7mKySseFZHRAvH6Yi/kDpLp0Pnd5bycenFhL63pTM2sjKycaGxSMwKvcllHS
 MKCsa5bKUYAAeaZxk+NvLTG13Ezi4JTe/QLiuL7VIp4YOKn74dEo5
X-Received: by 2002:a05:622a:10f:b0:42e:f574:62c7 with SMTP id
 u15-20020a05622a010f00b0042ef57462c7mr5187785qtw.24.1709886095300; 
 Fri, 08 Mar 2024 00:21:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqWV60pi28rxnFgZBUA98XM9uJ9TfnS9WNEJvaE7uvYsZE4up+mlFGK1eYH2l2CzC2QZFKfw==
X-Received: by 2002:a05:622a:10f:b0:42e:f574:62c7 with SMTP id
 u15-20020a05622a010f00b0042ef57462c7mr5187767qtw.24.1709886094936; 
 Fri, 08 Mar 2024 00:21:34 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 f8-20020ac859c8000000b0042c61b99f42sm6027344qtf.46.2024.03.08.00.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:21:34 -0800 (PST)
Message-ID: <ee3f60de-8bbd-4a49-a6b7-65937a122a93@redhat.com>
Date: Fri, 8 Mar 2024 09:21:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] e1000e: fix link state on resume
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20240124104006.335166-1-lvivier@redhat.com>
 <CACGkMEtzqCA_x1hg-ddp0d-Q-+XLH01k2Pf0KziiYSeLmDwaXA@mail.gmail.com>
 <622dabbe-a215-476a-b72c-41d1103b7cb6@redhat.com>
 <CACGkMEuCewG-RLNRrBP03-qrWO4w8Jg5L3ASAUbYcKXwBnwzUw@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <CACGkMEuCewG-RLNRrBP03-qrWO4w8Jg5L3ASAUbYcKXwBnwzUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/8/24 09:09, Jason Wang wrote:
> On Tue, Mar 5, 2024 at 6:07 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> On 2/1/24 06:45, Jason Wang wrote:
>>> On Wed, Jan 24, 2024 at 6:40 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>>>
>>>> On resume e1000e_vm_state_change() always calls e1000e_autoneg_resume()
>>>> that sets link_down to false, and thus activates the link even
>>>> if we have disabled it.
>>>>
>>>> The problem can be reproduced starting qemu in paused state (-S) and
>>>> then set the link to down. When we resume the machine the link appears
>>>> to be up.
>>>>
>>>> Reproducer:
>>>>
>>>>      # qemu-system-x86_64 ... -device e1000e,netdev=netdev0,id=net0 -S
>>>>
>>>>      {"execute": "qmp_capabilities" }
>>>>      {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
>>>>      {"execute": "cont" }
>>>>
>>>> To fix the problem, merge the content of e1000e_vm_state_change()
>>>> into e1000e_core_post_load() as e1000 does.
>>>>
>>>> Buglink: https://issues.redhat.com/browse/RHEL-21867
>>>> Fixes: 6f3fbe4ed06a ("net: Introduce e1000e device emulation")
>>>> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>>
>>>
>>> I've queued this.
>>
>> Ping?
>>
>> Thanks,
>> Laurent
>>
> 
> This fail CI at:
> 
> https://gitlab.com/jasowang/qemu/-/jobs/6348725267
> 
> It looks to me we can safely drop e1000e_autoneg_pause()?
> 
> Thanks
> 

Yes, I'm going to send a new version of the patch.

Thanks,
Laurent


