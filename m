Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99176C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkW3v-0005fX-8p; Wed, 13 Mar 2024 17:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rkW3q-0005f9-23
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rkW3n-00065T-Ut
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710364970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8N7JwHnp0Ttoav2b4x6ciXuazHrUsMH7ZGOHLQBF4PE=;
 b=VrvivIQCkjTht5YBr39an6omYmV+KpmWigaFmo22uv5pSlRiICkA5/UwUU7yNcAIAjvS4b
 SlLOPEnbCCt6X+sHDjLD+Fjxd5RzDgHaSpnNIL+zFAMRf0gTz+VP5fkj5MNOaGIyrTIWi4
 /LAny5GHh6wddkKNwI6LwDkQb3yLKjQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-QrngziMhMCWmQYTBNVaeIQ-1; Wed, 13 Mar 2024 17:22:49 -0400
X-MC-Unique: QrngziMhMCWmQYTBNVaeIQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33ec4a5ec46so72782f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710364968; x=1710969768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8N7JwHnp0Ttoav2b4x6ciXuazHrUsMH7ZGOHLQBF4PE=;
 b=LCH6vX1jx/RJMNqAGAuS4bL+y3JTBgfSTmUq+slolouixMPIbLDQkQsUeOXsmQ7zkz
 Py16ShrRcuFhP/nVVnPSnxS3KIzBRYYD92oPoPyV25bOrELxKB1Z6yaFtj40dnciv2X4
 HLwuiRF4ER6LaND2ggysrkpSxeGRyjHoWCMiuLcMzkgJersFeevFa/W/a3SxQZwYBrNe
 NuMt+IT7QtOxeS6qxlabPxVYdgwtNxbdNax2KfJTKdEtNaZOiKCgaAdGxAOk/f+9nbH2
 Rb8rEapNsWLaJkbaQlglg1ZLTXvtyWddes2dYRamAzEV94VVEg5UodF4WSGS6QIKJmD3
 NVMg==
X-Gm-Message-State: AOJu0Yz17RoMVs3Lh0Nt/uxp9LmEk3wNmcYDYiNizAwUD/778oWQNt5q
 o3NNFo5hxl5ZraN6Ra6ZemASuqQ70LT55gblnq96rq8V9VyYI4l/N57XJNhSlCsMsFZqjpfWSoG
 wwbo0BGeLCr+aFLLYzn6ihMrMz6ifajq4cd5Kghu+GgCA6doqHWYx
X-Received: by 2002:a5d:5108:0:b0:33d:b03a:5e2f with SMTP id
 s8-20020a5d5108000000b0033db03a5e2fmr2330056wrt.10.1710364968106; 
 Wed, 13 Mar 2024 14:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCcRw9S+uwTIgBx343SgoZcbDjeCfLHR522Av4JWrz7I27reA4rNYhP8xQP3INRZn0//1jHg==
X-Received: by 2002:a5d:5108:0:b0:33d:b03a:5e2f with SMTP id
 s8-20020a5d5108000000b0033db03a5e2fmr2330048wrt.10.1710364967767; 
 Wed, 13 Mar 2024 14:22:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 dv13-20020a0560000d8d00b0033e75e5f280sm40615wrb.113.2024.03.13.14.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 14:22:47 -0700 (PDT)
Message-ID: <375cdc79-9854-459c-9ba2-08312645b89c@redhat.com>
Date: Wed, 13 Mar 2024 22:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/14] migration: stop vm for cpr
Content-Language: en-US, fr
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-11-git-send-email-steven.sistare@oracle.com>
 <ZdvyuazPp6Lrn5Mr@x1n> <9d560585-8f3b-4ad4-82e6-333e8c74b496@oracle.com>
 <ZeEvSLgKW96KCy-N@x1n> <00ac45c5-2c46-41c1-9cb3-585498d0ded9@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <00ac45c5-2c46-41c1-9cb3-585498d0ded9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/13/24 15:18, Steven Sistare wrote:
> On 2/29/2024 8:28 PM, Peter Xu wrote:
>> On Thu, Feb 29, 2024 at 10:21:14AM -0500, Steven Sistare wrote:
>>> On 2/25/2024 9:08 PM, Peter Xu wrote:
>>>> On Thu, Feb 22, 2024 at 09:28:36AM -0800, Steve Sistare wrote:
>>>>> When migration for cpr is initiated, stop the vm and set state
>>>>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>>>>> possibility of ram and device state being out of sync, and guarantees
>>>>> that a guest in the suspended state remains suspended, because qmp_cont
>>>>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>
>>>> cpr-reboot mode keeps changing behavior.
>>>>
>>>> Could we declare it "experimental" until it's solid?  Maybe a patch to
>>>> document this?
>>>>
>>>> Normally IMHO we shouldn't merge a feature if it's not complete, however
>>>> cpr-reboot is so special that the mode itself is already merged in 8.2
>>>> before I started to merge patches, and it keeps changing things.  I don't
>>>> know what else we can do here besides declaring it experimental and not
>>>> declare it a stable feature.
>>>
>>> Hi Peter, the planned/committed functionality for cpr-reboot changed only once, in:
>>>      migration: stop vm for cpr
>>>
>>> Suspension to support vfio is an enhancement which adds to the basic functionality,
>>> it does not change it.  This was planned all along, but submitted as a separate
>>
>> If VFIO used to migrate without suspension and now it won't, it's a
>> behavior change?
> 
> VFIO could not cpr-reboot migrate without suspension.  The existing vfio migration blockers applied to all modes:
>    Error: 0000:3a:10.0: VFIO migration is not supported in kernel
> 
> Now, with suspension, it will.  An addition, not a change.

Still, I wonder if we should not have a per-device toggle to block
migration for CPR_REBOOT mode. This to maintain the pre-9.0 behavior
and to manage possible incompatibilities we haven't thought of yet.

A config option to deactivate CPR_REBOOT mode in downstream could be
useful too.

Thanks,

C.




> 
>>> series to manage complexity, as I outlined in my qemu community presentation,
>>> which I emailed you at the time.
>>>
>>> Other "changes" that arose during review were just clarifications and explanations.
>>>
>>> So, I don't think cpr-reboot deserves to be condemned to experimental limbo.
>>
>> IMHO it's not about a feature being condemned, it's about a kindful
>> heads-up to the users that one needs to take risk on using it until it
>> becomes stable, it also makes developers easier because of no limitation on
>> behavior change.  If all the changes are landing, then there's no need for
>> such a patch.
>>
>> If so, please propose the planned complete document patch. I had a feeling
>> that cpr is still not fully understood by even many developers on the list.
>> It'll be great that such document will contain all the details one needs to
>> know on the feature, etc. meaning of the name cpr-reboot (what is "cpr"),
>> when to use it, how to use it, how it differs from "normal" mode
>> (etc. lifted limitations on some devices that used to block migration?),
>> what is enforced (vm stop, suspension, etc.) and what is optionally offered
>> (VFIO, shared-mem, etc.), the expected behaviors, etc.
>>
>> When send it, please copy relevant people (Alex & Cedric for VFIO, while
>> Markus could also be a good candidate considering the QMP involvement).
> 
> Submitted.
> 
> - Steve
> 


