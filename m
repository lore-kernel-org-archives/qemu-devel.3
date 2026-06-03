Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8BBCD6E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUguT-00084t-CD; Wed, 03 Jun 2026 04:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUguK-00083R-Vs
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:02 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUguJ-0002p0-Co
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780471809; bh=KJvJTZVApkdRk99lzWwqGcFraSvMRngywlojJ7oG04c=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=fwZztRRJLMaFmXm+pyVnksqUc7Nn12lO2NFR4Q2GvKVTZveA5S1F7Xn+l95a/Sba4
 kO6ldzllJXFjPQohN6qzUHXbDYIU6V4pJhgJr2NQgQ8k9Im9Zuf4z+Ma+s55p+W4iV
 H1K+A0NVjFA0ROxRQWZjrs8jPgKZhEEAekHKuYvw=
Received: by be1-1.in.mailobj.net [192.168.91.11] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:29:21 +0200 (CEST)
X-EA-Auth: DSu9ZNS5I1vh8nK2vCRxRFCEK8WNNqBwguTUpffA2JOgBRu92oQ256uYrDKsOWeUXZ5Iv/pJqyFdI/umuIgMRFOW/Gr6esL3
Message-ID: <002e3675-ff9f-4e3a-ba32-942c539044b5@mailo.com>
Date: Wed, 3 Jun 2026 09:29:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/38] MAINTAINERS: Drop stale F: from "Guest CPU cores
 (TCG)"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-4-armbru@redhat.com>
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

On 3/6/26 08:39, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we merged util/cacheinfo.c
> into util/cacheflush.c.  Update it now.
> 
> Fixes: 7971375287 (util: Merge cacheflush.c and cacheinfo.c, 2022-06-20)
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>


