Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CADCE7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 08:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJqUO-000698-7G; Sat, 07 Dec 2024 03:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqUL-00068V-Ro; Sat, 07 Dec 2024 03:48:33 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqUK-0001JB-19; Sat, 07 Dec 2024 03:48:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 47A4BA4044B;
 Sat,  7 Dec 2024 08:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8802C4CECD;
 Sat,  7 Dec 2024 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733561309;
 bh=CVM0mjv5RG7brvVCh3WS0X7N1BVIzQDL/bjpUuAkI8E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ARrCaxyPTlRedWz8BQ1b4n97z9HBC6LREwwRjDuyLW6J3wZqbR0xwoYsWQb1G5MMy
 lpSpKGMi8po5BuW+ZxNNSQR/RE2biNnaesFZaKlpJuRs9c2O4HXIZCBofhMCf86EdY
 VTNiLQD/4CzvnP9rub4gj4C/DqAJTG1l08LFDXi0mApCKkKBk3AZ5/p/1X4wF9zzPn
 I3dAXnJ+Ouaw9lgyMkKZl0xegWhZPPDbi0BFcYOM0A11ntsLExdG0vmm6XGmCgSseG
 3kCDJPdcF2f9UumX1EAX/znUld9mh/nWuwI+TTIz0zCsb8boyxEE64UHCWQjsX7p6Y
 gx1v9PjtzimcQ==
Date: Sat, 7 Dec 2024 09:48:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor
 Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 31/31] FIXME: acpi/ghes: properly set data record size
Message-ID: <20241207094824.465c8bb6@foz.lan>
In-Reply-To: <87o71o2f09.fsf@pond.sub.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
 <104add143d349685cea1b47298b8f5d367a3a15e.1733504943.git.mchehab+huawei@kernel.org>
 <87o71o2f09.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Sat, 07 Dec 2024 07:17:42 +0100
Markus Armbruster <armbru@redhat.com> escreveu:

> Another subject line that suggests this isn't fully baked.  Respin to
> reduce confusion?

The last 3 patches on this series were purely to debug some things,
and aren't meant to be submitted. This particular one is just a potential
future cleanup. The FIXME there is just to remind me that I would need
to double check it, and provide a better description when submitting it
again.

Thanks,
Mauro

