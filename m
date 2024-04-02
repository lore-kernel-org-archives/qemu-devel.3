Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85C7C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 21:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrlc7-0006LS-IY; Tue, 02 Apr 2024 17:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrlc6-0006LB-Fg
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 17:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrlc3-0006hM-Rp
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 17:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712093050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=abB9L3onVgL5FYE3loDnV0els5ZzrcEfmstHw8e18oE=;
 b=CRwhwnZDwFI5frVcDYgbsPrKAeWGeAktLMJbGCM+qpeBNqA3FjRSSSWXExZR05JKUM6GEY
 Jbg4P6o4cUfJcJjNaacqRfMN+QRQfLUR6KIeIrZyRg/TJuu5IPxLOsl88d+Pm1J5Xg/fGa
 7eZheEjrWrtzbUkxkwWk2vlCPZhiWV4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-_XrSW8gDMhKk8zjUe2PoIg-1; Tue, 02 Apr 2024 17:24:08 -0400
X-MC-Unique: _XrSW8gDMhKk8zjUe2PoIg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78d346eeb02so14784085a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 14:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712093048; x=1712697848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abB9L3onVgL5FYE3loDnV0els5ZzrcEfmstHw8e18oE=;
 b=ZG9+fDZpemNccUgyyXAt30DQDoUvhFAFc7tGE6JQAJCFNO0IACvWKKB96GOb8Ks8CR
 QmNxB/r3xjaUfxlmCi2Iux8K7ZvhNN8RYZ5vdrq0G5ihmnwSXAcf0EDHRmeWm3jPjxLe
 RvcX8nAxqhcsG1qLUAYbSiIgKDUw/JxCdfrqw4BLVrWPmrB7LBkp+gq0rwXwBQAqkPDU
 EBdbep5Ckw7amKCFzkyIEcMvwgPvt01kcHNptMjvN/59pscehhmx9XHgOFRrDTRWiPkV
 pcGEKXv2hY/EbNqqK2e26YE4Tk0ofLl6e/I5iHWmQesDUb53rxwybyPdAqh5eDORfZvj
 Grdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT9R4THdtlGTm/VRuvzyas41o0C4sl4x8gNZAqTED0+Lxxy5ry26SybTVBOQt2ZnYqNDZ3Qmimxrnxn51iHff/HiQjW44=
X-Gm-Message-State: AOJu0YwKXcVf70+6FLfujx917TGpSzJlPqJVYw9NMJEIfK151zCtx52O
 OlX4LJs6U+ZHFhzChKQ8m5arP01ZKkhxM2DabSGYgNxaRtMSld+j7HqQZK9CMDhTmianYKdnW1K
 8VVVteYxTpYqj7F5rdFLSF1auNxYLHAx7j+bnP6gpNzkzOfEdzZLr
X-Received: by 2002:a05:620a:5750:b0:78b:eab6:5351 with SMTP id
 wj16-20020a05620a575000b0078beab65351mr4476025qkn.0.1712093047854; 
 Tue, 02 Apr 2024 14:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgyiNIw3BvnQeiCPcqaYp6stSiqG/f0HtImtDgtbCAm54X+H3RzBxTCxNZoCMBkHEMot9VLQ==
X-Received: by 2002:a05:620a:5750:b0:78b:eab6:5351 with SMTP id
 wj16-20020a05620a575000b0078beab65351mr4475991qkn.0.1712093047242; 
 Tue, 02 Apr 2024 14:24:07 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c28-20020a05620a165c00b0078bc4cad726sm4072242qko.72.2024.04.02.14.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 14:24:07 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:23:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Yu Zhang <yu.zhang@ionos.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <Zgx3brrz8m0V7HS4@x1n>
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org> <87frwatp7n.fsf@suse.de>
 <ZgWGMmUTq0jqSUvr@x1n>
 <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 01, 2024 at 11:26:25PM +0200, Yu Zhang wrote:
> Hello Peter und Zhjian,
> 
> Thank you so much for letting me know about this. I'm also a bit surprised at
> the plan for deprecating the RDMA migration subsystem.

It's not too late, since it looks like we do have users not yet notified
from this, we'll redo the deprecation procedure even if it'll be the final
plan, and it'll be 2 releases after this.

> 
> > IMHO it's more important to know whether there are still users and whether
> > they would still like to see it around.
> 
> > I admit RDMA migration was lack of testing(unit/CI test), which led to the a few
> > obvious bugs being noticed too late.
> 
> Yes, we are a user of this subsystem. I was unaware of the lack of test coverage
> for this part. As soon as 8.2 was released, I saw that many of the
> migration test
> cases failed and came to realize that there might be a bug between 8.1
> and 8.2, but
> was unable to confirm and report it quickly to you.
> 
> The maintenance of this part could be too costly or difficult from
> your point of view.

It may or may not be too costly, it's just that we need real users of RDMA
taking some care of it.  Having it broken easily for >1 releases definitely
is a sign of lack of users.  It is an implication to the community that we
should consider dropping some features so that we can get the best use of
the community resources for the things that may have a broader audience.

One thing majorly missing is a RDMA tester to guard all the merges to not
break RDMA paths, hopefully in CI.  That should not rely on RDMA hardwares
but just to sanity check the migration+rdma code running all fine.  RDMA
taught us the lesson so we're requesting CI coverage for all other new
features that will be merged at least for migration subsystem, so that we
plan to not merge anything that is not covered by CI unless extremely
necessary in the future.

For sure CI is not the only missing part, but I'd say we should start with
it, then someone should also take care of the code even if only in
maintenance mode (no new feature to add on top).

> 
> My concern is, this plan will forces a few QEMU users (not sure how
> many) like us
> either to stick to the RDMA migration by using an increasingly older
> version of QEMU,
> or to abandon the currently used RDMA migration.

RDMA doesn't get new features anyway, if there's specific use case for RDMA
migrations, would it work if such scenario uses the old binary?  Is it
possible to switch to the TCP protocol with some good NICs?

Per our best knowledge, RDMA users are rare, and please let anyone know if
you are aware of such users.  IIUC the major reason why RDMA stopped being
the trend is because the network is not like ten years ago; I don't think I
have good knowledge in RDMA at all nor network, but my understanding is
it's pretty easy to fetch modern NIC to outperform RDMAs, then it may make
little sense to maintain multiple protocols, considering RDMA migration
code is so special so that it has the most custom code comparing to other
protocols.

Thanks,

-- 
Peter Xu


