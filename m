Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C568E8782A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGN3-0007gz-Eg; Tue, 03 Feb 2026 08:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnGN2-0007gX-29
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:23:08 -0500
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnGN0-0003Te-Dl
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:23:07 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.199])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f54144N4kz5w1M;
 Tue,  3 Feb 2026 13:23:04 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 3 Feb
 2026 14:23:03 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G00671ef3d11-8b2f-463b-9468-91bce274a2fa,
 43D9FD9E6FAA5025B81087D7BA78A3446A80EEF4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <fc66e841-217c-40b8-bc03-23e903e3dc4a@kaod.org>
Date: Tue, 3 Feb 2026 14:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] docs/system/arm/aspeed: Load raw U-Boot image in
 AST2700 boot example
To: Jamin Lin <jamin_lin@aspeedtech.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <TYPPR06MB82066553EFFA88182689036BFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB82066553EFFA88182689036BFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: a5067250-87fe-4102-a74c-b3f1d9a21223
X-Ovh-Tracer-Id: 17777959532243028981
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGs1FVmJmR0rocJc9dH+u5GuLP1FIV890KW9vhFwiSiAnIkZB+PQENIZNzU8FH52mrMx/WkZro4TbhSm8i4m7F0pRUIuDc0AOHyj4eA/jj4ffnlAZGflHV78iqMzA3YNGP0p7IHi3kT0fOCzr+nDuJ178NmtE+ruLNfCyxxyu/k2N5suIWRe8aj38iyrdvm3FFZbc5zb6NnKkqpDFrXv/kQdn5QAif0IQXRnSVtu/Ep6rA1C3ySiz02gpUOwdtCkccFk2EcL0oGJz48EkZkNsuUeQsyPzGoAwOoaA7/z6+JPgQsNvRJgb0Eoy/aVVwO1LYyXthXMYzM7ZTePbo4gy2yDTjed7kI6PSa6NKNjCXvgMTWWU6jo64/3bpylVRgwJ/av1ofFJijqRPDmjXtXBSA0pne35spBnrtYKN5Wvj6ed55riEWvuWrjQGaCuxyqZ5TRqRAQe5lpWbZmBN4RMLplU7HSlOTZ/GXpaPNM7DX+kchIlxYp38T6BNC4sTs/fhih0Mb944PvmiB8idv6ESP8bzmqyBsgaqIm48RgzygyfAZHaYIpazQXQABR590bbIFsHuRpoF0Vy5IP/jt4EbSc1ywNe1tTRLmGu5Kef4ROq8FSnp+tNIeCp02R7Kz9yotCyZtimYbqwADH/UfgG9Z9eNUihYjSpwnQ7nT0e6eIA
DKIM-Signature: a=rsa-sha256; bh=8z6Ihm1LfHehRrgeQiraybdMf6hVi7ScgSSic41VZvc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770124984; v=1;
 b=YybXaUkpNIqg+IS0KrgXvLt4tnqxnW3QN1R60x74t4E65L61HJGx65GexYs++C09ujdachdY
 Qc7aswnq04MnQTCsqlIndpY5+OH1HceU7cT2ojxqq7R3BvDW4I0gPPIjyPc2hrL44PhDXBFSJpL
 zSgrrzj0lmuYxD+dwvh+kW3I7XuKHzgjf5XZRfFnLh18tUIpp7M7aQDJvo75duw3HljdK0NOFX9
 Ef+u7MZzjsPeJmdoj4l0oWK/c8M/0GpON4+EE+5WZ44C8HQujFVwIxVubBLBU/V+3AaFxF5AXN4
 gGYPikgtP154h+ezTAhfBmla/18ERyVq8o64FLagEcxKg==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=clg@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2/3/26 02:55, Jamin Lin wrote:
> Recent SDK versions no longer provide a U-Boot FIT image, and U-Boot is
> now built as a single raw binary. Update the documentation to load the
> raw u-boot.bin image directly.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   docs/system/arm/aspeed.rst | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 97e14b7d33..d0054a7dbb 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -350,11 +350,9 @@ corresponds to the BL31 image load address.
>   .. code-block:: bash
>   
>     IMGDIR=ast2700-default
> -  UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
>   
>     $ qemu-system-aarch64 -M ast2700-evb \
> -       -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
> -       -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb \
> +       -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot.bin \
>          -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
>          -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin \
>          -device loader,cpu-num=0,addr=0x430000000 \
> @@ -409,11 +407,9 @@ Steps to boot the AST2700fc machine:
>   .. code-block:: bash
>   
>     IMGDIR=ast2700-default
> -  UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
>   
>     $ qemu-system-aarch64 -M ast2700fc \
> -       -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
> -       -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb \
> +       -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot.bin \
>          -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
>          -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin \
>          -device loader,cpu-num=0,addr=0x430000000 \

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

