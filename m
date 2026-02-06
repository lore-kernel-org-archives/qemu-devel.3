Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E70EE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUac-0008NR-1T; Fri, 06 Feb 2026 17:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUaT-0008LB-QA
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:46:08 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUaR-0004FH-Jr
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:46:04 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-29f30233d8aso8696965ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770417962; x=1771022762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77aotkXHt4IJq2ZfSL+LWAxxh7s1p/STZp88kofeVpY=;
 b=Jgwh1N0wcMwoLbFBNKL4n138/BfTVkm1ySNOYOj1PEH0BmCqasppvyx9vCzG7Jy7ij
 JPUaXM+Nm0l9mByUqcM08QCh6+lKC7Kw9UGdGYsdSGXtFRiWkybfoZNK6UZcFDYs4MC0
 LnnShg9Fgi9aK8AMrr5s0SOPh5wIMDuh35oV4oGLDzjSrlaCCn9v35+l2vf78alJWZyY
 skCM5HvU5ACeNOZnUCqfXEFetJZhH0goJKNfuEmY3WeFN/lXV1kbBi3gzWE1eDXGHVMu
 kMQLn6MzWI6RDmHiUVzoDlxyLcdXAxtvCMHMexfMZtxj91oEOUz4abpzo+XejDNrjIw1
 y8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770417962; x=1771022762;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77aotkXHt4IJq2ZfSL+LWAxxh7s1p/STZp88kofeVpY=;
 b=pplmRxNOnliYo9Ip9xevsT9geNNv3AoYlPXgfSKjXet3Q+v2RRWi8Ipow4L7gUi9Oq
 CacYpvRs9Nv5CSclUY+FupWJhJVOTJrg+p6nsQdG6/6wMnXKyFJvsEbP/0h3GVLTcH4f
 mcZSTfbqgGGjF5yxvCKvahs72qR94DN0aofSXt2nDl5RS/c3F7izNq8zHAFodsOxt1Zt
 +AiK7bPUn/kXhmgCcUugyBtEPHstztanK5cW/c14MOJdNIQOrN/R4gEpdqrCxX4NgnN9
 JSn2VgOb5vxnBnh5wqOnCHEsMeP8i8ZpHY27ZMH/xiT75io2RSzRei/Ktev/omTzfexb
 phkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgpDMFUocx9sQ37grcfXkbB14pItcfGn0GUJdNchcTvUFdgzcCrTJuO3tKEE4iFtlOSbPpE+SG8BQA@nongnu.org
X-Gm-Message-State: AOJu0YxrufV/zKweV39tzo7mVNjm0XoXEeWuwnPeqm4/du24azEGDlA4
 R2bmDPUhLUzMHKiXXwy/2hLvN7HNlGOY2ridupIGhJ9Dh5gzLbr64eCbKt0iczy8suA=
X-Gm-Gg: AZuq6aKmeofwxsAez1rDGej5fkg3ubn/31k37Iz9dtj6Qblpq1TYsv11jO3++J7QaKk
 q+R+L5HY/W37aRYCP5oXAGMX74cPqsAqlEnpClM0aXo78fomRI/+a7KVwlW9PrNLvVHPkSZKcwB
 1xPTfilOBUHGqwDvz6dWkqOKwODr4I8KlwqQz+s+6h2Sk5DIuuhIPgxfo+5mrurvprsT3X3cs0L
 MLBbHjB4HPeRKpqzOhXjoIYg6C1aREx39yFwHsfpfmoaCHXx579mYGSAoM05uATdvCU8vv5CUk9
 LNnRshMifvHLNQ1fSun35lhlNaFedKfFWySLJhTpKeWnwY+dfJClGONlq3djTftCi/zo+29IvEo
 +36iHjyYwWX2upY9/EgfLz5AK0d8lSfvWfvXhY8ImLMeSgQ5c8X/h/EwENqr7vMM0vyaj0/gQSf
 mhmF0vy9KDmwuiwxcLAMGOmC+10lwILJNABZr/fYDT7Ry+fqQLZA+EJwTr
X-Received: by 2002:a17:90b:2c90:b0:354:7b96:1300 with SMTP id
 98e67ed59e1d1-354b3abd9e5mr3523653a91.0.1770417961630; 
 Fri, 06 Feb 2026 14:46:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244166fb78sm3260143b3a.9.2026.02.06.14.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 14:46:01 -0800 (PST)
Message-ID: <20cc5e51-c558-49dd-8ef6-d3f6c4d326b3@linaro.org>
Date: Fri, 6 Feb 2026 14:46:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hexagon: Reject duplex encodings with
 duplicate dest registers
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, alex@alexrp.com
References: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
 <20260206183813.2573541-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260206183813.2573541-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 2/6/26 10:38 AM, Brian Cain wrote:
> A duplex encoding like 0x00000000 decodes as two loads that both write r0.
> 
> Add a check in decode_insns() after both sub-instructions decode
> successfully to verify they don't write the same destination register.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2696
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/decode.c           | 12 ++++++++++++
>   tests/tcg/hexagon/invalid-dups.c  | 23 +++++++++++++++++++++++
>   tests/tcg/hexagon/Makefile.target |  6 ++++++
>   3 files changed, 41 insertions(+)
>   create mode 100644 tests/tcg/hexagon/invalid-dups.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

