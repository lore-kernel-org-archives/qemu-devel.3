Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9363C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2sCN-00061P-TV; Sat, 05 Sep 2026 11:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x2sCM-00060q-9C
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 11:20:54 -0400
Received: from smtpout7.mo536.mail-out.ovh.net ([51.210.91.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x2sCJ-0003VT-R9
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 11:20:54 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hccV016wFz886K;
 Sat,  5 Sep 2026 15:20:39 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sat,  5 Sep 2026 15:20:39 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.242])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hccTz3PVKz6Nmj; Sat,  5 Sep 2026 15:20:39 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id CEFDA12E400D;
 Sat,  5 Sep 2026 15:20:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0010f0623f6-1afa-4200-b43d-6260703dee1b,
 C5A412D0C323687AB51699137568C5B956514C2B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 92.184.140.72
Message-ID: <34122b5b-c6e0-4625-923c-ca7bc504ce1e@kaod.org>
Date: Sat, 5 Sep 2026 17:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Adding /machines/labels (was Re: [PATCH v2 18/25]
 tests/functional: add a pure-Python device-locator resolver)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>, Markus Armbruster <armbru@redhat.com>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
 <20260731-sanmiguel-bmc-locator-v2-18-1266926ba769@free.fr>
 <cb1b5ec3-d7ba-42fe-a8ab-da7c236b1660@kaod.org>
 <bdbdec6f-91a6-4c70-a818-ef2b1fbe4ad5@ilande.co.uk>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <bdbdec6f-91a6-4c70-a818-ef2b1fbe4ad5@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 3694922022858239021
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTExkUrLy+FmNXOmKmMG0E0GHqCromTFqkEW92jkqTMjg/io9x99q00wfqBvn70MySYJ82OAqPvAhxOkIummSJKmCShaT9ebTqzrvhzvUpB19TBLQTRCy2nJcPcWhiOnbkhz8rCc9wbdqUdz4D+ZkJiPrsSZbSBgr1W+c9pZ38FRyAfJEkynTMqlx2f3MbW/7y1UNtv599x+qKiQABFSCeUpK+329OO4vT9/M0JtHb98en0AoGPCma9h/1JYCZe17h160JxIb7lT7qWPXt85Yk6gxqknYo3hA3ej3p3eZ2c5FLJJT2jwoRI/VRmLjC1cLfaAU8t/AHSZfM4XUWLob50xJcDnFkZIHo50uxv4GwcG3meLbeX4vc/G6w+RxKdVvjeB+7WO78Go+rNHwhloBBeZaFy4qc0Y4ryVHX5MDy9DmWUtOy6dc4qWW9D4QqVUmg+VRdE5IVQ7AACLk/s3FYbV9OC1a4JZdUi37yRYFB2xdmJNFQI7/ATzgJqTOMLub5c4l8CnLQP3uC0VGpwb05N5is9vl7ZwRhRsduLjTOVzYGw27X3qjzNfX9tzHfmGE+aknx9IGbFT+cIJVoM4vPiXXHvVQS6gObZCZJqostocSe0SMb+u/kAKErxBTnEGZY+oVHChUujNPFpqLmEuqJsrHfdXM6yJ/U8lrOvGNXf+3w
DKIM-Signature: a=rsa-sha256; bh=H6rv43ynrT1Gazu2B38ukvbekrxCMR7RU+AKUgILbtk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788621641; v=1;
 b=nacIxpLNgUozrCrQRFKVfQS7NxpwT4ugkAEW5/Wz+xQ1xwCNjVDdm8Ub/dkocZJCxDVBc4wX
 zQEfKir8QkCaoHKh6hGk3lXxiEHMvkwR1ctOYDUG1P5j6xwg+XII224pI6t+aPze+uXyjArgC4P
 A2KqXE2YBwmy+VJw8IJkwT6wVXjAUaL3Uky4njfD60LN8l6TalTEo9QeIuCbMQjze9zuYiX651L
 LIyRPX/Ujbz2JCqvoyDV+kDvrq6JQ5pxTR834x1x1aCJYVTZZ+Ii8MPbZn/+C7pc6SXeLQx4CDH
 lYF9xD2mndRL1EfF8fEsCY6Wg7CjJe/aAzz/a7tlM/Z3Q==
Received-SPF: pass client-ip=51.210.91.16; envelope-from=clg@kaod.org;
 helo=smtpout7.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hell Mark,


>> [1] https://lore.kernel.org/qemu-devel/20260701-i2c-adc128d818-anacapa-v5-6- fe8292d86b38@free.fr
>> [2] https://lore.kernel.org/qemu-devel/87se5scipx.fsf@pond.sub.org
>> [3] https://lore.kernel.org/qemu-devel/20260711223707.42139-1-graf@amazon.com
>> [4] https://lore.kernel.org/qemu-devel/20260718213652.37673-1-graf@amazon.com
>> [5] https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator- v2-0-1266926ba769@free.fr
> 
> I remember expressing a similar idea a while back in a private thread but as /machine/aliases, possibly with Pierrick and Phil?
> 
> The problem I was trying to solve was how to access in-built PCI buses and NIC devices from the command line consistently without resorting to various hacks such as having to use -nic to connect an in-built NIC to a backend: instead expose the frontend as an alias that can be referenced by the backend, so the exact QOM path is fixed and doesn't matter.
> 
> I'd certainly be interested to see the design fleshed out in more detail to explore more potential use cases.

Here is a simple proposal for the aspeed machines :

   https://lore.kernel.org/qemu-devel/20260904050424.4049984-1-clg@redhat.com/

Thanks,

C.

