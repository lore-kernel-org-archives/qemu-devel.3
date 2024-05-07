Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D729FC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 21:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4SIu-0002RR-9J; Tue, 07 May 2024 17:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4SIl-0002QL-Ue
 for qemu-devel@nongnu.org; Tue, 07 May 2024 17:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4SIi-0002sF-W4
 for qemu-devel@nongnu.org; Tue, 07 May 2024 17:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715117078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uh+qwMbLNvjpkxSfcevpmQuws+tbOebBqrnhG75VPJM=;
 b=BjxzVqWdC+l2T1TRAkjqyqLk95mjLAbx64u1Yr0hjMQme0+yFlAL/BHReC1cWOr2qDa9oV
 nB/0pq1KCm3XrCOStbALwH2nfQ8quwjjnLYDhkMrerYNd7iFGkmI0ADDWHMpFr4mn3Puqk
 B8+3XjT3ueT9JNHH3hkEtjuNFxwNxII=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-wR05hIAeO3KVSsx7tjk-aw-1; Tue, 07 May 2024 17:24:35 -0400
X-MC-Unique: wR05hIAeO3KVSsx7tjk-aw-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7f3873f8104so423051241.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 14:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715117074; x=1715721874;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uh+qwMbLNvjpkxSfcevpmQuws+tbOebBqrnhG75VPJM=;
 b=VFiHcFjEigWlt+1fYHB5pxHW1EzQm/5pfhlGqX9/a304R9WMWmuh8lvegaCts/4dBZ
 dRwI1eCl36lPW/iwVfL5+ScSfmo63A1CX3lyWjDMn5GWsD3ydrVhKMFmlFT9rz+Z6bcD
 BvoA65dP63CmdwrpHy1U4cIAYXBDPepxf1C1hJ6Aevxj5mL61I80SoFgNfp4V9DLEsxF
 eJyNR7zCOhYzCAUZbzICigkL2Djd3oN5Mx7FdKnjZ7Sq3lvMb86iuObxR57nqsAzdgYu
 mdyPTcyHi6E3+w45+d8XWToiinEm0v+LhfARIy7z7mS+vnZdX5vLJrSappFvjYuahEPV
 BwHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyUSw+dyYOobqh8kyjifpnKuExPF5597ky2KJOUshJXUQVx2VfyNyVymSLcGKcZOwJS1IUP4FuwChP1SmkBtCUisGhty4=
X-Gm-Message-State: AOJu0YxKa8VmWHoJUyjVlxZYRJ9fS6KCeTxx1M9dHwc07qdmV+IhYpwz
 ATMVWn9XCcXaaAveF72j8KLVIlw9061X1NlxGZdjVx3exfhojKMZ+Uu5DQ/q04mxxlZHStEcLU1
 kjRizgK7ne57OBPt9J3tQOYnPio5k8OQmtuhS/y9/pq0wbzHLtCCV
X-Received: by 2002:a67:f54b:0:b0:47c:2372:1130 with SMTP id
 ada2fe7eead31-47f3c3789fbmr664695137.3.1715117074252; 
 Tue, 07 May 2024 14:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPZ4ns4OQMHPXkmblzVRHD1L2832czuUznVjH30hCnKJvsmL+jB77Wx5jkzzQlMb0so1oJSQ==
X-Received: by 2002:a67:f54b:0:b0:47c:2372:1130 with SMTP id
 ada2fe7eead31-47f3c3789fbmr664666137.3.1715117073532; 
 Tue, 07 May 2024 14:24:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ne18-20020a056214425200b006a0e151d54csm4918260qvb.108.2024.05.07.14.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 14:24:33 -0700 (PDT)
Date: Tue, 7 May 2024 17:24:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fiona Ebner <f.ebner@proxmox.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 0/4] Fix "virtio-gpu: fix scanout migration post-load"
Message-ID: <ZjqcDqxxJDxsN5n7@x1n>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
 <87wmo5l58z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmo5l58z.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Tue, May 07, 2024 at 05:46:36PM -0300, Fabiano Rosas wrote:
> marcandre.lureau@redhat.com writes:
> 
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > The aforementioned patch breaks virtio-gpu device migrations for versions
> > pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is more
> > complex than it may initially appear, as evidenced in the problematic commit
> > dfcf74fa68c ("virtio-gpu: fix scanout migration post-load").
> >
> > To resolve this, we need to propagate the `vmstate` `version_id` through the
> > nested structures. Additionally, we should tie specific machine version to a
> > corresponding `version_id` to maintain migration compatibility.
> >
> > `VMS_VSTRUCT` allows specifying the appropriate version of the nested structure
> > to use.
> 
> This would have been caught by the migration-compat-x86_64 CI job had we
> added the virtio-gpu device to it.

I had exactly the same thoughts, and actually I added a todo after I
noticed this issue but I forgot to discuss with you today.. actually I have
one more on whether we can allow vmsd versioning to work for bi-direction
(then we can get rid of machine type dependencies), we may need the
handshake work as pre-requisite, so that two qemus need to talk first on
verify the vmsds.  But let's leave that for later.

> 
> $ cd build-8.2
> $ QTEST_TRACE='vmstate_*' QTEST_DEVICE_OPTS='-device virtio-gpu' \
> QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> QTEST_QEMU_BINARY_DST=../build-9.0/qemu-system-x86_64 ./tests/qtest/migration-test
> ...
> vmstate_n_elems fb.offset: 1
> vmstate_subsection_load virtio-gpu-one-scanout
> vmstate_subsection_load_good virtio-gpu-one-scanout
> vmstate_load_state_end virtio-gpu-one-scanout end/0
> vmstate_subsection_load virtio-gpu-scanouts
> vmstate_subsection_load_good virtio-gpu-scanouts
> vmstate_load_state_end virtio-gpu-scanouts end/0
> vmstate_subsection_load virtio-gpu
> vmstate_subsection_load_good virtio-gpu
> vmstate_load_state_end virtio-gpu end/0
> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-gpu instance_id=0 downtime=32118
> qemu-system-x86_64: Missing section footer for 0000:00:03.0/virtio-gpu
> vmstate_downtime_checkpoint dst-precopy-loadvm-completed
> qemu-system-x86_64: load of migration failed: Invalid argument
> 
> Some considerations:
> 
> 1) Here QTEST_DEVICE_OPTS is a hack I added on top, it doesn't currently
>    exist.
> 
> 2) This only uncovers relatively simple bugs where we don't need the
>    guest to access the device, it just needs to be there.

Right, but having something to cover the basics would still be nice,
because the rarer the bug the less impact to users too (I hope!), so they
can be with lower priority too when tested.

> 
> We could take the steps to enable this kind of testing if we think it's
> worthwhile. Some downsides are:
> 
> a) the item (2) above - situations that depend on guest behavior are out
>    of the picture because migration-test runs only a custom program that
>    dirties memory;
> 
> b) this test only works in CI or in a pre setup environment because it
>    needs the previous QEMU version to be built beforehand;
> 
> c) the full set of migration tests already runs a few times in CI via
>    make check, plus the compat job. We'll probably need to do some
>    simplification to avoid taking too much additional time;
> 
> d) there's also the obvious maintenance burden of choosing devices and
>    doing the eventual upkeep of the QEMU command line for the
>    migration-test.

The last one should be mostly fine, iiuc - we shouldn't add any device that
can easily break ABI, and the list of devices can start with a minumum; an
extreme case is we add one device only if something broke first with a
stable ABI.

Then if the ABI is stable, we need to go through the deprecation procedure,
and that takes two releases.  We can drop the device in migration-test in
the release of when deprecation starts.

Thanks,

-- 
Peter Xu


