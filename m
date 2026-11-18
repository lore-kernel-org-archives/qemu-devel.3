Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBC606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=gVGeb8Ox
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTljU-00044o-CV; Wed, 18 Nov 2026 14:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xTljQ-00044Y-Qg
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 14:54:13 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xTljO-00081E-Lf
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 14:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795031644; bh=4GD85oV1/8tbNlEh0p+OrMQayb1ng/MyRJlzpeEnbOc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gVGeb8Oxz2lAGxqBzNSeqiQfaG8PBpoBJh6e/z8ZmTH6gRdnW1xeAOATavWoFJcCk
 RJtawP3ikNuqXsTeszOdEWpHxPFlIYJeR/ktV7bRySscoo8rz48y1up+jSHOsUO+MO
 rF8e/pFiuyLJgwu4SQqGB52DFo6qs8nzs28OVll0f23kIHRfp0nz7XHxhXNsZXHj2k
 d7HkcKjajY0TjnwUT1pWuEDUduJOMYAPCUpEWF568Wh3lW5ekLyE14j67fgFwEa9HI
 n1N0QZkBqK7yR5igGpFCiAZVEb7qsLHuk4ondarC+Qbam4BAK78li2ijv9Eek1Gbvb
 oeEbXWcYWTxGQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 35DD71E7C1E;
 Wed, 18 Nov 2026 22:54:04 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 10D0646126A;
 Wed, 18 Nov 2026 22:54:04 +0300 (MSK)
Message-ID: <217e62c3-69fd-4c82-8f12-2629ea57700b@tls.msk.ru>
Date: Wed, 18 Nov 2026 22:54:03 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] roms: record the H2 commit in a file
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261118171410.3753915-1-brian.cain@oss.qualcomm.com>
 <20261118171410.3753915-2-brian.cain@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261118171410.3753915-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 20:14, Brian Cain wrote:
> The H2 build ID was derived by running `git rev-parse`, which fails when
> building from a source tarball.  Leaving H2K_GIT_COMMIT as "0x" does
> not compile.
> 
> Instead, keep the commit in a tracked file and always build from it.
> When the submodule is checked out, fail the H2 build if its HEAD does
> not match the recorded commit, so a submodule update without a matching
> update of the file is caught.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Thank you for the work and the update!

/mjt

>   MAINTAINERS                     |  1 +
>   roms/Makefile                   | 22 ++++++++++++++++++----
>   roms/hexagon-hypervisor-version |  1 +
>   3 files changed, 20 insertions(+), 4 deletions(-)
>   create mode 100644 roms/hexagon-hypervisor-version
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15942aaba3a..c6ed3469779 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1400,6 +1400,7 @@ F: tests/qtest/qcom-dsp-test.c
>   F: docs/devel/hexagon-sys.rst
>   F: pc-bios/hexagon*
>   F: roms/hexagon-hypervisor
> +F: roms/hexagon-hypervisor-version
>   
>   LoongArch Machines
>   ------------------
> diff --git a/roms/Makefile b/roms/Makefile
> index bae8f3b766b..bcde6835851 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -226,11 +226,25 @@ hexagon_h2_booters := hexagon-booter-qcs6490-cdsp \
>   hexagon_h2_loadlinux := hexagon-loadlinux-qcs6490-cdsp \
>   	hexagon-loadlinux-sm8975-nsp hexagon-loadlinux-sa8775p-cdsp \
>   	hexagon-loadlinux-sc8480xp-nsp0 hexagon-loadlinux-sa8797p-nsp0
> +include hexagon-hypervisor-version
> +
> +.PHONY: hexagon-hypervisor-check
> +hexagon-hypervisor-check:
> +	@if test -e hexagon-hypervisor/.git; then \
> +		h2_head=$$(git -C hexagon-hypervisor rev-parse HEAD); \
> +		if test "$$h2_head" != "$(H2K_COMMIT)"; then \
> +			echo "hexagon-hypervisor is at $$h2_head, but" \
> +				"roms/hexagon-hypervisor-version has" \
> +				"$(H2K_COMMIT)" >&2; \
> +			exit 1; \
> +		fi; \
> +	fi
> +
>   hexagon_h2_common_flags = USE_PKW=0 TARGET=opt NULL_ANGEL_TRAP=1 \
>   	HMX_HLX_SUPPORT=1 \
>   	H2K_LOAD_ADDR=0x9b800000 H2K_GUEST_START=0xa2000000 \
> -	H2K_GIT_COMMIT=0x$(shell git -C hexagon-hypervisor rev-parse --short=8 HEAD) \
> -	H2K_GIT_COMMIT_LONG=0x$(shell git -C hexagon-hypervisor rev-parse HEAD) \
> +	H2K_GIT_COMMIT=0x$(shell echo $(H2K_COMMIT) | cut -c1-8) \
> +	H2K_GIT_COMMIT_LONG=0x$(H2K_COMMIT) \
>   	JFLAG=-j$(shell nproc)
>   
>   .PHONY: hexagon-qcs6490-cdsp hexagon-sm8975-nsp \
> @@ -264,7 +278,7 @@ hexagon-loadlinux-sm8975-nsp hexagon-loadlinux-sa8775p-cdsp \
>   	hexagon-loadlinux-sc8480xp-nsp0 hexagon-loadlinux-sa8797p-nsp0: \
>   	hexagon_h2_linux_flags = LINUX_LINK_ADDR=0xa0000000
>   
> -$(hexagon_h2_booters): hexagon-booter-%:
> +$(hexagon_h2_booters): hexagon-booter-%: hexagon-hypervisor-check
>   	rm -rf $(hexagon_h2_out)/booter-$*
>   	$(MAKE) -C hexagon-hypervisor $(hexagon_h2_common_flags) \
>   		$(hexagon_h2_machine_flags) \
> @@ -273,7 +287,7 @@ $(hexagon_h2_booters): hexagon-booter-%:
>   		$(hexagon_h2_build)/booter-$*/install/bin/booter
>   	chmod -x ../pc-bios/hexagon_booter_$(subst -,_,$*)
>   
> -$(hexagon_h2_loadlinux): hexagon-loadlinux-%:
> +$(hexagon_h2_loadlinux): hexagon-loadlinux-%: hexagon-hypervisor-check
>   	rm -rf $(hexagon_h2_out)/loadlinux-$*
>   	$(MAKE) -C hexagon-hypervisor $(hexagon_h2_common_flags) \
>   		$(hexagon_h2_machine_flags) \
> diff --git a/roms/hexagon-hypervisor-version b/roms/hexagon-hypervisor-version
> new file mode 100644
> index 00000000000..4aeabdc7d0e
> --- /dev/null
> +++ b/roms/hexagon-hypervisor-version
> @@ -0,0 +1 @@
> +H2K_COMMIT = 23d5bde4313c1e63ba64dd5d7f542b1055188ef8


