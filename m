Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DFBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sav4s-000478-G7; Mon, 05 Aug 2024 06:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sav4m-000445-W3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sav4l-0007S8-BC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722854186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2rCIQn8mbNUu0AU533hRGwmW/3ry4r598ZD1LKx3FrU=;
 b=bTveaf6noESAqAT6yXpM/8QkXsokikROK43k7g0QRpWLnZ0Q3TttE8c5y+HvT8jwHfLQOE
 Cdgu/w69yM5gAzuQtIVrIzz8WRyJwhl/s3iVYaVzSaeMdvahzuRBkxkKXJbQ9CEKGzpUNG
 ud7h4d99PsusVZqBP7pFQBvOq6GDhWI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-WB_ihGq-NG6q8iLD_WUQyQ-1; Mon,
 05 Aug 2024 06:36:22 -0400
X-MC-Unique: WB_ihGq-NG6q8iLD_WUQyQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 838251955D4E; Mon,  5 Aug 2024 10:36:21 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.224])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25E2319560AA; Mon,  5 Aug 2024 10:36:18 +0000 (UTC)
Date: Mon, 5 Aug 2024 12:36:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 hreitz@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH] iotests/024: exclude 'backing file format' field from
 the output
Message-ID: <ZrCrGskHtP7gAoOX@redhat.com>
References: <20240730094701.790624-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730094701.790624-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 30.07.2024 um 11:47 hat Andrey Drobyshev geschrieben:
> Apparently 'qemu-img info' doesn't report the backing file format field
> for qed (as it does for qcow2):
> 
> $ qemu-img create -f qed base.qed 1M && qemu-img create -f qed -b base.qed -F qed top.qed 1M
> $ qemu-img create -f qcow2 base.qcow2 1M && qemu-img create -f qcow2 -b base.qcow2 -F qcow2 top.qcow2 1M
> $ qemu-img info top.qed | grep 'backing file format'
> $ qemu-img info top.qcow2 | grep 'backing file format'
> backing file format: qcow2
> 
> This leads to the 024 test failure with -qed.  Let's just filter the
> field out and exclude it from the output.
> 
> This is a fixup for the commit f93e65ee51 ("iotests/{024, 271}: add
> testcases for qemu-img rebase").
> 
> Found-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Thanks, applied to the block branch.

Kevin


