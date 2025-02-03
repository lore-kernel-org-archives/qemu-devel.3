Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B611C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texWH-0001Rl-CU; Mon, 03 Feb 2025 09:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1texW8-0001Qo-Ay
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1texW5-0001Yb-If
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738593216;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/8lBcAxko77k2JXvwd14R3PdPpTHUsEvPGEv7+BpP0=;
 b=g8Rb5H+kt6FtNyQFR4czJhYfGo3tpIFmhOHSGHxlK4FoeAf/mrfhdAAms3EE/c8Jh3Ucsu
 nY5RVS/QQ77bibqgCrLjpqeXT2lZMfOqNLp+cMJDE6JhWwr7GpdxR7ZCseLiCs5xlP838p
 FT6tk5ZhOXc1LrDfSQ3cyvM5RuAQJyU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-_ZEzzofhMEqaSxQEspyoFg-1; Mon,
 03 Feb 2025 09:33:31 -0500
X-MC-Unique: _ZEzzofhMEqaSxQEspyoFg-1
X-Mimecast-MFC-AGG-ID: _ZEzzofhMEqaSxQEspyoFg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A30519560B2; Mon,  3 Feb 2025 14:33:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 491F5180035E; Mon,  3 Feb 2025 14:33:25 +0000 (UTC)
Date: Mon, 3 Feb 2025 14:33:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Jared Mauch <jared+home@puck.nether.net>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of DRAM
Message-ID: <Z6DTsdf35ApQ0qLU@redhat.com>
References: <20250201091528.1177-1-philmd@linaro.org>
 <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
 <CAFEAcA_mBXO20NhYRHJCgkB0h8uYQQhBMdwVW376R4u-qh51nA@mail.gmail.com>
 <87ed0fayoy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ed0fayoy.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 03, 2025 at 02:29:49PM +0000, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Sat, 1 Feb 2025 at 12:57, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >>
> >> On Sat, 1 Feb 2025, Philippe Mathieu-Daudé wrote:
> >> > - Deprecate the 'raspi4b' machine name, renaming it as
> >> >  'raspi4b-1g' on 32-bit hosts, 'raspi4b-2g' otherwise.
> >> > - Add the 'raspi4b-4g' and 'raspi4b-8g' machines, with
> >> >  respectively 4GB and 8GB of DRAM.
> >>
> >> IMHO (meaning you can ignore it, just my opinion) if the only difference
> >> is the memory size -machine raspi4b -memory 4g would be better user
> >> experience than having a lot of different machines.
> >
> > Yes, I think I agree. We have a way for users to specify
> > how much memory they want, and I think it makes more sense
> > to use that than to have lots of different machine types.
> 
> I guess for the Pi we should validate the -memory supplied is on of the
> supported grid of devices rather than an arbitrary value?

If the user wants to create a rpi4 with 6 GB RAM why should we stop
them ? It is their choice if they want to precisely replicate RAM
size from a physical model, or use something different when virtualized.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


