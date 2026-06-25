Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43FCCDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcnQh-0006al-PP; Thu, 25 Jun 2026 12:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wcnQh-0006ab-3u
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:59:55 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wcnQf-0000tA-GS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:59:54 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 65B87240028
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:59:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
 t=1782406783; bh=5W/ZhD4i5RtLwGiKc1kE5cvPPfJT6JWkcqNTXslpLrA=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=PAOaYHVDuw7FS+45mR/tPymrjv0J0Q/MJCZ+CJQ8FotIsqkFJPlWxO9mOAk8MT6jV
 vaWKL6awkFs3saN7TIgXccNOw79c2yshTriRyjg/x0Z5a1K0m4rR87StJPKnOdwLju
 ZJvXE+H+Z+kNfBab01mJnFHCxi3YLdYGkH0WTLZzg0czuecHFbZHGCxKERhSEWaFmS
 01Qd20GwYCD7/RQSP32+15je172oei/o+IfFFyPPTkg4d+M1P9z76fT73QwuuNr7Yf
 78QB8dsWDWFPIUvnzvv4lgoOurG5iGGDKp3hITDOGe1+p66ldDFES8tZAIZLbr3eZ0
 p6XWwH9Z9TV4Q==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gmQ5V4VC2z9rxM;
 Thu, 25 Jun 2026 18:59:42 +0200 (CEST)
Date: Thu, 25 Jun 2026 16:59:43 +0000
From: Thomas Huth <th.huth@posteo.eu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PULL SUBSYSTEM pseries 0/1] pseries: Update SLOF firmware
 image to release 20260618
Message-ID: <20260625185941.421b952f@tpx1>
In-Reply-To: <22607674-c519-4384-a51e-51da9e7c9967@linux.ibm.com>
References: <20260618082623.345255-1-th.huth@posteo.eu>
 <22607674-c519-4384-a51e-51da9e7c9967@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am Tue, 23 Jun 2026 15:06:50 +0530
schrieb Harsh Prateek Bora <harshpb@linux.ibm.com>:

> Hi Thomas,
> 
> On 18/06/26 1:56 pm, Thomas Huth wrote:
> >   Hi Harsh, hi Nicholas!
> > 
> > The following changes since commit c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff:
> > 
> >    Merge tag 'firmware-20260617-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-06-17 10:17:29 -0400)
> > 
> > are available in the Git repository at:
> > 
> >    https://gitlab.com/huth/qemu.git tags/qemu-slof-20260618
...> 
> Looks like updating VERSION file was missed before building the slof.bin
> (as checked in gitlab repo). Also, I see below FW version (git-xxx)
> during boot:
> 
> SLOF 
> ********************************************************************** 
>   
> 
> QEMU Starting 
>   
> 
>   Build Date = Jun 18 2026 08:06:19 
>   
> 
>   FW Version = git-def1516ec9340518 
>   
> 
>   Press "s" to enter Open Firmware.
> 
> 
> Whereas, earlier, it used to appear like proper release timestamp:
> 
> 
> SLOF **********************************************************************
> QEMU Starting
>   Build Date = Oct 26 2025 18:45:22
>   FW Version = release 20251026
>   Press "s" to enter Open Firmware.
> 
> Curious to know if it's only the VERSION update needed or something more 
> (make args) ?

As you just mentioned in chat, I also missed to update the submodule :-/

Sorry for messing up this time, I will send a v2 in the next days when I
got some spare time....

 Thomas

