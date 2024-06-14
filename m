Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A554C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 11:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI564-0000Pg-4h; Fri, 14 Jun 2024 07:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=g5qb=NQ=kaod.org=clg@ozlabs.org>)
 id 1sI563-0000PF-1J; Fri, 14 Jun 2024 07:27:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=g5qb=NQ=kaod.org=clg@ozlabs.org>)
 id 1sI560-0003tX-Jm; Fri, 14 Jun 2024 07:27:54 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W0xpR70KKz4wcC;
 Fri, 14 Jun 2024 21:27:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0xpN0yv2z4wyh;
 Fri, 14 Jun 2024 21:27:39 +1000 (AEST)
Message-ID: <ceefb013-7e8a-47ae-9450-2601db9872aa@kaod.org>
Date: Fri, 14 Jun 2024 13:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ppc/pnv: Add SPI controller model
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
 <20240515174149.17713-2-chalapathi.v@linux.ibm.com>
 <a671f38a-f7b0-433d-b016-a024964be8be@kaod.org>
 <38161823-19d4-4cd1-b85b-33b9beadb56b@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <38161823-19d4-4cd1-b85b-33b9beadb56b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=g5qb=NQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/13/24 3:45 PM, Chalapathi V wrote:
> 
> On 20-05-2024 11:19, Cédric Le Goater wrote:
>> On 5/15/24 19:41, Chalapathi V wrote:
>>> SPI controller device model supports a connection to a single SPI responder.
>>> This provide access to SPI seeproms, TPM, flash device and an ADC controller.
>>>
>>> All SPI function control is mapped into the SPI register space to enable full
>>> control by firmware. In this commit SPI configuration component is modelled
>>> which contains all SPI configuration and status registers as well as the hold
>>> registers for data to be sent or having been received.
>>>
>>> An existing QEMU SSI framework is used and SSI_BUS is created.
>>>
>>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>>> ---
>>>   include/hw/ppc/pnv_xscom.h    |   3 +
>>>   include/hw/ssi/pnv_spi.h      |  44 +++++++
>>>   include/hw/ssi/pnv_spi_regs.h | 114 +++++++++++++++++
>>>   hw/ppc/pnv_spi_controller.c   | 228 ++++++++++++++++++++++++++++++++++
>>
>> The file names are not consistent.
>>
>> Please rename hw/ppc/pnv_spi_controller.c to /hw/ssi/pnv_spi.c.
> 
> Hello Cedric,
> 
> I could not compile hw/ssi/pnv_spi.c because of target specific code.
> 
> /FAILED: libcommon.fa.p/hw_ssi_pnv_spi.c.o
> cc -m64 -mcx16 -Ilibcommon.fa.p -I/usr/include/p11-kit-1 -I/usr/include/pixman-1 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/gio-unix-2.0/ -I/usr/include/slirp -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wold-style-declaration -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2 -Wmissing-format-attribute -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi -isystem <qemu_dir>/linux-headers -isystem linux-headers -iquote . -iquote <qemu_dir> -iquote <<qemu_dir>>/include -iquote <qemu_dir>/host/include/x86_64 -iquote <qemu_dir>/host/include/generic -iquote <qemu_dir>/tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing 
> -fno-common -fwrapv -fPIE -MD -MQ libcommon.fa.p/hw_ssi_pnv_spi.c.o -MF libcommon.fa.p/hw_ssi_pnv_spi.c.o.d -o libcommon.fa.p/hw_ssi_pnv_spi.c.o -c ../hw/ssi/pnv_spi.c
> In file included from <qemu_dir>/target/ppc/cpu.h:25,
> from <qemu_dir>/include/hw/ppc/pnv.h:24,
> from <qemu_dir>/include/hw/ppc/pnv_xscom.h:24,
>                   from ../hw/ssi/pnv_spi.c:12:
> <qemu_dir>/include/exec/cpu-defs.h:23:2: error: #error cpu.h included from common code
>   #error cpu.h included from common code
>    ^~~~~
> In file included from /<qemu_dir>/target/ppc/cpu.h:25,
> from <qemu_dir>/include/hw/ppc/pnv.h:24,
> from <qemu_dir>/include/hw/ppc/pnv_xscom.h:24,
>                   from ../hw/ssi/pnv_spi.c:12:
> <qemu_dir>/include/exec/cpu-defs.h:34:10: fatal error: cpu-param.h: No such file or directory
>   #include "cpu-param.h"
>            ^~~~~~~~~~~~~
> compilation terminated.
> /
> 
> Hence shall I keep pnv_spi.c in /hw/ppc/ ?


Can't we "fix" pnv_xscom.h to be more friendly ? with forward declarations
of the Pnv* types ?


Thanks,

C.


