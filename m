Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D84C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURC9-0003wL-K1; Thu, 18 Jul 2024 09:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sURC8-0003rd-7A
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:29:16 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sURC6-0007Su-Jn
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:29:15 -0400
Date: Thu, 18 Jul 2024 15:29:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721309353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ol+Df5K4LMiilY/gQaQS91liFd6iUChEl6uHcyLw7YU=;
 b=YCQR6ydDXYVx0RUaNhXsQPllffgSK2xcdlmSABDAOkJdGiBacCH9NrO8qBgyClP9NaOr3H
 mcAyYn6h/wxNaItB/RzPcUM4Ne/6TzYcQxk0e1zZuu4/1NdbTE1QTKCiFC8VsJkeKlcGrp
 gQ3jxykH1ZifZYs+ZKs90TgCIlpbZJA4PL7/XaX6xIMl9OE6Skm92aXiMKs+/Ea0vHgzoR
 wyhF892CuiPAkrlWrVJ2c77qlW2uXG3XBDVIkRfXBUAVfKyqjGjOV4hQpV1ARj9Hru/jOC
 1naZv6c56tfnhETcqOBalawtaTeBf0HGq7/aWyS4rKEv32hUFG/lnaXAdDIMDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721309353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ol+Df5K4LMiilY/gQaQS91liFd6iUChEl6uHcyLw7YU=;
 b=ULVSuA136S7ytPCKce8kaz0cCUpuZHoKsPfY1rFSbn+YOvSsz6y0bo1tGRWlOVEzWAuDpr
 QOlIxynuAE1I8MBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <t-8ch@linutronix.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v5 2/4] docs/interop/firmware.json: add new enum
 FirmwareArchitecture
Message-ID: <20240718152757-ea83949a-2ef8-4bf8-aeff-c1412baa753c@linutronix.de>
References: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
 <20240718-qapi-firmware-json-v5-2-0dba12d7aaf5@linutronix.de>
 <871q3qon3k.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q3qon3k.fsf@pond.sub.org>
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

On Thu, Jul 18, 2024 at 03:18:07PM GMT, Markus Armbruster wrote:
> Thomas Weißschuh <thomas.weissschuh@linutronix.de> writes:
> 
> > Only a small subset of all architectures supported by qemu make use of
> > firmware files. Introduce and use a new enum to represent this.
> >
> > This also removes the dependency to machine.json from the global qapi
> > definitions.
> >
> > Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  docs/interop/firmware.json | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> > index a26fe81bf2fe..2eb0be11d595 100644
> > --- a/docs/interop/firmware.json
> > +++ b/docs/interop/firmware.json
> > @@ -14,7 +14,10 @@
> >  # = Firmware
> >  ##
> >  
> > -{ 'include' : 'machine.json' }
> > +{ 'pragma': {
> > +    'member-name-exceptions': [
> > +        'FirmwareArchitecture' # x86_64
> > +    ] } }
> >  
> >  ##
> >  # @FirmwareOSInterface:
> > @@ -59,6 +62,28 @@
> >  { 'enum' : 'FirmwareDevice',
> >    'data' : [ 'flash', 'kernel', 'memory' ] }
> >  
> > +##
> > +# @FirmwareArchitecture:
> > +#
> > +# Enumerations of architectures for which Qemu uses additional firmware files.
> 
> docs/devel/qapi-code-gen.rst section "Documentation markup":
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
> > +# The values are a subset of the enum SysEmuTarget.

Ack.

> Will consumers of firmware.json care for this?

Most probably not.

> Or is it just a reminder for developers to keep the two enums in sync?

I guess so.
Should I drop it?

> 
> > +#
> > +# @aarch64: 64-bit Arm.
> > +#
> > +# @arm: 32-bit Arm.
> > +#
> > +# @i386: 32-bit x86.
> > +#
> > +# @loongarch64: 64-bit LoongArch.
> > +#
> > +# @x86_64: 64-bit x86.
> > +#
> > +# Since: 9.1
> 
> The enum type is indeed since 9.1, but its members are since 3.0, and
> that's what matters.  Except for @loongarch, which is since 7.1.0 (not
> documented in qapi/machine.json; I'll fix that).
> 
> > +##
> > +{ 'enum' : 'FirmwareArchitecture',
> > +  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
> > +
> > +
> 
> Drop one blank line, please.

Ack.

> 
> >  ##
> >  # @FirmwareTarget:
> >  #
> > @@ -80,7 +105,7 @@
> >  # Since: 3.0
> >  ##
> >  { 'struct' : 'FirmwareTarget',
> > -  'data'   : { 'architecture' : 'SysEmuTarget',
> > +  'data'   : { 'architecture' : 'FirmwareArchitecture',
> >                 'machines'     : [ 'str' ] } }
> >  
> >  ##
> 

