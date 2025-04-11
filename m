Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96089C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 12:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Dx9-0002rB-Oe; Fri, 11 Apr 2025 08:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3Dx2-0002jT-NV
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3Dx0-0004Tx-Uy
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744376262;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/34RTJsKHRoxj2V/HVfiDMLcwHyEbnVRyOwurKKhbvw=;
 b=hSVCNRCby743PH7I91amXLnLXBUZ/XV8cdLsn7Nz70eW3ShcYRbAoR+fAXGWQwmdMKiB62
 9qtqq05E6zxOXwW9ubB3QjmG8CVD+atxcbbjI1uE2oFX3IcxqVib8tOUW70wHNi4VyTETv
 AJ7LGzjRI0mj4IbamzCXWlnW7pDlbDQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-oMGRrilCMPywDCfdKTr8JA-1; Fri,
 11 Apr 2025 08:57:37 -0400
X-MC-Unique: oMGRrilCMPywDCfdKTr8JA-1
X-Mimecast-MFC-AGG-ID: oMGRrilCMPywDCfdKTr8JA_1744376255
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3BD11800259; Fri, 11 Apr 2025 12:57:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE67F180886A; Fri, 11 Apr 2025 12:57:29 +0000 (UTC)
Date: Fri, 11 Apr 2025 13:57:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, walling@linux.ibm.com,
 jjherne@linux.ibm.com, jrossi@linux.ibm.com, fiuczy@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 01/24] Add -boot-certificates /path/dir:/path/file
 option in QEMU command line
Message-ID: <Z_kRtundT0x2-LxY@redhat.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-2-zycai@linux.ibm.com>
 <2e8a1ccf-5073-48dc-9641-c80d95d65b93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e8a1ccf-5073-48dc-9641-c80d95d65b93@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 11, 2025 at 12:44:17PM +0200, Thomas Huth wrote:
> On 08/04/2025 17.55, Zhuoying Cai wrote:
> > The `-boot-certificates /path/dir:/path/file` option is implemented
> > to provide path to either a directory or a single certificate.
> > 
> > Multiple paths can be delineated using a colon.
> > 
> > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > ---
> >   qemu-options.hx | 11 +++++++++++
> >   system/vl.c     | 22 ++++++++++++++++++++++
> >   2 files changed, 33 insertions(+)
> > 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index dc694a99a3..b460c63490 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -1251,6 +1251,17 @@ SRST
> >       Set system UUID.
> >   ERST
> > +DEF("boot-certificates", HAS_ARG, QEMU_OPTION_boot_certificates,
> > +    "-boot-certificates /path/directory:/path/file\n"
> > +    "                  Provide a path to a directory or a boot certificate.\n"
> > +    "                  A colon may be used to delineate multiple paths.\n",
> > +    QEMU_ARCH_S390X)
> > +SRST
> > +``-boot-certificates /path/directory:/path/file``
> > +    Provide a path to a directory or a boot certificate.
> > +    A colon may be used to delineate multiple paths.
> > +ERST
> 
> Unless there is a really, really good reason for introducing new top-level
> options to QEMU, this should rather be added to one of the existing options
> instead.
> 
> I assume this is very specific to s390x, isn't it? So the best way is likely
> to add this as a parameter of the machine type option, so that the user
> would specify:
> 
>  qemu-system-s390x -machine s390-ccw-virtio,boot-certificates=/path/to/certs
> 
> See the other object_class_property_add() statements in
> ccw_machine_class_init() for some examples how to do this.

With other arches that use EDK2 (x86, arm64, riscv64, loongarch64) we
pass this info via fw_cfg

   -fw_cfg name=etc/edk2/https/cacerts,file=<certdb>

Assuming this series is trying to implement a pre-existing s390x machine
standard for passing certs, then it seems inevitable that it will need
a different config approach than we use for EDK2.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


