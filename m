Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A031606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=aurH7hYB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTfxB-00024L-AS; Wed, 18 Nov 2026 08:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xTfx8-00022S-4H
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 08:43:58 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xTfwx-0002vF-RP
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 08:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795009414; bh=JGsL22R63vJld+aS7F+MpzDiIXfAhMLMZ5zzwlRJ3zI=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=aurH7hYBg+YDiUI7bvaviOpn0NZPRafVDBtNqpRkIrRqsiwD0nR8ZxDsUj0sbXG6Q
 Ij4ok62gtx5Znq8oTX3T3HUo1C+8RUEyJ8PZayzK2G5LAjo/QxLAlQzJIdY6nIlZjq
 HdEAEit9pw1hFXzlZVkrrqhoChCzbRi7d8wZfwVN+IUJAv9d3p4vFJPTD0dNJzvwfV
 axv/FYAUXPfZnWidj/qSe4nRgvA1GgH5hIXcqRShe9ITOtSjaWEMAVLOkDTnIyWRJc
 aWHELzt7PVal3k7O1HDsvkmEx47kKED10EOvSa00OV4sE2toiYatG3wTNfdkvrYucR
 OZzYzsdcrfT/w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A94B01E7AE2;
 Wed, 18 Nov 2026 16:43:34 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9A3E44610CC;
 Wed, 18 Nov 2026 16:43:34 +0300 (MSK)
Message-ID: <66172cab-a9a3-4be6-a4e7-edc77ba9da44@tls.msk.ru>
Date: Wed, 18 Nov 2026 16:43:34 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] Misc TCG & HW patches for 2026-11-17
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
Content-Language: en-US, ru-RU
Cc: Tommaso Califano <tcalifano@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 02:23, Philippe Mathieu-Daudé wrote:

> Tommaso Califano (3):
>    hw/usb/dev-mtp: Fix recursive delete of directories
>    hw/usb/dev-mtp: Check length of class control request
>    hw/usb/dev-mtp: Stop processing SendObjectInfo after an error

Hi!

Philippe, there were a 7-patch series by Tommaso, grouped into a
single patch set because they touch the same file and all together
fix a single issue --
   https://gitlab.com/qemu-project/qemu/-/work_items/4529

Did you omit the other 4 changes because of the review comments?

The original patchset cover letter is
   https://lore.kernel.org/qemu-devel/20261112174907.158825-1-tcalifano@redhat.com/

Thanks,

/mjt

