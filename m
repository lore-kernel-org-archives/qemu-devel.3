Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B241CF6D2C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw020-0005sl-Du; Wed, 02 Oct 2024 10:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sw01u-0005ln-Ak
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:08:38 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sw01r-0005K5-4U
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:08:38 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MaIGB-1sPmIK1Bor-00S7Ns; Wed, 02 Oct 2024 16:08:29 +0200
Message-ID: <1251d17b-71f4-4630-b71f-990860bd9366@vivier.eu>
Date: Wed, 2 Oct 2024 16:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Noah Goldstein <goldstein.w.n@gmail.com>, qemu-devel@nongnu.org
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aPSOyWnmtwJnWqanmmvwW1B1+3j8vmyOkmQMQEgqWQHacrF0wk/
 shAzWUMWplJ5ryTwPtLT/EWvbS3Km4ZX1sqHWsVIezuZv7H1tB1Zcs2ZUP1VwvMQEjlqFok
 J6rWp5+1hsBWV+cSz4lC8h0NXTHCEvghcb2SzK0BNTgCy/wN4LWl7gQVN1vULdBHA8kgP0v
 fE9iMpoCM1ybNL6qUSohA==
UI-OutboundReport: notjunk:1;M01:P0:sk8Rw10Imb4=;sxM64mxiLQSB/Xq8S8bNfxroGJ2
 DT9fq40goEY/MQrlueepmSiOCxdbQK6GwS609OlJ99IxOe1D2Di74Cbzs4KCx4OTpe0/QoKCe
 rZRNGDI5uY1/TbF/k6T/WmDUq7XOowBOJb/9bWWkMLalfv5REoLEZGmTnARadxIXSeW6mJsSV
 CySoN5BvgV697RYjIAihUR07OeoPrA89Gz3+8FafLnUrtKk56+dI+49UUtDXMIXf17VnVY5xd
 SKnZF+r5y2/uVYAgEQtwOaF1q5hzK9LwLF9L60By90D+SLbfamgRQbPEfNkr2f22anGDmNdSl
 1giy2JoEQJBgSbKQ1B0uQ2tS4LE9mjcSsIz44Fj4yo2tqc/UP1IrCiWSykzllCpVr3team194
 IeuLNghf0XQo2XT4Sq9ILVXm+PpxLkvlHq3FBB5Bfmym97yxnhaV2oH6PXMieYM8ezeaY+raw
 3rSQ/xcP0viMHP3U3f/FrfwJU6tww7Ez4+00qtzWwHD6eD+XyOyneKyG/qaUTX0D17kyn7eFa
 tJLtLlLUM6b/403qjCuk01BM9BQ1SGfl8P24PzKosOOMxlNztYtgzaX7ZSx0wsLUvspbX8lkZ
 q43pn87QyxbQjhSQw9RvCcHETbpGbjhV9o75mkSWsLcgWzs/EOW/G8ktW7ap5A3juJLcT2Dal
 95m6EuIzn6Yo2zuVb491p1Lc7xIICPVxBKl8xXck90SreuxlnRjJRj+2+S/nmq4ba8xhFH375
 Nlytk1Y5eK24k6GoPXIFiQ9DcElE78vZQ==
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 02/10/2024 à 10:08, Ilya Leoshkevich a écrit :
> On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
>> The new option '-qemu-children' makes it so that on `execve` the
>> child
>> process will be launch by the same `qemu` executable that is
>> currently
>> running along with its current commandline arguments.
>>
>> The motivation for the change is to make it so that plugins running
>> through `qemu` can continue to run on children.  Why not just
>> `binfmt`?: Plugins can be desirable regardless of system/architecture
>> emulation, and can sometimes be useful for elf files that can run
>> natively. Enabling `binfmt` for all natively runnable elf files may
>> not be desirable.
> 
> Another reason to have this is that one may not have root permissions
> to configure binfmt-misc.

A little note on that: binfmt_misc is now part of the user namespace (since linux v6.7), so you can 
configure binfmt_misc as a non root user in a given namepace.

There is helper to use it with unshare from util-linux, you can do things like that:

   With 'F' flag, load the interpreter from the initial namespace:

     $ /bin/qemu-m68k-static --version
     qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
     Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
     $ unshare --map-root-user --fork --pid 
--load-interp=":qemu-m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\x00\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/bin/qemu-m68k-static:OCF" 
--root=chroot/m68k/sid
     # QEMU_VERSION= ls
     qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
     Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
     # /qemu-m68k  --version
     qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
     Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers

   Without 'F' flag, from inside the namespace:

     $ unshare --map-root-user --fork --pid 
--load-interp=":qemu-m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\x00\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/qemu-m68k:OC" 
--root=chroot/m68k/sid
     # QEMU_VERSION= ls
     qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
     Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
     # /qemu-m68k  --version
     qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
     Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers

Thanks,
Laurent


