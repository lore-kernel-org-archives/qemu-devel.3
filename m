Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1E7C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZ2t-0006ZP-Ek; Mon, 27 May 2024 08:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBZ2X-00068D-7f
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:01:25 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBZ2G-0007Ej-Ub
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:01:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f4a52b9413so5219765ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716811263; x=1717416063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9w0L7T5wggHpd1ci3Zaa2n5GNcJdc8VgVQL+loHFhac=;
 b=bY+YR9tESpf/VNh66XpvkiIp/cqkW5WL7azdudoOpWyy5Vqd/j/PRj5Jgn8OX3VHdJ
 JDE1u+fxCZb6kMb9BL8/cCm+nzE8FCFkfB9+GTiRY/goxScXfQuZYfsTupqyop2CbVTe
 3+K4QoVgU8OVuF54/uH4EUdMTQ1r/ha/3omhq545pMw/U0zG3b1F9PKdgvFarpLAgnYE
 MfOrWnZUmIr1KGQ44Zwe2SAMtuMzBbLeiUYqSZRCo5SWE3x0M8hNg/1fxfjL5ZYvvNNJ
 9ov+w3GXLUcb1kD8eBoozAQ/mTks1ReLc/UBMj2KaCMgpeYgbv+4ERwH4mjvw3yeZyR1
 LsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716811263; x=1717416063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9w0L7T5wggHpd1ci3Zaa2n5GNcJdc8VgVQL+loHFhac=;
 b=csIqDUGzeUIldOJj6aZn0N5FUzy8nUlRIR9MhHmz4OFB5BoaIKK1GDnXWhT7kbxhIz
 vux5VFTE/1WPTbOrUodBT+dvH5oXfQHggvV1LC7PC2kYvjj8djtksoIX7W7bQiX/p/PK
 7IT7sLGCbG32x5BVbwqVf903hHd4P1wWwCc/SeIp2lYg3eQJ71fImQBIu0RnCmNMEciU
 bkVQp6EnYMDbVJjp0IaJmH1cVef6h9RuIfXUwjpEKY1N9tFL028dJMan8fqSCJWH2noQ
 pJclL8hYrPJVj6AgR9HvF6RnzW1/ERJGjjKl8RCeJA8mdx/X22rCiD6NNVdALv7zMdp0
 juGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7AafOTnrCbORktOK2PXUMq80ZxAKuHpwxtZry6gG9ezHNUZAAzTO8b9auVQMhebdijm5kV0DAU0GWVjwT/mZgKi0tgdg=
X-Gm-Message-State: AOJu0YwoXwNag8XZWFCZ8eqXn2/ONB6d6xDIXXo+GGtX6gvZMpJtCQAd
 mqHWhWEDECzVRRFbSVtpUKrV/lB4xLR2ad8u8cMG/2doDSWOb5dFul3Z2/mCUS4=
X-Google-Smtp-Source: AGHT+IEKnQZtxjh+qkDoB+BpHVEqqhvvsZijDlnieDswM/rlBP1y0U1DLNvreob5CuPmxcqJi8J0OA==
X-Received: by 2002:a17:903:22c6:b0:1f2:f182:f616 with SMTP id
 d9443c01a7336-1f4486fd2a1mr105695335ad.13.1716811263028; 
 Mon, 27 May 2024 05:01:03 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7bb72fsm59476865ad.91.2024.05.27.05.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 05:01:02 -0700 (PDT)
Message-ID: <8e2b5906-e080-4b17-9e71-f718eb7a98da@ventanamicro.com>
Date: Mon, 27 May 2024 09:00:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] target/riscv/kvm: define
 TARGET_KVM_HAVE_GUEST_DEBUG
To: Chao Du <duchao@eswincomputing.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, pbonzini@redhat.com, alistair23@gmail.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@dabbelt.com, anup@brainfault.org, duchao713@qq.com
References: <20240527021916.12953-1-duchao@eswincomputing.com>
 <20240527021916.12953-5-duchao@eswincomputing.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240527021916.12953-5-duchao@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/26/24 23:19, Chao Du wrote:
> To enable the KVM GUEST DEBUG for RISC-V at QEMU side.
> 
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   configs/targets/riscv64-softmmu.mak | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
> index 7c0e7eeb42..f938cc1ee6 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -1,5 +1,6 @@
>   TARGET_ARCH=riscv64
>   TARGET_BASE_ARCH=riscv
>   TARGET_SUPPORTS_MTTCG=y
> +TARGET_KVM_HAVE_GUEST_DEBUG=y
>   TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
>   TARGET_NEED_FDT=y

