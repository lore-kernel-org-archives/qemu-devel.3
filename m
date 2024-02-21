Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA23C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrcQ-0005T6-Lg; Wed, 21 Feb 2024 13:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrcN-0005OL-3r
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:46:55 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrcG-0007LH-NX
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:46:54 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so1563813a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708541207; x=1709146007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s+KclRE1IQFVJH0yY1NBZ+8bRc3GULNkrtLUWxW5QUw=;
 b=wCWKpg1hJMBBL6dgsna8/0BMYqLFDJ3GUjwjK6cMs4d+vDlIpweo0I/1QBYtEiP9Ah
 jYypNojiB5g8+r+ga8D32YXzqKmRgySAiZZXyFnE8TBgdVKeAdHGCd4KVNboe4W71UcZ
 ijKfi8sxM9evsfnX2Qg9W2ByMskaVjja5zOVaGzpcHYfDwXI1822Jhg9RCe02EbAug9d
 sMqZyN79K+rrY8F+vFDdiNf7ZfyzkBOzcwuJEPXoQK5FYEKCN5il1/7cTikOOZGKd3i6
 ebef9KOB6/cUyY5Cut2oJ17TrwN7h0vSQeOkADeQRDR71xb3iTaflhrGwIwVv611VTuU
 6YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708541207; x=1709146007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s+KclRE1IQFVJH0yY1NBZ+8bRc3GULNkrtLUWxW5QUw=;
 b=MDqPgMi2IjouiHNtwx6WQEcxJc1DsB3bkb3NgO98vSNoykND3uJv9D1aUVkrt4M3eC
 tAMcCXU7w5HehfPmO0Bg5o6feCue3zzbkGb1oS+jJGNzMGDFMTtq04z9BQHGemBrAQFz
 nRwaHbipRenVw+F8q6yXT+JtreV3Zwf36vIrq5EVtP+brE3ShsgyGAU0cvI8npCpPlCK
 tTLV+bH+U/uvKo9PsZY2CJ7kjMDSFtqWg/FNFV+OKaQ3wKrCR2Ft4+J6O9gxUqm0bzCJ
 +dnAyStGT3fNOz/DxR3cHTiJUPE9b41P6ac+suvYukRGn+ROe3Yz9KrJSMGgDZfD555G
 zpKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTSbpzNJKvI7wTvPcFUPkXhwalRp7eRp7QeMddFfMB4YAynWgq30YsQZ59/fwLpk6wTeVcRmpMJCrF9tFOwv8sy8RmiV4=
X-Gm-Message-State: AOJu0YzKdAKGyIzMcaDM6oJ4x/ex788GD45vh1fs/suiB4fO5/c3sn2Z
 qKapxfA6Nfg0MyoRgdq+5BuTxwC+1Queep8kmnHOM700BogJVJ0b1y2n6NVbnac=
X-Google-Smtp-Source: AGHT+IEXTIHTvGVvmUUR77Vgy/SwXO6rrQ47ozKu0NYTaH7JzmOjYwqN/M8fRrXwMN3p+EU5tPPdig==
X-Received: by 2002:a17:906:f8ca:b0:a3e:ff8d:c6d9 with SMTP id
 lh10-20020a170906f8ca00b00a3eff8dc6d9mr3780777ejb.71.1708541206994; 
 Wed, 21 Feb 2024 10:46:46 -0800 (PST)
Received: from [192.168.221.175] ([93.23.14.172])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a1709067b8600b00a3e53eb1dcasm4188372ejo.107.2024.02.21.10.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:46:46 -0800 (PST)
Message-ID: <6eea2038-e9d5-4f7e-98f1-f1c06bf97eda@linaro.org>
Date: Wed, 21 Feb 2024 19:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/ide: Move IDE bus related definitions to a new
 header ide-bus.h
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org
References: <20240220085505.30255-1-thuth@redhat.com>
 <20240220085505.30255-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220085505.30255-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/2/24 09:55, Thomas Huth wrote:
> Let's consolidate the public IDE bus related functions in a separate
> header.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/ide/ide-bus.h  | 42 +++++++++++++++++++++++++++++++++++++++
>   include/hw/ide/internal.h | 40 +------------------------------------
>   2 files changed, 43 insertions(+), 39 deletions(-)
>   create mode 100644 include/hw/ide/ide-bus.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


