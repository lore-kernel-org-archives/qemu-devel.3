Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2F4C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1eB8-0006cN-9t; Wed, 02 Sep 2026 02:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1eB6-0006bq-S8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:10:32 -0400
Received: from smtpout2.mo538.mail-out.ovh.net ([51.210.91.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1eB3-0002zZ-SS
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:10:32 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hZXQT3Q4Dz5vZC;
 Wed,  2 Sep 2026 06:10:25 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed,  2 Sep 2026 06:10:25 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.77])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hZXQT2khnz6MbL;
 Wed,  2 Sep 2026 06:10:25 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 40E56203FDB; 
 Wed,  2 Sep 2026 06:10:23 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004fe92f47e-db1d-4019-99d8-f2d50423713f,
 E05C9764BA5542D7874F2BFBE20C1A6231857223) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8b49306d-b767-4d80-a4de-bf492e646138@kaod.org>
Date: Wed, 2 Sep 2026 08:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Add ECDSA akcipher support and the ASPEED SBC
 ECDSA engine for AST10x0
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13677713544579558445
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGyVfh0oo5tsmvl8dId4WGuM94nMRbhQElUiOrN/jbPxJaDgSfXvzOj36c9yiKcVMUNPDP/bnjKmI3jn2zUB5vaNjemuKSLH+jViGLj8Q0fW6KFqZ+IOVMAH3HESfNxYm6FZnoAonSnoTVyBo+Ih79EeL2nwnKkZAoPpzmU4L7KnL94CjKxv1czB052V9FFtZu1YOTeOo6f+rmnYXRe+2YQiUwYDxjXQZZ1mh7M70LQ7DguKGgHrUCaXgXDCoOJZEI419neoC7hR4HDV0YWor5wAkKR/w+gViT7p+NIDM7cLVBzCb5vvXrIMCvjXb71kpx3gbk2zA3Ld7Px5Hku5s6imkJBI9WTTapvgln8kJXQL6eHExDpchGPbezNok9uv8cMeWgMlusvIqQ1bJiIGa845fiiflZmPQzCcGvSg0WC1ODORhlWoj9tLemWnXfIAsMh/hTKn/jwmNu3OBUziR/WrI4N8l/c/XZppE3GnVmCMSf3ykD0JeDj70T5/jegoveRgtkGLzxnn/pwFbM0Q1IKfy6Jw007HyGDxsltSXCxx4yeStpuG5bY+jEMCbu6o1GfiiPyOlmkcP883/BFUJpFhIWquNsi9NZn8D5RpbHIAbWdAYvwKBt+YYVA65Sy4RWJW+xD43XJ2EY3g7vS+ZwHTcq6qWH2AA/MdrsWXmiFHQ
DKIM-Signature: a=rsa-sha256; bh=qXeEYmdq+fv9GR9jc2xTGC+4M1iZskHC1ufE+rb/9/M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788329426; v=1;
 b=KQsQJwQ46LIeuPIoZHIgL0hoejnXWam1D5VGqrS+WeArky7nWUvDvtcRGhc7DA7V5/cOZAVc
 9RWxHYEjyCS2xGRpGIRkUMFlMLtozcefLGnG8czsHFnVXxawZ/GXEnZ8xDCKdZGsNf/S2nYVIHW
 +q0a/Zfor2BbGEPdZFesInEpXO/xUhRUvOWbVm7r3C7kq1HaZ7jnys6B3tqxxJ7EQbuIXHz6JwV
 io8EcQJJUPm2C9o4NzNvTvNkROWjJUsOXXTXIWArIuq8k/5Tu+0RKb3FCIlRx6IiCNEmSYlNUVW
 PThqWxqg2NQLBovmzJHuKPAs6iHSY1GNgz2ekoSNheJiA==
Received-SPF: pass client-ip=51.210.91.31; envelope-from=clg@kaod.org;
 helo=smtpout2.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/1/26 10:52, Jamin Lin wrote:
> This series depends on:
> 
>   1. [v4,0/4] Add ASPEED ACRY RSA model for the AST2600
>      https://patchwork.kernel.org/project/qemu-devel/cover/20260901081531.898176-1-jamin_lin@aspeedtech.com/
> 
> This series adds ECDSA to the QEMU crypto akcipher framework and models the
> ASPEED AST10x0 secure boot controller (SBC) ECDSA engine on top of it.
> 
> The crypto side adds ECDSA sign/verify for prime256v1 (NIST P-256) and
> secp384r1 (NIST P-384) in both the gcrypt and nettle backends, using the raw
> big-endian form (public key Qx || Qy, private key scalar d, signature r || s)
> with a pre-computed digest as input.
> 
> Both the AST2600 and the AST1030/AST1060 have a Secure Boot Controller (SBC)
> that supports RSA and ECDSA verification, but only the AST1030/AST1060 have an
> ECDSA verify engine, so this series models ECDSA only. RSA verification is used
> solely to verify the AST2600 SPL in ROM CODE, which ASPEED does not release,
> so it is very unlikely to be used by end users.
> 
> v1:
>   1. Add ECDSA akcipher support with gcrypt backend
>   2. Add ECDSA akcipher support with nettle backend
>   3. Add ECDSA sign/verify unit tests
>   4. Support the ECDSA verify command for AST10x0
>   5. Add ASPEED SBC ECDSA engine qtest
> 
> v2:
>   1. Wrap the SEC SRAM in a container mapped at offset 0 so the device
>      addresses it by relative offset (drop the "sram-base" property)
>   2. Add a patch removing the obsolete unimplemented SBC mapping
>   3. Add Qtest to ast1060-evb machine.
>   4. Rename R_ECDSA_CMD to R_SEC_TRIGGER, since the register
>      triggers both the RSA and ECDSA engines.
> 
> v3:
>   1. fix typo
>   2. Replace g_printerr with g_test_skip
> 
> v4:
>    1. Reorder the patches to fix a QEMU startup failure at an intermediate commit.
>    2. Add public key type validation for ECDSA verification.
>    3. Add private key type validation for ECDSA signing.
>    4. Remove sbc_unimplemented from AspeedSoCState
>    5. Update the commit messages.
> 
> Jamin Lin (9):
>    qapi/crypto: Add ECDSA algorithm and curve id
>    crypto/akcipher: Support ECDSA sign/verify with gcrypt
>    crypto/akcipher: Support ECDSA sign/verify with nettle
>    tests/crypto: Add ECDSA sign/verify tests
>    hw/arm/aspeed_ast10x0: Remove obsolete unimplemented SBC mapping
>    hw/misc/aspeed_sbc: Increase register space to 0x1000
>    hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model
>    hw/misc/aspeed_sbc: Support the ECDSA verify command
>    tests/qtest: Add ASPEED SBC ECDSA engine test
> 
>   qapi/crypto.json                  |  33 ++-
>   include/hw/arm/aspeed_soc.h       |   1 -
>   include/hw/misc/aspeed_sbc.h      |   6 +-
>   hw/arm/aspeed_ast10x0.c           |  14 +-
>   hw/misc/aspeed_sbc.c              | 158 +++++++++++++-
>   tests/qtest/aspeed-sbc-test.c     | 194 +++++++++++++++++
>   tests/unit/test-crypto-akcipher.c | 236 +++++++++++++++++++++
>   crypto/akcipher-gcrypt.c.inc      | 340 +++++++++++++++++++++++++++++-
>   crypto/akcipher-nettle.c.inc      | 272 ++++++++++++++++++++++++
>   hw/misc/trace-events              |   2 +
>   tests/qtest/meson.build           |   2 +
>   11 files changed, 1242 insertions(+), 16 deletions(-)
>   create mode 100644 tests/qtest/aspeed-sbc-test.c
> 

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


