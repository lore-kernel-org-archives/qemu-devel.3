Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4463ACD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 12:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMmL1-0003po-AO; Tue, 12 May 2026 08:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMmJt-0003VR-CA
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMmJm-0004K3-8S
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778589269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w6qMfSWV0SVl7RQ1coNdYguDG1GesSUrfFe5pgBiYDA=;
 b=cfxSOULZzIfv7XySWvNWkGwtQU8IevlWj2n+iLp+dQR6sgAqLWpzMCWCg6tr0cH9P4PV2x
 3U//wNOiRCTYUKkD6NdsHGDMOE3NTNdu0SgyKthAhzoA28w7Hx5m5k+Gc8mFS3Be2LCxv6
 9vmX/LB5qmCraeD+SBNJi5/BVTycQvw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-Z077yFlHMQq8_CO722-msQ-1; Tue,
 12 May 2026 08:34:22 -0400
X-MC-Unique: Z077yFlHMQq8_CO722-msQ-1
X-Mimecast-MFC-AGG-ID: Z077yFlHMQq8_CO722-msQ_1778589261
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DE9B18002FA; Tue, 12 May 2026 12:34:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.152])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B211C1800352; Tue, 12 May 2026 12:34:18 +0000 (UTC)
Date: Tue, 12 May 2026 14:34:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as maintainer for replication
Message-ID: <agMeSMj8XETo1vMn@redhat.com>
References: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Lukas,

Am 25.04.2026 um 16:08 hat Lukas Straub geschrieben:
> I recently took up maintainership for the orphaned COLO migraion component.
> Here I take over maintainership for replication which is another important
> component for COLO.

What are your plans with replication? Will you be sending pull requests
directly to the global maintainer, or should we keep taking patches
through the block layer queues with your Acked-by?

Same question for this series, will you merge it yourself or would you
like someone else to pick it up?

> To: qemu-devel@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zhang Chen <zhangckid@gmail.com>
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
> Lukas Straub (2):
>       MAINTAINERS: Add myself as maintainer for replication
>       MAINTAINERS: Rename Replication -> COLO block replication

Acked-by: Kevin Wolf <kwolf@redhat.com>


