Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E585C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmqv-0007Oe-UR; Tue, 16 Jul 2024 14:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmqs-0007GV-Nb
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmqq-0003w9-Rt
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721154276;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vnDZkv+3/JXy6MzG92pmYyUBBWm3Ns1PcH/s34KunFM=;
 b=feAtFcfIH9hG37RsVwEJ/FPpaYb6p3DZOGTGgaGJA4x7lk4rx6Ga6ZFS0RE3AmVqikp2hm
 itmmfW1jpicJ0eHZkhnAgrv2FkcBanIeG0bXjzdZrfwrXBjAxkxBSe/5ZL4guwE7j+trsj
 CkqTXi7xer6DXyD44bepCkZdQ0RBUcY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-Llc49W9ZNSyqE91dnP_qeA-1; Tue,
 16 Jul 2024 14:24:29 -0400
X-MC-Unique: Llc49W9ZNSyqE91dnP_qeA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F08C1955D44; Tue, 16 Jul 2024 18:24:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4E131955D42; Tue, 16 Jul 2024 18:24:24 +0000 (UTC)
Date: Tue, 16 Jul 2024 19:24:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 10/11] tests/functional: Convert the s390x avocado tests
 into standalone tests
Message-ID: <Zpa61bWr-ojr50Vi@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <20240716112614.1755692-11-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240716112614.1755692-11-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 16, 2024 at 01:26:13PM +0200, Thomas Huth wrote:
> These tests use archive.lzma_uncompress() from the Avocado utils,
> so provide a small helper function for this, based on the
> standard lzma module from Python instead.
> 
> And while we're at it, replace the MD5 hashes in the topology test
> with proper SHA256 hashes, since MD5 should not be used anymore
> nowadays.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                   |  4 +-
>  tests/functional/meson.build                  |  6 ++
>  tests/functional/qemu_test/utils.py           |  7 ++
>  .../test_s390x_ccw_virtio.py}                 | 32 ++++-----
>  .../test_s390x_topology.py}                   | 70 +++++++------------
>  5 files changed, 52 insertions(+), 67 deletions(-)
>  rename tests/{avocado/machine_s390_ccw_virtio.py => functional/test_s390x_ccw_virtio.py} (95%)
>  mode change 100644 => 100755
>  rename tests/{avocado/s390_topology.py => functional/test_s390x_topology.py} (90%)
>  mode change 100644 => 100755
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 025227954c..cbefb6fb81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1739,7 +1739,7 @@ S: Supported
>  F: hw/s390x/
>  F: include/hw/s390x/
>  F: configs/devices/s390x-softmmu/default.mak
> -F: tests/avocado/machine_s390_ccw_virtio.py
> +F: tests/functional/test_s390x_ccw_virtio.py
>  T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
> @@ -1802,7 +1802,7 @@ F: hw/s390x/cpu-topology.c
>  F: target/s390x/kvm/stsi-topology.c
>  F: docs/devel/s390-cpu-topology.rst
>  F: docs/system/s390x/cpu-topology.rst
> -F: tests/avocado/s390_topology.py
> +F: tests/functional/test_s390x_topology.py
>  
>  X86 Machines
>  ------------
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index c8fc9f6c07..f6de9af8a2 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -13,6 +13,7 @@ endif
>  test_timeouts = {
>    'netdev_ethtool' : 180,
>    'ppc_74xx' : 90,
> +  's390x_ccw_virtio' : 180,
>  }
>  
>  tests_generic = [
> @@ -47,6 +48,11 @@ tests_ppc_thorough = [
>    'ppc_bamboo',
>  ]
>  
> +tests_s390x_thorough = [
> +  's390x_ccw_virtio',
> +  's390x_topology',
> +]
> +
>  tests_sparc64_thorough = [
>    'sparc64_sun4u',
>  ]
> diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
> index 4eb5e5d5e5..8115d9d1da 100644
> --- a/tests/functional/qemu_test/utils.py
> +++ b/tests/functional/qemu_test/utils.py
> @@ -8,6 +8,8 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> +import lzma
> +import shutil
>  import tarfile
>  
>  def archive_extract(archive, dest_dir, member=None):
> @@ -19,3 +21,8 @@ def archive_extract(archive, dest_dir, member=None):
>              tf.extract(member=member, path=dest_dir)
>          else:
>              tf.extractall(path=dest_dir)
> +
> +def lzma_uncompress(xz_path, output_path):
> +    with lzma.open(xz_path, 'rb') as lzma_in:
> +        with open(output_path, 'wb') as raw_out:
> +            shutil.copyfileobj(lzma_in, raw_out)

Avocado short-circuited if output_path already existed
for speed. Worth doing the same.

The inner 'with' should be surrounded by a try/except
that does os.remove(output_path) on error. Avocado
didn't have this safety net either, but we should add
it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


