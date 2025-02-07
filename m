Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74122C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 08:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgK3M-0008Lo-95; Fri, 07 Feb 2025 03:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1tgK3G-0008LZ-TL
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 03:49:31 -0500
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1tgK3E-0002Op-Q6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 03:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4eBD9aCrImXbASeVWKPQGZgVi7qVSc9rMbPADmGNTJc=; b=XZZZ5nc5RNlNRS3JiRV1fwcBJo
 6v2njyN0wIukOVirecOD7TMpaNmxcnJseJbhh7TpivWAobkGAPHB9GiqT4aug9OBraPhxyRfy0LkM
 AOIHb1+Ud7mDdMoGv1dNtqWzZ9pTDVZ/AHgveE1IzMnN61JaJh9za+XfBrRteUApUY8M=;
Date: Fri, 7 Feb 2025 09:49:19 +0100
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/tricore: Inline TARGET_LONG_BITS in
 decode_rr_logical_shift()
Message-ID: <6awodnxb3u2ldcz2erxbjrpkttask6tyl4bk5kik4jaowr5nfd@xnc6zkzm6w35>
References: <20250206173258.36624-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206173258.36624-1-philmd@linaro.org>
X-IMT-Source: Extern
X-IMT-rspamd-score: -25
X-UPB-Report: Action: no action, RCVD_TLS_ALL(0.00), FROM_HAS_DN(0.00),
 FROM_EQ_ENVFROM(0.00), BAYES_HAM(-2.99), TO_MATCH_ENVRCPT_ALL(0.00),
 MID_RHS_NOT_FQDN(0.50), MIME_GOOD(-0.10), NEURAL_HAM(0.00),
 RCPT_COUNT_TWO(0.00), RCVD_VIA_SMTP_AUTH(0.00), ARC_NA(0.00), ASN(0.00),
 RCVD_COUNT_ONE(0.00), MIME_TRACE(0.00), TO_DN_SOME(0.00), MISSING_XM_UA(0.00),
 Message-ID: 6awodnxb3u2ldcz2erxbjrpkttask6tyl4bk5kik4jaowr5nfd@xnc6zkzm6w35
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Thu, Feb 06, 2025 at 06:32:58PM +0100, Philippe Mathieu-Daudé wrote:
> We only support 32-bit TriCore architecture.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/tricore/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

