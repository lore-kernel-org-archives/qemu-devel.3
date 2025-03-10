Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A82EC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trd6x-0001Yv-S1; Mon, 10 Mar 2025 09:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trd6t-0001Xg-Qx; Mon, 10 Mar 2025 09:23:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trd6o-0006IZ-Fq; Mon, 10 Mar 2025 09:23:59 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1B5624E602E;
 Mon, 10 Mar 2025 14:23:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XvkD-BHqHTfr; Mon, 10 Mar 2025 14:23:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C9D5B4E6029; Mon, 10 Mar 2025 14:23:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C787874577D;
 Mon, 10 Mar 2025 14:23:46 +0100 (CET)
Date: Mon, 10 Mar 2025 14:23:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org, 
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>, 
 Paul Durrant <paul@xen.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, 
 Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 00/16] make system memory API available for common code
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
Message-ID: <f231b3be-b308-56cf-53ff-1a6a7fb4da5c@eik.bme.hu>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, 9 Mar 2025, Pierrick Bouvier wrote:
> The main goal of this series is to be able to call any memory ld/st function
> from code that is *not* target dependent.

Why is that needed?

> As a positive side effect, we can
> turn related system compilation units into common code.

Are there any negative side effects? In particular have you done any 
performance benchmarking to see if this causes a measurable slow down? 
Such as with the STREAM benchmark:
https://stackoverflow.com/questions/56086993/what-does-stream-memory-bandwidth-benchmark-really-measure

Maybe it would be good to have some performance tests similiar to 
functional tests that could be run like the CI tests to detect such 
performance changes. People report that QEMU is getting slower and slower 
with each release. Maybe it could be a GSoC project to make such tests but 
maybe we're too late for that.

Regards,
BALATON Zoltan

