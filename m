Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77365CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfiT-00030h-P0; Wed, 03 Jun 2026 03:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfiS-0002x1-7P
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:40 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfiQ-0000F7-Mw
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780468509; bh=C/cmGvy+wwTcEh21OjQS7A6yxBT/Fh6/zJYZJGUNnok=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=Zm9fdjRFIVJIanpnW+Pk+ATdBN8aj386Dfjq2fWS+RrpnOaHoei2M+VFtntpyMKoj
 WSvogYV9MF2GcwmKOvN3JYtWPgSK1TarkyltXK73Xmiyx+aoyrUp4nic4+6r1GQLKw
 F39jxtjxNRoNr7OrNjADne+lyy7wiR7yWzni9c4s=
Received: by be1-7.in.mailobj.net [192.168.91.17] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 08:34:42 +0200 (CEST)
X-EA-Auth: 8fMt0eDKtu13af/9AVB45cTz05MX7OKhg3zYsSi6AmF+/fBSukcvM+sfpi+r0knAnRS1fFR9z2yJjKfELtwlM3hmlvJWJ9uu
Message-ID: <a3c3773d-c77f-40eb-aedf-ee936d959d87@mailo.com>
Date: Wed, 3 Jun 2026 08:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] target/loongarch: Add wrapper function
 get_csr_offset()
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260602030029.1476299-1-maobibo@loongson.cn>
 <20260602030029.1476299-13-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602030029.1476299-13-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/6/26 05:00, Bibo Mao wrote:
> Add wrapper function get_csr_offset(), it is to get offset from structure
> CPULoongArchState. There is no function change, and it is used for future
> LVZ feature.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c                           |  4 ++--
>   target/loongarch/csr.h                           |  4 ++++
>   .../tcg/insn_trans/trans_privileged.c.inc        | 16 +++++++++++-----
>   3 files changed, 17 insertions(+), 7 deletions(-)


> diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
> index 508a3214fc..ed7c603a0b 100644
> --- a/target/loongarch/csr.h
> +++ b/target/loongarch/csr.h
> @@ -27,4 +27,8 @@ typedef struct {
>   
>   CSRInfo *get_csr(unsigned int csr_num);
>   bool set_csr_flag(unsigned int csr_num, int flag);
> +static inline int get_csr_offset(const CSRInfo *csr, int vm_level)

unsigned

> +{
> +    return csr->offset;
> +}
>   #endif /* TARGET_LOONGARCH_CSR_H */



