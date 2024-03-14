Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402F3C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmv2-00078c-0J; Thu, 14 Mar 2024 11:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkmuz-00078J-Av
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkmuw-0003iL-Qs
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YBLsaHQRWmgI5xtRyjnZlSrZ5Mfmm95p7kFi0A/ame0=;
 b=XQCtsBoCQFQlIHUYZEpWLDm0nLc5Ujb1FfvWHCbK9o9oCKxLORpdEL0eJQpb51DFI6rhoe
 4IFqg85uucCU8Xe8HNY+syQ+/2kI+vq/oe1m8A6gmepwSbf1lvKm2JtfGtY133crROKLSU
 451PcpTRYgkmxt987lf24Tk9/2JPFCk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-UhLMvhIsO42Mzhwjdhgg5g-1; Thu, 14 Mar 2024 11:22:46 -0400
X-MC-Unique: UhLMvhIsO42Mzhwjdhgg5g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-690d3f5af86so3691406d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710429766; x=1711034566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBLsaHQRWmgI5xtRyjnZlSrZ5Mfmm95p7kFi0A/ame0=;
 b=D1IeFXZSCiyUOchjjq9s1vVsCtQaymZssAp3LEF0uX5LWfkANTyBZetwIdqL+/w66s
 0FAhk2KITeIkee54E7N+jYKSfwyoUgh7ovmyOyp0FafvAUW8hebFcS1hADO1NejFZesX
 KEqAFo2+8eJJVxJwyE5+WrdpSx/e0m7fpXEB4qSMJJ5If64Jihf97p6fOnJ5VmGX9hJf
 uQhl5JjYKMM40iytV43PWB//Mtb7ZAQTAKbj1AsZ0GMv/o80ItypikkuHzDf9MKhQ+rT
 7j8zjUEZZV/j+dFyEPmMFKy+tJdS5dwcS7TQ6hcsTfyZE4GocrYpPAVySgoO2A3RTP3L
 X/Qg==
X-Gm-Message-State: AOJu0YxC1FM34tdoTK/GM8IuTS4aeuWLzZuG+30b+lgM5hmpb/oR4fQw
 bj3hx9DS0nuNsXug4MHnQ/rCmP5HgLdMeDpzYTHGpfcMNO0Em/BwwP4qb+ntGVhaIa4QMi5Ub8e
 PWTBTDc7akrP6LTk+xD/Fl/Xfw8o32XRUCaW8Vy8LI8c5QUFmbLhj9HVmFUTQ
X-Received: by 2002:a05:6214:2b87:b0:690:d74d:7e6d with SMTP id
 kr7-20020a0562142b8700b00690d74d7e6dmr2111552qvb.3.1710429766057; 
 Thu, 14 Mar 2024 08:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrgr8ZehAZbR6Bcchlz4mFY+tU2MLAQmy9t1bwtYO1AAGIjwUoXsvYUT0fzokglRpQz4nbfg==
X-Received: by 2002:a05:6214:2b87:b0:690:d74d:7e6d with SMTP id
 kr7-20020a0562142b8700b00690d74d7e6dmr2111534qvb.3.1710429765625; 
 Thu, 14 Mar 2024 08:22:45 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 9-20020a0562140d4900b006904d35e1c6sm577741qvr.58.2024.03.14.08.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 08:22:45 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:22:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/2] migration mapped-ram fixes
Message-ID: <ZfMWRBDN4wPQsOWI@x1n>
References: <20240313212824.16974-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240313212824.16974-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Wed, Mar 13, 2024 at 06:28:22PM -0300, Fabiano Rosas wrote:
> Hi,
> 
> In this v2:
> 
> patch 1 - The fix for the ioc leaks, now including the main channel
> 
> patch 2 - A fix for an fd: migration case I thought I had written code
>           for, but obviously didn't.

Maybe I found one more issue.. I'm looking at fd_start_outgoing_migration().

    ioc = qio_channel_new_fd(fd, errp);  <----- here the fd is consumed and
                                                then owned by the IOC
    if (!ioc) {
        close(fd);
        return;
    }

    outgoing_args.fd = fd;               <----- here we use the fd again,
                                                and "owned" by outgoing_args
                                                even if it shouldn't?

The problem is outgoing_args.fd will be cleaned up with a close().  I had a
feeling that it's possible it will close() something else if the fd reused
before that close() but after the IOC's.  We may want yet another dup() for
outgoing_args.fd?

If you agree, we may also want to avoid doing:

    outgoing_args.fd = -1;

We could assert it instead making sure no fd leak.

> 
> Thank you for your patience.
> 
> based-on: https://gitlab.com/peterx/qemu/-/commits/migration-stable
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1212483701
> 
> Fabiano Rosas (2):
>   migration: Fix iocs leaks during file and fd migration
>   migration/multifd: Ensure we're not given a socket for file migration
> 
>  migration/fd.c   | 35 +++++++++++---------------
>  migration/file.c | 65 ++++++++++++++++++++++++++++++++----------------
>  migration/file.h |  1 +
>  3 files changed, 60 insertions(+), 41 deletions(-)
> 
> -- 
> 2.35.3
> 

-- 
Peter Xu


