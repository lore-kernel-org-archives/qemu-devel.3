Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E08CD73EB8
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 03:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlf3Z-0006CX-Tf; Thu, 29 Jan 2026 22:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vlf3X-00069k-Tg
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 22:20:23 -0500
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vlf3U-0002RU-G9
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 22:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail2; t=1769743214; x=1770002414;
 bh=ZKkPLwiL37tibxeapD5vVb9xeYwK3T39PhNxOnlkB9U=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=XriCRu9Rh11QguzFb8P/ew4bawPEHy9aquCC53HZGVGrxM3aFtR563Nu3nh2Fvxih
 RxQq0YR7rJCXYFQRNc/J/4hC6zTiU55kISFq3Pymelv8HYc9h2ARQ1T0kp1D4FdtBP
 a7SK7GQEk1l4QYyuJsbr/e+prQismGenLPvlNRLIrikiZx84CYGNBG24NP9C8pac27
 Sj5S5OSbJUwakMvOT6KEGJVinW/mMPlAQZM3sztoyUhMuziRe4STGv5nAM1K7nudYy
 Kud3+vnKkGk7KW8qGDyo7fxa/L2O8ezQvOiwGf53JLNQ3FwD44FkyuQ81lR1m84UAz
 o65xo5D4hE/WA==
Date: Fri, 30 Jan 2026 03:20:11 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 stefanb@linux.ibm.com, peter.maydell@linaro.org, kwolf@redhat.com,
 berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v3 0/4 qemu] GNU/Hurd support
Message-ID: <20260130031954.1661880-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: 28f2f7ca6c2d5b9d14fee1e42aa37ea198fb96a6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=damien@zamaudio.com;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Hi all,

This patchset was buried in the mailing list, I have rebased and
addressed all comments in the separated threads relating to this series.

Thanks for reviewing previously, and I hope the original author does not mi=
nd I have
picked up this work.

TESTED: It compiles and runs qemu-system-i386 and qemu-system-x86_64 on GNU=
/Hurd x86_64.

Cheers,
Damien



