Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F7AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYmCc-0002M7-8u; Tue, 30 Jul 2024 08:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sYmCM-0002JI-3h
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sYmBq-0007qa-L2
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722343321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JycbVMmMRlQiGwD4Kn9RJXFGAHh+tI+ECZkH/3uGGZs=;
 b=G+R4vqcTc5HFO1BMEBFBSu4tbqjMnR5aXgYj6MV1hlglQGMfchfhFQh83tyFQ3EdcYqSj3
 yKIZipl0N5JygGDd1Qdhj8aT7Ajdf0JVlHCpJE96DWlWOEG5fsuzRmkOwiUBLikrnDrKNL
 uC2LBtM3p1Mn+9qTbgcVgHOsoA910g4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-qw8dK3LXNeGxtlG7eBZLrA-1; Tue,
 30 Jul 2024 08:39:41 -0400
X-MC-Unique: qw8dK3LXNeGxtlG7eBZLrA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A531C1955D4D; Tue, 30 Jul 2024 12:39:40 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B12273000193; Tue, 30 Jul 2024 12:39:38 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:39:35 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH] iotests/024: exclude 'backing file format' field from
 the output
Message-ID: <mg4thvc6d2uhixhenryitgctf4hkzkxmefs7ykc2ywr3rjpuk2@vbxdqaqw6myi>
References: <20240730094701.790624-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730094701.790624-1-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Jul 30, 2024 at 12:47:01PM GMT, Andrey Drobyshev wrote:
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
> ---
>  tests/qemu-iotests/024     | 2 +-
>  tests/qemu-iotests/024.out | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


