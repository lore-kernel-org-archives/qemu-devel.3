Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F57ECFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQ2p-00050M-Rv; Tue, 02 Dec 2025 08:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vQQ2k-0004zp-EQ
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:03:46 -0500
Received: from out28-87.mail.aliyun.com ([115.124.28.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vQQ2h-0007Mz-OC
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:03:46 -0500
Received: from Sun.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.fbGTgJT_1764680591 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 02 Dec 2025 21:03:34 +0800
From: Jie Song <mail@jiesong.me>
To: armbru@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, mail@jiesong.me,
 marcandre.lureau@gmail.com, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, songjie_yewu@cmss.chinamobile.com
Subject: Re: [PATCH v4] monitor/qmp: cleanup SocketChardev listener sources
 early to avoid fd handling race
Date: Tue,  2 Dec 2025 21:03:10 +0800
Message-ID: <20251202130310.4424-1-mail@jiesong.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87sedtt7dj.fsf@pond.sub.org>
References: <87sedtt7dj.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.87; envelope-from=mail@jiesong.me;
 helo=out28-87.mail.aliyun.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

> Jie Song <mail@jiesong.me> writes:
> 
> > Hi Markus,
> >
> >> Jie Song, Marc-André, is this bug serious enough and the fix safe enough
> >> to still go into 10.2?
> >
> > First, regarding the seriousness of this bug, although the probability of 
> > encountering 
> > it in a production environment is relatively low, it has existed for quite 
> > some time.
> >
> > Secondly, with regard to the safety of this fix, it has been verified 
> > successfully
> > in the test environment. However, it would be better if more people could 
> > help to
> > review it to further ensure its robustness.
> 
> This confirms Marc-André's "too late for 10.2" feeling.
> 
> I'll track this patch for 11.0.  More review would be nice, but if we
> can get it, I'll get the patch merged early in the development cycle.
> 
> Thank you!

Hi Markus,

Thanks for the update and for tracking this patch for 11.0.

I’ll keep following up on this and will address any comments
or issues that come up.

Thanks again for your support.

Best regards,
Jie Song

