Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E07C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMj4-0003jl-7B; Thu, 16 Jul 2026 10:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wkMj1-0003gC-NY; Thu, 16 Jul 2026 10:06:07 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wkMiz-00027G-EZ; Thu, 16 Jul 2026 10:06:07 -0400
Received: from [192.168.25.24] (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 4926D2003C6;
 Thu, 16 Jul 2026 16:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1784210761;
 bh=Fcch2Ulk2tllJdjAQdNy+yeM0HvoaCnSDPQrmLS81wY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lASqkKJQk1gBK9ZAtL3WzA3XI6j7rhObTozg7D/koJ3wOMquGbyEicgTtNDTk1WWh
 zKiYJRb674VfC9fcBv3u/N90I//sEISQ/fa2Rj8z6EedfRYUT+qco13k6hW5/yKcD/
 /Fkrm1Dzk1CjVxljQ7+XN568XPbGmcxipeN5qb8NDc/BJ6FI+xGMSy3NX82y/izDtX
 +uJ18lZmTi+s6jp+Aj3o28YNMEpi0Ygo73ESJ+rPVeD1fVru042M2KyhqAmQLHX60w
 JnBEOlKSo4vWyyUPjVfIy6yYSgII/AGqGLML92D4D9ANQxZbbCc/JJnTxy/h1k12m8
 TNuo6h8YvbdrQ==
From: emmanuel.blot@free.fr
To: Miles Glenn <milesg@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 11/29] tests/qtest: pca9555: test output-to-input
 reflection and pull-ups
Date: Thu, 16 Jul 2026 16:05:39 +0200
X-Mailer: MailMate (2.0r6290)
Message-ID: <37343465-DA0D-4D3B-96AF-2FF2BEEDA1C5@free.fr>
In-Reply-To: <5da27eef8c07b6d742d46dca19035e221cac402a.camel@linux.ibm.com>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-11-82a63fead90c@free.fr>
 <5da27eef8c07b6d742d46dca19035e221cac402a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hey Glenn,

Yes sorry, I=E2=80=99ve been fighting my ISP SMTP server that considers t=
hat sending more than a couple of patches to 10 different addresses is so=
me kind of SPAM, and I ended up pushing twice the same email=E2=80=A6

Emmanuel.

On 16 Jul 2026, at 15:58, Miles Glenn wrote:

> Not sure why patch 11 was sent twice (once from two different emails),
> but...
>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
>
> Thanks,
>
> Glenn
>
> On Thu, 2026-07-09 at 17:23 +0200, Emmanuel Blot wrote:
>> Add tests covering the pin I/O semantics of the expander: output-drive=
n
>> pins reflected in the input register, the pull-up seen on input-config=
ured
>> pins, and the independence of the two 8-bit ports.
>>
>> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
>> ---
>>  tests/qtest/pca9555-test.c | 75 +++++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 75 insertions(+)
>>
>> diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
>> index 5945c3441e..6b085702c3 100644
>> --- a/tests/qtest/pca9555-test.c
>> +++ b/tests/qtest/pca9555-test.c
>> @@ -28,6 +28,77 @@ static void test_reset_defaults(void *obj, void *da=
ta, QGuestAllocator *alloc)
>>      g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), =3D=3D, 0xFF);
>>  }
>>
>> +/*
>> + * When a pin is configured as output and driven low (output=3D0, con=
fig=3D0),
>> + * the input register should reflect 0 for that pin.
>> + * When driven high (output=3D1, config=3D0), input should reflect 1.=

>> + * When configured as input (config=3D1), PCA5555 pull-up makes it re=
ad 1.
>> + */
>> +static void test_output_drives_input(void *obj, void *data,
>> +                                     QGuestAllocator *alloc)
>> +{
>> +    QI2CDevice *dev =3D (QI2CDevice *)obj;
>> +
>> +    i2c_set8(dev, PCA9535_CONFIG0, 0xF0);
>> +    i2c_set8(dev, PCA9535_OUTPUT0, 0xFA);
>> +
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), =3D=3D, 0xFA);
>> +
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), =3D=3D, 0xFF);
>> +
>> +    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
>> +    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), =3D=3D, 0x00);
>> +
>> +    i2c_set8(dev, PCA9535_OUTPUT0, 0xFF);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), =3D=3D, 0xFF);
>> +}
>> +
>> +/*
>> + * When all pins are inputs (config=3D0xFF) and no external driver,
>> + * PCA9555 pull-ups should make the input register read all ones.
>> + * Switching a pin to output mode with output=3D0 should drive it low=
=2E
>> + */
>> +static void test_input_pullup(void *obj, void *data, QGuestAllocator =
*alloc)
>> +{
>> +    QI2CDevice *dev =3D (QI2CDevice *)obj;
>> +
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), =3D=3D, 0xFF);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), =3D=3D, 0xFF);
>> +
>> +    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), =3D=3D, 0xFF);
>> +
>> +    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), =3D=3D, 0x00);
>> +}
>> +
>> +/*
>> + * Test that both ports are independent: changing port 0 registers
>> + * should not affect port 1 and vice versa.
>> + */
>> +static void test_port_independence(void *obj, void *data,
>> +                                   QGuestAllocator *alloc)
>> +{
>> +    QI2CDevice *dev =3D (QI2CDevice *)obj;
>> +
>> +    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
>> +    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
>> +
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), =3D=3D, 0x00);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), =3D=3D, 0xFF);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), =3D=3D, 0xFF);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), =3D=3D, 0xFF);
>> +
>> +    i2c_set8(dev, PCA9535_CONFIG1, 0x00);
>> +    i2c_set8(dev, PCA9535_OUTPUT1, 0xAA);
>> +
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), =3D=3D, 0x00);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), =3D=3D, 0xAA);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), =3D=3D, 0x00);
>> +    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), =3D=3D, 0xAA);
>> +}
>> +
>>  static void pca9555_register_nodes(void)
>>  {
>>      QOSGraphEdgeOptions opts =3D {
>> @@ -39,6 +110,10 @@ static void pca9555_register_nodes(void)
>>      qos_node_consumes("pca9555", "i2c-bus", &opts);
>>
>>      qos_add_test("reset-defaults", "pca9555", test_reset_defaults, NU=
LL);
>> +    qos_add_test("output-drives-input", "pca9555", test_output_drives=
_input,
>> +                 NULL);
>> +    qos_add_test("input-pullup", "pca9555", test_input_pullup, NULL);=

>> +    qos_add_test("port-independence", "pca9555", test_port_independen=
ce, NULL);
>>  }
>>
>>  libqos_init(pca9555_register_nodes);
>>

