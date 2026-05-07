Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18D6CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKuxm-0003K7-Rp; Thu, 07 May 2026 05:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wKuxl-0003Jx-Kp
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:24:09 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wKuxk-0008Pm-BA
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:24:09 -0400
Received: from example.com (p3e9c0e4f.dip0.t-ipconnect.de [62.156.14.79])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0248420B7165;
 Thu,  7 May 2026 02:24:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0248420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778145843;
 bh=EzUf1HnyHHRRfERQeQCyZMKjM6QgpkU40jqMFhYBVqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BHCzrvM+A0XX1Clsq6RD7BX3bKdxpPUtBw5QvJSKCjWFw8glx29P3BgEjZ066PSIJ
 /uPjroB7cfS8kqx3xUs+qOhLOMCgtUqTaiXCGKOTcsR8snRM+1Ge4MrpiA7hm8CIq8
 MK/QHWT6K3Z8TVnEqh1UOtzpn5yjOCzZBfFAVdEI=
Date: Thu, 7 May 2026 11:24:01 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>
Subject: Re: [PATCH] MAINTAINERS: =?iso-8859-1?Q?Ad?=
 =?iso-8859-1?Q?d_Doru_Bl=E2nzeanu?= as MSHV reviewer
Message-ID: <afxaMe73222BkQYP@example.com>
References: <20260506102156.501805-1-magnuskulke@linux.microsoft.com>
 <afxNRhpeEOYTldCX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afxNRhpeEOYTldCX@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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

On Thu, May 07, 2026 at 09:28:54AM +0100, Daniel P. Berrangé wrote:
> On Wed, May 06, 2026 at 12:21:56PM +0200, Magnus Kulke wrote:
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Given this will result in Doru being automatically CC'd on patch
> mails, it ought to have either a signed-off-by, or at least a
> reviewed-by, from Doru to indicate they are happy with this.
> 

Thx, that makes sense, I asked Doru to review.

