Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F14FC369AA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 08:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stNdm-0003ih-Fx; Wed, 25 Sep 2024 04:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1stNdk-0003hh-6y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 04:44:52 -0400
Received: from out-174.mta1.migadu.com ([2001:41d0:203:375::ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1stNdg-0001Kb-Oh
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 04:44:51 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1727253879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9O+UUUJm3nyntWakZNT0dv/CP+ufvWXvD9+xXCtNvd8=;
 b=jpeF0Tx6Cjz4dpvJy44uH8lO3SOV9ZF9wuw1Hdg8FiDsmS/PvegvGPrMwT2iNbTcMuVPaR
 lRyRLws2FUQXXk9JyqKp6ULow99qyNErVxtHsKfGj2tJFYqVvLsuEZoNHNKshvkyYeeXeC
 WyvonYTok6K4GSRuNxD0OXirpJDtpz8=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: CCA capability qeury QMP command
Message-Id: <A96F9591-F80E-4193-AEFF-5E23B4E0FD5C@linux.dev>
Date: Wed, 25 Sep 2024 17:44:21 +0900
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
To: qemu-devel@nongnu.org
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ae;
 envelope-from=itaru.kitayama@linux.dev; helo=out-174.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
I=E2=80=99ve been looking at the libvirt code to add Arm=E2=80=99s CCA =
support for some time and I am wondering how QEMU folk want to implement =
the CCA query command. Any pointer would be appreciated.

Thanks,
Itaru.=20=

