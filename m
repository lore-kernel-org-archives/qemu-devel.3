Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C171CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXJ2S-0003nb-RG; Wed, 10 Jun 2026 09:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXJ2A-0003lJ-Pt
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXJ28-0000qj-2E
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781098310;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONd7lsQTUMTNVEIj+JZpJjUkZ7lSPDjBXfGMxFHXdPQ=;
 b=ipjiep2Pe4LOdhyba+Ik4yW/etOgmTmEgrLjIUe8+kdQPTwgTQsUqc09VSSptcvjIuRlfc
 ZI1JO2bPCrjN5V1ubYq9m9jhhVHkmX1LIiOg2gTU2WtD1W87fNKXV+QumMyJ5XliQOCx/u
 +pwpkJzrNuGt67lbAEfNbfl9aBcDQ/c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-qdMRLVnGNri0od0tSC-Ecg-1; Wed,
 10 Jun 2026 09:31:45 -0400
X-MC-Unique: qdMRLVnGNri0od0tSC-Ecg-1
X-Mimecast-MFC-AGG-ID: qdMRLVnGNri0od0tSC-Ecg_1781098301
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45072195E926; Wed, 10 Jun 2026 13:31:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AF911955BE0; Wed, 10 Jun 2026 13:31:35 +0000 (UTC)
Date: Wed, 10 Jun 2026 14:31:31 +0100
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
Subject: Re: [PATCH v7 11/12] virtio-serial-bus: add terminal resize messages
Message-ID: <ailnM0cDE6fdIouj@redhat.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <20260609-console-resize-v7-11-0c550fdcec15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609-console-resize-v7-11-0c550fdcec15@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 09, 2026 at 09:16:21PM +0200, Filip Hejsek wrote:
> Implement the part of the virtio spec that allows to notify the virtio
> driver about terminal resizes. Gate the new resize support behind the
> console-size property, which defaults to off. To implement the property,
> restore VirtIOSerial::host_features (previously removed by commit
> d0660e5b7fc7e97926232d13d2500a16df32b310).
> 
> The virtio spec contains two methods to inform the guest about console
> size:
> 
> For legacy drivers, we have only one port and we put the terminal size
> in the config space and inject the config changed interrupt.
> 
> For multiport devices, we use the control virtqueue to send a
> packet containing the terminal size. Unfortunately, old versions
> of the Linux kernel used an incorrect order for the fields (rows
> then cols instead of cols then rows), until it was fixed by commit
> 5326ab737a47278dbd16ed3ee7380b26c7056ddd. As a result, when running an
> old guest kernel, the number of rows and columns will be swapped.
> 
> Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
> but partially rewritten to fix various corner cases.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
>  hw/char/trace-events              |  1 +
>  hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-serial.h |  7 ++++
>  3 files changed, 87 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


