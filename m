Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F59CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0mu-0006jt-4O; Tue, 23 Jun 2026 09:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0mp-0006jj-VQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0mo-0001EV-FB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782219808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kZ5sS1RzWkrPW/nYL7FLneNQqqUSL0wym3Hb6oKxH3M=;
 b=XScAZ3HtSx9qP/w2tnIBAtl1Vf6rxovqNFSySJokZZUXrUf0uP9gIWVB7y2iRiFFVUnk93
 azYypQJZkKmLtXlIa5hPKNq84yW3gRq6R4071Nzn3EmegkkfWheivQZxwuY7rbUTrUWZ+f
 bw2Ip7BOD1z7aCMqBVSQL7Y+CAV/zGA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-B9mtu9i5OlyVbD-6tu6Kuw-1; Tue, 23 Jun 2026 09:03:27 -0400
X-MC-Unique: B9mtu9i5OlyVbD-6tu6Kuw-1
X-Mimecast-MFC-AGG-ID: B9mtu9i5OlyVbD-6tu6Kuw_1782219806
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8dcfdbe9da2so83371916d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782219806; x=1782824606; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kZ5sS1RzWkrPW/nYL7FLneNQqqUSL0wym3Hb6oKxH3M=;
 b=qSmNG3DMTGHPMztz5m3M7lUj2AkinFtfe6XXmdusJ4ss7f45Vn14B3MXCaRz1qEuJg
 YZT/dD/D3vU6OtodQ7odZplHLytUyBt1+YOyIcZ1bXQQ7phHpXOe+UT81Tdv8qnh35cq
 A5k+ax2oGX6+4bxhyUsQrgKayTelFjN2DI7r8rP9LSalZErrBMar9I+j3C0kyKC9IX8l
 HLJ7Dkwdltj4Ubfi3QhwT1ZenA/xnqsKw6tU6pWeo4oa1pJgIsGNowUjIcupexYIsFnf
 ckrpUvTwYNwAnk93KomAQnfS2JAr9kag/Vyef542Hhxcp8eQFX75EmjHx1ORZZmztDAs
 cs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782219806; x=1782824606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZ5sS1RzWkrPW/nYL7FLneNQqqUSL0wym3Hb6oKxH3M=;
 b=RCIygBLZ88lugMEUovn6DGbUrnnmT5K8GLM4o0srp1JbBp312LdL7DymhRbj7FvMWf
 /iL1zAKrs+p9I7Q5fdhgc1L2QiarIdGBIB2gZyF7N3IMKkjBON8RUKMVgrrwvKXFDeO0
 mDeEtDoo0nIgy5VhKJP+iJVAPmlOYiH+uK9IPYEBf0ue2sPv9FQDP9PWxM3jHSIc0rpl
 8GbRAQPk3iMV3/SknbRYRVPtodsGENtFNk7kTA4Mnpdrw4n1faID1jqSQtcWyTZiYhJQ
 98xvJMuDf1dy2E5Y57Qr8B9plXEfVy9rSGI70TeuY3hfHsSzU8P8Oui5ZOJTBAXLxoOs
 6PHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+088bz63gGFudzwiWUUfaPsbC17vHVZlacjz6eiC9N3V7+iyYUM4kywuX/A1IqyYgzFSGtxsv5a+H6@nongnu.org
X-Gm-Message-State: AOJu0YzJj2Yw7Yit/S1AYJWFKgOo5t4kR7cwFfKxNf8t0tCIDr22Xdx1
 lpIAMS0OBnotzSZHY99uTLPdU/ikEsdqowQIIGmSxdwg+gYSZfjF5L2W7vbtXamLVWGtcw9XXi+
 LINjFSAK4MUyVDvCQU0XLXtOHfANfH73Wfaxaotm3ASlzICfDWV2x8++0
X-Gm-Gg: AfdE7cmjGZgeQIzDhL+4d4T5cM7SaTTDjADAjTrUj9qmSuuFVkWJmkE4us45Rtf24kb
 vzH6ISezzXx62y93Zb5iMAob8iQaMUpq63CeTL2Gu/NyG7VEuFtZRZ3ZWieq/juLJyvM4unFTV8
 wkNNDjdGweZL3RmGRq3k/EK7lKckKL3rUpEo05cjn4HASy8NMKJS9/aKWmQkRHQVFOLqUFHUUsh
 OSG0ig4aAXWSnKwwn4m1Xd3bbqwtWm8JrzxJ28kE/XZJKMaflyGn65qPrwfPBXTdw9W/cunLqZ2
 6o8nomBK8qeHaWWFSkzYgrvQwy4ZRg7qhu4cEnGivtMxtIhjvfjbXg12I+KIn50T27s7dCsBfUw
 SqsKceu6OTbbUE7UsvOI9ybp8Acv5ddUcnChWBoZwib5PX4zf7stPAgTl9aGC9ozqj/d+vH4E
X-Received: by 2002:a05:622a:1817:b0:517:2c1e:8b6 with SMTP id
 d75a77b69052e-51a55aa30edmr35013911cf.38.1782219806363; 
 Tue, 23 Jun 2026 06:03:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1817:b0:517:2c1e:8b6 with SMTP id
 d75a77b69052e-51a55aa30edmr35013361cf.38.1782219805701; 
 Tue, 23 Jun 2026 06:03:25 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a515c5219sm23738801cf.7.2026.06.23.06.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:03:25 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:03:23 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 farosas@suse.de, maciej.szmigiero@oracle.com, mark.kanda@oracle.com,
 bchaney@akamai.com
Subject: Re: [PATCH 1/1] migration/cpr: Add HMP support for cpr-transfer
Message-ID: <ajqEG0UvCNkhk1tl@x1.local>
References: <20260621072646.517545-1-dongli.zhang@oracle.com>
 <ajp7GduDZGjei3Gz@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajp7GduDZGjei3Gz@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 23, 2026 at 12:24:57PM +0000, Dr. David Alan Gilbert wrote:
> * Dongli Zhang (dongli.zhang@oracle.com) wrote:
> > Currently the cpr-transfer source QEMU instance cannot be driven entirely
> > via HMP.  The source must use QMP in order to specify both the
> > main migration channel and the CPR channel.
> > 
> > Extend the HMP migrate command with an optional CPR channel URI. When the
> > migration mode is cpr-transfer, HMP uses this URI to build a
> > CPR MigrationChannel in addition to the main migration channel. The new
> > argument is rejected unless the migration mode is cpr-transfer, so existing
> > HMP migrate usage is unchanged.
> > 
> > For example, source QEMU HMP commands can be something like below. The
> > "unix:/tmp/cpr.sock" is for CPR URI.
> > 
> > (qemu) migrate_set_parameter mode cpr-transfer
> > (qemu) migrate tcp:0:50002 unix:/tmp/cpr.sock
> > 
> > Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> 
> Yeh this looks OK to me; I don't see a check for if you do:
> (qemu) migrate_set_parameter mode cpr-transfer
> (qemu) migrate tcp:0:50002
> 
> Does that get caught by the qmp_migrate or should you add a check here?
> 
> I do have a slight preference for using flag optional parameters rather 
> than positional, e.g.
> 
>    migrate -c unix:/tmp/cpr.sock tcp:0:50002
> 
> but I wouldn't insist on it.

I'll also vote for that.

Thanks,

-- 
Peter Xu


