Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FFDCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDk7q-0006Co-8s; Tue, 28 Oct 2025 09:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1vDk7o-0006CQ-Mk
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:52:36 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1vDk7i-0006pL-4z
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:52:35 -0400
Received: from movement by movementarian.org with local (Exim 4.97)
 (envelope-from <movement@movementarian.org>)
 id 1vDk7c-00000003vF0-21Qv; Tue, 28 Oct 2025 13:52:24 +0000
Date: Tue, 28 Oct 2025 13:52:24 +0000
From: John Levon <levon@movementarian.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PULL 09/25] vfio-user: implement message receive infrastructure
Message-ID: <aQDKmM2FFKAusenB@movementarian.org>
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-10-clg@redhat.com>
 <CAFEAcA9+EyeWE0QSUhgd7+i3din8J76jnhTuDB7i9hu3x-urOg@mail.gmail.com>
 <CAFEAcA88jVL4Qwb4MEzdcqeXDjob1NZ3-k_ZtwPCgG+9U6fkNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA88jVL4Qwb4MEzdcqeXDjob1NZ3-k_ZtwPCgG+9U6fkNA@mail.gmail.com>
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

On Tue, Oct 28, 2025 at 01:35:05PM +0000, Peter Maydell wrote:

> On Thu, 10 Jul 2025 at 13:44, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Thu, 26 Jun 2025 at 08:47, Cédric Le Goater <clg@redhat.com> wrote:
> > >
> > > From: John Levon <john.levon@nutanix.com>
> > >
> > > Add the basic implementation for receiving vfio-user messages from the
> > > control socket.
> > >
> >
> > Hi; Coverity suggests there are some issues with this code
> > (CID 1611807, 1611808, 1611809):
> 
> Hi; it looks like 1611807 and 1611808 (the resource leaks)
> are still present in this code in current git; would somebody
> like to have a look at this?

Please see https://lore.kernel.org/qemu-devel/aG-4hkfLDEpDsqo6@movementarian.org/

I believe them to be false positives.

regards
john

