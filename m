Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65C8CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 17:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyCqo-00072B-2f; Mon, 15 Sep 2025 13:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyCql-00070V-Dq
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 13:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyCqc-0005y4-CZ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 13:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757956713;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JwBxJbsuhxjUU4DljefK1d1YKNvIldqJYryg8aRmkGk=;
 b=aWFVR/R/3fVYw0yVCnXRppAmYEqA7Trl2EL1TwXr2KATuk9jEaVwJgPT/qvOwi0vRAvykV
 wxvgj4q74oDTvPQCELnBCTIj/bjWpreUT8/RkqeoSL+SVXQO7ePANlkXIOplfpHkyFnW30
 xpNRuj16Jc0zl/Mxv/kmuVg79PKntxo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-MY2S4Vy5PaG0bCeS_V_yLg-1; Mon,
 15 Sep 2025 13:18:30 -0400
X-MC-Unique: MY2S4Vy5PaG0bCeS_V_yLg-1
X-Mimecast-MFC-AGG-ID: MY2S4Vy5PaG0bCeS_V_yLg_1757956708
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B53518002D7; Mon, 15 Sep 2025 17:18:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6750C19560B4; Mon, 15 Sep 2025 17:18:22 +0000 (UTC)
Date: Mon, 15 Sep 2025 18:18:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 alifm@linux.ibm.com
Subject: Re: [PATCH v5 01/29] Add boot-certs to s390-ccw-virtio machine type
 option
Message-ID: <aMhKWu7i-9MgO30H@redhat.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-2-zycai@linux.ibm.com>
 <87v7lpjvsw.fsf@pond.sub.org>
 <ffb4d32b-d2bc-45f0-91ce-6472d64c02bb@linux.ibm.com>
 <87wm64b29p.fsf@pond.sub.org>
 <3d930413-d809-4650-b1d8-446eb4ee7daa@linux.ibm.com>
 <87tt14z03x.fsf@pond.sub.org>
 <14c613b1-d595-4cf1-b26e-5d87965a2c98@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14c613b1-d595-4cf1-b26e-5d87965a2c98@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 15, 2025 at 12:14:50PM -0400, Zhuoying Cai wrote:
> On 9/15/25 2:44 AM, Markus Armbruster wrote:
> > Zhuoying Cai <zycai@linux.ibm.com> writes:
> > 
> >> On 9/12/25 2:42 AM, Markus Armbruster wrote:
> >>> Zhuoying Cai <zycai@linux.ibm.com> writes:
> >>>
> >>>> Thanks for the feedback.
> >>>>
> >>>> On 9/11/25 3:24 AM, Markus Armbruster wrote:
> >>>>> Zhuoying Cai <zycai@linux.ibm.com> writes:
> >>>>>
> >>>>>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
> >>>>>> machine. This allows users to specify one or more certificate file paths
> >>>>>> or directories to be used during secure boot.
> >>>>>>
> >>>>>> Each entry is specified using the syntax:
> >>>>>> 	boot-certs.<index>.path=/path/to/cert.pem
> >>>>>>
> >>>>>> Multiple paths can be specify using array properties:
> >>>>>> 	boot-certs.0.path=/path/to/cert.pem,
> >>>>>> 	boot-certs.1.path=/path/to/cert-dir,
> >>>>>> 	boot-certs.2.path=/path/to/another-dir...
> >>>>>>
> >>>>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> >>>>>> ---
> >>>>>>  docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
> >>>>>>  hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
> >>>>>>  include/hw/s390x/s390-virtio-ccw.h |  2 ++
> >>>>>>  qapi/machine-s390x.json            | 24 ++++++++++++++++++++++++
> >>>>>>  qemu-options.hx                    |  6 +++++-
> >>>>>>  5 files changed, 81 insertions(+), 1 deletion(-)
> >>>>>>  create mode 100644 docs/system/s390x/secure-ipl.rst
> >>>>>>
> >>>>>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> >>>>>> new file mode 100644
> >>>>>> index 0000000000..9b3fd25cc4
> >>>>>> --- /dev/null
> >>>>>> +++ b/docs/system/s390x/secure-ipl.rst
> >>>>>> @@ -0,0 +1,20 @@
> >>>>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
> >>>>>> +
> >>>>>> +Secure IPL Command Line Options
> >>>>>> +===============================
> >>>>>> +
> >>>>>> +New parameters have been introduced to s390-ccw-virtio machine type option
> >>>>>> +to support secure IPL. These parameters allow users to provide certificates
> >>>>>> +and enable secure IPL directly via the command line.
> >>>>>
> >>>>> All too soon these parameters will no longer be new.  Consider something
> >>>>> like "The s390-ccw-virtio machine type supports secure TPL.  To enable
> >>>>> it, you need to provide certificates."
> >>>>>
> >>>>>> +
> >>>>>> +Providing Certificates
> >>>>>> +----------------------
> >>>>>> +
> >>>>>> +The certificate store can be populated by supplying a list of certificate file
> >>>>>> +paths or directories on the command-line:
> >>>>>
> >>>>> File is clear enough (use the certificate found in the file).  What does
> >>>>> directory do?
> >>>>
> >>>> A directory contains a list of certificate files, and allowing both
> >>>> files and directories could make the CLI more flexible.
> >>>
> >>> I figure when @path names a file, it's an error when the file doesn't
> >>> contain a valid cetificate.
> >>>
> >>> What is @path names a directory, and one of the directory's files
> >>> doesn't contain a valid certificate?
> >>>
> >>> Can a single file contain multiple certificates?
> >>
> >> A certificate file path is expected to contain exactly one certificate.
> >>
> >> Certificates provided through the CLI, whether as individual files or
> >> within a directory, are validated before use. If a certificate is
> >> invalid (e.g., unsupported format), it will be skipped and not added to
> >> the S390 certificate store.
> > 
> > Hmm.  What exactly happens when I configure a certificate file like
> > 
> >     -machine s390-ccw-virtio,boot-certs.0.path=/dev/null
> > 
> > or some other file that doesn't contain a valud certificate?  Is it
> > silently ignored, or is it an error?
> > 
> >> When iterating through the provided paths, the program will terminate on
> >> fatal configuration errors, such as when a specified path is neither a
> >> file nor a directory.
> > 
> 
> If /dev/null is provided, the program will report an error and terminates.
> 
>    qemu-system-s390x: Path '/dev/null' is neither a file nor a directory
> 
> If a file exists but doesn't contain a valid certificate, the program
> will report the error but continues validating other remaining
> certificates. For example, providing a certificate in DER format
> (cert.pem) is not supported; only PEM format certificates are accepted:
> 
>    -machine s390-ccw-virtio,boot-certs.0.path=/root/cert.pem, \
>                             boot-certs.1.path=/root/pem-test/rsa.pem, \
>                             boot-certs.2.path=/root/pem-test/rsa-oaep.pem
> 
>    qemu-system-s390x: Failed to initialize certificate: /root/cert.pem:
> Failed to import certificate: Base64 unexpected header error.
> Using virtio-blk.
> SCSI boot device supports secure boot.
> LOADPARM=[        ]
> 
> Using virtio-blk.
> Using SCSI scheme.
> ....Verified component
> ...Verified component
> ...
> 
> In summary, QEMU first collects a list of .pem files from the CLI, and
> then validate each certificate in that list.
> 
> More specifically, QEMU first checks and normalizes the certificate
> paths - each path must be a non-empty string, must exist, and must be
> either a regular file or a directory. An invalid path will be reported
> and cause the program to terminate. Regular files with a .pem suffix, as
> well as .pem files inside directories, are added to the list.

IMHO we should be a bit more strict than this

 * If pointing to a file - loading must succeed; errors must be fatal
 * If pointing to a dir - the dir must exist, any file NOT ending in
   .pem should be ignored, any file ending in .pem must succeed, errors
   must be fatal
 * If pointing to neither a file, nor dir - must be fatal

ie we should be assuming that the configuration is expected to work, and
thus errors when loading are liable to be admin config mistakes that should
be fatal.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


