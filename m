Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035DCCCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 17:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChcT-0004m4-N0; Sat, 25 Oct 2025 12:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vChcS-0004lg-0I
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:59:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vChcQ-0000sq-3N
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:59:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D9C5F5972FE;
 Sat, 25 Oct 2025 18:59:51 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id WXMk47hL0myM; Sat, 25 Oct 2025 18:59:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BF1D65972FB; Sat, 25 Oct 2025 18:59:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BD5915972F3;
 Sat, 25 Oct 2025 18:59:49 +0200 (CEST)
Date: Sat, 25 Oct 2025 18:59:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: deller@kernel.org
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Fam Zheng <fam@euphon.net>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 03/11] ncr710: Add driver for the NCR 53c710 SCSI chip
In-Reply-To: <20251025161901.32710-4-deller@kernel.org>
Message-ID: <20935a97-925f-3f58-998a-871dd0d04ca1@eik.bme.hu>
References: <20251025161901.32710-1-deller@kernel.org>
 <20251025161901.32710-4-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Sat, 25 Oct 2025, deller@kernel.org wrote:
> From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
>
> Add an emulation for the NCR 53c710 SCSI chip.
> This SCSI chip was used widely in historic machines, e.g. as SCSI core
> in the LASI controller in HP PA-RISC machines.

Shouldn't this patch come before the previous one as it defines functions 
that the LASI glue uses so I wonder if this compiles without this patch?

Regards,
BALATON Zoltan

