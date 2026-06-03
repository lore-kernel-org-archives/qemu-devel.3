Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CA1CD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgv8-0008Oz-4Q; Wed, 03 Jun 2026 04:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgur-0008F3-Bi
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:33 -0400
Received: from msg-1.mailo.com ([213.182.54.11] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgup-00034I-Mx
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780471989; bh=fH3fFr69+5oTs14WJ3zPYqys5LqxJ0B3cLAFgnotpjI=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=O2VxdaS1WyDDlGevoY2Cdlc4Qj1c0bBAa3YNOSGW5oBvwYNCZ1lVut2XP2Uy10PSe
 thOfKBBuN1Fs5xAG52JBu2NU4U+x1LRrAueGbrv9ToweQYQdqKxHtgMV0DAQ2fq0bG
 i7MPE+Kf3GVp+OEdKQwZm1qEXnuf9mMjQXhA/NLM=
Received: by be1-1.in.mailobj.net [192.168.91.11] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:32:23 +0200 (CEST)
X-EA-Auth: vQV4oBK53Q0tYH4+r+JhY2WJHq2ba0kCEmK4JPwEYkqh7m+952a5fW8BLpN7eg9dMRwx8qFz/5yaI2HJ8EYcZPXOo571rZ4a
Message-ID: <a7341ab4-4556-4113-98ef-1438b5f91016@mailo.com>
Date: Wed, 3 Jun 2026 09:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/38] MAINTAINERS: Drop stale F: from "Overall CPUs
 other accelerators"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-7-armbru@redhat.com>
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
> We neglected to update MAINTAINERS when we deleted makefiles.  Update
> it now.
> 
> Fixes: 1a82878a08 (meson: accel, 2019-08-18)
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15793b088e..2dc53c7e2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -541,8 +541,6 @@ F: include/system/cpus.h
>   F: include/accel/accel-*.h
>   F: accel/accel-*.?
>   F: accel/dummy-cpus.?
> -F: accel/Makefile.objs
> -F: accel/stubs/Makefile.objs

Adding:

   +F: accel/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>

>   F: cpu-common.c
>   F: cpu-target.c
>   F: qapi/accelerator.json



