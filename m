Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32B2CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwBR-0005e2-Ar; Thu, 23 Oct 2025 10:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwBD-0005TP-6I
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:20:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwBB-0008OZ-4u
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:20:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so8972235e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229232; x=1761834032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B/3T3u3vrJFyOo7CzzG4W5+4fXOzcP+Ioy5uP4fNaUM=;
 b=lIrAWLocl02uVJD+Ahppkxc78QdE4oh/nA7YJlcQYyd32dhXU6Snmn1Olj/zwzM5iv
 99PTBo0Sg+kUOkglZkvzh4aYm1Bs+j9RHifxrX7A+jiZ1u0BA5KNtPJdCiPuc+3wTJH0
 XXkh0pe4VvUNa+poZ+A8DVHVloyvEr90gCjNe58eVbSNcM94fxPX1v8sso5qKT5V5I0b
 XdXWfdm6ALa8Mt49ATD6lJP2wybL80xWrjCJTIPa9SpHWskXRqGd0H9nSS6vXmHU12gA
 VA2NHLlygDDz+v5r3IrO/4Vm3UeTrp9aH2FbAJ2DyRVbyfwBoVSxc1KcFmAyMpMcP7MA
 R3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229232; x=1761834032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B/3T3u3vrJFyOo7CzzG4W5+4fXOzcP+Ioy5uP4fNaUM=;
 b=hafdeWWnToJoEr1Fg4QH0MY+muO4XQLn7y7V4nQDpNu1JZHIrzvoG2JX444D5sgAJS
 LZ0G/fp/uH/NASkHE2KBwVPIWNbbhaIAzWRsEKJTA66D6hcquq4xw+Y4c1j8vyQ8cxd+
 ZvmQwP/U1QgUC3Q7J1AziJdthZFtWLPtxqyXrZ6rK6CZiC6fTQW1WUWgpKa9z/1J8Ci3
 8x86fVcl4b4fBShNATQ6kR/yQi/RscAV1+Sy0Xp41QW31S0bGzbnUe+JcjdgzYDIck3W
 TuBTEn8Dn0/oIK163bnFv6rHnzdGjCpWYRDFweTWnG+3U9GsVoB2yJZ/Iwb3j6tWKWxk
 56fA==
X-Gm-Message-State: AOJu0YwYnqdljQQYPAhGh6H2iDRNNC4kokTrQr1SC9hJK+vbeLfGMdWU
 lbwCLYK8dbPKecuekLfrTyIrceoupL3FzHFCayTYj7hpNxddFZcJfeZ8ZiJCmNTPB6OW3U4hDdT
 j0YdACpU=
X-Gm-Gg: ASbGncsnY0pVfHYa/X5u8tlheQ6wkrKkUnaswoyx6TQ5L08f4CXYuaxgDf69LS9hFje
 C6WUvXMZ19ZkcRdMha4ssv4lJQbK22mYqOdC9++NyJF/CJ2XD0fMjGwF7CqLFZ7P4fLyx/k9zIm
 X6o3cfc89E6eErP6L/s9KWN1AbVfPtTXAsg6BS5/SntolMP7fqmdXublw/JDwHAF549eX3q4zRy
 Cz/ez0N/Z9MKrpqJLWQpoqaLpKpQO9t1IlR6ojQ4oXHEpC1SDhe8nYfGhKKaiJYuygBfpi2WKjj
 SYTyFFeYgWBTD6zAFPVf8WSJBn9Q4dYq3Dq9kgo+oHEUWATr+tmi6tDT78Cb3LYElOB7iKAGsHC
 sBXA9xIwlxWKEsTzcStJ7QHc11z7iBx5YjJVGJuBSeozvBmnegDV5UddApsVNBtLRz13UNJbiYI
 OiMlJC0OKLvnZ8af/xfbopwqyZ/BVnwl8GZXtvf/xeR9OSEaU8lnCB/Q==
X-Google-Smtp-Source: AGHT+IFVKfifpv4X1bolBhGXGl4Frw8eHmfkAEwn3uq8N11SwOdZmxBCMJoHOG35nH9ULUM9MjCe0A==
X-Received: by 2002:a05:600c:354a:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-47117903f24mr164119455e9.20.1761229232624; 
 Thu, 23 Oct 2025 07:20:32 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494b22536sm60875295e9.5.2025.10.23.07.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 07:20:31 -0700 (PDT)
Message-ID: <07851b4a-2b28-4daf-95a1-a747baa1bf14@linaro.org>
Date: Thu, 23 Oct 2025 16:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/58] accel/hvf: Drop hvf_slot and
 hvf_find_overlap_slot
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023115311.6944-11-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023115311.6944-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 23/10/25 13:52, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> These are now unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h  | 13 -------------
>   accel/hvf/hvf-accel-ops.c | 14 --------------
>   2 files changed, 27 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


