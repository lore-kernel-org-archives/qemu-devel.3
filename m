Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8725ACD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgv9-0008Qq-81; Wed, 03 Jun 2026 04:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgut-0008Fa-Oa
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:35 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgus-00035P-C2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780471989; bh=7gWAeujX1+Kjk7S3O8NhZbp1yUm/ukGilgELrmX6bUg=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=NwZRo4s8xipsChWMMQG8v430Ixdus7+vFRhf933wnLGnrNhW19EhO7EScwNoHzLWe
 5VBDOZG+4lHFEZZDqWS9TwtnE53ItFunCngnvmpk2OtxEZz6OwrV3ahXNfUp1E4Yvx
 NI6/3+YfhanV2ryRpJPhrsGlvEBTOBuHHgjTTiGI=
Received: by be1-3.in.mailobj.net [192.168.91.13] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:32:47 +0200 (CEST)
X-EA-Auth: 8IvzebplsHL6j1hzAiSz93LtaD8BZLDtXqlF58B0BwMiWvuX4BtZMTVoISz9YMIlQk7m8a0C63dZL/UO5WbhwuciYbHOBwxP
Message-ID: <c7711687-69d6-4a10-800b-03902cd554ed@mailo.com>
Date: Wed, 3 Jun 2026 09:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/38] MAINTAINERS: Fix F: in "Apple Silicon HVF CPUs"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Alexander Graf <agraf@csgraf.de>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-9-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-9-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
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
> We neglected to update MAINTAINERS when we deleted
> target/arm/hvf-stub.c.  Update it now.
> 
> Fixes: 293984563e (hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX and HVF, 2026-02-10)
> Cc: Alexander Graf <agraf@csgraf.de>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>


