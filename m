Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29CFCCF9EB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 08:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEk2L-0002zF-4S; Fri, 31 Oct 2025 03:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1vEk2H-0002yw-5l; Fri, 31 Oct 2025 03:59:02 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1vEk2D-0006CU-Dt; Fri, 31 Oct 2025 03:59:00 -0400
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1vEk23-0004u9-2c; Fri, 31 Oct 2025 08:58:48 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1vEk23-000GBl-1e; Fri, 31 Oct 2025 08:58:47 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 0E16148014E;
 Fri, 31 Oct 2025 08:58:47 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id beBozUZgIBLl; Fri, 31 Oct 2025 08:58:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 76393480152;
 Fri, 31 Oct 2025 08:58:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.embedded-brains.de 76393480152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=embedded-brains.de;
 s=34EE5404-8E36-11F0-B577-2ECCAB4968F5; t=1761897526;
 bh=1eV0Ldsgx/ctP8tgKGd2Lw97BG5YK4pGwns+q7b5HA0=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=bJpe0DqSTZ/V98qHg1I6fGKVPbeS1M9e3zCTbIRXTPW6NpG3LXeraY1fImqC4ObpA
 7jQTLhyIrG0giKrrFXmFYemfb129s1Jb0q7iccZ1FH2c0aSNPTbVkmXqPqiXmKIYlO
 6BNg/5+xmsQDjad+IVKQmiZpJxWO2qh1HIvmEZ73DvgQiyGb7wCuIXELEeV/0iTn0j
 tSmufqamjJYfNw6eTVQWpxxRLUlZcq3pdfb58+c4ruS8mIt2mcsdjnkZqWbOQ1nNQN
 cx4GC110y4nnUf18wfcRg+YgEQmupZbiybsXDeCOTXYBRmJ3RZ/T4azSArpRScsD5j
 h4STzElI+UP9g==
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id CiBujhIz4Iyh; Fri, 31 Oct 2025 08:58:46 +0100 (CET)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id 514C348014E;
 Fri, 31 Oct 2025 08:58:46 +0100 (CET)
Date: Fri, 31 Oct 2025 08:58:46 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, qemu-devel <qemu-devel@nongnu.org>, 
 qemu-riscv <qemu-riscv@nongnu.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <387693146.35079.1761897526299.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <CAKmqyKNkJiK_8UkJ6AqvmCbtkj=amzJvrV1CUx2EXCdUvD_jCw@mail.gmail.com>
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
 <38528707-3d28-4be8-8b58-60269cb1db1b@roeck-us.net>
 <788527663.312.1759727663914.JavaMail.zimbra@embedded-brains.de>
 <67097d9c-ec3c-420c-b5b3-e2f3595a0612@roeck-us.net>
 <CAKmqyKNkJiK_8UkJ6AqvmCbtkj=amzJvrV1CUx2EXCdUvD_jCw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] hw/riscv: Make FDT optional for MPFS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF140
 (Linux)/10.1.10_GA_4785)
Thread-Topic: hw/riscv: Make FDT optional for MPFS
Thread-Index: 2LxsqKNBypmzsIfWY5xx/vh+OhXjQw==
X-DKIM-Status: pass [(embedded-brains.de) - 78.47.199.104]
X-Virus-Scanned: Clear (ClamAV 1.0.9/27808/Thu Oct 30 10:49:23 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

----- Am 31. Okt 2025 um 3:56 schrieb Alistair Francis alistair23@gmail.com=
:

> On Tue, Oct 7, 2025 at 6:34=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>>
>> On 10/5/25 22:14, Sebastian Huber wrote:
>> > Hello Guenter,
>> >
>> > thanks for the report. Do you have a Linux image and a Qemu command li=
ne so that
>> > I can test this?
>> >
>> See http://server.roeck-us.net/qemu/riscv64/
>>
>> run.sh executed with qemu 10.1 or later should trigger the problem
>> (the command line is not passed to the kernel).
>=20
> Any updates here?

Sorry, I didn't forget it, but I have a huge backlog of work.

--=20
embedded brains GmbH & Co. KG
Herr Sebastian HUBER
Dornierstr. 4
82178 Puchheim
Germany
email: sebastian.huber@embedded-brains.de
phone: +49-89-18 94 741 - 16
fax:   +49-89-18 94 741 - 08

Registergericht: Amtsgericht M=C3=BCnchen
Registernummer: HRB 157899
Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas D=
=C3=B6rfler
Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
https://embedded-brains.de/datenschutzerklaerung/

