Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71E2C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIZw-0007pA-73; Wed, 28 Feb 2024 06:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rfIZu-0007oZ-IS
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:58:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rfIZt-00073w-0j
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709121503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRdAQ551NkGobukhi+9r4yjHrWN/nSBAekiV+icfRhU=;
 b=RzuTK4LhnrLG8QCgi0DZ5Bdiq5TMtyDpSCzsjl+TVhF/p0m3Dn1dgi54tsXFZkoGv+5RVp
 sFtwgMgz8lrNVWH/o5egN4Ea59yiIXnt4pczrIpQRlSEGdhf4nbJqdkyV6SXlT8ZgNpcDA
 GP5Mn/FjLfbKLSo5QQoxh20JTXMPPbU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-Se3dibaUMeK1WN2Gbx53RA-1; Wed,
 28 Feb 2024 06:58:22 -0500
X-MC-Unique: Se3dibaUMeK1WN2Gbx53RA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36A561C0513F;
 Wed, 28 Feb 2024 11:58:22 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40E18C0348D;
 Wed, 28 Feb 2024 11:58:21 +0000 (UTC)
Date: Wed, 28 Feb 2024 12:58:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qapi: Craft the BlockdevCreateOptionsLUKS comment
Message-ID: <Zd8f3CGhoDDsZnGU@redhat.com>
References: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
 <874je22u83.fsf@pond.sub.org>
 <CAK9dgmZkLZiT_W0UjB+=EN9_vAK5Qy5XKRMBhHBQ98sRBbiAQw@mail.gmail.com>
 <875xyiz0ho.fsf@pond.sub.org>
 <CAK9dgmZOEqd=EgBjsiZZoK3R+VQRMqSdUrK_WwKHfP7LiWzQMQ@mail.gmail.com>
 <87v8693x7c.fsf@pond.sub.org> <Zd8IQShNrGeXEnLz@redhat.com>
 <Zd8ZOHJxhgrmbIWc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd8ZOHJxhgrmbIWc@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

Am 28.02.2024 um 12:30 hat Daniel P. Berrangé geschrieben:
> On Wed, Feb 28, 2024 at 11:17:37AM +0100, Kevin Wolf wrote:
> > Until now, @size has been mandatory for creating images with every
> > driver. Maybe we should even have put it into BlockdevCreateOptions's
> > base, because without a size, you're not really creating an image.
> 
> NB, @size isn't mandatory for creating images. It isn't required
> when creating qcow2 files with backing stores, as the size is
> acquired from the backing file instead.
> 
> $ qemu-img create demo.raw 1g
> Formatting 'demo.raw', fmt=raw size=1073741824
> $ qemu-img create -o backing_file=demo.raw -o backing_fmt=raw -f qcow2 demo.qcow2
> Formatting 'demo.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1073741824 backing_file=demo.raw backing_fmt=raw lazy_refcounts=off refcount_bits=16

Yes, 'qemu-img create' is different, it adds some convenience magic like
this. But for 'blockdev-create', it's mandatory for every driver. I
double checked the QAPI schema.

Kevin


