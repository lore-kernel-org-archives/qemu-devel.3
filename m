Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9579CC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprFx-0003Dm-W6; Thu, 28 Mar 2024 11:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rprFt-0003Al-2i
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rprFq-0008Qu-Eb
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711638081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhghMiltiW1UkToaahRi3DpW9JO4WF1eZBFYOiD8cqk=;
 b=bSLVPM3Jsua1aN/DJYM9iGd/2/OrMpSyYxvvSiUFyYWFCezuo2xxHxRe8h0x2SusGoY2rs
 KIfCPxddD8/bDFZJz1wY6TRNSJ5w4w/mJEgTVsTdRrPLyhaREzOPgF4la94GurvN79gXUm
 g9w7vSWQa4nRXVDZ2YAtmND/VzYeRH0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-pPLkp8nlODmCpovu1D1Myg-1; Thu, 28 Mar 2024 11:01:17 -0400
X-MC-Unique: pPLkp8nlODmCpovu1D1Myg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-78a256c2439so10822985a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638076; x=1712242876;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rhghMiltiW1UkToaahRi3DpW9JO4WF1eZBFYOiD8cqk=;
 b=rc/SvhKMn0OTn/V5ZHtSaCrEGm/bR/PkwiI4lZSjZbiB7abnxzKr72SQrKdekJA8s0
 rpqcqBjTXeao5Y9X+H3oE9pXWmo7EQGY0FT/+8g/+sOneJOVGrEsGL7oP5jR5xmmF4mI
 i/X8oKvSszDIZ+/zqJcVYPL05gdKOUsrnF4wJBd812Lnyq34x/fmBNKQVRo83beWxHIA
 nzQF0ujBkWoGZ1s00BdaOkq/dqqIX6clfMk4kEPNJVHEqYP7ZpHB6lf803S/s5Gaxjeh
 JT8X1WA63b5KGAkjYxAWrkjzn+oy1STBso1zsrdBjlfZVcwBfo+ANcZ+kwh96qNlXBm0
 KbsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYtodohdFqjLLcVWDVYsOjL1uqwx9hvlU/mZBlqsvGjB0aMGAxx5vqISciKbdkDkB+jPWXQKf8w3Nles3b5lCNVoSwbyk=
X-Gm-Message-State: AOJu0YyZ7+omD+oPYPCkpdDFKyNhld21MfO9WgxgimRIPSipASH5BvCu
 Hs0yAbtk3++vdgGY2WZgaWUFlL08lGXd5ETNSsHNqOZ3ztbwZNRR3CIgwdhYDZo0UYiIPeXFeNr
 BpGDqf6/c3BA9eKzThMz2CoAyRGQbKgwCrWq5OgStmm5HetLJ9hPQ
X-Received: by 2002:a05:620a:c:b0:78a:459a:d95a with SMTP id
 j12-20020a05620a000c00b0078a459ad95amr2715534qki.4.1711638075569; 
 Thu, 28 Mar 2024 08:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtleZUQcJcx9ICtB7VdPTpkNmJuk5PPSR0J7emOaOVPxXNwX7wUCqNo9JnCKdyGgn2ixHfFA==
X-Received: by 2002:a05:620a:c:b0:78a:459a:d95a with SMTP id
 j12-20020a05620a000c00b0078a459ad95amr2715479qki.4.1711638074893; 
 Thu, 28 Mar 2024 08:01:14 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 b23-20020a05620a119700b0078a4590c62esm582343qkk.87.2024.03.28.08.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:01:14 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:01:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 integration@gluster.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZgWGMmUTq0jqSUvr@x1n>
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org> <87frwatp7n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frwatp7n.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 28, 2024 at 11:18:04AM -0300, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > The whole RDMA subsystem was deprecated in commit e9a54265f5
> > ("hw/rdma: Deprecate the pvrdma device and the rdma subsystem")
> > released in v8.2.
> >
> > Remove:
> >  - RDMA handling from migration
> >  - dependencies on libibumad, libibverbs and librdmacm
> >
> > Keep the RAM_SAVE_FLAG_HOOK definition since it might appears
> > in old migration streams.
> >
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Li Zhijian <lizhijian@fujitsu.com>
> > Acked-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Just to be clear, because people raised the point in the last version,
> the first link in the deprecation commit links to a thread comprising
> entirely of rdma migration patches. I don't see any ambiguity on whether
> the deprecation was intended to include migration. There's even an ack
> from Juan.

Yes I remember that's the plan.

> 
> So on the basis of not reverting the previous maintainer's decision, my
> Ack stands here.
> 
> We also had pretty obvious bugs ([1], [2]) in the past that would have
> been caught if we had any kind of testing for the feature, so I can't
> even say this thing works currently.
> 
> @Peter Xu, @Li Zhijian, what are your thoughts on this?

Generally I definitely agree with such a removal sooner or later, as that's
how deprecation works, and even after Juan's left I'm not aware of any
other new RDMA users.  Personally, I'd slightly prefer postponing it one
more release which might help a bit of our downstream maintenance, however
I assume that's not a blocker either, as I think we can also manage it.

IMHO it's more important to know whether there are still users and whether
they would still like to see it around. That's also one thing I notice that
e9a54265f533f didn't yet get acks from RDMA users that we are aware, even
if they're rare. According to [2] it could be that such user may only rely
on the release versions of QEMU when it broke things.

So I'm copying Yu too (while Zhijian is already in the loop), just in case
someone would like to stand up and speak.

Thanks,

> 
> 1- https://lore.kernel.org/r/20230920090412.726725-1-lizhijian@fujitsu.com
> 2- https://lore.kernel.org/r/CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com
> 

-- 
Peter Xu


