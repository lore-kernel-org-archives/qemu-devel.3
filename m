Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163F7E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUugY-0001lt-Sw; Mon, 06 Jan 2025 16:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUugT-0001la-BS
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:30:53 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUugR-00043n-Q7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:30:48 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so153516775e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736199046; x=1736803846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z1cXzymWgTDYO6B48cL7AqBy9VWPWIvwVHlv5YtqJUM=;
 b=kBADqjgs8oR5cv37L9pxWgf68t2jmt2Sb0b5moUvP2M8B7nHe2kRcsaveE5Av7dbyx
 yS65B2TwdYHgO8Gsf4LgHcKkvcvLaJVQNSHSk+yAg7eyQHW1gCYOwVZhtbAsWMoxgaUt
 RWM3xkshLtQO6JoSt73SrOF0GCLdomLRxnHG1yvgO54LUBdIB7MFQ07JQNUbPg5Bjbth
 yC58O6hXyhlHH/fARypKNl9cl8ypTxMOd0IzPh+FtRxv/SNrfxhw7FSc1Qj7U0nqg24O
 0VFLw//zfeKxhdEhDtPKiI3XHOJ6KzVnrOZ4eRKix56oumvpfOIedpOPPoQoPFJRVZo1
 BeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199046; x=1736803846;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1cXzymWgTDYO6B48cL7AqBy9VWPWIvwVHlv5YtqJUM=;
 b=jIw9/+DL4ZaDFO6d4EK2DMudakrf39rCi2mzyXPIHwnqGWOR3SMz9DzzF+4Gd7Y5rJ
 prtMN1AiBDwu+PUV7ESoqgo5WatocngsYNdP3n0X96Rf+z/7PlgdriicueElOBHZBDvs
 qpSkKKxtpviLWRtErZNp/eZrG78y2nP4Nzg9+atQ6Bxg7wB+Ya4TSG4l66UWuBSUOkfS
 O+TVl7MCrh5MtXoAQMjAfDl3qV3YdowQkJL+PeRB7xGQDV7y+LhOV1mi64lv38/BSX3o
 jSJfFsFrF331RKGvwLqXsjihFSUWnuxumg0ylg9IGpNe+slBI6jpgWEGO3q3rqoC9UhC
 gxHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4tkHV+IlMVmnj8/hpcwFzUX5gAJvagydXcih85M3oqFW9B4y6Gl/HxfBDkhRLewzSZogMxSEMRSyG@nongnu.org
X-Gm-Message-State: AOJu0YxzZatdL5hW5QQnyv3u3H+TmLl/WEiD+Ok286NFQXNaUROQZqa1
 InT7mTHluS2whV9FOpMDuLKW5kab+ge1UkDs0/1lrafXqvt96DSpFQr2IAcGXeuDC9B5tdxGJzL
 mNZM=
X-Gm-Gg: ASbGncvOXbe5pYa5UUMVh97jUFZokDhXdtRe5/vOWCXc1Mo5aWQ2im91FdCeOvDUCl5
 LtaTHhdgeSs8jlb8AP5nZRvz3inaBiHUJ/bcI7zwDbBdtFs/Hgx8vnzfija5RtMkitNSMx+5jf2
 BGcHZMXmKOH0pgUBxNaMDQXPsjY0lC3hJaB5QSWRIkj0xkuiZsP3wlTrQOjAOEiyx4fNL/NIuSY
 ZS/VqxMp1EMVAcT1oMB/wcle61vTrTIVkrzlBmJKXTYvQigJkcgxURSmuibC0AR9BHkujE3nwEt
 1DB8K8K0QIP/qIQwMH3I3ICW
X-Google-Smtp-Source: AGHT+IH6xlqIEfwX9AaFBHaXrUX1+7WkR0Bg6ZZC6wxzEPnND0XvASKkXUbgwrUF03VunDZE5EPrgA==
X-Received: by 2002:a05:600c:35cb:b0:436:1baa:de1c with SMTP id
 5b1f17b1804b1-4366854c186mr503947235e9.13.1736199045826; 
 Mon, 06 Jan 2025 13:30:45 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e3d9sm47888967f8f.67.2025.01.06.13.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:30:45 -0800 (PST)
Message-ID: <cf144a31-c5d8-4191-bb6f-ec79415cddea@linaro.org>
Date: Mon, 6 Jan 2025 22:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/73] target/i386: Use tcg_op_deposit_valid
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> Avoid direct usage of TCG_TARGET_deposit_*_valid.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


