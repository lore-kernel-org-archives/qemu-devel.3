Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D0ACFC50A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 09:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0H0v-00060E-S2; Mon, 14 Oct 2024 05:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1t0H0j-0005vu-QO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1t0H0h-0002Rf-PJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728896699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QTMfZRCJOIL2NoWmUxRWYQxPyttb9kDTXib0osKSwiM=;
 b=RJ5gCHKuo0y+LPainMANgB6mlGQhSOOMN8Q5kbs+ePsj2DDMuXs4e7fiXy2oPVkXY503Ya
 OcPRV+9pckTZ+LDZGoNvPEJUH2jinis/eORzlZrvzZ8atwgmiB9k9mWYsa7m2PdauVAIb4
 CO4eianhTXidmS6NZOxV2X0YL0xqZoQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Jevscm7_Pg6HW5X5YBHhJQ-1; Mon, 14 Oct 2024 05:04:56 -0400
X-MC-Unique: Jevscm7_Pg6HW5X5YBHhJQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4311c681dfcso20612965e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 02:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728896695; x=1729501495;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QTMfZRCJOIL2NoWmUxRWYQxPyttb9kDTXib0osKSwiM=;
 b=sP9t2AjA/JmB1ERrowAbpEyzWbTuVO4D/mRk/DnPpCMRQjDx8RC7BLIC/FtntgYLRF
 p5vKNTrDjRgCWf4oeqN5a/dxtkk/n5LhcYc+usXQ7ThfycK9sZQRs9OHbs6bB3kiqTeu
 GNDu81jcgHKg/EIjLxzL5o48krpvHyW3d7XHN7tH2+OVfMnjIAZM5ULnn8JziWkSp2ry
 jce5xs91J6VvKj2+VJAYR75LiLzMXeOSzxRMooM7CPNglk1sRy8xtoFHNSWooZpPJmOc
 VqyEH9jiaQjh4YQC43lqG2xFym/5SJDM/v0QYDMB7as3AyLLjKrvdfT86xJ1MS8xowYM
 S+lQ==
X-Gm-Message-State: AOJu0Ywv02M4dD2DZvV4SzeYbbzFSgr1eMysItLloAKUIXAKwr479qCv
 v5Q7Qx3K7bBEm/UyY14jSQcl5bNK8ohqQetm1KAIvUypd2olWnS8AIVNYUbYzIbW5AYXDwdSQm7
 Rcm9QY9OwgfEL4bQ6IbHPUjkpEyiZd9NFyBF2ld0vMhkLHDWltVE875NSSQ3rWtuFzNosQ7Gcod
 8mAIRAkCw9J+1hFoCAhSB56zwoKec3cVrtkMCv
X-Received: by 2002:a05:600c:468b:b0:42c:ba1f:5482 with SMTP id
 5b1f17b1804b1-4311df56381mr81806015e9.35.1728896694852; 
 Mon, 14 Oct 2024 02:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy8VsCa7toXQBtbXpH7TGIQns4USVMOjXOSATBDYQ5qKDC5Lnq0cUzIpfm0DmmE49/ZBIw7w==
X-Received: by 2002:a05:600c:468b:b0:42c:ba1f:5482 with SMTP id
 5b1f17b1804b1-4311df56381mr81805785e9.35.1728896694420; 
 Mon, 14 Oct 2024 02:04:54 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf51753sm146437325e9.23.2024.10.14.02.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 02:04:53 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RESEND v4 0/4] target/i386: Various Hyper-V related fixes
In-Reply-To: <87y139jlcz.fsf@redhat.com>
References: <20240917160051.2637594-1-vkuznets@redhat.com>
 <87y139jlcz.fsf@redhat.com>
Date: Mon, 14 Oct 2024 11:04:53 +0200
Message-ID: <87plo3f422.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>
>> Changes since '[PATCH RESEND v3 0/3] i386: Fix Hyper-V Gen1 guests stuck 
>> on boot with 'hv-passthrough':
>>
>> - Added "target/i386: Make sure SynIC state is really updated before KVM_RUN" 
>>   to the set.
>>  
>> This is a long pending collection of fixes for various Hyper-V related 
>> issues, mostly detected by tests. On top of that, the patchset updates
>> Hyper-V related documentation adding recommendations.
>>
>> Vitaly Kuznetsov (4):
>>   target/i386: Fix conditional CONFIG_SYNDBG enablement
>>   target/i386: Exclude 'hv-syndbg' from 'hv-passthrough'
>>   target/i386: Make sure SynIC state is really updated before KVM_RUN
>>   docs/system: Add recommendations to Hyper-V enlightenments doc
>>
>>  docs/system/i386/hyperv.rst | 43 +++++++++++++++++++++++++++++++++----
>>  target/i386/cpu.c           |  2 ++
>>  target/i386/kvm/hyperv.c    |  1 +
>>  target/i386/kvm/kvm.c       | 18 ++++++++++------
>>  4 files changed, 54 insertions(+), 10 deletions(-)
>
> Ping) Some of these patches are really getting old :-)

Ping)

-- 
Vitaly


