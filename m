Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95609CFC52C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0I5c-0006Rs-CQ; Mon, 14 Oct 2024 06:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0I5V-0006R2-5K
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0I5Q-0002Kl-4S
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728900838;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5gKkCG6usCG+bfba3Xn2GCgK6CC1BB9xO0vJlMJdMY=;
 b=TAiIA1SuXH1B+K6AUZj0JEOwooK158eRs4aOjgz97hu75s4LmK9ZQk3zsXiT2Ot29iQsqx
 hmGh18aY04Vxhz4VCwoltDU4vg6bnGiwG7bzEjCiNxSy1MfNo78ACEYXufswQx174Zih9p
 HGjrNDlOV2OYM2AHgjzpyEemLf8r00A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-FfYTG9KvMP6tMvokbO93bg-1; Mon,
 14 Oct 2024 06:13:54 -0400
X-MC-Unique: FfYTG9KvMP6tMvokbO93bg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 477751956058; Mon, 14 Oct 2024 10:13:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 260E91955F42; Mon, 14 Oct 2024 10:13:46 +0000 (UTC)
Date: Mon, 14 Oct 2024 11:13:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/17] Convert the Avocado tuxrun tests into new
 functional tests
Message-ID: <Zwzu1c9urQ2vSy0I@redhat.com>
References: <20241011131937.377223-1-thuth@redhat.com>
 <87bjzoaura.fsf@draig.linaro.org>
 <7e8c6503-e56b-4a01-a1f8-945e3e0020d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e8c6503-e56b-4a01-a1f8-945e3e0020d1@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 14, 2024 at 08:12:39AM +0200, Thomas Huth wrote:
> On 13/10/2024 17.27, Alex Bennée wrote:
> > Thomas Huth <thuth@redhat.com> writes:
> > 
> > > This patch series converts the tests/avocado/tuxrun_baselines.py
> > > to the new functional test framework. While converting the sh4 test,
> > > I noticed that the Avocado test was completely broken, so I included
> > > a fix (revert) for that problem in this series, too.
> > 
> > How can I run them from meson? I don't see them in list (but make
> > check-functional works). Shouldn't I be able to do:
> > 
> >    ./pyvenv/bin/meson test qemu:func-thorough
> > 
> > ?
> 
> Did you regenerate the meson files before running this command?
> 
> Anyway, the "official" way to run the tests is:
> 
>  make check-functional
> 
> This should take care of
> 1) Regenerating the meson files if necessary
> 2) Precaching the assets if necessary
> 3) Running the tests

Or if you just want to run a single test, directly execute the python
file eg  ./tests/functional/testname.py

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


