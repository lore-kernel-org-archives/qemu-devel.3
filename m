Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC5EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3gq-0006tZ-Ow; Fri, 28 Jun 2024 00:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3gk-0006tA-G9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:58:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3gj-0002WS-2I
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:58:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42564316479so1625135e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550699; x=1720155499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xbr9rybPh4N2rWmaVgVENrLo/ZsiPhxe1OSxAbxrTQE=;
 b=JwHE+g9feUic1yeArIJEBDPUP9aj053BK4/uJ6+bUAdJbET0DZDBXM2Rbj6t/0gAZm
 zXF/eRDfet198quOwPguo6VcaJPJ2TLS7n330FkTJJI45QQ2CIG85waCIckKWkPJhmto
 ACFmrUvRMFNmwUUMPVZh0B+KcNxq3uV6ixBSs7CXdkHyt+cT9HnDlUkx+MQRu6lFPydh
 +UoOObXVY5whGjW8DHjPICctdT1KKwN4VjxYcTHQ45NKQTatu1TmqieU81F/K9lQ/gdf
 XrKUH1xZ+4GnSdxu8C5eOnLuJj+RuZ6hLI0Ow3vcce2hSAho5HZcDwO5RLl+oGiWtJAs
 vuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550699; x=1720155499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xbr9rybPh4N2rWmaVgVENrLo/ZsiPhxe1OSxAbxrTQE=;
 b=VROBS/IPz7igz3Ez7edxU2XUh2IBogkZJ1fSMCsq+4layVb03IhUK2Ly3XpNYk7WkG
 bpfbqPD+1sFE0J6L1wS6pbwreYIxTxIdH11eT2vTxIAalbBectCRnkHF2HQ4KFuedzO8
 mOoVQjFBgcGMtrRE6UqUS7wI/zfnVuz8S+PiQrzGdBLpfoB21sz3DwRv3gO1DwW/Zob+
 05S0cXWKqo9qNRh8vlvBcWKWkUKe3G65Pbnf5F28y6/oLuzq+i7bVyGK7tHPQUQh8UHV
 plmcbOxmBORMerKNUC4aIpUNtxHO5X+99ErHZMfct8da76OLPtP2RbNDx9/F/hb295T0
 k2Dw==
X-Gm-Message-State: AOJu0Ywas/owkKL03BrXF6tMDrFUECJw1eXJrdl7JFJIDisqZYmHQf/B
 Vl1TODse8xRIeT5nZMPPa6d70qGw3TX0GFWdgJDtRLmvOAYlNyDFL9Xn9zerC3E=
X-Google-Smtp-Source: AGHT+IFHAkpBaW4fGxThauPZRd+6pZuA7n5gWXtm4QGGLOm71Z470DLP/MnCfXxn9yXVGKTYgPS4RA==
X-Received: by 2002:a05:6000:1847:b0:366:ead3:37cd with SMTP id
 ffacd0b85a97d-366ead33bc6mr12604703f8f.28.1719550699270; 
 Thu, 27 Jun 2024 21:58:19 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba2dsm1068055f8f.73.2024.06.27.21.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 21:58:18 -0700 (PDT)
Message-ID: <836773ea-562b-40f2-9839-070dcb868c6f@linaro.org>
Date: Fri, 28 Jun 2024 06:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Fix reference to dump-guest-core
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240628-dump-v1-1-c581d10f3646@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240628-dump-v1-1-c581d10f3646@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 28/6/24 06:05, Akihiko Odaki wrote:
> dump_guest_core is exposed as dump-guest-core with QOM.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   system/physmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



