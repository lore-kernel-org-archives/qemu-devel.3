Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E6BC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 12:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5PhN-0003XP-AA; Fri, 10 May 2024 08:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1s5PhL-0003Wy-S4
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:50:04 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1s5PhJ-0003Ty-PP
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=DZ3np201b3kN0+UyHmOGJFUtkpQjbsnD5FnJ9ucvzIY=; b=awAJs1fX89Nb2MOT
 vRgSkJRmOoxOdLs9mplzlpjOxfhZokg0ym10NvIcjiRIVzRQ1V4EBmOLAiyiRtDLXEIHLpYq/HVMD
 IxM3/oMtJkt3nlv4Iz/ABiYS0HyovefctlI1TqvMhozGO8T764QKh4a0MTN651hMBD8l0kYefWgVG
 4m1Dns2D8p2PRC3joFhXdCcndnqlReO+IlyYXqiLLEaJ6xun1RCj+aTkVc77QBPqXnqGOMJXeE9qz
 meMIUwlbaiz5AHW1itjP5RaazCNU9pZS4VwbAMlLH+d9fe181L3XUrmef3vLl0n7vkWMW2EF7NFsi
 UgwqdNng3ugUqiFTrg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1s5PhF-000New-0r;
 Fri, 10 May 2024 12:49:57 +0000
Date: Fri, 10 May 2024 12:49:57 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 6/7] target/ppc: Remove unused struct 'mmu_ctx_hash32'
Message-ID: <Zj4X9S0pftDqfaVS@gallifrey>
References: <20240505171444.333302-1-dave@treblig.org>
 <20240505171444.333302-7-dave@treblig.org>
 <c9c5eebe-7f72-ddf4-5192-d504ac964396@eik.bme.hu>
 <3c4a85c4-eb99-42ed-722d-993695630adb@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3c4a85c4-eb99-42ed-722d-993695630adb@eik.bme.hu>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:49:42 up 2 days, 3 min,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* BALATON Zoltan (balaton@eik.bme.hu) wrote:
> On Sun, 5 May 2024, BALATON Zoltan wrote:
> > On Sun, 5 May 2024, Dr. David Alan Gilbert wrote:
> > > I think it's use was removed by
> > > Commit 5883d8b296 ("mmu-hash*: Don't use full ppc_hash{32,
> > > 64}_translate() path for get_phys_page_debug()")
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> > 
> > Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> I've picked this patch up and will send with my series that changes the same
> place to avoid needing to rebase.

Thanks!

Dave

> Regards,
> BALATON Zoltan
> 
> > > ---
> > > target/ppc/mmu-hash32.c | 6 ------
> > > 1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> > > index 3976416840..746321329c 100644
> > > --- a/target/ppc/mmu-hash32.c
> > > +++ b/target/ppc/mmu-hash32.c
> > > @@ -36,12 +36,6 @@
> > > #  define LOG_BATS(...) do { } while (0)
> > > #endif
> > > 
> > > -struct mmu_ctx_hash32 {
> > > -    hwaddr raddr;      /* Real address              */
> > > -    int prot;                      /* Protection bits           */
> > > -    int key;                       /* Access key                */
> > > -};
> > > -
> > > static int ppc_hash32_pp_prot(int key, int pp, int nx)
> > > {
> > >     int prot;
> > > 
> > 
> > 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

