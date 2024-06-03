Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C611C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sECxC-0000Ti-Ei; Mon, 03 Jun 2024 15:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECx7-0000TD-CR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:02:44 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECx5-000718-78
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:02:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so2757945ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717441357; x=1718046157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TOxsmWjGZpnwIiGfGze2fRMPC6csmdvLSCFXfKjGI2U=;
 b=HCKph/i4xBF15Tja9ch+d3EEl0Q3BhWYUdBN2D/xvaA78pB9sL7uw0eEcNhDWXxdJv
 r157OxrcCGQXpdN+1Nc1vv2FBKv2VcLOWTj84E5pQm0udJ6PoE58sWbm6ePTlZzxnL6L
 6nO7L6DFxFP/HEerSqYoOgaNZU1z3Wsy9BmPgMb+/chAYzBKgzKT+DqTcicrK4RiEzzO
 v4IbN3PFY7kgJScwdWQr9jg2eSlYGZ8bsf/TbkeB38XzbgeE3Luczf6FTkv2DYU664oM
 ci8zzidhCid9bjw76AqXrGc8nx+xqQ9LD5GMrriEVuu2wE6spdDd+a+a3WYUdROLjPW+
 HyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717441357; x=1718046157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TOxsmWjGZpnwIiGfGze2fRMPC6csmdvLSCFXfKjGI2U=;
 b=AfdWNqQZXpaFofYe24sPiXazXJNaduNRoD/4TJq0s+bcByx75kx5azOQgkoRGAVbJZ
 RixUEL9QJDPA2/v3i9dSAJl5xKHZ65uKy8JEG6tXRM8emWHvn1q2lyNLleYYPzdf0JQG
 hlyEx/toEW6wql9+scG2XHvUmizPT5h18GDie3r26KMt94nsUTp4R12GTw3Q21lF2o60
 WftM3lOW/HXEjT+gIgIINjOd1enViGlJuCUE4vv1SabVLeBT8+QCpOjo5Y48oU05HuKk
 pmB667RmHnXbP0fJecsYWaU86lPcefIwcsXNAOgXeuYSDkiQa2HnKx1JvRiRi4utZu2I
 +DAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbbYYoCELLHc4Ehi2jFP3FarWhnAByH1ncHYCPpfsr049+UiOC5vysUuuGoLS/jeKGmxwFVMD//cJqM68nDW+o07eh6yE=
X-Gm-Message-State: AOJu0YyJiH2DbcHuC6cFj+kERVgA6vcsgqKc+WPzfNfgKposIIcIIsi/
 lK6x+5BPtTICjC6oLvJNdj355EmWNiftBr51bkpPQiMTNFCN78sZVDUpTs/ejJA=
X-Google-Smtp-Source: AGHT+IEaGaOX6UPX8ae1GjzuyJHzSQhfOrsEXx9GJuOYCpR00SiTut3wnfCz5mcZWjY/B2xAcCzWFw==
X-Received: by 2002:a17:902:c94c:b0:1f6:5a50:93b3 with SMTP id
 d9443c01a7336-1f65a509712mr79990525ad.43.1717441357331; 
 Mon, 03 Jun 2024 12:02:37 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632416d90sm69917185ad.285.2024.06.03.12.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:02:36 -0700 (PDT)
Message-ID: <4cf04d34-bc45-4c6d-b746-aaade0b35df4@linaro.org>
Date: Mon, 3 Jun 2024 12:02:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/27] linux-user/flatload: Replace sprintf() by
 snprintf()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-23-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gNC8xMi8yNCAwMDozMywgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IEZyb206IFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gDQo+IHNwcmlu
dGYoKSBpcyBkZXByZWNhdGVkIG9uIERhcndpbiBzaW5jZSBtYWNPUyAxMy4wIC8gWENvZGUg
MTQuMSwNCj4gcmVzdWx0aW5nIGluIHBhaW5mdWwgZGV2ZWxvcHBlciBleHBlcmllbmNlLiBV
c2Ugc25wcmludGYoKSBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBNZXNzYWdlLUlkOiA8MjAy
NDA0MTExMDQzNDAuNjYxNy01LXBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4g
LS0tDQo+ICAgbGludXgtdXNlci9mbGF0bG9hZC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2xpbnV4LXVzZXIvZmxhdGxvYWQuYyBiL2xpbnV4LXVzZXIvZmxhdGxvYWQuYw0KPiBpbmRl
eCA1YjYyYWEwYTJiLi4xYmIyZjQwMGJjIDEwMDY0NA0KPiAtLS0gYS9saW51eC11c2VyL2Zs
YXRsb2FkLmMNCj4gKysrIGIvbGludXgtdXNlci9mbGF0bG9hZC5jDQo+IEBAIC02OTIsNyAr
NjkyLDcgQEAgc3RhdGljIGludCBsb2FkX2ZsYXRfc2hhcmVkX2xpYnJhcnkoaW50IGlkLCBz
dHJ1Y3QgbGliX2luZm8gKmxpYnMpDQo+ICAgCWNoYXIgYnVmWzE2XTsNCj4gICANCj4gICAJ
LyogQ3JlYXRlIHRoZSBmaWxlIG5hbWUgKi8NCj4gLQlzcHJpbnRmKGJ1ZiwgIi9saWIvbGli
JWQuc28iLCBpZCk7DQo+ICsgICAgICAgIHNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1ZiksICIv
bGliL2xpYiVkLnNvIiwgaWQpOw0KPiAgIA0KPiAgIAkvKiBPcGVuIHRoZSBmaWxlIHVwICov
DQo+ICAgCWJwcm0uZmlsZW5hbWUgPSBidWY7DQoNClJldmlld2VkLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

