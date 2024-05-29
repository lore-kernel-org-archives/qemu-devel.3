Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E07C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCMc-0003Gs-0h; Wed, 29 May 2024 02:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCMa-0003G3-4o
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:00:40 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCMX-0002fE-FR
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:00:39 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45eso1445851a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 23:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716962435; x=1717567235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ztLgaymL7oLxJjP6YRzdsWRYZX3TwouQKFQPvFZnj9A=;
 b=u6zuk/jyKVu8dtWsArUeizEHycy7k5ca/dUuN+9AonArhkBo8Yau+SMnzmly5TmiD+
 TAIk7+DQVTnqIExAohsleVCt3LpvyC42spHPi6p0dKGGexUD9sc4wloqOgmi2smuB5JV
 FFsREGBoNIBBYUcaGBAUhn4L8W1rzpAlnJrqbxDhzzER3ELgOvuaywsyZgcxbnDSL2Ez
 cTKj6hlqLPfcdX3rMo51SYduRjwO2xKWdOv+s4Sa0ry9mrVRf2b5eDCn7goCCwEiCUF5
 HNs8AD59jI5fzypE9DwqmeIBI4+CgnQDd7mQ2iycUTMzI/Oz/eqTh44qH4jKWLI6m3YQ
 WCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716962435; x=1717567235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ztLgaymL7oLxJjP6YRzdsWRYZX3TwouQKFQPvFZnj9A=;
 b=J/bhruqGdA9vHQcw6wAtnW1j0unaCtYjw+3qTtQEr0gv5/deJwB3I/4Pl0q34UDWtw
 D+5bwWCZV6+GrdmSTkNKqYYyPDu5ZXkkQxL6gt5nvlFvcSGrl+qlsOlvkKCmr2Y7wmgp
 TqQ6kw+UCKbXXdFb8t6isVhjk/Uu1K8xE6e2zA/uWsHTkF4GJbqxCXL9joeWa8vxkATk
 Ij8a1hO5NCEZcoKxEPm4aG+TNMK63duEdMC75OrMmBiReUuuq5V0PiA6oGMSBAmJtaHo
 zwXVVxD5rVtVyZvC5sJNSf+4XKopf1hmdwZBsZEMmv1m/H7+M0Exnv2CPa+v+BXIwBBl
 nW/A==
X-Gm-Message-State: AOJu0Ywl1FoOwfs9w8WC/i8hjPmbPXf191pmhjmWgFBRs/qIibA/axeF
 r8+RWhNMA9teol6NHFtTMmcVlGUmxB4TYJE+f9rMVwOQEInBTzmFlq+b2e4e/Rs8yCuHs1ObXBr
 4
X-Google-Smtp-Source: AGHT+IFM5Z0aeALvku2ZQJue38QP4A/ewivTRaua4nTvgaCOsWj3iia/lN0vWaRyGOb3z7t/bUIofw==
X-Received: by 2002:a50:8e1b:0:b0:578:62a8:a5f6 with SMTP id
 4fb4d7f45d1cf-57862a8a716mr13082474a12.4.1716962435335; 
 Tue, 28 May 2024 23:00:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5785234860dsm8037402a12.7.2024.05.28.23.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 23:00:34 -0700 (PDT)
Message-ID: <877f0608-88c3-4864-9805-b6b108f8d0e1@linaro.org>
Date: Wed, 29 May 2024 08:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/23] hw/i386: Remove deprecated pc-i440fx-2.0 -> 2.3
 machines
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240529051539.71210-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 29/5/24 07:15, Philippe Mathieu-Daudé wrote:
> Missing review: #20

Err, missing review #20 & #21

> Paolo, Michael, should I merge this myself? Ack-by welcome ;)


