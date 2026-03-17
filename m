Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9200FED9E6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2WJJ-0006OE-Tt; Tue, 17 Mar 2026 11:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2WJC-0006IL-N9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2WJ9-0006rA-Cw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773761169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6iw+KvFviR21IQj8AqbAhFEOiE/vSwQ50CVPhbUBL4=;
 b=c6KOMU2lJIn1TKpCyTL5CxEe3bZoOXiAToxIUU88TyGZWwIE/PQxZWKCpGy35spaRCCS9U
 Xjx2y79NIDm6PTD2dDQV8Cx44Wrp9SOft2UJGRCfS58/OiGU+lkClRzrYjYjs4Dt5a7MNx
 M21krf/uertIaPJDy8pykd+lC0+ZLb8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-g6ojhI9RNeiczB7rIWed4A-1; Tue,
 17 Mar 2026 11:26:05 -0400
X-MC-Unique: g6ojhI9RNeiczB7rIWed4A-1
X-Mimecast-MFC-AGG-ID: g6ojhI9RNeiczB7rIWed4A_1773761164
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55E2A1955BCE; Tue, 17 Mar 2026 15:26:04 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.252])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1B5E1800351; Tue, 17 Mar 2026 15:26:02 +0000 (UTC)
Date: Tue, 17 Mar 2026 15:25:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/3] tests/lcitool: Update openSUSE to version 16
Message-ID: <ablyhiGvPb4-qCZx@redhat.com>
References: <20260316135407.209072-1-thuth@redhat.com>
 <20260316135407.209072-3-thuth@redhat.com>
 <877brbomx1.fsf@draig.linaro.org>
 <b4db6dcf-a55c-4c11-bae7-c19f8f03d755@redhat.com>
 <87jyvacwmr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyvacwmr.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 17, 2026 at 03:18:36PM +0000, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 16/03/2026 15.43, Alex Bennée wrote:
> >> Thomas Huth <thuth@redhat.com> writes:
> >> 
> >>> From: Thomas Huth <thuth@redhat.com>
> >>>
> >>> The first version of openSUSE 15 has been released in 2018, and
> >>> according to our support policy, we "support the most recent major
> >>> version at all times for up to five years after its initial release."
> >>>
> >>> Since openSUSE 16 has been released a while ago, and openSUSE is
> >>> clearly older than 5 years already, it's time to update to version 16
> >>> now.
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>   configure                  |  1 -
> >>>   tests/lcitool/mappings.yml | 58 --------------------------------------
> >>>   tests/lcitool/refresh      |  2 +-
> >>>   3 files changed, 1 insertion(+), 60 deletions(-)
> >>>
> >>> diff --git a/configure b/configure
> >>> index cd1dadd8bb2..f3603fd9160 100755
> >>> --- a/configure
> >>> +++ b/configure
> >>> @@ -929,7 +929,6 @@ if ! check_py_version "$python"; then
> >>>     error_exit "Cannot use '$python', Python >= 3.9 is required." \
> >>>                "Use --python=/path/to/python to specify a supported Python." \
> >>>                "Maybe try:" \
> >>> -             "  openSUSE Leap 15.3+: zypper install python39" \
> >>>                "  CentOS: dnf install python3.12"
> >>>   fi
> >>>   diff --git a/tests/lcitool/mappings.yml
> >>> b/tests/lcitool/mappings.yml
> >>> index 60618971584..62fe60d047f 100644
> >>> --- a/tests/lcitool/mappings.yml
> >>> +++ b/tests/lcitool/mappings.yml
> >>> @@ -3,70 +3,17 @@ mappings:
> >>>     bindgen:
> >>>       Ubuntu2204:
> >>>   -  flake8:
> >>> -    OpenSUSELeap15:
> >>> -
> >>>     meson:
> >>> -    OpenSUSELeap15:
> >>>       # Use Meson from PyPI wherever Rust is enabled
> >>>       Debian:
> >>>       Fedora:
> >>>       Ubuntu:
> >>>   -  python3:
> >>> -    OpenSUSELeap15: python311-base
> >>> -
> >>> -  python3-PyYAML:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-devel:
> >>> -    OpenSUSELeap15: python311-devel
> >>> -
> >>> -  python3-docutils:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-numpy:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-opencv:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-pillow:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-pip:
> >>> -    OpenSUSELeap15: python311-pip
> >>> -
> >>> -  python3-pillow:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-selinux:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-setuptools:
> >>> -    OpenSUSELeap15: python311-setuptools
> >>> -
> >>> -  python3-sphinx:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-sphinx-rtd-theme:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-sqlite3:
> >>> -    OpenSUSELeap15: python311
> >>> -
> >>>     python3-tomli:
> >>>       # test using tomllib
> >>>       apk:
> >>>       Fedora:
> >>>       Debian12:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  python3-venv:
> >>> -    OpenSUSELeap15: python311-base
> >>> -
> >>> -  python3-wheel:
> >>> -    OpenSUSELeap15: python311-wheel
> >>>       rust:
> >>>       Debian12: rustc-web
> >>> @@ -79,12 +26,7 @@ pypi_mappings:
> >>>       default: meson==1.8.1
> >>>       # Drop packages that need devel headers
> >>> -  python3-numpy:
> >>> -    OpenSUSELeap15:
> >>> -
> >>> -  # see above
> >>>     python3-tomli:
> >>>       apk:
> >>>       Fedora:
> >>>       Debian12:
> >>> -    OpenSUSELeap15:
> >> I'm unsure about the mappings stuff just because I'm not sure what
> >> it is
> >> for. Does it supplement the mappings in libvirt-ci itself?
> >
> > Yes, that's how I understood it. Since this is just an extension to
> > the mappings from libvirt-ci, I think we can safely remove those
> > mappings on the QEMU side now.
> 
> Ahh ok - I've always been waiting for the libvirt-ci MRs to go through.

That's the right approach in general. This qemu local mappings.yml
file was just for some QEMU specific overrides that are not appropriate
for upstream libvirt-ci.git  mappings. Ideally we should rarely, or even
never, use the local mappings as that tends to defeat the benefit of
sharing the info across many projects.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


