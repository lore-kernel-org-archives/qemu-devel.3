Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037DAF46102
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4en0-0007Xv-QL; Mon, 23 Mar 2026 08:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1w4emy-0007XN-AH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:53:48 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1w4emw-0005S9-Bm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=tmAqCEm6U9BXvY1oucl5rUkYxHykeU55To8eA+qnX5I=; b=UYf4bCi2DGgNFsf8
 6+ocPd0rF1Z36GKriJAaXUj5vy81LvQ8D4MbjPsh/G4nqjF/0kXez4YPAr3GQ57eKoXft8Y9zpmDs
 BTiQJpCAiDrLbRIGZdYS1IVIH/6tSGLe3cMWJC25vpwT2gJDi4s4i2fbVsWW0axVZVBW8W9x5XlqV
 uV4GI/uZc49so2EOqLKz7IQO4dAQKt0CSxB2E3W2RvuLBZk75KarBIxOrjCFyykceOFmF8Uqx817u
 SOUQcKa1f0lhc0hdWzusOiP5kRb25yoh1lKCnczCHm5piQzr01UUJabIrE/+dy3giIrfJ36XZBsaF
 N6OskMsOYTf+YN3djw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1w4emq-00000002X4V-1C6Q;
 Mon, 23 Mar 2026 12:53:40 +0000
Date: Mon, 23 Mar 2026 12:53:40 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Monitor address printing
Message-ID: <acE31Ce4LbLafF8K@gallifrey>
References: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
 <32d3d036-77dd-414e-9cf5-45044c98069f@linaro.org>
 <e9df395a-388e-4ba5-8b24-268b0e91c06f@linaro.org>
 <08186662-ad0c-4845-8444-4c3474ab1a23@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08186662-ad0c-4845-8444-4c3474ab1a23@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 12:53:21 up 10 days, 14:06,  2 users,  load average: 0.03, 0.03, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> On 23/3/26 10:35, Philippe Mathieu-Daudé wrote:
> > On 23/3/26 10:00, Philippe Mathieu-Daudé wrote:
> > > On 23/3/26 00:38, BALATON Zoltan wrote:
> > > > Hello,
> > > > 
> > > > Noticed that now addresses are printed with a lot of leading
> > > > zeros in monitor:
> > > > 
> > > > $ qemu-system-ppc -monitor stdio -S
> > > > QEMU 10.2.90 monitor - type 'help' for more information
> > > > (qemu) x/x 0
> > > > 0000000000000000000000000000000000000000000000000000000000000000:
> > > > 0x00000000
> > > > (qemu) x/x 0xfff00000
> > > > 00000000000000000000000000000000000000000000000000000000fff00000:
> > > > 0x60000000
> > > 
> > > Likely commit 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr
> > > argument in memory_dump()").
> > > 
> > 
> > Thanks for the report, I'll post a patch with a fix similar to:
> > 
> > -- >8 --
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index bad034937a9..59d49b00f7b 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -537,9 +537,11 @@ static void memory_dump(Monitor *mon, int count,
> > int format, int wsize,
> >       uint8_t buf[16];
> >       uint64_t v;
> >       CPUState *cs = mon_get_cpu(mon);
> > -    const unsigned int addr_width = is_physical ? 8 :
> > (target_long_bits() * 2);
> > +    const unsigned int addr_width = is_physical ? 8 :
> > (target_long_bits() / 4);
> >       const bool big_endian = target_big_endian();
> > ---
> 
> Dave had it right during review btw ;)
> https://lore.kernel.org/qemu-devel/aUyC6HNv8KftowlQ@gallifrey/

Haha, only spotted half the confusion!

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

