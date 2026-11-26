Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44888606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBTjh/+B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWe77-0008Nk-Ag; Thu, 26 Nov 2026 13:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWe6c-0008KW-Qc
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:22:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWe6Y-00064K-Kw
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795717317;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSWV/bzhnjRAB60EzAlN62fcjxewo9AF+++oBpPFvqk=;
 b=HBTjh/+BKSbuhtGyqHKGbd40OHy0Nik++TIFn4zlenaE9vFa+Z4VkrRM+dp1LxnClkloGL
 eaJWq50uX0rGRb3KF68OitBDM7K77aTf657Ss5NHB0A/dDSWtgRiqTXAj1CmgH+2lssFrx
 cpaRP+YcQCZzhHWJdcVvsJhBbHf+znI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-5hg8zDycMMu3JLF0Sa3Eww-1; Thu,
 26 Nov 2026 18:21:54 +0000
X-MC-Unique: 5hg8zDycMMu3JLF0Sa3Eww-1
X-Mimecast-MFC-AGG-ID: 5hg8zDycMMu3JLF0Sa3Eww_1795717313
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 508B91955F03; Thu, 26 Nov 2026 18:21:53 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F1DC180197D; Thu, 26 Nov 2026 18:21:51 +0000 (UTC)
Date: Thu, 26 Nov 2026 18:21:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 05/10] iotests: skip preallocation tests if not
 supported
Message-ID: <awh4vHGVgfu-PidZ@redhat.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
 <20261125191701.93931-6-bogorodskiy@gmail.com>
 <awgBfVWItT68xQEW@redhat.com> <awh3gvqh561nkTQ1@tulp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awh3gvqh561nkTQ1@tulp>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 07:16:36PM +0100, Roman Bogorodskiy wrote:
>   Daniel P. Berrangé wrote:
> 
> > On Wed, Nov 25, 2026 at 08:16:55PM +0100, Roman Bogorodskiy wrote:
> > > Skip preallocation tests requiring efficient zero writes if
> > > not supported. Support is detected by probing
> > > "qemu-io write -z -n".
> > > 
> > > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > > ---
> > >  tests/qemu-iotests/298 | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
> > > index f2b94077f4..869bdb3242 100755
> > > --- a/tests/qemu-iotests/298
> > > +++ b/tests/qemu-iotests/298
> > > @@ -18,6 +18,7 @@
> > >  # along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > >  #
> > >  
> > > +import errno
> > >  import os
> > >  import iotests
> > >  
> > > @@ -32,6 +33,15 @@ drive_opts = f'node-name=disk,driver={iotests.imgfmt},' \
> > >  
> > >  class TestPreallocateBase(iotests.QMPTestCase):
> > >      def setUp(self):
> > > +        with iotests.FilePath('zero-probe.raw') as probe_path:
> > > +            iotests.qemu_img_create('-f', 'raw', probe_path, '1M')
> > > +            ret = iotests.qemu_io('-f', 'raw', '-c', 'write -z -n -q 0 1M',
> > > +                                  probe_path, check=False)
> > > +            if ret.returncode != 0:
> > > +                if os.strerror(errno.ENOTSUP) in ret.stdout:
> > > +                    self.case_skip("File backend does not support "
> > > +                                   "efficient zero writes")
> > > +            self.assertEqual(ret.returncode, 0, ret.stdout)
> > 
> > I guess this works, but any idea what the actul underlying missing
> > feature is ?  Is it something we can check directly instead of
> > matching on stderr strings ? 
> 
> The actual missing feature is a working handle_aiocb_write_zeroes().
> Thus, one of:
> 
>   CONFIG_FALLOCATE
>   CONFIG_FALLOCATE_ZERO_RANGE
>   CONFIG_FALLOCATE_PUNCH_HOLE
> 
> and filesystem support.

Ok, that's a bit too complex to check directly here, so

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> > >          iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(10 * MiB))
> > >  
> > >      def tearDown(self):
> > > -- 
> > > 2.56.0
> > > 
> > > 
> > > 
> > 
> > With regards,
> > Daniel
> > -- 
> > |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> > |: https://libvirt.org          ~~          https://entangle-photo.org :|
> > |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> > 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


