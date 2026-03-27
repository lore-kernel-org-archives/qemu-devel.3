Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A11A10BA422
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ydE-00005Y-DV; Fri, 27 Mar 2026 00:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5ydC-000058-IK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:17:10 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5ydB-0004R8-08
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:17:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1774585014; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mCiOP36+/WBzTVxO+wz9+mwBJH0nQTYNT/KzpLO8GpGSWlL8XGqzReg6P0DuzDCgnb83qEW/YSBX3yQfq2gvmgQ5cE5UEguzlP4n4vqPXFQ61c8jykl5tg3F5NFZkqG5Eljfyuo8yEE3utOcv+u4DxCy8B+WjrLMZb3g5/gYoB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774585014;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=U4xQzVLlV5JaejnEGKR4TDz6ZHJ92C1kKu13MarbLys=; 
 b=UFZFk92wRhBCDG5NWQYxn1k7vEZJ2zKYgTcifeqSm0V4U+YAZvmj5Txn1Pve9IlwZXmJckcD0j1PE7ImKdC+GgjcFzTNNz9mbVOBXNiCf8SVt82kisJ4YzhHNPpHjpcRQZdWCFsaAoANlYX9VMB9MGyzVwCEHEL6shNx/E24vuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774585014; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=U4xQzVLlV5JaejnEGKR4TDz6ZHJ92C1kKu13MarbLys=;
 b=GCkithJnL2YVyvTniafo5ARz9CA+lZm61MXNolK77svvylZSb28RIjBfr1e7dsFF
 OPi5lpMyUcFmcSg8yJ7H//XVrMr3nNyf7H1LcThcrOubzW5REf4k3N4rOkZzPhTKWdp
 Y5FeFiZo24GZ0smhi8bIjAO2sdS+alNs/yrA205I=
Received: by mx.zohomail.com with SMTPS id 1774585012796959.7469330877027;
 Thu, 26 Mar 2026 21:16:52 -0700 (PDT)
Date: Fri, 27 Mar 2026 04:16:48 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 1/9] accel/mshv: use mshv_create_partition_v2 payload
Message-ID: <20260327-undetectable-succinct-serpent-cf48be@anirudhrb>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
 <20260323115711.353793-2-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323115711.353793-2-magnuskulke@linux.microsoft.com>
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

On Mon, Mar 23, 2026 at 12:57:03PM +0100, Magnus Kulke wrote:
> When using the extended request format we can instruct the hypervisor to
> provision enough space for requested XSAVE features. This is required
> for supporting QEMU models provided via the -cpu flag properly.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> ---
>  accel/mshv/mshv-all.c          |  71 ++++++++++--
>  include/hw/hyperv/hvgdk_mini.h |   2 +
>  include/hw/hyperv/hvhdk.h      | 195 +++++++++++++++++++++++++++++++++
>  3 files changed, 261 insertions(+), 7 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


