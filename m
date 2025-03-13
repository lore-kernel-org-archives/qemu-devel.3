Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B451DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsl2W-00053K-Sz; Thu, 13 Mar 2025 12:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tsl2C-0004am-Bi
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:03:51 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tsl29-0008Cz-Rf
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:03:47 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso2422612a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741881822; x=1742486622; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sIkb5arOEkqODDz9dzsL9/lmEx2EyxAguJsBahIivbs=;
 b=hp0uakgUeDlaXNK8comNUb65yt0N0javJwqGOzO3at8IM5yV3XTcuAoi1yuqZRZvju
 rKSUJDA3O+XxWmG3krZtx/sKOFj1buxK/c7eeZP4YMBGbZYAtYL1TW9gTXjueh9LafZZ
 Eujsq8lcVAb5AeD6h/ZclejJVzLehUnbtLsy5dHFV4WE/vzh6wkedY4zGhtUI78vOCSE
 mO9OA0SZ0VUz2k3TQx8cNb+xwZ38NPVVvRYhG+xhrbMdeo+cl7+SkrMVTKzRG0q9NxWp
 35RX0WOmLAORjWZ+YRV6jcBwSvOdb29R+7T1t49As0oujLp7a2eThGINdMUXZI28bJLT
 39Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741881822; x=1742486622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIkb5arOEkqODDz9dzsL9/lmEx2EyxAguJsBahIivbs=;
 b=IzuFBLYG8mgMZPvqg6vwfJNWnySp1cFjcFELPqZQP0NXIT/kfrz0h3w166hAie6Yrx
 bJfeXSUOqsKnIDBXIpR5c+QGT0cyZH9TjGAN9wOXuYSWHVvqyqH/YoDy3Wah9ikRMmnO
 DOy9/aBR33vQD9swFX6WoCPEre1txqqU/BGHIfsRvmNrixtlhkYmHzmCaGLe8gg2LVdN
 R2YG1Xx3K0edJFSiJTLyWGi+LqeAGFdMji4Hks/rppdK8BMSq+a+fqfpR2Modw23E5I9
 4fRaC5veY3HdxXc9A3gOfmkDp1W8aELCM55SySC+S3QBnfx2E8CidsJ5lsYqtRPBMD9O
 ItXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuvr3I0CsLBpwaEhP2cbGwfZmZq8kNVanYEpQxkx/0Whc0ZIpwiz/4Mj3lWWXXEnoaXLqE3eTss5j1@nongnu.org
X-Gm-Message-State: AOJu0YxXpBkTFrj5hekaJJayf/sd6eCGu4YGuUc5FddXx0RK0EHEqsn7
 Wm2mpOlQtMEgjLMki30F4PupJ4ZR3SC9WPemzqUbAgLnKNtTd2Zu
X-Gm-Gg: ASbGnctokm2VgRs9+aWlfCCbtxyqbkBxX/TEzUaftdC4To/enCMj0Xa05EnT57pnuu2
 /ixNEVC/Eh8aKPFJK3aCME4LR2MvdWPW9CIlouj00vo1NBWxmLDFah2p6uB8RzuWbos7V0EDMHT
 ax4a8rR0zQNQPxcJN6xbyDs4EdTwjgEB9TfHCGCnKW+fZvpzd8ipDTTUXZuEt7DbnS2fG/R9f2O
 /zOofCysqvzcCtWY98dJi+Sctdy1LS6Rj7XJg8SGlFBr8u6Wc8ufSXziV4Oxt5sXPgX5noF+pyq
 njdubE3DTlZjGewQzZKMflS+NSDx73pI3k2Fu8X+/+itXgcFzA==
X-Google-Smtp-Source: AGHT+IFUWruZuGkMW1jbmnyjoZN66WwgopSQq4sJ/Fn8+F7Mq8lCY19EnN8b/20bLhsAxbkUdjfqew==
X-Received: by 2002:a17:90b:2802:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-3014e861a2dmr108612a91.18.1741881821778; 
 Thu, 13 Mar 2025 09:03:41 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:1e89:f144:8d88:9d5c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30138b3b2bdsm1688969a91.5.2025.03.13.09.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:03:41 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 13 Mar 2025 09:03:37 -0700
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Junjie Fu <fujunjie1@qq.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, viacheslav.dubeyko@bytedance.com,
 zhitingz@cs.utexas.edu, svetly.todorov@memverge.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su887@gmail.com,
 dave@stgolabs.net
Subject: Re: CXL memory pooling emulation inqury
Message-ID: <Z9MB2bl2mUXjgetJ@debian>
References: <20230215151854.00003e34@Huawei.com>
 <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
 <20250312180543.00002132@huawei.com>
 <Z9HheFFgOdGE9BcW@gourry-fedora-PF4VCD3F>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9HheFFgOdGE9BcW@gourry-fedora-PF4VCD3F>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 12, 2025 at 03:33:12PM -0400, Gregory Price wrote:
> On Wed, Mar 12, 2025 at 06:05:43PM +0000, Jonathan Cameron wrote:
> > 
> > Longer term I remain a little unconvinced by whether this is the best approach
> > because I also want a single management path (so fake CCI etc) and that may
> > need to be exposed to one of the hosts for tests purposes.  In the current
> > approach commands are issued to each host directly to surface memory.
> >
> 
> Lets say we implement this
> 
>   -----------         -----------
>   |  Host 1 |         | Host 2  |
>   |    |    |         |         |
>   |    v    |   Add   |         |
>   |   CCI   | ------> | Evt Log |
>   -----------         -----------
>                  ^ 
> 	    What mechanism
> 	   do you use here?
> 
> And how does it not just replicate QMP logic?
> 
> Not arguing against it, I just see what amounts to more code than
> required to test the functionality.  QMP fits the bill so split the CCI
> interface for single-host management testing and the MHSLD interface.

We have recently discussed the approach internally. Our idea is to do
something similar to what you have done with MHSLD emulation, use shmem
dev to share information (mailbox???) between the two devices. 
> 
> Why not leave the 1-node DCD with inbound CCI interface for testing and
> leave QMP interface for development of a reference fabric manager
> outside the scope of another host?

For this two hosts setup, for now I can see benefits,
the two hosts can have different kernel, that is to say, the one served
as FM only need to support for exmaple out-of-band communication with
the hardware (MCTP over i2c), and do not need to evolve with what we
want to test on the target host (boot with kernel with features we care).
That is very important at least for test purpose, as mctp over i2c
support for x86 support is not upstreamed yet, we do not want to rebase
whenever the kernel is updated.

More speficially, let's say, we deploy libcxlmi test framework on the FM
host, and then we can test the target host whatever features needed to
test (DCD etc). Again the FM host does not need to have dcd kernel support.

Compared to qmp interface, since libcxlmi already supports a lot of
commands and more commands are being included. It should be much more
convinient than implementing them with qmp interface.

Fan


> 
> TL;DR:  :[ distributed systems are hard to test
> 
> > > 
> > > 2.If not fully supported yet, are there any available development branches 
> > > or patches that implement this functionality?
> > > 
> > > 3.Are there any guidelines or considerations for configuring and testing CXL memory pooling in QEMU?
> > 
> > There is some information in that patch series cover letter.
> >
> 
> The attached series implements an MHSLD, but implementing the pooling
> mechanism (i.e. fabric manager logic) is left to the imagination of the
> reader.   You will want to look at Fan Ni's DCD patch set to understand
> the QMP Add/Remove logic for DCD capacity.  This patch set just enables
> you to manage 2+ QEMU Guests sharing a DCD State in shared memory.
> 
> So you'll have to send DCD commands individual guest QEMU via QMP, but
> the underlying logic manages the shared state via locks to emulate real
> MHSLD behavior.
>                      QMP|---> Host 1 --------v
>                [FM]-----|              [Shared State]
> 	             QMP|---> Host 2 --------^
> 
> This differs from a real DCD in that a real DCD is a single endpoint for
> management, rather than N endpoints (1 per vm).
> 
>                                   |---> Host 1
>                 [FM] ---> [DCD] --|
> 		                  |---> Host 2
> 
> However this is an implementation detail on the FM side, so I chose to
> do it this way to simplify the QEMU MHSLD implementation.  There's far
> fewer interactions this way - with the downside that having one of the
> hosts manage the shared state isn't possible via the current emulation.
> 
> It could probably be done, but I'm not sure what value it has since the
> FM implementation difference is a matter a small amount of python.
> 
> It's been a while since I played with this patch set and I do not have a
> reference pooling manager available to me any longer unfortunately. But
> I'm happy to provide some guidance where I can.
> 
> ~Gregory

