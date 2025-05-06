Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F67BC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEvG-0005z3-SA; Tue, 06 May 2025 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCEvF-0005yT-NU
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCEvD-0006It-UR
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746524946;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=j4zQy2jjm0EQeae9P6oM+RBC8ShtZDqZM+z3RBCYOxc=;
 b=XXSh23lhSwq1sp4kkiS8nBUdx7G4g0uB9S0iOeChsapJgOlYpfw6fyf4I2Dc/KN/OWRTuK
 Q8CbyM62nTgEIJ5Wv2oheztxqPGMzFekdpiDkVz5hr4LqbUVKFi9o96Bs/caV7aDjJS0rI
 Hn5Wj1LSEvBxeKc8ae01g/VzPK3qU3g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-icjNE5uKOg6QIUrdinWgaA-1; Tue,
 06 May 2025 05:49:05 -0400
X-MC-Unique: icjNE5uKOg6QIUrdinWgaA-1
X-Mimecast-MFC-AGG-ID: icjNE5uKOg6QIUrdinWgaA_1746524944
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C6B11801A13; Tue,  6 May 2025 09:49:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54EAD30001A2; Tue,  6 May 2025 09:49:02 +0000 (UTC)
Date: Tue, 6 May 2025 10:48:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH preview 0/5] rust: allow minimum version of 1.83
Message-ID: <aBnbC4-hov9gY3MF@redhat.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <aBnOyhMawDaY9yyR@intel.com>
 <CABgObfYDOAGKdRNO91bfXQ4MPjbc0wNZSrDfpDiQZsOkrL53RQ@mail.gmail.com>
 <aBnVtNgdjQ9DlugK@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBnVtNgdjQ9DlugK@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 06, 2025 at 05:26:12PM +0800, Zhao Liu wrote:
> > > "enable Rust" supports v1.77 and "enable all devices written in Rust"
> > > supports v1.83, correct?
> > 
> > Both support v1.83 only.  However, if Rust is missing or old, "enable
> > all devices written in Rust" will fail compilation (e.g. Kconfig would
> > fail for ARM/x86 targets due to unsatisfiable CONFIG_PL011);
> 
> In this case, a brand new Rust device (without a corresponding C
> version) would be unable to compile on the above platforms which don't
> support v1.83. I'm not sure if this is an acceptable limitation or
> policy. (Has there been a similar case in history?)
> 
> > "enable Rust" will simply pick the C version of the PL011 and HPET devices.
> 
> I support this, at least the compatibility with the old QEMU won't be
> broken! Then all C devices rewritten in Rust can be covered by this
> category.

I don't really like this because it perpetuates a state where we have
parallel implementations of devices that have to be kept in sync.

If we're re-writing C devices in Rust, we need to be able to promptly
drop the C impl once the Rust impl is feature complete. Keeping 2 impls
is a general maint burden, as well as an ongoing vmstate compatibility
danger if a change in one impl is not matched by an identical change
in the other impl.

IMHO having Rust declared supported in QEMU should be aligned with being
able to drop C impls of any ported devices.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


