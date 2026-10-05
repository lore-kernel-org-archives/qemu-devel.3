Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6858ECA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDirG-00022m-Nx; Mon, 05 Oct 2026 09:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDirE-0001yK-7F
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDir3-00068O-9V
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791207343;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edsWgcTvJSh2xQnmTdTIDoWg/t2feMO6k0rNtRTjdUU=;
 b=CugxnQ0NrWm/k36Ufdj3+iKnzwJPyttvZpkDzBT5jAXji5el+coJbkcBE/cG0NMiNgRfkl
 1nO4vSXnCIbqZGDF08zgCaj8hfWcii61jIRz7oAlAsGEuvI5eU17SUJmSzhU0jhnilON2V
 tIdxtSJaV7S9EQ8ueKmpeAvErH6sPdI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-yYWFsrshO_qvQ2caxQ9Wuw-1; Mon,
 05 Oct 2026 09:35:36 -0400
X-MC-Unique: yYWFsrshO_qvQ2caxQ9Wuw-1
X-Mimecast-MFC-AGG-ID: yYWFsrshO_qvQ2caxQ9Wuw_1791207334
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E20CD18088B8; Mon,  5 Oct 2026 13:35:33 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93F431800446; Mon,  5 Oct 2026 13:35:31 +0000 (UTC)
Date: Mon, 5 Oct 2026 14:35:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 14/28] hw/ide: mark ICH9 and ide-hd/ide-cd as secure
Message-ID: <asOnoKDrx_wwOIn2@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-15-berrange@redhat.com>
 <63427797-e8ed-4345-b8c7-469d20865165@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63427797-e8ed-4345-b8c7-469d20865165@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 05, 2026 at 03:30:09PM +0200, Philippe Mathieu-Daudé wrote:
> On 11/9/26 16:36, Daniel P. BerrangÃ© wrote:
> > These have a long history of usage in virtualization scenarios on
> > x86, for OS which lack modern virtio drivers for storage, and thus
> > must be considered secure.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   hw/ide/ich.c     | 1 +
> >   hw/ide/ide-dev.c | 3 +++
> >   hw/ide/piix.c    | 2 ++
> >   3 files changed, 6 insertions(+)
> 
> 
> > @@ -252,6 +254,7 @@ static const TypeInfo ide_device_type_info = {
> >       .parent = TYPE_DEVICE,
> >       .instance_size = sizeof(IDEDevice),
> >       .abstract = true,
> > +    .secure = true,
> 
> We shouldn't accept abstract secure device class IMO because it
> will be to easy to merge new devices that ended secure and we do
> not want to consider them. I'd go a step further and assert both
> can not be set together.

Setting 'secure' in a parent device does NOT imply that all children
have the same, only the reverse. ie, if a leaf device is secure, then
by definition all its parents must be secure.

This series only intended to mark leaf devices as secure, but a
followup series will explicitly mark the whole parent chain as
secure too, and also validate that chain in tests.

Another followup is to require non-user creatable implied devices
as secure. ie if a machine creates devices X, Y & Z, then if that
machine is secure, then X, Y & Z must be considered secure too.

Note, this would be just for those implied when "-nodefaults" is
given.

> 
> >       .class_size = sizeof(IDEDeviceClass),
> >       .class_init = ide_device_class_init,
> >       .instance_init = ide_dev_instance_init,
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


