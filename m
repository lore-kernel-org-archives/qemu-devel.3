Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F4DC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 04:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u20sI-0002fA-4t; Tue, 08 Apr 2025 00:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u20sF-0002ey-Ua
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 00:47:47 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u20sD-0007wI-Us
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 00:47:47 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so3368891a12.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 21:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744087664; x=1744692464; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wXvizl6RATbEjTOKl0CCRHeoPrumOttIJFNv6HPEZ9M=;
 b=m9oSTjD9eRwZmfzOgD07bCv2EKavtNOIdVT0ZGbuWGFREpnHOJMEk0U1GZuy0jib83
 fqWHtnRJZkm7OeEjPwfxqg/xut6gLNPlyQZ1wq5uYjs5hUI/4Imtwi3A/iPmqU5fNtC0
 gWW3KFJRLQgiRSzWhcefGBr6YSRq0wt4epMwrLUmp/iX7k9WBSH+vKAeuZJamnh+V8Hd
 mKnZmCQF6ZwQqIW25JcdPx5HUKTf67K69oo2DM5dMpznBwm65dSiHe9WJII743gXji8A
 LxAe2e09eHAe3eikUKlCxpUkFi0L5ljwKfg9gCCEqpP6D7Nyve95yEltwSQVBsOgJfW9
 x0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744087664; x=1744692464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXvizl6RATbEjTOKl0CCRHeoPrumOttIJFNv6HPEZ9M=;
 b=cYN4PA/yGDt3ZbdhVEVQF/RM+iOSAjhD8EGDi8btsaH/pquaRi9rgyg35QBztXfMgY
 LdTxpAd5NlcT9NIfbhD296APeYEjvMtFHmg8HfJYZHaD8J3ARCHqu0ccx4a0RZoc51H2
 sSqs8Sbuy/80dq/nItSf1hEVvsNfGXeLr41RTl52kRENK8n7V4UEKer3DaHeQHUMLY3F
 NWJuV49lg2uo2gC+cITvbTyQio7K1+xG7eSPiiGbWhFCE/0cHnu90OF3qFd8xwkk2k05
 jUhtjNb8EaU2K7scHku05A3IF02QsAi9sjqT/bbLJbhD3VeXuTmsQ2vyCeFwMTQSHAtb
 jS7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPUiFrtXL1vqBnACHLpAxGCLpd2fW8gh67tZdOJ1UtEIVS1v1yzz3uyR50ec9YhuvUkZfN5Uq8F70q@nongnu.org
X-Gm-Message-State: AOJu0YzX0/QlNN8EFNi6jc3d33HmrUnmofoGcnqoag7gnrt6koRJrA/p
 hkb0ijjTDcCjm/rjTQcUPqIDuWW8VnISsH87CcLQV5DGIPGJjJi2
X-Gm-Gg: ASbGncvSi+CHaaie6gS32czOwJhZppKaQsbq/U8VEaeDH+8TWwZrUHoQnSiBM6H0X19
 JX98Q5e8MPwO1DykqGr88CDE/48YY9TMa2AOofmkmyF6SeStgfZKjm72BIKQyNxRapJGt2YAGLt
 GaDuF8/FKPV9cR6C1hzm/r5legoLwGhLQZFYqs2xzMdiQ/MIGW7GsEqGohGkxfOwHiptc589TkZ
 i1ACHsh+YibTdRaj4l3rnYorJhISBHtOD5iWuuIhrdl55/1l6X03h9X+wcfwnNyiKlMA/5kMVoJ
 djLr6hksR9YPpM4/ozfuQ3tYMvOCF9giuwAPUs2G
X-Google-Smtp-Source: AGHT+IHJ2jl8VbiUC6NnzGN5Sh1yW+WlVtPUlc6ZoqCLMf0g5TGQqXpf36rMCLvfwE57/UDB0SUD9w==
X-Received: by 2002:a17:90a:d650:b0:305:2d27:7ba5 with SMTP id
 98e67ed59e1d1-306a4822f9cmr18912924a91.6.1744087664260; 
 Mon, 07 Apr 2025 21:47:44 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057cb8e88esm10029666a91.41.2025.04.07.21.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 21:47:43 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 7 Apr 2025 21:47:41 -0700
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Junjie Fu <fujunjie1@qq.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, viacheslav.dubeyko@bytedance.com,
 zhitingz@cs.utexas.edu, svetly.todorov@memverge.com
Subject: Re: CXL memory pooling emulation inqury
Message-ID: <Z_SqbdVE9znpRjtp@debian>
References: <20230215151854.00003e34@Huawei.com>
 <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
 <20250312180543.00002132@huawei.com>
 <Z9HheFFgOdGE9BcW@gourry-fedora-PF4VCD3F>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9HheFFgOdGE9BcW@gourry-fedora-PF4VCD3F>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x535.google.com
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
> 
> Why not leave the 1-node DCD with inbound CCI interface for testing and
> leave QMP interface for development of a reference fabric manager
> outside the scope of another host?

Hi Gregory,

FYI. Just posted a RFC for FM emulation, the approach used does not need
to replicate QMP logic, but indeed we use one QMP to notify host2 for a
in-coming MCTP message.
https://lore.kernel.org/linux-cxl/20250408043051.430340-1-nifan.cxl@gmail.com/

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

