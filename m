Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A820C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj9pf-0005Hf-Vo; Mon, 13 Jul 2026 02:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wj9pe-0005HD-CK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wj9pd-00055Y-5X
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783922876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/iYGnNN2uyHBACPeGmmYRSVx8sfpIg3LBdDL7Z5HB7U=;
 b=MYA2vr9l27JWk9R4AOv/0pMxekmar5boMf9QKvTYYePgXfRMzWoalU/7N6misItTlv8vEv
 kBdOMOqzia9yKGjy6sBvxtwvZ+qba02uwR4nteaKLatFHLI1nYQvSzJfwR7hwHUEtvI/E5
 dN9ZtJ1+o/TTscWL7HCTqmd53OBO/+A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-nrEmPKWeN6S9NLuE0LRPWQ-1; Mon,
 13 Jul 2026 02:07:53 -0400
X-MC-Unique: nrEmPKWeN6S9NLuE0LRPWQ-1
X-Mimecast-MFC-AGG-ID: nrEmPKWeN6S9NLuE0LRPWQ_1783922872
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 422C51955DDE; Mon, 13 Jul 2026 06:07:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2E00195419F; Mon, 13 Jul 2026 06:07:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 32C7921E6920; Mon, 13 Jul 2026 08:07:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  alistair23@gmail.com,  qemu-riscv@nongnu.org,
 bin.meng@processmission.com,  mzamazal@redhat.com,  sgarzare@redhat.com
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark "vhost-user-scmi" orphaned
In-Reply-To: <20260711035848-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Sat, 11 Jul 2026 04:00:10 -0400")
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-3-armbru@redhat.com>
 <20260711035848-mutt-send-email-mst@kernel.org>
Date: Mon, 13 Jul 2026 08:07:49 +0200
Message-ID: <87fr1nwhfu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Jul 10, 2026 at 01:43:05PM +0200, Markus Armbruster wrote:
>> Commit a5dab090e1 (hw/virtio: Add boilerplate for vhost-user-scmi
>> device, 2023-06-28) added the section with S: Supported, but no M:.
>> This makes no sense.  Downgrade to S: Orphan.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>
> No, this makes sense. The reason this section was added is so that Milan can
> get copied on vhost-user-scmi but not other virtio stuff:

The section's S: is confusing.

> ./scripts/get_maintainer.pl -f hw/virtio/vhost-user-scmi.c
> Milan Zamazal <mzamazal@redhat.com> (reviewer:vhost-user-scmi)
> "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost)
> qemu-devel@nongnu.org (open list:All patches CC here)
>
> Pls drop this patch.

Done.


