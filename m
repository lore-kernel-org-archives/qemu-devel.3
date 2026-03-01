Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70949FD006D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi4G-000808-9O; Sun, 01 Mar 2026 09:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vwi4C-0007pF-DD; Sun, 01 Mar 2026 09:46:45 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vwi49-0006J4-78; Sun, 01 Mar 2026 09:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=TxKe6jhnaAy9AxqiN1DhVLvNJAOF5Nq+TOFO4TmmFIs=; b=nC/soH790qepqHZQZ7e0SaLbrD
 hO/CIFbDnq1RoeWO1F7RvhVnEtfljYIRb1OOnXMghCwTCaH1jqoMrdQtzrund7o0SdyN5/AD56rE/
 M6qvgqRP4lwX4pGJM2RKfzE60+f6B/MQqQ4WlPwPczFNZdezuD/F9dIalv+OF7JWC4xn5BhoBOjVo
 3k3nXUv0/I5+r2gz/uMKAl17WRaK5giNPte9ecFcaT6Lz18wwuxC2P4S8a6IRqaL/XlojJLtHbLhg
 jp+Yw+3XgPi0K398Zx+W1x2YGeY9o1Fbgy73jMqL+gI4YrDuo82fwXPVOXgMqNBFkvwCyBlRroEN1
 s+UZvxERScyPTIexSbyXF+fbP35vpeCoyKGORpWTHeqsITfdQq24ELKOwcQ5s4fR+XuNiSEWM8684
 zukb8p8ZgLp1r7CujNdKf0SCIEWeFyilHUf5Qrauw0KDdAHrOIlAlJhT4vFLb3nOnNrM0Yvn20dpr
 u2ZzklCUeKYDV8EQ2M91Z53OZNK/ycVh4sh/HNI7v26dKCD3OZ++EPQKS5W3y1WhMT4k0pS2dc190
 TsntAW4GQBC3dhET7hBWy2iPqHNNoRhneTkeP2Qa4zkHJVO6favRR/zHNkNARkxdcknaSVSpBBUSN
 dzAVpSBc0tU13c0ICKwyru1x+JW6BJTN1+vglXa4Q=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Richie Buturla <richie@linux.ibm.com>,
 Oliver Chang <ochang@google.com>, qemu-stable <qemu-stable@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PULL 0/2] 9p queue 2026-02-28
Date: Sun, 01 Mar 2026 15:46:30 +0100
Message-ID: <5970717.DvuYhMxLoT@weasel>
In-Reply-To: <e73dbda1-f569-4299-a8a4-4d2ed1b943a9@tls.msk.ru>
References: <cover.1772285406.git.qemu_oss@crudebyte.com>
 <e73dbda1-f569-4299-a8a4-4d2ed1b943a9@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sunday, 1 March 2026 07:23:43 CET Michael Tokarev wrote:
> On 28.02.2026 16:30, Christian Schoenebeck wrote:
> > 9pfs changes:
> > * Fix crash under unlink-heavy load in v9fs_mark_fids_unreclaim().
> > * Fix crash with the synth fs driver.
> > 
> > ----------------------------------------------------------------
> > 
> > Christian Schoenebeck (1):
> >        hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs
> >        synth driver
> > 
> > Richie Buturla (1):
> >        hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
> 
> Hi!
> 
> I'm picking these changes up for active qemu stable releases,
> as these looks like bug fixes worth to have.

Yes, that makes sense.

> Please let me know if I shouldn't do that.
> 
> Also, please Cc: qemu-stable for future patches which, in your
> opinion, should be back-ported to the stable releases.

I usually do. For some reason I have forgotten to CC qemu-stable this time. 
Thanks for the reminder and noticing!

/Christian



