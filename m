Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB68C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlTMS-0001i3-Sd; Sun, 19 Jul 2026 11:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMM-0001ho-Rz
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:19 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMH-0006hJ-0l
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784474581; x=1784733781;
 bh=55Kk2uBUTTnug4mm/duDGe3vuwvKlTXdM8MXmjQw4pw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=h6IrT1UmJnSIyca1jk9YctLXIC9YORRpVL7M+IMqJTJKaCLVO5gKhr7IWgsUFB4QL
 tpercT89F23lBMAWonK4S0+QwNqCpi+8B0mo7u433ogxu+zOusLVVd2jZK5vULbhDK
 uIXySQBdPhePNHHDx1Jd+v7Gi4QZv4WO3tCm89yZHrliXsDLXsnEtFgWbhkDGyFkbF
 2y0KCZhbnehXN1E0b4BLXU+JfEQ0CFs9ZFE5Eplzr7zxsJnwyTr3iqcXVjRh2f7y0P
 N4agP3I4qtq5L+DfZrq337W8WZCH+siWjM6RTkQ6POaTUEK/LuklhQ71x7su0jR88H
 nKbjwwPvaQiiw==
X-Pm-Submission-Id: 4h36pr2cJwz1DDrb
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	peter.maydell@linaro.org
Subject: Re: [PATCH v2 0/2] hw/misc/applesmc: fix GET_KEY_BY_INDEX and
 populate key set
Date: Sun, 19 Jul 2026 08:22:58 -0700
Message-ID: <20260719152258.69448-1-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507152020.48728-1-matthew@pq.io>
References: <20260507152020.48728-1-matthew@pq.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.9.206.169; envelope-from=matthew@pq.io;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Ping — this v2 (2026-05-07) addressed the v1 review comments and has had
no further feedback. It still applies cleanly on master (no applesmc.c
changes upstream since). Happy to rebase/resend as v3 if preferred.

  v1: https://lore.kernel.org/qemu-devel/20260507040153.14565-1-matthew@pq.io/
  v2: https://lore.kernel.org/qemu-devel/20260507152020.48728-1-matthew@pq.io/

Thanks,
Matthew

