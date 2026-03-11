Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647DF1125821
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Jr4-0003FH-04; Wed, 11 Mar 2026 09:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0Jr2-0003F3-KR; Wed, 11 Mar 2026 09:44:04 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0Jqz-00073e-Ob; Wed, 11 Mar 2026 09:44:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CB1548074D;
 Wed, 11 Mar 2026 16:43:57 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:d28::1:5])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uhGFm30AaGk0-tpmXgvPO; Wed, 11 Mar 2026 16:43:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773236637;
 bh=dRACo3oAkHHnwWt5e0bmNSEYoPq1TWoQSR8PzCsJBsw=;
 h=In-Reply-To:Subject:Cc:Message-Id:Date:References:To:From;
 b=TXYVe/tkTR2Mm9oMDBnupq/IJ+CPNYeI0+LhlqsuNUzaQ/Imt9urqj1E9QUIwYsnX
 YmuI+2+1e2YJe9CsjRoG5YsyqOhghx//6MPPQnVZNgzSQUd7GdS7rd8QcbTyxo+0rl
 m6BL27aqIMa7pDzx0hWRxCOdEoPdGffWYOuzAAHk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 18:43:56 +0500
Message-Id: <DGZZXCXXYK0L.1ZBGURAHY5Y5S@yandex-team.com>
Cc: <qemu-trivial@nongnu.org>
Subject: Re: [PATCH v3 0/4] Fix a few minor issues reported by Coverity
From: "Sergei Heifetz" <heifetz@yandex-team.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, "Sergei Heifetz"
 <heifetz@yandex-team.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <20260208103958.121455-1-heifetz@yandex-team.com>
 <47a14220-139f-4be6-a19d-503924d5e90b@tls.msk.ru>
 <DGZZGGO06GZ5.3UDKO7EUE6XMP@yandex-team.com>
 <54bf3ef9-2fdd-4d0e-b5cc-5e429165f75b@tls.msk.ru>
In-Reply-To: <54bf3ef9-2fdd-4d0e-b5cc-5e429165f75b@tls.msk.ru>
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed Mar 11, 2026 at 6:25 PM +05, Michael Tokarev wrote:
> On 11.03.2026 16:21, Sergei Heifetz wrote:
>
>> I've just resubmitted the series with a change to the commit message of
>> the `physmem.c` patch. As pointed out by Peter Maydell, there is a good
>> reason to consider the assertion redundant.
>
> Sigh.. I already picked all the patches up.
>
> Lemme re-pick stuff..
>
> /mjt

Yeah, sorry about that. Thanks for your time.

