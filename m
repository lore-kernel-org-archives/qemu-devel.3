Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9F2C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjQN-0000th-9P; Fri, 17 Jul 2026 10:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkjQL-0000t4-Vp
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkjQJ-0006pn-EB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784298018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TqjynaZJ3T5vXhPFO6S4R2h+TtDuA0HDkCuMwqZghJ4=;
 b=JLwaCeaTEH9UmFHClSjH9nM/p3FgGpkZQSgSN9yuWkHU4yKWnIrCk3bUbvZbVU5uneC4Lt
 ueuJOfVrQ3EC0PWPuwSdYXAJHUj9h0EFcjqm+W2XPM79QriNUL4fFlVSQKK/oNPNcIQICr
 EMw+aA++LwOeDJW9kkSRszrwqPDQw/g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-gieoI-RGNIy9epZZPDTKow-1; Fri,
 17 Jul 2026 10:20:15 -0400
X-MC-Unique: gieoI-RGNIy9epZZPDTKow-1
X-Mimecast-MFC-AGG-ID: gieoI-RGNIy9epZZPDTKow_1784298014
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 384721955D59; Fri, 17 Jul 2026 14:20:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48CE4195604D; Fri, 17 Jul 2026 14:20:10 +0000 (UTC)
Date: Fri, 17 Jul 2026 15:20:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 6/6] qom/object.c: rename
 object_class_property_uint*_ptr() to
 object_class_static_property_uint*_ptr()
Message-ID: <alo6F68cv-anFwc5@redhat.com>
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
 <20260717135254.508701-7-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717135254.508701-7-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 17, 2026 at 02:51:46PM +0100, Mark Cave-Ayland wrote:
> This more accurately reflects that these properties are held within the class and
> not the object. Update the documentation to describe the few cases where static
> properties should be used.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/qom/object.h | 56 +++++++++++++++++++++++++++++++-------------
>  hw/riscv/spike.c     |  5 ++--
>  qom/object.c         | 28 ++++++++++++----------
>  3 files changed, 59 insertions(+), 30 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


