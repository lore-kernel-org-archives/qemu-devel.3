Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D94CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGF0M-0003RY-4V; Mon, 12 Oct 2026 08:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xGF02-0003QZ-5r
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:19:26 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xGF00-0006NI-OC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:19:25 -0400
Received: from example.com (unknown [167.220.208.79])
 by linux.microsoft.com (Postfix) with ESMTPSA id F004920B7169;
 Mon, 12 Oct 2026 05:19:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F004920B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791807560;
 bh=cSWr/6dRPBS8RXtuL1ASH8v56OoYcLEYiS7iYhTYybQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YpSKGJNeFElrBmyHq0Zwf2nI+RtmyfiuxlosjsHYqrvwQxv7VtOKVoFZ2oTFHV//O
 G/r171kh1TdG2sHtJz+U+ajpNnKrly5m9q/p6w6VeH7gjUly9EDZsooyb2OgQXlqyx
 yiH80VlX9Zmt7c8Kjk6rQ5zNOusx3JQn/o0PaFz8=
Date: Mon, 12 Oct 2026 14:19:20 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 0/1] target/i386/mshv: fix read and write memory across
 the page boundary
Message-ID: <aszQSNCFtBnf1OhY@example.com>
References: <20260409175334.181249-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409175334.181249-1-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, Apr 09, 2026 at 08:53:33PM +0300, Doru Blânzeanu wrote:
> This fixes the guest memory reading and writing spanning multiple pages for mshv Port I/O.
> 
> Currently, the read_memory and write_memory functions only translate GVA-to-GPA once per buffer.
> In case the buffer is bigger than a page, the translation is only valid for the first page.
> 
> Doru Blânzeanu (1):
>   target/i386/mshv: fix read/write memory across the page boundary
> 
>  target/i386/mshv/mshv-cpu.c | 71 +++++++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 19 deletions(-)
> 
> -- 
> 2.53.0

included in mkulke-pull-20261006


