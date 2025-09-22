Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31FACAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cwJ-0006H4-NY; Mon, 22 Sep 2025 05:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0cvg-0005pW-Bk
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0cvb-0008FM-K2
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758533619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kuq+j5Hi/lkGDSxuuvFB8LuNDfhyiIxoeUAKJbC6eKI=;
 b=ZmGB1aTRHjba69vjDJZvtdJ9coHwEI8pEvA7f4I5oINaNYZr/98k4EHeOlytdpyS3ebUzW
 Qna6K3UvBZ3UrvnG5mtiRjMElIZFOtw43GABYrzzj8h0B+N48QeM05fu7/9wwRmRN7p42D
 aqkBsO/RxtyslUkHC8uzM3/qLTf/+3Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-y6-_Xn41MsWB_L4I1az4_w-1; Mon,
 22 Sep 2025 05:33:35 -0400
X-MC-Unique: y6-_Xn41MsWB_L4I1az4_w-1
X-Mimecast-MFC-AGG-ID: y6-_Xn41MsWB_L4I1az4_w_1758533613
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77B8B195608A; Mon, 22 Sep 2025 09:33:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CDDE3000198; Mon, 22 Sep 2025 09:33:30 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:33:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH v3 4/4] tests/functional: Adapt arches to
 reverse_debugging w/o Avocado
Message-ID: <aNEX5pgu8vwcMWhc@redhat.com>
References: <20250922054351.14289-1-gustavo.romero@linaro.org>
 <20250922054351.14289-5-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922054351.14289-5-gustavo.romero@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 22, 2025 at 05:43:51AM +0000, Gustavo Romero wrote:
> reverse_debugging no longer depends on Avocado, so remove the import
> checks for Avocado, the per-arch endianness tweaks, and the per-arch
> register settings. All of these are now handled in the ReverseDebugging
> class.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  .../functional/aarch64/test_reverse_debug.py  | 13 +++++--------
>  tests/functional/ppc64/test_reverse_debug.py  | 15 +++++----------
>  tests/functional/x86_64/test_reverse_debug.py | 19 ++++++-------------
>  3 files changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
> index 8bc91ccfde..7f816025a9 100755
> --- a/tests/functional/aarch64/test_reverse_debug.py
> +++ b/tests/functional/aarch64/test_reverse_debug.py
> @@ -1,26 +1,23 @@
> -#!/usr/bin/env python3

Please don't remove this - all the tests are expected to be directly
excecutable. (Same comment for the other files)

> -#
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for aarch64
>  #
>  # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>  #
>  # Author:
>  #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> -from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
> +from qemu_test import Asset, skipFlakyTest

>  from reverse_debugging import ReverseDebugging
>  
>  
> -@skipIfMissingImports('avocado.utils')
>  class ReverseDebugging_AArch64(ReverseDebugging):
>  
> -    REG_PC = 32
> -
>      ASSET_KERNEL = Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>           'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
> @@ -35,4 +32,4 @@ def test_aarch64_virt(self):
>  
>  
>  if __name__ == '__main__':
> -    ReverseDebugging.main()
> +    ReverseDebugging_AArch64.main()
> diff --git a/tests/functional/ppc64/test_reverse_debug.py b/tests/functional/ppc64/test_reverse_debug.py
> index 5931adef5a..2b7b18e9a8 100755
> --- a/tests/functional/ppc64/test_reverse_debug.py
> +++ b/tests/functional/ppc64/test_reverse_debug.py
> @@ -1,41 +1,36 @@
> -#!/usr/bin/env python3
> -#
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for ppc64
>  #
>  # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>  #
>  # Author:
>  #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> -from qemu_test import skipIfMissingImports, skipFlakyTest
> +from qemu_test import skipFlakyTest
>  from reverse_debugging import ReverseDebugging
>  
>  
> -@skipIfMissingImports('avocado.utils')
>  class ReverseDebugging_ppc64(ReverseDebugging):
>  
> -    REG_PC = 0x40
> -
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
>      def test_ppc64_pseries(self):
>          self.set_machine('pseries')
>          # SLOF branches back to its entry point, which causes this test
>          # to take the 'hit a breakpoint again' path. That's not a problem,
>          # just slightly different than the other machines.
> -        self.endian_is_le = False
>          self.reverse_debugging()
>  
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
>      def test_ppc64_powernv(self):
>          self.set_machine('powernv')
> -        self.endian_is_le = False
>          self.reverse_debugging()
>  
>  
>  if __name__ == '__main__':
> -    ReverseDebugging.main()
> +    ReverseDebugging_ppc64.main()
> diff --git a/tests/functional/x86_64/test_reverse_debug.py b/tests/functional/x86_64/test_reverse_debug.py
> index d713e91e14..408e5d1f48 100755
> --- a/tests/functional/x86_64/test_reverse_debug.py
> +++ b/tests/functional/x86_64/test_reverse_debug.py
> @@ -1,36 +1,29 @@
> -#!/usr/bin/env python3
> -#
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for x86_64
>  #
>  # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>  #
>  # Author:
>  #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> -from qemu_test import skipIfMissingImports, skipFlakyTest
> +from qemu_test import skipFlakyTest
>  from reverse_debugging import ReverseDebugging
>  
>  
> -@skipIfMissingImports('avocado.utils')
>  class ReverseDebugging_X86_64(ReverseDebugging):
>  
> -    REG_PC = 0x10
> -    REG_CS = 0x12
> -    def get_pc(self, g):
> -        return self.get_reg_le(g, self.REG_PC) \
> -            + self.get_reg_le(g, self.REG_CS) * 0x10
> -
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2922")
>      def test_x86_64_pc(self):
>          self.set_machine('pc')
> -        # start with BIOS only
> +        # Start with BIOS only
>          self.reverse_debugging()
>  
>  
>  if __name__ == '__main__':
> -    ReverseDebugging.main()
> +    ReverseDebugging_X86_64.main()
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


