Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6DDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seynH-00058o-Uz; Fri, 16 Aug 2024 11:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seynF-00058D-Hl
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seynC-0000Ey-Lk
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723821785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uj52EsrloWca9ptatlUCUNTU4yDVlABfo3NDTaLXJ0U=;
 b=FhJG8Km3IBRxwFBduRnYszIcN/CHv0bBqT9Y86/xutgKzKQ+B/wmeTss49Po1JRKreDjEi
 MeaqWgTkrEbLx4LQU0u//bGi6OBqm6JY8D/dXosRxb44oTg2cuSoLoj3mpsz8WDRRcbMhj
 MZSw8W0rqvU7YwOqis0yMthInCgSkFw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-9OE_rFm2MVieKX_U5GC88A-1; Fri, 16 Aug 2024 11:23:03 -0400
X-MC-Unique: 9OE_rFm2MVieKX_U5GC88A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-44ff585970bso4276781cf.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723821783; x=1724426583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uj52EsrloWca9ptatlUCUNTU4yDVlABfo3NDTaLXJ0U=;
 b=oDrzBP1/TUSWLhjcHD0cfZqDYlXLvrLjDMyrWdzUSIsug1wSuvEKbLoahf3i4MoeH6
 A2EfBaJcA4oIfpJPIh64HPUb/FmVblcWd5pL7ZF87def+wwqIOM29gg69LhKJVDCN21P
 Rq2Ytu3NMfyV9JILikLUt3/5+Gs2vsFO8OOhGhG6WPm2+29Osi6W/CYh5xIKJlSwTiti
 g3AI4/q2OfA4UsIDkrcGBe6OJ/niYUM1NDXGImBv8SKq8hxk299G/AUmQOUlBfp73oC9
 +Se8iewIBbxk+kGDleHVKfyif3jzo9X4fEYTZfrv6/NYzM8mziBdO3MRDHpSfMiI8iBc
 3Z1A==
X-Gm-Message-State: AOJu0Yx7F4FsZjX4XAlrKJUU2HJgyeQ2PfAy30yuePbDLvxtC0/s/aco
 XW7CSGpcfcq+JEDazaqLK9Rzt8SEvhnZxGoXYflAENLbCT5IC+mcUeDuKLe0T8YrY6gi3sIg5gB
 K4C5WRNkaslmnjk1zGcZuV0OAyVM46kc0coIgNN3evAQwjTQzkNvT
X-Received: by 2002:a05:622a:1486:b0:44f:e2d3:16ee with SMTP id
 d75a77b69052e-45374297aa0mr22284041cf.8.1723821783184; 
 Fri, 16 Aug 2024 08:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAEJvT8rDo07Nw9obYnUROOI0Qxo5IJDqeArONZekaWEHxDx8NsZ7v7VvlIyGZhhb1wdxXnw==
X-Received: by 2002:a05:622a:1486:b0:44f:e2d3:16ee with SMTP id
 d75a77b69052e-45374297aa0mr22283931cf.8.1723821782797; 
 Fri, 16 Aug 2024 08:23:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4536a004f77sm17385501cf.51.2024.08.16.08.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:23:02 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:23:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
Message-ID: <Zr9u1YV4m9Uzvj7Z@x1n>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n>
 <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n>
 <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Fri, Aug 16, 2024 at 11:13:36AM -0400, Steven Sistare wrote:
> On 8/15/2024 4:28 PM, Peter Xu wrote:
> > On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
> > > > > The new user-visible interfaces are:
> > > > >     * cpr-transfer (MigMode migration parameter)
> > > > >     * cpr-uri (migration parameter)
> > > > 
> > > > I wonder whether this parameter can be avoided already, maybe we can let
> > > > cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
> > > > in the same channel?
> > > 
> > > You saw the answer in another thread, but I repeat it here for others benefit:
> > > 
> > >    "CPR state cannot be sent over the normal migration channel, because devices
> > >     and backends are created prior to reading the channel, so this mode sends
> > >     CPR state over a second migration channel that is not visible to the user.
> > >     New QEMU reads the second channel prior to creating devices or backends."
> > 
> > Today when looking again, I wonder about the other way round: can we make
> > the new parameter called "-incoming-cpr", working exactly the same as
> > "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
> > be reused for migration incoming ports?
> > 
> > After all, cpr needs to happen already with unix sockets.  Having separate
> > cmdline options grants user to make the other one to be non-unix, but that
> > doesn't seem to buy us anything.. then it seems easier to always reuse it,
> > and restrict cpr-transfer to only work with unix sockets for incoming too?
> 
> This idea also occurred to me, but I dislike the loss of flexibility for
> the incoming socket type.  The exec URI in particular can do anything, and
> we would be eliminating it.

Ah, I would be guessing that if Juan is still around then exec URI should
already been marked deprecated and prone to removal soon.. while I tend to
agree that exec does introduce some complexity meanwhile iiuc nobody uses
that in production systems.

What's the exec use case you're picturing?  Would that mostly for debugging
purpose, and would that be easily replaceable with another tunnelling like
"ncat" or so?

> 
> I also think -incoming-cpr has equal or greater "specification complexity" than
> -cpr-uri.  They both add a new option, and the former also modifies the behavior
> of an existing option (disallows it and subsumes it).

Please see Dan's comment elsewhere.  I wonder whether we can do it without
new qemu cmdlines if that's what we're looking for for the long term.  If
QMP is accessbile before cpr early loads, then we can set cpr mode and
reuse migrate-incoming with no new parameter added.

-- 
Peter Xu


