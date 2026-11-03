Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A5606A329
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BOgbBcKq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO9gw-0000I1-03; Tue, 03 Nov 2026 03:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xO9gs-0000Fx-BX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xO9gp-0001cA-Et
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793693777;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BVLfCVXQHgSH4f3V9ZECiy4kJVTCfquG8wFB49Y2ssc=;
 b=BOgbBcKqzY2vs17Uqyt1i9kPJ+JGyh4IsGn+SoAPf89NXRfgGMA1dkUSc9bQNlvoT2mix9
 JMN6B1U9j/KjMBHsEmELxVAyx4cIUfiN+lSe1W8DCdhFJN4X/H7ixiXhsaruRv2A/PMnov
 75OPUfgXy7yGLxDT8apkLjPFYxUVAP8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-kBU0XR3aMbS8L4OQaIH33A-1; Tue,
 03 Nov 2026 03:16:13 -0500
X-MC-Unique: kBU0XR3aMbS8L4OQaIH33A-1
X-Mimecast-MFC-AGG-ID: kBU0XR3aMbS8L4OQaIH33A_1793693768
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DF86180067A; Tue,  3 Nov 2026 08:16:06 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D11201955F43; Tue,  3 Nov 2026 08:15:55 +0000 (UTC)
Date: Tue, 3 Nov 2026 08:15:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Anthony PERARD <anthony@xenproject.org>, Felipe Balbi <balbi@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
Message-ID: <aumYOBw-nKQAWdYK@redhat.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 05:51:44PM -0800, Pierrick Bouvier wrote:
> On 10/30/2026 4:09 PM, BALATON Zoltan wrote:
> > On Fri, 30 Oct 2026, Yonggang Luo wrote:
> >> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo and the
> >> type_init
> >> function that calls type_register_static(). A later change needs to
> >> pass a
> > 
> > That's the point of the macro to hide the boiler plate code.
> > 
> >> target mask into that registration, and the macros have no parameter
> >> for it.
> > 
> > Couldn't you just change the macros to take that parameter instead of
> > expanding it everywhere?
> >
> 
> Problem of macros is that they don't have default parameters, so you
> need variants for everything:
> 
> DEFINE_MACHINE
> DEFINE_MACHINE_EXTENDED
> DEFINE_MACHINE_WITH_INTERFACES
> DEFINE_MACHINE_WITH_INTERFACE_ARRAY
> and now would need a new variant, with variant for other existing ones.
> 
> In the end, it's just simpler to remove this and add the boilerplate.
> It's written once and never modified, so using a macro just save typing
> those lines once.

For each machine, it is only written once, but we add machines
over time, and every time a new machine is added the code style
is slightly different. We introduced all the variuos DEFINE_*
macros for QOM to better ensure consistent style and usage as
new code is added over time.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


