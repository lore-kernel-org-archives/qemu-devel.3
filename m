Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8AAC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZfX-0007VM-7v; Fri, 23 Feb 2024 12:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZDd-0004yR-4O
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:20:17 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZDb-0000cy-7d
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:20:16 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3ddc13bbb3so96712866b.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708708813; x=1709313613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z8Jv9wGMl+ZWNGY1N6TGKa4oXViAPzD9FVBkL88AQXE=;
 b=jtXAMasRi+9zWsJNJTRV/Pvmf0g84QQKBI4M4tAJixw5OP0/ztCKCx2k7r8XogTBqA
 QxXT+ktkK0xm9Ui4fUa2UfU36kUHOKDZFdiKXznDULTG9IbHk8Okka196UmC8x0Mf6Gd
 mHDQLy7d2u0Iv3btqLf5P4/AuE+gsV57lx2oA5ZsaI7qGly6PIVbNgE3tpB6ebVdJfAn
 YVKZuCxdoMZ2qks+pAP17gau6GvU3uouXrsH8LEBpiV+zZt5sXrYufMJpBQ3BFyYUUy2
 puwduCmcU0/jt2IlXy4vHzHfPdNx6R1M/vZQ14tOWxEgWok0IDIVol/SouEZ2/MF5njV
 mPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708708813; x=1709313613;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8Jv9wGMl+ZWNGY1N6TGKa4oXViAPzD9FVBkL88AQXE=;
 b=aTxgu/M4CYu5qsauMSGoSfDF8ykcQhx8n4NKglcb9c8StX9DjzdEllgDGApcYhHtzP
 v90+cnT2YOMfMoFbX0/5czCWx7GQxGWH6HqUurXLyWUkrP14o0Gje6hn3db5qXbm7oKd
 CfrQ9kdFcJxgxzTkuL8yp6Io+5d/nDF1cIbFvhARC/CsnwhV8Yp0CJA+/Ovkh88zOG75
 cEp0kF2Y2T+sJoGUr12gh5QcMhLtOXBZ2ZV+3+sUZ32HHy4GiAIpSmxikwWGEsmiT0Cn
 ILPochSLD+KrrhtFypAzGkZpG8yt24BzVClkhxWzP9C7JEnmlYAq2Qjvzc78+mMMCzup
 oaKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoF0Ps1WZcokV0rYD3bli5np/JNWv0r7b6di8SsiakjcwJb1Zbrulq6WZI8+70ythWn1IJR0/IuVY5ho6DwPhxrQ+Edxs=
X-Gm-Message-State: AOJu0YzTg1e7o9bmM2B+mM6owvsEEko7fW1Yw3icfG+ZrjkfnuRkPVfV
 u4TvGUevtGalshA+iABwOwNhJHLUWsrUPolpti0x5HFEP4hXlYlsignZUXSVhiw=
X-Google-Smtp-Source: AGHT+IFZpk2XF3Fv3/lssJUhF5Nfn3AawizCtZ4BuLlg1Yul0AG2hf/oCppzfcLdB/eMg6vngoSbyA==
X-Received: by 2002:a17:906:718d:b0:a3f:8dea:85f7 with SMTP id
 h13-20020a170906718d00b00a3f8dea85f7mr373193ejk.15.1708708813037; 
 Fri, 23 Feb 2024 09:20:13 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 vh9-20020a170907d38900b00a3f1ea776a1sm3101721ejc.94.2024.02.23.09.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:20:12 -0800 (PST)
Message-ID: <b062cfa8-66c4-4e81-bbdb-be001014ac5c@linaro.org>
Date: Fri, 23 Feb 2024 18:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] mac_newworld: do not require CONFIG_USB
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-7-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223124406.234509-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 23/2/24 13:44, Paolo Bonzini wrote:
> With --without-default-devices it should not be required to have
> devices in the binary that are removed by -nodefaults.  It should be
> therefore possible to build a binary that does not include any USB
> host controller or any of the code guarded by CONFIG_USB.  While the
> simpler creation functions such as usb_create_simple can be inlined,
> this is not true of usb_bus_find().  Remove it, replacing it with a
> search of the single USB bus on the machine.
> 
> With this change, it is possible to change "select USB_OHCI_PCI" into
> an "imply" directive.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/ppc/mac_newworld.c | 7 +++----
>   hw/ppc/Kconfig        | 2 +-
>   2 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


