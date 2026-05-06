Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE7DCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 09:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKYJ8-0004G7-JN; Wed, 06 May 2026 05:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wKYJ6-0004Fy-Bv
 for qemu-devel@nongnu.org; Wed, 06 May 2026 05:12:40 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wKYJ4-0001IW-R3
 for qemu-devel@nongnu.org; Wed, 06 May 2026 05:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=72MUBjEeCZ0ZyEbbnlRLoIj+WK/QTXXwWqZZroe5Ib4=; b=nxodd9gsX7sIgbI
 ky6URVmJsPhOY2K/lrKJJ+5qF+1YLJkvGn1MiWfIy4d1cUgFn9hRmPDqHSwsLd+6i4hYPKmkpit5u
 Nd3RkOmHjwcIDkBDAjUv8cuYl6FRF4t5VLDARPKLQqm7FbRzuAy/fYS/bqmtYUnS5cNJzKTQ4HsHd
 MI=;
Date: Wed, 6 May 2026 11:16:59 +0200
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] docs/devel/codebase: add link to rev.ng video series
Message-ID: <afsFdNbJQDFctL2C@hive.localdomain>
References: <20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/04/26, Pierrick Bouvier wrote:
> Those two videos provide an excellent introduction for a new QEMU
> developer, and such resources are rare.
> 
> Kudos to Anton Johansson <anjo@rev.ng> for creating this.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  docs/devel/codebase.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
> index f09307b8971..f065d7eee0b 100644
> --- a/docs/devel/codebase.rst
> +++ b/docs/devel/codebase.rst
> @@ -8,6 +8,11 @@ organized.
>  Beyond giving succinct descriptions, the goal is to offer links to various
>  parts of the documentation/codebase.
>  
> +Those two videos are an excellent introduction to QEMU codebase:

Thanks for posting this!:)

For the text I'd suggest something like

  "For an overview of the codebase in video form covering user- and system mode,
  these provide an excellent introduction:"

If anyone has suggestions/corrections please feel free to let me know
and I'll make a revised version.

Reviewed-by: Anton Johansson <anjo@rev.ng>

