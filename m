Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C10C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 10:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUOUa-0004R7-5D; Thu, 18 Jul 2024 06:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUOUW-00045L-4E
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUOUS-0005Ih-1W
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721298958;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9T5obncNKnugeO8Z4UQU0/NqybKuOciUdnz6mClwFeo=;
 b=BSY7avzg3R17ryNtr5JCQC0YO2YgS8jQYtx+RYII3hZgNHCoQilv4TV+ukenF8UyELjzBC
 XV4x8b56427b2/WsmnVKDs3T3YuDLsQ9A6691IFxauG54LKNVgjFEnysG7i97+gZKtdJKp
 BlxRhLUX7VfP1glLPx/58/2RGD6yPWg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-cKDS10ZaMIKwBe6BAk33GQ-1; Thu,
 18 Jul 2024 06:35:54 -0400
X-MC-Unique: cKDS10ZaMIKwBe6BAk33GQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6EB919560B1; Thu, 18 Jul 2024 10:35:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBA6019560AA; Thu, 18 Jul 2024 10:35:49 +0000 (UTC)
Date: Thu, 18 Jul 2024 11:35:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/2] ci: add gtk-vnc to the deps
Message-ID: <ZpjwAoqPF73tBRh5@redhat.com>
References: <20240718094159.902024-1-berrange@redhat.com>
 <20240718094159.902024-2-berrange@redhat.com>
 <c1c108af-9f7c-4bb1-bfd4-df3586534e3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1c108af-9f7c-4bb1-bfd4-df3586534e3c@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jul 18, 2024 at 12:34:13PM +0200, Thomas Huth wrote:
> On 18/07/2024 11.41, Daniel P. Berrangé wrote:
> > The gtk-vnc package is used by the vnc-display-test qtest
> > program. Technically only gvnc is needed, but since we
> > already pull in the gtk3 dep, it is harmless to depend
> > on gtk-vnc.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/lcitool/projects/qemu.yml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
> > index 0c85784259..252e871f80 100644
> > --- a/tests/lcitool/projects/qemu.yml
> > +++ b/tests/lcitool/projects/qemu.yml
> > @@ -32,6 +32,7 @@ packages:
> >    - glusterfs
> >    - gnutls
> >    - gtk3
> > + - gtk-vnc
> >    - hostname
> >    - json-c
> >    - libaio
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> IIRC Alex has a patch in his queue already to refresh the docker images,
> maybe he could include this change there, too...?

Yep, I included patch 2 just for completeness, assuming Alex would
just pick patch 1, and then re-generate.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


