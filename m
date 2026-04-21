Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B982F8FA71
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFAfv-0005Tz-PD; Tue, 21 Apr 2026 08:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFAft-0005TT-I2
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 08:57:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFAfs-00086y-0o
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 08:57:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso42632915e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776776274; x=1777381074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uKYE9cTzKeCDq31ckTpF96seOfS4DsreiNy1HtAudMU=;
 b=U76YEDXrjCWR2cM1Ouzakg6t8GwMK024J5TPY7OKn/j/4Hwct5MKOQxhW5ZKqPu/XG
 eq8zIBu4+oNmiiF2SzA1DNZvBPiJyU8VvE0KRdRRzqnBAQ8+taa5xOtoIbWsZntlQ3Rl
 Ci2hMiwyu2j7HlnI4nDgB4+VF5VrSeTEzKP9J3Ns9h/BZh+1zu3fgY3X2w51g1/kk3MT
 2giDTIc07/xzIhbm+AprfjGTuUfXCjfu1UfKVJlIwK/Qy8OQkyg+HixDUcryQQIaYJ6+
 NomuBMg08zUFuIjJe/eZ4kLTM/X1SEEqFAgWwART424k0YbvHuFkGP778ZE4daVQSbAC
 lK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776274; x=1777381074;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uKYE9cTzKeCDq31ckTpF96seOfS4DsreiNy1HtAudMU=;
 b=E3McqP7qfdw9O60g0jvqxq4VUitnwlhP8tHYYROY1oPQvJd6d+eBFN7K8jPvM28WUC
 sbvu7APhBTM98Q/DLLwJS9kFU9T2TzOFxKyS+KE6IT2Zw6D+Cd2jhhH7wBPstD2ShPsL
 5HyA1FVrNTsfvzoLB3KABYqkmgT8mSYvftoRgES87Qdl8R3JVW8l8egsb4BIeCxIbLvr
 Y8XGvSTJKzgv9mUtBJYkoGN7M87lgH/c7pgBplIU5IjcUeiGu32nVlc75++kYVflrZcq
 cRAd3yNPu1w3IN9aWwPxmrHoryiE1H0jHI4ttWHAgZYv64vOJmlQa4TVePDaRc3WvLXF
 75XA==
X-Forwarded-Encrypted: i=1;
 AFNElJ92DQ0GjbEFaUj4GU0vZRMLJ3hZYKmR3jSBXSHDJOL35PaOPDeyHMsQjZxmvZ84IpoBQYq95EY07EgF@nongnu.org
X-Gm-Message-State: AOJu0YzHTLobPXksKtl6FgOeBpbs8xrZll67a6JBwEdK3jeQ8sustEJg
 5WGcNpvCBs4qPhMDpqXj8lYjV5YS4AiChV/6gdTpKoF1Nnxe66hry8Dv1P3F1YRnYAMFpt0MGup
 BJMQkf/E=
X-Gm-Gg: AeBDiessW5jsdzDAvnMV5Lk0MTxXohqHW/PHvvKNFEGT7uYE9Z3UysUug7XcAWDdKJQ
 uDuNXPOXLfFpJSNRBem/jgg4zOaNCD6hVgbQf0Q3gemGWhXy+ZDxWzeUx9y4e1azjI9PwwNRTmj
 hsOH8bgxsJ3GUm+V4gsKTKDfUdxZqlDjaolVDEt/rexILzEG/VjAjUT9S3glo25i9+lTnToWMa6
 4aq8mSoVO79nQ0DRoh7xgxudjHVey6kiETB2rrfSbdUD588cJnpZ2UmvSDkKbb3CM7pSQgJ/ptI
 H/S4ACFECBNIjUpoJ0irj6TWY1t0Eb9Flk370U3Lv/7uAx3OKdWsnkQalCkMCxnQgDygkcyPYJT
 4Qf5IM5bDPC6DbAxfPzPC3LBJN5pb18HG+Fq6F0v03izmEX7uLMfmOfYI6NGqloZX+IeU9cvTo5
 PKIGCUrAIWrxLsFk4at3ig9mTWNVo2scVXQzy9T8Wg026qmRdVZf2Ph4fFmPQugnUevilVRHU7N
 Q==
X-Received: by 2002:a05:600c:1e09:b0:489:1f6b:6276 with SMTP id
 5b1f17b1804b1-4891f6b6464mr101396835e9.15.1776776274029; 
 Tue, 21 Apr 2026 05:57:54 -0700 (PDT)
Received: from [10.193.39.66] (140.170.88.92.rev.sfr.net. [92.88.170.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc09b1sm37767318f8f.9.2026.04.21.05.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 05:57:53 -0700 (PDT)
Message-ID: <cda93b76-dc00-4e53-8ccc-625cdcba3ec2@linaro.org>
Date: Tue, 21 Apr 2026 14:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/28] MAINTAINERS: Remove Bastian Koppelmann
Content-Language: en-US
To: Christoph.Seitz@infineon.com, qemu-devel@nongnu.org
References: <4b5c41ec7fa24117a88384bde27594c7@infineon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4b5c41ec7fa24117a88384bde27594c7@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Christoph,

On 20/4/26 23:43, Christoph.Seitz@infineon.com wrote:
> On 4/16/26 1:35 PM, Philippe Mathieu-Daudé wrote:
>> On 16/4/26 11:16, Peter Maydell wrote:
>>> Bastian Koppelmann has not posted to qemu-devel in some years and did not
>>> respond to a query about whether they still wished to be listed in
>>> our MAINTAINERS file.  Remove them, on the assumption that they are
>>> no longer active in QEMU.
>>>
>>> This makes the Tricore TCG CPUs orphan.
>>
>> Cc'ing TriCore users.
> 
> Dear Peter, Philippe,
> 
> I would join Parthiban in this effort, as I contributed some of the code to fork. I'm working regularly with TriCore devices.

Great, please post a new patch once Peter merge this one.

Regards,

Phil.

> 
> Best regards,
> Christoph Seitz


