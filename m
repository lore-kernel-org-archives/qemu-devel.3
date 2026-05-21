Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FB8CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ0A0-0001NB-2y; Thu, 21 May 2026 05:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wQ09y-0001Mn-QE
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wQ09w-0006ud-Fj
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779357463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HmnCA60Rn/YOtUo3qbO1bJuoxWl9y5OCIjaYMyPXGCQ=;
 b=V1hS/zayQgxbCqrskcTYTDr920OTaw10Jz6qx55upbj8JAVbnkEWNxcy17ok+yqS9Od2lL
 rwIVjGKXKjquiCVGRCBmSDovHooVEo2n0vOLbKDPJGqf89FuBy7JjiL6kYrVczTyWqgOGS
 DEpz0Ladp/aahmkZ+ioPDYf4iHT+Zt0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-uZ1gxa7kMUGrWfiT06CgCQ-1; Thu,
 21 May 2026 05:57:39 -0400
X-MC-Unique: uZ1gxa7kMUGrWfiT06CgCQ-1
X-Mimecast-MFC-AGG-ID: uZ1gxa7kMUGrWfiT06CgCQ_1779357458
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92D5D195608B; Thu, 21 May 2026 09:57:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 367ED1684; Thu, 21 May 2026 09:57:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C0E1321E6A01; Thu, 21 May 2026 11:57:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 pierrick.bouvier@oss.qualcomm.com,  Amit Shah <amit@kernel.org>,  Mathieu
 Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 23/39] MAINTAINERS: Fix bad / stale F: in "virtio-rng"
In-Reply-To: <c27cb59f-db7c-4ee9-9035-464aecadbdb9@redhat.com> (Laurent
 Vivier's message of "Thu, 21 May 2026 11:03:23 +0200")
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-24-armbru@redhat.com>
 <c27cb59f-db7c-4ee9-9035-464aecadbdb9@redhat.com>
Date: Thu, 21 May 2026 11:57:35 +0200
Message-ID: <87ldddozjk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Laurent Vivier <lvivier@redhat.com> writes:

> Hi,
>
> it seems to be "vhost-user-rng" rather than "virtio-rng"

Yes, my bad.  Thanks!


