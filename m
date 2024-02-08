Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB7BC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 21:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBmP-0002jn-FD; Thu, 08 Feb 2024 16:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBmN-0002jB-Q9
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:17:55 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBmM-0005r3-DU
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:17:55 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d99c5f6bfeso10034845ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707427073; x=1708031873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sMqayHFgeTmFTK6rscFoPhRtTuGguPDYOGnk0TtlTFI=;
 b=PSCjJiltmNV+yQ62TkKex7q9mreLzR/MWzLIEXNB8Wy8sk64XQx5Vq2KIcS6pp4ZfF
 mdg2Zqhd7Xcu8XdNU2+n9hmUO2E/r3yw4Ev+8/oh+cYQRbSTNMt7GuajjddNGf0j8Iap
 ks6D0t0tyZbgsiimRsLyih+2awqdxypauu+ODkHk0DEUgnn5OfQK8XNEznTamxED28aO
 Nf4AkSpGwiyg4wQKVriQH+G0zZUaL/CimcfHpxDEONXWYhMexPRFeXDzhER0G6jRXlTv
 1/ysrZkv+t82I97Swq95rLfApxIWFrbojndTxKGOHyH6fobDhIHAlj6LIi9f5VAqur+l
 hB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707427073; x=1708031873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sMqayHFgeTmFTK6rscFoPhRtTuGguPDYOGnk0TtlTFI=;
 b=jds6oSKhCo8XufmMUDGAf00UyHh4A19pi4romnC+cadf9XBol2UGtzBKB2A5FwD4UL
 0sALImrwSAQLmIDS5YFd6OowJ98ez4cTXXKiu7jNRWFBEn/Las5bU5bfLer15PZiH2fe
 qfmTPULBvka57A/FIOx7KTqSLFse9/p4Lx/EGa8YIqCH1TEData/u8iF//LmFGRpwUT5
 PiBx3NIuIpKGQM4zn2OULZUgART7pXvY9IYpsIq1399oC64vXpsNSo85ON+g8Ov7N637
 BI4VcJW2wgUuoxlPAlz3vycHhWyTBE/YgNF06heB6OapOXT/11RHbNdK52Nn8svdO15p
 yNTg==
X-Gm-Message-State: AOJu0YzTkCt/NlxsMCU5H5F3iMzJX53+JryklBKyd423UcJv1pn8SXV+
 MtuCoMsd3g13ehN8k7q6nj0lguDTp9Q0U1qbXnW09tJezZEg+bR5iBJA4go8bJFx/50qCMbo2G1
 S
X-Google-Smtp-Source: AGHT+IHwt3lYq52H49gSLNnKfMQHsbuUubtkw2gM/4oxi+2fFjS+ZMAELzVRK/wfiaSQEjdIjeRfpg==
X-Received: by 2002:a17:90a:b395:b0:28f:fa9d:ebdf with SMTP id
 e21-20020a17090ab39500b0028ffa9debdfmr6167747pjr.3.1707427072816; 
 Thu, 08 Feb 2024 13:17:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU2XRf+qxFFlg8psNHp09GOKVLFWWO4CLdsMRydJH3Xv/El91T6jQAmK8xZqKWwkHU8nxuodJ+HrPxnymBSUxJQgBjdGYs=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 q13-20020a170902c74d00b001d8d04a4fa8sm198458plq.300.2024.02.08.13.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 13:17:52 -0800 (PST)
Message-ID: <2eb7afd6-af71-45df-bcf8-5c514f58b473@linaro.org>
Date: Thu, 8 Feb 2024 11:17:49 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/hppa: PDC_BTLB_INFO uses 32-bit ints
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-12-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-12-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/7/24 08:20, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The BTLB helper function stores the BTLB info (four 32-bit ints) into
> the memory of the guest. They are only available when emulating a 32-bit
> CPU in the guest, so use "uint32_t" instead of "target_ulong" here.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

