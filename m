Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BACDC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 13:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thqmD-0007rG-RC; Tue, 11 Feb 2025 08:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1thqm9-0007qm-GD
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1thqm6-0004v8-Cv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739282285;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIni7Y4X6MVcwOnXuoGdcC0X3q3M4AIzz3OcIV2xqmo=;
 b=gpzwEkiCLj6bSnVzyb2QqQMtr7lLh2oV3u6vCg8+Hw0bKPem3NcQ/p6MMPwccx2HkqsSPV
 qzRyLBo4lirzZYNagFiUTcPLHffP/ru4a8x112Lb+05hw/jjDCYWu8xj/CoHiPqxV5TasM
 wtGK4Xj2vXosOKZzA31RSc7LGQvbX9o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-wZe0FEkEM7OQxn7dDG0soQ-1; Tue,
 11 Feb 2025 08:58:02 -0500
X-MC-Unique: wZe0FEkEM7OQxn7dDG0soQ-1
X-Mimecast-MFC-AGG-ID: wZe0FEkEM7OQxn7dDG0soQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 384241801A18; Tue, 11 Feb 2025 13:58:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A315D30001AB; Tue, 11 Feb 2025 13:57:58 +0000 (UTC)
Date: Tue, 11 Feb 2025 13:57:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] gitlab-ci.d/cirrus: Update the FreeBSD job to v14.2
Message-ID: <Z6tXY2nSrmQZSrtB@redhat.com>
References: <20250211120817.35050-1-thuth@redhat.com>
 <Z6s-0LxACyF5KWOc@redhat.com>
 <a314109f-3238-4605-8fba-beaf310cd565@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a314109f-3238-4605-8fba-beaf310cd565@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Tue, Feb 11, 2025 at 01:36:35PM +0100, Philippe Mathieu-Daudé wrote:
> On 11/2/25 13:13, Daniel P. Berrangé wrote:
> > On Tue, Feb 11, 2025 at 01:08:17PM +0100, Thomas Huth wrote:
> > > The FreeBSD job started to fail since the 14-1 image disappeared
> > > from the cloud. Update the job to v14.2 to fix it.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   .gitlab-ci.d/cirrus.yml | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> > > index 16411f3d2b..75b611418e 100644
> > > --- a/.gitlab-ci.d/cirrus.yml
> > > +++ b/.gitlab-ci.d/cirrus.yml
> > > @@ -37,7 +37,7 @@ x64-freebsd-14-build:
> > >       NAME: freebsd-14
> > >       CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
> > >       CIRRUS_VM_IMAGE_SELECTOR: image_family
> > > -    CIRRUS_VM_IMAGE_NAME: freebsd-14-1
> > > +    CIRRUS_VM_IMAGE_NAME: freebsd-14-2
> > >       CIRRUS_VM_CPUS: 8
> > >       CIRRUS_VM_RAM: 8G
> > >       UPDATE_COMMAND: pkg update; pkg upgrade -y
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > This needs to be merged to master immediately, and also into stable
> > branches. Any old reference to 14-1 is a guaranteed failed job since
> > FreeBSD deleted old images off Google Cloud
> 
> https://cirrus-ci.org/guide/FreeBSD/ still only lists 14-1...

FreeBSD project only deleted the images some time in the last 8
hours, so Cirrus CI hasn't had time to update their web pages.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


