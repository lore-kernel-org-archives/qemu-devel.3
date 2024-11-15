Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7526DD6DDD8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 13:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBw7D-0003J7-1M; Fri, 15 Nov 2024 08:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1tBw7B-0003Iw-IV
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 08:11:57 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1tBw78-0004jm-N3
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 08:11:57 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:94a7:0:640:198e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7928F60B95;
 Fri, 15 Nov 2024 16:11:46 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8011:701:66e1:20a5:ba04:640b] (unknown
 [2a02:6bf:8011:701:66e1:20a5:ba04:640b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id iBNATh5AZ4Y0-eb5xLDzW; Fri, 15 Nov 2024 16:11:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1731676305;
 bh=rSFiDEf6GCIKTBQ64/uR6HhLtdm2bj5zXAbCmyeMcNA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=il4X6uxUm0ofVSswfLGnPejKUM8ko6HdavmFpQ3KnETN3L80Vxe2qjBwhNTVS2DeN
 kSxIk+MhYn7iyGpCel3004jaVwN8a723bt5XXbBmEA9gfpA9V+PmVf6mV9dcvptOhE
 0pdMbHA1Gsg2qZCwzu2eRROLx0BaeBGd49wC3lY8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7e485305-8957-411a-a792-d07468f77264@yandex-team.ru>
Date: Fri, 15 Nov 2024 16:11:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] target/i386: Update EPYC CPU models for Cache
 property, RAS, SVM feature bits
To: Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com
References: <cover.1731616198.git.babu.moger@amd.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <cover.1731616198.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi!

On 11/14/24 23:36, Babu Moger wrote:
> 
> This series addresses the following issues with EPYC CPU models.
> 
> 1. Update the L1, L2, L3 cache properties to match the actual hardware (PPR).
>     This needs to be updated on all the EPYC models.
> 2. RAS feature bits (SUCCOR, McaOverflowRecov).
> 3. Add SVM feature bits which are required in nested guests.
> 4. Add perfmon-v2 on Genoa.
> 5. Add missing feature bit fs-gs-base-ns(WRMSR to {FS,GS,KERNEL_G}S_BASE
>     is non-serializing).
> 

Seems good for me. I've tested cache changes.
If needed, Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>

> Dropped EPYC-Turin model for now. Some of the feature bits
> (srso-user-kernel-no, eraps, rapsize) are still work in progress in
> the kernel. Will post them later.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
> ---
> v4: Some of the patches in v3 are already merged. Posting the rest of the patches.
>      Dropped EPYC-Turin model for now. Will post them later.
>      Added SVM feature bit as discussed in
>      https://lore.kernel.org/kvm/b4b7abae-669a-4a86-81d3-d1f677a82929@redhat.com/
>      Fixed the cache property details as discussed in
>      https://lore.kernel.org/kvm/20230504205313.225073-8-babu.moger@amd.com/
>      Thanks to Maksim and Paolo for their feedback.
> 
> v3: Added SBPB, IBPB_BRTYPE, SRSO_USER_KERNEL_NO, ERAPS and RAPSIZE bits
>      to EPYC-Turin.
> 
> v2: Fixed couple of typos.
>      Added Reviewed-by tag from Zhao.
>      Rebased on top of 6d00c6f98256 ("Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging")
> 
> v3: https://lore.kernel.org/kvm/cover.1729807947.git.babu.moger@amd.com/
> v2: https://lore.kernel.org/kvm/cover.1723068946.git.babu.moger@amd.com/
> v1: https://lore.kernel.org/qemu-devel/cover.1718218999.git.babu.moger@amd.com/
> 
> 
> Babu Moger (5):
>    target/i386: Update EPYC CPU model for Cache property, RAS, SVM
>      feature bits
>    target/i386: Update EPYC-Rome CPU model for Cache property, RAS, SVM
>      feature bits
>    target/i386: Update EPYC-Milan CPU model for Cache property, RAS, SVM
>      feature bits
>    target/i386: Add feature that indicates WRMSR to BASE reg is
>      non-serializing
>    target/i386: Update EPYC-Genoa for Cache property, perfmon-v2, RAS and
>      SVM feature bits
> 
>   target/i386/cpu.c | 299 +++++++++++++++++++++++++++++++++++++++++++++-
>   target/i386/cpu.h |   2 +
>   2 files changed, 300 insertions(+), 1 deletion(-)
> 

-- 
Best regards,
Maksim Davydov

