Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B505CD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgvD-000091-4b; Wed, 03 Jun 2026 04:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgv9-0008Sg-DC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:51 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgv8-00039v-0e
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780471389; bh=yAiu3w2G3lDUCfjX4V3NtgO+0j43x+iJJtfaddQqxak=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=YyIRHvlUMqFmW5mTwP0iyksrnPB28kcrQ86C6+DRKgseJUOqJQfkDsmYiUHpd4ST3
 2KWk+wqtDjn/OYIYpsuFFYAzXzO4EsGyRfJ83i4a93cPuONwAYoC/OBDoNypjMKD6H
 053KQbEtomeC8Nn4ph/CLIpcCNhhOJwH+1ThPaX0=
Received: by be1-3.in.mailobj.net [192.168.91.13] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:23:05 +0200 (CEST)
X-EA-Auth: +DCMrhiGIOMCNXn7AQsuWUzutDgE6Eaxry4thtnwlAHOcy7OnWUBZ9Q1fKeHpEI666YaRBrLybCP00IlUgxO/yAZQC5vEAtg
Message-ID: <8fbdb14c-1751-4822-a1db-7ced19c65975@mailo.com>
Date: Wed, 3 Jun 2026 09:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 36/38] MAINTAINERS: Fix F: in "Build and test
 automation"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-37-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-37-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
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
> We neglected to update MAINTAINERS when we split off the testing docs.
> Commit 97b091c88f (MAINTAINERS: Update the paths to the testing
> documentation files, 2025-06-10) updated it belatedly, but missed one
> line.  Correct that now.
> 
> Fixes: ff41da5030 (docs/devel: Split testing docs from the build docs and move to separate folder, 2024-08-30)
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>


