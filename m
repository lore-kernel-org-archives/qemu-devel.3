Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22735C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxVL5-0001oj-AB; Fri, 21 Aug 2026 15:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1wxVL3-0001oA-E4
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 15:55:41 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1wxVKz-0007mY-Km
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 15:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787342124; x=1787601324;
 bh=nUWM7xmEFxGzd1mA6rzVil3JxtRBvVDgf8HMtRC6Ubk=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=A1bpQyGZyifD6ydaf+ZjkGZB/oyvU1b/t32gN8IJVJSeH/myKVBZPQlSESx+u8zWd
 f0Tzot1UwcQn6jN6Ru8Icv6lKFeeAENRA9hYHwwAUB4Mr3RlcbWU/AiVwOcMd2tRY+
 SC8z5JLoLEoQ0HTg1zaJW1sgB8Kil08VFtLHQfVBSpof+Rf6QZ6AHckVrkhIoWs8Oc
 YPH01vtAVSYDrIl2wk2iIqXBxLX0rjgGFFESHofEQLrpLm3Y+RsbGQSXpDZbvpFWRY
 qOAj7LMyml8UhJmkthvQSmUU76JSRB1Ka5lGETkF4sSEaQsnPgSykSEZOvUFtTjL5a
 ba3dsTmK4rPdA==
Date: Fri, 21 Aug 2026 19:55:19 +0000
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
From: Christian <christianslima@proton.me>
Subject: Re: [PATCH v2] disas: converts malloc to g_new0
Message-ID: <XaPMaTPL-fcjuqFX8zBkAs6cGcFdvMQrPUPLfgKtuTmzvUmuJ5b_lcHJKOjWamD49Csl8R9L2G4LANfNb7PcYl75x_P2o73YwnNsmZmU7Ec=@proton.me>
In-Reply-To: <20260630223159.68737-1-christianslima@proton.me>
References: <20260630223159.68737-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: d2367be6fbfe555bbb6a613d5e282e0ab593496c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169;
 envelope-from=christianslima@proton.me; helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Ping @Laurent Vivier

