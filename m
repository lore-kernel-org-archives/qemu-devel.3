Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C43CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYzA-00082R-L5; Tue, 29 Sep 2026 10:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xBYz6-00081X-LT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xBYz5-0002cc-70
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790692746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDIe1z5fgliycx5PBCFycn92kDwDeCNiWibSTQw6qAU=;
 b=U/EVNr7kf0va2RfzoSvwP/nRIaeE8ewN3CMNNOD5kqe4z2XFe9EJxbohWSdcKCF8VREZml
 KS4u8U7oSymO57g69qDh3L75MKKRM+zSXMTWV1BStEkU4zbdDJg7V0GU1M2zimJNbc+tSb
 QH4NHfEEdJm6Hy4gq9WEN7eWpex2qn4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-Hou3eabCO_qyC2fn0k1_fg-1; Tue,
 29 Sep 2026 10:39:04 -0400
X-MC-Unique: Hou3eabCO_qyC2fn0k1_fg-1
X-Mimecast-MFC-AGG-ID: Hou3eabCO_qyC2fn0k1_fg_1790692743
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C9D01933B45; Tue, 29 Sep 2026 14:39:03 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.225])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE0A21956042; Tue, 29 Sep 2026 14:39:00 +0000 (UTC)
Date: Tue, 29 Sep 2026 16:38:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] iotests: remove unused 'owner=' variable assignment
Message-ID: <arvNgvmyp69UYcGD@redhat.com>
References: <20260810141206.525581-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810141206.525581-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 10.08.2026 um 16:12 hat Daniel P. Berrangé geschrieben:
> Most, but not all, of the shell I/O tests assign an email address to
> the 'owner' shell variable. This variable is never used for anything
> so gets reported as a dead assignment by shellcheck. The same is also
> not done for the python I/O tests, though some include owner= in a
> comment.
> 
> Mostly the 'owner=' variable seems to be an alternative to expressing
> an "Author: NAME <EMAIL>" comment, but without the NAME. While they
> could be converted to Author comments, this does not have a benefit
> over using Git history and are not widely used in QEMU source code.
> Git records activity over time so is more representative than the
> initial author. Meanwhile the MAINTAINERS file, also expresses a
> notion of ownership over the maint of files.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Ok, why not. I don't think I ever looked at the line to figure out who
to contact.

> diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
> index 6f980fd34d..d26c13ea03 100755
> --- a/tests/qemu-iotests/001
> +++ b/tests/qemu-iotests/001
> @@ -19,8 +19,6 @@
>  # along with this program.  If not, see <http://www.gnu.org/licenses/>.
>  #
>  
> -# creator
> -owner=hch@lst.de
>  
>  seq=`basename $0`
>  echo "QA output created by $seq"

But can you remove one of the now two empty lines after the comment
block, too, please? (Same for every hunk.)

Kevin


