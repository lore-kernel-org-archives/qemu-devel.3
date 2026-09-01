Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A38C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Nb6-0007Ad-Bt; Tue, 01 Sep 2026 08:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1Nb4-0007A8-Sq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:28:14 -0400
Received: from smtpout10.mo538.mail-out.ovh.net ([51.210.91.39])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1Nb2-0004fx-Ka
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:28:14 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hZ4rl74cJz67BQ;
 Tue,  1 Sep 2026 12:28:07 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 12:28:07 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.120])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hZ4rl3PCrz1xss;
 Tue,  1 Sep 2026 12:28:07 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 460F81923FA3; Tue,  1 Sep 2026 12:28:05 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003a74d813b-bc5d-4004-8749-ce3c00659c12,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f3b4305d-802f-4edf-8e95-f143dd6f19fb@kaod.org>
Date: Tue, 1 Sep 2026 14:28:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add ASPEED ACRY RSA model for the AST2600
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260901081531.898176-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260901081531.898176-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14183805553972522029
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEClX8cXBR6RA2DFJGGQcFrLRBJDwhxGu9ncLjXzDeJ+SyF2fjmSap2Ik/uoscOdPwSbngZrBOa1HUbQHpEPd+7cUn7Wkewny9P8TBriu3LScAHBJdgFkxoVuhifWu0arjIK4Q66QGtdGGZoHDtF2DaYS2dTAVa7cx7yg145E/AmBTPfHsvhe50xwQXTkU2Rk1OelMVkbaWXjACzlgpVtZ10+3/hSGss6OBIQQrclVENyT5u1bImcX+LODXQxIZCezN5JfnghJwLAPUyWJ/pNIx/F2lDnnyYhQIFMVnFcnQIzqK0kc5yl3z5GveX39JMyGlyF6HEWnuC++nqiIYjFhxEmMgZAyyQeGj5Rp4InDB07GWV7zhmB0Vxjbq1vBlSzh9F1ZPALZURn4wryq3nZ0JxeYygkuHtIGTByo+LwdXjs9hes6jT8ec6OuoiQjmWvW/fBYbI4xhe95XfYi70zlk6UrNHodCMnVVge8C8ufiCuggSbxLKS7L2bLdaMgApTxaWdE6PYix6o9JuMPltjv2ectNt/2nRHGy+9MkkYmvHPMURftUJJ4mzA9xdItecWYFIMS1D335LecoxlbLi8HddkrwCi8CeAVdoj6tK5m5zdKwlfrIpz0Hz5d81wREhtvN+vhzMyzK60/MzqcOALd7fHTYemB/O4WnUiI6ejF2Qg
DKIM-Signature: a=rsa-sha256; bh=bq64J9zOM4lsVCdxFMajCtecKOrb6hgOrvuHJTjgJos=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788265689; v=1;
 b=M8ULOJULGAnVdMBqRycwm4IKVrl8ntg6/99U+KRw3hBkCV3BhTFpf5m2132iHD9ildwVPMvB
 a0M27zBeElBNCpcd1dq8+syTa23JdWTVUJIn5AAfBW+IkLQQuEpABgK78JYzeDwwSaevbvg/rCm
 FczdtLbxX5TFe5DDvZKGbMjJuGJK0eAlF39JxiEEF5NtOxXdZ2RZlM8UsunkU9ewmJ7cnpZiKFa
 R7YgN2pzCeT4rjwru1KREhEMlgmgRY1+JcT0FoPS4JKWeRma8XOuIng0NA84ypVOcfj1Sei5j4D
 qYzd4WsBv6rK6GufudqcmVXVWd4GyFmugjeUYXOne8TUg==
Received-SPF: pass client-ip=51.210.91.39; envelope-from=clg@kaod.org;
 helo=smtpout10.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/1/26 10:15, Jamin Lin wrote:
> This series adds a model of the ASPEED ACRY engine found on the AST2600
> SoC, wires it into the SoC, and adds a qtest.
> 
> The ACRY engine performs RSA modular exponentiation (c = m^e mod n). It
> DMAs the operands (data, exponent, and modulus) from guest DRAM and writes
> the result to a dedicated 64 KiB SRAM region.
> 
> Guest firmware uses the engine for RSA signature verification during boot.
> Without a model, the guest starts the engine and waits indefinitely for a
> completion interrupt, causing the boot to hang.
> 
> The model uses QEMU's generic akcipher API to perform raw (unpadded) RSA.
> Raw RSA is currently supported only by the libgcrypt backend, which can be
> enabled alongside gnutls with -Dgcrypt=enabled, so a build does not have to
> choose between the two. When raw RSA is unavailable, the engine still
> completes and raises its interrupt, but returns an all-zero result. This
> allows the guest's signature verification to fail cleanly instead of
> hanging. The qtest is skipped when the selected crypto backend does not
> support raw RSA.
> 
> Although the hardware documentation describes both RSA and ECDSA support,
> ECDSA is known to be broken on this hardware and is therefore not modeled.
> 
> v1:
>   1. Add ASPEED ACRY RSA model for the AST2600
>   2. Add qtest for AST2600 ASPEED ACRY RSA model
>   
> v2:
>   1. squash "Add the ACRY model to AspeedSoCState" into "Wire up the ACRY
>      model"
>   2. wrap the ACRY SRAM in a container mapped at offset 0 so the device
>      addresses it by relative offset (drop the "sram-base" property)
>   3. build the scattered SRAM byte offsets on the fly instead of caching
>      them in per-instance lookup tables
>   4. write the result with address_space_stl_le() and check the MemTxResult
> 
> v3:
>    1. Return early when the DMA read of the operand buffer fails
>    2. Replace g_printerr with g_test_skip
>    
> v4:
>    1. Remove unused macros.
>    2. Dynamically allocate data and src_buf to reduce stack usage in aspeed_acry_do_rsa().
>    3. Add a helper function to clear the result when aspeed_acry_do_rsa() fails.
>    4. Add bounds checking to aspeed_acry_operand_offset() and replace magic numbers with
>       compile-time constants.
> 
> Jamin Lin (4):
>    hw/misc/aspeed_acry: Add ASPEED ACRY model
>    hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
>    hw/arm/aspeed_ast2600: Wire up the ACRY model
>    tests/qtest/aspeed-acry-test: Add RSA ModExp tests
> 
>   include/hw/arm/aspeed_soc.h    |   4 +
>   include/hw/misc/aspeed_acry.h  |  39 +++
>   hw/arm/aspeed_ast2600.c        |  34 +++
>   hw/misc/aspeed_acry.c          | 481 +++++++++++++++++++++++++++++++++
>   tests/qtest/aspeed-acry-test.c | 406 ++++++++++++++++++++++++++++
>   hw/misc/meson.build            |   1 +
>   hw/misc/trace-events           |   6 +
>   tests/qtest/meson.build        |   5 +-
>   8 files changed, 975 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/misc/aspeed_acry.h
>   create mode 100644 hw/misc/aspeed_acry.c
>   create mode 100644 tests/qtest/aspeed-acry-test.c
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


