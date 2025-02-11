Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B327C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrQJ-0006Ef-AD; Tue, 11 Feb 2025 09:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1thrPn-00064N-IB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:39:09 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1thrPl-0002bR-6x
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:39:07 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7697F4E6014;
 Tue, 11 Feb 2025 15:39:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 2L6-XcMBaOV5; Tue, 11 Feb 2025 15:38:59 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 822244E600E; Tue, 11 Feb 2025 15:38:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 802D474577C;
 Tue, 11 Feb 2025 15:38:59 +0100 (CET)
Date: Tue, 11 Feb 2025 15:38:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PULL 4/7] tests/functional: Add a ppc sam460ex test
In-Reply-To: <20250211123144.37617-5-thuth@redhat.com>
Message-ID: <a7615640-96d9-4712-e0c2-f5dfaa3fac60@eik.bme.hu>
References: <20250211123144.37617-1-thuth@redhat.com>
 <20250211123144.37617-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1450815247-1739284739=:29847"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--3866299591-1450815247-1739284739=:29847
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 11 Feb 2025, Thomas Huth wrote:
> From: Cédric Le Goater <clg@redhat.com>
>
> The test sequence boots from kernel a sam460ex machine with a
> virtio-net device to check PCI.
>
> The buildroot is built with config :
>
>  BR2_powerpc=y
>  BR2_powerpc_440fp=y
>
> and the kernel with the '44x/canyonlands' deconfig and virtio support.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Message-ID: <20250203092606.491933-1-clg@redhat.com>

Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
--3866299591-1450815247-1739284739=:29847--

