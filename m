Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E5CC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRYRQ-0006TK-9f; Wed, 10 Jul 2024 10:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRYRO-0006Pb-9d
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:37:06 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRYRM-0008Cp-BV
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:37:05 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c980b08b4bso4481610a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720622222; x=1721227022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KPjBhqTMQQz+zEW5BDmFbWOo9n0F1MrwOUwA8+Jpr6g=;
 b=vze2vlo9U+iTXnLH0w3Ici/vjKXoD1Nc+Io9Ci6z/zVmI4KkJD3+6TQ2j/ugr/xPbo
 /Qb8ROFl1DDt2QyLj0cl90KEHzn6fOF4ZRI6PFo7Nn5xNiSRl9UFYGwq4rpxfD5qOnEj
 gEXD5J+79gIbFsyoGkEAR2l5QMYekYXD7/Q2HR6gKJ57w0xr/qw2xTmek3SrUdO2Umiq
 +dxBRdktGdoBnKDAc7vzBcBkblzQeBTo7nLYzOLAbVzs0f55GpEVTwt0HZVcFuOxKjl8
 wsX5pd0/f6RutU9aFo9B7HZugVJ2Afqr01V+K1jgxuolrR0Q/nU+A5xAttg82tKmqWkY
 xQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622222; x=1721227022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KPjBhqTMQQz+zEW5BDmFbWOo9n0F1MrwOUwA8+Jpr6g=;
 b=QSh3zkjS/BHp7ZR6T/RE1k9XJBj3OkEQ62iI76l1evFs0FQsHq0HtJGeJ8L9TpsS1A
 W7viDjq/m4CgeXIEetQB/ot+biC2Q1kF1uKbOuAsZxmibDw9KrDAe4s+18N1LE++Tv9c
 AOlqaderkReDdsCnAgowO2mOXtkMz1637kY47t6EwteGzOccFjGUr/5gvd+xIVj+iAyh
 spK7uP4/6wDjzHbVoVYvrqeJhiuF/Pk/FNDgmAhgmFObvcbetOwVcrAt7z28MVQwZ+mv
 AFyf0qCDyZC9QvNmkFbeFtj9JpFvtolwBNUVyWeRmp9/1Cvtihw3+FY1S3GQV1J7YfXq
 rphg==
X-Gm-Message-State: AOJu0YxqHCtvUdnaDlzxt8PyCyruo6Qp4w8xlQZR7eFEdfLnABFrBRMU
 Xpey2u0NAqOWiAVcULOHJybhA9FqJMkLQW5FRxq57gDAx4ZISlx/6B/JdXY9n2E=
X-Google-Smtp-Source: AGHT+IFjx9GNWv+yEnsm84ZlfU0gpq7J1Z1SKA4pJ/tlrGPEaj3CqT3D2sULOmObJv/adFi2TgrMYg==
X-Received: by 2002:a17:90b:3a84:b0:2ca:7636:2214 with SMTP id
 98e67ed59e1d1-2ca763625e3mr1859187a91.4.1720622222226; 
 Wed, 10 Jul 2024 07:37:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99aabab9dsm11978185a91.57.2024.07.10.07.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 07:37:01 -0700 (PDT)
Message-ID: <7059ae89-1181-48ce-b828-0837f7a62c93@linaro.org>
Date: Wed, 10 Jul 2024 07:36:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] target/ppc: Hoist dcbz_size out of dcbz_common
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, max.chou@sifive.com
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-7-richard.henderson@linaro.org>
 <aedda59d-2a8f-94bd-246d-d32ee6cf19be@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <aedda59d-2a8f-94bd-246d-d32ee6cf19be@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 7/10/24 05:11, BALATON Zoltan wrote:
> On Tue, 9 Jul 2024, Richard Henderson wrote:
>> The 970 logic does not apply to dcbzep, which is an e500 insn.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> As all callers pass GETPC() to retaddr maybe that could be moved into dcbz_common() as i 
> had in my patch.

No, that would be incorrect usage of GETPC.
It *must* be used in the HELPER directly called from TCG.


r~

