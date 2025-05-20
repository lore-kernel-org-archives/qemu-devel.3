Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE56C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 06:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHGlZ-0001LT-6B; Tue, 20 May 2025 02:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uHGlP-000172-Rh; Tue, 20 May 2025 02:47:49 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uHGlN-0006yy-TD; Tue, 20 May 2025 02:47:47 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6FDE8A4D97B;
 Tue, 20 May 2025 06:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E6EC4CEE9;
 Tue, 20 May 2025 06:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747723664;
 bh=n9eHYTR2G0ZOX2X+WcAxPwfwrHUt6xhEfBxV5W3ZGaU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AjeJfcboWc3Cvf46j/fHBWI9ENPs+NBSfbR6HNmDS5dFYzUnT2ZnHVGJVr5yrCiRr
 lQD+RsXw/oYji5pHQynUafr2DOa1N8jMJrrYYKWfLBOu39KHgAS3OUZz6cdLFOtcLA
 0vYAXJSGWIRZky7beBCJIYtSOzpOt2jXYS9EO8VwP/ajKlbpHQhH5Abm/CmwBwft+W
 /UOYWwYY+XCSWzdhAlQITCCNqWptjyVClfhqkzkWwL/y+CgDuD0cUJRL6Mh7L9EuSa
 /vclnZFd++vgbY3E9dsydVrqU5kFg9cMN2l0SlVoQC10Nfzue53p7+ggLAD/rjL0dB
 de1OqFMDKAjuQ==
Date: Tue, 20 May 2025 08:47:38 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/20] acpi/ghes: don't hard-code the number of
 sources for HEST table
Message-ID: <20250520084738.4dcf9cef@foz.lan>
In-Reply-To: <20250512154053-mutt-send-email-mst@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <1c024a700815fa4a100fc3bada477481fd266a83.1741374594.git.mchehab+huawei@kernel.org>
 <20250512154053-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Mon, 12 May 2025 15:42:27 -0400
"Michael S. Tsirkin" <mst@redhat.com> escreveu:

> On Fri, Mar 07, 2025 at 08:14:38PM +0100, Mauro Carvalho Chehab wrote:
> > The current code is actually dependent on having just one error
> > structure with a single source, as any change there would cause
> > migration issues.
> > 
> > As the number of sources should be arch-dependent, as it will depend on
> > what kind of notifications will exist, and how many errors can be
> > reported at the same time, change the logic to be more flexible,
> > allowing the number of sources to be defined when building the
> > HEST table by the caller.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Breaks CI:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/10007863974
> 
> I dropped the patchset for now, pls rebase and repost.

Compilation was happening fine for me. I suspect that some rebase
dropped a change here:

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a256f9d817cd..a1492bcaeb8d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2360,7 +2360,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              */
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
-                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SEA,
+                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
                                              paddr)) {
                     kvm_inject_arm_sea(c);
                 } else {

but somehow, ninja didn't detect and was keep using an already
compiled kvm.o object. Anyway, fixed at the new series:

	https://lore.kernel.org/qemu-devel/9404b305e0fefdb14dce4839c3d96ccedf0533e0.1747722973.git.mchehab+huawei@kernel.org/T/#u

And, just in case, I removed ./build directory and recompiled it
again.

Thanks,
Mauro

