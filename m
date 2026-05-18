Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D44CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmkK-000270-MI; Sun, 17 May 2026 21:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmkI-00026e-LW
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:26:14 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmkH-0004Cm-1Z
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:26:14 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3697c35eab7so642189a91.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779067571; x=1779672371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sLgtw4nCC6Ta6El2BWhyiRkX84Clbq7kWdbXQP4ga+Y=;
 b=kr0SRcfrAqXyV/SRh9SWBuzXSrQW24daUiDMFV6E3VUIEktFDP4Y2cc6qSktANXfyB
 yKCTtsa+0glsGIdI3TUYo2nPzuHmoG4B4oVjUtLcYUqNrHEREBa548su5OjIRLukt4tA
 F6avscAMS5BYpZi05lodOkIFHQM/Jyls4b00aAobJAMKEVJqPB0aYZSd29RSYL9g9I8K
 rxX0u08zch9RfWgdlUj6+iIRhsBd3RKJroYfKtOOQ3Ak4teQnx9xIXHjCw4XtOcwZKHY
 /w8S4GXnaVIyoSJDh8BVuGJVs0/s6/BEkIU6SRBEkLxVj5O7w8HpIrba8eeNuZpK5B9Q
 iphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779067571; x=1779672371;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sLgtw4nCC6Ta6El2BWhyiRkX84Clbq7kWdbXQP4ga+Y=;
 b=Q57DautwuJwrvwAbQnDKdk/hgYmdhlH3D/0uZJ0xTx8oUOUBlegAWVyhNSELHZoyFL
 hlqWIFYy8mWBgLJf46qATvV7E0SLhDijVTEVI0gXgxqnzcLw3gmTmaGtemprYawsrq83
 +e3w040pivHtE8yFRrggTePkbJCiCoWEJypTWV2DU4/4ATaLkCcr2k7ddnS3WeL2uocq
 hgPgZHT5xWQhvND0ggswxFNNgSB+TViAjUShW808gI3QUk5IGEHQqDlqIAxw91nLC4LY
 mexrVOp2lUbBlBsHk1hXE3tUhZg1CCjnConxZCf80h5j3zyd2+rm5QGsEHS7Qm6En1Hy
 Odjg==
X-Gm-Message-State: AOJu0YwH5Kkmtm0JBJ45b2UdMonzy1FkT+mCdSHfs6sv/1kZwGH99Icp
 fWJYHEXTOhmvxYPaTVkT1CkLDpSYeiVLFAG1TedkO6rMDzQEhFvCDPPVJGgcdAR4w6QZjsRY6RU
 i/isV
X-Gm-Gg: Acq92OHpa313bbyhlcdGppQ/d5iHeL5BahllamhJdIwAVZbQ9Y4HdNjr2CJXKZISyUG
 p1HzUv63ot9olv6ZW88lxbDvYwECIdror3AbAyfPf0iBSCI9X6GHUq9I2I65P+Sf9mRVMv+Rixb
 dZLs1RHeR5wG3pqkyW2UaMtgJFSXnYVSS0bZnsZBDIU7oQfKxvy17D4/wUwkf5vQFF2j1KefeEd
 TfM0LEmTj/39ZHDdjFUDSvTVGhqyBX9Kszk227oMQSXXdC9GgpVbxftCn4nnbghL+QFsUFTz4C1
 1P6y9PB0fz1BV0gzxi9Fl4a1rOKTSGklV0DRvCJWYzdolbFb9XdpLsZW2aMY8O5D1Ozmef8kY+T
 nec4czhDXiscQZ+HeRfB8ZImTRa2xjQEQ+bmPUx9SAwisd5xC4XROhcrjPsWlq/TtEj9dEsLo+N
 Q6dRXNVAIwYpXccv+K43tuECvpJ+denHHOQeV/
X-Received: by 2002:a17:90b:53cf:b0:366:16d1:6a25 with SMTP id
 98e67ed59e1d1-369518b206cmr13095491a91.5.1779067571235; 
 Sun, 17 May 2026 18:26:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369a37f34f5sm1536736a91.4.2026.05.17.18.26.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 18:26:10 -0700 (PDT)
Message-ID: <ee6ecc2c-ac50-49e8-b19b-8795f13d163a@linaro.org>
Date: Sun, 17 May 2026 18:26:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 27/35] target/mips: add Octeon COP2 crypto core support
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-27-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-27-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 5/14/26 10:37, James Hilliard wrote:
> Octeon processors expose their crypto engines through selector-driven
> DMFC2/DMTC2 accesses rather than architected standalone opcodes. Add the
> common COP2 state, selector decode, and helper plumbing for the base
> engine set.
> 
> This covers the hash, AES, CRC, GFM, 3DES, KASUMI, and SNOW3G engines
> and moves the implementation into octeon_crypto.c to keep the MIPS
> helper layer manageable.
> 
> Model the AES RESINP selector bank as writable as well as
> readable. Octeon COP2 engines use these slots as result-input staging
> registers, so the shared bank belongs with the base selector support.
> 
> Extend the TCG smoke test with AES key-register readback checks for the
> selector window introduced here.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - Fold the AES COP2 selector readback smoke coverage into this patch.
>    - Move Octeon COP2 decode plumbing into octeon_translate.c.
>      (suggested by Philippe Mathieu-Daudé)
>    - Use uint64_t/i64 helper types for Octeon COP2 state transfers.
>      (suggested by Philippe Mathieu-Daudé)
> 
> Changes v2 -> v3:
>    - Remove redundant MIPS64 checks from Octeon COP2 translation; the
>      opcode path is already restricted to TARGET_MIPS64 Octeon CPUs.
>      (suggested by Richard Henderson)
> 
> Changes v5 -> v6:
>    - Rename COP2 selector constants and comments to use RESINP/INP,
>      HSH_STARTSHA, and MF/MT direction suffixes from the hardware selector
>      naming.
>    - Rename COP2 crypto state fields and shared-window helpers to use
>      HSH_IV/HSH_DAT/HSH_IVW/HSH_DATW and GFM_RESINP hardware naming.
>    - Rename HSH register word-packing helpers from octeon_hash_* to
>      octeon_hsh_*.

This is not good.

(1) Split out the machine state change patch, like you did for multiply.

(2) Don't keep re-decoding these insns at different levels.
All of these should be decoded individually in octeon.decode, like so:

{
   [
     CVM_MF_KAS_KEY0  010010 00001 rt:5 0000 0000 1000 0000
     CVM_MF_KAS_KEY1  010010 00001 rt:5 0000 0000 1000 0001
     CVM_MF_KAS_KEY2  010010 00001 rt:5 0000 0000 1000 0010
     ...
   ]
   CP2_Undef          010010 ----- ----- -------- --------
}

Many of these insns are trivial data moves that do not require a helper.

(3) Split this into much smaller batches.


r~

