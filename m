Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2BBCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxmg-0004Ai-P0; Fri, 29 May 2026 10:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxmW-00046T-Mw
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxmV-00079i-0N
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780063306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbXrp4Fg+JWr5HAr7WK7enq4G421fMo/fkRB7NYAe9E=;
 b=PPRROkE1TQUu9QAXdADNL3vtIJWVcMUo1rL3xgqgSkhjHVhWN8vWhwQgBKyc7bHQ03JMBZ
 PjruyXdvRrBc8nxJEh7e2GjG/ULpip9WUFat4fwMeJ//z/Pz+03/5sUCweHMLIqLCom2ON
 9LCmABGUQnOObDX89UdGgPTMwiMQ38Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-uYDj3SOINV-wkzXNpP3YrA-1; Fri,
 29 May 2026 10:01:42 -0400
X-MC-Unique: uYDj3SOINV-wkzXNpP3YrA-1
X-Mimecast-MFC-AGG-ID: uYDj3SOINV-wkzXNpP3YrA_1780063301
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0246E18002D0; Fri, 29 May 2026 14:01:41 +0000 (UTC)
Received: from localhost (unknown [10.67.32.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BFE51800347; Fri, 29 May 2026 14:01:38 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 0/4] buildsys: Stop checking for ESA/390 host
In-Reply-To: <20260519171240.97420-1-philmd@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260519171240.97420-1-philmd@linaro.org>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 29 May 2026 16:01:34 +0200
Message-ID: <875x46mi0x.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 19 2026, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> - Fix MAINTAINERS entries
> - Remove s390 check in ./configure
> - Replace __s390__ -> __s390x__
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   MAINTAINERS: Fix s390x storage key/attribute device paths
>   MAINTAINERS: Fix tcg/s390x/ path
>   buildsys: Stop checking for ESA/390 host
>   tests/tcg: Explicitly check for 64-bit z/Architecture
>
>  MAINTAINERS                    |  6 +++---
>  configure                      | 12 ++----------
>  include/qemu/cacheflush.h      |  2 +-
>  include/qemu/timer.h           |  2 +-
>  tests/tcg/multiarch/nop_func.h |  2 +-
>  block/file-posix.c             |  2 +-
>  disas/disas-host.c             |  2 +-
>  util/cacheflush.c              |  2 +-
>  8 files changed, 11 insertions(+), 19 deletions(-)
>

Thanks, queued patches 1-3 (3 with context tweak) to s390-next.


