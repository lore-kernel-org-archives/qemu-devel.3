Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E807CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Afk-0003s9-UN; Fri, 26 Sep 2025 11:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2Afj-0003qn-2j
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2AfZ-00021x-JU
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758901652;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qiHLTf8dwa8Z+P8OqoltK6Cz27E+fC5mVYzQ03uT9LQ=;
 b=aaU3FNenlGrd9sE+dnedrpVRlgHX2baygk1ZS5UdXhxmx0Al07rnTCvW3kRIldr7zu9Ndk
 iMIXiv8cF/33zc1GvSEsR9DWWXSMIDtmxLekDpWa+gFQKVMVHDMo9I2E/1HL0q/twmJsgZ
 hXMlLmhrB2dHJoBMjVDF+dIh2sUIh8U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-4zJmuA3GNKOIC3SV9CmGeQ-1; Fri,
 26 Sep 2025 11:47:29 -0400
X-MC-Unique: 4zJmuA3GNKOIC3SV9CmGeQ-1
X-Mimecast-MFC-AGG-ID: 4zJmuA3GNKOIC3SV9CmGeQ_1758901648
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC7DB19560B8; Fri, 26 Sep 2025 15:47:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 040AA19560A2; Fri, 26 Sep 2025 15:47:24 +0000 (UTC)
Date: Fri, 26 Sep 2025 16:47:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: Re: [PATCH v4 1/9] tests/functional: Re-activate the check-venv target
Message-ID: <aNa1iV7XZ-BSeX88@redhat.com>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-2-gustavo.romero@linaro.org>
 <5aefdfa3-4b8b-4512-a6a4-1a1684352d0f@redhat.com>
 <aNZQwnBW76LPUgeE@redhat.com>
 <1015000c-3f92-429f-84d2-bf496b5776d7@redhat.com>
 <aNZTx0Sxfo8QJMj_@redhat.com>
 <80c73d95-e8c0-4cb7-bf11-1c1e2f749c00@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80c73d95-e8c0-4cb7-bf11-1c1e2f749c00@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 26, 2025 at 12:44:58PM -0300, Gustavo Romero wrote:
> Hi Daniel,
> 
> On 9/26/25 05:50, Daniel P. Berrangé wrote:
> > On Fri, Sep 26, 2025 at 10:42:22AM +0200, Thomas Huth wrote:
> > > On 26/09/2025 10.37, Daniel P. Berrangé wrote:
> > > > On Fri, Sep 26, 2025 at 10:34:01AM +0200, Thomas Huth wrote:
> > > > > On 26/09/2025 07.15, Gustavo Romero wrote:
> > > > > > Add check-venv target as a dependency for the functional tests. This
> > > > > > causes Python modules listed in pythondeps.toml, under the testdeps
> > > > > > group, to be installed when 'make check-functional' is executed to
> > > > > > prepare and run the functional tests.
> > > > > > 
> > > > > > Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> > > > > > Suggested-by: Thomas Huth <thuth@redhat.com>
> > > > > > ---
> > > > > >     tests/Makefile.include | 2 +-
> > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > > > > index 3538c0c740..d012a9b25d 100644
> > > > > > --- a/tests/Makefile.include
> > > > > > +++ b/tests/Makefile.include
> > > > > > @@ -109,7 +109,7 @@ $(FUNCTIONAL_TARGETS):
> > > > > >     	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
> > > > > >     .PHONY: check-functional
> > > > > > -check-functional:
> > > > > > +check-functional: check-venv
> > > > > 
> > > > > I just noticed that there's still a problem: If you run "make
> > > > > check-functional-aarch64" immediately after configuring + compiling QEMU in
> > > > > a fresh folder for the first time, the functional tests fail with:
> > > > > 
> > > > > ModuleNotFoundError: No module named 'pygdbmi'
> > > > > 
> > > > > We either need to add dependencies to the check-functional-<arch> targets,
> > > > > too, or we have to make sure that tests still get properly skipped in the
> > > > > case that pygdbmi has not been installed into the venv yet.
> > > > 
> > > > We already have a decorator for skipping tests when modules are missing,
> > > > so we should add usage of that.
> > > 
> > > Ack ... and the "from .gdb import GDB" in qemu_test/__init__.py likely also
> > > has to go away, to avoid that each and every test tries to pull in the gdb
> > > code.
> > 
> > Or alternatively the gdb module can move the gdbmi import so that it is
> > only referenced in method scope, so it becomes relevant only when
> > executed.
> 
> I can´t follow what you meant here. Do mind expanding on it a bit?

The code currently does:

  from pygdbmi.gdbcontroller import GdbController

  class GDB:
      def __init__(self, gdb_path, echo=True, suffix='# ', prompt="$ "):
          gdb_cmd = [gdb_path, "-q", "--interpreter=mi2"]
          self.gdbmi = GdbController(gdb_cmd)
          self.echo = echo

but it could instead do

  class GDB:
      def __init__(self, gdb_path, echo=True, suffix='# ', prompt="$ "):
          gdb_cmd = [gdb_path, "-q", "--interpreter=mi2"]
          from pygdbmi.gdbcontroller import GdbController
          self.gdbmi = GdbController(gdb_cmd)
          self.echo = echo


so pygdbmi is only required if the GDB classs is instantiated
by a test, not when 'gdb.py' is imported

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


