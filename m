Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AF8C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz97B-0004gp-Bv; Wed, 26 Aug 2026 04:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wz979-0004gX-Hs
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wz977-0000Lu-KL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787733364;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRyKuU93pUs5bcTVPRv81kic/LbNCDXi4qC2i6YptPA=;
 b=Vz0EnauQqK81/V69vE2R/h7lRsAuCz2BHJtDTlb3cb8msK5CipkW9PmcUwav4XLRjrswfa
 yw/O4GF1QK2/nJKZ01MdKjyF93sE35ZawCZaBQsHA5wSvnnbthiCedA8U3TaRirCoQerPh
 HgAsTYVdGnH+Tagas7qisSe65UrZwI4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-BXgcbgOSNtCjl8o8QxBQdg-1; Wed,
 26 Aug 2026 04:36:00 -0400
X-MC-Unique: BXgcbgOSNtCjl8o8QxBQdg-1
X-Mimecast-MFC-AGG-ID: BXgcbgOSNtCjl8o8QxBQdg_1787733359
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9742118A696A; Wed, 26 Aug 2026 08:35:58 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BE837D6; Wed, 26 Aug 2026 08:35:54 +0000 (UTC)
Date: Wed, 26 Aug 2026 09:35:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Warner Losh <imp@bsdimp.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 02/16] tests: update libvirt-ci, lcitool
Message-ID: <ao6lZ9FXK_wgXmUm@redhat.com>
References: <20260825215851.1780608-1-jsnow@redhat.com>
 <20260825215851.1780608-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260825215851.1780608-3-jsnow@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 25, 2026 at 05:58:37PM -0400, John Snow wrote:
> Update libvirt-ci to current origin/master for the primary sake of
> grabbing new mappings for FreeBSD, which has upgraded from Python 3.11
> to 3.12 and along with it changed the name of their python ecosystem
> packages.
> 
> Refresh the lcitool generated files to fix our FreeBSD tests.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/dockerfiles/debian-amd64-cross.docker   |  2 +-
>  tests/docker/dockerfiles/debian-arm64-cross.docker   |  2 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker   |  2 +-
>  tests/docker/dockerfiles/debian-i686-cross.docker    |  2 +-
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker |  2 +-
>  tests/docker/dockerfiles/debian-riscv64-cross.docker |  2 +-
>  tests/docker/dockerfiles/debian-s390x-cross.docker   |  2 +-
>  tests/docker/dockerfiles/debian.docker               |  2 +-
>  tests/docker/dockerfiles/opensuse-leap.docker        |  2 +-
>  tests/docker/dockerfiles/ubuntu2404.docker           |  2 +-
>  scripts/ci/setup/debian/debian-13-ppc64le.yaml       |  2 +-
>  scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml     |  2 +-
>  scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml       |  2 +-
>  tests/lcitool/libvirt-ci                             |  2 +-
>  tests/vm/generated/freebsd.json                      | 12 ++++++------
>  15 files changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


