Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D45EA8529
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 15:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzG7k-0005aZ-Tf; Sun, 08 Mar 2026 11:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzG7K-0005Rq-6B
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 11:32:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzG77-0006Cx-LT
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 11:32:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48374014a77so129012375e9.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772983936; x=1773588736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PrN4p/BD/fjYdU3wnZYTtnTYrSBl3tFrk2UtfU/gPkk=;
 b=S7edNOS2vPggKRoA8E8xBpo1c3CBTU9And1t2aeTxMKwkAhSe6Erds7i7IJtX1uZHt
 DgOG1x7yOQ8/NPUYtGnqAH9NoRp3SCMdltRqSId6EbQZDttO+PaXui+ttwyPB1+BBrtt
 mXOMO30zhdCQr2EIpqBRnYq/NJi+9JWkkpWMGT8x8VZsBV/KFLonq/QBM+y9X73AZiMM
 soENE3aqZ5ISgDQjf8VznD2yyrGVtcBRNL/D21krta1DGgah4IGVcgNXcn4dhFltQPI/
 JFuQsYWP+GnstlCQdCzyu1DRNXYSCAtiph3r2H7exWDiJXxp0sV2SktZ3lGspEfJpXsL
 uTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772983936; x=1773588736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PrN4p/BD/fjYdU3wnZYTtnTYrSBl3tFrk2UtfU/gPkk=;
 b=EOcuFJpUdaiogIGEH9tGhkqpvm4RkIstHQU74Do+3C3bQg4nzs54mSPWtap+BDHfpk
 ZUImLk1pR50lC4aSpwYAxQPb1yX0Iu1+pTjLPpeAXR9/XGhdSjhnWMrcNBODDhMqSReS
 o4aSpKyRzs6SMSniv9NJ2qU5+Q33vd5hOSOpJkcy2uUb0BdnvVzZyLDQCFvRPOXc+9qp
 8DZ25xO/JvlyS7iLRuYdmOJh7SzHhqGo7OGIO5iNRTehitnLzMnh8zTLQ2yAnZJS+GB1
 TAa05iKiT8Fh/czheffJwgmyLs7/lewoImRXRP4cZhlCUkIo3w3Jw0S7NiERzUgB4BS1
 B7AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWK+lixxuXF/3VVF6UBOEAqj8MMIqBncpVyPKhiK5fCtv+Oj6C4kZ/tp2epvIV8J/sTvgcca6tpcRP@nongnu.org
X-Gm-Message-State: AOJu0YzL9LpRINTpL+7P3TTHrXsOFncIbIugcl0/PeyK+RF2Zwveppm3
 8ZwTUQ2lo81hQG/Qyca220ybFmMyf/LeU1PT1EbXsYO3eoF2ixmOy/XKH3uf5Z7Lcoc=
X-Gm-Gg: ATEYQzzuk/jjuSYiFUxvMqdRRBvKcCTIhC6mxwiu2TxIY6Lw5FbomdEQxMdqjBe5Iqa
 v09OFrNdRsoh0F5h78Ki3k6z75V+KrWK7HZwwiW11OJVbH2uypZB2M7ZSyWNPXRl0cinLIUVZCH
 kOQ1Dqk+Db21nAAhWVpgJpuCScT/x2MGa6opaQDeZLsy13A4pQLt/N6x1IceDsSJsc62F3rNgo3
 UYB1cfRyfBaKGp8HFIF9wCuGQeKTBWnrT8xD5ZWAbC12Hxsupm+wsN+VGCpI4M0nDowFAmP1xsj
 xY5WuCxJyaISdSJUtPtBmcDZ1W3tKZsH0QVV3cTmAnQgzDFMGinknureLcwPziS0wvoaq804sB6
 3mPtRk915fk/ZrJNbPsmSZwIZpWCtSn+kljLG1QlGonD1Wqgbn2kekLsl7V5oHLWeM+mZyphZrt
 NDQ0CtS9V4aH4U/UpDV4oOHqk5QeuLWDMq/2WjS1lQyCYakzVfjfPJpyqOZiB3RGFdrhpeqKAjZ
 sHQ
X-Received: by 2002:a05:600c:c8f:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-4852695aec4mr144438865e9.18.1772983936230; 
 Sun, 08 Mar 2026 08:32:16 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae56300sm18516050f8f.37.2026.03.08.08.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 08:32:15 -0700 (PDT)
Message-ID: <3cb43c27-1eb9-430f-9414-26d582f0001c@linaro.org>
Date: Sun, 8 Mar 2026 16:32:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] hvf: arm: unbreak the x86 build
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
 <20260307181856.2209-4-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307181856.2209-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/26 19:18, Mohamed Mediouni wrote:
> We don't really have any great choices here, so use the __aarch64__ define to unbreak the x86 build.
> 
> Once the CI moves away from macOS 15.1 SDK to... 15.2 even we can get rid of these SME stubs horrible hacks.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr
> ---
>   target/arm/hvf_arm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

