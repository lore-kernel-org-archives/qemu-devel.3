Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E36C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0ev-0002SG-4p; Tue, 12 Mar 2024 07:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk0er-0002Rf-Fp
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk0ep-0005zl-Cr
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710244257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0YDIGIg2iopt7NxV3WrtB12QE0x2z0P794tm2y6Qfk=;
 b=aeMXa9OcmI/MBgLQIvMJ17qQv/2plIXh0t2/9u/n5R4kPYm06tD9sPG1n3MZo45joG4abl
 g9UaX+AUVunBqXHPHkYGFqEupJrCtvUgE9dm/bFEOLlt0jm8ixxRLZ8uuLBhdy583IM1Ps
 D9lseNkufT1cUQ3hjLNsV2M2RUDQxuw=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-QkEafN1JPaWx5X6FQ_b6Ug-1; Tue, 12 Mar 2024 07:50:56 -0400
X-MC-Unique: QkEafN1JPaWx5X6FQ_b6Ug-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4d37816c789so50464e0c.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710244255; x=1710849055;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O0YDIGIg2iopt7NxV3WrtB12QE0x2z0P794tm2y6Qfk=;
 b=GvymUiUm5rG6/An0OLs8tp0oRoLmnbonEd5cg1HVrWBaZF5baP4jeErIbevFTeSt3B
 7sB0ZmVowKb97asPAYv7Xne1PmONW/Ny5W+0tA5joqGRq0/HJaFma44YyrnD0vnE+Tjr
 nXjKf3+A8RlfQlhHbCVHUarxLGk5CBCwvTc64PY82IZ/EFZqQ47CHAzktPeVNqlUl8eM
 t/75W0rnchwOpvEE667bDkh+dAKwI6YIH4Z1p17vWBT7Y6Q8uB4KuHjpoV/Eah4rCqiM
 QhSc9KMt63Zp19GXdlXSVVwjaEJjkHW25pxK3FWppinnRv2nKzNs1N+3Cu+gQ6YrdMDn
 tCtA==
X-Gm-Message-State: AOJu0YwJiGdxQuR5xk24LGIrj4f6BcKXGq4ixDekjNGNnCXcA3q+2S1B
 CZNR1vCA7Owtz1uWP3j05LL5DKBbBcHYditqddDBeUcfc1+htBxyD5H+1eSEaKP/mXXKv5e0BwL
 J3VctXDQEQl+NnGzHn8ayczYVlAQ0Rq92gGXIIEXRmFmpZyszBo9D
X-Received: by 2002:a05:6122:18a9:b0:4d3:9ad3:4998 with SMTP id
 bi41-20020a05612218a900b004d39ad34998mr5320891vkb.1.1710244255543; 
 Tue, 12 Mar 2024 04:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0gcPG8eb4j178m/yvoqP3niCUq5MWT1HXiyQVJ2hOZIfbxMc7DPpER0vQl7sMieJly/m6OA==
X-Received: by 2002:a05:6122:18a9:b0:4d3:9ad3:4998 with SMTP id
 bi41-20020a05612218a900b004d39ad34998mr5320868vkb.1.1710244255077; 
 Tue, 12 Mar 2024 04:50:55 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 eu8-20020ad44f48000000b0068fcd643b9dsm3574278qvb.22.2024.03.12.04.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:50:54 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:50:53 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 00/25] migration: Improve error reporting
Message-ID: <ZfBBnWcBTFqlH2wf@x1n>
References: <20240306133441.2351700-1-clg@redhat.com> <ZerJDAdaakTCtECF@x1n>
 <Ze9ogyFZT73gB-La@x1n>
 <0a1c329e-e6ab-4329-815d-e6be3e64c2ae@redhat.com>
 <5ca62745-deae-41b5-a9ef-2269a7220830@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ca62745-deae-41b5-a9ef-2269a7220830@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On Tue, Mar 12, 2024 at 10:58:51AM +0100, Cédric Le Goater wrote:
> On 3/12/24 08:16, Cédric Le Goater wrote:
> > On 3/11/24 21:24, Peter Xu wrote:
> > > On Fri, Mar 08, 2024 at 04:15:08PM +0800, Peter Xu wrote:
> > > > On Wed, Mar 06, 2024 at 02:34:15PM +0100, Cédric Le Goater wrote:
> > > > > * [1-4] already queued in migration-next.
> > > > >    migration: Report error when shutdown fails
> > > > >    migration: Remove SaveStateHandler and LoadStateHandler typedefs
> > > > >    migration: Add documentation for SaveVMHandlers
> > > > >    migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
> > > > > * [5-9] are prequisite changes in other components related to the
> > > > >    migration save_setup() handler. They make sure a failure is not
> > > > >    returned without setting an error.
> > > > >    s390/stattrib: Add Error** argument to set_migrationmode() handler
> > > > >    vfio: Always report an error in vfio_save_setup()
> > > > >    migration: Always report an error in block_save_setup()
> > > > >    migration: Always report an error in ram_save_setup()
> > > > >    migration: Add Error** argument to vmstate_save()
> > > > > 
> > > > > * [10-15] are the core changes in migration and memory components to
> > > > >    propagate an error reported in a save_setup() handler.
> > > > > 
> > > > >    migration: Add Error** argument to qemu_savevm_state_setup()
> > > > >    migration: Add Error** argument to .save_setup() handler
> > > > >    migration: Add Error** argument to .load_setup() handler
> > > > 
> > > > Further queued 5-12 in migration-staging (until here), thanks.
> > > 
> > > Just to keep a record: due to the virtio failover test failure and the
> > > other block migration uncertainty in patch 7 (in which case we may want to
> > > have a fix on sectors==0 case), I unqueued this chunk for 9.0.
> > 
> > ok. I will ask the block folks for help to understand if sectors==0
> > is also an error in the save_setup context. May be  we can still
> > merge these in 9.0 cycle.
> 
> I discussed with Kevin and sectors==0 is not an error case, the loop
> should simply continue. That said, commit 66db46ca83b8 ("migration:
> Deprecate block migration") would let us remove all that code in
> the next cycle which is even simpler.

Thanks for taking a look.  I can try to have a look at removing block
migration in 9.1.

Regarding to the failover failure - I still think what you posted as a
"hack" could be an official patch.  Do you plan to send it?  Or do you have
anything else in mind?

For 9.0, we're missing softfreeze. IIUC we can only merge things like
regression fixes, documentation updates, some test changess, etc.. into rc
windows. With QEMU's heavy reliance on CI now I don't even think most test
case changes would be applicable for RCs unless it's never run in a CI.  So
unless there's a strong need, it'll be easier if we wait for 9.1 (but yet
again, we can still queue them earlier, so they will appear in the 1st 9.1
pull).

Thanks,

-- 
Peter Xu


