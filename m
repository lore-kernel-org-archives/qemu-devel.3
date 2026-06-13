Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4126CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 18:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYSrB-0004lZ-05; Sat, 13 Jun 2026 14:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bblank@thinkmo.de>) id 1wYSr9-0004lM-HO
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 14:13:19 -0400
Received: from mail.thinkmo.de ([2a01:4f8:271:3f5c:0:25:1:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bblank@thinkmo.de>) id 1wYSr7-0003zu-Ig
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 14:13:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.thinkmo.de (Postfix) with ESMTP id 4gd4Hq61FHzygv;
 Sat, 13 Jun 2026 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thinkmo.de; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received; s=
 mail202312; t=1781374391; bh=6GPKAOobwmNg968WVow6EBZsOTaaulq+Iwz
 Tk8mWKdE=; b=WFA+uWuhApZWf7VWd8/7P3CJSHS062sBwv3TNsSMwW9kgE+xfPU
 I16+IKhuk0wTRdt2/otJTg1KbwM32kFk4GuBfwPXNz1MAokd9s1PTbcUIn1lBL61
 emjwe4xXWcO7NRrV5SU6pYf9YFvXK7p62K3uCxPwEURLSMMImxRTAguyxd2PbvPo
 PMjUHmB2BS0op2zm6aBLNihf/z8l/vvh7oihpm5fRM9bdAvnl6IuMwyFi76Ottfx
 phQR8oHvWZS24876hZA2mq9lIZxAIEuEAMkr8L2w1vN1jLkYpaBUokKKSGKldF7q
 GZLfTQFbqXOkcP+4+Ps66+zH5otlU7GMNNg==
X-Virus-Scanned: Debian amavis at 
Received: from mail.thinkmo.de ([127.0.0.1])
 by localhost (mail.thinkmo.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoE-fvk-5wM7; Sat, 13 Jun 2026 18:13:11 +0000 (UTC)
Received: from shell.thinkmo.de (shell.thinkmo.de
 [IPv6:2a01:4f8:271:3f5c:0:22:0:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (No client certificate requested)
 by mail.thinkmo.de (Postfix) with ESMTPS id 4gd4Hq52mnzyTR;
 Sat, 13 Jun 2026 18:13:11 +0000 (UTC)
Date: Sat, 13 Jun 2026 20:13:10 +0200
From: Bastian Blank <bblank@thinkmo.de>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] hw/xen/interface: Remove pre-C99 checks
Message-ID: <xuuzvpxooyhkbqluaxszcizjxrqzjczejhdqiso6q2mc4cnhjl@kszikmaagunj>
Mail-Followup-To: Bastian Blank <bblank@thinkmo.de>, 
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
References: <20260613175151.1357-1-philmd@oss.qualcomm.com>
 <20260613175151.1357-2-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260613175151.1357-2-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=2a01:4f8:271:3f5c:0:25:1:1;
 envelope-from=bblank@thinkmo.de; helo=mail.thinkmo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Sat, Jun 13, 2026 at 07:51:50PM +0200, Philippe Mathieu-Daudé wrote:
> We mandate a compiler supporting C99 since 2019-01-17 in
> commit 7be41675f7c ("configure: Force the C standard to gnu99"),
> thus supporting flexible array members. Remove what is now dead
> code.

> +    uint32_t optarr[0];

This is no flexible array member. "optarr[]" would be.

https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Flexible-Array-Fields.html

Or are you talking about something different?

Bastian

-- 
The best diplomat I know is a fully activated phaser bank.
		-- Scotty

