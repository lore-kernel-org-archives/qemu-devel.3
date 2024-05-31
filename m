Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE9DC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyGf-0006es-1y; Fri, 31 May 2024 05:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCyGc-0006dF-RO
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:09:42 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCyGb-00053j-53
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:09:42 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52b7b829bc7so2102787e87.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717146579; x=1717751379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9nHLqWeneXgssP+00AwHJM3tHuDqX/2jS/REuWoSHIw=;
 b=khg6hTSFpNCI3lEaUE1bnHq9VsDXxt/ytxAeaDEzWosRenRpMzqwQxXVRX+MURB/xh
 Aa7XkpR3rP0Nq4dqf5cBV+9JAxt3m5D/hP4zCyHmnrMJN6HbvdLfCUds2XqfocFc1iKs
 Qh0tbxQ7QyCXVN06pgm9atwVhnHw0kzVZjpMca0kX9lZLaCDNUQEV3SLB6BKOBJhQFLB
 WmCHytzrJrv59TG2sXQ2FDzGTfX+UN1kDYoRWQyKEKyaujg2oSArYAIaLQaUeDqlYfJ0
 pirP06+B+ilSS2fNyuFY8jCTdAoEAuWMliLzu8DMRskExuuJ70eZvUPHYaE89RpumNo4
 y5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146579; x=1717751379;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nHLqWeneXgssP+00AwHJM3tHuDqX/2jS/REuWoSHIw=;
 b=s2f16wWxIXXhCuZ16Wm4qGa/D7O3+S61ErPoIGyOl+0ho2fAiYG3R6NjutQl5h4g9Z
 bxOSRdVefBO/mDqewxEJQSKkW/oDEyNswSb9daRXauV0OjycHVWSMa7/ED7KbCnbJw9K
 wKYkI+L1OH6+elPQ45YUaDVTwWPDdQa8niDe6JHruPALOcGZXGP6yoZb+0TyeCa1GeHa
 9oyMrG7xtkI3ZpAtJROWVqjl6aL1cU4NYHeDtS/SbPPpfnDgwJvPil7muo+ixSCCo3qZ
 ipFNvH+/2tPBME9HDsp7gn61pKQEdE0EbXTIbnlaFkQu/eTTsfKZ0Pu5CVhZxrhimSTj
 ETiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV18ivtY7X4KFhhyWiuLj49Gsagx6K6OJrEAUCbbGkAaMbfybeubMrqpUDVq3BbPKs9qqceGZfkfv1JEV6Wr43ili7Z2pg=
X-Gm-Message-State: AOJu0YyVHf90Xw1FhANqjEomyAYA2H7/OCCMSozH++Mlb9SO1QBPUn3R
 1JHH84TW+BU5vvtlGWhq7/pRGZaGSedmqP15kyqScqlO8bpMPWDK
X-Google-Smtp-Source: AGHT+IH88NdbdF6pEzhBNUimRkWJPQqdY0qzX+TwohQvgXS4DJe6CtPrF9PW//10pZ/crdnVcStzaw==
X-Received: by 2002:a05:6512:45b:b0:52a:daba:f7f0 with SMTP id
 2adb3069b0e04-52b896dc4abmr679253e87.62.1717146578471; 
 Fri, 31 May 2024 02:09:38 -0700 (PDT)
Received: from [192.168.3.251] (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b83d5c7sm18847855e9.8.2024.05.31.02.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 02:09:38 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e1451535-b62a-473d-bb6c-00e91274aace@xen.org>
Date: Fri, 31 May 2024 10:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] hw/xen: Constify XenLegacyDevice::XenDevOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
 <20240510104908.76908-3-philmd@linaro.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240510104908.76908-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=xadimgnik@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/05/2024 11:49, Philippe Mathieu-Daudé wrote:
> XenDevOps @ops is not updated, mark it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/xen/xen_pvdev.h  | 2 +-
>   hw/xen/xen-legacy-backend.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


