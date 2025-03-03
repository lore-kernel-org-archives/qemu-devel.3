Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C21C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3LU-0006cW-Sn; Mon, 03 Mar 2025 05:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tp3LQ-0006bq-AQ
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:48:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tp3LM-0000OF-FQ
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740998894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tULCGMejepMp3HVhQsarMoHA0/BH17DGeAYuLBBG8os=;
 b=hGT3z6M4W3V3aEkMPmRhI8h/Rb7fyQbqMSkr8YhhitaUD23gFle9txkc959FOEUbC94Oc4
 LNTMSvCqHn17N4jWq2rjtc+UCvI3Nn7/XkXLcQ4+VAnNI5fcoGSZG4JDhWGqiUSLk3t1wS
 gmLod50krbBqh+18hi8jwRYpAsK14UA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-GudBPiZrPwqlL5qmYXFxOA-1; Mon, 03 Mar 2025 05:48:13 -0500
X-MC-Unique: GudBPiZrPwqlL5qmYXFxOA-1
X-Mimecast-MFC-AGG-ID: GudBPiZrPwqlL5qmYXFxOA_1740998892
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so30829415e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998891; x=1741603691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tULCGMejepMp3HVhQsarMoHA0/BH17DGeAYuLBBG8os=;
 b=mYHKCzhIVTRdOmFdF+ENNR6/mCIgPGP2HKsM4OvQgqD/fEX1L4swX2CwHPayVsxwsY
 +rIPdQuVla9n0neTQ6vZr7XZO5zCOE66UWmKE99+n+0jF3j1DhSPXFy297lf5+FCjTLG
 D5cofD+oUvr83w1/y41J8N3u04lly4ERyYUdH7Kulsv9eEPUqZT7wc8Qkh6lacqAdNcS
 1hh6FPHmZ2VrsmRJdVUDZJ/BsYU91BAiS5Fr2ZQVLeoHANHcSg+CCgXQOMHoyRd/WrI8
 7ObySMV0vt4MAI8EWCyDkeQ9IIOjFli4Hu+E8Azak3Fnw1+VpsQzi1q+K4qeD69d2CiX
 XMmA==
X-Gm-Message-State: AOJu0YwlV1bMhwyMP9xn7yUNE+YuKrJtdNj5hCW0Ux+unaB4G0WR5XZ1
 hMVv4wV2uVc8n1owasBx7ImcUvmDZc0aPfgN0r0E1oY+tJ0wz3bTUA57UuKYuLbd8Xlnc0xOXOt
 obwFQ+eFkQSc04SmlyAbgRpPS6BohMDLuo6Oi1Q4h7QoB0kL68646iTDlYNiMwKQ+LQNsekD/nR
 ywRa9v/6WDfGnKBJHoYEaYOkk0Llh0ORDHQxZkxw==
X-Gm-Gg: ASbGncvM7Qc6CIQcaDybvqa3Wcn9hLAESAoaRlhsnAdN1xYtg7Tu9UzK/KWNyMsrsBr
 9jbFR1BLrid+09XytPw2Qva6he/LfC4JFbTZ7EzT51g0V5yU/Hqd7xkl18cJYYJjN6X6TBB3DDN
 0=
X-Received: by 2002:a05:600c:3543:b0:439:5541:53cc with SMTP id
 5b1f17b1804b1-43ba6a84832mr109987475e9.29.1740998890908; 
 Mon, 03 Mar 2025 02:48:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErpXiC22B0CnZjHMOx8lLWZ/RYj1uUWVeFLA8ydqCGG1zN0MHcaZJTJIwpYUhIf9+t3IHcCDdJ/2gEbnO4ZiM=
X-Received: by 2002:a05:600c:3543:b0:439:5541:53cc with SMTP id
 5b1f17b1804b1-43ba6a84832mr109987055e9.29.1740998890207; Mon, 03 Mar 2025
 02:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <87frjy2k8z.fsf@suse.de>
In-Reply-To: <87frjy2k8z.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 3 Mar 2025 16:17:53 +0530
X-Gm-Features: AQ5f1Jqf42box0Hz3-n8jFW9UKMqtrpzNDv8lL4ReOonAe3nxPhqIRxu9In7p10
Message-ID: <CAE8KmOwVoGJ2frVCY76W7UxSr90wAL2EMj5Nmtcrdc+BE1e9=g@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Allow to enable multifd and postcopy migration
 together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Fabiano,

On Fri, 28 Feb 2025 at 20:23, Fabiano Rosas <farosas@suse.de> wrote:
> You forgot to split patch 2. We cannot have a commit that revamps the
> channel discovery logic and enables a new feature at the same
> time. Changing the channel discovery affects all the migration
> use-cases, that change cannot be smuggled along with multifd+postcopy
> enablement.

===
>> Continue with this patch and fix the stuff I mentioned. You can ignore
>> the first two paragraphs of that reply.
>>
>> https://lore.kernel.org/r/87y0y4tf5q.fsf@suse.de
>>
>> I still think we need to test that preempt + multifd scenario, but it
>> should be easy to write a test for that once the series is in more of a
>> final shape.
===

* I thought that major overhaul of the channel discovery part by
moving it to channel.c was to be done subsequently, no? As we
discussed, we need to touch the channel discovery parts in
'migration_ioc_process_incoming' because, we need to identify the
Postcopy channel when its connection comes in. So the Patch-2 does
minimal changes that are _required_ to enable the two (multifd &
postcopy) features together.

* Whereas, moving channel discovery parts out to connections.c could
be done separately with its own reasoning that - we are moving it
outside to connection.c because it fits better there.

> Similarly, the multifd+postcopy enablement is a new feature that needs
> to be tested and reasoned upon in isolation, it cannot bring along a
> bunch of previously existing code that was shuffled around. We need to
> be able to understand clearly what is done _in preparation for_ the
> feature and what is done _as part of_ the feature.
...
> Not to mention bisect and backporting. Many people will be looking at
> this code in the future without any knowledge of migration, but as part
> of a bisect section or when searching for missing backports in the
> distros.

* I think we (you, me, Peter) are all looking at things differently.
    - In my view Patch-2 is the minimal change _required_  to enable
multifd & postcopy. In your view we are _revamping_ channel discovery
parts while _sneaking_ in a feature of enabling multifd & postcopy
together.
    - In my view Patch-5 in this series is an isolated change because
it adds a new migration command to allow multifd threads sync from
source side. But Peter thinks without that 'flush and sync' Patch-2 is
incomplete, so we should merge it back there.

* I've also shared my view about not trying to do everything in this
one series. I don't know how do we move forward from here. I'm also
not sure what the final _acceptable_ patch-set should look like. I
thought a tested working patch-set is a good start. At this point I
think I'll just follow your lead.

> I also suggested to move that logic into channel.c. The code is now
> well-contained enough that we don't need to be reading it every time
> someone is going over the migration flow, it becomes just a helper
> function.

* How exactly do we want to divide patch-2 to move channel discovery
parts to channel.c?
===
     if (!migration_has_main_and_multifd_channels()) {
     }
     ...
     } else {
        channel = CH_MAIN;
    }
===
Do we move this entire if - else - else block to channel.c from
migration_ioc_process_incoming() ?

> > ===
> > 67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             147.84s   81 subtests passed
>
> I see postcopy/multifd/plain hanging from time to time. Probably due to
> the changes in patch 5. Please take a look.

* Okay. Does it hang indefinitely or for brief moments?

Thank you.
---
  - Prasad


