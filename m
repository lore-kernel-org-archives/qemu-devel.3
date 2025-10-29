Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEA2CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1JC-0008Ls-Uo; Wed, 29 Oct 2025 04:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vE1J8-0008La-Kj
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vE1Iu-0004r2-EZ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761725588;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5a8Kq+IOmMJRrwM8iNvSbLy58xA4clpP8sMfwpHD0SE=;
 b=P6+ROFI86mCI1KYjl0KBNR7H8CCv/M776XEX8vYzF44TdvVHEiWQJuwIKy6AmFRwzGc0fh
 BzUr1xXWWtUc9HvleI+d78sqlRhmDFfD284Ep1SUwT7FbXJhljCB1vavp0DppeIuk2Y6xH
 +Rut6fjNcy5EbEoNjUly2w/Aot1y/r8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-zL-f8zpyPxGYi8NnSshH0Q-1; Wed,
 29 Oct 2025 04:13:04 -0400
X-MC-Unique: zL-f8zpyPxGYi8NnSshH0Q-1
X-Mimecast-MFC-AGG-ID: zL-f8zpyPxGYi8NnSshH0Q_1761725583
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A5B3180121E; Wed, 29 Oct 2025 08:13:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AFCF180035A; Wed, 29 Oct 2025 08:13:00 +0000 (UTC)
Date: Wed, 29 Oct 2025 08:12:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/2] tests/functional: include the lower level QMP log
 messages
Message-ID: <aQHMNLgcazOGGR45@redhat.com>
References: <20251028182651.873256-1-berrange@redhat.com>
 <20251028182651.873256-3-berrange@redhat.com>
 <c87f0929-a38c-425d-bfb6-d2985b908124@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c87f0929-a38c-425d-bfb6-d2985b908124@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 29, 2025 at 08:12:31AM +0100, Thomas Huth wrote:
> On 28/10/2025 19.26, Daniel P. Berrangé wrote:
> > We've seen a GitLab CI timeout failure in the test_pseries.py test,
> > where it appears likely that the test has hung in a self.qmp('quit')
> > call, but we don't have conclusive proof. Adding the QMP log category
> > to what we capture should help us diagnose this, at the cost of the
> > base.log file becoming significantly more verbose. The previous
> > commit to include the logger category name and function should at
> > least help understanding the more verbose logs.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/testcase.py | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> > index 6fc6e1ac0a..5ab84ce674 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -225,6 +225,9 @@ def setUp(self):
> >           self.machinelog = logging.getLogger('qemu.machine')
> >           self.machinelog.setLevel(logging.DEBUG)
> >           self.machinelog.addHandler(self._log_fh)
> > +        self.qmplog = logging.getLogger('qemu.qmp')
> > +        self.qmplog.setLevel(logging.DEBUG)
> > +        self.qmplog.addHandler(self._log_fh)
> >           if not self.assets_available():
> >               self.skipTest('One or more assets is not available')
> > @@ -235,6 +238,7 @@ def tearDown(self):
> >           if self.socketdir is not None:
> >               shutil.rmtree(self.socketdir.name)
> >               self.socketdir = None
> > +        self.qmplog.removeHandler(self._log_fh)
> >           self.machinelog.removeHandler(self._log_fh)
> >           self.log.removeHandler(self._log_fh)
> >           self._log_fh.close()
> 
>  Hi,
> 
> I tested this patch, and now I'm seeing Python stack traces in the base.log,
> like this:
> 
> 2025-10-29 07:22:45,264 - DEBUG: qemu.qmp.protocol.default._bh_loop_forever
> Task.Reader: failure:
>   | Traceback (most recent call last):
>   |   File "../python/qemu/qmp/protocol.py", line 914, in _bh_loop_forever
>   |     await async_fn()
>   |   File "../python/qemu/qmp/protocol.py", line 952, in _bh_recv_message
>   |     msg = await self._recv()
>   |           ^^^^^^^^^^^^^^^^^^
>   |   File "../python/qemu/qmp/protocol.py", line 1053, in _recv
>   |     message = await self._do_recv()
>   |               ^^^^^^^^^^^^^^^^^^^^^
>   |   File "../python/qemu/qmp/qmp_client.py", line 459, in _do_recv
>   |     msg_bytes = await self._readline()
>   |                 ^^^^^^^^^^^^^^^^^^^^^^
>   |   File "../python/qemu/qmp/protocol.py", line 1021, in _readline
>   |     raise EOFError
>   | EOFError
> 
> If if it's harmless, I think that's very confusing for the casual user when
> trying to debug a problem. Can we avoid these?

That comes from this code in qemu/qmp/protocol.py

        except BaseException as err:
            self.logger.log(
                logging.INFO if isinstance(err, EOFError) else logging.ERROR,
                "Task.%s: %s",
                name, exception_summary(err)
            )
            self.logger.debug("Task.%s: failure:\n%s\n",
                              name, pretty_traceback())
            self._schedule_disconnect()
            raise

Given EOF is a "normal" thing, I'm not convinced it justifies printing
a traceback.  I'd be inclined to suggest a new "except EOFError" clause
that catches that normal exception and thus skips the traceback.

I don't think we need to block this patch waiting for that improvement
though. When collecting DEBUG logs there are always going to be weird
things like this present, and anything misleading just needs to be
fixed when we uncover it.

> Or maybe rather log the qmp stuff into a separate file, e.g. qmp.log ?

I really don't want separate files for different log categories, as then
you have created a problem of merging the two files in order to interpret
the flow. That doesn't doesn't scale as we capture yet more log categories.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


