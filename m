Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A24E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 07:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXbCu-0006SM-Tw; Tue, 14 Jan 2025 02:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tXbCt-0006Rg-Cp
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 02:19:23 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tXbCq-0001sU-Ms
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 02:19:23 -0500
Message-ID: <462228d6-b313-4f40-a130-ac51dd51cf7f@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1736839157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noxIeDIJDo2cQXmtqbHinZY1fQM6L/KiBU5R8FQtWiI=;
 b=q7fLaqjsKZls34KXmWC2T0K9fxcLLbhgMlAOLhEWxE/Td/tDlGDRnvRKzV2iUfYGsrqW6J
 qDmLe28MZBnLgsf7d9BHo2kF/2fVa1cWwpgDSa9i4vjnD4M1TjQaIxYzl0nO05tFT5HmgS
 V4+hjx4f8U6UFNwZ2EWNhuu9wRAjeL0=
Date: Tue, 14 Jan 2025 10:19:17 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] tests/qtest: fix non portable env varibles access
Content-Language: en-US
To: Prasad Pandit <ppandit@redhat.com>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
References: <20241112063703.116386-2-frolov@swemel.ru>
 <CAE8KmOwDuv7AR4pEGbq=ubEkrHbkQBn7cz2hJsSYx6YgH5Ubpg@mail.gmail.com>
 <224ceb0c-7219-45de-88e2-1e51b47cfc58@swemel.ru>
 <CAE8KmOzzBrJa6Os=_D=F=LjHG=8ByHVi2hz3g9ahtVTwYPO8Zg@mail.gmail.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <CAE8KmOzzBrJa6Os=_D=F=LjHG=8ByHVi2hz3g9ahtVTwYPO8Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello, Prasad.

Bugs in clang are really very interesting...
This exact patch fixes this exact issue.
What is about applying it?

With best regards,
Dmitry.

