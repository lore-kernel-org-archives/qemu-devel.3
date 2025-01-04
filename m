Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C591DE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 00:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTrmN-0000xJ-GT; Fri, 03 Jan 2025 19:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tTrmJ-0000wp-5r
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 19:12:31 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tTrmG-0001iO-AW
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 19:12:30 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 48CC24E6001;
 Sat, 04 Jan 2025 01:12:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id I1Led5Zy25Dc; Sat,  4 Jan 2025 01:12:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F3CDA4E6000; Sat, 04 Jan 2025 01:12:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF0D5757B1C;
 Sat, 04 Jan 2025 01:12:19 +0100 (CET)
Date: Sat, 4 Jan 2025 01:12:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Remove myself as Avocado Framework reviewer
In-Reply-To: <20250103233026.65717-1-philmd@linaro.org>
Message-ID: <c15e8494-0171-4f30-5bad-e2ff370d5569@eik.bme.hu>
References: <20250103233026.65717-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-822804277-1735949539=:66461"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-822804277-1735949539=:66461
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 4 Jan 2025, Philippe Mathieu-Daudé wrote:
> While I was very enthusiast when Avocado was presented to

I think 'enthusiastic' would be correct here.

Regards,
BALATON Zoltan

> the QEMU community and pushed forward to have it integrated,
> time passed and I lost interest. Be honest, remove my R: tag
> to not give fake expectation I'd review patches related to
> Avocado anymore.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> MAINTAINERS | 1 -
> 1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2101b512175..8d7044e91fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4196,7 +4196,6 @@ F: tests/tcg/Makefile.target
> Integration Testing with the Avocado framework
> W: https://trello.com/b/6Qi1pxVn/avocado-qemu
> R: Cleber Rosa <crosa@redhat.com>
> -R: Philippe Mathieu-Daudé <philmd@linaro.org>
> R: Wainer dos Santos Moschetta <wainersm@redhat.com>
> S: Odd Fixes
> F: tests/avocado/
>
--3866299591-822804277-1735949539=:66461--

