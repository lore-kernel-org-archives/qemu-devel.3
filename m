Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D195C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 03:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reRjv-0000oa-Na; Sun, 25 Feb 2024 22:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reRju-0000oH-4O
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 22:33:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reRjs-0002YQ-Mv
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 22:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708918391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5i9T5i7yljMwNBMVo4eYZVc+eAF+mvVLs+opWsuOr0=;
 b=dp9Bxa0HsdHf3a0KtuDbxnXE0Cra771vYRfMzFFaO/80h4CVfv1dLnXdG1utz2Aip37mLf
 IyAZ8YLSgMMkSMldmqrfzfwP8E508a2HHeg32o2Wd+itVWUBTr+iQkfz4HDAGArUUStgRE
 uEstzKmCB3mPvvSB5NEHcVQfX/HRynY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-EzTm-g2ZOi-4rffpTsETyg-1; Sun, 25 Feb 2024 22:33:10 -0500
X-MC-Unique: EzTm-g2ZOi-4rffpTsETyg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5a01c10bd75so1376380eaf.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 19:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708918389; x=1709523189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5i9T5i7yljMwNBMVo4eYZVc+eAF+mvVLs+opWsuOr0=;
 b=T+QDO34b3mgwTEoMtRQpIgBHM8zgn1kJgIAgNTd45TQrm0gSLnn0kZuy02phyqjxV3
 30F/HW3OkM8f4gdaBNH1e29+aZfqOF3JgFsl754xOIQr/hAb61DxaJcEP+d2VoRHP0y9
 ceaMAIodtS8N3TAp+Dk6BIRjjzOwRXXtjXwoFdEgI62MIMOCPVDUcgJDbJhoroQM2AUd
 y019T8Uati6htO5kSkg9nBn2fWHqYR6sgBbVCJ28A5wGzWmhQCJBi4Ju+VdGp1naOEol
 Mi7gVDteGbCzrKJV+RLAL+vWcZnbUjQjkkYb2JDOBtt3RvCWEzJUZ020LaGvcqswaIFP
 uMZg==
X-Gm-Message-State: AOJu0Yz+6Jbto9yAqzaH4VzTTyWiwoqjo3kBdpyv2HihKo4MeqhIA8HA
 B/jJoaJ+eBKE2n9//Rzje97cH8mPYHYndZ2rjn+7wGY1Bj0ZfSj33HzADZiWmyr5dIgzZWR7d7Z
 IIPIX7ymz9UYFa9ZVZrUAz4YrSd8IfQbL9AedcLhLFLoYnfE/BkiP8Sx0jSWn4oooRRLrvmS9C9
 c/ujjOOr0L8PbF1eGHFr6bRyHe6+SxCN6sCFdg
X-Received: by 2002:a05:6359:4588:b0:178:b44b:1b5f with SMTP id
 no8-20020a056359458800b00178b44b1b5fmr4368891rwb.0.1708918389235; 
 Sun, 25 Feb 2024 19:33:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXe+mNOjzw3IF62yhGSwq/Rp3LluTCVcw6RfMYiKvUWOZwc1K1eGcwrFkP0TPg1VqMgAQ8Dw==
X-Received: by 2002:a05:6359:4588:b0:178:b44b:1b5f with SMTP id
 no8-20020a056359458800b00178b44b1b5fmr4368871rwb.0.1708918388845; 
 Sun, 25 Feb 2024 19:33:08 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 jw13-20020a056a00928d00b006e506cf450csm1777433pfb.181.2024.02.25.19.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 19:33:08 -0800 (PST)
Date: Mon, 26 Feb 2024 11:33:02 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/5] migration: cleanup TLS channel referencing
Message-ID: <ZdwGbpnABAMChw_9@x1n>
References: <20240222095301.171137-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222095301.171137-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Feb 22, 2024 at 05:52:56PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> v2:
> - add patches
>   - migration/multifd: Make multifd_channel_connect() return void
>   - migration/multifd: Cleanup outgoing_args in state destroy
>   - migration/multifd: Drop unnecessary helper to destroy IOC
> - fix spelling
> 
> This is a small cleanup patchset to firstly cleanup tls iochannel deref on
> error paths, then further remove one unused var on yank if the cleanup
> applies.  In v2 three more small cleanups on top as suggested by reviewers.
> 
> Please feel free to have a look, thanks.
> 
> Peter Xu (5):
>   migration/multifd: Cleanup TLS iochannel referencing
>   migration/multifd: Drop registered_yank
>   migration/multifd: Make multifd_channel_connect() return void
>   migration/multifd: Cleanup outgoing_args in state destroy
>   migration/multifd: Drop unnecessary helper to destroy IOC

queued.

-- 
Peter Xu


