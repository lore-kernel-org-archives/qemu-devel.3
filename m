Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A965CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyZb-0006c7-5H; Thu, 07 May 2026 09:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1wKyZZ-0006aQ-Ce
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:15:25 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1wKyZX-0004yp-Ve
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:15:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1778159714; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iShMEgGh3Aiqa4h3dfHTCKFnu4tvFS5CoKDFoIv4f+r6oArb8Dlpk4d8madmFJYBuJmHD3lKCqQa9IKGL7aerP/JIbl/HkiZbsf0NHyFgXZO7SJV3FAuXkCJhGcd+zH9Mtxm3lGvKPBaQHe6VbAWi4fPSn/9/hOhWJAPqcjS4Fk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778159714;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=X0MMzOJqdoE0ReSi+1F1lH+NvpaTChkX5g9gjckY/HE=; 
 b=mMPSRAGyWi+EN3OTAfjx6PjID3N6Sstiei9cNSOWeYJvUhUMH1xLSQE9snoVuBGB64vx00GdBPG8yf6rSB8wPded6izM7BBL2MCALjUh/3AsYBI914gnhlhoG6ooxT4JmnkkeHSXofF3j/JZmp7F730Q9loyXpJZbrTuzVsuOfM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778159714; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=X0MMzOJqdoE0ReSi+1F1lH+NvpaTChkX5g9gjckY/HE=;
 b=y0T/A/UYfjIpBIqdEqxK0t5Cvo7jsBwyxAwdXbABm5k9ILgnOpSxl0+VKgXnOaZO
 33VICBbqc0JsEWxMLmpBXDjVzozUpQrXJ4RHn3Dqmqd2PsAXtm5nx6/OY0vghBUq9fd
 3spSuelGRqqjHwFsOksg9P7J9jTopHe3IG1kqRh0=
Received: by mx.zohomail.com with SMTPS id 177815971161199.61687882983472;
 Thu, 7 May 2026 06:15:11 -0700 (PDT)
Date: Thu, 7 May 2026 13:15:06 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/7] include/hw/hyperv: add hv_vp_register_page struct
 definition
Message-ID: <20260507-furry-pheasant-of-wealth-c3b0a6@anirudhrb>
References: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
 <20260505185028.237207-4-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505185028.237207-4-dblanzeanu@linux.microsoft.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, May 05, 2026 at 09:50:24PM +0300, Doru Blânzeanu wrote:
> Define the `hv_vp_register_page` structure that the linux kernel uses
> to allow access to vcpu registers.
> 
> This structure is going to be used in later patches to access vcpu
> registers.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  include/hw/hyperv/hvgdk.h |   2 +
>  include/hw/hyperv/hvhdk.h | 105 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


