Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C26F436B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkzM-0003m8-Kh; Fri, 17 Apr 2026 11:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wDkzK-0003lb-QI
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wDkzJ-0001ht-9U
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776439208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ghxtZg9CyGT1zbyVJenZXcL3fIwlchkEMil0Wq9SCY=;
 b=AQoM39JgaYxjRyRVjVhKNYXjGqGXQmrgCzhtop4PJhCF3V8VWJj4pkV3aZmRCqBvCcyuma
 EQ58PPLi83aduWKHgO7wxiHb85bUPvwuiX2TfGXwINTbN0Hb1r6OIqT5tT/YcUgPAN9fpD
 hhok5B4Qka4KGus1iE4M1jn9R63sgxU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-Qi-mIfU2P3-zUfg5z9ZZ3w-1; Fri,
 17 Apr 2026 11:20:04 -0400
X-MC-Unique: Qi-mIfU2P3-zUfg5z9ZZ3w-1
X-Mimecast-MFC-AGG-ID: Qi-mIfU2P3-zUfg5z9ZZ3w_1776439203
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFFB818005A8; Fri, 17 Apr 2026 15:20:02 +0000 (UTC)
Received: from localhost (unknown [10.44.48.66])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0239B1800906; Fri, 17 Apr 2026 15:20:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/2] hw/loongarch/virt: Add versioned machine type
 support
In-Reply-To: <20260401015705.3009762-1-maobibo@loongson.cn>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260401015705.3009762-1-maobibo@loongson.cn>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 17 Apr 2026 17:19:59 +0200
Message-ID: <87ldelty00.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Apr 01 2026, Bibo Mao <maobibo@loongson.cn> wrote:

> Now la464 CPU type feature is basically finished, versioned machine type
> is added here for compatibility support in future.
>
> ---
> v2 ... v3:
>   1. Refresh the patch based on the latest code
>   2. Change version machine from 11.0 to 11.1
>
> v1 ... v2:
>   1. Change version machine from 10.2 to 11.0
> ---
> Bibo Mao (2):
>   hw/loongarch/virt: Define virt machine type with type_init()
>   hw/loongarch/virt: Define versioned virt machine
>
>  hw/loongarch/virt.c | 66 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 53 insertions(+), 13 deletions(-)

LGTM.

(For the new compat machines, you could either pick the patch yourself
or wait until the s390 changes get merged, I guess.)


