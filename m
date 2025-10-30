Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CB9CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESe3-0008TN-TS; Thu, 30 Oct 2025 09:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vESdz-0008S0-H7
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vESdk-0005eJ-7l
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761830666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+t6joo9guDcAdqYcwidgb5UKo7/tSfETZ2kJ8OSVWg=;
 b=cGXdO+XoaQQL3DdUXSFTft7dLHmUrqzf/TcNKbk0omVhAJui1m9dSCSvPY8ie1/McWdil8
 iaEUcxjNhyOScH/XuzlOqtly/s+50xJWiJ2DS9kImF43NQFh7aN014vBdRSouql778J4JU
 ZCTahrywZmzFq8UJW/CE+1JZYUeZIbw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-Rxk8WMBpP_id3gfBQtQ8-A-1; Thu,
 30 Oct 2025 09:24:22 -0400
X-MC-Unique: Rxk8WMBpP_id3gfBQtQ8-A-1
X-Mimecast-MFC-AGG-ID: Rxk8WMBpP_id3gfBQtQ8-A_1761830662
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0F02180AE03; Thu, 30 Oct 2025 13:24:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7117930001A1; Thu, 30 Oct 2025 13:24:19 +0000 (UTC)
Date: Thu, 30 Oct 2025 14:24:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4] block: replace TABs with space
Message-ID: <aQNnAfGGjlMbxpLi@redhat.com>
References: <20251007163511.334178-1-thuth@redhat.com>
 <3fedb6dd-fd2c-48ff-97de-24b4e6d08aec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fedb6dd-fd2c-48ff-97de-24b4e6d08aec@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 30.10.2025 um 13:51 hat Thomas Huth geschrieben:
> On 07/10/2025 18.35, Thomas Huth wrote:
> > From: Yeqi Fu <fufuyqqqqqq@gmail.com>
> > 
> > Bring the block files in line with the QEMU coding style, with spaces
> > for indentation. This patch partially resolves the issue 371.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/371
> > Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> > Message-ID: <20230325085224.23842-1-fufuyqqqqqq@gmail.com>
> > [thuth: Rebased the patch to the current master branch]
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   I came accross this old patch today - it fell through the cracks
> >   in 2023, but I think it's still worth to get the coding style
> >   finally fixed in these files.
> 
> Ping!
> 
> Kevin, if you don't have any concerns, could you pick it up via your block
> tree, please?

I think v3 was closer to what I had in mind, so I was planning to have a
closer look and merge some mix of them. Just didn't get to it yet.

Kevin


