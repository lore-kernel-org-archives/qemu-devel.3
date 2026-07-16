Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66FBC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPOv-0008L1-RM; Thu, 16 Jul 2026 12:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wkPOu-0008KO-2J; Thu, 16 Jul 2026 12:57:32 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wkPOr-0005DW-Uk; Thu, 16 Jul 2026 12:57:31 -0400
Received: from [192.168.75.54] (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 06D5320041C;
 Thu, 16 Jul 2026 18:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1784221047;
 bh=Np62XeGJOSYMINz6EVZ4Sz27kHUVpGcmQUL5xXn4Pnk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OPZci06jZRVUf1nesLaino/YHblAOs9bth7a3uWXm5RCmYRyaKm6uCDeUjU0wNow0
 YBCTCNgZrzyoH2JHYdtzxf2Vjp9yG8dcSz0kIQ1A5NlL7kZQtdtGoA9IEGAdFrBlEq
 U7+uEp74VTScaGE+00u3kYZ79FT54c+uemg+5+1SUVGADqaJ+DowFhy2UijTAAHJ+Z
 TcVapGVeYKPhbHtj6waoUNw6sNeh1T1FdEtdXuX34pnXsu6arrIxyNBzVS+w74c3MJ
 Y4u0DWvY3SyI79hNZmq7grJm99HghJRU8IHK7HD+3RJkTeHf8/pHlFplL9+ckwo7pi
 LUOK+Pct8K7rw==
From: emmanuel.blot@free.fr
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>,
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v5 6/8] hw/i2c: parent slaves created with
 i2c_slave_create_simple
Date: Thu, 16 Jul 2026 18:56:46 +0200
X-Mailer: MailMate (3.0r7020)
Message-ID: <F7E73975-A2A2-4A5A-BBCA-40C2229FFF18@free.fr>
In-Reply-To: <87pl0uyihl.fsf@pond.sub.org>
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
 <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
 <87pl0uyihl.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
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



On 10 Jul 2026, at 17:25, Markus Armbruster wrote:

> Emmanuel Blot <emmanuel.blot@free.fr> writes:
>
>> Slaves created with i2c_slave_create_simple() were left unparented and=

>> showed up under /machine/unattached with no stable QOM path. Add each
>> slave as a QOM child of its bus, named after its I2C address, so it ha=
s
>> a deterministic and addressable QOM path.
>
>> index 54f6bdca88..0bbce45d48 100644
>> --- a/hw/i2c/core.c
>> +++ b/hw/i2c/core.c
>> @@ -382,6 +382,9 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus, con=
st char *name, uint8_t addr)
>>  {
>>      I2CSlave *dev =3D i2c_slave_new(name, addr);
>>
>> +    g_autofree char *childname =3D g_strdup_printf("0x%02x", addr);
>
> Is the hex address a satisfactory child name?
>

Addresses are unique on a I2C bus. They are identified on the bus with th=
eir unique address, which is usually expressed as an hex integer in the d=
atasheets. It makes the QOM path easy to interpret and use to access an I=
2C device, but I do not have a strong opinion on how to name them.

Emmanuel.


