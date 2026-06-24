Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9604CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRiq-0003iC-5F; Wed, 24 Jun 2026 13:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRio-0003hh-E5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRim-0006BY-Lz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782323347;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6hFrtTvVhuF0/dqY/dXfE5wyfYXbeqNh3zsMqCY128=;
 b=QwKhd1OhWb8A4TPFpRo+z9+9hre6h0P+86RXNyQRSSLnLljGFiLU5AHAvPLARil9yr+SL5
 jM+CvQJ2lxjvxsNVfc5+l+OmoIEy1rsK7foWnPvzc9vPVGhg1flrmMBBJ2LQ/hB+5kXjAA
 xONdraAl2jslzYOEnM67A64Pm37z3YM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-uEBQOXD2NUiYQmxkjsI9ZA-1; Wed,
 24 Jun 2026 13:49:01 -0400
X-MC-Unique: uEBQOXD2NUiYQmxkjsI9ZA-1
X-Mimecast-MFC-AGG-ID: uEBQOXD2NUiYQmxkjsI9ZA_1782323340
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AC0519560B3; Wed, 24 Jun 2026 17:49:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB79D3000239; Wed, 24 Jun 2026 17:48:57 +0000 (UTC)
Date: Wed, 24 Jun 2026 18:48:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 stefanha@gmail.com, Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH] tests/docker: add flex and bison to emsdk-wasm64-cross
Message-ID: <ajwYhu9lClShuhVj@redhat.com>
References: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
 <dd48e432-ab04-42e7-a88f-231d1c9d55fa@oss.qualcomm.com>
 <87wlvnj0qf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wlvnj0qf.fsf@draig.linaro.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, Jun 24, 2026 at 06:40:24PM +0100, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> 
> > On 24/6/26 07:48, Brian Cain wrote:
> >> The hexagon idef-parser requires flex and bison as host build
> >> tools.  Add them to the emsdk-wasm64-cross container image so that
> >> wasm64 builds including hexagon-softmmu can find them.
> >> Link:
> >> https://lore.kernel.org/qemu-devel/CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=z3w@mail.gmail.com/
> >> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >> ---
> >>   tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 ++
> >>   1 file changed, 2 insertions(+)
> >> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> >> b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> >> index 8a924816f92..5debbc77d08 100644
> >> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> >> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> >> @@ -19,7 +19,9 @@ ENV CXXFLAGS="$CFLAGS"
> >>   ENV LDFLAGS="-sWASM_BIGINT -sASYNCIFY=1 -L$TARGET/lib"
> >>   RUN apt-get update && apt-get install -y \
> >>       autoconf \
> >> +    bison \
> >>       build-essential \
> >> +    flex \
> >>       libglib2.0-dev \
> >>       libtool \
> >>       pkgconf \
> >
> > Maybe emsdk-wasm64 should have been added to lci-tool first.
> > (not your responsibility).
> 
> I don't think that will be easy on account of emsdk having to build a
> bunch of libraries to support building QEMU. If a distro provides a
> better cross environment for wasm64 then we could try.

Yeah, there's rather too much custom stuff going on in our emsdk
dockerfile to make it practical to add to lcitool.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


