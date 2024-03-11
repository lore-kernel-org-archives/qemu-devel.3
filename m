Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772A8C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmGU-0002xr-7C; Mon, 11 Mar 2024 16:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmGR-0002xf-Eh
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmGP-0005RC-3J
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710188927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2vv4sRGv3k/5RV6ThrSIcqwYxZscPYExrXYmn5yPbU=;
 b=gaL4LDLNkiY9ijfpIXlo/h1eV1KY/FpxM3ZmDHwvcm48g72977UOReXIKl2scSdbMiPNPI
 mdDRenGnqnoLKZzv6+NzSBHMfHNlnf70hqiGii/c9SWoyOinZ1u/HjW7nU76cG/u1gK2Jc
 f/TQ4vrte0qRT1PWpNw94p1doWZRIKM=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-0iUtxQd8PmSnPcK8B0uKSA-1; Mon, 11 Mar 2024 16:28:43 -0400
X-MC-Unique: 0iUtxQd8PmSnPcK8B0uKSA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-2218be82ae7so1050589fac.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710188923; x=1710793723;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c2vv4sRGv3k/5RV6ThrSIcqwYxZscPYExrXYmn5yPbU=;
 b=dTYTz4DNqdptxAK32S3P9o2y+TrNNFexzdxqLRklWR3ugBirFPGfIv81a30oq9KjKn
 H7RswaYUS413J5+YJOwhxow3b4jKfScVijk3KymV2XnS1MXM/llA7yQ83LBo6RajnkQZ
 AVpDAli15/FxZk9VrpC3dQW4NW3isFthq8N4V+VI1jsnwKC2Z+G5xLes4WW+Fe6wkvIP
 GP4SSqGFMaZDOISIdjmKS2N0gft6d+vaJPr0t0/l0QKHxjNVOLLWMkZjE7AkMQtuEiwA
 woCqtLA3KQo1OzqMixvd83L9j5HaSPnol2dHEeuMDhfSFNmdKB6N1MDQWDrnoEyRapXe
 YFMw==
X-Gm-Message-State: AOJu0YzwD/BvYjBX/N7TmCbKEyhaEvP/dgSufdkibQVfBWJdZZTKFqPD
 CqKNGls0Upqcuy3kHieVqj4R6k7PL42OXkcAbtbvjTGU/CBVIAlO0TIiSEZ1pL07TSGXnwlxFcZ
 RM57oOMM7EYeeK/S4xxLo7gqXjwRUwjHq76Js4rnLxz1qoi7icmcL
X-Received: by 2002:a05:6871:829:b0:221:3a21:5b37 with SMTP id
 q41-20020a056871082900b002213a215b37mr7644328oap.4.1710188923253; 
 Mon, 11 Mar 2024 13:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYGFjcyP2nv6bLiAMnMtL4dMHiXPtJ+ygKhJ2U7RUY6Nvr7npZsoRm/SXiIODsUuL8EMS0PA==
X-Received: by 2002:a05:6871:829:b0:221:3a21:5b37 with SMTP id
 q41-20020a056871082900b002213a215b37mr7644296oap.4.1710188922908; 
 Mon, 11 Mar 2024 13:28:42 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 h11-20020a37c44b000000b007883e49837bsm3008847qkm.86.2024.03.11.13.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 13:28:42 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:28:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH V2 00/11] privatize migration.h
Message-ID: <Ze9pcgtMPVFM2CX8@x1n>
References: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
 <Ze9b7JULHLUoYGgV@x1n>
 <93cbe4f1-6451-4dc3-8150-f62a99f83f4a@oracle.com>
 <fb3d25ca-4a46-4a59-b172-cade9dbcbe55@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb3d25ca-4a46-4a59-b172-cade9dbcbe55@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Mar 11, 2024 at 04:24:14PM -0400, Steven Sistare wrote:
> On 3/11/2024 3:45 PM, Steven Sistare wrote:
> > On 3/11/2024 3:30 PM, Peter Xu wrote:
> > > Steve,
> > > 
> > > On Mon, Mar 11, 2024 at 10:48:47AM -0700, Steve Sistare wrote:
> > > > Changes in V2:
> > > >    * rebase to migration-next, add RB
> > > 
> > > Not apply even to master branch.  Note that there're >=1 PULLs sent and
> > > merged since my last reply..  Perhaps you rebased to the "old" next?
> > 
> > I pulled from branch migration-next in https://gitlab.com/peterx/qemu a
> > few hours ago, but I must have screwed up somewhere.  I'll figure it out
> > and post a V4.
> 
> My pull was a fiew hours old, but my patches still apply cleanly to the
> most recent tip:
>   a1bb5dd169f4 ("migration: Fix format in error message")
> 
> I can sent that as V3, but ...
> Note that you must apply "migration: export fewer options" before
> "privatize migration.h".  If that does not help, I will send V3.

Ouch, I forgot that dependency... Sorry.

Yeah it works now.  No need to resend for now.

-- 
Peter Xu


