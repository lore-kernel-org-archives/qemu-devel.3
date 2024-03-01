Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA314C54798
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 02:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfsRx-0005D4-7a; Thu, 29 Feb 2024 21:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfsRu-0005Bp-T7
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfsRt-0003Ds-4c
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709259391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5N80RBWPqVV+IIPJyw+czTFh0k8pWe0GFBhA+4VJGk=;
 b=Yeabvj5qZLgL8mYGih5wOA7KzB1b8Ing6OqRus/TUlUynsoV92LndfeGS/W79DoWET7DtW
 tQesRMgMGiOsGnI9HrrxhLhPsHSyq13rMqyFqrEiOnJP749e7xoaOOYwdYNbafnBOHQWBw
 pOsZeqwxw6vNz54sqQc7ZVX+UHmAyDI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-2Xxqu84jMRG6t652mQkSvA-1; Thu, 29 Feb 2024 21:16:30 -0500
X-MC-Unique: 2Xxqu84jMRG6t652mQkSvA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5dc97ac2facso558681a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709259389; x=1709864189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5N80RBWPqVV+IIPJyw+czTFh0k8pWe0GFBhA+4VJGk=;
 b=gFN2p2xhvXQHfxp3KPKQnpbCBL2m2yeeugmg3wa7uGPe3ynZHA0GBxHNleyFtGVsqz
 xB/BtWfBXCrBgg7gwHDz4NtuW/5iyif4Qlv1d4GpZQEXViHmtD68IxjDep9VnZVoSop3
 ymGxLeW63NaSbjsm3mvA6idSsiNf5XqmXtKGpvoy1RiQLx0+ryVeUm2YuuI4K427Bnpz
 SKjIu4GY7Y18/zw79zaDPelYU198EXptKnsu4jJupSP8bC8Q4eHMcF69q19guMyDtugB
 Qq9POvTJtrI1L7J8PjjSzCJ1foaAfUh1UfUkJez8bBSrUiEcMBzcyxwks4mY7YPgKfFz
 qQlQ==
X-Gm-Message-State: AOJu0YwP3JLWmslYa/OAQCXf8t76gTW2EdVq6+ctq0X0ignQITLVr6Iy
 KYUKn0+Jk5yrjtRWjNOphm3MiP4J3EHn3R+KHDn4pWdj7+fLw2F4iHNpeNEuwSypMindiNslR99
 E0vy7zeDkWaiHdepTptz1biel3/l4gPtZvh8Pdj3mA+tzowl81mNI
X-Received: by 2002:a05:6a20:65c:b0:1a1:15e1:da14 with SMTP id
 28-20020a056a20065c00b001a115e1da14mr217562pzm.0.1709259389188; 
 Thu, 29 Feb 2024 18:16:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaGosygh4jKIboYg5mJteQdV6UbuL7MVYI9rzqvfzKL8Nd/hG63wlsWlhfA68g5ch15FgBUg==
X-Received: by 2002:a05:6a20:65c:b0:1a1:15e1:da14 with SMTP id
 28-20020a056a20065c00b001a115e1da14mr217554pzm.0.1709259388888; 
 Thu, 29 Feb 2024 18:16:28 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902e5c800b001dca6d1d572sm2201775plf.63.2024.02.29.18.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 18:16:28 -0800 (PST)
Date: Fri, 1 Mar 2024 10:16:21 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2] migration: massage cpr-reboot documentation
Message-ID: <ZeE6dXIy521fqzuz@x1n>
References: <1709218462-3640-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1709218462-3640-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On Thu, Feb 29, 2024 at 06:54:22AM -0800, Steve Sistare wrote:
> Re-wrap the cpr-reboot documentation to 70 columns, use '@' for
> cpr-reboot references, capitalize COLO and VFIO, and tweak the
> wording.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

queued.

-- 
Peter Xu


