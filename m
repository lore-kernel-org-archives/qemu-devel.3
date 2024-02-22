Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8F8C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd84Z-0000B8-NI; Thu, 22 Feb 2024 07:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rd84X-00008K-U3; Thu, 22 Feb 2024 07:21:05 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rd84U-0006wo-Kl; Thu, 22 Feb 2024 07:21:05 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E32024E6006;
 Thu, 22 Feb 2024 13:20:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 1Hu2bOPa7_1u; Thu, 22 Feb 2024 13:20:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 44DCC4E6012; Thu, 22 Feb 2024 13:20:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 436CA7456B4;
 Thu, 22 Feb 2024 13:20:56 +0100 (CET)
Date: Thu, 22 Feb 2024 13:20:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Subject: Re: [PATCH v6 5/9] target/ppc: Simplify syscall exception handlers
In-Reply-To: <f0b24f1d-1d6d-477d-948d-976b89f922d6@linaro.org>
Message-ID: <b06a66b4-d31b-d106-1a4b-fcfc9e3bd1b2@eik.bme.hu>
References: <cover.1708601065.git.balaton@eik.bme.hu>
 <5441ced92de39f712378e8aac4346aef809301c7.1708601065.git.balaton@eik.bme.hu>
 <f0b24f1d-1d6d-477d-948d-976b89f922d6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-181539689-1708604456=:36052"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

--3866299591-181539689-1708604456=:36052
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 22 Feb 2024, Philippe Mathieu-Daudé wrote:
> On 22/2/24 12:33, BALATON Zoltan wrote:
>> After previous changes the hypercall handling in 7xx and 74xx
>> exception handlers can be folded into one if statement to simpilfy
>
> "simplify"
>
>> this code. Also add "unlikely" to mark the less freqiently used branch
>
> "frequently"

Could these be fixed up when merging please? I'd not resend again unless 
there's some other things need fixing.

Regards,
BALATON Zoltan

>> for the compiler.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   target/ppc/excp_helper.c | 24 ++++++++----------------
>>   1 file changed, 8 insertions(+), 16 deletions(-)
>
>
>
--3866299591-181539689-1708604456=:36052--

