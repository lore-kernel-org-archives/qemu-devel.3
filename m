Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CDFC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpn3F-0007fk-BN; Thu, 28 Mar 2024 06:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rpn2t-0007eI-Vg
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:31:51 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rpn2r-0000sN-Vc
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:31:43 -0400
Date: Thu, 28 Mar 2024 11:31:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1711621878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmajqnqPgd1U9Ifk5DBgR88ny9eMkWyAJEddVfskcAM=;
 b=4GfMeEtMNEFGE1Z6urV9kyftC5e9OBsUp2K3G1QNfjsSSlrG7fQmtja882BcvtIz03odn8
 N/iwxBftOdH2QC82EPb8Z58KzUUEwJ5S5f8or+uctCIkqseVy7CxPh2fuhZuhk8Dka3Wzx
 AzyGl3k1SaNBy7TZIqnaQWXVPEdPn1CV9v0tMrp9YLdup+KFCxHKvFdDKWyDcm8KzufK9W
 a4xSUvFvlZQrti+YJ2cEZRd1b6ibexAmtxqgYhUQgN40o1u/KfykGM3LdWqRBYFL0CRnp5
 WnsCfWPUKeicnV9GwA4yIiS4Mlwr4i5a6X7Mxp74ll//2Ey0ucwFNM/UN3Tb3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1711621878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmajqnqPgd1U9Ifk5DBgR88ny9eMkWyAJEddVfskcAM=;
 b=rFAob5Fx6V36lADW0aVcnI+oMUH68auE/XFe/WUqx4s5pDRxlFy+yI4GiuclzJUuBDxXr7
 6L1JiFDMvzIaYFDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/3] docs/interop/firmware.json: add new enum
 FirmwareFormat
Message-ID: <20240328112446-04ad852e-c1cc-4ca9-88b0-cd4bb891a324@linutronix.de>
References: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
 <20240311-qapi-firmware-json-v3-1-ceea6e35eb4a@linutronix.de>
 <87wmq8sxqi.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmq8sxqi.fsf@pond.sub.org>
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Hanna and Kevin,

any updates?

On Mon, Mar 11, 2024 at 02:29:25PM +0100, Markus Armbruster wrote:
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> writes:
> 
> > Only a small subset of all blockdev drivers make sense for firmware
> > images. Introduce and use a new enum to represent this.
> >
> > This also reduces the dependency of firmware.json on the global qapi
> > definitions.
> >
> > Suggested-by: Daniel P. BerrangÈ <berrange@redhat.com>
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  docs/interop/firmware.json | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> > index 54a1fc6c1041..0e619e8780e7 100644
> > --- a/docs/interop/firmware.json
> > +++ b/docs/interop/firmware.json
> > @@ -15,7 +15,11 @@
> >  ##
> >  
> >  { 'include' : 'machine.json' }
> > -{ 'include' : 'block-core.json' }
> > +
> > +{ 'pragma': {
> > +    'documentation-exceptions': [
> > +        'FirmwareFormat'
> > +    ] } }
> 
> Necessary because ...
> >  
> >  ##
> >  # @FirmwareOSInterface:
> > @@ -200,6 +204,16 @@
> >               'enrolled-keys', 'requires-smm', 'secure-boot',
> >               'verbose-dynamic', 'verbose-static' ] }
> >  
> > +##
> > +# @FirmwareFormat:
> > +#
> > +# Formats that are supported for firmware images.
> > +#
> 
> ... we don't document the members here.  Documenting them would be
> nicer.  We'd do that if we could steal it from BlockdevDriver, but
> there's nothing to steal there.
> 
> Mere observation; I'm not asking you to come up with documentation
> BlockdevDriver doesn't have.
> 
> > +# Since: 8.3
> > +##
> > +{ 'enum': 'FirmwareFormat',
> > +  'data': [ 'raw', 'qcow2' ] }
> 
> @raw or @file?  Kevin or Hanna, thoughts?

The existing descriptors in pc-bios/descriptors/ are using @raw.

> > +
> >  ##
> >  # @FirmwareFlashFile:
> >  #
> > @@ -219,7 +233,7 @@
> >  ##
> >  { 'struct' : 'FirmwareFlashFile',
> >    'data'   : { 'filename' : 'str',
> > -               'format'   : 'BlockdevDriver' } }
> > +               'format'   : 'FirmwareFormat' } }
> >  
> >  
> >  ##

Thanks,
Thomas

