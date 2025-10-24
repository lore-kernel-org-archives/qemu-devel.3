Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9035ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 11:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCG82-0002rT-NG; Fri, 24 Oct 2025 07:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCG7u-0002rB-Pw; Fri, 24 Oct 2025 07:38:34 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCG7r-0005jl-1p; Fri, 24 Oct 2025 07:38:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CAF4F59744F;
 Fri, 24 Oct 2025 13:38:25 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 8VHHAj_5Qyh2; Fri, 24 Oct 2025 13:38:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C6E31597307; Fri, 24 Oct 2025 13:38:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C506E5972EB;
 Fri, 24 Oct 2025 13:38:23 +0200 (CEST)
Date: Fri, 24 Oct 2025 13:38:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Vishal Chourasia <vishalc@linux.ibm.com>
cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com, 
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com, 
 hpoussin@reactos.org
Subject: Re: [Patch v9 6/6] ppc: Pass error_fatal to load_image_targphys()
In-Reply-To: <20251024092616.1893092-9-vishalc@linux.ibm.com>
Message-ID: <c262a6fe-27cf-6f67-6394-2e563f542498@eik.bme.hu>
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-9-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Fri, 24 Oct 2025, Vishal Chourasia wrote:
> Pass error_fatal to load_image_targphys() calls in ppc machine initialization
> to capture detailed error information when loading firmware, kernel,
> and initrd images.
>
> Passing error_fatal automatically reports detailed error messages and
> exits immediately on failure. Eliminating redundant exit(1) calls, as
> error_fatal handles termination
>
> The behavior remains functionally identical, but error messages now
> come directly from the loader function with more context about the
> failure cause.
>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Thank you for doing this. It's a nice clean up making these boards more 
concise and readable.

Regards,
BALATON Zoltan

