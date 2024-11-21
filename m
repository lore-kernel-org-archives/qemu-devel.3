Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0C0D75BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 05:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDzqA-00060G-79; Thu, 21 Nov 2024 00:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tDzq8-000608-6a
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 00:34:52 -0500
Received: from out-173.mta1.migadu.com ([2001:41d0:203:375::ad])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tDzq5-0004qq-Ce
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 00:34:51 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1732167282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uHHZMDuVGOiykTUFj7rUL2f13lxFeICupKnQL7IyHB4=;
 b=YdcuouxizHwxZxQvGNnMSLR40NncgW5Ruc+9V9CIIkCoxW4Io+jf+dx7huhWsxsfLIPBxa
 K0HE4zC6J+pOPl3Up8JXPoMg0+kx2Mz7QDIpiVGzLzYyOgh0OjJzk4EUqpDgwu+fQwyUS8
 WN4zHJw8FcRPyMR+njAKbInE4Gppp5s=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: New "rme-guest" QEMU object addition
Message-Id: <9FF5EDFD-6026-4C3A-A6A1-A66521D837A5@linux.dev>
Date: Thu, 21 Nov 2024 14:34:24 +0900
Cc: qemu-devel@nongnu.org
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ad;
 envelope-from=itaru.kitayama@linux.dev; helo=out-173.mta1.migadu.com
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

Hi Jean, Mathieu,

I=E2=80=99ve been using you guys=E2=80=99 ccs/v3 QEMU for some time to =
bring up an Realm instance without a major issue, and as a one who is =
making changes libvirt to support CCA, I wonder if you could merge the =
v3 local changes under qap dir first so I can query the feature from =
libvirt?

Thanks,
Itaru.=

