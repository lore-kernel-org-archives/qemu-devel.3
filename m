Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CE6C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricYX-0007Lw-NH; Fri, 08 Mar 2024 10:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1ricYW-0007LO-0q
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:54:44 -0500
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1ricYU-00051z-02
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:54:43 -0500
Date: Fri, 8 Mar 2024 16:54:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709913269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xG59uKkO3wSO43BZ4/5KJJL6yb+z9MIWqd6jTvMli4=;
 b=h1QILic7CCUZzFncoUJrOiiu8dtCO9dzWVGbZq9tS2M1ijTAXNMZ9fzY8SaPV7O66Nz3NP
 gLcgJJdVu0SeXzD9UH7HCP3Ox+i10/9avOCNfgPc1WZd9/mDfy5mON8i08BSl0Bsa4t2uW
 wO+zpnc7H1QFmKaHLZJOVcu46/eHN+q3oNb6n/Q4EzziKIQEfq8RB0j/vXtMONgUt0k+hB
 +worhoiWBLyDoIRASCVRBGdfQr+NuKDQoGwoqnAaXCSgqaiEGirgtUcbKy9Xa8aduoGoob
 FspeDSi0JZk3wt61R6aSzBQ+kKOcgcC5Z7B5jhjwI50qUPTy6m5uvoraJFuN+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709913269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xG59uKkO3wSO43BZ4/5KJJL6yb+z9MIWqd6jTvMli4=;
 b=GYM0hfugffLm5M0+5Ood5RP2CjPycLUN1mtxwxwrNV1GZMgCQBKafyHpsLrXzQCfQ4NYtj
 A67Ul2wNBuR1odCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] docs/interop/firmware.json: Use full include paths
Message-ID: <20240308164620-2ed882af-2ff4-4d36-a3aa-148c2d48fcbf@linutronix.de>
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
 <20240306-qapi-firmware-json-v1-3-619f7122a249@linutronix.de>
 <87le6s21kh.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87le6s21kh.fsf@pond.sub.org>
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 08, 2024 at 04:19:42PM +0100, Markus Armbruster wrote:
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> writes:
> 
> > The included files are part of the toplevel QAPI directory and need to
> > be included from there.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  docs/interop/firmware.json | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> > index 54a1fc6c1041..4ac840e2b413 100644
> > --- a/docs/interop/firmware.json
> > +++ b/docs/interop/firmware.json
> > @@ -14,8 +14,8 @@
> >  # = Firmware
> >  ##
> >  
> > -{ 'include' : 'machine.json' }
> > -{ 'include' : 'block-core.json' }
> > +{ 'include' : '../../qapi/machine.json' }
> > +{ 'include' : '../../qapi/block-core.json' }
> >  
> >  ##
> >  # @FirmwareOSInterface:
> 
> The coupling with the main QAPI schema is unfortunate.
> 
> The purpose of docs/interop/firmware.json is to serve as schema for
> firmware descriptions: a firmware description is a JSON object that
> conforms to this schema's struct Firmware.
> 
> Such a description should be installed along with each firmware binary.
> 
> QAPI tooling can be used to check conformance: parse the firmware
> description JSON object, feed it to the generated visit_type_Firmware().
> Success implies conformance.
> 
> If you find more uses for the C struct Firmware created by
> visit_type_Firmware(), more power to you.

I am writing a tool "qemu-firmware" that can be used to query and
introspect those installed JSON description files.
This is where my changes are coming from.

That tool is meant to be pushed to qemu upstream but it's not ready yet.

> firmware.json needs machine.json for SysEmuTarget, and block-core.json
> for BlockdevDriver.  The largest and the third-largest QAPI module just
> for two enums.  Almost a quarter Mebibyte of code.
> 
> qapi-gen.py generates more than 12kSLOC.  Without the include (and with
> the enums dumbed down to 'str' to enable that), it generates less than
> 800.

The generated code also doesn't link properly because it has
dependencies on various parts of qemu internals.

In my "qemu-firmware" branch I have two more commits that split
SysEmuTarget and BlockdevDriver into their own JSON files.
Then everything works nicely.
These commits were not submitted yet as they felt specific to my
usecase.

> We could use Sphinx to generate a manual from firmware.json's document.
> Except that manual would be useless, because of its 11,000 lines of
> HTML, less than 800 are for firmware.json.
> 
> Options:
> 
> * Live with the mess.
> 
> * Refactor QAPI modules so firmware.json can include just the enums.
> 
>   Drawback: we spread the mess into qapi/.  Ugh.

As mentioned above, this is what I ended up doing and which I prefer for
my usecase.

> * Copy the enums to firmware.json.
> 
>   Drawback: we risk them going stale.
> 
> * Dumb down to 'str'.
> 
>   Drawback: the conformance check no longer enforces the value of
>   FirmwareTarget member @architecture and FirmwareFlashFile member
>   @format is valid.
> 
> Thoughts?

