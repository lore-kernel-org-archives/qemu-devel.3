Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E785CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOxlu-0005IP-9X; Mon, 18 May 2026 09:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wOxlp-0005GJ-Nw
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wOxln-0008FS-6n
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779109949;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKxM/A8ChSV1rPzhAmz8E3iOA+f/0224yoh5z9PTxcU=;
 b=gZNMuCzYEEKpUPvezLg/LXB0ZPmAHgeAuHVBnbcl8tYacEZY4oVM37YeSV5xGEgjoNISou
 gfJzEWhP1OGtyBGd9o6E4uLTqffQ/j94U80TMOeEbmKbqJiLC7nlXTsaLPudcjJ5btuOJR
 zTvOkUocJAcBqi/qGTTHxcQkglSu+/g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-2ORhLiy4MWuOplem421DfA-1; Mon,
 18 May 2026 09:12:25 -0400
X-MC-Unique: 2ORhLiy4MWuOplem421DfA-1
X-Mimecast-MFC-AGG-ID: 2ORhLiy4MWuOplem421DfA_1779109944
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19A7719560A2; Mon, 18 May 2026 13:12:24 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E78E30001A2; Mon, 18 May 2026 13:12:19 +0000 (UTC)
Date: Mon, 18 May 2026 14:12:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 12/16] tests: validate dmsetup result in test 128
Message-ID: <agsQMCV5u2oba8mX@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
 <20260513120003.226790-13-berrange@redhat.com>
 <agc0tMv-GCVIyeQY@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agc0tMv-GCVIyeQY@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 15, 2026 at 04:59:00PM +0200, Kevin Wolf wrote:
> Am 13.05.2026 um 13:59 hat Daniel P. Berrangé geschrieben:
> > The I/O test 128 uses 'dmsetup create' to create a device, optionally
> > using sudo to elevate privileges.
> > 
> > This dmsetup command works in GitLab CI, however, the test then fails
> > with a missing device name:
> > 
> >   1..1
> >   # running raw 128
> >   not ok raw 128
> >   ----------------------------------- stderr -----------------------------------
> >   --- /builds/berrange/qemu/tests/qemu-iotests/128.out
> >   +++ /builds/berrange/qemu/build/scratch/raw-file-128/128.out.bad
> >   @@ -1,5 +1,5 @@
> >    QA output created by 128
> > 
> >    == reading from error device ==
> >   -read failed: Input/output error
> >   +qemu-io: can't open device /dev/mapper/eiodev16546: Could not open '/dev/mapper/eiodev16546': No such file or directory
> >    *** done
> > 
> >   (test program exited with status code 1)
> > 
> > It is believed that this is due to the build env using a manually
> > populated /dev, such that the device mapper node won't ever appear.
> > It is not a race, since a test adding a sleep did not result in the
> > device appearing.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> I wonder how much this test gets run at all then. Tests requiring
> passwordless sudo probably aren't something that most people run
> locally, and my idea with them was mostly that at least CI will run
> them.
>
> So while I don't disagree with your fix, I wonder if the test couldn't
> be rewritten to work without dmsetup. Maybe the FUSE export could help?

I'll file an issue so this idea doesn't get lost

> 
> Anyway, for now:
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


