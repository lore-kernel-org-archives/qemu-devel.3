Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427BFC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpM1s-0004AB-EX; Thu, 30 Jul 2026 04:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wpM1r-00049x-0Q
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:22:11 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wpM1p-0002zl-HN
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:22:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 017ACC025D;
 Thu, 30 Jul 2026 11:22:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:484::1:24] (unknown
 [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 6MarKnMWKGk0-1qU8ymN7; Thu, 30 Jul 2026 11:22:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785399726;
 bh=2sM+u3Z5PYFP5dR41pcA4x5YGfJ4pUz+gESofPCIsy4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=nwfgB908oqHQid3mE4isVKlUzKZfIQSZOrd2lp8RlotqVO+oedkGrfON2ujvm/Q4L
 tyklAQmx/9i0GXZDIvhnD1RQJNCa7YXChs/sEsFkOC/3/msdG6GOiUgnJn0w5A6sP1
 cDsQebG+8kNd7DGYtqRPviy7tUCXlPxHFp8y++c4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <59d8df72-f0f0-4f8e-99da-d1c5c4931c11@yandex-team.ru>
Date: Thu, 30 Jul 2026 11:22:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] migration: Remove extra type-checking from vmstate
 macros
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <20260729225227.1170574-1-farosas@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260729225227.1170574-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 30.07.26 01:52, Fabiano Rosas wrote:
> Hi, this is basically what I ranted about in:
> https://lore.kernel.org/r/87jyqeomqz.fsf@suse.de
> 
> I'm replacing the per-integer-size type checks with a single "int that
> fits in 32bit" check. This allows several lines of duplicated code to
> be removed.
> 
> I haven't changed the macro names in the device code yet. If this
> series gets positive feedback then I'll send per-subsystem patches
> doing that.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2716814081
> Also tested:
> - migration-test --full --thorough
> - x86_64 compat run forwards and backwards for previous 3 QEMU releases
> - s390x compat run forwards and backwards for previous 2 QEMU releases
> - ppc64 compat run forwards and backwards for previous QEMU release
> - migration-test smoke ASAN/UBSAN run
> 
Thanks for doing it, all these _TYPE_ were pain!

-- 
Best regards,
Vladimir

