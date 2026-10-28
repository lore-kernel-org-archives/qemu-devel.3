Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0C606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=fccxrBHm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1VF-0007L2-5L; Wed, 28 Oct 2026 07:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xM1VC-0007JV-G5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:07:30 -0400
Received: from 10.mo528.mail-out.ovh.net ([46.105.37.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xM1VA-0001LU-OX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:07:30 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4jF4MK18dkz6WdR;
 Wed, 28 Oct 2026 11:07:24 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 28 Oct 2026 11:07:24 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.223])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jF4MJ3YHcz1xq7; Wed, 28 Oct 2026 11:07:24 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 75C1A203209; 
 Wed, 28 Oct 2026 11:07:23 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005ea6cb01b-f243-4ff1-8738-d43319637bdf,
 E08929C5676352A1F51837021B168DD299C323AB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <19d8e389-295b-4045-8d91-51a89adc4fa0@kaod.org>
Date: Wed, 28 Oct 2026 12:07:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] hw/i2c/aspeed: fix non-packet buffer and DMA
 transfer modes
To: Timur Maksimov <gessingate@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 15522782018392927277
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFeEDdIsGv3P/8DCcjk3nyuKD3nQoRph8w1AsCVPIJW1iV26FbgX02jOU80z86J+5DVWiNc2M4gRi33E7z+a7Ec3MKiWJ8bOtVdIF24hTBg9/OzuFsLBKU69sKj5mFtJ9RNfTviXzdQzRADxgt8GxJX95HrfaTOwiRXQnpp8+0gPp2V7olvHgWMIdpOP50aksDiW+KrwV7lotwRDcPCxj2psfCUoXH2djUMNmXmhdR1983C3TbKxWFIfYc2c4Ll7SgrQiyOTBynwN6eJcvH1tdJp92I/G6WlLgFq3u3sSsTmM5HCfXq5p5wbvD/nKsl96T/AOQru/J/jdKSQxlmn+KLdVVhcq0gJPPbMgUQXINRno/C5Oz05o26W4F88kLNx4IfFVm5PnC0OJSiP6U33CkgJVm/QiJUnotGDtVSVBdyoyK/M/Gi99kwolFH1w+uChgQvCIGdVnvTZhzyABZYd/eCf8K6GxIFbRWBvo8zplC/Ck7y6cW+If0m+5atbgK5Gupb5Nle/q4HS+sDZ2AziqkMLJ6EzwvfQfXozQrWoTS1/nJLMY7nD8GhxMhXlx0iYDuF6lNTzen7/2Hp1/9+kCvp4Pu0Yx9SWINcNzil7WnGMaCy0DTJ8HBiEczs4bD9gdMwlrTVt8iP57MSr5p1LvrfZF7p32OICxhpKbvJDV1Nw
DKIM-Signature: a=rsa-sha256; bh=uuvhANXmJAFkYxiEUb9SCrmLzmmyuRsFO6Ka814qwHg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793185645; v=1;
 b=fccxrBHm9wYmxxv3ZtKzNwpT7s4cLPbAkIVPdg7i5L/3wEG0tkqvGcHQpQDtEoZPBUa4nA3h
 SLfi/n4SJLZhR/1lkEqUywRAL/DJWG2wV3VBJx9EWeqp4qQrj/QnrZRgm888lbVxfv4WPzEL1+a
 wfWTFKFm5TVMzMW+8A9BFG4q9RC5bkaIQh2NOCgP2AjmVQFWk8OdqRfQFSDw739mOyXbAGz+eFX
 EX3oUSUpkqSB8LaC+S6bWag572m6goE9ZNeOtA6KNffp+fDJCZhryWoNfKJ7gRXQIX4r3n/tU1J
 sVY0NSL3F4DgTfVfu1HFs1TYxjbXGf6FIz+XzROBeUYLQ==
Received-SPF: pass client-ip=46.105.37.93; envelope-from=clg@kaod.org;
 helo=10.mo528.mail-out.ovh.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Jamin,

Could you please check the Fix changes, patch 2-5 ? They appear to be valid
additions but I would like a second opinion.

Thanks,

C.

On 10/27/26 20:50, Timur Maksimov wrote:
> In non-packet mode, buffer and DMA modes are broken
> in the Aspeed I2C controller,
> probably because no available driver currently uses them.
> This patch fixes them, so byte, buffer, and DMA transfer modes
> now work correctly for both register modes, old and new ones.
> Tests are provided to prevent possible regressions.
> 
> Signed-off-by: Timur Maksimov <gessingate@gmail.com>
> ---
> Changes in v2:
> - Fix commits description format. Some of them are reordered and clarified.
> - Link to v1: https://lore.kernel.org/qemu-devel/20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com
> 
> ---
> Timur Maksimov (6):
>        hw/i2c: add dummy device
>        hw/i2c/aspeed: fix BUSY status reading in new register mode
>        hw/i2c/aspeed: fix I2CD_CMD register reading
>        hw/i2c/aspeed: fix buffer transfer in non-packet mode
>        hw/i2c/aspeed: fix DMA transfer in non-packet mode
>        tests/qtest: Add cases for 32-bit Aspeed I2C controllers
> 
>   hw/i2c/Kconfig                |   5 +
>   hw/i2c/aspeed_i2c.c           |  23 +-
>   hw/i2c/i2c-dummy-device.c     | 168 +++++++++
>   hw/i2c/meson.build            |   3 +-
>   tests/qtest/aspeed_i2c-test.c | 836 ++++++++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build       |   2 +
>   6 files changed, 1029 insertions(+), 8 deletions(-)
> ---
> base-commit: 9b77fa7a4fe86c80d1ff526769c61ada7d28666a
> change-id: 20261025-aspeed-i2c-nonpkt-fix-89b852b5c84a
> 


