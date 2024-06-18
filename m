Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1703EC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 23:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhxH-0006MO-Kx; Tue, 18 Jun 2024 19:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhxG-0006MC-75
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:09:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhxE-0004ko-Mq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:09:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f6f38b1ab0so45599445ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718752170; x=1719356970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Opy/LV3p4GQRrbSHtrvDjI1eJsA7CzjuRJDK1CBdQUc=;
 b=KE7BCNLyt5OipRjJwTOPGJg8oWPpIbjwIMMRg6igoZyyWZ5a66g6xwlN7nh/39646o
 Y/IxWbbtAagiHXUollCVsxaQ3bRDt9mo1E66E1+DnPuLN9kQZXr3y89ShbqRycnp/dTE
 2HK1vt+DvLHIxRWlp6nct3pdJzwVOvYWuzZCtkysJFv6ie2BQdubbdNb466AI/ZUS6Y+
 HkkqK/kPB+UODNVLkuMyl3+yBqz7qMG9m9zCji8MfVtn217Ofc27TxP/Allgi+BnwQNp
 rOs8wySyNNLjuDu2qPnM0dg0+YukO51Y95iYN8F63fbFeNWhvMdNJq9WgFmjUo7g5nHo
 Tpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718752170; x=1719356970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Opy/LV3p4GQRrbSHtrvDjI1eJsA7CzjuRJDK1CBdQUc=;
 b=KeqkdIlnLYW1R5ENHESST6qTwG3TwFcMUVWDa6J0exn2N86Q0G+UkTXWAdzcnB3W9Y
 RBMbkTwQl3IrM2pq84L5phP2/ja+npewwr1fnPErk6VWItlqwq/Nk1l0819YolPRp62A
 i4jpDQPYks5JRQuYow5sysYY1+nU+E9KcuoVUGiA7COXq3PkJyKuR++aXGfedmU1F5vF
 hJWZui1q8MvGgGU2vXwaMtxTUy8qXTcNiAGprmWDKVwr//GZB/MYBbiTMQb2FVpPhUxa
 K3kI1lyQQxs7qLhTnsF83pgLuqxhg4lV0l07u+ou1D81KU1CnwUjbCMNv/IA+SteyzXu
 1WEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZp1Rf/OyQC7As5IdcoQqBeT1Jf0C1zjBqnsKnRzaGWzYE1mNlVz2844120d1LDEgalKTd/1EtCME/v1s7x2HjLKdN1JA=
X-Gm-Message-State: AOJu0YyLdKbU4tDTjdwZzwBmNgNjryz4rNbzu3MswBDaEabGR+ZbVbwu
 f5D+QDzUOV31IGlKSejEFUwk7NVeyq7pP2RkVbwNNmfS222cOstysN56s7121+s=
X-Google-Smtp-Source: AGHT+IH+E0f1lZBtvclRbz8z96L/4JqL7zdbkmpwf1wDZkmoxau6W5H+0vKniQEaOynU/x3qCoPahw==
X-Received: by 2002:a17:902:ecc9:b0:1f6:dfbc:7f1c with SMTP id
 d9443c01a7336-1f9aa3f87bdmr11834345ad.35.1718752169964; 
 Tue, 18 Jun 2024 16:09:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f01768sm102784515ad.194.2024.06.18.16.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 16:09:29 -0700 (PDT)
Message-ID: <6991f177-7a7e-49f4-8406-50089afe6b32@linaro.org>
Date: Tue, 18 Jun 2024 16:09:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] gdbstub: move enums into separate header
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240612153508.1532940-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/12/24 08:35, Alex Bennée wrote:
> This is an experiment to further reduce the amount we throw into the
> exec headers. It might not be as useful as I initially thought because
> just under half of the users also need gdbserver_start().
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/exec/gdbstub.h    |  9 ---------
>   include/gdbstub/enums.h   | 21 +++++++++++++++++++++
>   accel/hvf/hvf-accel-ops.c |  2 +-
>   accel/kvm/kvm-all.c       |  2 +-
>   accel/tcg/tcg-accel-ops.c |  2 +-
>   gdbstub/user.c            |  1 +
>   monitor/hmp-cmds.c        |  3 ++-
>   system/vl.c               |  1 +
>   target/arm/hvf/hvf.c      |  2 +-
>   target/arm/hyp_gdbstub.c  |  2 +-
>   target/arm/kvm.c          |  2 +-
>   target/i386/kvm/kvm.c     |  2 +-
>   target/ppc/kvm.c          |  2 +-
>   target/s390x/kvm/kvm.c    |  2 +-
>   14 files changed, 34 insertions(+), 19 deletions(-)
>   create mode 100644 include/gdbstub/enums.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

