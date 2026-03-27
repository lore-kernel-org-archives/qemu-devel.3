Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B330310BA422
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yjN-0002UD-9t; Fri, 27 Mar 2026 00:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5yjI-0002Qe-Rc
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:23:30 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5yjH-0005AZ-6b
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:23:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1774585390; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QfVeJrB0/lAPGaNPsosoUhXaq9Lgq32Gl1qUyOlMAOHLpxxsw5K9+H0KrpxJdtqNcJ8KP0J4JyFygEQ8P02YJwXOz+syPXU0PLtFZu2mLTJQh5JKJJw6fqG8325uvmYEjc2MZc404BF2W2WNZFt0nbeVg1abkCUoBkY/7LWTA1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774585390;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6oE3bYwApYPVsW0ty1Fo0dWirlR0eRi+IuqViRgk/gE=; 
 b=X+1HK96lfokV+67LFx9Zf3a7E6u9xVz3Rwx5vaVqp/p5FC5VXgDpqiUqMKx+G+wjuhuU41f6JHepL4SB8wiViMnvFLKGPAFQ8GYMC2laYE+7f7L0imavItwiknTYN5e/RwHgQGhA8T+tavPeikI4wzClhsScFBJdahYSHMKCYIk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774585390; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=6oE3bYwApYPVsW0ty1Fo0dWirlR0eRi+IuqViRgk/gE=;
 b=poq649ds1krC7wTBWHfMJUoIw5/7MQP4+115BPEX3Ivu2xqq53lG7xZlsdg03S7k
 wA6GcPNkIFSeI0M4aoOPLXZf2kckyE/6fGuoIckOP8gjSgK+ft2RVVhpj1lH5AS0bNp
 gnAlOApPhD18YsLskspoWUzwrc5umEDV3zsqWJPU=
Received: by mx.zohomail.com with SMTPS id 1774585389100340.84870623555423;
 Thu, 26 Mar 2026 21:23:09 -0700 (PDT)
Date: Fri, 27 Mar 2026 04:23:05 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 9/9] accel/mshv: disable la57 (5lvl paging)
Message-ID: <20260327-petite-stoat-of-success-ade662@anirudhrb>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
 <20260323115711.353793-10-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323115711.353793-10-magnuskulke@linux.microsoft.com>
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

On Mon, Mar 23, 2026 at 12:57:11PM +0100, Magnus Kulke wrote:
> This change disable la57 paging on the mshv hypervisor on both the
> mshv processor feature bitmap and mask the cpuid feature leaf to the
> guest.
> 
> Since the removal of hypervisor-assisted gva=>gpa translation in
> 1c85a4a3d7 we have seen MMIO errors in guests on la57-enabled hw. We
> will have to investigate and test this further.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       |  7 +++++++
>  include/system/mshv_int.h   |  2 ++
>  target/i386/mshv/mshv-cpu.c | 12 ++++++++++++
>  3 files changed, 21 insertions(+)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


