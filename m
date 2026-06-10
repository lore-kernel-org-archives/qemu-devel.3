Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31E6CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIwL-00024p-4n; Wed, 10 Jun 2026 09:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIwK-00024M-0N
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIwI-0006KU-8l
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781097949;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYxI0swasrth0x1SN7eKkcoGMiHKfsxR7Wj0LHAr1Z4=;
 b=EI0aFcOmO1aw72FcC6zEwBrJRwJ5onfxZ5TghV4p0cFzkX1JVfXNUu+m8piNSgTQNVwlyJ
 3xvDTbTRltIEsRaSZLE7ojvFTPF6To/MICPKrxDRX8Lth0D6O3q+t0Q9eQOKPxQk47pLFA
 PfcTbosnje7UOKSczj2+yK6YfV79qk0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-8167ZuBNOIG02BrB4iW5BA-1; Wed,
 10 Jun 2026 09:25:47 -0400
X-MC-Unique: 8167ZuBNOIG02BrB4iW5BA-1
X-Mimecast-MFC-AGG-ID: 8167ZuBNOIG02BrB4iW5BA_1781097945
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27012195F166; Wed, 10 Jun 2026 13:25:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.112])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 910A8180058C; Wed, 10 Jun 2026 13:25:39 +0000 (UTC)
Date: Wed, 10 Jun 2026 14:25:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v7 02/12] chardev: add CHR_EVENT_RESIZE
Message-ID: <aill0F5USl993rBe@redhat.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <20260609-console-resize-v7-2-0c550fdcec15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609-console-resize-v7-2-0c550fdcec15@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 09, 2026 at 09:16:12PM +0200, Filip Hejsek wrote:
> From: Szymon Lukasz <noh4hss@gmail.com>
> 
> Add a new chardev event, CHR_EVENT_RESIZE, which a backend should
> trigger if it detects the size of the connected terminal changed.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> [Filip: add note that only the focused frontend gets the event]
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
>  backends/cryptodev-vhost-user.c | 1 +
>  chardev/char.c                  | 1 +
>  hw/block/vhost-user-blk.c       | 1 +
>  hw/char/terminal3270.c          | 1 +
>  hw/char/virtio-console.c        | 1 +
>  hw/ipmi/ipmi_bmc_extern.c       | 1 +
>  hw/scsi/vhost-user-scsi.c       | 1 +
>  hw/usb/ccid-card-passthru.c     | 1 +
>  hw/usb/dev-serial.c             | 1 +
>  hw/usb/redirect.c               | 1 +
>  hw/virtio/vhost-user-base.c     | 1 +
>  hw/virtio/vhost-user-scmi.c     | 1 +
>  include/chardev/char.h          | 6 ++++++
>  monitor/hmp.c                   | 1 +
>  monitor/qmp.c                   | 1 +
>  net/passt.c                     | 1 +
>  net/vhost-user.c                | 1 +
>  17 files changed, 22 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


