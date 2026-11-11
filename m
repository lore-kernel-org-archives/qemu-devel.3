Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8852A606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=b/pm1vnK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3P1-0001Qn-Bh; Wed, 11 Nov 2026 03:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xR3Ox-0001QR-Ah
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 03:09:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xR3Ov-0007Pd-1c
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 03:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794384585; bh=mcpJ56LhgPWVdNtC5u2VHpPfVtxXjy8XUf6u8/7jVRg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=b/pm1vnK5023BEqw9Kc7zhopv00yHYfi40Mpxc+98Kq27ZWAwafcBzUtaul0Dl9ab
 toE0wZs9MF1MjGoWokaVuSCcnP55gWj8IqcwZExeYd2vo8Jh/xrSLxzYiBRB7K4u7l
 e2lQ9TPH7yh3/K5dEVoxR/XCuYPG3cPmnFcpIF4xLLQVCYSve/iMPNul9UOADZCcp9
 S2mEasyoRUzceyeIiinOpS1bKUg436x0eKhUHMnMiPHsc6Q5eaUSnH7IFr7NksiCVF
 wB9qS/4TpYEPE3QGDiIe14cJakprg/jgS39LsQvgKQW958rC8NQYg+0z27rgNIio6D
 od3x1V36eDe3Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3CA4A1E5519;
 Wed, 11 Nov 2026 11:09:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3157E458CAF;
 Wed, 11 Nov 2026 11:09:45 +0300 (MSK)
Message-ID: <4e004471-b8e2-498f-8c8b-19f0983f7082@tls.msk.ru>
Date: Wed, 11 Nov 2026 11:09:45 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] roms: add H2 firmware support
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261024180657.2036255-1-brian.cain@oss.qualcomm.com>
 <20261024180657.2036255-2-brian.cain@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261024180657.2036255-2-brian.cain@oss.qualcomm.com>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 21:06, Brian Cain wrote:

> --- a/roms/Makefile
> +++ b/roms/Makefile

> +# Needs Hexagon SDK on PATH.
> +hexagon_h2_build := hexagon-firmware-build
> +hexagon_h2_src := $(CURDIR)/hexagon-hypervisor
> +hexagon_h2_out = $(CURDIR)/$(hexagon_h2_build)
> +hexagon_h2_booters := hexagon-booter-qcs6490-cdsp \
> +	hexagon-booter-sm8975-nsp hexagon-booter-sa8775p-cdsp \
> +	hexagon-booter-sc8480xp-nsp0 hexagon-booter-sa8797p-nsp0
> +hexagon_h2_loadlinux := hexagon-loadlinux-qcs6490-cdsp \
> +	hexagon-loadlinux-sm8975-nsp hexagon-loadlinux-sa8775p-cdsp \
> +	hexagon-loadlinux-sc8480xp-nsp0 hexagon-loadlinux-sa8797p-nsp0
> +hexagon_h2_common_flags = USE_PKW=0 TARGET=opt NULL_ANGEL_TRAP=1 \
> +	HMX_HLX_SUPPORT=1 \
> +	H2K_LOAD_ADDR=0x9b800000 H2K_GUEST_START=0xa2000000 \
> +	H2K_GIT_COMMIT=0x$(shell git -C hexagon-hypervisor rev-parse --short=8 HEAD) \
> +	H2K_GIT_COMMIT_LONG=0x$(shell git -C hexagon-hypervisor rev-parse HEAD) \
> +	JFLAG=-j$(shell nproc)

Can we get rid of the git thing here please?

When a user downloads tarball from qemu download area and extracts it,
there's no git repository in there.  So the above `git rev-parse` fails.

I dunno if there should be official releases for the hexagon firmware or
we can create a file with some version string inside the subdir and use it
if exists (as we've done previously for some other roms, for exactly the
same reason).  But the current version is not good :)

(Testing 11.2.0-rc0 as a tarball, and noticed this immediately ;)

Thanks,

/mjt

