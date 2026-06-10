Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D485ECD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXMhi-0001mg-8X; Wed, 10 Jun 2026 13:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMhc-0001mL-PB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:26:58 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMhb-0006gv-8T
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:26:56 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c85822059d8so4437249a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781112413; x=1781717213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nUDp1ELpmNlq/M5/dXqa9FQ9Wb8rTWgL3jlqAcWUsKQ=;
 b=idfhj/anHwChEPSz6mxq6LeRTFwwiD+BTt9Juey3V6nNyBiTsLER3vgRgfEpkvvMO0
 ZoGMs9TxsF9hVNTycqTg2l/qqLHTuZGoYyakH4Er+x6idenzUQXzTvzYlxArzatJeElR
 khNOcTWy68C5eggdaEgQVARTlsTxuP7730VtViMIxpgL5lCgrHoFUYnaVx5GqgTcVeEe
 /XuG27PegHzRc3IxmrsLSYKd2FKrlTSoF6ZMqVNuMlr8aqgXGgRWIaTABIZ7Sxl5I43E
 bDbOJKEUHDsVGk+toFHqhldVUwjhYtBJej3Gl0vBbQj9P4WX/wHRbH4rGygOfz7bTz6Q
 xgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781112413; x=1781717213;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nUDp1ELpmNlq/M5/dXqa9FQ9Wb8rTWgL3jlqAcWUsKQ=;
 b=N2XlckkJLdjfJHL4y8dFlWPefY/0Du5mbrxRN/CN9vCugdFUo6GmpZ9mLjiLLmTRll
 mIbgaAJkBu/tZ+BOINjkMuJDKIHwJAo24snJT4dxwU2psm4l+e6jZWojUOsRhExmfkli
 4i7xlSDuLbc2K66JoDLV2tckyggzMGrQrCHX2FMg6uJbKVNnLTcvIbE4i8Ogxipyftnh
 eA5m8ikCc2bMcAsgoegDAMCbPyh00xF2xNFPSxvFwNA0YNPySb+mQf9S1nf+WyQV6Jyn
 Bw+vkIrwOOdHp7LTm1a/KjYt4PkbQ1JeAvd589Y1PPijEBMKqtwYe2XUwp8wLiKv+5vz
 vhqA==
X-Gm-Message-State: AOJu0YzDycNdXoAtnQ/MV1FLe4ylK8v5kgAfRCk+kTzee36iIUc+T2ZX
 pNwZEOBs24RsX7xrQWTi54S88o7jiW4/+mYq/0+iufPkxLUBMCVOE3biQGmxNU/P/sM=
X-Gm-Gg: Acq92OFaB+X5IzTA5tCEyP1dlklP6RIYADm5j+Jx0iDOjS2mU5suA2UDNQNHcl4sBiK
 GQ7JcuBypbj3yslFxcWX3GkgYJNwUjlScrhfbvn9vGoAnfrnBpO4LTWWx4sC/j3fGV773F/5OK5
 IX/j1rWHFHBatOVv8b8vjmLVPLadnwQ9fCn+47O4xie9VHo69H3Am2XlBk9ejP8Y9vbz6P3ZbKB
 DR/lYxRCX/9QTlG9j62nJ4uAp21Z1t3H8WZ88wwwTsa9b5DL8LFYyZbyFXdOgtdaGtrNOQG+O1/
 IcEnlBzrdFSbSAz4urqkz4mfn4bUbeFWgDWPgRAKkmuWbSLzaX821xhRNYChxRNBFr5gtn4ijum
 GqjFyBp6Ech/lpozsUb5t/e/Vep0bT8GMMegFS+JSSZyWT3LwkrLT/iD1g2BEf8DOfcBcZ2iynp
 PYFDMhSCPmV4UgeOiIUrb5DPiRvZDPmHBo0lbhhZ27Qw9syVo=
X-Received: by 2002:a05:6a00:1304:b0:82f:7b98:e499 with SMTP id
 d2e1a72fcca58-842b0eb51e3mr26239451b3a.31.1781112412319; 
 Wed, 10 Jun 2026 10:26:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828821ddsm25281302b3a.35.2026.06.10.10.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 10:26:51 -0700 (PDT)
Message-ID: <6b2f9c83-2f2a-4886-80d4-f6396487719f@linaro.org>
Date: Wed, 10 Jun 2026 10:26:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/arm: trigger timer recalc on SCR:ECVEN change
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260609140008.3206970-1-alex.bennee@linaro.org>
 <20260609140008.3206970-4-alex.bennee@linaro.org>
 <7914fe09-fdb4-4f5b-a283-aa364d0c4525@linaro.org>
 <87wlw6ftax.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87wlw6ftax.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 6/10/26 05:56, Alex Bennée wrote:
> Not many of the references to cp15.scr_el3 seem to have those checks
> (although I guess that may be inferred from higher up the call chain).

It depends on the sense of the test.  Some of the bits are 1 to disable, others are 1 to 
enable.  The disable sense bits don't need the feature test.

> I can add a arm_feature(env, ARM_FEATURE_EL3) in front...

Yes please.


r~

