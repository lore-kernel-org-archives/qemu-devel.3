Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0252606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SqZ0Umu1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWcUR-00027O-Je; Thu, 26 Nov 2026 11:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWcUM-00025y-Rn
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWcUL-0003Ly-FP
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795711103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y78kGiYoCblQOjBdtUPnGl0pPRlHlMguzfTIJgQmc7A=;
 b=SqZ0Umu13RMZ/46Tk/U0iMv/6vFwduk52t0GUY80QTznylwA2nhQSZYPpcpVmlWWrzLCht
 pN3wxtLaUJjkq/1dsqPFfh9vFWSe63cEbhiSjA6ZMziScpmrB+JkaiPLQGv5RX8JjhpsWt
 wPOWG1gzQQrPy7RoCDktg7c4LzZEIsI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-gwP2slUqO7exrIRrHJ3l9w-1; Thu,
 26 Nov 2026 16:38:19 +0000
X-MC-Unique: gwP2slUqO7exrIRrHJ3l9w-1
X-Mimecast-MFC-AGG-ID: gwP2slUqO7exrIRrHJ3l9w_1795711098
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 532C11955F10; Thu, 26 Nov 2026 16:38:18 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 886C7195604A; Thu, 26 Nov 2026 16:38:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Markus Armbruster <armbru@pond.sub.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, alex.bennee@linaro.org
Subject: Re: [PATCH 1/3] docs/devel: relax policy on AI-generated contributions
Date: Thu, 26 Nov 2026 17:37:57 +0100
Message-ID: <20261126163813.2314618-1-pbonzini@redhat.com>
In-Reply-To: <87tsl3yeln.fsf@pond.sub.org>
References: <20261124164217.1768040-1-pbonzini@redhat.com>
 <20261124164217.1768040-2-pbonzini@redhat.com>
 <awX8HEfLfE2x4hu7@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87tsl3yeln.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 13:14:12 +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>> If we can't identify that in a realiable way, IMHO the policy here will be
>> hard to carry out.
>
> Yes, but that doesn't necessarily make it not useful.
>
> We have many laws on the books that can be broken, with and without
> intent, in ways that are notoriously hard to detect.  Tax fraud, for
> instance.  We keep these laws anyway.  They serve as a clear statement
> of what conduct we expect and demand.  We make some effort to catch
> violations[*], but accept that we cannot catch them all.
>
> Could this policy be useful in similar ways?  Not the punishment part
> (there is none).  But a clear statement of what conduct we expect and
> demand.  Something we can point to when we reject slop.

I agree with the parallel (sometimes expressed as "the optimal amount
of fraud is not zero"); however, it leaves a hole for maintainers.

As a maintainer, I don't want to show that it is okay to ignore the
policy as long as you don't get caught; but at the same time, hopefully
I'll not be the one pushing slop in QEMU and in fact I want to be if
anything a positive example of how to profit from AI.

Paolo


