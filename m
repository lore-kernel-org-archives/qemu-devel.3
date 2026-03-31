Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2145A109B46C
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ZQJ-0004dt-A4; Tue, 31 Mar 2026 09:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7ZPg-0004St-S5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:45:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7ZPf-00016J-DY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:45:48 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0665D596A1D;
 Tue, 31 Mar 2026 15:45:44 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wD6I0G7Uwpkr; Tue, 31 Mar 2026 15:45:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 07E58596A24; Tue, 31 Mar 2026 15:45:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0690B596A23;
 Tue, 31 Mar 2026 15:45:42 +0200 (CEST)
Date: Tue, 31 Mar 2026 15:45:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/2] ati-vga Coverity fixes
In-Reply-To: <1122d60a-c7f9-466d-ab2b-c7bac6c66245@linaro.org>
Message-ID: <58689216-a72e-de88-de61-cca626e1bde9@eik.bme.hu>
References: <cover.1774904832.git.balaton@eik.bme.hu>
 <1122d60a-c7f9-466d-ab2b-c7bac6c66245@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-942512843-1774964742=:7804"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-942512843-1774964742=:7804
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 31 Mar 2026, Philippe Mathieu-Daudé wrote:
> On 30/3/26 23:09, BALATON Zoltan wrote:
>> Small patches to address Coverity warnings.
>> 
>> BALATON Zoltan (2):
>>    ati-vga: Silence warning about operator precedence
>>    ati-vga: Add upper limit to x-linear-aper-size property
>
> Queued via hw-misc tree, thanks.

Thanks. Could somebody review the cirrus-vga patch too so it could be 
picked up?

Regards,
BALATON Zoltan
--3866299591-942512843-1774964742=:7804--

