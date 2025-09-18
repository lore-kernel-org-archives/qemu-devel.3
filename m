Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558F5CAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzA9x-00077X-P3; Thu, 18 Sep 2025 04:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzA9v-00076l-FP
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzA9p-0002Ln-Pn
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758184703;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FwW1Ve/ElzCGgx/OYSno/7cRR/EqJl+++32Ha7IlMkQ=;
 b=UlqzDYSGbpWzkm1pzW1/C2bHWsGAk9HnJD2mVtBUqGPO+TUipjlnlldvmPQnUT62VNm5T/
 r03FURbTssedZb/1e15zHyToOFkVLlVhs+WbSWdbAVd7ybnFlQKlmmHkY/G3C8dklbFiwo
 r9rskolJj5xq0ASu2hTgvc7CFrVGLBM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-ros6VydQMGqEafN1W-TyxA-1; Thu,
 18 Sep 2025 04:38:14 -0400
X-MC-Unique: ros6VydQMGqEafN1W-TyxA-1
X-Mimecast-MFC-AGG-ID: ros6VydQMGqEafN1W-TyxA_1758184692
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDC20195604F; Thu, 18 Sep 2025 08:38:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77DD71800447; Thu, 18 Sep 2025 08:38:07 +0000 (UTC)
Date: Thu, 18 Sep 2025 09:38:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 alifm@linux.ibm.com
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
Message-ID: <aMvE7Phd7sLvgj-J@redhat.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com>
 <87ldmcz1so.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldmcz1so.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 18, 2025 at 08:56:39AM +0200, Markus Armbruster wrote:
> Zhuoying Cai <zycai@linux.ibm.com> writes:
> 
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
> 
> Given we can specifiy a directory containing any number of certificate
> files, is the ability to specify multiple paths worth the additional
> complexity?

The typical scenario would be point to somewhere in /etc/pki
for some globally provided certs, and then also point to
somewhere local ($HOME) for custom extra certs. So IMHO it
is reasonable to want multiple paths, to avoid copying around
certs from different locations.

> 
> > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> 
> [...]
> 
> > diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> > index 966dbd61d2..51bf791fe6 100644
> > --- a/qapi/machine-s390x.json
> > +++ b/qapi/machine-s390x.json
> > @@ -119,3 +119,25 @@
> >  { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
> >    'features': [ 'unstable' ]
> >  }
> > +
> > +##
> > +# @BootCertificate:
> > +#
> > +# Boot certificate for secure IPL.
> > +#
> > +# @path: path to an X.509 certificate file or a directory containing certificate files.
> > +#
> > +# Since: 10.2
> > +##
> > +{ 'struct': 'BootCertificate',
> > +  'data': {'path': 'str'} }
> 
> I'd call this BootCertificates (plural), because it can pull in any
> number, not just than one.
> 
> > +
> > +##
> > +# @DummyBootCertificates:
> > +#
> > +# Not used by QMP; hack to let us use BootCertificateList internally.
> > +#
> > +# Since: 10.2
> > +##
> > +{ 'struct': 'DummyBootCertificates',
> > +  'data': {'unused-boot-certs': ['BootCertificate'] } }
> > diff --git a/qapi/pragma.json b/qapi/pragma.json
> > index 023a2ef7bc..66401837ad 100644
> > --- a/qapi/pragma.json
> > +++ b/qapi/pragma.json
> > @@ -49,6 +49,7 @@
> >          'DisplayProtocol',
> >          'DriveBackupWrapper',
> >          'DummyBlockCoreForceArrays',
> > +        'DummyBootCertificates',
> >          'DummyForceArrays',
> >          'DummyVirtioForceArrays',
> >          'HotKeyMod',
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


