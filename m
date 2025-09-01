Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53921CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1Zr-0007E2-FZ; Mon, 01 Sep 2025 06:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ut1Zn-0007DS-D6; Mon, 01 Sep 2025 06:15:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ut1Zi-0003AZ-OK; Mon, 01 Sep 2025 06:15:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7BA0356F374;
 Mon, 01 Sep 2025 12:15:33 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id FT0KCVafiScx; Mon,  1 Sep 2025 12:15:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7364556F378; Mon, 01 Sep 2025 12:15:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7135256F377;
 Mon, 01 Sep 2025 12:15:31 +0200 (CEST)
Date: Mon, 1 Sep 2025 12:15:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com, 
 thuth@redhat.com, rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 3/4] hw/ppc: Add a test machine for the IBM PPE42
 CPU
In-Reply-To: <e867b3af-c2fc-4776-8c47-bff7114e29f8@redhat.com>
Message-ID: <7b00cd62-f432-8b49-2478-93c73af29023@eik.bme.hu>
References: <20250826201920.335308-1-milesg@linux.ibm.com>
 <20250826201920.335308-4-milesg@linux.ibm.com>
 <e867b3af-c2fc-4776-8c47-bff7114e29f8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1145442367-1756721731=:23565"
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

--3866299591-1145442367-1756721731=:23565
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 1 Sep 2025, Cédric Le Goater wrote:
> On 8/26/25 22:17, Glenn Miles wrote:
> I would introduce a specific MachineState for the ppe42 Machine:
>
>  struct Ppe42MachineState {
>    /* Private */
>    MachineState parent_obj;
>    /* Public */

Private/public comments are not recommended any more for QOM objects 
since commit 067109a11c8 just an empty line after parent_obj.

Regards,
BALATON Zoltan
--3866299591-1145442367-1756721731=:23565--

