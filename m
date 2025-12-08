Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B085BD3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXOQ-0003sZ-VD; Mon, 08 Dec 2025 04:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vSXOO-0003mE-Tu
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:18:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vSXON-0001Zm-5e
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765185530;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pWrVWxMfSqJleTJDYMwU/Gf3ZV+HDuLQ2JSWAR7AO4=;
 b=WvwuB4RF0jIaNs/zpmJQW65jSGonXL4fVAkBjrgJxKXRXsJql73MgW9vWsXn41KtMhB8qX
 j/GLVlQ6qn1KLGnfPK7hReqsw2UMTtJLooyIw9Hd5MY3noQiPrsDiM7DJC0iwM985ONOxl
 3Wb0M74yaW9nE6Uei+p5QzxVHk1Eyqg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-biMblahGMdW1esIZJefHSA-1; Mon,
 08 Dec 2025 04:18:46 -0500
X-MC-Unique: biMblahGMdW1esIZJefHSA-1
X-Mimecast-MFC-AGG-ID: biMblahGMdW1esIZJefHSA_1765185525
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70FCF1801213; Mon,  8 Dec 2025 09:18:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BBE519560B0; Mon,  8 Dec 2025 09:18:43 +0000 (UTC)
Date: Mon, 8 Dec 2025 09:18:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qemu-iotests: Check for a functional "secret"
 object before using it
Message-ID: <aTaX7_xJyHCnjHlg@redhat.com>
References: <20251205130014.693799-1-thuth@redhat.com>
 <aTMUQXOjJO0EiK8b@redhat.com>
 <6333f8d4-3feb-43c7-8d11-98a7c3cbe0c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6333f8d4-3feb-43c7-8d11-98a7c3cbe0c4@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Mon, Dec 08, 2025 at 09:15:38AM +0100, Thomas Huth wrote:
> On 05/12/2025 18.20, Kevin Wolf wrote:
> > Am 05.12.2025 um 14:00 hat Thomas Huth geschrieben:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > QEMU iotests 049, 134 and 158 are currently failing if you compiled
> > > QEMU without the crypto libraries. Thus make sure that the "secret"
> > > object is really usable and skip the tests otherwise.
> > > 
> > > Reported-by: Alex Bennée <alex.bennee@linaro.org>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > > diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> > > index e977cb4eb61..10d83d8361b 100644
> > > --- a/tests/qemu-iotests/common.rc
> > > +++ b/tests/qemu-iotests/common.rc
> > > @@ -1053,6 +1053,20 @@ _require_one_device_of()
> > >       _notrun "$* not available"
> > >   }
> > > +_require_secret()
> > > +{
> > > +    if [ -e "$TEST_IMG" ]; then
> > > +        echo "unwilling to overwrite existing file"
> > > +        exit 1
> > > +    fi
> > > +    if $QEMU_IMG create -f $IMGFMT --object secret,id=sec0,data=123 \
> > > +                 -o encryption=on,encrypt.key-secret=sec0 "$TEST_IMG" 1M 2>&1 \
> > > +                 | grep "Unsupported cipher" ; then
> > > +        _notrun "missing cipher support"
> > > +    fi
> > 
> > What is the thing that you're checking here? If it's really the secret,
> > then just running 'qemu-io --object secret,data=123,id=sec0 -c ""' would
> > be enough. If it's not the secret, but encryption support, then the
> > function is a misnomer.
> 
> The "qemu-io" statement seems to work fine in that case, so you're right,
> it's apparently not the "secret" object, but rather the "encryption" part
> that is failing.
> 
> So shall I rename it to "_require_encryption" ?
>
> > _require_working_luks() looks pretty similar, though it requires
> > specifically a working luks driver. Could something be unified? (The
> > answer might be no, but it would be good to explicitly say it.)
> 
> While it looks a little bit similar, at least for me it still looks too
> distinct for unification - or is "-o key-secret=sec0" doing exactly the same
> as "-o encryption=on,encrypt.key-secret=sec0" ? ... I lack the deeper
> understanding of the parameters here to judge on that topic.

Specifically these three tests are all relying on QCow2 traditional
built-in AES encryption which pre-dated LUKS. Just name it for what
it tests:

  _require_qcow2_aes

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


