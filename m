Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59E4CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIuo-0004rO-0w; Tue, 04 Nov 2025 10:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGIul-0004po-Tb
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGIui-0006Wz-BT
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762269938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qNhTsU9qcEWV18121LGheTobqNOasnmeNmb8hcYYtyE=;
 b=QKFyiY4gPhABq4+Vm8i9/1vVRKhDnEY/cnLBkmwWycdzzlKj+4MCJrgmArFk0ZBFbCJCyq
 lcmUxj00L/vCB3P+PNJsW4pI7nrPDiwalKUMfhZ6UrN0OllK253Cux3gck0NkyQhrCyc2N
 8317eddrsPtp5hn1X5kdgdHvanYnBJM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-9FRZ46uONqCbQFSiidrrbg-1; Tue,
 04 Nov 2025 10:25:35 -0500
X-MC-Unique: 9FRZ46uONqCbQFSiidrrbg-1
X-Mimecast-MFC-AGG-ID: 9FRZ46uONqCbQFSiidrrbg_1762269934
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5183B195606D; Tue,  4 Nov 2025 15:25:34 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E27719560B2; Tue,  4 Nov 2025 15:25:31 +0000 (UTC)
Date: Tue, 4 Nov 2025 16:25:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v4] block: replace TABs with space
Message-ID: <aQoa6OKSz8BTIbtQ@redhat.com>
References: <20251007163511.334178-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007163511.334178-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

Am 07.10.2025 um 18:35 hat Thomas Huth geschrieben:
> From: Yeqi Fu <fufuyqqqqqq@gmail.com>
> 
> Bring the block files in line with the QEMU coding style, with spaces
> for indentation. This patch partially resolves the issue 371.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/371
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> Message-ID: <20230325085224.23842-1-fufuyqqqqqq@gmail.com>
> [thuth: Rebased the patch to the current master branch]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I came accross this old patch today - it fell through the cracks
>  in 2023, but I think it's still worth to get the coding style
>  finally fixed in these files.

Thanks, applied to the block branch (after bringing back some of the
vertical alignment that v3 had).

Kevin


