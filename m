Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C79C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 06:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFVa-0007hD-OL; Mon, 15 Jul 2024 02:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTFVY-0007gW-LZ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 02:48:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTFVX-0003ew-0Q
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 02:48:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso24489705e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 23:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721026098; x=1721630898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ejM0fchB/+7b5+8oaXsShCr6BuLuqd5/JmcZT6oPNn8=;
 b=Eq4UntjAtSgTskRx1h3nNFuC58CziJt+H5So2KmUowFM7xmz5dxpKzqYQC3cxR60oI
 JBVRRD8peuBm8vyrt5Dt1rOBUHgqi0LD8tIX34VBr2eDpNN/ytaGwzfcvSJa9B2EJBXA
 AihLseIldgH4LRd8tB5fOdXkHnwbaNmoHhrbHUJfs5TiNKUVo0Uo1bbGwkrijjwrfmwh
 elw/gicVXQNrDueoebE8IaCvqjGTTW1cnFiLjZOPAhKC6nkmtBYNHgroWtkFJGLvzkFN
 bQ6zGyA7HOR8pjJG1dK0JhUT+P4AKCV4l8ssiaLB60ylUivEtMoWUm3qiITpaFsEhYjD
 E1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721026098; x=1721630898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ejM0fchB/+7b5+8oaXsShCr6BuLuqd5/JmcZT6oPNn8=;
 b=QSv4M4tTR0jDRgeq53WXwAeacHinvvB8TCd0Q0mODT4LiAGXQxVsTo9bEcv6iFRPTu
 dk/3XdJT210Nv1UZU3cc6FW6izfH2XFnq5HS3cOqpLhayvLIj0OodTuwDTf5pEiHSB1b
 2v4jj2bgelHK87+/RbxefSo4vAvGkRHRlJkBORaIgBXLNT2YswH3xQgBdgscV4yokRG+
 WPTv8lnIa97ItOIcfrwG3g4FmZ1QY3Y1xQ6jbPeylxDrKdGiIkIumAt/9mBR8CjVhjCD
 YtnB8Mf2UrUs2shKQzYZcIDCv66B3pnlGZLXFdE5Apq1TMJgMn1djHjI7fMa7JUEdgRX
 CxvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6KKLP2weBOy6s97woqcfNoZNiMZ6OdT2se09ii5zqbz2OKEbJSrht69gnJ3yCYMfTOnprdcQuRqhTGIDTXmFgVg0Fy/4=
X-Gm-Message-State: AOJu0YxyXjJ1hiJxGr/T99cHR71P7BUJzAiS+mkbWRfZP1GH6i8jzc9Z
 ajwNmw1u/rLq7Uf747IXeROQvZOkokVj4UKlayOkLDaXt3CypOzVr4WmKigacsAOfL7CJR76+aJ
 d
X-Google-Smtp-Source: AGHT+IFTZgdFbXziU/o+CNnuWbi6HFqyXy04ySjz+PL9CdoNzRdACHmv4xkUbWHsEoB11TiyGS8QqA==
X-Received: by 2002:a05:600c:6b05:b0:426:58cb:8ca3 with SMTP id
 5b1f17b1804b1-426707e21d1mr114557505e9.21.1721026098176; 
 Sun, 14 Jul 2024 23:48:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.134.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25abf0sm108424305e9.14.2024.07.14.23.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 23:48:17 -0700 (PDT)
Message-ID: <1408e396-b597-4481-b537-e7b53976d5d1@linaro.org>
Date: Mon, 15 Jul 2024 08:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] esp.c: remove transfer size check from DMA DATA IN and
 DATA OUT transfers
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, fam@euphon.net
References: <20240713224249.468084-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240713224249.468084-1-mark.cave-ayland@ilande.co.uk>
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

On 14/7/24 00:42, Mark Cave-Ayland wrote:
> The transfer size check was originally added to prevent consecutive DMA TI
> commands from causing an assert() due to an existing SCSI request being in
> progress, but since the last set of updates

[*]

> this is no longer required.
> 
> Remove the transfer size check from DMA DATA IN and DATA OUT transfers so
> that issuing a DMA TI command when there is no data left to transfer does
> not cause an assert() due to an existing SCSI request being in progress.
> 

[*] See commits f3ace75be8..78d68f312a

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2415
> ---
>   hw/scsi/esp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Queued adding [*], thanks.

