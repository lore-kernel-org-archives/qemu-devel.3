Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6086BE937F9
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 18:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBzX2-0000iT-Bo; Sun, 12 Apr 2026 14:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzX0-0000i9-K4
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:27:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzWz-00012H-50
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:27:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so46228005e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776018455; x=1776623255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Gy6uAiK7aQcX3R9bMX2lARw4Fnyee7kyt6fQhTNNVU=;
 b=IAFyB7rg2o4yH9S1TBs+Q4xXXCqd80ieVR5573KNcuzWnOONBrboN4HTjwFWeagTRK
 cLLY/PuemBiRDBfRyT6/Je12i05osQBBZxUy1vFOSIClPBJVJLWYjdElkHMbp1+DAj9D
 JuTr8yG/lhrKuqrXjPo4KnJL7HZXfqNLYKLR0xqOEhxy8VjlkPjffbDJormX+6GWynY2
 B0gKir4CgFq3hEyW7RyYcAz7wo/M+y42spUe6fRxqmnkdAsnl7AZXIVV+dAKyuTop0YN
 32dKbMUWFuwyn42+I1vAR07I685XJde81r6Xa/X/pDynCtiTsF/8TBC7W72q14EWbsNg
 iGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776018455; x=1776623255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Gy6uAiK7aQcX3R9bMX2lARw4Fnyee7kyt6fQhTNNVU=;
 b=h5qHamE+RHwBDGxK0yMYVc3wJXVfwM8zdELffICCOF8+/YePXXagZ4bd8mDtDQpVH+
 mtU1RzAzTX7123H+csjTyXlvkVuE7mqvDlkA38Wsgfva8y+hLAkkpyEvuHRu148RQIUb
 uYzjhqv3AxJogxG6016qFok7XF9ozO/CLSx3wzTkCUSXvfwWH2NbWH/QVmJ6Sfzdq9B5
 YEdioOc35YgzaqgsxMI0+cY0s3TDCPv1buoqNMxdLObzl4ziqXnLKiFfEvqOIGQbZPWR
 YCIm0OgSos7U3Om2WGmMbm4ZosjUyi9B9cU4BOghNAsGi/2yOxBj0JkgqLxKbGV9Qc7e
 2lsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUz0cSem9uIL72XxFLa73OFAhsUelAldK51F5CCkzK2g9eBoiIP7wYSWA1c2/I8OybrVSjho1TI/9d@nongnu.org
X-Gm-Message-State: AOJu0YygkkbgtpjJJz+BQFd1NyrRTIdajsWm/EL2VNKOTuNxn4na4KDC
 AItS3KZxR0U1OuqDAGH+16t4HBUmPBV7E9q12KBRH7xSGggeSXPuYwqFerWK8feLPvU=
X-Gm-Gg: AeBDieuYNYCgmcyGjHaIaCnietjYt5A943DOsMdLkILbfu++5kLpzEoXtrSI8HN9fkU
 gkk2kxSTq/wEM+sDWZXx+HBHdubHKsIwmgVlx3O6lmo4oLn7YwPvg9GwYVUhazGVvSqKUe+z8bF
 ffqOobFHUTC1HTVNxhi49qo8K7vAiLe43w8B7UFTUZtycNFtTFOC3B9UKM/3MQDe26ae2qJZHCc
 HO21Js8j0himFaBpW597xarpKSY8k5NiITwnTyZuCJu+gWLNmmY9hJp3/U2iWJkDX339TWIfWf5
 yMtFDwaMKHjNL5n3dJN/TlzyKuXQal1XA5uRXAV23x4fApLIy0WzmshHWobLevzmUn+2FWY3Kq0
 UZj9ukW/jM2wmRAiZPBFlpNzFYR1RAm9YkMfvevhtfcUSqeNTebBkfA5trHVL/8QmlexrJR+5jK
 fVdALBixdJDpCDyPcy8/LOK08EJ6760MNKPzOzCkrV364LUznku6EBw2lxBdsX9PT5T53NuuF71
 V8Y
X-Received: by 2002:a05:600c:5298:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-488d688687cmr153273445e9.26.1776018455025; 
 Sun, 12 Apr 2026 11:27:35 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5396293sm223575825e9.15.2026.04.12.11.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 11:27:34 -0700 (PDT)
Message-ID: <8ba10582-c041-4ed7-a077-8d524837a1ab@linaro.org>
Date: Sun, 12 Apr 2026 20:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/mips: add Octeon SMS4 crypto support
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
 <20260411070637.72421-5-james.hilliard1@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260411070637.72421-5-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 11/4/26 09:06, James Hilliard wrote:
> On Octeon, the SMS4 engine is exposed through selectors that alias the
> AES register bank. Add the missing selectors and model the shared
> RESULT, IV, and key state so the hardware interface matches the
> processor behaviour.
> 
> Use the in-tree SM4 tables to implement the block operation without
> adding a host crypto dependency.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   target/mips/cpu.h               |  18 +++++
>   target/mips/tcg/octeon_crypto.c | 114 ++++++++++++++++++++++++++++++++
>   target/mips/tcg/translate.c     |   8 +++
>   3 files changed, 140 insertions(+)

Tests welcome, otherwise patch LGTM.

