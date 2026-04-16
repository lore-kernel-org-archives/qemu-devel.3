Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E2EF8A167
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDLVN-0007EC-Ha; Thu, 16 Apr 2026 08:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wDLV3-0007Dh-VW
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:07:15 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wDLV2-0001Uh-JN
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:07:13 -0400
Received: from example.com (unknown [167.220.208.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0881D20B7128;
 Thu, 16 Apr 2026 05:07:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0881D20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776341231;
 bh=0zpssSWeGlcgfOyr2x6FLeqEomlYlZp0/XFqQBAXZds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rzIbGxM2bE32Ccd3Zo4gpYFfumpo745p8zmFwE2VWsudWHjnnJFM2rGq5PUhnKP8q
 /mzgc/kQTmcsgPqFnEUb1JMwXS3XxmsnRumUbBrLgq6xyEqgWd8QMVZz4Kix9EBlX2
 sxQh21A1WXr9MTWyakDzP/sH4lQSntPk748Tawto=
Date: Thu, 16 Apr 2026 14:07:06 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v5 8/9] target/i386/mshv: use hv-provided [0xD,1+2].EBX
Message-ID: <aeDQ6jvV94BWRte6@example.com>
References: <20260415170012.520934-1-magnuskulke@linux.microsoft.com>
 <20260415170012.520934-9-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415170012.520934-9-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 15, 2026 at 07:00:11PM +0200, Magnus Kulke wrote:
>      }
> +
> +    if (func == 0x07 && idx == 0 && reg == R_ECX) {
> +        ret &= ~CPUID_7_0_ECX_CET_SHSTK;
> +    }

gah, sorry about that, please disregard. this is a leftover
that will disable CET shadowstack anyway. I'll post a new
revision.

>  
> -- 
> 2.34.1

