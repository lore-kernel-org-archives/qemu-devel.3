Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB65606A332
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zVkAmzWM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOXE-0008QC-IE; Tue, 17 Nov 2026 14:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOXC-0008PQ-Bl
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:08:02 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOXA-00056S-Rf
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:08:02 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so173752a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794942478; x=1795547278; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CdCQzjUznTnLVlxutFVOXin6EKbzjCxkzZyS+FeIge4=;
 b=zVkAmzWM6UqQNKyi3rAY5M7lpWLvwIan4bxL6nsvK1/dlopDrKqDrymJ4U3FrK9M+l
 HZZ5/iGdkXm0weiJi/iu5NSiWPuYkSypU3jB1XDtpfcYCdrR1kfcqA4Tv4JoSwrYYegx
 q+GoZdyrjZqsK1vqHQ1CHebfUPcw5mZoycoF0bwmru5AxGWwmkdW1iZCYaJfdy4TDlz5
 qrtgWngRzgciEn7Q7zK5GSW0Kaso32nLfmb56Rol+F8Ko7QS+oxZBhjZlQUN5ZgdEKlp
 BwZDr9b1Rck7Pzb0/gthTKf8FYcRrtHD3qKXueyWBg2iJ/o9F1KoK0FvkgtrzEny5sJQ
 dT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942478; x=1795547278;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CdCQzjUznTnLVlxutFVOXin6EKbzjCxkzZyS+FeIge4=;
 b=EduWqRQamQp9pq7JClV1D5m73SM/HoewLCmaDNWDmclL5tfsjUCaXEHRgzDZnZxYzW
 o586TdxdtS4Dxn4nKw1OImOv4Pg/jvnro+FejXV0xaIgJ2zkYSOS3NKhCTkl4k2qN7gu
 v07DPLngcfiwbw5ThAYTK+UrOjiRelqY8xoocEWI2ist4zpgEHbU5cf0uMeUXwksPdVb
 flYCC4z7UB+uPaYOvkTDWaHGompDc6aYjxttwdkE/ovK47eO38MB14bYOU6xjSin6J1w
 pwaWV+370j3/Y+WTd4DTK8BQzxeuuY0hwNnsO1u5U1/TQygmPr7UpYPurVr7ulPpNl4U
 GeVg==
X-Forwarded-Encrypted: i=1;
 AL+hErHNDcRtjyjbWg95KdYr1SWC4nlpXKz5sg/rq1K1Qv2BfQLe1JQ/Aq6GXEgQ4sAn8DiYVB3U0rAikHQy@nongnu.org
X-Gm-Message-State: APuU4Z+mcLQrkCADdCBGxDGKoP0efsvHkExz8v+oeQAHSxDEZwVECRr8
 xpaeuaYy0+t0XT2eOk28uxmXp7PqwXSjEYmY1lltoo66izS0i9EKPR0KLeBKtcy5CjE=
X-Gm-Gg: AZFdTZeGBbrv15aUEYgMXCLeq56nfU/McNje22vZqs8mvgcZsrL/pGFIOGjEGZOlBk7
 F3Ir05fi2HxSDtzcgW1cnp8EmiL9j57LEOUeywAYA2qBd8gd2rK6D7LJYvwUbYdZ5chMKwb91rU
 wQm/JRZGAhzw0hgcYL3EEYK0ZwyvBDo/znZ6HSbD2N/D/kCrYmCYACb5233Zsh4awD/s8IG0ulo
 TL4eFu7wII8JHZNkEZng42n/+1CRuylcYxIwxqWfYuTDp4mDuCSllaKlwUz2nYEK8sg0IcdB5Wk
 NCMqdiDUzzs0cFiCPbLHC1UjtP/266I1WHwlweJdMOV5ZsvNXCKkfM8nQnW12Gb/swkiQkXlWjk
 AEVPWLgnbmHtEzRPvhNAj0MHRM1HSAzdRrdc+4hzSqCwjZFGnHPL1XPVOo1v140qsYW+qb1z6dI
 LMTL7qPXHuCd48z0ETh7svUD1ee1c6nXIVCM+TH5uM0QDXd6nycb7Bn2q99kqy4rFOTWfVz53GQ
 sOapYFiG2cW6upOdDANSW6Fw6VyqYNRUOsZMVkrT7apgxhw2O0s/9d8xhoan9Ds5xnpq04FCYec
 Q4QRSTopmDBeqkkTnc2dFp+ly5lSxVVtLKjdGQVd6qSR56HPpwj1ihX0q8NQqedf2uPXBiA=
X-Received: by 2002:a17:90b:4a8f:b0:3b3:b425:fe4e with SMTP id
 98e67ed59e1d1-3b3d07e0f97mr282259a91.55.1794942478102; 
 Tue, 17 Nov 2026 11:07:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac2550e1sm5257476a91.3.2026.11.17.11.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:07:57 -0800 (PST)
Message-ID: <e0caa12e-a62a-47e7-8e93-cd0f53da6789@linaro.org>
Date: Tue, 17 Nov 2026 11:07:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] target/mips: Fix microMIPS BC2NEZC POOL32I minor
 opcode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-8-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> BC2NEZC is POOL32I minor opcode 0x0b (bits 25:21 = 01011);
> 0x0a is BC2EQZC. See MD00582 rev 6.04 p. 131 and MD00594
> rev 6.04 p. 145.
> 
> Both constants are unreferenced, so there is no functional change.
> 
> Fixes: 3a1f426828cd ("target-mips: add microMIPS32 R6 opcode enum")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/micromips_translate.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

