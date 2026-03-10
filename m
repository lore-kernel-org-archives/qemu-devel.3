Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B50FD4F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 19:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w036S-0001Jm-Vu; Tue, 10 Mar 2026 15:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w036S-0001Im-1k
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:50:52 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w036P-00014R-2m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:50:51 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8cd830404c2so291275985a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773172247; x=1773777047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SXp7Aw7p+Rku6vw6OMciN1od2GKGBv5AEEe4yBuQU2Q=;
 b=klnOjbLRdoqhMlcf2b+TFNh9ZDNd98hGgoFMZ6Lf5Bw/g8UPQarwRnn9XSEu8It9W8
 16yQpIzC5iFttXvOzatVCkJIZdVQ5mvPmKrcyNKyzHmnohUt2WID7IdS7Rs5qrid5Ure
 jQ7F/jlgmp4MiHt948v/CJMlXxXEoUjFwXvVN76TBEjgAyZnKX32dhyuQ84Yv4OODPEJ
 Sgu/0MZGPvSnlCOpduv045qMSZL1453Pxk6Vu0VulPSJ/G8LkEColpqGwlr68XCQ3PIC
 jrZ2h/G3dUkO4AlfKaxZzc77LcFarq/P1JHA8VQ8rchoQPatKFjQxl/P5bq/P/B1wjp8
 hXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773172247; x=1773777047;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SXp7Aw7p+Rku6vw6OMciN1od2GKGBv5AEEe4yBuQU2Q=;
 b=bbEVxG0KSRIeZHTe6g7LSymuiwD9VSgpeVoo8QMGOSDrjKY/U9AzDGFC9ZimYehW5d
 3fvaSFqJRbuyZOzN/phEGImdGHAhQuoU/ZgJjsWFMWMVfz5D/hMctb533s7zS2OXNE1A
 ZvWf2R2N/U0fgl2fPZrkKYRNyDHX5Fbw6vxAObESoxqAh7+XOd28cTgwbu9HvnY6Unck
 ZjcfH7lh3GasL++vdtcWb819eTJPdywHp8mfqvJ25FgQCCkStp6nPZzZ3n22iWLpQUwf
 cwqdQ1Z1LvNJs9psnoTHX0RDoaDiIH6H90/kDdOY4r1E9Tuw7tTAdg/36BA49yrkT6oH
 S/YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6NoboJEgGm9OJP/hjnr4kQ38lvs4718f6HAGG9tlwZUAuCETJj/zSXe+hhpV3Tr2LPdWB2nwayLsp@nongnu.org
X-Gm-Message-State: AOJu0Yz2T5PgsDssF+mHUSLZQRMEFDRbiyeTBJtKivHfUdOI0Xp7RuEr
 2krVBVG/OzypAvHdwZcCQwYhF3fgmTB41pT435daqbACQoAl9nunTG44Kx0yUMsRAZ4=
X-Gm-Gg: ATEYQzx5IcAUUjmZrr4biGlUAPzVMPfzUMB6OzTMkQn81lSX/0JjZOVIAHVA+6+uGrt
 2dlLSWUbJySiKaM8xBnRFa1RYzJ+5NwWRtswqRCpzC7HHegEtvoTnM/SiDEd6XYihQsVoIu3TPB
 welij/Nm6SJ/Ol2GygCW8ef79XmBdN+XBEeGUZRtdd2smc77w7LGMvOV+p5yGohb3ktulFhnYbQ
 BQDiJDjj1Nci25WJBjhuWpyBWuqx6hRmYtaggJB6ugDvgfjzD9q8sbbGF9nrMq8ilhPawMDskw9
 fwWJCLFptA4mSApifqIloqcZmt5dHQgafRw8aEme2ycQsfVhJLvJrNjHNUs04qskhxyq5FMZF1Y
 HHbZPuxAKdwIfmw2Iz5xpJssWXLfauJjUuzWD4a9aLKf8mUtjMayK3MuWSkOx5mOBgzK4+jcjKH
 +raQFLWdGz+uUIfQXMFvRt1xYfzVRa5RrfYwM1J7+h2IMbxmlOGWgIcEMZaDpmvOo6mC1K
X-Received: by 2002:a05:620a:4489:b0:8cd:982d:410a with SMTP id
 af79cd13be357-8cda1a5137cmr16801385a.56.1773172247233; 
 Tue, 10 Mar 2026 12:50:47 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda12936bdsm21123485a.15.2026.03.10.12.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 12:50:46 -0700 (PDT)
Message-ID: <5bfcaaa7-1583-4775-bbb6-9ab9be29f1a5@linaro.org>
Date: Tue, 10 Mar 2026 12:50:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] gdbstub: Simplify gdb_init_cpu() logic
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Chao Liu <chao.liu.zevorn@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-ppc@nongnu.org
References: <20260310155329.48772-1-philmd@linaro.org>
 <20260310155329.48772-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260310155329.48772-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72e.google.com
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

On 3/10/26 8:53 AM, Philippe Mathieu-Daudé wrote:
> Ensure we either set gdb_num_core_regs or have a XML file.
> We shouldn't modify CPUClass content, so mark it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   gdbstub/gdbstub.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

