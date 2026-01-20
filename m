Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB9BD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8S9-0000jA-7r; Tue, 20 Jan 2026 04:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi8S5-0000gj-Tq
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:55:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi8S2-0000ut-LY
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768902905;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=A+VXIJs2cOjeC2q1b62H4qNcN5GNWm8T7erUAjCZ9yw=;
 b=fdr88gVQytU3Eevpe1Bf8CvJALW53P4uvEIURuZzCffKaBEuezook0rtGSTp9pkIjX67xW
 xqIWbJ+4feufrYFCb9N6oCFiLY3VbWR1OSI7sqWjBZDcVbH3/hMAfog492oqXxHGhwA2Ct
 lKvobWaaTuomhbtJbWsjjBLQ+nNyG3g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-j-FlIFNkNRSOQrpmzakmlA-1; Tue,
 20 Jan 2026 04:55:01 -0500
X-MC-Unique: j-FlIFNkNRSOQrpmzakmlA-1
X-Mimecast-MFC-AGG-ID: j-FlIFNkNRSOQrpmzakmlA_1768902900
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EC511956095; Tue, 20 Jan 2026 09:54:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8C741800665; Tue, 20 Jan 2026 09:54:54 +0000 (UTC)
Date: Tue, 20 Jan 2026 09:54:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v6 08/12] virtio-serial-bus: add terminal resize messages
Message-ID: <aW9Q62g60J6L4yuI@redhat.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <6910accb5917c60e89801af1c3528187e732166f.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6910accb5917c60e89801af1c3528187e732166f.camel@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 20, 2026 at 10:50:04AM +0100, Filip Hejsek wrote:
> On Mon, 2026-01-19 at 04:27 +0100, Filip Hejsek wrote:
> > Implement the part of the virtio spec that allows to notify the virtio
> > driver about terminal resizes. The virtio spec contains two methods to
> > achieve that:
> > 
> > For legacy drivers, we have only one port and we put the terminal size
> > in the config space and inject the config changed interrupt.
> > 
> > For multiport devices, we use the control virtqueue to send a packet
> > containing the terminal size. Note that old versions of the Linux kernel
> > used an incorrect order for the fields (rows then cols instead of cols
> > then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.
> > 
> > As a result, when using a Linux kernel older than 6.15, the number of rows
> > and columns will be swapped.
> > 
> > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
> > but partially rewritten to fix various corner cases.
> > 
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > ---
> >  hw/char/trace-events              |  1 +
> >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++++++++++++--
> >  hw/core/machine.c                 |  4 ++-
> >  include/hw/virtio/virtio-serial.h |  5 +++
> >  4 files changed, 83 insertions(+), 3 deletions(-)
> > 
> > [...]
> > 
> > diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
> > index 60641860bf..bda6d5312a 100644
> > --- a/include/hw/virtio/virtio-serial.h
> > +++ b/include/hw/virtio/virtio-serial.h
> > @@ -145,6 +145,9 @@ struct VirtIOSerialPort {
> >      bool host_connected;
> >      /* Do apps not want to receive data? */
> >      bool throttled;
> > +
> > +    /* Terminal size reported to the guest.  Only used for consoles. */
> > +    uint16_t cols, rows;
> >  };
> 
> I found a bug: after a migration, the guest is not informed about the
> new console size. I see two ways to fix this: either add the cols and
> rows fields to the migration stream, or always send the console size to
> the guest after migration, even if it might not have changed. Which do
> you prefer? Modifying the migration stream is somewhat annoying,
> because both versions will have to be supported, and also the device
> still uses legacy save/load functions rather than VMState.

On the backend side, I'd consider migration to be equivalent to closing
and re-opening the backend character device. That should imply sending
a resize event on  migration completion. I'm surprised the chardev on
the dst isn't already triggering that when it gets connected, but perhaps
that is too early & getting lost ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


