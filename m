Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25517C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFuZ-00070u-GG; Wed, 14 May 2025 13:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1uFFtm-0006Hk-5M
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:28:07 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1uFFth-0002Tk-Jz
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:28:04 -0400
Date: Wed, 14 May 2025 19:27:54 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Little Mu <me@littlemu.space>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "kbastian@mail.upb.de" <kbastian@mail.upb.de>
Subject: Re: Wiki account creation request
Message-ID: <igaor6wsjwzwu5ukcpd22hcbv4ht36jv43ob4if2nns7cr7dbv@wl5qrnmlczwg>
References: <7QToVN8NmNf6U7XhvLQTM6Bt2CQMQ_IjZLfiafc_9zTfRg9RBKaTnCm9YbMLy3WvcpYGGVLJjUJP4M3WBrlZPkYZpINGfr0ltB748sZXqCU=@littlemu.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7QToVN8NmNf6U7XhvLQTM6Bt2CQMQ_IjZLfiafc_9zTfRg9RBKaTnCm9YbMLy3WvcpYGGVLJjUJP4M3WBrlZPkYZpINGfr0ltB748sZXqCU=@littlemu.space>
X-IMT-Source: Extern
X-IMT-rspamd-score: -17
X-UPB-Report: Action: no action, RCVD_TLS_ALL(0.00), FROM_HAS_DN(0.00),
 FROM_EQ_ENVFROM(0.00), BAYES_HAM(-2.20), TO_MATCH_ENVRCPT_ALL(0.00),
 MID_RHS_NOT_FQDN(0.50), MIME_GOOD(-0.10), NEURAL_HAM(0.00),
 RCVD_VIA_SMTP_AUTH(0.00), ARC_NA(0.00), ASN(0.00), RCVD_COUNT_ONE(0.00),
 MIME_TRACE(0.00), TO_DN_SOME(0.00), TO_DN_EQ_ADDR_SOME(0.00),
 MISSING_XM_UA(0.00), RCPT_COUNT_THREE(0.00),
 Message-ID: igaor6wsjwzwu5ukcpd22hcbv4ht36jv43ob4if2nns7cr7dbv@wl5qrnmlczwg
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Hi,

On Wed, May 14, 2025 at 10:21:21AM +0000, Little Mu wrote:
> 
> Hello
> 
> I've been working on the TriCore architecture support on QEMU and wish to
> request a wiki account to update the TriCore page as it has become quite
> out-of-date, even compared to the current state of QEMU. I'm also in
> communication with the maintainer of the TriCore architecture on QEMU to
> integrate updates to the architecture's codebase.

I created an account for you and have sent you the credentials privately.

Cheers,
Bastian

