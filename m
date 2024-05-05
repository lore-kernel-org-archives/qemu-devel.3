Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876F2C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 18:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3gga-0004LM-Kt; Sun, 05 May 2024 14:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1s3ggZ-0004L8-4V
 for qemu-devel@nongnu.org; Sun, 05 May 2024 14:34:07 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1s3ggX-0006a7-AF
 for qemu-devel@nongnu.org; Sun, 05 May 2024 14:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=znsvO2fULORDRknVkBAtFzMGIkXf6cd80T1Bm0O5iEg=; b=fxl2zIETDNm2Wl2f
 kufAaz8Gti3f2y/4zOQEm/6iER9ZOgg1kOzCP4gd25kF4BY50Emhp1UFRs2+F4+ka504Fzs+twNg8
 3A55H8cWqCbWDGDp+WiIHL199UG/QrcgoAmVdo9yJU7pRse1OcupUtHVgaA+xNrvxvHvO5JID6sNm
 Tmfh5SLXq+LF/hTmq+G3LXpb4bLwx8KKsNLf5Y1U066qAtn1rM8rhHYyNYA8UCuODHa0tARUOJDhq
 HkIdSUliHFXt6SjzHDYjOsDdIny5JtfEumquzCpOh7mA0d0R7dRiM5yPhORlqcfxYUwOUEOwwKXnq
 lz2bxuDw5pyv7jkLHQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1s3ggQ-004nxe-1t;
 Sun, 05 May 2024 18:33:58 +0000
Date: Sun, 5 May 2024 18:33:58 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/7] linux-user: i386/signal: Remove unused fp structs
Message-ID: <ZjfRFhza_-5h8hw7@gallifrey>
References: <20240505171444.333302-1-dave@treblig.org>
 <20240505171444.333302-3-dave@treblig.org>
 <0b1375d2-ee39-4225-a3c2-c95abd69968d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0b1375d2-ee39-4225-a3c2-c95abd69968d@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 18:33:49 up 123 days, 21:23,  1 user,  load average: 0.00, 0.00, 0.00
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

* Richard Henderson (richard.henderson@linaro.org) wrote:
> On 5/5/24 10:14, Dr. David Alan Gilbert wrote:
> > The structs 'target_fpxreg' and 'target_xmmreg' are unused since
> > Paolo's:
> > 
> > Commit 2796f290b546 ("linux-user: i386/signal: support FXSAVE fpstate on
> > 32-bit emulation")
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> > ---
> >   linux-user/i386/signal.c | 10 ----------
> >   1 file changed, 10 deletions(-)
> 
> I have
> 
> https://lore.kernel.org/qemu-devel/20240409050302.1523277-1-richard.henderson@linaro.org/
> 
> which cleans this up.  I need to refresh and resubmit.

Ah yes, that's fine.

Dave

> 
> 
> r~
> 
> > 
> > diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
> > index 990048f42a..9bf602b388 100644
> > --- a/linux-user/i386/signal.c
> > +++ b/linux-user/i386/signal.c
> > @@ -34,16 +34,6 @@ struct target_fpreg {
> >       uint16_t exponent;
> >   };
> > -struct target_fpxreg {
> > -    uint16_t significand[4];
> > -    uint16_t exponent;
> > -    uint16_t padding[3];
> > -};
> > -
> > -struct target_xmmreg {
> > -    uint32_t element[4];
> > -};
> > -
> >   struct target_fpx_sw_bytes {
> >       uint32_t magic1;
> >       uint32_t extended_size;
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

