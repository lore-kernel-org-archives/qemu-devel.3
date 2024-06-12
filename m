Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A47C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMom-0005i6-Fv; Wed, 12 Jun 2024 08:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHMoj-0005VW-Vh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:11:06 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHMof-0007Sa-8q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:11:05 -0400
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 1709440755E8;
 Wed, 12 Jun 2024 12:10:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1709440755E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718194258;
 bh=DRSFjF/dgB1gvkLyyo4wetTJfJh6MBV01nJzR81S+XE=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=gtLVvPOLYzimfd9bhrzzDTCF85us2qt6IX8KOZbdnRgDAPKa7HbWEPhYG/aJjl0FM
 FEvTAuQFvflX9pfmiqEu+W8858UMO34H/mtmGzyES1s9tbLQTyZ4fP5tp+1vKDNx/d
 0bVBc/VA3frtbPORqfGPkUcRnWoSTYOHMlH9S0tQ=
Date: Wed, 12 Jun 2024 15:10:58 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
In-Reply-To: <CABgObfaswAJRffjdu9h8crD6jvFAP78CaDDbutvoa7EGxwuy1w@mail.gmail.com>
Message-ID: <e292326a-0f71-3d4d-4ec1-562efe94271b@ispras.ru>
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <e26ac8a0-5cb0-22a8-fbf9-54f198cdc7ed@ispras.ru>
 <CABgObfYf8=3yXu1p6q6jzyZ7uHy92BHaBXtJY8AMYXBdd9+HGA@mail.gmail.com>
 <caa7d068-a2c6-28a4-51d5-93c61f004bc0@ispras.ru>
 <CABgObfaswAJRffjdu9h8crD6jvFAP78CaDDbutvoa7EGxwuy1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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


On Wed, 12 Jun 2024, Paolo Bonzini wrote:

> Ahah, nice. :) I'm pretty sure that, when I tested "pf =
> (__builtin_popcount(x) & 1) * 4;", it was generating a call to
> __builtin_popcountsi2.

Why write '__builtin_popcount(x) & 1' when you can write
'__builtin_parity(x)' in the first place? 

> Still - for something that has a code generator, there _is_ a cost in
> supporting old CPUs, so I'd rather avoid reverting this. The glibc bug
> that you linked is very different not just because it affected 32-bit
> installation media, but also because it was a bug rather than
> intentional.
> 
> Since you are reporting this issue, how did you find out / what broke for you?

I found out from the mailing list. My Core2-based desktop would be affected.

Last but not the least, I'm sympathetic to the efforts of my distro maintainers,
who I imagine would be put in an uncomfortable position by this change.

Alexander

