Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E854FD262A7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 21:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJd5-0000P3-OJ; Tue, 20 Jan 2026 16:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viJd3-0000Ku-1F
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viJd0-0002k5-R1
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768945868;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBRUx4dw97YmqsXJNJgFtntmv+3fXVnqpHqrl3KuW4g=;
 b=hOYnbnVAWdTCYhkrVwnyijOKg4MQ+F2Ltz1C6GQDXc5pIB0Hz+BfpD3di0N9NxN07Tg8jS
 9E6iclPAOlQVUVRFo3GeaR9EDMooahC4wCpfxrht6yv/1TIyiJebhuxUfGCntyZkZPgNQG
 WHA4aXlxo84A4uadCBnbfRQJia4B8Dk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-f3THEO9YOKeWJhRRRGSdeQ-1; Tue,
 20 Jan 2026 16:51:04 -0500
X-MC-Unique: f3THEO9YOKeWJhRRRGSdeQ-1
X-Mimecast-MFC-AGG-ID: f3THEO9YOKeWJhRRRGSdeQ_1768945863
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0533F195609D; Tue, 20 Jan 2026 21:51:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A411930001A2; Tue, 20 Jan 2026 21:50:57 +0000 (UTC)
Date: Tue, 20 Jan 2026 21:50:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <aW_4p65WIEuQO4UQ@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
> Hi Marc-André,
> I haven't seen discussion about the project ideas you posted, so I'll
> try to kick it off here for the mkosi idea here.
> 
> Thomas: Would you like to co-mentor the following project with
> Marc-André? Also, do you have any concerns about the project idea from
> the maintainer perspective?

The idea of being able to build test images is very attractive,
however, actual deployment of any impl will run into the same
constraint we've always had. If we host disk images, then we
have the responsibility to host the complete & corresponding
source. This is a significant undertaking that we've never been
wished to take on. IMHO publishing images in GitLab CI won't
satisfy the license requireemnts.


> === Reproducible Test Image Building with mkosi ===
> 
> '''Summary:''' Build minimal, reproducible test images for QEMU
> functional tests using mkosi, replacing ad-hoc pre-built assets with a
> standardized, maintainable build system.
> 
> QEMU's functional test suite (`tests/functional/`) relies on pre-built
> images fetched from various external sources including Debian
> archives, Fedora repositories, GitHub repositories (e.g.,
> qemu-ppc-boot, linux-build-test), Linaro artifacts, and others. While
> this approach works, it has several drawbacks:
> 
> * '''Reproducibility issues''': External sources may change,
> disappear, or serve different content over time
> * '''Opacity''': The exact build configuration of these images is
> often undocumented or unknown
> * '''Maintenance burden''': When images need updates (fixes, new
> features), there's no standardized process
> * '''Inconsistency''': Images come from different sources with varying
> quality, size, and configuration
> 
> This project proposes using mkosi to build minimal, reproducible test
> images directly from distribution packages. mkosi is a tool for
> building clean OS images from distribution packages, with excellent
> support for Fedora and other distributions. It should be able to
> produces deterministic outputs.
> 
> The Ouroboros has finally caught its tail: QEMU adopts mkosi for
> testing, while mkosi continues using QEMU to exist.
> 
> '''Project Goals:'''
> 
> # Create mkosi configurations for building minimal bootable images for
> x86_64 and aarch64 architectures using Fedora packages
> # Integrate with the existing Asset framework in
> `tests/functional/qemu_test/asset.py` to seamlessly use mkosi-built
> images alongside existing assets
> # Set up GitLab CI pipelines to automatically build, hash, and publish
> images when configurations change
> # Document the image building process including comparison with
> existing tuxrun/tuxboot assets (which remain out of scope for
> replacement)
> # Migrate selected tests from external pre-built images to mkosi-built
> equivalents
> 
> '''Links:'''
> * [https://wiki.qemu.org/Testing/Functional QEMU Functional Testing
> documentation]
> * [https://github.com/systemd/mkosi mkosi project]
> * [https://gitlab.com/qemu-project/qemu QEMU GitLab repository]
> * [https://www.qemu.org/docs/master/devel/testing.html QEMU Testing
> documentation]
> * [https://mkosi.systemd.io/ mkosi documentation]
> 
> '''Details:'''
> * Skill level: intermediate
> * Language: Python (test framework), Shell/mkosi configuration
> * Mentor: Marc-André Lureau <marcandre.lureau@redhat.com> (elmarco)
> * Thomas Huth ?
> * Suggested by: Marc-André Lureau
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


