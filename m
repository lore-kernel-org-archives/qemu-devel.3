Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA347606A325
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=p80wUlJP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUfj5-0004TX-Jy; Sat, 21 Nov 2026 02:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xUfj1-0004TJ-FU
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 02:41:31 -0500
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xUfiv-0000W5-5z
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 02:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795246858; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=4W81obebWRdfnlpacsHa+CD2X6VUq8jPgb1dIoUZz0c=;
 b=p80wUlJPQbgS8TxaI6AHYPfLwIJJ+L9EZqhmrEIbJq/rI4R7C61APFsqzlb0ybtslBbriPfE+EzDpFcRavC9a9P795mmOXmAs5ZunuALGwPtWMZPAeEosUPyk/ghOVpfGd/d4SSAZdJuc7/wzB56crpu4PJigxQVUrOkghtw3M8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0XF8Fl3L_1795246856; 
Received: from 30.251.90.35(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XF8Fl3L_1795246856 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 21 Nov 2026 15:40:57 +0800
Message-ID: <bc4de753-0dee-4fb5-89e4-09344d29bb16@linux.alibaba.com>
Date: Sat, 21 Nov 2026 15:40:56 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/22] MAINTAINERS: make LIU's entries consistent
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
 <20261120200511.822573-21-alex.bennee@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20261120200511.822573-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-24.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

On 11/21/26 4:05 AM, Alex Bennée wrote:
> All the commits and s-o-b's use capitalised entries.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Thanks for fixing this!

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c5d0b07aad3..5d1444ff661 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -367,7 +367,7 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
>   M: Alistair Francis <alistair.francis@wdc.com>
>   R: Weiwei Li <liwei1518@gmail.com>
>   R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> -R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> +R: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>   R: Chao Liu <chao.liu@processmission.com>
>   L: qemu-riscv@nongnu.org
>   S: Supported

