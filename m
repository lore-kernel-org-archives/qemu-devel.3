Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D61CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24AK-0007Mu-5M; Fri, 26 Sep 2025 04:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v24AJ-0007Mk-2t
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v24A5-0000cg-6b
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758876626;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjKm6cjFisvotmhfB0nkvgkZD0vkkcxV7PvTdaXrEAg=;
 b=bpnGv6UHMtTPUO24AyxeFN/rPg7s7pQoIaJehtfuZQIdOmzWPjBoHvw6Km2tYaEXGAgOqV
 OesKPGg13pVCOGlwAZ1VnuxXfln0BcBfHNMEHDs7BmFTF4WRm7Dic0Lb312ROnr8/1AYTK
 oPaUlX/+OJ9zC7mYOfG0+DjCF8qdMC4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-kFd5z9s2NfGbHlsbkONUiQ-1; Fri,
 26 Sep 2025 04:50:22 -0400
X-MC-Unique: kFd5z9s2NfGbHlsbkONUiQ-1
X-Mimecast-MFC-AGG-ID: kFd5z9s2NfGbHlsbkONUiQ_1758876621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 924BB1956089; Fri, 26 Sep 2025 08:50:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.175])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6745180044F; Fri, 26 Sep 2025 08:50:18 +0000 (UTC)
Date: Fri, 26 Sep 2025 09:50:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: Re: [PATCH v4 1/9] tests/functional: Re-activate the check-venv target
Message-ID: <aNZTx0Sxfo8QJMj_@redhat.com>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-2-gustavo.romero@linaro.org>
 <5aefdfa3-4b8b-4512-a6a4-1a1684352d0f@redhat.com>
 <aNZQwnBW76LPUgeE@redhat.com>
 <1015000c-3f92-429f-84d2-bf496b5776d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1015000c-3f92-429f-84d2-bf496b5776d7@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 26, 2025 at 10:42:22AM +0200, Thomas Huth wrote:
> On 26/09/2025 10.37, Daniel P. Berrangé wrote:
> > On Fri, Sep 26, 2025 at 10:34:01AM +0200, Thomas Huth wrote:
> > > On 26/09/2025 07.15, Gustavo Romero wrote:
> > > > Add check-venv target as a dependency for the functional tests. This
> > > > causes Python modules listed in pythondeps.toml, under the testdeps
> > > > group, to be installed when 'make check-functional' is executed to
> > > > prepare and run the functional tests.
> > > > 
> > > > Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> > > > Suggested-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >    tests/Makefile.include | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > > index 3538c0c740..d012a9b25d 100644
> > > > --- a/tests/Makefile.include
> > > > +++ b/tests/Makefile.include
> > > > @@ -109,7 +109,7 @@ $(FUNCTIONAL_TARGETS):
> > > >    	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
> > > >    .PHONY: check-functional
> > > > -check-functional:
> > > > +check-functional: check-venv
> > > 
> > > I just noticed that there's still a problem: If you run "make
> > > check-functional-aarch64" immediately after configuring + compiling QEMU in
> > > a fresh folder for the first time, the functional tests fail with:
> > > 
> > > ModuleNotFoundError: No module named 'pygdbmi'
> > > 
> > > We either need to add dependencies to the check-functional-<arch> targets,
> > > too, or we have to make sure that tests still get properly skipped in the
> > > case that pygdbmi has not been installed into the venv yet.
> > 
> > We already have a decorator for skipping tests when modules are missing,
> > so we should add usage of that.
> 
> Ack ... and the "from .gdb import GDB" in qemu_test/__init__.py likely also
> has to go away, to avoid that each and every test tries to pull in the gdb
> code.

Or alternatively the gdb module can move the gdbmi import so that it is
only referenced in method scope, so it becomes relevant only when
executed.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


