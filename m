Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5A5CD6E69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfif-0003pk-8T; Wed, 03 Jun 2026 03:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfiZ-0003IL-4U
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:47 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfiX-0000GO-D3
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780468329; bh=6ngb6vQ5slCHIQlw070V4bqOwzt1fTzia7aCnQISkOU=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=NpfvefAtMuD2GbFYtHbmhdYCf8Ak1WMTrLHRCxTTE1btvSFsWjm7jVmOPHi3YR2O/
 hTGjRZE99tX0nBxyRTfF7yNwq1donjkLFUTECKJU7AA6UxxTYfA5hSR/mmM3Y3lkxS
 4Kr8kAQABlvOxdo6CqxAO3xEsWGvT7+Ruqn14PzA=
Received: by be1-2.in.mailobj.net [192.168.91.12] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 08:31:40 +0200 (CEST)
X-EA-Auth: 7eJxxchVdva92NlkFg6eGKUxpXT5Zgj+q9reqOYADi+jPyBAD/Gmsv7uRRrjAsfyE0EuFEGP6Q3SZIZEVsoaDazv42ijtP+X
Message-ID: <af7b9044-2845-4d82-93fa-ba19bd27d1fc@mailo.com>
Date: Wed, 3 Jun 2026 08:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] target/loongarch: Add default CSRFL_BASIC info
 with flags field
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260602030029.1476299-1-maobibo@loongson.cn>
 <20260602030029.1476299-12-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602030029.1476299-12-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/6/26 05:00, Bibo Mao wrote:
> With CSR array structure, its validility is checked from offset field.

"validity"

> Now default CSRFL_BASIC information is added with flags field and its
> validility can be checked with flags field.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/csr.c | 6 +++---
>   target/loongarch/csr.h | 1 +
>   2 files changed, 4 insertions(+), 3 deletions(-)



