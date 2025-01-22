Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326B3C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 17:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taeYw-0001qX-JJ; Wed, 22 Jan 2025 12:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1taeYu-0001p1-EW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:30:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1taeYr-0004G8-VQ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737567039;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NX+HOJh1PRf+A69qAh06HIHe68iq6l+1RcyLVLKYfXk=;
 b=IJlm/dp6ItWgjQrCfCCz4im4DmSznpUPCzl1ULSlzLZ8QSE4MA85kZ0+mm6yWpdJinYPCn
 Ya/kEkLRI+8JBZT1aREN8wSx244eZFqokNLMAdTXQqzvYV5WsiHcOdnezmNKlVYCjjKXua
 M2yk+nBnR8OrQR0kzXtMiH9MbJFUcjY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-GrtO3XiUNZGpEclz_wZ69Q-1; Wed,
 22 Jan 2025 12:30:34 -0500
X-MC-Unique: GrtO3XiUNZGpEclz_wZ69Q-1
X-Mimecast-MFC-AGG-ID: GrtO3XiUNZGpEclz_wZ69Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D12A619560BD
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 17:30:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEBA03003E7F; Wed, 22 Jan 2025 17:30:31 +0000 (UTC)
Date: Wed, 22 Jan 2025 17:30:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <Z5ErNNWhIC4HkidT@redhat.com>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
 <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
 <28e3e395-0eaa-4eeb-bd61-1cb031d8da7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28e3e395-0eaa-4eeb-bd61-1cb031d8da7f@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Wed, Jan 22, 2025 at 06:22:06PM +0100, Laurent Vivier wrote:
> On 22/01/2025 17:51, Stefano Garzarella wrote:
> > On Wed, Jan 22, 2025 at 05:41:15PM +0100, Laurent Vivier wrote:
> > > On 22/01/2025 17:20, Stefano Garzarella wrote:
> > > > On Wed, Jan 22, 2025 at 08:59:22AM -0500, Michael S. Tsirkin wrote:
> > > > > On Wed, Jan 22, 2025 at 02:42:14PM +0100, Stefano Garzarella wrote:
> > > > > > On Tue, Jan 21, 2025 at 11:00:29AM +0100, Laurent Vivier wrote:
> > > > > > > In vhost_user_receive() if vhost_net_notify_migration_done() reports
> > > > > > > an error we display on the console:
> > > > > > > 
> > > > > > >   Vhost user backend fails to broadcast fake RARP
> > > > > > > 
> > > > > > > This message can be useful if there is a problem to execute
> > > > > > > VHOST_USER_SEND_RARP but it is useless if the backend doesn't
> > > > > > > support VHOST_USER_PROTOCOL_F_RARP.
> > > > > > > 
> > > > > > > Don't report the error if vhost_net_notify_migration_done()
> > > > > > > returns -ENOTSUP (from vhost_user_migration_done())
> > > > > > > 
> > > > > > > Update vhost_net-stub.c to return -ENOTSUP too.
> > > > > > > 
> > > > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > > > > > ---
> > > > > > > hw/net/vhost_net-stub.c | 2 +-
> > > > > > > net/vhost-user.c        | 2 +-
> > > > > > > 2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> > > > > > > index 72df6d757e4d..875cd6c2b9c8 100644
> > > > > > > --- a/hw/net/vhost_net-stub.c
> > > > > > > +++ b/hw/net/vhost_net-stub.c
> > > > > > > @@ -93,7 +93,7 @@ void
> > > > > > > vhost_net_config_mask(VHostNetState
> > > > > > *net, VirtIODevice *dev, bool mask)
> > > > > > > 
> > > > > > > int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
> > > > > > > {
> > > > > > > -    return -1;
> > > > > > > +    return -ENOTSUP;
> > > > > > > }
> > > > > > > 
> > > > > > > VHostNetState *get_vhost_net(NetClientState *nc)
> > > > > > > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > > > > > > index 12555518e838..636fff8a84a2 100644
> > > > > > > --- a/net/vhost-user.c
> > > > > > > +++ b/net/vhost-user.c
> > > > > > > @@ -146,7 +146,7 @@ static ssize_t
> > > > > > vhost_user_receive(NetClientState *nc, const uint8_t *buf,
> > > > > > > 
> > > > > > >          r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
> > > > > > > 
> > > > > > > -        if ((r != 0) && (display_rarp_failure)) {
> > > > > > > +        if ((r != 0) && (r != -ENOTSUP) && (display_rarp_failure)) {
> > > > > > >              fprintf(stderr,
> > > > > > >                      "Vhost user backend fails to broadcast fake RARP\n");
> > > > > > >              fflush(stderr);
> > > > > > > -- 
> > > > > > > 2.47.1
> > > > > > > 
> > > > > > 
> > > > > > IIUC the message was there since the introduction about 10 years ago
> > > > > > from commit 3e866365e1 ("vhost user: add rarp sending after live
> > > > > > migration for legacy guest"). IIUC -ENOTSUP is returned when both F_RARP
> > > > > > and F_GUEST_ANNOUNCE are not negotiated.
> > > > > > 
> > > > > > That said, I honestly don't know what F_RARP or F_GUEST_ANNOUNCE is for,
> > > > > 
> > > > > rarp is to have destination host broadcast a message with VM address
> > > > > to update the network. Guest announce is when it will instead
> > > > > ask the guest to do this.
> > > > 
> > > > Okay, thanks for explaining to me.
> > > > So if both features are not negotiated, no one is going to broadcast
> > > > the message, right?
> > > > 
> > > > Could that be a valid reason to print an error message in QEMU?
> > > > 
> > > > To me it might be reasonable because the user might experience some
> > > > network problems, but I'm not a network guy :-)
> > > 
> > > I'm working on adding vhost-user to passt[1], and in this case we
> > > don't need to broadcast any message.
> > 
> > Okay, so please can you add that to the commit description and also
> > explaining why you don't need that?
> > 
> > > 
> > > So I don't implement VHOST_USER_SEND_RARP and I don't want the error
> > > message to spoil my console.
> > 
> > Fair enough, but at that point, if it's valid to have both feature not
> > negotiated, IMHO is better to return 0 in vhost_user_migration_done().
> > Maybe adding also a comment to explain that in your scenario you don't
> > need to do nothing (like if guest supports GUEST_ANNOUNCE).
> 
> I agree.
> 
> > 
> > > 
> > > -ENOTSUP is an error message for developer not for user.
> > 
> > I was referring to the "Vhost user backend fails to broadcast fake RARP"
> > error message we are skipping here.
> 
> So in the end my real question at this point is:
> 
> is it better to suppress the error message in QEMU (1) or implement an empty
> VHOST_USER_SEND_RARP in Passt (2)?

If it is valid to interpret "VHOST_USER_SEND_RARP" to mean the service
is "capable of sending a RARP where appropriate" rather than "will always
unconditionally send an RARP", then it would be reasonable for Passt to
have an empty VHOST_USER_SEND_RARP impl.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


