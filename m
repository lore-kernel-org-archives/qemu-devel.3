Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B47C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40S0-0004LN-Ou; Mon, 06 May 2024 11:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s40Rw-0004KZ-Pq
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:40:20 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s40Rn-0005Nc-Ju
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:40:20 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2df83058d48so26149201fa.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715010010; x=1715614810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fj/V+8fwauN7RjTvGkzU4XDUsH0+fiTZ2T8Tp6TefJI=;
 b=Z0KT361GmKWYOwzweqeklkequKfDB14smFXhJJeLGTJrsjd7G7rFBp9V+peXRYvzyO
 D7D8LS8eiOSbG3Mb0qsBOCGgrmKIA/aUTnIAFJkPmWDN1NxKFOkyrPNyrtH7SPH81T15
 21tcpXGdUb3+UFUFOf0eMPTLInnKdKqsoJnoV4r2CwYF/sy0WXttFO98xBzPe5jjDvzB
 tIus4ZYeO1+b2JCixcy2Y0eXqm42fU4ZgzuV0N8ZCvw0pvjsVFjispVfCLe+cnobluOc
 erNkyYUS7eoYb6KtyUXkuJS4+4IFZxpGV2SZZ16nXYFQelvmrlz9zJVw0v67Y36dJrKY
 aSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715010010; x=1715614810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fj/V+8fwauN7RjTvGkzU4XDUsH0+fiTZ2T8Tp6TefJI=;
 b=LSr6H5UcbR2znFRyuFzZeDDEVYjYR9W0WTldsUjTumSAjfhj4Dp7vTcI7CC4ZTBBbI
 I8RWZbWLbeL7d9XtMpQSUN0tCHrRkBrRn6Or01KpJGvfyI2YlIn7C6bO97RIgGgEgK8d
 44R4YfGQtKIeLZf3pf+ohYxVhit3J3bz3kmF8imiYK5ihnC9s/lS3q4B2TV2Rwly93iU
 eIl1lPSoEqnozKUt8xHpdxQqqsbHWobWiAsCF0xlUcoX1jDgi74aRDXSqSmk1x9v8S+g
 k7r1lHrdS62aLwJr2V0sUw5VXtxdx8HydMU2mpt7JIq0LKoTgOOYeM381kVYE4sC9PED
 cbSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWWKryFujJ+5eilXXI0U2HAXrI2kXH+2WVQdhvnCfZlG2Cd8+tTiKqG47ZP4/fctRzTbnNnhK7WYatUO2AdT2u+apVy90=
X-Gm-Message-State: AOJu0Ywu4ZFN06uX6uK+5tSzEmQmJh2DdW6TZi1O/HJjshg6d1KmCstp
 nh0BvbU//Ap516+a/XF0NZPkG3+OLvgoVuN7PHEnsZbibaeKin6CZ2VbVhUyq4I=
X-Google-Smtp-Source: AGHT+IG6tNGsXTdXz4ywU79UnpVwHFi22ns4wz/A5uVv3VNP8U/uflZQCiTWsi/aeFKbNtdzaMphng==
X-Received: by 2002:a2e:b0fb:0:b0:2d8:9d8c:9533 with SMTP id
 h27-20020a2eb0fb000000b002d89d8c9533mr6303567ljl.53.1715010009658; 
 Mon, 06 May 2024 08:40:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a05600c1c0d00b0041be58cdf83sm16494026wms.4.2024.05.06.08.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 08:40:09 -0700 (PDT)
Message-ID: <491ac14a-2a02-4525-8846-4eb0e679eddd@linaro.org>
Date: Mon, 6 May 2024 17:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] qemu-sparc queue 20240506
To: Michael Tokarev <mjt@tls.msk.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
 <811528af-cddd-492b-8b7a-4e153932a1f2@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <811528af-cddd-492b-8b7a-4e153932a1f2@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/5/24 16:50, Michael Tokarev wrote:
> 06.05.2024 14:44, Mark Cave-Ayland wrote:
> 
>> Mark Cave-Ayland (1):
>>        hw/sparc64: set iommu_platform=on for virtio devices attached 
>> to the sun4u machine
>>
>> Richard Henderson (7):
>>        linux-user/sparc: Add more hwcap bits for sparc64
>>        target/sparc: Fix FEXPAND
>>        target/sparc: Fix FMUL8x16
>>        target/sparc: Fix FMUL8x16A{U,L}
>>        target/sparc: Fix FMULD8*X16
>>        target/sparc: Fix FPMERGE
>>        target/sparc: Split out do_ms16b
> 
> Should these "Fix" changes go to stable?

If the backport is clean, otherwise they fix a 17yo bug
so could just go in the next release IMHO.

>> Thomas Huth (4):
>>        target/sparc/cpu: Rename the CPU models with a "+" in their names
>>        target/sparc/cpu: Avoid spaces by default in the CPU names
>>        docs/system/target-sparc: Improve the Sparc documentation
>>        docs/about: Deprecate the old "UltraSparc" CPU names that 
>> contain a "+"
> Thanks,
> 
> /mjt


