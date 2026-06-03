Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C05BCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgvI-0000Ks-8s; Wed, 03 Jun 2026 04:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgvD-00009R-S6
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:55 -0400
Received: from msg-4.mailo.com ([213.182.54.15] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgvB-0003AO-SQ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780471749; bh=Exw/MqzmmMd1Vbtrx2I9Z7Pz45FCEjQ4uro/dQQu2U8=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=VeBf8sYQJZVsSapbK83zx8jVoiu8J+uEsUUUpO4Mq2U7mXqzjzb9hEhj1FLFt2Isb
 uv5TzVp/fztTCgR0jxq9cIK+KtQme2QawTyHq0h6nomu0bVv97W72/1+o+U0ko/e2v
 vwJUnUm8OHG5jrhHtVySlDqHAU7kHsrCiNurxLko=
Received: by be1-8.in.mailobj.net [192.168.91.18] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:28:54 +0200 (CEST)
X-EA-Auth: UIZLls9CKpkNWx0GA6B/5B6fzGetvWBWvOycgnZrns88AkZJO7Trghzn56CodaVdL7H3+2gRgXXuqdOdgaFPRR8yituLizIl
Message-ID: <41ef9019-99f2-48d3-bc9e-8739f95865fc@mailo.com>
Date: Wed, 3 Jun 2026 09:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/38] MAINTAINERS: Fix F: lines
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com
References: <20260603064032.3733394-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.15; envelope-from=philmd@mailo.com;
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

Hi Markus,

On 3/6/26 08:39, Markus Armbruster wrote:
> Quite a few F: lines don't match any files.  The quick & dirty check
> 
>      $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null
> 
> finds about fifty.
> 
> Philippe Mathieu-Daudé recently posted a few fixes:
> 
>    MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>    MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch section
>    MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
>    MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
>    MAINTAINERS: Cover python.docker with Python library section
>    MAINTAINERS: Fix s390x storage key/attribute device paths
>    MAINTAINERS: Fix tcg/s390x/ path
>    MAINTAINERS: Correct scripts/coverity-model.c path
>    MAINTAINERS: Fix RISCV related paths
>    MAINTAINERS: Fix hexagon-linux-user.mak path
> 
> These are in
> 
>     Subject: [PATCH 0/7] docker: Remove LegacyKeyValueFormat warnings
>     Date: Mon, 18 May 2026 12:22:15 +0200
>     Message-ID: <20260518102222.80735-1-philmd@linaro.org>
> 
>     Subject: [PATCH v2 0/4] buildsys: Stop checking for ESA/390 host
>     Date: Tue, 19 May 2026 19:12:36 +0200
>     Message-ID: <20260519171240.97420-1-philmd@linaro.org>
> 
>     Subject: [PATCH] MAINTAINERS: Correct scripts/coverity-model.c path
>     Date: Tue, 19 May 2026 19:19:26 +0200
>     Message-ID: <20260519171926.98099-1-philmd@linaro.org>
> 
>     Subject: [PATCH] MAINTAINERS: Fix RISCV related paths
>     Date: Tue, 19 May 2026 19:26:21 +0200
>     Message-ID: <20260519172621.98469-1-philmd@linaro.org>
> 
>     Subject: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
>     Date: Wed, 20 May 2026 14:39:47 +0200
>     Message-ID: <20260520123947.12711-1-philmd@linaro.org>
> 
> This series takes care of the remainder, except for one discussed
> next.  It applies cleanly with and without Philippe's patches.

Not sure if you are expecting something from me here, I dropped
these thinking you'd include them in your cleanup series or in
a PR.

Friendly recommendation: merge what is already review and repost
what is not in 1 week, do not wait for all the 38 patches to be
reviewed before posting your PR, that'd be exhausting. Or even,
do not repost in 1 week, directly send your PR; these patches
have been long enough on the list.

Regards,

Phil.


