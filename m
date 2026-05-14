Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771D0CD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNTIA-0004Sf-2C; Thu, 14 May 2026 06:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNTI8-0004SX-G2
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:27:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNTI6-0002yz-R3
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:27:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso4564266f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778754461; x=1779359261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zggFzJerIf0xBKSgQOcOG7F8TxL+bOqm30hJXi/FoHk=;
 b=LhO3Hh6CCt69sd7eUAFTeM1ycmPIUR4HCdujV/q9QFLDpfN3sww3r7mWNrATpba1T1
 7/67pmijVv9jG/8XArp9Af+AjqhBs+njLeQTOuBcwlgW/3ln9gBpKaoPiSVQMUTm63wn
 CWlS31d86U0J3UZr7h9zxELmaEhD5fmZQhIdtdOOCPW7bymV3zoNVqV3Ts3HPVxstLkA
 HLUJ8kbQJJzS/RXYlmIGWGoZcUdadIsXyub9yi2X55JQe7ODGMbcVtPRNpnw5oXXmxuL
 rgaDaNtTXqhqky0b49jpwnwKhUAVP7Nt68frnLGSpeftOcFZccCzNphBxTaHh3gjNC6a
 vesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778754461; x=1779359261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zggFzJerIf0xBKSgQOcOG7F8TxL+bOqm30hJXi/FoHk=;
 b=dNwiHmj4LD9Szc021I4iE1nfFvzcLXwMBT8tc82YY2C0FRfc8SZdD0GbX2SPQQzDOl
 rt9eNNKZwaW0DkJo50BeJBK4/z7BA8zWo2Ovcl0Rjf1d5+u4Ce/SJMAcSaLt+PJLC8u4
 jgZb/znjXsuKvusGoJvd5RiC2xh9Ufj/bonU/d/AHlkyLlRmrB5rvbejWCh/amPI9b0k
 H8yApaiRvemFGI2JenputgEDOToryf8ldXJhj/1Zv2W4P0cuFzqlwVfkHrW7N1vYmgvu
 Tyk1IbnsWY6nlr/N9o11wCD5qLO0uGnWE4TOHl8xb6keSWHTrKCxjiVKHb6JShukEEAC
 W20w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NjOGDkPj5pSrT7qsQf6GvHgw5miYCJmsJcyaKKYeeMH5t9t19F3n94EHD4XQrPt8e9RRDPPQm+pFE@nongnu.org
X-Gm-Message-State: AOJu0YyL7+riVzI167Or6J+urlB8bsN7L1bYxDaEM0QuhrD9PEx4+wj7
 qSq0Pw/t/oUCZ54o8ie6mUKGLNpCU8jlozbC55FK8qeV/kKH+YyOr20xG8dPFWwY2IE=
X-Gm-Gg: Acq92OEatnx2+gMHMsQClDrK7Z1ja5eUGFVr4rvP9F2T5I5aBbU4q0n77+QTWPY/MeF
 T3OspUyxnSEdJJkMfXqCKyH6nwzxnEdkIgqULsPnpqqV4c8UUMX8sxDA14ONxs0sJsmx68bOKLm
 vkOvCXcWHR4U43+6ec+3cZJQjXZO5BJ4Ilog6Ia+CHTs57PYmEy/ra4DFukRAd1eLdH0CL+nXoI
 6c//wL/4fFvOCnRS54YfYwSStJBEsUFeX6PkwVYLqssv4HqxVQ4cCAYUuMqCTORbUY+zfPmfk/u
 XCcc7DraZcAZnp9crd7xL0LM4hA9qydNmV8nybax7xDiTpTxjJvCcGzK5wuK5z68JuSpAbEgEzZ
 3ScpeuojJaKOo0EV6rQFNdAU3aKz3jICuk1zpZAwxz5XgXdrmSfRUCFeDANS0o315PvKDufaY3E
 rfvZdtnSeyoBnF2utH3bu6+7aK6MZAlgdcEYvSQcs48GnlIP1KXvGanZtRBbnU5t2Rug==
X-Received: by 2002:a05:6000:2882:b0:43f:ea91:63ff with SMTP id
 ffacd0b85a97d-45c58a70c1emr11549096f8f.10.1778754460564; 
 Thu, 14 May 2026 03:27:40 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a178adsm6243750f8f.18.2026.05.14.03.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 03:27:39 -0700 (PDT)
Message-ID: <7c56afa9-711a-4807-bca3-2625a05fdc39@linaro.org>
Date: Thu, 14 May 2026 12:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/35] target/mips: add Octeon multiplier state
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-7-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-7-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/5/26 20:22, James Hilliard wrote:
> Add per-thread Octeon multiplier state for the MPL and P limb banks used
> by the VMULU/VMM0/V3MULU instruction family.
> 
> Octeon3 extends the older MPL0-MPL2/P0-P2 state with high lanes
> MPL3-MPL5/P3-P5, programmed by the two-source MTM/MTP forms. Represent
> both banks as uint64_t arrays so the TC state matches the architected
> 64-bit limb layout used by Octeon68XX user-mode code.
> 
> Migrate the multiplier registers in an Octeon-only subsection so
> non-Octeon CPU models do not grow migration state.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split the multiplier state out of the combined Octeon arithmetic and
>      memory instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Document and keep the Octeon3 MPL3-MPL5/P3-P5 high-lane state used by
>      the two-source MTM/MTP forms.
> ---
>   target/mips/cpu.h            | 12 ++++++++++++
>   target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index b478f834c1..346713705a 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -459,6 +459,14 @@ typedef struct mips_def_t mips_def_t;
>   
>   
>   typedef struct TCState TCState;
> +
> +/*
> + * Octeon3 adds a second bank of multiplier/product limbs used by the
> + * two-source MTM/MTP forms: MPL0..2/P0..2 from rs and MPL3..5/P3..5 from rt.
> + */

I'd reorder this patch just before adding these MT* instructions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


