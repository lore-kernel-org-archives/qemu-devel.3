Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3174CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEROA-0005vu-LV; Wed, 07 Oct 2026 09:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xERNz-0005v5-Kk
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:08:44 -0400
Received: from smtpout1.mo536.mail-out.ovh.net ([51.210.91.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xERNw-0008GN-Hv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:08:43 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4j0D2q70fGz88R6;
 Wed,  7 Oct 2026 13:08:35 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed,  7 Oct 2026 13:08:35 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.42])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j0D2q317Dz1xrl; Wed,  7 Oct 2026 13:08:35 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 842651922C58; Wed,  7 Oct 2026 13:08:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G00607362911-8fae-4702-af6c-f2f90f0a929a,
 55F3741E86F82430FE8C443D65E56F6716F373F4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 92.184.136.188
Message-ID: <23d822c9-4c74-4e34-af38-237416cee439@kaod.org>
Date: Wed, 7 Oct 2026 15:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/functional/aarch64/test_aspeed_ast2700a2:
 Add I2C test for IO expander 1
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
 <20261005020428.3496039-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261005020428.3496039-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4923278821287767051
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGv9ncUogrE83oDH/5+N52iY1GKGKIZUSmnfpDcBTyw7FvZ2Ip7+Fp0ewWo2k73W0Ab+6ir9POEQaAkNIVN0oHxd3wU1U9CvO87uGFn+Fp/C89ZjzcbMW5uU9ylRrVP3f50vUOIdq868aXHkI45bsledf7oDl61+54gH6/WeYaUBrdKHlaoVLneIn3HukAVB83a33lk1+DVDkasQ0JlNZ7FSlBFZeCSllQfF6Fh0y8sU5EvAeZRUk4cV0jBYFvUnrp9HX2I5so/QY5KeqsgqZpV+oJwfyLnUe1AniYT+MPi2jVaLPpawttPnWkdAJISCZOKFJoWjDTerUv5OeJjnt/CNNl+xivLbAocz8LCqQNI5zYi6LvtFBcCpuOE4v3YylpN3ZJy9Wwk4O/LSNOtILkKng0k41RUpOEEPo5IMJSH/p+ifQdmqwPdHqqjjdYfGmM1lSl9P3ve9s14Ln9Re53ehGOgAbFLNFH9xRBJELtpX3SW328uv9HgfRg3mKL7ZuhmCjdIJKatgYvOHcclvXQHIZIwaYF52afDLkLoclMdZ5ItIrLzFlx/BbOVPEjIm3Tt+H1HSJ1JVfl14dezSKHdTGjN4QYeoJOdzRYV+O8IuRaJKnHWf7mPXDu6jtaUfHuQPJ9DtPiJxn+qd+MrVGIFz9bbH3CCVN0BHu+CNOUDTQ
DKIM-Signature: a=rsa-sha256; bh=SV0MTsx7G7yOApnYx1aE0y7EEVL0SEvBEZ7p/p5ON/Q=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791378517; v=1;
 b=uHGXbzMoZe2IXQjKwXTHRohhqomRR738k9rjKkzw+2quAhMfxJgqc82Hit/OkAmPLhBV5Xjz
 UyuhOX7W9VTqmkf72x8r0PLllJRhndai5XyeAvk29U8I3J5Ntfl8/WUuLXx5VgJL111CF/b2bTc
 8fCKjpPKPnoVWmXBExjCTmLU0s2UEigYMG5jjScRWyqG4/dbO9NF8XlyzCCBRUEswl0sNX4IwOb
 /EM/xRNI0WDrar9zTqvfVNKOpXRMEXy+X5V/VGZ2+NDOMUtzLoXjFlJ7eX9Yk6LCRLLp8AQpg+/
 V1NdVmRO2Rv9FmfB4s2R6eL8ND9+NUN4Lj2D6M/YuAr4w==
Received-SPF: pass client-ip=51.210.91.10; envelope-from=clg@kaod.org;
 helo=smtpout1.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/5/26 04:04, Jamin Lin wrote:
> The IO expander test only checks the I2C bus of IO expander 0. The I2C
> buses of IO expander 1 are not tested, so a wrong interrupt wiring for
> IO expander 1 can not be detected.
> 
> Add a TMP105 device on the first I2C bus of IO expander 1 and check that
> it can be read from firmware.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/aarch64/test_aspeed_ast2700a2.py | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
> index 01c7c4fdbe..74ef93fc0d 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700a2.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
> @@ -196,10 +196,13 @@ def test_aarch64_ast2700a2_evb_ioexp_v11_03(self):
>           self.vm.set_machine('ast2700a2-evb,fmc-model=w25q512jv')
>           self.vm.add_args('-device',
>                            'tmp105,bus=ioexp0.0,address=0x4d,id=tmp-test-16')
> +        self.vm.add_args('-device',
> +                         'tmp105,bus=ioexp1.0,address=0x4d,id=tmp-test-32')
>           self.start_ast2700_test('ast2700-dcscm-image', 8)
>           self.verify_openbmc_boot_and_login('ast2700-dcscm', False)
>           self.do_ast2700_i2c_test(8)
>           self.do_ast2700_i2c_test(16)
> +        self.do_ast2700_i2c_test(32)
>   
>   if __name__ == '__main__':
>       QemuSystemTest.main()


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

