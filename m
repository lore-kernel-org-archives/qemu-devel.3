Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A0606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e1FlG7uW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOy4N-0003iD-Sy; Thu, 05 Nov 2026 09:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOy4H-0003hc-SN
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 09:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOy4F-0007TT-JK
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 09:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793887431;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrFG4d4I3bf6wvFIecldGgUKxuaBVaJdqc7s0tzOd/0=;
 b=e1FlG7uWCd/LdP37Rs5GyoVyS4i/C65SE389A0jM4S8ScCpCZFopgPvBM5yPhr15ZjY3uq
 X4+X6BuefDCcL6mU9Bii1c6JwavZp+6/Lul8AaWf4xXtM5K5SA0ULYgj1pEM+HFK5kLg/N
 AGsA+JeqpOxdCMSXf22YHZl4K44V7Q4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-kgdL6b5EMXCNFCI9ULPNsA-1; Thu,
 05 Nov 2026 09:03:47 -0500
X-MC-Unique: kgdL6b5EMXCNFCI9ULPNsA-1
X-Mimecast-MFC-AGG-ID: kgdL6b5EMXCNFCI9ULPNsA_1793887425
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1D45180063F; Thu,  5 Nov 2026 14:03:44 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 394943001DA0; Thu,  5 Nov 2026 14:03:40 +0000 (UTC)
Date: Thu, 5 Nov 2026 14:03:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2 06/12] target/arm: register separate max-v8 CPU types
 for arm and aarch64
Message-ID: <auyMuW8OWgckzmLf@redhat.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
 <20261031164009.2048-7-luoyonggang@gmail.com>
 <auxgsFyzv-5UiyNk@redhat.com>
 <CAE2XoE9J++-BHL5BDx4_jxuto+xwVmvFS3F-hE9gLbgfUmaFdA@mail.gmail.com>
 <aux5vwTnbV3cXcFX@redhat.com>
 <CAFEAcA97kTiGVdPO-QtEkQ0+AuVS1z3Ctfc-q8bJJnEqFwavCw@mail.gmail.com>
 <auyJOk0bjHWO4-FO@redhat.com>
 <CAFEAcA_T+WtgKYU5QnaGiuAyZYpAmj6vrzvd_kC8FAFqP7i-mA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_T+WtgKYU5QnaGiuAyZYpAmj6vrzvd_kC8FAFqP7i-mA@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Thu, Nov 05, 2026 at 01:56:51PM +0000, Peter Maydell wrote:
> On Thu, 5 Nov 2026 at 13:48, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Nov 05, 2026 at 01:45:00PM +0000, Peter Maydell wrote:
> > > On Thu, 5 Nov 2026 at 12:42, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > So that essentially matches the historical semantics where one
> > > > CPU class magically changes its behaviour based on what target
> > > > is running.  So in that sense, it works, and is no worse than
> > > > the semantics we've had for 'max' models forever.
> > > >
> > > > Splitting into 2 distinct types is worthwhile if we want to
> > > > make it possible for the aarch64 emulator to support a runtime
> > > > choice of both 32-bit and 64-bit "max" models.
> > >
> > > What would the difference between that and configuring the 64-bit
> > > capable "max" to not have AArch64 via "-cpu max-v8:aarch64=off"
> > > (which should work today) ?
> >
> > Is that really the same result ?
> >
> > It seems like aarch64_max_v8_tcg_initfn does alot more CPU modelling
> > than aarch32_max_v8_tcg_initfn, than just a single flag ?
> 
> Conceptually it gets you to the same place -- a 32-bit only CPU
> with all the 32-bit features turned on that we support.
> 
> aarch64_max_v8_tcg_initfn() sets up all the 64-bit-only ID registers,
> which is most of what its code is doing. But the handling of
> "aarch64=off" then clears them all out via arm_clear_aarch64_idregs(),
> and even if it didn't, any 64-bit-only features are by definition
> unreachable from 32-bit code.
> 
> It's possible it might not get you 100% absolutely an identical thing
> from the guest's point of view, but any deviations should be minor
> and I think we might consider them bugs.
> 
> There are some minor UI-level things relating to CPU properties,
> e.g. "qemu-system-arm -cpu max,sve=on" gives a property not found
> error, but "qemu-system-aarch64 -cpu max-v8,aarch64=off,sve=on"
> will run (with no visible difference to the guest since SVE
> is AArch64 only). It probably ought to error out complaining
> that you've asked for two things that conflict, but this is
> "minor bug" I think.

Ok, in that case I'd agree aarch64 wouldn't need to expose a
distinct 32-bit CPU model for max


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


