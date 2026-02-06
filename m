Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D02E8B364
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIG9-0002yk-5K; Fri, 06 Feb 2026 04:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1voIG7-0002wW-2U; Fri, 06 Feb 2026 04:36:15 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1voIG5-0005Nz-9z; Fri, 06 Feb 2026 04:36:14 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.199])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f6pqs0Zjdz5vqG;
 Fri,  6 Feb 2026 09:36:09 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 6 Feb
 2026 10:36:08 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006e264fffc-df02-4fb4-b080-3ce4621e512e,
 C2DCEC2B1261BCA5104DC73024CD17A0EB88A4A8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ba061380-7377-4814-b0ff-2a95743fcb8d@kaod.org>
Date: Fri, 6 Feb 2026 10:36:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase I2C device register
 size to 0xA0
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260206053340.3716041-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 2e4fe875-f8fe-4202-adc9-3559c01965c9
X-Ovh-Tracer-Id: 13116733916223736638
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE7t8tx8KKcdEwFt5SZ5M1fCvER61nVQOn2KImXy0KSMJrRe9eiA1vrXcOjCJ9cDyf3tUqW3nytcxkDuaniYc1EcXEAAmByb1U1xStA8oeSOZ+JLW5j7kT7XQnThutFPMZUD6DkQwdgTk/kJTq3CDjXbC9r3XmZXTx4mq7zCgd5UGjoYYCwzG8ZqcpQLybDe4mqAVgmBecTljRHaqtdyuGgUBQyrBnm93huWhR2zVNBunrcww0ZXL1J7O1bFL4QQiMwdqiDIMdHf8gxsFPW9voGgqWbUOXU9gaQIkkYWTr37h6CghuuzvJLhy3FKktZLcgggxJUxZLjZkGvpEl//+LNClfs8EyyNqy1g0XxHVX7O00JuFgnasU4MYf7rgF3KsOR8C/nWwbhvqvZuIJgm5nLnEYztOR5sqpsfL/1klHxL67D3FATuIQ5jsb8HCrO2SZ9Zuk0KE5sOV8mGO6T7+cQg1A5WdnePo6HX6nsBnEmciHhJIBP34qbBGnpQNFq4qV7IIrvkYQvUJ6ZW2NflR9qqHLVcYIbv5my83u4A7LsOA2Y4RzsDCffOvzGmlWVgNmR68ru+ff7mv8QtlJWi0n9fzUBw4u8ng+VVGTzfkORCcFFlUXsrWQdg70ovmqgiFSB/I5dTDOg/ECaVxu4X2Kecdeev6W8n1kH63YUyBEj6Q
DKIM-Signature: a=rsa-sha256; bh=xx67vB0iA2zPiTa2bBi6S2pRxoji1DEP41DfTh2ug+k=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770370569; v=1;
 b=mhNgygn3tj5mC6Gi30Ti4rUE/d7EEFkXJqoqrkUv3DjUp919LEoSCCUhStKNlAieqU+NDWRy
 WjeK+BvxM2TCkJQSGqR6yjWUx5mLMNyvPav2O24enyghrPjBRjrABHBQ3EYwy6XFCZuSXlAw/zv
 5O41V/QsCRnJYndIdg8PMNDWFe41E60EF2scrZY4sT09vB4UFphz7TXzsdV53NEgjSKKMq3z+JD
 iRrghigueqV7h9xRt7m1iRTpouXdpA2MVHf/1eTFtTKYejG+hLod8/urCNFmbBjN0egWzJJnhrZ
 199rswmQcfR6HJ0VB84THP4FAj7XMgQkxRBu8l3JT9qjQ==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=clg@kaod.org;
 helo=10.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2/6/26 06:33, Jamin Lin wrote:
> According to the AST2700 A1 datasheet, the register space for each I2C
> device instance has been expanded from 0x80 bytes to 0xA0 bytes.

Was that change introduced with the A1 ? or A0 ?

Thanks,

C.


> Update the AST2700 I2C controller configuration to reflect the new
> register layout by increasing the per-device register size to 0xA0
> and adjusting the register gap size accordingly.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/i2c/aspeed_i2c.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index cf3a003978..e1682c9bdd 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1206,37 +1206,37 @@ static void aspeed_i2c_instance_init(Object *obj)
>    *
>    * Address Definitions (AST2700)
>    *   0x000 ... 0x0FF: Global Register
> - *   0x100 ... 0x17F: Device 0
> + *   0x100 ... 0x19F: Device 0
>    *   0x1A0 ... 0x1BF: Device 0 buffer
> - *   0x200 ... 0x27F: Device 1
> + *   0x200 ... 0x29F: Device 1
>    *   0x2A0 ... 0x2BF: Device 1 buffer
> - *   0x300 ... 0x37F: Device 2
> + *   0x300 ... 0x39F: Device 2
>    *   0x3A0 ... 0x3BF: Device 2 buffer
> - *   0x400 ... 0x47F: Device 3
> + *   0x400 ... 0x49F: Device 3
>    *   0x4A0 ... 0x4BF: Device 3 buffer
> - *   0x500 ... 0x57F: Device 4
> + *   0x500 ... 0x59F: Device 4
>    *   0x5A0 ... 0x5BF: Device 4 buffer
> - *   0x600 ... 0x67F: Device 5
> + *   0x600 ... 0x69F: Device 5
>    *   0x6A0 ... 0x6BF: Device 5 buffer
> - *   0x700 ... 0x77F: Device 6
> + *   0x700 ... 0x79F: Device 6
>    *   0x7A0 ... 0x7BF: Device 6 buffer
> - *   0x800 ... 0x87F: Device 7
> + *   0x800 ... 0x89F: Device 7
>    *   0x8A0 ... 0x8BF: Device 7 buffer
> - *   0x900 ... 0x97F: Device 8
> + *   0x900 ... 0x99F: Device 8
>    *   0x9A0 ... 0x9BF: Device 8 buffer
> - *   0xA00 ... 0xA7F: Device 9
> + *   0xA00 ... 0xA9F: Device 9
>    *   0xAA0 ... 0xABF: Device 9 buffer
> - *   0xB00 ... 0xB7F: Device 10
> + *   0xB00 ... 0xB9F: Device 10
>    *   0xBA0 ... 0xBBF: Device 10 buffer
> - *   0xC00 ... 0xC7F: Device 11
> + *   0xC00 ... 0xC9F: Device 11
>    *   0xCA0 ... 0xCBF: Device 11 buffer
> - *   0xD00 ... 0xD7F: Device 12
> + *   0xD00 ... 0xD9F: Device 12
>    *   0xDA0 ... 0xDBF: Device 12 buffer
> - *   0xE00 ... 0xE7F: Device 13
> + *   0xE00 ... 0xE9F: Device 13
>    *   0xEA0 ... 0xEBF: Device 13 buffer
> - *   0xF00 ... 0xF7F: Device 14
> + *   0xF00 ... 0xF9F: Device 14
>    *   0xFA0 ... 0xFBF: Device 14 buffer
> - *   0x1000 ... 0x107F: Device 15
> + *   0x1000 ... 0x109F: Device 15
>    *   0x10A0 ... 0x10BF: Device 15 buffer
>    */
>   static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
> @@ -1670,8 +1670,8 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
>       dc->desc = "ASPEED 2700 I2C Controller";
>   
>       aic->num_busses = 16;
> -    aic->reg_size = 0x80;
> -    aic->reg_gap_size = 0x80;
> +    aic->reg_size = 0xa0;
> +    aic->reg_gap_size = 0x60;
>       aic->gap = -1; /* no gap */
>       aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
>       aic->pool_size = 0x20;


