Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBECF33812
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q3X-0003yd-NQ; Tue, 17 Mar 2026 04:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w2Q3V-0003wP-Lj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w2Q3T-0006ww-No
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlieGdi6ZOkCHyp2ldI/32JlToohy+mEtd9XgegbTkM=;
 b=CVAkVnMOOUqARLQQMVDCvqWlxWHonbuwNMBC0kU5y5B4HAU+EyjW9aEFIFTozvhnRWaK4e
 D9r5YHsE+EJlYhsqpl2Oa4VQvlgwl/jTfmQ8rL79Mh2mgIFKufmI8QWSiRr4X1fqvA+RoP
 fxdktmYQqcouQs2OFaciZttw99gEwXg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-WLTBxXUEOqeMYuenHkm9lg-1; Tue,
 17 Mar 2026 04:45:29 -0400
X-MC-Unique: WLTBxXUEOqeMYuenHkm9lg-1
X-Mimecast-MFC-AGG-ID: WLTBxXUEOqeMYuenHkm9lg_1773737128
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 719E919560B9; Tue, 17 Mar 2026 08:45:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC4481800361; Tue, 17 Mar 2026 08:45:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 924181800634; Tue, 17 Mar 2026 09:45:25 +0100 (CET)
Date: Tue, 17 Mar 2026 09:45:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Oliver Steffen <osteffen@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/arm/virt: add serial-debug-level property for EDK2
 firmware
Message-ID: <abkPy4Xzf6YT6g5Y@sirius.home.kraxel.org>
References: <20260311-edk2_arm_serial-v1-1-c25e237116f3@redhat.com>
 <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 11, 2026 at 03:24:04PM -0700, Pierrick Bouvier wrote:
> Hi Luigi,
> 
> On 3/11/26 6:43 AM, Luigi Leonardi wrote:
> > Add a machine property to pass a debug level to EDK2 firmware via the
> > device tree. The value is set as an "edk2,debug-level" property on all
> > pl011 UART nodes.
> > 
> > This is to create a runtime parameter to set the verbosity of the debug
> > log on the serial ports in edk2. Currently, the only way to set the
> > verbosity is a compile-time option.
> > 
> > DT is used because the fw_cfg interface is not yet initialized in early
> > boot phases.
> > 
> > Corresponding edk2 PR: https://github.com/tianocore/edk2/pull/12277
> > 
> > Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > ---
> >   docs/system/arm/virt.rst |  6 ++++++
> >   hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
> >   include/hw/arm/virt.h    |  2 ++
> >   3 files changed, 46 insertions(+)
> > 
> 
> I am not sure if maintainer want to have bootloader specific options in
> machine code.

Does that mean "yes" or "no" or "maybe" ?

Some background:  Traditionally firmware logging in edk2/ArmVirtPkg is a
compile time option, so typically distributions ship two builds, one
with logging turned on and one with logging turned off.

Last year edk2 got support for logging to a memory buffer which can be
accessed from the booted OS or via qemu monitor.  Ideally we have this
always enabled, but without also spamming the serial console with the
firmware log (by default).  While working on that it would be nice to
also get rid of the two builds by moving from a compile time to a
runtime switch for the serial debug log.

> Alternatively, it's possible to dump virt dtb, modify it, and pass it.
> $ ./build/qemu-system-aarch64 -M virt,dtb=file.dtb
> $ ... modify dt ...
> $ ./build/qemu-system-aarch64 -M virt,dtb=file.dtb

I'd like to have something more convenient than that to turn on firmware
debug logging.

On x86 we have a dedicated device for firmware logging (isa-debugcon),
so logging can be easily enabled on the qemu command line by adding that
device.

So the idea here is to have a dt property added to serial port to
setup firmware logging, so we have something roughly comparable to the
x86 functionality ...

take care,
  Gerd


