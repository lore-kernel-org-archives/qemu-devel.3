Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2A2CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6bh-0003v8-8k; Mon, 15 Sep 2025 06:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uy6be-0003uo-CU
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uy6bX-0001Zr-Th
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757932714;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWVoBeq6JLRiW2zG8qJnca9frOGFntt9EEtk7QvB2sQ=;
 b=RSx7uLoF/wYklzgLwjR1Aw2sbiM9oAwhCaMblHWC8GM2Iixn8j8EoksZST/jIl+oBvpKm8
 KZmw0Y/vNSbP3WTYakEZQeEcaThvnSmQMekeb6E1jIH73g0h3/eEjxFNJZhjzy97sgp6/R
 lI3KoaaAWVJKxKFsHHdJJaz4Lfmy83Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-HdnXtgJBMTOdN2GuJA7omg-1; Mon,
 15 Sep 2025 06:38:33 -0400
X-MC-Unique: HdnXtgJBMTOdN2GuJA7omg-1
X-Mimecast-MFC-AGG-ID: HdnXtgJBMTOdN2GuJA7omg_1757932712
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 852C219560AD; Mon, 15 Sep 2025 10:38:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D994B300021A; Mon, 15 Sep 2025 10:38:30 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:38:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/6] tests/functional: drop datadrainer class in reverse
 debugging
Message-ID: <aMfso1ksrXgznBvi@redhat.com>
References: <20250912182200.643909-1-berrange@redhat.com>
 <20250912182200.643909-5-berrange@redhat.com>
 <878qigrpcu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qigrpcu.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 11:18:09AM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The reverse debugging test uses the avocado datadrainer class to
> > create a background thread that reads from the console socket and
> > dumps it via python logger.
> >
> > Most tests log console output as a side effect of doing calls
> > to match strings, but this test never tries to match anything.
> >
> > This isn't critical, so just drop the functionality.
> 
> We do end up with zero length logs for all console output although I don't know
> if we got that far before:

AFAICT, the logs were also zero-length with the current code.
When I ran it with the datadrainer code, there didn't seem
to be any output to be drained.  I'm unclear if that's expected
or a sign I did something wrong, or something has broken since
the test was first written ?


> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  tests/functional/reverse_debugging.py | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
> > index 1b880cda8f..9c89f5c897 100644
> > --- a/tests/functional/reverse_debugging.py
> > +++ b/tests/functional/reverse_debugging.py
> > @@ -35,8 +35,6 @@ class ReverseDebugging(LinuxKernelTest):
> >      endian_is_le = True
> >  
> >      def run_vm(self, record, shift, args, replay_path, image_path, port):
> > -        from avocado.utils import datadrainer
> > -
> >          logger = logging.getLogger('replay')
> >          vm = self.get_vm(name='record' if record else 'replay')
> >          vm.set_console()
> > @@ -54,10 +52,6 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
> >          if args:
> >              vm.add_args(*args)
> >          vm.launch()
> > -        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
> > -                                    logger=self.log.getChild('console'),
> > -                                    stop_check=(lambda : not vm.is_running()))
> > -        console_drainer.start()
> >          return vm
> >  
> >      @staticmethod
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


