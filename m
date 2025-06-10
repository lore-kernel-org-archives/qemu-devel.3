Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEC6C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2xs-0005m7-JN; Tue, 10 Jun 2025 13:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uP2xm-0005ga-9S
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uP2xk-0006uA-5h
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749577238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cv5bFESViWjPQpudrTI1BaWx/AAFR14EMHqwol6BU8U=;
 b=G6fDnx5Qm7KAj1kVDGcsrtCOkRcaG5iiRRlh9bXv/vj9/1gaP6ogt8nX9gRLMNOn+/X2sY
 TAnTqzZfCr+JV2KecTs9ibIN252IycfDrQMTqxIlh7zyzormemD6/yuWUacMeUi9LM13cx
 88Dh92LSQycr4Q8O9Jt5A/ian4e/Lmw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-JlSOVgHfPWuIyNeqzruErg-1; Tue, 10 Jun 2025 13:40:37 -0400
X-MC-Unique: JlSOVgHfPWuIyNeqzruErg-1
X-Mimecast-MFC-AGG-ID: JlSOVgHfPWuIyNeqzruErg_1749577236
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450df53d461so50002555e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 10:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749577236; x=1750182036;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cv5bFESViWjPQpudrTI1BaWx/AAFR14EMHqwol6BU8U=;
 b=V6KIKk43Yw045GvdFC9GDNR+VyiA20hCJBbk1OrtM41G+hlg7xHQ+xQ2lroQ5DNi/d
 gFOt4ttgfbxokBJFZ+CecM1A0W7+n+vTbcYAp6aY4M508fspAH3srm14xvd2TUbtqBXk
 r/buDjr+0Sfk0Q68eti1onpv8UDqZzk7lsdAJWdc/ruNC1XVT6zI+iO+SPPHTF9ZOgMv
 osyNRpEoF/9etgDgy5f8bxMaSv22uyzeMSNThaYIOYlvXs+q3EVM+IKoKz/bC4DmfQz4
 myCCHBY9oVjBpw1jle71f7wwJs2fCu0lUa9YDJmaLwDQRG+TL6NiKtxKivotD9fMLlNM
 glEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8hSdI95AdaDyySsQA1Pl/BFgo+mJFcpHRVf2Z4S3ZFqVJKmDyFYfzBSBikPP9h5wxCnh5SROftGPg@nongnu.org
X-Gm-Message-State: AOJu0Ywik4RAEsGvpnd16fxV7F6e5ou/XtdUUrclEjXy1ZzHxggrNx2a
 OYFPZYdO3Y4fmZQKvxytJ/oS4JCItAAKW9vipLitEBDBJ0SD9x1vzGE6oXVW5uz5twTqfGl9OsP
 /NQgZOmty5ZegtVu/sLDXnN458Q6UHcb87Q8v8xOMCRhG/KrkVptCRFxt
X-Gm-Gg: ASbGncupa9nAPmCtvK3zuNIpHgC2EIO9S518b3fVUm4VmUKqmJLKx7wvCi+NDG9PXa7
 mVcRGbeEaZ3udGcEW7vTLVIgZIMuN9w1SFw6cIfuHcuaaLKTcvmawZmQLrOzikRvlqosjiwXcUZ
 MC3T23iLMfYiVZ1QPnQjbCGZ8MhwrHFiitt9wInh1gHHv/6IaPhvx2T8nMQH/4KLP5XX/8wTjUc
 xVlG+E9EjRoYxcjfgFWWT5neiTZY+vcVIRv09tWHK+0JyUbb8hsDOZleomLskqYkXjjAZzwtEE6
 zKe0+rZsv8fVbUcdJ29ml791k1seRfgUt+8404yli1Edes9MSrEvg9HxWnSG
X-Received: by 2002:a05:6000:2c11:b0:3a5:27ba:47d0 with SMTP id
 ffacd0b85a97d-3a531cb25demr16312077f8f.56.1749577236473; 
 Tue, 10 Jun 2025 10:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaT86nKaX8NfqTvT+9gkRcezHeUDklDcq35cwBbF8c94/79mkIlu7dKtsVMr8+umq4N+oN3w==
X-Received: by 2002:a05:6000:2c11:b0:3a5:27ba:47d0 with SMTP id
 ffacd0b85a97d-3a531cb25demr16312058f8f.56.1749577236018; 
 Tue, 10 Jun 2025 10:40:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244df34sm13049971f8f.71.2025.06.10.10.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 10:40:35 -0700 (PDT)
Message-ID: <222271f8-3db7-4b75-b95f-c509a925c6f1@redhat.com>
Date: Tue, 10 Jun 2025 19:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v13 0/4] Report vfio-ap configuration changes
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250609164418.17585-1-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250609164418.17585-1-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/9/25 18:44, Rorie Reyes wrote:
> Changelog:
> v13:
> - added lock to 'vfio_ap_cfg_chg_notifier_handler' in patch 2
> - added RBs for patch 2 and 3 from Tony
> 
> v12:
> - adding locks to 'ap_chsc_sei_nt0_have_event' and 'ap_chsc_sei_nt0_get_event'
> 
> v11:
> - reverted return type to int for 'ap_chsc_sei_nt0_get_event'
>     - files reflected are 'ap.c', 'ap-bridge'h, and 'ap-stub.c'
> - using defined variables to represent return 0 and 1 to reflect logical sense
> - update documentation for 'ap_chsc_sei_nt0_get_event' to reflect return types
> 
> v10:
> - Added reviewed by for patch 4 by Tony and Cedric
>     - review needed for patch 2 and 3
> - changed 'cfg_chg_events' to a static variable
> - locked 'cfg_chg_events' using QemuMutex
> - removed ';' at the end of the definition for NT0
> - returning bools for 'ap_chsc_sei_nt0_get_event' and
> 'ap_chsc_sei_nt0_have_event'
> - updated the header file that contains 'ap_chsc_sei_nt0_get_event' and
> 'ap_chsc_sei_nt0_have_event' to a bool function
> - added documentation explaining the returning bool functions
> - whitespace clean up
> 
> v9:
> - added SPDX licensing to newly created file 'hw/s390x/ap-stub.c'
> 
> v8:
> - fixed windows cross-compile build
> - moved /hw/vfio/ap-stub.c to /hw/s390x/ap-stub.c
> - updated the use of stub file to MAINTAINERS to reflect new location
> - removed if_false for 'CONFIG_VFIO_AP' statement from /hw/vfio/meson.build
> - added if_false for 'CONFIG_VFIO_AP' to use ap-stub.c in /hw/s390x/meson.build
> - all those changes still address '--without-default-devices' issue from v5
> 
> v7:
> - Dropped initial commit for linux-header file vfio.h since I created two new commits
> to address the changes made in v6
> - Moved patches 6 and 7 to the beginning of the series after dropping the first patch
>     - Because I dropped the initial commit for linux-header file vfio.h, I had to add
> VFIO_AP_CFG_CHG_IRQ_INDEX
> - Resyncing latest to v6.15-rc3
> - Still need Thomas Huth's review of v5 changes for patch 6/6
> 
> v6:
> - Updating the update-linux-headers script to address kernel commit change 8a14
> - Update headers to retrieve uapi information for vfio-ap for update to Linux v6.15-rc1
> - Still need Thomas Huth's review of v5 changes for patch 7/7 (see below)
> 
> v5:
> - configuring using the '--without-default-devices' fails when building the code
> - created a stub file for functions ap_chsc_sei_nt0_get_event and ap_chsc_sei_nt0_have_event
> - add if_false for 'CONFIG_VFIO_AP' use ap-stub.c in meson.build
> - add the use of the stub file to MAINTAINERS since it's a new file
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
> 
> Rorie Reyes (4):
>    hw/vfio/ap: notification handler for AP config changed event
>    hw/vfio/ap: store object indicating AP config changed in a queue
>    hw/vfio/ap: Storing event information for an AP configuration change
>      event
>    s390: implementing CHSC SEI for AP config change
> 
>   MAINTAINERS                  |  1 +
>   hw/s390x/ap-stub.c           | 21 +++++++++
>   hw/s390x/meson.build         |  1 +
>   hw/vfio/ap.c                 | 88 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++
>   target/s390x/ioinst.c        | 11 ++++-
>   6 files changed, 159 insertions(+), 2 deletions(-)
>   create mode 100644 hw/s390x/ap-stub.c
> 


Applied to vfio-next.

Thanks,

C.




