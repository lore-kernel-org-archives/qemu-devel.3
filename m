Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB458109022A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3DtF-0001jU-RB; Thu, 19 Mar 2026 09:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w3DtD-0001iY-51
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:58:19 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w3DtB-0001xd-QX
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=WQCrO9hwsDs/QIu7AsxG5SF8brDxsPt/zmpR6KKd6zQ=; b=usKwEwj0DZ3ZYSy
 dw1vHFfZ/HWVTZghHP+cXogIjx0+X2rg1XgsAUDbvnpoEoYHl9Vy6G3rOw5vV7uc1kD8gXS8IqHJ3
 H2YVoTrFkkRbdBaJ7wk+fbGAQPh/p4P9RY5n8aP6tIKtr/BUyxOB0CZGB5AE8vhRSpICuf76n26mx
 LA=;
Date: Thu, 19 Mar 2026 15:02:06 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH 2/2] configs/targets: Restrict the legacy ldst_phys() API
 on LoongArch64
Message-ID: <abwB2bdIoNx5iZdm@hive.localdomain>
References: <20260319104944.66690-1-philmd@linaro.org>
 <20260319104944.66690-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319104944.66690-3-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/03/26, Philippe Mathieu-Daudé wrote:
> The LoongArch64 target doesn't use the legacy ldst_phys() API
> anymore. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable
> to hide the legacy API to the qemu-system-loongarch64 binary,
> avoiding further API uses to creep in.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  configs/targets/loongarch64-softmmu.mak | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
> index 476407f9413..a425b3dbaae 100644
> --- a/configs/targets/loongarch64-softmmu.mak
> +++ b/configs/targets/loongarch64-softmmu.mak
> @@ -6,3 +6,4 @@ TARGET_XML_FILES= loongarch-base32.xml loongarch-base64.xml loongarch-fpu.xml lo
>  TARGET_NEED_FDT=y
>  TARGET_LONG_BITS=64
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
> -- 
> 2.53.0
> 
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

