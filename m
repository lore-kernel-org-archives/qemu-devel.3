Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21710CD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgvB-00006J-U6; Wed, 03 Jun 2026 04:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgv4-0008OH-57
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:49 -0400
Received: from msg-1.mailo.com ([213.182.54.11] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgv2-00039A-Mz
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780472109; bh=DkuOg5gLk5gkH0MQnYseLcufmdJAOYLL4PPvAPg+mLw=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=FbmYmwAMKNiRBAuOphe0H+Jwgs42MtgoYyUAoQomMJkudsfFmZoMKs5DImskJAamY
 L004dJg3jQg0as8ypL9sYjqZdT8WHuGD2QHZ1OC6+oQ8duiHS8VXswZg764jHlo9Lg
 D4YMDyiA2HWfyvsbEkVdyMIBckmEkaB6PQmys+IU=
Received: by be1-5.in.mailobj.net [192.168.91.15] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:35:03 +0200 (CEST)
X-EA-Auth: jaGG1xUH4qhzaYuKgP7dolhfDaSGZ+/IwZnB2vVIHGdGM9wVR4Q+mUvx0IrOwmFHc4hEbVcIuSt3oLU6hi+Lmb2Jrpolqie1
Message-ID: <83caba57-44f0-49c0-a00f-2e2aa6a2af00@mailo.com>
Date: Wed, 3 Jun 2026 09:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/38] MAINTAINERS: Drop stale F: from "EDK2 Firmware"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Gerd Hoffmann <kraxel@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-33-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-33-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.11; envelope-from=philmd@mailo.com;
 helo=mailo.com
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

On 3/6/26 08:40, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we dropped roms/Makefile.edk2.
> Update it now.
> 
> Fixes: 22e11539e1 (edk2: replace build scripts, 2023-03-09)
> Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>


