Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAD8CCA471
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WoU-0004uC-1t; Tue, 30 Sep 2025 05:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3WoK-0004pr-U3
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3WoD-0001xv-5j
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759225085;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FNIGH+aeK2x8pcmjHpypzzIQrc/GSxU9dwFck2oJcrQ=;
 b=acZXwNzUvMGz6pjJ4x6o9znTywQ9nYeaNFSG2QKCZQoV7+RuDpKtJa+y80uwTC4ZGzs5GD
 tHSVJ/HXNpDed8zap0bpnzeo3LJYl/KpwQ9mqe+Z0d32OOnGA9oD2qVKeJtoItYiMlJ4wS
 3gNST7cgAHK9f8vEi81vksLa28KhgQs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-VlFqiasHP-2BtPrJKGi5QA-1; Tue,
 30 Sep 2025 05:38:01 -0400
X-MC-Unique: VlFqiasHP-2BtPrJKGi5QA-1
X-Mimecast-MFC-AGG-ID: VlFqiasHP-2BtPrJKGi5QA_1759225079
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B8DE1944EB8; Tue, 30 Sep 2025 09:37:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E66C219560B8; Tue, 30 Sep 2025 09:37:53 +0000 (UTC)
Date: Tue, 30 Sep 2025 10:37:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
Message-ID: <aNuk7o2XYjoFsfXT@redhat.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com>
 <9f3a8d43-c428-45d4-bce5-1af764cf18a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f3a8d43-c428-45d4-bce5-1af764cf18a9@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 30, 2025 at 11:34:23AM +0200, Thomas Huth wrote:
> On 18/09/2025 01.21, Zhuoying Cai wrote:
> > Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
> > machine. This allows users to specify one or more certificate file paths
> > or directories to be used during secure boot.
> > 
> > Each entry is specified using the syntax:
> > 	boot-certs.<index>.path=/path/to/cert.pem
> > 
> > Multiple paths can be specify using array properties:
> > 	boot-certs.0.path=/path/to/cert.pem,
> > 	boot-certs.1.path=/path/to/cert-dir,
> > 	boot-certs.2.path=/path/to/another-dir...
> > 
> > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > ---
> >   docs/system/s390x/secure-ipl.rst   | 21 +++++++++++++++++++++
> >   hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
> >   include/hw/s390x/s390-virtio-ccw.h |  2 ++
> >   qapi/machine-s390x.json            | 22 ++++++++++++++++++++++
> >   qapi/pragma.json                   |  1 +
> >   qemu-options.hx                    |  6 +++++-
> >   6 files changed, 81 insertions(+), 1 deletion(-)
> >   create mode 100644 docs/system/s390x/secure-ipl.rst
> > 
> > diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> > new file mode 100644
> > index 0000000000..92c1bb2153
> > --- /dev/null
> > +++ b/docs/system/s390x/secure-ipl.rst
> > @@ -0,0 +1,21 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Secure IPL Command Line Options
> > +===============================
> > +
> > +The s390-ccw-virtio machine type supports secure IPL. These parameters allow users
> > +to provide certificates and enable secure IPL directly via the command line.
> > +
> > +Providing Certificates
> > +----------------------
> > +
> > +The certificate store can be populated by supplying a list of X.509 certificate file
> > +paths or directories containing certificate files on the command-line:
> > +
> > +Note: certificate files must have a .pem extension.
> > +
> > +.. code-block:: shell
> > +
> > +    qemu-system-s390x -machine s390-ccw-virtio, \
> > +                               boot-certs.0.path=/.../qemu/certs, \
> > +                               boot-certs.1.path=/another/path/cert.pem ...
> 
> Using newlines/spaces between parameters does not work, so people cannot
> copy-n-paste this example to the shell.
> 
> So I think you either have to merge it into one line, or use multiple
> "-machine" statements, e.g.:
> 
>     qemu-system-s390x -M s390-ccw-virtio \
>                       -M boot-certs.0.path=/.../qemu/certs \
>                       -M boot-certs.1.path=/another/path/cert.pem ...

The inability to copy+paste is unfortunate, but IMHO the docs are better
in the way they are already expressed. Repeating the -M arg in this way
is not a natural way we'd expect people to configure QEMU, even if it
happens to work in the case of -M/-machine.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


