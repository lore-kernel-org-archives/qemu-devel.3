Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0469C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUWW-0003PE-Gj; Mon, 24 Aug 2026 09:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUWU-0003Ol-4p
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUWS-0004o5-5h
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787577330;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcVgrSsFrY9I2yhyV2JU2elleFYAbRK6B39sRLcJjyw=;
 b=ewY7Sp8LwHyqZYnBf918f3GHqKpmx88qyyUUFoIdITcVM4xWuNkArFpxQX6XuvVqNSxNu1
 E8wWUQ/aNrGUdo0gCrnVkKYBbabYnVyqTxvO8lMOao8kTN9X67hdwUq23YAtKnlDeq+1G2
 Z0H8GgRQ2WG1FJgBcWdbP3QPLzag9TA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-xWHgN4a3NsSDmOp7tcMoBA-1; Mon,
 24 Aug 2026 09:15:28 -0400
X-MC-Unique: xWHgN4a3NsSDmOp7tcMoBA-1
X-Mimecast-MFC-AGG-ID: xWHgN4a3NsSDmOp7tcMoBA_1787577325
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19B751926B4C; Mon, 24 Aug 2026 13:14:55 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9C831800348; Mon, 24 Aug 2026 13:14:51 +0000 (UTC)
Date: Mon, 24 Aug 2026 14:14:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH 02/12] tests: add Python3.12 to centos9.docker
Message-ID: <aoxDyM6Ll4lC5KKJ@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-3-jsnow@redhat.com>
 <178755712683.3526866.11521669620152567935.b4-review@b4>
 <765ebb79-1ac9-4dc2-be13-db1884750bb1@redhat.com>
 <CAFn=p-Zhaxup8sCkaH_qUwzDHHtmecAzRc6uEgkyjoiH7RK2SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-Zhaxup8sCkaH_qUwzDHHtmecAzRc6uEgkyjoiH7RK2SA@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 24, 2026 at 09:09:03AM -0400, John Snow wrote:
> On Mon, Aug 24, 2026, 4:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 8/24/26 09:38, marcandre.lureau@redhat.com wrote:
> > >> While we recently upgraded to Python 3.11 for the CentOS 9 container,
> > >> upgrade it even further to Python 3.12.
> > >>
> > >> Signed-off-by: John Snow <jsnow@redhat.com>
> > >> Message-ID: <20260824052859.880475-3-jsnow@redhat.com>
> > >>
> > >> diff --git a/tests/docker/dockerfiles/centos9.docker
> > b/tests/docker/dockerfiles/centos9.docker
> > >> index 6f5c400c2db1..8bfce395f9d7 100644
> > >> --- a/tests/docker/dockerfiles/centos9.docker
> > >> +++ b/tests/docker/dockerfiles/centos9.docker
> > >> @@ -96,10 +96,10 @@ RUN dnf --quiet distro-sync -y && \
> > >>                   pkgconfig \
> > >>                   pulseaudio-libs-devel \
> > >>                   python3-tomli \
> > >> -                python3.11 \
> > >> -                python3.11-pip \
> > >> -                python3.11-setuptools \
> > >> -                python3.11-wheel \
> > >> +                python3.12 \
> > >> +                python3.12-pip \
> > >> +                python3.12-setuptools \
> > >> +                python3.12-wheel \
> > >>                   rdma-core-devel \
> > >>                   rust \
> > >>                   rust-std-static \
> > >> @@ -129,7 +129,7 @@ RUN dnf --quiet distro-sync -y && \
> > >>       ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
> > >>       ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
> > >>
> > >> -RUN /usr/bin/pip3.11 install \
> > >> +RUN /usr/bin/pip3.12 install \
> > >>                        numpy \
> > >>                        opencv-python \
> > >>                        sphinx \
> > >> @@ -139,7 +139,7 @@ ENV
> > CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
> > >>   ENV LANG="en_US.UTF-8"
> > >>   ENV MAKE="/usr/bin/make"
> > >>   ENV NINJA="/usr/bin/ninja"
> > >> -ENV PYTHON="/usr/bin/python3.11"
> > >> +ENV PYTHON="/usr/bin/python3.12"
> > >>   # As a final step configure the user (if env is defined)
> > >>   ARG USER
> > >>   ARG UID
> > >> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> > >> index 2b317e0a61c5..5c56e4aca1b0 100644
> > >> --- a/tests/lcitool/mappings.yml
> > >> +++ b/tests/lcitool/mappings.yml
> > >> @@ -4,16 +4,16 @@ mappings:
> > >>       Ubuntu2204:
> > >>
> > >>     python3:
> > >> -    CentOSStream9: python3.11
> > >> +    CentOSStream9: python3.12
> > >>
> > >>     python3-devel:
> > >> -    CentOSStream9: python3.11-devel
> > >> +    CentOSStream9: python3.21-devel
> > Or drop it altogether, it seems not to be needed?
> >
> > Paolo
> >
> 
> Hah! Oops. Surprised that worked, but it does tell us something, eh?

Yes:

$ git grep python3-devel tests/lcitool/projects/


tells us that 'python3-devel' is not referenced in our definition
for QEMU as a build-dep, so in turn we don't need a mapping for it.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


