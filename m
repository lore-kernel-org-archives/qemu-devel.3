Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43A9C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 10:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhRiW-00043t-IA; Tue, 05 Mar 2024 05:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rhRiU-00042P-PD
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rhRiS-0007nH-B5
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709633286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tALNwQdrB2bpcYhWUnfhrfy/GgGGJmfc56O01qraNVE=;
 b=HtVdkKJ31lvW2mWIi1Ku+mplEFi9QfRagpCOIGsdvkngLWklILQAo5IozyoV95tAsxzP74
 n/a1FDIk/SdU7StcztCJzlukPyq29rc4/jYhA7N2YLmZM0W33cCUA5RVZkkP9Zm66U2iUB
 Du6C68GHQJL6IeXDjUwJuxiPPImGZbI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Vb58ZVnuNLWsEe59Z3nj6w-1; Tue, 05 Mar 2024 05:07:00 -0500
X-MC-Unique: Vb58ZVnuNLWsEe59Z3nj6w-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a0d2b86e19so5510453eaf.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 02:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709633220; x=1710238020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tALNwQdrB2bpcYhWUnfhrfy/GgGGJmfc56O01qraNVE=;
 b=TfHAe0SvwOyblhiAS1NsFfcrG6FHXEEfctl8NToyRPoDN+eyDeMF4E5KDLkiBdP2XG
 zIYlfu5BcclQ70Q42ly1JpAUXrZLT4xSQmJnTi8R6vjOaCrYgdsA6kuC8t3aENeu+ZzL
 MXsd+pQ3J4NsTv/UrUyAm9z30qoLSM4zrK5pgeeJxkfkL82b6meygee6XNsdysj2Ou12
 +TkEonjCbuM333bgllh4FS+4bPctvnkOtul0o0V/ZAw9YJi5rrATvPSjjp6spCKRfTrh
 gWbA1DkIjowZOcxkEmQ6/iSoXPORkqtE7FkU3crXYBAh6CzJAXxDkCR7LHUc95CyRV2P
 fRpw==
X-Gm-Message-State: AOJu0Ywqmic6vyy4WGUFx73g2u5cZ1MxiPjbTI/pPcIYN1w2q271K7Zn
 S+U9xjqhQgzPu23V/ygP61/RIZ6z0nrC3xQBP/Yqid1FmwUsdQXMiuJIJJV3vChmnxjqBooi01p
 xwjDZbiXPTVbLNtQtqaEb8wXtqqZMEkd7nnTbiOvnOKZk4Iea21uD
X-Received: by 2002:a05:6358:6f0e:b0:17c:1da1:aa8f with SMTP id
 r14-20020a0563586f0e00b0017c1da1aa8fmr1193960rwn.24.1709633220220; 
 Tue, 05 Mar 2024 02:07:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKQLVFDZXrEwEB6Pj2T8wX8KAPmKWOv4HnnXY+AsrXx44Qg0GfOfL3cdpVHieMsz3vi9DA5w==
X-Received: by 2002:a05:6358:6f0e:b0:17c:1da1:aa8f with SMTP id
 r14-20020a0563586f0e00b0017c1da1aa8fmr1193951rwn.24.1709633219940; 
 Tue, 05 Mar 2024 02:06:59 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 qr6-20020a05620a390600b007882e50260fsm1393404qkn.104.2024.03.05.02.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 02:06:59 -0800 (PST)
Message-ID: <622dabbe-a215-476a-b72c-41d1103b7cb6@redhat.com>
Date: Tue, 5 Mar 2024 11:06:57 +0100
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
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <CACGkMEtzqCA_x1hg-ddp0d-Q-+XLH01k2Pf0KziiYSeLmDwaXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

On 2/1/24 06:45, Jason Wang wrote:
> On Wed, Jan 24, 2024 at 6:40 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> On resume e1000e_vm_state_change() always calls e1000e_autoneg_resume()
>> that sets link_down to false, and thus activates the link even
>> if we have disabled it.
>>
>> The problem can be reproduced starting qemu in paused state (-S) and
>> then set the link to down. When we resume the machine the link appears
>> to be up.
>>
>> Reproducer:
>>
>>     # qemu-system-x86_64 ... -device e1000e,netdev=netdev0,id=net0 -S
>>
>>     {"execute": "qmp_capabilities" }
>>     {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
>>     {"execute": "cont" }
>>
>> To fix the problem, merge the content of e1000e_vm_state_change()
>> into e1000e_core_post_load() as e1000 does.
>>
>> Buglink: https://issues.redhat.com/browse/RHEL-21867
>> Fixes: 6f3fbe4ed06a ("net: Introduce e1000e device emulation")
>> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>
> 
> I've queued this.

Ping?

Thanks,
Laurent


