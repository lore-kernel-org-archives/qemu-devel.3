Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6649606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eeUgPQYt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT6QJ-0007tD-MW; Mon, 16 Nov 2026 18:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT6QE-0007ss-Mp
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:47:38 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT6QC-0002q9-Uh
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:47:38 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3b3a42a4bcdso480698a91.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794872854; x=1795477654; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=geae31w6Nn+SvnF21c05lr0SRkeyuUsbjSAMeyKAlKg=;
 b=eeUgPQYt+74PhEa9X2c4NqNAxVUc2/5Ra6ybZNhE/KhNz2M0NMnDM8Y5uHungq6cY0
 V1QNRCixsFsBXTVdNPToAvWE1qwhTzkrwnxrkaFW72lrvzwUGPUkfOgvH6nJURvH07qK
 n9ZN8zZcUDPucWqm8Nb707TqyjXA9t8aetWEyCRDJl1Qd51GzGGWWw7xIn1N2OtES4qT
 +fLWTXJtJqbDflqpv/0Jc74IwrWDufLx7gAJsL06cU9kvxJY0Vw0Dud7MlWm5Gsb6dER
 Zu1THr3SR9B+uSzyAf4rTnmobf3HoysWIi/pLtxwDHMmK1GbiEDhTUNqlROkP6nbFNBy
 AfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794872854; x=1795477654;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=geae31w6Nn+SvnF21c05lr0SRkeyuUsbjSAMeyKAlKg=;
 b=atHbbrJmK1IckYwjLzUUti98Sc0ctBDtA17Eg8CiY9XGm+lDiPmEQZE5MFBvh+FNGC
 jgZBcL4aGRfvETmsNNMIFqg/g3bx7h34fM4UMvRcJTFBzd5STkW41poMHftld17w4/6S
 Fl9fg5iMHuZGa6FnXqQJGP+89Ny9hWZE0ZP6FU8BYNUdjGch5la9txP/BELJAhICBrOH
 I+9bPD0vLGzpGX38lVxYVQmw3lHPJNnszDY4TTubPZi3zRW34kZqUJFXbOHxC20i6/uX
 fFb8RIhPLaBCait6LO/7vd0FPC7nPBEp2oSptiOlRucU51Jjr7nNRy0n5q4Aw4j+XE4m
 Q87g==
X-Forwarded-Encrypted: i=1;
 AL+hErHUPhuJYbC+Eul1BexUJ/BeI2IVURTS015qQDx/ifUiTSFC1M1Hxu0pDECamtRSp9iYwcXP2rLCoTo1@nongnu.org
X-Gm-Message-State: APuU4Z/sI9yKQuQlbTe24R0vE9Jscw6BzhFeBKvVE5ZrXLkUAgI+Wb3j
 gpzPb1DgRSVcbqLReQLT4V7SzCo/zgdSaW7J1G59MbamEqu2iiJzUC50Ttkbwe9pKiA=
X-Gm-Gg: AZFdTZeeWROAQgoftQT5xNW/CrVQmoZo+T9BKbdlvlRYjyoNpIIUmHit77lD9Kmsvns
 g08lEt4+jAmo6mufqhS4SOduwBMLjfzPircNlu0saUtL9awqvZkDkswBTAFoCDXu59oAHfszO2W
 ZesldEDel2EQrHu2IfIeUgeJuq8IaKNx+boGej7IqoG/VRSdnZAGtT/q4Z2GuN82bessCILj2wF
 RaToHLJrIZigFnb3z29cef83sbwxba/OUgeqS6NCwCinnmUnl+ol7Yh9QF1zInZAb/wcl5GUw7A
 KcT6QDWQkxYUcp7/9pXOOYfCF+R9xsYgDYzj0WovnpitKSF9P8oDdGgH2txYCvZ9FvXOUhnAGmn
 00uBT68UCV460G+G5bR8+CDz9kYuh/XpFk/D/ELAihYX5XlKevRG7ZrFAqqHIMdV/Reu4iaBVWJ
 2dZQAzjmEH40PKeT7y+z3ob3/sgX0uirsXk0kPpLyWqjvUn5vsUTiJn6eSVYIxCRfkGDReXdiM9
 Dfz//PZvo2U/jYbZXK8vmUQxaW5QCRGxUNa944cRPB/uTcCZKI07PBZPky3BukimIWec+KQwR0S
 QyWGrqHq5j5DL+MPiRpfrz3WbitH/GC8Rjg58E1ak4KwTDhBDuOBGn5FPzQjDtkPJoNH9E0=
X-Received: by 2002:a17:90b:4483:b0:3ab:413:49bc with SMTP id
 98e67ed59e1d1-3b1b0a4c331mr10795905a91.37.1794872854468; 
 Mon, 16 Nov 2026 15:47:34 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abbac776sm1191649a91.3.2026.11.16.15.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 15:47:34 -0800 (PST)
Message-ID: <3901913f-e91c-4f5c-933a-2011b29034d8@linaro.org>
Date: Mon, 16 Nov 2026 15:47:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] hw/nvme fixes
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20261116215014.59993-1-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261116215014.59993-1-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 13:50, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit 573577bff0138681ddd4ee2410c51bead7b53e74:
> 
>    Merge tag 'pull-target-arm-20261116' ofhttps://gitlab.com/pm215/qemu into staging (2026-11-16 12:09:43 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20261116
> 
> for you to fetch changes up to c0080f56036249df4a3f56e07e90cb0e56b3fd34:
> 
>    hw/nvme: fix broadcast fdp events handling (2026-11-16 22:41:27 +0100)
> 
> ----------------------------------------------------------------
> nvme queue

Applied, thanks.

r~

