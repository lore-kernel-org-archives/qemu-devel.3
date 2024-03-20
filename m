Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF3C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 22:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn4de-0008JY-Rj; Wed, 20 Mar 2024 18:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1rn4dd-0008JM-Em; Wed, 20 Mar 2024 18:42:25 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1rn4dZ-0008CQ-RP; Wed, 20 Mar 2024 18:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KBf/tPFYcgNlcQJNQKKFsPqHw6A1Q1et/hZJdIyr66w=; b=pvB4TtE8Jm1+RfiCwI93LXUAfr
 Ng0goMWDivrLmBdFf1quBrVTFiOW3YJTg79J+vy4C6pe5Or5Ck+uCxV9qKXlcRX/+xfDk/oyAl4M4
 cVyxZQpapH0+b+xyw5t+ovmdrKyrfUv6oZIhKAzt2lHOaxPv0X+XT3fHMJZby7rw8BtHyz+92B1oL
 mHmMfObwrUA6VVjaTIH29khJhSffeFeWbjxiU0WbhkWuunBDQ+bweSWV4G8JIKYErRicSlRoKFb6M
 kDYKQopSYUP3t3jNNvTmdyPeO931oOryZ2IrVVlrRJn9qu0FM3bjdnjuWR9iIYfz0Fa4FckyVT1Jc
 vIN5fs2g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1rn4dV-00DaIB-2z;
 Wed, 20 Mar 2024 22:42:17 +0000
Date: Wed, 20 Mar 2024 22:42:17 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com, Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH-for-9.0] monitor/hmp-cmds-target.c: append a space in
 error message in gpa2hva()
Message-ID: <ZftmSRMlOZfPtksS@gallifrey>
References: <20240319021610.2423844-1-ruansy.fnst@fujitsu.com>
 <c7cd0119-0c8b-45fa-93d5-de25fb8f6a6e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7cd0119-0c8b-45fa-93d5-de25fb8f6a6e@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 22:41:41 up 78 days, 1:31, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> On 19/3/24 03:16, Shiyang Ruan via wrote:
> > From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > 
> > In qemu monitor mode, when we use gpa2hva command to print the host
> > virtual address corresponding to a guest physical address, if the gpa is
> > not in RAM, the error message is below:
> > 
> > (qemu) gpa2hva 0x750000000
> > Memory at address 0x750000000is not RAM
> > 
> > a space is missed between '0x750000000' and 'is'.
> > 
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >   monitor/hmp-cmds-target.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> > index 9338ae8440..ff01cf9d8d 100644
> > --- a/monitor/hmp-cmds-target.c
> > +++ b/monitor/hmp-cmds-target.c
> > @@ -261,7 +261,7 @@ void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
> >       }
> >       if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
> > -        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx "is not RAM", addr);
> > +        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
> >           memory_region_unref(mrs.mr);
> >           return NULL;
> >       }
> 
> Fixes: e9628441df ("hmp: gpa2hva and gpa2hpa hostaddr command")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks,

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

Cc'ing in Trivial.

Dave

> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

