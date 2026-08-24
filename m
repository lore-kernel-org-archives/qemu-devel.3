Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6332C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPUZ-0003YY-Om; Mon, 24 Aug 2026 03:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyPUY-0003Xn-Jo; Mon, 24 Aug 2026 03:53:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyPUU-0000HS-Lu; Mon, 24 Aug 2026 03:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787557944; bh=d/WhINceyfFzDuIKwGfByAbyYNtfQF1zra+7spTO9Fc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gWVrCsRjBJWMI5PO9yLqAV/wQEbsktboLFVIQtesA88Pm57tn8DPdI6k19KbVhVm5
 b47QtFsWUe4a2kFG9gHiqal8YyTt2/jstZ3SIFMffndWjeneujP+y/tU+dywl71QC4
 +lQcCeOdvUnB/oVg7YEbdrBi/OQfBZyBO7CqO3WQwc1/Uh2XRJMHPyksnajDHVpbku
 6clqi/+JrUusAppVRRtLZRRnuzQo4XgF4CgNwVYkPMDzB4K/4lUYs3v1BqovqOKS1D
 Uv1VtjM1mVjh0r2r5X7h3BHW6nY1Q4qxfSngcDYuB4UITOLRDaEDnD0mtjVQIQX8gD
 YeuE2x9qQFskA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 655FD1CDC19;
 Mon, 24 Aug 2026 10:52:24 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 25EEC414B53;
 Mon, 24 Aug 2026 10:52:59 +0300 (MSK)
Message-ID: <54914f3a-54a3-4cc4-a4e8-b8d03aa1362d@tls.msk.ru>
Date: Mon, 24 Aug 2026 10:52:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] whpx: i386: some fixes
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260812082814.27217-1-mohamed@unpredictable.fr>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260812082814.27217-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/12/26 11:28, Mohamed Mediouni wrote:
> Some (backportable) fixes for x86_64 whpx.
> 
> -cpu host on Intel CPUs works again without needing a -cpu host,vmx=off
> workaround.
> 
> A floating point state sync fix and re-injecting exceptions on debug outside
> of the int1 case.
> 
> Mohamed Mediouni (6):
>    whpx: i386: fix xsaves enablement in legacy probing path
>    hw/i386: fw_cfg: do not set VMX feature control on WHPX
>    whpx: i386: enable fast hypercall output
>    whpx: i386: synchronise PAT too
>    whpx: i386: work around Hyper-V FP state oddities
>    whpx: i386: inject back db

I'm picking this patch set for qemu 11.1.x stable series.

Thanks,

/mjt

