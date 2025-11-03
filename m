Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1244CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwMe-00039u-TE; Mon, 03 Nov 2025 10:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1vFwMO-00033E-Qf
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:20:48 -0500
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1vFwMI-0005eY-Bm
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:20:43 -0500
Received: from movement by movementarian.org with local (Exim 4.97)
 (envelope-from <movement@movementarian.org>)
 id 1vFwM7-000000066hm-2XwU; Mon, 03 Nov 2025 15:20:27 +0000
Date: Mon, 3 Nov 2025 15:20:27 +0000
From: John Levon <levon@movementarian.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PULL 09/25] vfio-user: implement message receive infrastructure
Message-ID: <aQjIOzaujC6LrW8u@movementarian.org>
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-10-clg@redhat.com>
 <CAFEAcA9+EyeWE0QSUhgd7+i3din8J76jnhTuDB7i9hu3x-urOg@mail.gmail.com>
 <CAFEAcA88jVL4Qwb4MEzdcqeXDjob1NZ3-k_ZtwPCgG+9U6fkNA@mail.gmail.com>
 <aQDKmM2FFKAusenB@movementarian.org>
 <CAFEAcA-cLQTTeuwcCfYRXwv-434_mttDO0oXr_UuaOmkHX370w@mail.gmail.com>
 <aQiaoBcgnwJEYG5j@movementarian.org>
 <CAFEAcA-FSuURfXJETNYTegjLSAUzbSJiE6+s6LGJpdhM-RxjSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-FSuURfXJETNYTegjLSAUzbSJiE6+s6LGJpdhM-RxjSA@mail.gmail.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 03, 2025 at 02:09:00PM +0000, Peter Maydell wrote:

> > It's hard to say without the full analysis.
> 
> If you like you can ask for an account at
> https://scan.coverity.com/projects/qemu which will let you look
> at the issues in the web GUI, which is a bit more detailed than
> the email summaries.

Yes please. I think it was missed when I asked for one before.

regards
john

