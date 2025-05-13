Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E62C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEo72-00016z-RN; Tue, 13 May 2025 07:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uEo6u-00011x-Bi
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uEo6s-00024p-EI
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747136865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aVtBHmP8GZskniNPgSWFfh519F7zcuZa6yvwio2xwIo=;
 b=EZVC5jW9LqdSIHc7yT8Uv7PAKNxTTkqzCHGH2qYRjxoLQ6Y9FK1nFLzhpjhPhz12FZObJE
 HhD15TXiva0jS81CxO+iZ8i+EhNHViN+iPO2PF1n2b6TnEpCdly8NxaMoEuGvH+jDHkheD
 SYxqM2JWkjgIeEPLJcTBilhlJOSH4JE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-bhhh3aylMg2Fx6YwP6wvlQ-1; Tue, 13 May 2025 07:47:43 -0400
X-MC-Unique: bhhh3aylMg2Fx6YwP6wvlQ-1
X-Mimecast-MFC-AGG-ID: bhhh3aylMg2Fx6YwP6wvlQ_1747136863
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so26823935e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 04:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747136863; x=1747741663;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVtBHmP8GZskniNPgSWFfh519F7zcuZa6yvwio2xwIo=;
 b=ZiypZ1zFkW/d/+wrxAiMDtEgQeM0EXgZYXVO6vpTL5AgWbGNXKIznUT9cOVvX2xr56
 XYIWVwKcvvQAsbV0QZcWpz8q6PQVJrGroknLRBgBUFhZXgI5EraqTFR5afzBiIGrN7sr
 67zVVOyoHBTnNFWPXB5xQ0n7jsHjDQi0S/3X4sWfx/bfi6WY33vD3rWgQzH8mRqziTgq
 dJiTfS8JiZZ5Y/RY0WvNJRdFgMFGsaaK+3Dwye+OV6zwg8dgY7rZovMMrPSKNLkLfTvG
 mnDE+1N/3qphvg4fPA3yZiolClW+ocLi2hNgHd8upylInGUFua8eUeSYC/Ocf8valx8T
 0Vcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvl4q2aPfTXbvKeQ6i6hB39c76PK1O5rygXXsfF1pzzwUFN7jZskrq0oAuR05xrax+UwpGBGxHCObW@nongnu.org
X-Gm-Message-State: AOJu0Yw/va68ugyolglT9WXjxJnu1FhPAPcWnyusfUgJHEAGTgnasFnz
 koLIT8MDcASDOg74wqd1a4uIaomaYUghenmG1cxh4vDH03k6VZ3FVf1lAxgRe/3W5uH3ZANDaYC
 zT+bpDj394clmCOApTWt3H1PgTnkW2tu2HgeLM3UpSsl+j2RVRY4+
X-Gm-Gg: ASbGncsV8Sjau67BmBwXUfTEnegiXcPBIKk+CfH2rH182dnRVImUTF/ksGGF1+7u1Bx
 sYZz9bZbycZpIVtkOHamb+VZ5uRZpYfWe4//0nlnaZl2tasp7YrjmMDvkF8fz+gfIRLuelR+bz6
 0iyTEwHhJKG0IcfwhU/yTiJQL6NxlvuSJ0rLRDbGBEnMaeAuCQF2Cf6WwLkHSya3/QWlQRSTuL/
 SpmJP0swUDZDL7o6ABZzg7JWaVx3hMdnxnWdOkmdB8dnJk04ZOR3WdOAi6kj3NHANUfkfwvJjwf
 p+of2xARE0VHCj1aNdKO+geajdDpl0NEPCMfAEGhIVR/+BzW4w==
X-Received: by 2002:a05:600c:c07:b0:43d:300f:fa3d with SMTP id
 5b1f17b1804b1-442d6d18abfmr146275195e9.5.1747136862679; 
 Tue, 13 May 2025 04:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIqFlUMHW/YBiNrO+LIH4ntvgqbCtC6AV9Pg5qAuZ9pHF8ILsfZLLkBmAp5L3N07Iv122AMA==
X-Received: by 2002:a05:600c:c07:b0:43d:300f:fa3d with SMTP id
 5b1f17b1804b1-442d6d18abfmr146274905e9.5.1747136862248; 
 Tue, 13 May 2025 04:47:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb6esm210911845e9.25.2025.05.13.04.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 04:47:41 -0700 (PDT)
Message-ID: <4d74271e-93a4-49f1-9a56-2ea98b63d1d5@redhat.com>
Date: Tue, 13 May 2025 13:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 0/4] Report vfio-ap configuration changes
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250512180230.50129-1-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/12/25 20:02, Rorie Reyes wrote:
> Changelog:
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
> This patch series creates and registers a handler that is called when
> userspace is notified by the kernel that a guest's AP configuration has
> changed. The handler in turn notifies the guest that its AP configuration
> has changed. This allows the guest to immediately respond to AP
> configuration changes rather than relying on polling or some other
> inefficient mechanism for detecting config changes.
> 
> Rorie Reyes (4):
>    hw/vfio/ap: notification handler for AP config changed event
>    hw/vfio/ap: store object indicating AP config changed in a queue
>    hw/vfio/ap: Storing event information for an AP configuration change
>      event
>    s390: implementing CHSC SEI for AP config change
> 
>   MAINTAINERS                  |  1 +
>   hw/s390x/ap-stub.c           | 25 +++++++++++
>   hw/s390x/meson.build         |  1 +
>   hw/vfio/ap.c                 | 82 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 22 ++++++++++
>   target/s390x/ioinst.c        | 11 ++++-
>   6 files changed, 140 insertions(+), 2 deletions(-)
>   create mode 100644 hw/s390x/ap-stub.c
> 

Applied to vfio-next.

Thanks,

C.



