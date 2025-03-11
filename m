Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DBEC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxLV-0003hg-EW; Tue, 11 Mar 2025 07:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@weiser.dinsnail.net>)
 id 1trxLT-0003g7-Oq
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:00:23 -0400
Received: from heinz.dinsnail.net ([85.214.221.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@weiser.dinsnail.net>)
 id 1trxLR-0006Zr-Rd
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:00:23 -0400
Received: from heinz.dinsnail.net ([IPv6:0:0:0:0:0:0:0:1])
 by heinz.dinsnail.net (8.18.0.2/8.18.0.2) with ESMTP id 52BB07dP018762;
 Tue, 11 Mar 2025 12:00:07 +0100
Received: from eldalonde.UUCP (uucp@localhost)
 by heinz.dinsnail.net (8.18.0.2/8.18.0.2/Submit) with bsmtp id 52BB062w018761; 
 Tue, 11 Mar 2025 12:00:06 +0100
Received: from eldalonde.weiser.dinsnail.net (localhost [IPv6:0:0:0:0:0:0:0:1]
 (may be forged))
 by eldalonde.weiser.dinsnail.net (8.18.0.2/8.18.0.2) with ESMTP id
 52BAqEgP026661; Tue, 11 Mar 2025 11:52:14 +0100
Received: (from michael@localhost)
 by eldalonde.weiser.dinsnail.net (8.18.0.2/8.18.0.2/Submit) id 52BAqEkm026660; 
 Tue, 11 Mar 2025 11:52:14 +0100
Date: Tue, 11 Mar 2025 11:52:14 +0100
From: Michael Weiser <michael@weiser.dinsnail.net>
To: Hank Knox <hank.knox@mcgill.ca>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Michael Tokarev <mjt@tls.msk.ru>, 
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 11/13] ui/console: Remove dpy_cursor_define_supported()
Message-ID: <Z9AV3s7bGvM1BSgx@weiser.dinsnail.net>
References: <20240716180941.40211-1-philmd@linaro.org>
 <20240716180941.40211-12-philmd@linaro.org>
 <f0b1df5e-4eee-4a56-a8a0-5426cdf2b3d5@tls.msk.ru>
 <CAAibmn1FQgHwt4LapR1gJzyue4bf7Uhbua0sxGg+PxaEjR0Row@mail.gmail.com>
 <Z3_WHQI3GMepJkxp@weiser.dinsnail.net>
 <5a5917ef-2003-46e2-b89f-23a259231f3c@mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5917ef-2003-46e2-b89f-23a259231f3c@mcgill.ca>
X--MailScanner-Information: Please contact the ISP for more information
X--MailScanner-ID: 52BB07dP018762
X--MailScanner: Found to be clean
X--MailScanner-From: michael@weiser.dinsnail.net
Received-SPF: pass client-ip=85.214.221.163;
 envelope-from=michael@weiser.dinsnail.net; helo=heinz.dinsnail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi everyone,

On Thu, Jan 09, 2025 at 09:34:41AM -0500, Hank Knox wrote:

> > commit 4bba839808bb1c4f500a11462220a687b4d9ab25
> > Author: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Date:   Mon Jul 15 14:25:45 2024 +0900
> >
> >      ui/console: Remove dpy_cursor_define_supported()
> >
> > > > Apparently this commit made windows10 guest to freeze.  There's a rather
> > > > hairy bugreport at https://bugs.debian.org/1084199 .  Also there's an
> > > > interesting bug filed against qemu,
> > > > https://gitlab.com/qemu-project/qemu/-/issues/1628 ,
> > > > which seems to be relevant.
> I also am very happy to test any possible patches and to gather any other
> information, to the limits of my tech ability.

I've just run into this again after a system update which brought
qemu-9.2.2 and re-applied the revert locally which again circumvents the
issue for me.

Is there anything I can do to move forward finding a permanent solution?
-- 
Thanks,
Michael

