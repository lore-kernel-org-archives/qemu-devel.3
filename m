Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E31ACD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDbA-0001Qo-12; Wed, 13 May 2026 13:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wNDal-0001Ph-B6
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wNDah-0006lq-5G
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778694109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OcT/zJZpoWXc/hO7F/V/2ScLqbc4sRt2MbI9qeveX8E=;
 b=Rvtt9fy9MLB4+yoqYnlDgyhxz/+2HNI43qKC3XdqRoeyN6atpHrJT0UUm1ipHsZMGTORTQ
 E5hZkdKTYi4oO+h3YmonBFChTxboPsx1sWfXPG62YiqG75tY4QllKhXd8E3pp0+ctfGzeY
 h8lLnvRifl74fQE9eEWvOJ8sWeoAlto=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-gvu-uv7tOMCFXcgupIwbig-1; Wed,
 13 May 2026 13:41:41 -0400
X-MC-Unique: gvu-uv7tOMCFXcgupIwbig-1
X-Mimecast-MFC-AGG-ID: gvu-uv7tOMCFXcgupIwbig_1778694100
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A64019560A1; Wed, 13 May 2026 17:41:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94C9119560A2; Wed, 13 May 2026 17:41:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E8B221E6A01; Wed, 13 May 2026 19:41:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-ppc@nongnu.org,  qemu-devel@nongnu.org,  npiggin@gmail.com,
 rathc@linux.ibm.com,  milesg@linux.ibm.com,  adityag@linux.ibm.com
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer for PowerNV and PPC TCG
In-Reply-To: <20260501144558.24491-1-harshpb@linux.ibm.com> (Harsh Prateek
 Bora's message of "Fri, 1 May 2026 20:15:58 +0530")
References: <20260501144558.24491-1-harshpb@linux.ibm.com>
Date: Wed, 13 May 2026 19:41:37 +0200
Message-ID: <87cxyzp5pq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Harsh Prateek Bora <harshpb@linux.ibm.com> writes:

> Also remove the redundant entry for pseries.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

I'll take this through my tree.  Thanks!


