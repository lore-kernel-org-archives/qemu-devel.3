Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B54C54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 14:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjK9H-0004s9-N9; Sun, 10 Mar 2024 10:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rjK9F-0004qT-BQ; Sun, 10 Mar 2024 10:27:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rjK9D-0006rr-NG; Sun, 10 Mar 2024 10:27:33 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 57F104E601B;
 Sun, 10 Mar 2024 15:27:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id n0zamS6Q7mQr; Sun, 10 Mar 2024 15:27:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5EBB64E6005; Sun, 10 Mar 2024 15:27:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5A4417456B4;
 Sun, 10 Mar 2024 15:27:23 +0100 (CET)
Date: Sun, 10 Mar 2024 15:27:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/ide/ahci: Rename ahci_internal.h to ahci-internal.h
In-Reply-To: <00a87926-49bf-4945-94fd-99f5c3a73bb0@linaro.org>
Message-ID: <a1a9cdfd-8c54-dc8c-6512-9c59b63cdcdf@eik.bme.hu>
References: <20240227131310.C24EB4E6005@zero.eik.bme.hu>
 <00a87926-49bf-4945-94fd-99f5c3a73bb0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1950503917-1710080843=:22453"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1950503917-1710080843=:22453
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 27 Feb 2024, Philippe Mathieu-Daudé wrote:
> On 27/2/24 14:13, BALATON Zoltan wrote:
>> Other headers now use dash instead of underscore. Rename
>> ahci_internal.h accordingly for consistency.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ide/{ahci_internal.h => ahci-internal.h} | 0
>>   hw/ide/ahci.c                               | 2 +-
>>   hw/ide/ich.c                                | 2 +-
>>   3 files changed, 2 insertions(+), 2 deletions(-)
>>   rename hw/ide/{ahci_internal.h => ahci-internal.h} (100%)
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Was this also queued somewhere? I haven't seen it merged neither with the 
trivial nor the misc-hw pull requests.

Regards,
BALATON Zoltan
--3866299591-1950503917-1710080843=:22453--

