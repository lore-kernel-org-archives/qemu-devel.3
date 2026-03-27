Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BA310BA426
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5z1X-0007K9-NK; Fri, 27 Mar 2026 00:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5z1U-0007Js-Vp
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:42:17 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5z1T-0000my-JK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1774586520; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=H6R/nrMg06rLklFTEWSbXyBRqCU+SBZLE76Xx4Lbvf+MQQF7eo5LTzZmzlY2OQzNDoFF0eFEmLRZgoCyMeurauZYeldJSQtAGAo9WcFZw1K51yKmDUAGN/7xcu+IK+wyKLjgPxiPL2mLh/5AuLDTMTcU25AUOwrpqMIs0n9UURI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774586520;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kKaJoWpmOLfBMwgh1rUGGDxI0NQzj6VH1SN46KJuST8=; 
 b=Yc3Act7kbmblZzokdavmyonIxHF+7Fb3QVl56YB/7VvH9UsFBMJmmPqDvRW0GR3pQAygcD1KD8aDx668aqxAmp9J+zzvmIMRTPZhWheRaM2BX+CSKnDAblmdLYGL7aXP3XwvtuuYTj4hKsYRnkdg0ELmFq/pdlmegbnOutNOb4I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774586520; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=kKaJoWpmOLfBMwgh1rUGGDxI0NQzj6VH1SN46KJuST8=;
 b=PoEUTF1Aeyl7sZwkUvVqqPauLczPgCUxEor1C3e5ysVImNfXBjorpZQpYPjLqCNh
 9ErWIEIvwarZgbUmJuie3W2Mfsf6/svNe83HJVTRBY24jvyAC1fvTehO+n7jaGeWdNK
 +M7MiBhmv8YsLa9n+gtD0oipPmEBEkG5NsFID2I0=
Received: by mx.zohomail.com with SMTPS id 1774586519047172.9053944984032;
 Thu, 26 Mar 2026 21:41:59 -0700 (PDT)
Date: Fri, 27 Mar 2026 04:41:54 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 8/9] target/i386/mshv: filter out CET bits in cpuid
Message-ID: <20260327-furry-upbeat-jaguar-6e1bcd@anirudhrb>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
 <20260323115711.353793-9-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323115711.353793-9-magnuskulke@linux.microsoft.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 23, 2026 at 12:57:10PM +0100, Magnus Kulke wrote:
> e46dcef1d0 introduced CET_U/CET_S xstate bits in the ExtSaveArea. The
> response in EBX of a 0x4,1 cpuid query will contain a size contingent on
> what the guest enabled in the IA32_XSS MSR (compacted xsave size).
> 
> Since the MSHV accelerator currently responds with static answers to
> 0x4d cpuid queries, we'll have to disable those bits, even if the host
> supports them.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


