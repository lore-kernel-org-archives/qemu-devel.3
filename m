Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD51C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 11:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdR6B-0002Ty-8d; Sat, 27 Jun 2026 07:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hk@zapateado.de>)
 id 1wdR63-0002TX-Rt; Sat, 27 Jun 2026 07:21:16 -0400
Received: from relay.yourmailgateway.de ([188.68.61.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hk@zapateado.de>)
 id 1wdR61-00062i-NY; Sat, 27 Jun 2026 07:21:15 -0400
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
 by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4gnVTj2hqRz741s;
 Sat, 27 Jun 2026 13:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zapateado.de; s=key2;
 t=1782559257; bh=m3d1/dUnv79+C0XjmcNhrsrcwJWGuO7QSnC4TOFsnDw=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=Whu3myqDhknXDugWfv464rGKSLGw7O2gSShrz7oXWaMgNNGPoExLXaVJ45djkmA+9
 6lBY/eD9L1dwsBLBj5bRNwvfeOewl9Kghb1hvMDtVDruPA4+OnOyemCO4dwAF+JVK7
 cJQh/7RpUD0oAwNEybP0z9SyukixEaTpilHUWGO83pV5gGn9UquUOr0sw0GOxXei+C
 251vIlXYR12ADzCON+O0rjQRD2dZ98ZsyDEiWVLUqdIhPUIQ++dBoHyZzkEVy5N7T4
 axH5XPywcr0sWvvJ3OK0dMDWHzTpoq68PuHI4wFJEuneSOGvuFvp8OIlDoM+5WpApf
 Zv8TJ2EBkAWGw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4gnVTj1y41z740G;
 Sat, 27 Jun 2026 13:20:57 +0200 (CEST)
Received: from mx2f6e.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gnVTh46jpz8sZw;
 Sat, 27 Jun 2026 13:20:56 +0200 (CEST)
Received: from [192.168.54.9]
 (ipservice-092-208-007-167.092.208.pools.vodafone-ip.de [92.208.7.167])
 by mx2f6e.netcup.net (Postfix) with ESMTPSA id 0917B2073E;
 Sat, 27 Jun 2026 13:20:55 +0200 (CEST)
Authentication-Results: mx2f6e;
 spf=pass (sender IP is 92.208.7.167) smtp.mailfrom=hk@zapateado.de
 smtp.helo=[192.168.54.9]
Received-SPF: pass (mx2f6e: connection is authenticated)
Message-ID: <e9aefd25-21e3-427c-b4b6-3aa8be2cd877@zapateado.de>
Date: Sat, 27 Jun 2026 13:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] QEMU 11.0.2 Stable released
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mjt@tls.msk.ru
References: <20260627082913.181C717AB6B@think4mjt.localdomain>
Content-Language: en-US
From: Helge Konetzka <hk@zapateado.de>
In-Reply-To: <20260627082913.181C717AB6B@think4mjt.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178255925630.3284731.16838149683580535929@mx2f6e.netcup.net>
X-NC-CID: ykodJb/p3SedYnLIhS4dafK1tyQIZxoCc0BMO5Av1faN
Received-SPF: pass client-ip=188.68.61.107; envelope-from=hk@zapateado.de;
 helo=relay.yourmailgateway.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi Michael ,

Am 27.06.26 um 10:29 schrieb Michael Tokarev:
> Hi everyone,
> 
> The QEMU v11.0.2 stable release is now available.
> 
> You can grab the tarball from our download page here:
> 
>    https://www.qemu.org/download/#source
> 
>    https://download.qemu.org/qemu-11.0.2.tar.xz
>    https://download.qemu.org/qemu-11.0.2.tar.xz.sig (signature)
I cannot download the release using this URL:

wget https://download.qemu.org/qemu-11.0.2.tar.xz
--2026-06-27 13:16:36--  https://download.qemu.org/qemu-11.0.2.tar.xz
Auflösen des Hostnamens download.qemu.org (download.qemu.org)… 
2a02:6ea0:c700::21, 2a02:6ea0:c700::101, 2a02:6ea0:c77a::47, ...
Verbindungsaufbau zu download.qemu.org 
(download.qemu.org)|2a02:6ea0:c700::21|:443 … verbunden.
HTTP-Anforderung gesendet, auf Antwort wird gewartet … 404 Not Found
2026-06-27 13:16:36 FEHLER 404: Not Found.

Regards
Helge Konetzka

