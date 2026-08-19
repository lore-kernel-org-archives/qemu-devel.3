Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4020FC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkBF-0003vh-0G; Wed, 19 Aug 2026 13:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkBC-0003vW-MR
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:34:22 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkBA-0000yg-UO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:34:22 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwkAw-000000005jz-0Mrn; Wed, 19 Aug 2026 17:34:06 +0000
Date: Wed, 19 Aug 2026 18:34:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Matthew Jackson <matthew@pq.io>, Alexander Graf <agraf@csgraf.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] hw/misc/applesmc: Implement writes, the shutdown
 watchdog and get-key-type
Message-ID: <20260819144000.a1b2c3@makrotopia.org>
References: <cover.1787114994.git.daniel@makrotopia.org>
 <CAFEAcA-kkKrduX6r85vLTFixRZ8pgvXpZDjR_-DTSz0h_+kDOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-kkKrduX6r85vLTFixRZ8pgvXpZDjR_-DTSz0h_+kDOg@mail.gmail.com>
Received-SPF: pass client-ip=2a07:2ec0:3002::65;
 envelope-from=daniel@makrotopia.org; helo=pidgin.makrotopia.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 19 Aug 2026 at 14:29, Peter Maydell <peter.maydell@linaro.org> wrote:
> How does this series fit in with Matthew Jackson's set of patches
> https://patchew.org/QEMU/20260720164930.68383-1-matthew@pq.io/

They do overlap, and Matthew's is the more complete of the two, so I
am dropping the overlapping parts of mine in favour of his.

We independently implemented the same two missing SMC commands (write
and get-key-type). On top of that Matthew's v4 also implements
get-key-by-index and populates a full key table, whereas my series
left get-key-by-index out (the macOS 26 guest I traced doesn't seem to
emitted them). So his series supersedes patches 2 and 4 of mine.

The only parts of my series not covered by his are the SMC shutdown
watchdog and the trace events. I have rebased those two patches on top
of his v4 and will send them as a short follow-up ("[PATCH 0/2]
hw/misc/ applesmc: SMC shutdown watchdog and trace events").
Reviewed-by/Tested-by for his series are in my replies to it.


Cheers and thanks for connecting the two threads


Daniel

