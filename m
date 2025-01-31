Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA409C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyZh-0003RH-IC; Fri, 31 Jan 2025 16:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tdyZg-0003Qt-Gt
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:29:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tdyZe-00050h-8F
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738358950;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oHmLDy+cP0TKEKGiBFBdrMwxKrR9TDf2AZVLB5a8pvc=;
 b=W4pfK0t4xDeZCtuTJnIXnDCAXnVntSIcKBEAKiNTj12a2W/1oNai1lJ6K+P/limqr7HyO+
 njTG23+0fgyZYnhpkxXXLyjVu6Dc+dn1kaEkEgD9zvsGTkFeaRhIi/s4h+6083L0p/i9hR
 mR0DxamHg76eiaqECdLWbGm97fwahtc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-o7Bx2ihlOtSN4Lt6sADwKg-1; Fri,
 31 Jan 2025 16:29:03 -0500
X-MC-Unique: o7Bx2ihlOtSN4Lt6sADwKg-1
X-Mimecast-MFC-AGG-ID: o7Bx2ihlOtSN4Lt6sADwKg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59C311956087; Fri, 31 Jan 2025 21:29:01 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C30118008F0; Fri, 31 Jan 2025 21:28:56 +0000 (UTC)
Date: Fri, 31 Jan 2025 21:28:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Hajnoczi, Stefan" <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liviu Ionescu <ilg@livius.net>
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
Message-ID: <Z51AlWh80Pqou6h_@redhat.com>
References: <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
 <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
 <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
 <c13e207e-06a5-4f40-b319-f4f2e59d919a@redhat.com>
 <CAFEAcA_CfVfypS5yUtT3V34CDxmAqx7wYnDoKPfHq-o=54GgAg@mail.gmail.com>
 <8a54600c-ff3f-42dd-b164-62a57de867df@redhat.com>
 <62449bfd-eb65-41d6-ae53-0333bcb603b3@linaro.org>
 <CABgObfYvYWxua7_TwYzWH99N5pR92Vsmv8Q=57FU_g5wSwmacw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfYvYWxua7_TwYzWH99N5pR92Vsmv8Q=57FU_g5wSwmacw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jan 31, 2025 at 06:08:32PM +0100, Paolo Bonzini wrote:
> Il ven 31 gen 2025, 17:46 Richard Henderson <richard.henderson@linaro.org>
> ha scritto:
> 
> > On 1/29/25 04:47, Paolo Bonzini wrote:
> > > The difference with TCG of course is that TCG is in active development,
> > and therefore its
> > > 32-bit host support is not surviving passively in the same way that a
> > random device is.
> > > Still, I think we can identify at least three different parts that
> > should be treated
> > > differently: 64-on-32, 32-on-32 system-mode emulation and 32-on-32
> > user-mode emulation.
> >
> > Why the user/system split for 32-on-32?
> >
> 
> Various reasons which overall point at 32-on-32 system emulation being not
> used very much.
> 
> 1) 32-bit has the address space size limitation, which makes it harder to
> test even moderately sized (2G) guests.
> 
> 2) I might be wrong but user mode emulation has no equivalent of the
> forced-64bit hwaddr or ram_addr_t types; 32 bit is not very 32 bit anyway
> in the case of system emulation
> 
> 3) 32-bit virtualization support only exists on x86 and possibly MIPS
> 
> 4) system emulation is used mostly on development systems, whereas user
> mode emulation might be used on small systems to run short-lived
> proprietary programs
> 
> 5) for those 32-bit hosts that have a completely separate TCG backend
> (well, that's Arm), getting rid TLB accesses does eliminate a bit of code.

These days perhaps one of the more (most?) common "linux-user" scenarios
I see is foreign arch containers. When telling docker/podman to run a
non- native container image, it relies on qemu-user to make it all work
transparently. Users probably don't even realize they're relying on
QEMU, things just look a little slower.

Given the prevalence of containers these days, if you have an OS install
whether 32-bit or 64-bit you're probably relying on podman/docker to some
extent. Those who need non-native containers is admittedly relatively
niche, but it wouldn't surprise me to hear of people doing it on 32-bit
machines.

In general I think the biggest problem we have is that users that are likely
to be impacted by our decisions won't pay any attention to QEMU upstream
at all. IOW they'll never see our deprecation announcement, and thus we
will never hear any feedback if they want it kept around

So perhaps we need to make a bit more effort to broadcast this particular
plan, given its more fundamental impact that most deprecations.

I'd suggest we should put out a qemu.org blog post post asking for feedback
on the proposal to drop 32-bit support. Then get people to publicise this
to their distro forums/mailing lists, and/or CC lwn.net to ask for it to be
featured it as a news item.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


