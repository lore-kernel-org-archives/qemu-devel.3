Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2858FCD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKche-0007kJ-EC; Wed, 06 May 2026 09:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKchc-0007k0-Ni
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKcha-0007N2-IJ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778075653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+QhbvYAmYNexNcjfjTevz8GNne3BxIxGTPeqj8Oq9UA=;
 b=AWHFrq/KPs3CB4EMtKALwldDREoN3nV2n75WcSOv7C3CNbhuO5PfnGZgzqZTWlR/xQD2QI
 xoybI6XPyAnZ2ZyI1VI2VSDwbBbLs0fbUoYfRaQQzmKIAl6/5NnLi44t2txVjhquZ8Jtjy
 PlM2yAFQQSG2k9WIr84GRExr/tsRuIU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-ZEcnUJmEO2-Q4sOUebK2Sg-1; Wed,
 06 May 2026 09:54:09 -0400
X-MC-Unique: ZEcnUJmEO2-Q4sOUebK2Sg-1
X-Mimecast-MFC-AGG-ID: ZEcnUJmEO2-Q4sOUebK2Sg_1778075645
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43A4319560AD; Wed,  6 May 2026 13:54:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A307E3002D31; Wed,  6 May 2026 13:54:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D34B21E6A01; Wed, 06 May 2026 15:54:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Thomas Huth <thuth@redhat.com>,
 linux-edac@vger.kernel.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: update HEST maintainership entries
In-Reply-To: <6316f5b788cdc6b63e808606649dc5862271b22e.1778075257.git.mchehab+huawei@kernel.org>
 (Mauro Carvalho Chehab's message of "Wed, 6 May 2026 15:47:37 +0200")
References: <6316f5b788cdc6b63e808606649dc5862271b22e.1778075257.git.mchehab+huawei@kernel.org>
Date: Wed, 06 May 2026 15:54:02 +0200
Message-ID: <87y0hwabk5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Mark HEST code as maintained and assign them to me.
>
> While here, add a "L" entry to EDAC ML as RAS discussions
> usually happen there.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thank you!

Acked-by: Markus Armbruster <armbru@redhat.com>


