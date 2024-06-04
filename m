Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE510C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 01:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEIaY-0002uI-G6; Mon, 03 Jun 2024 21:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEIaT-0002u6-Cq
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 21:03:41 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEIaR-0001zC-Oh
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 21:03:41 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f12eda7c7fso2528098a34.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717463018; x=1718067818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=loueSisvW3AJs/KkMGbDRG6jAUTVL3hMxtj77+JfEec=;
 b=pjYXkY9SaV9Yi4H3Q8ayaL46HdrI8iIbJNrRoUVvb/oSz0LlMN774xuVxS3ZkB0aQE
 sr+ThJz+FPpTLHTqGh16VvIZYCFeBpNwIFFnpl/RrbuRrKmS8NSIgW4a3jBhG3NA4RSb
 9WiesG0iW46SZvlyzyaqUCj651c5aSHdRdBkMAMHbfXE7hfghVFU7ibO7XicxhMYEStR
 LEXR/oRP0cqwmyevf93Mk+BoOJ17ziUk/oXE78wU3T6rBSdnBrY7XntdtIo7vcC48wFC
 cooNGkoN7nzosyOKyxIGW3RdR+Bu1WFgRZXUUe3oWFgTQ/+YhA5iMP28aPcNBIpzt2CJ
 HC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717463018; x=1718067818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=loueSisvW3AJs/KkMGbDRG6jAUTVL3hMxtj77+JfEec=;
 b=raMi0Js9QUHCbKY8oBgbiame2M+XFIGVX3yUSwWo8tJlbb9dwBKnyE87wKP9a1TW+7
 IkgvTEOjz/aSj3eF2j1ZmLqOhS3skYn6BcCsgbknoUgg2YOzR/PP7fyfpBwoYWM46mnP
 qUJFwyFP/Ip8xn64YgOhwa26qO8imUMW3myP7peQ/+ZxSczLGJSZkHL3+0z7D5u+wWFW
 MyEe+MMl3XVVAS8ljXoHtUGffFFwOSKtnld7R2hx6Z9zxQKotW/OXfhyNzadNLvfjEfj
 URvaSjyTyYP6vrXjvS9bTlfue9T+3K7ZQIZEXDrL3tIJc0ReQvy5uk+F+ACzUiJfltgd
 jSHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5iU2zDC7CTdqUQ+PTwU0qyHXWxrkXbpYJpqyIh7xwNGi1xlkYk8kF00yAbgC/zmSDkmibJNbICwMpZ76Y8s3K9dOeI9o=
X-Gm-Message-State: AOJu0YyJdCMim+1eOO96KLh5Rhw84hH390teD89XVBMm0wstvCo3/n8b
 F00BfLtWXXQABlc01o1HG4tqLrlVLaPiVxB+9wlX8cPCHrqmGyJVrTMnC3zQrMdTbNp3n3sHxTx
 j
X-Google-Smtp-Source: AGHT+IHAgHVa0DVftObdUcjQRpztCH78Di24ZF+zivMEHYLaWGabJTa271jy8BBMZ9sh/SSiNyGCiA==
X-Received: by 2002:a05:6830:e15:b0:6f9:3b54:28ef with SMTP id
 46e09a7af769-6f93b5435bamr273881a34.25.1717463018226; 
 Mon, 03 Jun 2024 18:03:38 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff25947b0sm44492911cf.91.2024.06.03.18.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 18:03:37 -0700 (PDT)
Message-ID: <8305cf6e-01a0-4e65-99f9-286a7b42be7d@linaro.org>
Date: Mon, 3 Jun 2024 20:03:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpu_exec_halt: make method mandatory
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240603160933.1141717-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/3/24 11:09, Peter Maydell wrote:
> Peter Maydell (3):
>    target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to arm_cpu_exec_halt()
>    target: Set TCGCPUOps::cpu_exec_halt to target's has_work
>      implementation
>    accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

