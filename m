Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC99EC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR92-0007vo-HM; Thu, 18 Jul 2024 09:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUR8z-0007ld-KK
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:26:01 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUR8x-0006Xw-Dd
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:26:01 -0400
Date: Thu, 18 Jul 2024 15:25:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721309155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5ceFkFkkwilixkfLDr31gEl4Wvdmh9vOg+PAZ+h8K0=;
 b=k6XtSWyVhZIlVrTd049IBDmzXoxkIwnFLiy7de726uodyHnNfb+pM/1Wg6orZaHYNuSrSL
 Tvl7SCtldXNqEzU4dpCF0b2Qj7aOs4csrNip6aByEqv4DpjKQCrcfDPkp2x7kRoQsHQBn/
 BEHie0883vSmo37A2G/YPrJFWMCMOBlQx8XorjN+FUB4SuhVq0eKvKu5T8R5Eytuy1Uu/q
 dxdMEfYIHiU+XjRz+MnN+JJToaSxR0Ypzq8sJutmVAQWM24awyADXVORMmAeS3Qg/NZ5xh
 BU9t2kK9f1J3QgYORgDFXLBXmpvBYQPT/dO8sTtePB1JqT6FMF0lQaG0Kmbtew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721309155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5ceFkFkkwilixkfLDr31gEl4Wvdmh9vOg+PAZ+h8K0=;
 b=4Sj1KgYOB0IwL1WUjV5mcdEKdqr/EnK9W7xbYk4D2i24XoyCczXdZAYmc8IiOvY+qNw8pA
 xCzgGc5zlwXh04Dw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <t-8ch@linutronix.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v5 1/4] docs/interop/firmware.json: add new enum
 FirmwareFormat
Message-ID: <20240718152306-277d9707-6fb4-4707-ae1c-78927fa42a4f@linutronix.de>
References: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
 <20240718-qapi-firmware-json-v5-1-0dba12d7aaf5@linutronix.de>
 <877cdionhq.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cdionhq.fsf@pond.sub.org>
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Thu, Jul 18, 2024 at 03:09:37PM GMT, Markus Armbruster wrote:
> Thomas Weißschuh <thomas.weissschuh@linutronix.de> writes:
> 
> > Only a small subset of all blockdev drivers make sense for firmware
> > images. Introduce and use a new enum to represent this.
> >
> > This also reduces the dependency on firmware.json from the global qapi
> > definitions.
> >
> > Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  docs/interop/firmware.json | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> > index 54a1fc6c1041..a26fe81bf2fe 100644
> > --- a/docs/interop/firmware.json
> > +++ b/docs/interop/firmware.json
> > @@ -15,7 +15,6 @@
> >  ##
> >  
> >  { 'include' : 'machine.json' }
> > -{ 'include' : 'block-core.json' }
> >  
> >  ##
> >  # @FirmwareOSInterface:
> > @@ -200,6 +199,20 @@
> >               'enrolled-keys', 'requires-smm', 'secure-boot',
> >               'verbose-dynamic', 'verbose-static' ] }
> >  
> > +##
> > +# @FirmwareFormat:
> > +#
> > +# Formats that are supported for firmware images.
> > +#
> > +# @raw: Raw disk image format.
> > +#
> > +# @qcow2: QEMU image format.
> 
> It's not the only QEMU image format...  Maybe "The QCOW2 image format."
> Almost tautological, but I don't have better ideas.

I used the wording from qemu-img(1).
If you prefer "The QCOW2 image format", I'll switch to that.

> > +#
> > +# Since: 9.1
> 
> The enum type is indeed since 9.1, but its two members are since 3.0,
> and that's what matters.

Ack.

So I change the Since: of the whole enum?
And not on the individual members?

> > +##
> > +{ 'enum': 'FirmwareFormat',
> > +  'data': [ 'raw', 'qcow2' ] }
> > +
> >  ##
> >  # @FirmwareFlashFile:
> >  #
> > @@ -219,7 +232,7 @@
> >  ##
> >  { 'struct' : 'FirmwareFlashFile',
> >    'data'   : { 'filename' : 'str',
> > -               'format'   : 'BlockdevDriver' } }
> > +               'format'   : 'FirmwareFormat' } }
> >  
> >  
> >  ##
> 

