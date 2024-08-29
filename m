Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8344C83F07
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 11:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjdYu-0008Tq-5q; Thu, 29 Aug 2024 07:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjdYq-0008SP-Od
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 07:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjdYo-0004AR-TV
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 07:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724931809;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9p7GJgl+8TMhgrdjgdLFhM7eolrHyMcoSUUa1krlMM=;
 b=HgKXpPmnShHXC6CSkOfhJFGqMFyyPMRE8OqqbjSEOeSFaCQW0LcuHOEgxwb6Snuk5Mw9kj
 VRzRyPK25hW6Uu1vVvoEapnDpyx5I6Ht9ytFO6N4thacMybESW/xnqi3o8c2xmpriXYY1z
 iHY7MAL1+AeSejVu5iYOIcDiZ637Mi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-Xipud7NKPjeRw_LR2klvzg-1; Thu,
 29 Aug 2024 07:43:27 -0400
X-MC-Unique: Xipud7NKPjeRw_LR2klvzg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC9F61944CFD; Thu, 29 Aug 2024 11:43:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A12019560AA; Thu, 29 Aug 2024 11:43:22 +0000 (UTC)
Date: Thu, 29 Aug 2024 12:43:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 35/35] docs/devel/testing: Add documentation for
 functional tests
Message-ID: <ZtBe1kcbKxf_rnDO@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-36-thuth@redhat.com>
 <ZtBOvBh-keKVeCni@redhat.com>
 <37bd851e-4957-443c-9e7a-949ee2eaf3d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37bd851e-4957-443c-9e7a-949ee2eaf3d8@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 29, 2024 at 01:35:21PM +0200, Thomas Huth wrote:
> On 29/08/2024 12.34, Daniel P. Berrangé wrote:
> > On Wed, Aug 21, 2024 at 10:27:36AM +0200, Thomas Huth wrote:
> > > Document the new functional testing framework. The text is originally
> > > based on the Avocado documentation, but heavily modified to match the
> > > new framework.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   docs/devel/testing/functional.rst | 269 ++++++++++++++++++++++++++++++
> > >   docs/devel/testing/index.rst      |   1 +
> > >   docs/devel/testing/main.rst       |  12 ++
> > >   3 files changed, 282 insertions(+)
> > >   create mode 100644 docs/devel/testing/functional.rst
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > > +The tests should be written in the style of the Python `unittest`_
> > > +framework, using stdio for the TAP protocol. The folder
> > > +``tests/functional/qemu_test`` provides classes (e.g. the ``QemuBaseTest``
> > > +and the ``QemuSystemTest`` classes) and utility functions that help
> > > +to get your test into the right shape.
> > 
> > One gotcha when using TAP protocol is that you can't just spew
> > debug info to stdout/stderr. Each line of debug info needs to
> > be prefixed with '#' so it is interpreted as diagnostic output.
> 
> Actually, that's the great thing about pycotap (in comparison to other
> Python TAP implementations that I've seen), it helps you to get this right:
> By instantiating the TAPTestRunner like this:
> 
>     tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
>                                test_output_log = pycotap.LogMode.LogToError)
> 
> The stdio output gets redirected to stderr. And the meson test runner is
> fine by collecting the error messages from stderr and showing them to the
> user in the right way in case the test failed (and puts them into the log
> file if the test succeeded).

I'm not sure that works in all scenarios. In the patch that converts the
acpi-bits test, I had to add this chunk:

@@ -264,8 +263,12 @@ def generate_bits_iso(self):

         try:
             if os.getenv('V') or os.getenv('BITS_DEBUG'):
-                subprocess.check_call([mkrescue_script, '-o', iso_file,
-                                       bits_dir], stderr=subprocess.STDOUT)
+                proc = subprocess.run([mkrescue_script, '-o', iso_file,
+                                       bits_dir],
+                                      stdout=subprocess.PIPE,
+                                      stderr=subprocess.STDOUT,
+                                      check=True)
+                self.logger.info("grub-mkrescue output %s" % proc.stdout)
             else:
                 subprocess.check_call([mkrescue_script, '-o',
                                       iso_file, bits_dir],

because I saw errors in TAP output parsing when V=1 was set,
due to mkrescue_script printing to the STDOUT file descriptor.

IIUC, I wonder if the pycotap runner is replacing the 'stdout'
python object, but leaving the underlying OS FD 1 open on its
original channel such that it gets inherited by child processes.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


