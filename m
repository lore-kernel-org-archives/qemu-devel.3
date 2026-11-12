Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050FB606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HVS9pMB1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRURT-0000AZ-7m; Thu, 12 Nov 2026 08:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xRUR8-0008Kl-RP
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xRUR6-0005Kx-Aa
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794488511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q9yEj5+N1MgfukgNKbaNISPVmVSmZWeJLMxOKzlHfow=;
 b=HVS9pMB19cyhnuk1WW9l7peG45z+36jS2xk5ZhLya4Iu2D7HOOQoIMCGjcTyAa06FCfWhi
 4ou/d/YqP6cAQUryULJ/P8ROZqUIfVtTTBRZrn/kg7PVJ0fuzyxy3V4oxJQT+HGXklpbmC
 ek6ODl1xgN5U9wgx6nAqQ8e3Feh4D/o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-nmcExl37OzG6X2DHKTiFzg-1; Thu,
 12 Nov 2026 08:01:46 -0500
X-MC-Unique: nmcExl37OzG6X2DHKTiFzg-1
X-Mimecast-MFC-AGG-ID: nmcExl37OzG6X2DHKTiFzg_1794488505
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7473D195609D; Thu, 12 Nov 2026 13:01:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.60])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 703971956086; Thu, 12 Nov 2026 13:01:43 +0000 (UTC)
Date: Thu, 12 Nov 2026 14:01:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] iotests: fix false positive on running-outside-venv
 warning
Message-ID: <avW4tfoJj5sw6_Fl@redhat.com>
References: <20261007183338.1899422-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007183338.1899422-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 07.10.2026 um 20:33 hat John Snow geschrieben:
> Currently, iotests checks to see if you are running with the "correct"
> python interpreter by checking string equivalence between your current
> python and the configure-time venv python.
> 
> Depending on exactly *how* you launch or configure your python,
> however, this warning may produce false positives because it treats
> "python" as different from "python3" as different from
> e.g. "python3.12", even though they are all actually the same exact
> interpreter.
> 
> This patch fixes this by comparing only the parent directories; we
> will now be happy with any interpreter so long as it is located within
> build/pyvenv/bin/.
> 
> Note that we cannot fix this by resolving symlinks, as python venv
> binaries are often (but not always) just symlinks to /usr/bin/<etc>,
> and full resolution would produce even more false negatives.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: John Snow <jsnow@redhat.com>

Thanks, applied to the block branch.

Kevin


