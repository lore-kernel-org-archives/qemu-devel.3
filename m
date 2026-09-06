Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4773C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 14:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3E43-0005gA-O4; Sun, 06 Sep 2026 10:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x3E41-0005fx-VY
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 10:41:45 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x3E3z-0003aL-Ox
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 10:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=r1LZ2gTwoK+O9ScuFeelOv71QR0pJzwIXTom7Vs51gA=; b=ejJg9DB1Yxrqhgsz
 nSkUwFRH4753wBSOK6YF5zeL70Qh9/IAz9wljQldAl52kJhyDaDfhKHZtfNsFlV0GLnfNWy7IDnsB
 JEtinhLBnxuGY0ocO69bOHTT/r+Ie5kaSGd9/SOrSa8DXrEg3v6bQcejSkSxQ+6GclsZuAFPpZtBa
 xcev80aSHMwpw8skvKzOSkXvpzU8lAP1jdwvV+SuLORyE92gvwofeqp7qSGVFgDXcPDHrNtmQmQXX
 j2NoBxe5ZtcPsnCZ7ve9zVCwFCxUTfbA80hw1dklfuoH7smoJWx4VIjFKQChlZgr+9L89IIjL1Gdo
 cnv8hRxXd5UDqKB3Sg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1x3E3r-00000002GtD-3fEY;
 Sun, 06 Sep 2026 14:41:35 +0000
Date: Sun, 6 Sep 2026 14:41:35 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Alano Song <alanosong@163.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com,
 philmd@oss.qualcomm.com, armbru@redhat.com, laurent@vivier.eu,
 atar4qemu@gmail.com, zhao1.liu@intel.com,
 =?iso-8859-1?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4] monitor: Refine 'info tlb' command
Message-ID: <ap17nw2Zi0r2onmz@gallifrey>
References: <20260905130832.536358-1-AlanoSong@163.com>
 <135c0676.2f9e.1a071e3c0d8.Coremail.alanosong@163.com>
 <3d1ee2f9.289e.1a0771145b4.Coremail.alanosong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d1ee2f9.289e.1a0771145b4.Coremail.alanosong@163.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.107+deb13-amd64 (x86_64)
X-Uptime: 14:40:02 up 7 days, 16:01, 2 users, load average: 0.00, 0.00, 0.00
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

* Alano Song (alanosong@163.com) wrote:
> Hi Markus,
> 
> 
> I found that this patch email has been rejected by
> the qemu-devel mail server.

Hi Alano,
  What's the error that you're getting?
I think one problem might be that your copy of Marc-Andr�'s
name looks like it gets corrupt, if you just change it from:
  Marc-André Lureau <marcandre.lureau@redhat.com>
to
  marcandre.lureau@redhat.com

it might be better.

Dave

> I attempted to resend it, but received the same result
> (I am checking the details).
> 
> 
> Therefore:
> a) You could manually apply this patch,
>    as we have received it through our personal emails.
> b) Or I should resend it using other email account
>    until the qemu-devel mail server receives it.
> 
> 
> Could you let me know the next steps? Thank a lot.
> 
> 
> Alano.
> 
> 
> 
> At 2026-09-05 22:05:46, "Alano Song" <alanosong@163.com> wrote:
> 
> 
> 
> At 2026-09-05 21:08:32, AlanoSong@163.com wrote:
> >When booting an i386 target, the 'info tlb' command
> >may walk the entire page table hierarchy and emit
> >an enormous amount of output. It will take dozens of
> >minutes to print all the info.
> >And the same situation also occurred on sparc32 and
> >m68k targets.
> >
> >So this change do the following:
> >1) Add a address range argument to help user control
> >   the number of output items.
> >2) Add warning note in help message that such address
> >   range argument only supported on target i386,
> >   sparc32 and m68k.
> >3) Print ignore warning when user add such address
> >   range argument on other targets (sh4, sparc64,
> >   ppc and xtensa). Those targets only print limited
> >   tlb info.
> >
> >Signed-off-by: Alano Song <AlanoSong@163.com>
> >Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> >Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >---
> 
> 
> Hi, Markus,
> 
> 
> This patch has been rebased on the top of commit,
> and it has been built and tested on my local.
> 
> 
> Could you help to pull it,
> Thanks a lot!
> 
> 
> Alano.
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

