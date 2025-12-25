Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293ACE776FC
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 00:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYZbb-0000EN-QM; Wed, 24 Dec 2025 19:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vYZbW-0000Ds-FU
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 19:53:22 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vYZbT-0008No-VV
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 19:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=30Y07OcjGBogwL93Zit92osnomxgi2nRkb2Wl5mHk6Q=; b=WYql1a5TZ/xdEYBS
 aoXGIvikzPAfY88qcBz63HAZ4cpr1RWSjdBCnFyRMrJPxkI6+QnfTow+iYxFvSWWr6k2g1pjcDHSH
 pbgiJ8F71JRlQeBUSrMScLz/vKTImFrTP1pQntIoFn0r5RC/ap1AWOZw5kbFgVo/tpxWicbDSbTjB
 LJZK5CJ3P9tM/MNq+rIRoT+lRym0N/enLXEuJI0FI5kJGbINp2fK/3IPbjDIPUZBghHS85zMi31N8
 vDsL6xVLvYac9yEjH+dkxYbUZWSlEZHvSO6nVMndF2BxxZ/NbhjK5WQ2vtWJXQhb5E77DN5/3CJhY
 5HRASVKby4eOHnnH3Q==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vYZbR-0000000BFkY-0SFC;
 Thu, 25 Dec 2025 00:53:17 +0000
Date: Thu, 25 Dec 2025 00:53:17 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 6/6] monitor/hmp: Merge hmp-cmds-target.c within hmp-cmds.c
Message-ID: <aUyK_Qcb8-czgmXO@gallifrey>
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-7-philmd@linaro.org>
 <CAAjaMXauqeKDJ84LowukGMHcDy+kyB8Y_pDoBCr_kSNyguSRPA@mail.gmail.com>
 <e36cb7e3-799e-4a3c-89c6-4b5242f57344@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e36cb7e3-799e-4a3c-89c6-4b5242f57344@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:49:52 up 59 days, 26 min,  3 users,  load average: 0.00, 0.00,
 0.00
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
> On 24/12/25 15:24, Manos Pitsidianakis wrote:
> > On Wed, Dec 24, 2025 at 3:40 PM Philippe Mathieu-Daudé
> > <philmd@linaro.org> wrote:
> > > 
> > > hmp-cmds-target.c is no more target specific, move its code
> > > in hmp-cmds.c, which is built once for all system binaries.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > >   monitor/hmp-cmds-target.c | 383 --------------------------------------
> > >   monitor/hmp-cmds.c        | 354 +++++++++++++++++++++++++++++++++++
> > >   monitor/meson.build       |   2 +-
> > >   3 files changed, 355 insertions(+), 384 deletions(-)
> > >   delete mode 100644 monitor/hmp-cmds-target.c
> 
> 
> > > diff --git a/monitor/meson.build b/monitor/meson.build
> > > index a71523a1ce8..763fcaba6c5 100644
> > > --- a/monitor/meson.build
> > > +++ b/monitor/meson.build
> > > @@ -9,4 +9,4 @@ system_ss.add(files(
> > >   system_ss.add([spice_headers, files('qmp-cmds.c')])
> > > 
> > >   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
> > > -               if_true: [files( 'hmp-cmds-target.c', 'hmp-target.c'), spice])
> > > +  if_true: [files('hmp-target.c'), spice])
> > 
> > Nit: Indentation?
> 
> We usually don't use tabs in meson.build files, and indent as 2 spaces,
> but I couldn't find any documented style enforcement :/

Looking at ui/meson.build and audio/meson.build, it looks like if_true: on
separate lines are generally aligned with the (
(ish....)

Dave

> Paolo, Marc-André, any preference?
> 
> > 
> > Otherwise
> > 
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> Thanks!
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

