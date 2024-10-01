Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14029CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveKI-0001za-4a; Tue, 01 Oct 2024 10:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sveKC-0001lQ-1O; Tue, 01 Oct 2024 10:58:05 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sveK5-0007TQ-Aj; Tue, 01 Oct 2024 10:58:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 78CBCA428C6;
 Tue,  1 Oct 2024 06:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BF3C4CEC6;
 Tue,  1 Oct 2024 06:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727762565;
 bh=rGURyU0q5IpmNAxeZNOxzNUHTX2mHMJxAi0SPIdKbRY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QxgM0nZXvcli+3SxLlTIQ3jQ9d3zwVBWfTXDZqufc3WmF8iXSrAILhZhCHS6+JPGa
 hIt3nfJfj9TE5vBKSy/F1fSS0pSIXWrlh7aKJQUMEP4iuLJpcgrWzkBrkfrfqLISqK
 JsYvcjNOIEpbcrDytheCePB9MH0FwPE8DXtkpqqSdSgNQ3o0C/EhdAeCzrz1AjWFmC
 blBXzIj0a7uykHqmD+HWqXKstPMTqVqJPm2GP/XK6JptLkduy9dbR8OTopiIUZ96J3
 39CniiBYzPSVa3NpPC/+ZB34Oqw17lN07qAQZcQov+3DSh67cwFxyWAFVzv6nPwn9K
 JSQDkUrlZySEQ==
Date: Tue, 1 Oct 2024 08:02:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 14/15] better name the offset of the hardware error
 firmware
Message-ID: <20241001080240.56a927d2@foz.lan>
In-Reply-To: <20240926131225.0000337c@Huawei.com>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
 <94dec32ef07d95940ee63445f151899ae7b430b3.1727236561.git.mchehab+huawei@kernel.org>
 <20240926131225.0000337c@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Thu, 26 Sep 2024 13:12:25 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 25 Sep 2024 06:04:19 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The hardware error firmware is where HEST error structures are
> > stored. Those can be GHESv2, but they can also be other types.
> > 
> > Better name the location of the hardware error.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> This feels a little theoretical as for now they are always GHESv2 I think?

It is, but the new code that will be added on the next patch series
will allow future addition of other types as well, as it seeks for
the source ID inside the error block structures.

Yet, if we end adding other types, it will probably make sense to
rename ghes.c to hest.c.

> I guess it does no harm and may make sense after follow up series.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,
Mauro

