Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684A6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQ5C-0000gX-6c; Wed, 12 Jun 2024 11:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHQ5A-0000fH-FG
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:40:16 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHQ57-0005X4-1q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:40:16 -0400
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 8A1AD40737D7;
 Wed, 12 Jun 2024 15:40:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8A1AD40737D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718206809;
 bh=psgtTP+ihheUh85Mf01TtaoJUNTpIRsnQqeDwLwSgr0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=BwFjXx1CgIE4js153MhxJRckak/68n2XnrEM7eSYtBMdb49U3CelI5eChD7Q6vtZK
 TA3cMcw3NYakpHfO53e/cGNNxBLet76L0pPjEZjCjv7LnVoyX66me7fL4Ef7qnt6+x
 /vzSqAhemBi3kJ08Y+ZgL0fZWca6r1/Lvzbv2Ca0=
Date: Wed, 12 Jun 2024 18:40:09 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
In-Reply-To: <Zmm6Kf8PEwZ47bMb@redhat.com>
Message-ID: <59f923eb-1925-8c22-e83a-8703fbf60b7f@ispras.ru>
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <ZmmIpr5f0sQy-VGl@redhat.com>
 <CABgObfZHBGxS-D9LdM1v0oDXBHoKm2-A4FknixmqjfJeQR1YLw@mail.gmail.com>
 <ZmmSxq7i_tpYj7tw@redhat.com> <Zmm6Kf8PEwZ47bMb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1831344947-1718206809=:9248"
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1831344947-1718206809=:9248
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT


On Wed, 12 Jun 2024, Daniel P. Berrangé wrote:

> I learnt that FESCo approved a surprisingly loose rule saying
> 
>   "Libraries packaged in Fedora may require ISA extensions,
>    however any packaged application must not crash on any
>    officially supported architecture, either by providing
>    a generic fallback implementation OR by cleanly exiting
>    when the requisite hardware support is unavailable."
> 
> This might suggest we could put a runtime feature check in main(),
> print a warning and then exit(1), however, QEMU has alot of code
> that is triggered from ELF constructors. If we're building the
> entire of QEMU codebase with extra features enabled, I worry that
> the constructors could potentially cause a illegal instruction
> crash before main() runs ?

Are you literally suggesting to find a solution that satisfies the letter
of Fedora rules, and not what's good for the spirit of a wider community.

Alexander
--8323328-1831344947-1718206809=:9248--

