Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4D1C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcVx-0006cZ-Aw; Tue, 02 Apr 2024 07:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcVo-0006Z1-SH
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:41:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcVl-0003aI-66
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:41:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41551639550so22314275e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712058063; x=1712662863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JVvFcxLkj8uqsss8uUOAepWIduuXZZ17RoMd7ZYlL10=;
 b=AxCrgHeTCy7uemZ4fTw3Zw3hE9xK24J857gdN69Legl71tH/sIf5yiZSfFx9Vgfn//
 akbGEwxtxFK8bwlVLgu1cQCpdvy2yOOrraz4PQA9PBpe6VTll0k0J8wbzvJra0gJk2wm
 tJpH6B+8VGRZvwBwpF3S/vUQM76L3QlwZrCnFBZJxJ51TlMQTu5Z+F8FJ3LR5Gtq36O8
 8iKTHF0SPLglxIBCuwiqFIKPPy8t8jGfDdjYQmqFOMbxDjVG2rU8cydcRnJRNY3hB7oe
 Bij+4jnif01mtSfcRoSu1IwnEgh9hA+3h7LuSZI1mcDzzbf7AYUp0UdCLI3r8E+sDIAq
 1SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712058063; x=1712662863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JVvFcxLkj8uqsss8uUOAepWIduuXZZ17RoMd7ZYlL10=;
 b=r3d84WvNJRBZktMdk59CyDDxCOLEximigG2EH0aVhaR5aUU0dkJzZk5XWNJIEkUk2V
 UV2gs9deQvuOW9M1qbZDGOawBZ9CnL/CQVYyrxBfmjGV+ZxugrPwd7Z93xVG3fbJSI1T
 A1Foze4TjlHVKvvHtm5/xum43WmHvul04ePLOnvzNUqZdS74GMW0njmQD7nRZD906GTn
 xhJFrpAVMDz9xN8BUfe5Hxj2khMaVO3H2RCr2MhSRTHQXwAGR9lnTmq9N9U4wsAl/onB
 3g3OO/mWhNCz8wotJWbDajTaYSevbfYUL1IRQiqn5+3SmuO/FN8AYyXLl4gXFTz0j2G0
 Gmhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFMm+AFWH85F62qBTdtORuVGyJI5b1ByOS+xRe1ciNz6IPfOp/aUyw3/xWO5Ln8A0aOpPMlp8/HObbViWgHVhjMxb2wtY=
X-Gm-Message-State: AOJu0Yw8Bksvr2swx5n62TXh77F+Heo9FFrIX3TxpgyC7EODwz08ChlZ
 rr2SyUf68gJKvajQibOF1DF7ug+4yXCRN1VKM8wBSf2fpDccqUBcXclLa49gUYjAImkQABUD45H
 4DJM=
X-Google-Smtp-Source: AGHT+IHlGMkh3C2xSO0DgVFjLHtnhCp8QC0U2r8GWFO6HR9we67d8twnizu1ERlx2pyd114NtvmSsA==
X-Received: by 2002:adf:e008:0:b0:341:cfd6:42af with SMTP id
 s8-20020adfe008000000b00341cfd642afmr9398865wrh.31.1712058062837; 
 Tue, 02 Apr 2024 04:41:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 bl37-20020adfe265000000b0033b87c2725csm13941613wrb.104.2024.04.02.04.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 04:41:01 -0700 (PDT)
Message-ID: <51e5bed1-8c65-4145-a2fd-d69255c8e962@linaro.org>
Date: Tue, 2 Apr 2024 13:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 1/4] vga: merge conditionals on shift control
 register
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
References: <20240402113408.18048-1-pbonzini@redhat.com>
 <20240402113408.18048-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240402113408.18048-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 2/4/24 13:34, Paolo Bonzini wrote:
> There are two sets of conditionals using the shift control bits: one to
> verify the palette and adjust disp_width, one to compute the "v" and
> "bits" variables.  Merge them into one, with the extra benefit that
> we now have the "bits" value available early and can use it to
> compute region_end.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/display/vga.c | 89 +++++++++++++++++++++++-------------------------
>   1 file changed, 42 insertions(+), 47 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


