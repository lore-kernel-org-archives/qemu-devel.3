Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5632DC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 21:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlExQ-0006sU-RS; Fri, 15 Mar 2024 17:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlExO-0006s7-UI
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:19:14 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlExM-0003xt-AO
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:19:13 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1deefb08b9eso7853495ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710537551; x=1711142351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+gLcsSd+82W//jVjpRTLgIoNNUORr3Cdrj83Fcwwhhc=;
 b=VSGZrRwaLXFjGpSi+SpP+jYsty7xgOt/8W+20qxCKlcKSJACfPFdVhA9hiMoe8TNay
 43g38xlqliyLb1bpAKBVsprgSsbAe0/WHk1u7tmX5yWp2z2LOpdJQT0yyW019TmXxspt
 d9Y3/02+zK2rStwJeE3TqHyA5hZLFDIRF3H2GdEhXrGKE4/57dDkZWt6NLPDn6XGGMEl
 QZlEBibVLRPJcsxf88DBElYQQrCK9D8S9EHHujpVRoHNjLsGVpnxsDNci7LSye07g4hy
 tiRVNIYt//gWpf7nEAjzUw2l0qVXSjQJ3Q3BzOPEhndrD6ujbIlNxflr/op7Rea+UEQ8
 olKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710537551; x=1711142351;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+gLcsSd+82W//jVjpRTLgIoNNUORr3Cdrj83Fcwwhhc=;
 b=VcsvAp/jqwdR8gVQeEEBPpb5PPijdXSLSvfoCCKguFmXOlr+DN2gc3toMy95xo1ih3
 5+6VgG2m73x56nVsAmWtq9Ef1WaCq8nEt70nv0GWtMpnSODJRUNejR62buAo4CT4Jv40
 u0M1ZjhmMNfyoUNUERp8JZEmr5PW3mVeIAXhWzyRFtuCWQEBQVf14MHEIyCfsAqwCCyl
 v4WHJGVr8Tllo3o20PUzDUpiiH1Whlfk7uy9MCA2PvzFMep28Uzey9vGAcBkQC2N9eEW
 AcFC/BBhr8EVv5JCoVJe+4Z9aQ7Eaz2SmQKEUbxR7wuL/MCdlY5rRtz9miCjqN4/iBKY
 U87A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUZVfbLmX0DljnNGF6ihFsuc72ZvXMbTVVN1407lY+j6M85va2fC31nWekXjF27l32rHO3f6/oz5KKe4uTPMQp4961miE=
X-Gm-Message-State: AOJu0YxDy3yfRjq6aw7nLEsct/Dlgqzay9Sm/OkOQwSDl7HoTZ7jj4Hi
 AnTLfifHWvxkcN4GvKqzG9JcVrtRtJnu9PUKwCv835RN5MBnY5dZFiMMkQrrO3g=
X-Google-Smtp-Source: AGHT+IGd839unfl5u88c4jZhktapH64UexUXDFUsA3WP4J6nj2zQHi7/A+2CwJziG9tbYFU+IFRU2Q==
X-Received: by 2002:a17:902:f812:b0:1dd:e114:1216 with SMTP id
 ix18-20020a170902f81200b001dde1141216mr5520961plb.30.1710537550773; 
 Fri, 15 Mar 2024 14:19:10 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 o19-20020a170902e29300b001dd8d298693sm4365995plc.23.2024.03.15.14.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 14:19:10 -0700 (PDT)
Message-ID: <d144337e-514c-4796-a4cf-52c9c06d5a68@linaro.org>
Date: Fri, 15 Mar 2024 11:19:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 07/12] plugins/api: Check for USER_ONLY definition
 instead of SOFTMMU one
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> Since we*might*  have user emulation with softmmu,
> replace the system emulation check by !user emulation one.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   plugins/api.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

