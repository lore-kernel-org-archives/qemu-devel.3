Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67974CEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svewz-00022z-Ct; Tue, 01 Oct 2024 11:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svewq-0001re-9V
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svewo-0006lD-NK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727797077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hH0FVSOczkl1o2SGmrPPZ2jT+Q/A9LLpJo05Iw0IozE=;
 b=fDMznairYc7sNAMEPg+VpwC/PkHqif72CnIjTa5dFftm+3QE/+eeRvDNlh1t0awzuzJC3B
 PCCMLfv9SI94dZ2fptP6JOTgJBWSB9oZdQjxN17M2OMHwteoS9pDOuCpfs+CP5BQp2/lGb
 ci/OmiBKieQ45ntCGbznhub1Hle4j1M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Yvs8tLx5MI2fgd6q4iyoqA-1; Tue, 01 Oct 2024 11:37:56 -0400
X-MC-Unique: Yvs8tLx5MI2fgd6q4iyoqA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cb659e73ceso28984146d6.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727797076; x=1728401876;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hH0FVSOczkl1o2SGmrPPZ2jT+Q/A9LLpJo05Iw0IozE=;
 b=w42D+aylCeFtvFCv/vk6zKPxl9byvHEBXaNCWI2sLAFPB96SkjzV6NmpwVvh/EJp6t
 QF4NEW2oo7jjWkdpWEzxn0HQY0PZlUOViLnzHXEcAAQ8xhEd/vd/ZWErWl3XCoA1g3Cm
 QrwEdRxNLvS9bxcO104C6pDKEbviikHKw8NTDQRpp7RWvpefxZ6mXLWB/R0kMfTkpp0P
 qvy3OPIG7k5d1SWy0maCOhVxLYxYTYnTNSa5Rs0MJ1pOp2R5+669D6v1KbtyJtUdrnPS
 hOS7tq7vn0GMj3CsHi6VcSu2VMRCl2LIX+U0OOlx+7vTBlrQfmxLrScYo6Y3Np8ZUgyk
 Jl7A==
X-Gm-Message-State: AOJu0YyclesO/rMN6kHZ7hYKnNUbgYMMsy87Tkx+0o7bOZgeRTWortcN
 QncF1s4YCoJsEd5uVHflz5p1N3XkPt/PK6LKYYl7d6EqIbtz8vHMdTfHlF1wycl8ydMUSwEY9ny
 8xXJ0TSAeU2KcUqu0LxZNFBNmjqNwRHmBsEs+HySACWI4DI6Uswtw
X-Received: by 2002:a05:6214:4b07:b0:6cb:28fe:ac0 with SMTP id
 6a1803df08f44-6cb3b5f38fcmr291959086d6.23.1727797075594; 
 Tue, 01 Oct 2024 08:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrsEkWTnzQ1UDk81w8UHNcxNBZJHwN1v57criK8KyGI4MJmcakOEgFA6VqnDjQ3z2PSa+C1g==
X-Received: by 2002:a05:6214:4b07:b0:6cb:28fe:ac0 with SMTP id
 6a1803df08f44-6cb3b5f38fcmr291958726d6.23.1727797075187; 
 Tue, 01 Oct 2024 08:37:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b6800a9sm50913966d6.116.2024.10.01.08.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 08:37:54 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:37:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/3] migration: Support responsive CPU throttle
Message-ID: <ZvwXUHltQU2seIM4@x1n>
References: <cover.1727630000.git.yong.huang@smartx.com>
 <3a383e563cc57c77320af805c8b8ece4e68eebea.1727630000.git.yong.huang@smartx.com>
 <ZvsORXZDZodSrzO-@x1n>
 <CAK9dgmZ7M30xXahBUKEkmQ2ZkWoF=DA=pb8XF_=YVM9xF2zcJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmZ7M30xXahBUKEkmQ2ZkWoF=DA=pb8XF_=YVM9xF2zcJw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 01, 2024 at 10:18:54AM +0800, Yong Huang wrote:
> On Tue, Oct 1, 2024 at 4:47 AM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, Sep 30, 2024 at 01:14:28AM +0800, yong.huang@smartx.com wrote:
> > > From: Hyman Huang <yong.huang@smartx.com>
> > >
> > > Currently, the convergence algorithm determines that the migration
> > > cannot converge according to the following principle:
> > > The dirty pages generated in current iteration exceed a specific
> > > percentage (throttle-trigger-threshold, 50 by default) of the number
> > > of transmissions. Let's refer to this criteria as the "dirty rate".
> > > If this criteria is met more than or equal to twice
> > > (dirty_rate_high_cnt >= 2), the throttle percentage increased.
> > >
> > > In most cases, above implementation is appropriate. However, for a
> > > VM with high memory overload, each iteration is time-consuming.
> > > The VM's computing performance may be throttled at a high percentage
> > > and last for a long time due to the repeated confirmation behavior.
> > > Which may be intolerable for some computationally sensitive software
> > > in the VM.
> > >
> > > As the comment mentioned in the migration_trigger_throttle function,
> > > in order to avoid erroneous detection, the original algorithm confirms
> > > the criteria repeatedly. Put differently, the criteria does not need
> > > to be validated again once the detection is more reliable.
> > >
> > > In the refinement, in order to make the detection more accurate, we
> > > introduce another criteria, called the "dirty ratio" to determine
> > > the migration convergence. The "dirty ratio" is the ratio of
> > > bytes_xfer_period and bytes_dirty_period. When the algorithm
> > > repeatedly detects that the "dirty ratio" of current sync is lower
> > > than the previous, the algorithm determines that the migration cannot
> > > converge. For the "dirty rate" and "dirty ratio", if one of the two
> > > criteria is met, the penalty percentage would be increased. This
> > > makes CPU throttle more responsively and therefor saves the time of
> > > the entire iteration and therefore reduces the time of VM performance
> > > degradation.
> > >
> > > In conclusion, this refinement significantly reduces the processing
> > > time required for the throttle percentage step to its maximum while
> > > the VM is under a high memory load.
> >
> > I'm a bit lost on why this patch 2-3 is still needed if patch 1 works.
> > Wouldn't that greatly increase the chance of throttle code being inovked
> > already?  Why we still need this?
> >
> 
> Indeed, if we are considering how to increase the change of throttle.
> Patch 1 is sufficient, and I'm not insisting.
> 
> If we are talking about how to detect the migration convergence, this
> patch, IMHO, is still helpful. Anyway, it depends on your judgment. :)

Thanks.  I really hope we can stick with patch 1 only for now, and we leave
patches like 2-3 for future, or probably never.

I want to avoid more magical tunables, and I want to avoid the code harder
to read.  Unlike most of other migration features, auto converge so far is
already pretty heavy on the "engineering" aspect of things.  More people
care about downtime with 100ms or even less, then it makes zero sense a
throttle feature can stop a group of vCPUs for more than that easily.

I hope we can unite more dev/qe resources on postcopy across QEMU community
for enterprise users.  PoCs are always good stuff for QEMU as it's a
community project and people experiment things on it, but I hope at least
from design level, not small tunables like this one.  We could have
introduced 10 more tunables all over, feed them to AI and train some
numbers that migration can improve 10%, but IMHO that doesn't hugely help.

If you really care about convergence issues, I want to know whether you
agree on postcopy being a better way to go.  There're still plenty of
things we can do better in that area on either postcopy in general, or
downtime optimizations that lots of people are working (e.g. VFIO's), so
again IMHO it'll be good we keep focused there.

Thanks,

-- 
Peter Xu


