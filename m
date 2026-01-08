Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021B0D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxd1-0001gd-3F; Thu, 08 Jan 2026 16:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxcz-0001ey-Kj
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:33:09 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxcx-0000y7-UA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:33:09 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso27202435ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767907986; x=1768512786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7yIhuNCRfTTJKoP/wxcKYGCTz9912mWOr1J1wvvXss=;
 b=bMEi7Es9Iss18FmC6/2WY9Satly5Zs/W+HAUxac28NsTRcyDdpz8uMN+u8BjVRZv8M
 XfutR4lmikBviGFL0EjpqLWjIRq1LGNth/dar14LaSAoqLRsk42uUu/4pRz6wVyd0B7r
 ELJvwgRCulJjBJFRXEAp4pumMBQR2xSJ0goD8+fCxlgfkjU+sAl/V3mJSdwOO4mjGR4S
 ouHzrCGtFxro2GjRWN0Ula+4+bGOd6zrRnCXlNflFgW3NNUZIoK+XpJgPUqFCsWOF7se
 eOUbhmvjcmHfdNzjYaLN+hJARmQL8vvv0Xm4mAelmIw4duytsYFBsJQTglVdewjMRZxI
 T3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767907986; x=1768512786;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7yIhuNCRfTTJKoP/wxcKYGCTz9912mWOr1J1wvvXss=;
 b=SkawTqH0dRO0y3Ra4o0fYcbu9vcHoAlZiyYXN8742vXKRgG+yPc4ncuI1wDis24//q
 QJOD2LYmne9CY9MjnGKIW3/gJP0/ZOroceIEdrm2ser/xYiwKC1TJ8bIRIe6f9fujTxv
 ryJRm1CVwOFafrFeYfkLjapgWzMQk9qh9IERQP5y4J4lLJAEys2G4rYGwzzb92ZlLN9o
 iA/05jeTYF3ru44X22yecb34AFkn0sJaPuhrTIR0lXRF/wShL8ZtA2g4yZ7AvpvFlPy0
 JCpzZ2Dm8zikcAf6cwTM/50WxtRK0uFZVjPz+87s8/Cio123Y6sTh4f7ucrf84zwOG2F
 xTlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9YqCXSZo5YWCiWY6AGC4PoSr+/RKMzZz4Q2ZYt/ZgPJ6V4y3wHzy+qdB0ldes7VmWe6JpyTIKaF/z@nongnu.org
X-Gm-Message-State: AOJu0Yxu2pBfsAcd2yeb9723z2EFED3IXJKdO6hWZ8N67vW6UjSCypMu
 wpPtwylayNfldp4pMPQ9qafk3J9lNB173dOIMB9VFaV8DbbecEdHAumcG668LwS/pfk=
X-Gm-Gg: AY/fxX5xao7DJet8Wm1tDPQ0FElFlFORu21J5sN1AzwWHgkT2laFLT5VdemuwfS3Xm6
 gkKhcZ9EWi4yAUNMZEWlMp7Ki4Vu8TPzqvdlhwFTDal1gkBudGFSRAdQnGvrwUojA1Fu2eBxjNt
 nlXGX/tLwearqqpOWxrOwZRYp7xaUi1u1MpzqkcURZUydIUpF5hymXGUW9GTo8ZhDMDE0j2Ym39
 nyDjesWkYuvmd7/tX+SSxeFyOSG6WTe3/GkZXBOSditnFJkL+lMndBYZxrfYMM3/nDT4qelZqXC
 TlEGMToMEmZADwQ/XCeK2Dw6gTku3xF0c4CybIuPOmMIrpJV9Q+6pAdGRRUQ72vTOtnZOzwqb2b
 1a83xAaf7jsGGXk6c98xy2gl0EzMF3LT20hIPmeZPxe3gtZct/l1AOevDriSZuWy2R6iLkBCFAH
 pl5kBBIcXyPcMpVZQgxa+N86nUi9gmRlhozpyXQ7kwpnXwT978G8VC1tyt
X-Google-Smtp-Source: AGHT+IGIQkzDgrsTFbNneMtNb0PJiQrLOUagIEsyLic0/fVl7s1LND1tGHKQktP/hbynMW5rM+PuoQ==
X-Received: by 2002:a17:902:db11:b0:2a3:bf5f:926b with SMTP id
 d9443c01a7336-2a3ee4c2efbmr80372545ad.47.1767907985985; 
 Thu, 08 Jan 2026 13:33:05 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a464sm85984685ad.2.2026.01.08.13.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:33:05 -0800 (PST)
Message-ID: <0c296692-0956-4f73-b65f-cff6d765ec27@linaro.org>
Date: Thu, 8 Jan 2026 13:33:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/50] accel/tcg: Drop CONFIG_ATOMIC64 checks from
 ldst_atomicicy.c.inc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-38-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> CONFIG_ATOMIC64 is a configuration knob for 32-bit hosts.
> 
> This allows removal of functions like load_atomic8_or_exit
> and simplification of load_atom_extract_al8_or_exit to
> load_atom_extract_al8.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c             |  35 +-------
>   accel/tcg/ldst_atomicity.c.inc | 149 +++++----------------------------
>   2 files changed, 24 insertions(+), 160 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

