Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C43606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XXuSuxFK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMs0r-000578-TB; Fri, 30 Oct 2026 15:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMs0q-00056i-Si
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMs0p-00060f-Hm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793387498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+bkxxW4K/9+AjsIchrpaygjmeOZk2FnyxrT/AS5IwPs=;
 b=XXuSuxFKKYRosW+Rnw6wEOOBBHGITws9YxG7V3JQtDHQMZFRQS1MLwXxX4F/c6JLaj948c
 9OdG21Rykt3b1kUplkl5DHzvJvdp1pPD2rO9yZaRVctjUTF7EGV0rt94gclxxe+7sUQDwj
 z44UJh3kzCW72L4Qjf70BrEanK6LY94=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-mXIS3Q5tPR6iWUe8LG0D3g-1; Fri,
 30 Oct 2026 15:11:27 -0400
X-MC-Unique: mXIS3Q5tPR6iWUe8LG0D3g-1
X-Mimecast-MFC-AGG-ID: mXIS3Q5tPR6iWUe8LG0D3g_1793387486
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 858F01800657; Fri, 30 Oct 2026 19:11:25 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.76])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB55518001CA; Fri, 30 Oct 2026 19:11:22 +0000 (UTC)
Date: Fri, 30 Oct 2026 20:11:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 3/3] iotests/290: add test case for qemu-img measure
Message-ID: <auTr2MD-y2aJTQMK@redhat.com>
References: <20260915140444.1223798-1-jean-louis@dupond.be>
 <20260915140444.1223798-4-jean-louis@dupond.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915140444.1223798-4-jean-louis@dupond.be>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 15.09.2026 um 16:04 hat Jean-Louis Dupond geschrieben:
> We create an image, write and discard some data in it, and then create a
> snapshot. In the snapshot we write and discard again some data.
> Then we measure the images with the base specified to calculate the
> merged image size. Finally we commit the image and check it's size.
> 
> This scenario is executed for discard-no-unref enabled and disabled.
> 
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>

You could maybe add the cases I commented on in patch 2, i.e. having an
explicit zero cluster in the base file (which shouldn't count) and an
encrypted base (which should count its clusters despite not having
BDRV_BLOCK_OFFSET_VALID).

Kevin


