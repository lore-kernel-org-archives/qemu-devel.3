Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0654DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9GP-0007rM-Fv; Thu, 23 May 2024 10:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sA9GN-0007qy-Aa
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:17:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sA9GJ-0004BM-IK
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:17:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f44dc475f4so3051604b3a.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716473862; x=1717078662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pdGbQPjxme3DwJ5zAVtp0PaiB9VUVcElj9okfZZHNVs=;
 b=xg0Va5Z3Ft+/DD6ggmbUf74vg42ePm35EWykmpgimWe9ck78DAoI1xjFo7t+8ILyiB
 MhrqJbz74W1GHu6BJ86P+StkJq7bnpkarWg/8zHcI1RcCqAvVQ/Po50lHsfThhEHZGP2
 v3UZkOjE6oa1TfEiDffTSEnSWSEdpR/j4KkEFU/eKeO3HC54QI2r/gg55KgepCSKkayQ
 OKT/b31sCvqNYSBbdtUMpYBYBY9oeR9/bTozVujc6+ZPdLib+xcAp5dHqZEf6ddtsSmi
 xvm/Fb/FJiwCps7b2YxUD2MMfncVDmRtb2XUPzvzbroWFk1801kewKwPC0h+ZmfemCJm
 MdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716473862; x=1717078662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pdGbQPjxme3DwJ5zAVtp0PaiB9VUVcElj9okfZZHNVs=;
 b=tsbDZxltNGAmE+Q3z8HIDdgvHCq21yjk4/8FERWyjKgiusy5HInv37Jm3AlptxIsdF
 xiV4e4YoAM/xMKQ1+n73tcrmubq6hDB8a3H5ZRuSO89fP9hcoxiSX1inVT1rIHEjcZ3p
 pYUVQ3lOsRX7ffaB3NnVgRMBwq7Ajbc9rFoDc1I3aD0tsictPc9M53PR/U+Adwjr6rSf
 WalQZgE28538rHVF5AO9n7WgtalIQHxTm3TGZkScgKah18ym8zrBmSvKb1Y/5zxk+FjY
 OgoIXSP2DVSXubEl7Ov8D3H0VQhh7tNJqHtnniSJFfevLIt9R9KXpo9T3PoEW7YWtlPJ
 J0Og==
X-Gm-Message-State: AOJu0Yz6bhc0woOLCU3bm/OikA606pjcr4DgYoiLj8gnwlzf0R66x7lK
 ZfwMN0nnrxcLkdY2P4hvHYPLqJGZ+aHZw5+oCfqtaMi+Cdo0i9UhJ+YBCJ2U//0=
X-Google-Smtp-Source: AGHT+IEwD5w0Gc0cHUrXYT9YWjBvHPrWayWGL2Mi7Pf6VCBsFoUaKIU6VUsVpre52PKS2U34ELss6A==
X-Received: by 2002:a05:6a00:a0e:b0:6f3:f447:57de with SMTP id
 d2e1a72fcca58-6f6d6106f77mr5483873b3a.19.1716473862095; 
 Thu, 23 May 2024 07:17:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a83d48sm24156983b3a.64.2024.05.23.07.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 07:17:41 -0700 (PDT)
Message-ID: <6c619574-1091-4218-b3b5-e728435c88ca@linaro.org>
Date: Thu, 23 May 2024 07:17:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/ppc: Move ISA300 flag check out of
 do_helper_XX3.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240523094821.124014-1-rathc@linux.ibm.com>
 <20240523094821.124014-2-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240523094821.124014-2-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/23/24 02:48, Chinmay Rath wrote:
> Moving PPC2_ISA300 flag check out of do_helper_XX3 method in vmx-impl.c.inc
> so that the helper can be used with other instructions as well.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/translate/vsx-impl.c.inc | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

