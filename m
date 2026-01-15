Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CC5D46610
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSTk-0007aR-TT; Thu, 15 Jan 2026 13:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgSTe-0007XO-Hi
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgSTc-0005Zh-SB
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768503227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jJ1/sybIWubS1aoRl7iPWQOB1qX4Sbm+k1dXhZnoQUE=;
 b=QU53HgWUa8Kuyamphq//X/OjeggJUd53o0wGy1k4C+UHfDSSZwg/oSpg6+39AsLt93nL/W
 RdKgcsfd63KVpD537Gqqdp7/vhTuMxbzLeClXqc8J3PGRlRjHgqSvCYpxs7tvlf/GttOwO
 NYFYgLMvi7mnH0dHygMnZP8Glni6YOs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-6oYLoVdNPvCvyBn1O1279g-1; Thu, 15 Jan 2026 13:53:45 -0500
X-MC-Unique: 6oYLoVdNPvCvyBn1O1279g-1
X-Mimecast-MFC-AGG-ID: 6oYLoVdNPvCvyBn1O1279g_1768503225
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a316ddbacso31830636d6.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768503225; x=1769108025; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jJ1/sybIWubS1aoRl7iPWQOB1qX4Sbm+k1dXhZnoQUE=;
 b=JF6NORhmlXWmEYr+y9cXJ5L1jG1Dung7KgS7yq7cxbB2XxvkA3aMdmdR9KoMDXzeiG
 /yf3tOHd9kOBFxv++R/6BvE+AmqcD/Y13DL+vuxiVHuLnCDslkK8psAWv/rd0Nl+tHmH
 gUv13t7PaGZtnUrWldnvxxLaF6ThTv6/HZpU0kyqKIh+5/4m6PipvAxxBAqWwE06FiVK
 yIAg2Yg5AfK+i1OWqojUnuvMW/oqFE4djC/gA9uSVAkrp+wA0OUeSQxLjTlIarJfECVm
 E0aHeLbqu8c+miSYTuzQxzk3LLgMP34T1/t+7Pymbf/ouuihz7V/zgtkDNJpqAk5JTfF
 BwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503225; x=1769108025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJ1/sybIWubS1aoRl7iPWQOB1qX4Sbm+k1dXhZnoQUE=;
 b=OPOP7F3yGecSasQ76sv5xsEpLjfjTdbe0nhDSacZfBnIC4YlSefZrU+X/IaAc1O/yC
 spvmtbynbfXT2sxTteiFsXoXQEkLofUFgbCkwzLjy/Ur2L4FwbPTLK/a2QO2reDjbkCN
 ObH6bpG4DiR15kPbTXuaFC4G+ZS+uf6HnFihyDUF2l2a8wEujibDRupJIAszsVCnLbzz
 F7cXdFlqZgDfmw0NnIa/EIQ8yZMTBFmUQG4CrOss8OFGSUAzdhGQI29qJis+FEhn8N99
 6IG/iDefptFEO4E620O23aGKBualMsMU+EcgMRPuey4pQ8duj+vJ/HcGUhjf1c2G4/qc
 iC6Q==
X-Gm-Message-State: AOJu0Yw2ANWSbDdzhQPgPtt4oYZwme5sL4iippPr+QzCe7sL8hjNbMCq
 4SEFsrAKF2XfnxjxjOZXmUODcYgKeZvyR6TOfigmtwUlDTDVi137JBv2jpuZ0ta8rcaLBzC9FwM
 LeSDWOVJpRzlRL8g6/wb30enRLebgpaJOA+uie9MY2/tpFt/PE/JbVB6N
X-Gm-Gg: AY/fxX4G+C4Lm/ojsANFGy0pt5Kvmhsc8qfzi3Y6Opc13F46OKufC7bal4YmKylXGVv
 oOnHDwCCRXtVZDVz/Sfquz+ASaT1N46E7oRLHHaF1w4xoGnQdASsqDUiM3MwJBWVaNyKSITIrGY
 tiZKuseXHnMu3qT4qd4lAwa6EzY8WEmXU/T4+thwosNVda6EXmHb3F090Duf4hlW8vr83sl292q
 s8tq/GYdLCvbh268rIunds7HAqbGV6SHIa0PLHv7YJjDPb4HBz847omxvXJVU9Im3rRp/n6miKZ
 tZU0+NTr7yTQikg3AV2mAG9FdPEuqN/fLBZwV5SAE4VCGmwbhcAow3r/knQ5bdHHa4u/Wjv3Hks
 9Hnc=
X-Received: by 2002:a05:6214:2523:b0:88a:2e39:957e with SMTP id
 6a1803df08f44-8942dd9e90fmr4829226d6.57.1768503224967; 
 Thu, 15 Jan 2026 10:53:44 -0800 (PST)
X-Received: by 2002:a05:6214:2523:b0:88a:2e39:957e with SMTP id
 6a1803df08f44-8942dd9e90fmr4828916d6.57.1768503224419; 
 Thu, 15 Jan 2026 10:53:44 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e5e5352sm2283106d6.3.2026.01.15.10.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:53:44 -0800 (PST)
Date: Thu, 15 Jan 2026 13:53:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 2/3] migration: Remove zero-blocks capability
Message-ID: <aWk3shSD4ixPt_Z0@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-3-peterx@redhat.com>
 <871pjrza7m.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pjrza7m.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 15, 2026 at 07:00:45AM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > It was declared deprecated since 9.2.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  docs/about/deprecated.rst       |  6 ------
> >  docs/about/removed-features.rst |  6 ++++++
> >  qapi/migration.json             | 11 +----------
> >  migration/options.c             |  5 -----
> >  4 files changed, 7 insertions(+), 21 deletions(-)
> >
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index b499b2acb0..6e4e2e4833 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -575,12 +575,6 @@ deprecated in favor of explicitly using the ``file:`` URI with the
> >  file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
> >  command documentation for details on the ``fdset`` usage.
> >  
> > -``zero-blocks`` capability (since 9.2)
> > -''''''''''''''''''''''''''''''''''''''
> > -
> > -The ``zero-blocks`` capability was part of the block migration which
> > -doesn't exist anymore since it was removed in QEMU v9.1.
> > -
> >  COLO migration framework (since 11.0)
> >  '''''''''''''''''''''''''''''''''''''
> >  
> > diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> > index e81d79da47..8a9d21068a 100644
> > --- a/docs/about/removed-features.rst
> > +++ b/docs/about/removed-features.rst
> > @@ -717,6 +717,12 @@ Block migration has been removed. For a replacement, see "QMP
> >  invocation for live storage migration with ``blockdev-mirror`` + NBD"
> >  in docs/interop/live-block-operations.rst.
> >  
> > +``migrate-set-capabilities`` ``zero-blocks`` option (removed in 11.0)
> > +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > +
> > +The ``zero-blocks`` capability was part of the block migration capability
> > +that got removed.  Removed with no replacement.
> > +
> 
> Suggest something like
> 
>    The ``zero-blocks`` capability was accidentally left behind when
>    block migration capability got removed in 9.1.  Removed with no
>    replacement.

Will do.

> 
> >  ``migrate-set-parameter`` ``compress-level`` option (removed in 9.1)
> >  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> >  
> 
> [...]
> 

-- 
Peter Xu


