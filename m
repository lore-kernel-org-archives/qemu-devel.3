Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0103D6B6BF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 18:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Dmd-0006el-2R; Wed, 30 Oct 2024 14:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Dmb-0006eZ-Iq
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:51:05 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6DmZ-0004sB-IK
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:51:05 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99f629a7aaso25846166b.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730314261; x=1730919061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+w9PwpNYhsS0XAY23sT7/ICSpkG/mbY4+j6vB1dDeR8=;
 b=lD3lsbP+5Z3lGaDpeynNAdKPdWgeanHSb/X1t6yW6fcrmax2Qb5VIqxjzfA5aqcPJh
 phw2ePJNpPPTFJKm+MjsA2lkjlFlROqJtrhwJfIm0t6MBW2zPpya1oCXSbbx+MczdOQg
 2jd2Q78fketUn68lGldsvreuZk0wr/87EwuvPUs9+Fhb7WfX1hLc5RbXNYDxAzs8umei
 Fcn+1jUx4h0LoxVOHVQRPe/xBpIS/ATP7g1BehlM3U2YJWAfA856WMvLrond2qJMwgeh
 pHl4W7eNABenoFgGtO9ALljd2dlNHTLSpMNLvtoblvf1P4jeAThtmKd/jUX668i8/Bc1
 ge8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730314261; x=1730919061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+w9PwpNYhsS0XAY23sT7/ICSpkG/mbY4+j6vB1dDeR8=;
 b=fDPx2grLW2G0FeIYQd0iX2Ptpdxf/rkAB7O0JjYSrRODiLnLCc3J6kVtxInScLV+Oz
 FQInkJWmAh56mtay4lQ/Rm8TLh399VaIZjyD3X5Y+A7eO+us8BUlCTtpcxWCnB2iGV6o
 ZByw9Z8hMKC4uLEIQLkfGqiCOf3ukeYtrKZiQQO1j/i6sTP7ElGgcJ0+cf/gs6fUroMA
 Y4ZGONPNCjcvc9kt34o0a6GurE3eVp/BcHLUQWWXPuh1loFBnoLqt98Fdl8CXuOlfEWM
 T1ndP51vL3gb7WpfMqGs219YqIY6Ngq0IM2gFNh+FMdiPMWO4Ghy+V3n/FO8DDlBHkHi
 DtNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4SnoVeQRaybLjohU739I74UYUd7+M0GgW5Ia0438/Bw0Glz8E+hQmHUWpGw6xjoKjtVlnwk6hBDH6@nongnu.org
X-Gm-Message-State: AOJu0YyIAHp3QGwgxSGVMkvNCDfjrY3fKdUdrF5H15eR4xaBdbfzZayz
 G2yrUpjjJH0rqAGeeY1FrIj9m1MQPT9ILQxLtNv7dyewyLQqGUJ80xIq/F2OcXo=
X-Google-Smtp-Source: AGHT+IHyR+1j+oFIqE3oN1BSISIfN2Odaf4Egy1bbmdXGJexHpjiG5YhxWw2GyTV48p24mGYm1GM1Q==
X-Received: by 2002:a17:907:96a1:b0:a99:3db2:eb00 with SMTP id
 a640c23a62f3a-a9e4105fd75mr304693866b.28.1730314260712; 
 Wed, 30 Oct 2024 11:51:00 -0700 (PDT)
Received: from [192.168.243.226] ([91.209.212.192])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1dec802csm604770766b.13.2024.10.30.11.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 11:51:00 -0700 (PDT)
Message-ID: <08cb3768-a7a9-4e01-a574-4af2affbbd30@linaro.org>
Date: Wed, 30 Oct 2024 15:50:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: purge 'loaded' property that was documented as
 already removed
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20241030084718.2980247-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241030084718.2980247-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 30/10/24 05:47, Daniel P. Berrangé wrote:
> The 'loaded' property on TLS creds and secret objects was marked as
> deprected in 6.0.0 and then marked as removed in 7.1.0.
> 
> Except it wasn't actually removed, it was just made read-only, while
> claiming it was removed. Finish the long overdue removal job.
> 
> Fixes: 0310641c06dd5f7ea031b2b6170cb2edc63e4cea
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/secret_common.c          | 12 --------
>   crypto/tlscredsanon.c           | 35 ----------------------
>   crypto/tlscredspsk.c            | 34 ----------------------
>   crypto/tlscredsx509.c           | 30 -------------------
>   docs/about/removed-features.rst |  6 ++--
>   qapi/crypto.json                | 51 +++------------------------------
>   6 files changed, 7 insertions(+), 161 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


