Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B00CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKutE-0001ZV-P1; Thu, 07 May 2026 05:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wKutD-0001ZG-MW
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:19:27 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wKutC-0006sG-Bb
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:19:27 -0400
Received: from linux.microsoft.com (unknown [86.121.140.248])
 by linux.microsoft.com (Postfix) with ESMTPSA id E0BE020B7165;
 Thu,  7 May 2026 02:19:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0BE020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778145560;
 bh=0OEHOXswTYYJvRYKdS1PRhWjnUtJ/pn5M+ISObLTmh4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mpYKlnFTr60Yr5M7oELlgDQeCTAxxcg+sYwRRgVHcD3PndDMfvSmIgSNkxXl3v1DN
 9QkfDwAExsQpxXhu1ISu01gLiIO4ppcKKJvrR2/bi7kH7qv3JdDEqlRvraWs/4WuuT
 koEWUWbPtWrc6yIGm2+f2P8In/lN2gnY2mlKFL7I=
Date: Thu, 7 May 2026 12:19:12 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>
Subject: Re: [PATCH] MAINTAINERS: =?iso-8859-1?Q?Ad?=
 =?iso-8859-1?Q?d_Doru_Bl=E2nzeanu?= as MSHV reviewer
Message-ID: <afxZEKJboh73NBCo@linux.microsoft.com>
References: <20260506102156.501805-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506102156.501805-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Wed, May 06, 2026 at 12:21:56PM +0200, Magnus Kulke wrote:
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

