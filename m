Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D782C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqCXZ-0003Jm-VH; Mon, 16 Sep 2024 10:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sqCXQ-0003Iv-9D
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:17:12 -0400
Received: from mail-4022.proton.ch ([185.70.40.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sqCXM-0005iU-I3
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail; t=1726496222; x=1726755422;
 bh=SZ34OBNKcUQfs74NzhP4vXxu+MsAoPqB9x3+m25pKeU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=zjETKCCocZae3KdMSaS33fDx63l8gxVejOiqmaG4jZIkwbFCCjmW6XnPulmJC4llm
 /RrtngC/SbCdR480g++UdYmOK9Mj6jVmVNxyzHCzocI173btdyCBOtwjrHREw8g8h0
 tnpHQ7MczPCaeosEf42JRhR5x024XLfsPR4GQSl5LyyzqOdPvyAfbNYJR2LctCqp5J
 3v7OSuyHIQh4Mqj2FI7i+0sifYZOgRArCN7RwTS6uKpSS4I+ZdPps0ROT76aVqWvRR
 82jYWRJt1Ero6YDaN1czM14TNmoTUAvxhuim1uWzIJEoGIhlZNc7+DxCNKlaUOjbTn
 GUfnXXlItcCVw==
Date: Mon, 16 Sep 2024 14:16:32 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] hw/i386/pc: Remove vmport value assertion
Message-ID: <gODCf5hAzTYfCYRLXtbPw4av6ynWG2Dry9O3v18w7iwM2a2uZQwQ02kHyHHAeLuKr8yRKdREq_QT29fEo4sScB2CvammMOz_ubrg4hCBhjQ=@szczek.dev>
In-Reply-To: <ZwF9ZexNs1h-uC0MrbkgGtMtdyLinROjVSmMNVzNftjGVWgOiuzdD1dSXEtzNH7OHbBFY6GVDYVFIDBgc3lhGqCOb7kaNZolSBkVyl3rNr4=@szczek.dev>
References: <ZwF9ZexNs1h-uC0MrbkgGtMtdyLinROjVSmMNVzNftjGVWgOiuzdD1dSXEtzNH7OHbBFY6GVDYVFIDBgc3lhGqCOb7kaNZolSBkVyl3rNr4=@szczek.dev>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: b197bb2c73997365f8bb447a8d0b7452c68b8d82
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.22; envelope-from=kamil@szczek.dev;
 helo=mail-4022.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Wednesday, August 21st, 2024 at 01:11, Kamil Szcz=C4=99k <kamil@szczek.d=
ev> wrote:
> There is no need for this assertion here, as we only use vmport value
> for equality/inequality checks. This was originally prompted by the
> following Coverity report:
>  >>> CID 1559533: Integer handling issues (CONSTANT_EXPRESSION_RESULT)
>  >>> "pcms->vmport >=3D 0" is always true regardless of the values of
>  >>> its operands. This occurs as the logical first operand of "&&".
>=20
> Signed-off-by: Kamil Szcz=C4=99k <kamil@szczek.dev>
> Reported-By: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Hi, just checking in to see if this needs any additional work.


