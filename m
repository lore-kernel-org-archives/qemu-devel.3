Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE23CD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgvF-0000A3-Ms; Wed, 03 Jun 2026 04:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgvA-000062-Jv
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:52 -0400
Received: from msg-1.mailo.com ([213.182.54.11] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgv9-0003AD-6L
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780471389; bh=UyBuANqosB/OewQpqiqT9T3fwSALYaP6lfShSRM1Ql8=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=VCQcPh6Gbr9UBHtHsvTgdL044gGXua+pj+7iJYgt36ok+j9Wa/fU96OtEGI3YF0Xg
 4ZlBAIwdC9tMpA/QfL53ioM+1n9lwIXlVr4afS7Ry4ZcnRoFbcUT6Maln2552rEmaG
 YxPLpcrcJLMBIFevzbyAuXvcVcsoY4H1k08JDX+Q=
Received: by be1-1.in.mailobj.net [192.168.91.11] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:22:17 +0200 (CEST)
X-EA-Auth: +R3OHiFf70QR5AX1r8m2j4p89yd+KLMyO4SEYbpIAe/7aoW5nv25CECkDAH148HHabHPhACjG+tjCjEYeDXXG5UFuIcPxO+e
Message-ID: <ff2c3cd4-4457-4f55-bdd7-9aa2d7f2bbfd@mailo.com>
Date: Wed, 3 Jun 2026 09:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/38] MAINTAINERS: Fix F: in "Darwin (macOS, iOS)"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Stefan Hajnoczi <stefanha@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-11-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-11-armbru@redhat.com>
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
> We neglected to update MAINTAINERS when we deleted
> .gitlab-ci.d/cirrus/macos-14.vars, and when we added
> .gitlab-ci.d/macos*.  Update it now.
> 
> Fixes: 984b192bdf (ci: drop cirrus MacOS build, 2026-05-26)
> Fixes: 7684e78132 (gitlab: add initial MacOS 15 on gitlab runner, 2026-05-26)
> Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a99c84839..2bf421c659 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -692,7 +692,7 @@ F: scripts/nsis.py
>   Darwin (macOS, iOS)
>   M: Philippe Mathieu-Daudé <philmd@mailo.com>
>   S: Odd Fixes
> -F: .gitlab-ci.d/cirrus/macos-*
> +F: .gitlab-ci.d/macos*

Ah, slighly better than 20260602162457.828969-4-stefanha@redhat.com.

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>

>   F: */*.m
>   F: scripts/entitlement.sh
>   



