Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C218CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0Lj-0003Qh-Nr; Thu, 23 Oct 2025 14:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vC0Li-0003Py-7W
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vC0Lg-0001q8-UU
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761245264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26rkqkMyMyT3FJEkuwcl8NsYfREVdvrGfbjXgjsUy+4=;
 b=HfiqgZiuohnRSaDGiIGBb/QCLKNAVhmyuz1ODg3iax3aZzxQr4i2K5zsFY4tDXuNWVHGRE
 LRI8niOO+N1GSRpnAbvVaOb2xJToxlHbBJ22CpmMwFgLZL6Tn1HyMjeVlWkvI7mYm3JJfi
 Wxpb3yoPPAmK57HNv3fFmLQhZCNdJzU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-9UR4Y8HeMkmsUmBHXoQfJw-1; Thu,
 23 Oct 2025 14:47:40 -0400
X-MC-Unique: 9UR4Y8HeMkmsUmBHXoQfJw-1
X-Mimecast-MFC-AGG-ID: 9UR4Y8HeMkmsUmBHXoQfJw_1761245260
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFAE91956052; Thu, 23 Oct 2025 18:47:39 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.90])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17F4719540EB; Thu, 23 Oct 2025 18:47:37 +0000 (UTC)
Date: Thu, 23 Oct 2025 20:47:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 3/5] vvfat: add a define for SECTOR_SIZE
Message-ID: <aPp4R9jcHqxDzfNc@redhat.com>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-4-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903075721.77623-4-chigot@adacore.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 03.09.2025 um 09:57 hat Clément Chigot geschrieben:
> This makes those 0x200 far clearer.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>  block/vvfat.c | 60 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 27 deletions(-)

> @@ -1513,7 +1515,7 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
>                               " allocated\n", sector_num,
>                               n >> BDRV_SECTOR_BITS));
>                  if (bdrv_co_pread(s->qcow, sector_num * BDRV_SECTOR_SIZE, n,
> -                                  buf + i * 0x200, 0) < 0) {
> +                                  buf + i * SECTOR_SIZE, 0) < 0) {

We get a nasty mix of BDRV_SECTOR_SIZE (the QEMU block layer's sector
size) and the new SECTOR_SIZE (the FAT file system's sector size) here.
I think both of these actually refer to FAT.

Should we also change those instances of BDRV_SECTOR_SIZE that really
should be SECTOR_SIZE?

Kevin


