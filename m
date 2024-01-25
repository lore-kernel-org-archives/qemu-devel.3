Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B258C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2va-0004LR-Oc; Thu, 25 Jan 2024 11:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rT2vY-0004L3-S9
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:50:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rT2vX-0007Ef-8h
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706201406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2TIFXIaacu2rgzZ8dWoK3wJ5CWDkJqcP2VFDGN5sdU8=;
 b=XkRmu8Tg6TCbaCJKWnAi6BQXd8joqJNMzkZbbwqIGEm521/cYKOnlPDwuNOEQ0JawX8kIO
 iqllQ0iEYvprQtTvucqLWKQ02B2GMkogtMcyXcDASJv4VgrquCF0oLfn2Y9bT9j2Cxfg1w
 aXFh+Q+MSUJDQwXv9SsiSUpzsyu7M8s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-anBaTzjiPvmB94fhIkgB-g-1; Thu, 25 Jan 2024 11:50:00 -0500
X-MC-Unique: anBaTzjiPvmB94fhIkgB-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C719827D87;
 Thu, 25 Jan 2024 16:50:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B5321121306;
 Thu, 25 Jan 2024 16:49:59 +0000 (UTC)
Date: Thu, 25 Jan 2024 17:49:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, qemu-devel@nongnu.org,
 npiggin@gmail.com
Subject: Re: [PATCH] tests/qemu-iotests: Bump timeout of iothreads-stream test
Message-ID: <ZbKRNj6qUSLkINho@redhat.com>
References: <20240124133538.2784097-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124133538.2784097-1-saif.abrar@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

Am 24.01.2024 um 14:35 hat Saif Abrar geschrieben:
> Current value of timeout=0.1 is sometimes too tight.
> Bump timeout to 0.3 to avoid test failures.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

This is not the real problem. The real problem is that the timeout makes
the test fail because we're catching the wrong TimeoutError class. What
it really should do is issue another query-jobs and go back to waiting.

I actually sent a patch earlier today to fix this:

https://lists.gnu.org/archive/html/qemu-block/2024-01/msg00353.html

Kevin


