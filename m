Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BFCC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMS3-0003HV-4e; Wed, 12 Mar 2025 09:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tsMS0-00038q-Jh
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tsMRx-0005z0-PW
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741787323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xGKWdCpco47VRyv2Aca0AhtduTJtorMhL5Wh+x3K7Gs=;
 b=CNiz7jzToTwWfx2WOFhkCHlh08NU9Ly980+xKJ1uUMP8bK0bzaFp5yUnpXAsNM/uZWspfw
 AUW6yTVCWf405aUawq1b7f4EGVEQCT2ahU1FEsa3DiqHpIqdCgMtjDxMFuW5TU1ecrocQK
 A++d7xp8zHs3yKNdKb6EyBfSWgD9KyQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-iExQ5adWNgiC5wb9gXb-gA-1; Wed, 12 Mar 2025 09:48:40 -0400
X-MC-Unique: iExQ5adWNgiC5wb9gXb-gA-1
X-Mimecast-MFC-AGG-ID: iExQ5adWNgiC5wb9gXb-gA_1741787320
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d00017e9dso15720095e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741787319; x=1742392119;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGKWdCpco47VRyv2Aca0AhtduTJtorMhL5Wh+x3K7Gs=;
 b=iFs1RzGObMKN19x37hgLTAZbg18voEWDw4f+UvmyxOALUC4hwAN9ZuNAaSXSnqY5KY
 Tm3GUUKO4mreuxI1BFDUccBitgbCL55EvSDg8F/P9UjCweJwwnUniHmXKU/95Pxz6D6H
 yDr2rAR/BrYw6lPrfSMYGmuk8HP5P2j5TC39VLVSsJTYhMN6wH7ofygDdEjc+MZIRq6Y
 5Hdw+XxDKDJeX50W/IBFCagvg2OzcDwwk79CkMClPIDoNHyb5ADCqmGh1J4nLUWiG2WY
 TbmkW84e5a4v/iC8gq1hTR2eVWRR+pM3Vso+t2SR+as84RVbnS5eN1LT+UshR+L0+Bnt
 3rzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzXmgDWI/DbYPLjbH53eImCZJIE633+UPig/LhXgzb/rlhxmUccN9/NRDwF3Mejod/aJHMu0ssttAf@nongnu.org
X-Gm-Message-State: AOJu0YzpGOv/wRgmieCBMHBHtxmzsmgVDo4fE0vn4XpGmQ5NY+YdAti9
 ap5lJK3FDbqKn+S6qTcGfUvQaZDR4vHcYhpoyVYAn95HEYS28H+Rcsh6wYgzPxg8WTav3pLn+jF
 fejz7Nk0QBEJaPgKo5VIPeAOyewxF0PAtgLW6aLzZvRwN1ri8LVUA
X-Gm-Gg: ASbGnctBb+h7KIU5dbs+sectmdq03CrXTfDDkVPAGZgTOvZ6iRCF6IM1bJyROq8JsL+
 s2ZINzZ0nUFDv6lIdu9rYeaGlE1+9YJ0QHBK7NbOBZLxbFR5Hq/vyfvhSX4GsVjSfjsKwYg0hHr
 uLiieS032X9VQD+6TwdPDkRx8vbfC3uUEVYwQuY4HW+h6+MS7UdwicBeCWUqi17I71/qiNO0Kh/
 IgygpLp0kBL81k9AYKmL0AVkn2oOVKcXCTCJZK5UX1hlU5hN0H6tciM8av69X71sSYg2wUOiVjT
 jWaTYRxV3g9mSWLO2b8maUleppQ0v9EUGPqrXoGZe5FYxsLOX62xmw==
X-Received: by 2002:a05:600c:1c14:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-43cf0ae15acmr126009275e9.7.1741787319665; 
 Wed, 12 Mar 2025 06:48:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMZBa9xNt0L32CQMSyR6UfJEG2FcTR/yXrCBcTggWrytEefZaZplzFKARlBxj4MWoqB2de/Q==
X-Received: by 2002:a05:600c:1c14:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-43cf0ae15acmr126009085e9.7.1741787319304; 
 Wed, 12 Mar 2025 06:48:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8c5d04sm22494175e9.27.2025.03.12.06.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 06:48:38 -0700 (PDT)
Message-ID: <3137b135-6db6-4c41-929c-2ef4b86d66dc@redhat.com>
Date: Wed, 12 Mar 2025 14:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/5] Report vfio-ap configuration changes
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250311151616.98244-1-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/11/25 16:16, Rorie Reyes wrote:
> Changelog:
> 
> v4:
> - allocating cfg_chg_event before inserting into the queue
> - calling nt0_have_event in if loop to check if there are any
> elemenets in the queue, then calling QTAILQ_FIRST when the check
> passes
> - moving memset() after the check
> 
> v3:
> - changes that were made to patch 3/5 should have been made in
> patch 2/5
> 
> v2:
> - removed warnings that weren't needed
> - added unregister function
> - removed whitelines
> - changed variable names for consistency
> - removed rc variable and returning 1 or 0 outright
> - reversed logics for if statements
> - using g_free() instead of free()
> - replaced hardcoded numeric values by defining them with #define
> in the header
> 
> --------------------------------------------------------------------------
> This patch series creates and registers a handler that is called when
> userspace is notified by the kernel that a guest's AP configuration has
> changed. The handler in turn notifies the guest that its AP configuration
> has changed. This allows the guest to immediately respond to AP
> configuration changes rather than relying on polling or some other
> inefficient mechanism for detecting config changes.
> 
> Rorie Reyes (5):
>    linux-headers: NOTFORMERGE - placeholder uapi updates for AP config
>      change
>    hw/vfio/ap: notification handler for AP config changed event
>    hw/vfio/ap: store object indicating AP config changed in a queue
>    hw/vfio/ap: Storing event information for an AP configuration change
>      event
>    s390: implementing CHSC SEI for AP config change
> 
>   hw/vfio/ap.c                 | 82 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 22 ++++++++++
>   linux-headers/linux/vfio.h   |  1 +
>   target/s390x/ioinst.c        | 11 ++++-
>   4 files changed, 114 insertions(+), 2 deletions(-)

Queued 2-5. linux-headers should be updated in the QEMU 10.1 cycle.

Thanks,

C.



