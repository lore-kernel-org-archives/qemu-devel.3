Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82422C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsoxC-0000Fb-VL; Thu, 13 Mar 2025 16:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsoxA-0000Dm-T5
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:14:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsox9-0008SX-BG
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:14:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223a7065ff8so38456295ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741896890; x=1742501690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F8Ka/6q0nCpii4nTD2g9s9kAST+aI5zjstfCYQG9kkk=;
 b=IafTTnLLkOO0jkFrr0U84goqy4qnpljboqsMxeLoqhBYscp4JjRIlEGAwYlzU/v9H6
 N2ylSF6EihQFB1DR4YXkRz4yh3IGF1T+SDWRn+XN3ISQu1IfpMCrsMxFDUhdKKhv/hgv
 gPB65y/5vKT17HdbQyyLUIF7X3g4oJOtf8teZGu2a4lPqpc75wQcvnj9l0lwiMt/0CUJ
 K5pkEjN2cOvlL8CmEfK86F3hIgMuynv+Zvvo/dyyd5z1TrDEQua04WcdyIpBBS/wJqQG
 H4bJqNHwE5zKkGgYNgcbWl3SeP5oalGxldOtc4Si1lbnsA6p2qpzTLEYHTcIywUf0395
 pH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741896890; x=1742501690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8Ka/6q0nCpii4nTD2g9s9kAST+aI5zjstfCYQG9kkk=;
 b=CKHdXfbLOZrxhSi+H9lnG8kHGeNNiw07ZCyGaqSYY0L/DmLhyd8B/IYlDbXzJ5WxNM
 NhRrnxSi5Csl/BTdr4yb9TMPbJy+X4GX+Q13I8f2zkIs2x/L6MTgXIglpGYaEp7q7ZF6
 P7KwozqHsXHZaJ72BovWccndLsJ5ghDx8dYUt1dzEH2Zh5mBedeMcUIKHFdTl7XSNX/v
 wA4cTF4r1E7XTbJJAiQzzVOmrMr3RL69hPGBjHPdCT0Kc+a6WSrdZoZUvkiNUEWt1nEG
 QHS4b5PwgIm/ADRCGmTz8tFVI9Qp54tX8ja2qdYwkY/GUOOkI8CCDeeCCbVYAv4fv04W
 MH1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgu4yEfdN6RscfaDVk3sdBydt+znBz/f3G77aH4zzr0aa4NyAjtwXIAGjxAYvX1LZvbGaYUaUqoTj1@nongnu.org
X-Gm-Message-State: AOJu0YyJknn5o/bIX0nDs25iZZX4LldYgOt87Ca/UjSVJ63kpmWQMD4O
 TrKxxKVwMiX6WWquPhT0DKwlAPJ2zE5wamK2+IIQ9v1z4w1OIm28xerElafP04w=
X-Gm-Gg: ASbGncv5uyCCEDLuDc8sJykLzStbWpiLqdHS2vHeTUpWN+MYzOcD9qhJrc9ag0zy4z1
 OpF4kir73Uj6DO73DEeyqZTrz0+t63erP4Ij8cT9Wsst6iA411M97Bx1Oi2sUwCtwDLeMYhkQTk
 3acXjbZrx0cANfQBi/eEDtjuBRhSd2sEr5YSvpajjOuXwx3zmcTTArzdymu5fRU19jUwvfyut0W
 t2yEkPG2/vfNN1UNXpch9x5HYspGIXARut5KbHRefRjbXsddBYanpxPvzDqHrycpUjZRncQtrJO
 2EsZ3+tEPulUzy0CE9qhOiUrOJh7jTQPL5Dgy2LSMbgprXYVQE5ys2PQuQ==
X-Google-Smtp-Source: AGHT+IG1skFxOEQk62Q1TNk4B1KUqib3ZLjDUBLu3nUV/16whVQc5qvGyznrnF/F70TMU9kfUG9Pmg==
X-Received: by 2002:a17:903:2448:b0:224:1579:5e91 with SMTP id
 d9443c01a7336-225dd8a45a0mr8572825ad.47.1741896889906; 
 Thu, 13 Mar 2025 13:14:49 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd5a7dsm17507105ad.251.2025.03.13.13.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:14:49 -0700 (PDT)
Message-ID: <1173d712-1f73-4eec-80e0-67ce06371e2d@linaro.org>
Date: Thu, 13 Mar 2025 13:14:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] include/exec: Inline *_mmuidx_ra memory operations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-6-richard.henderson@linaro.org>
 <a6e79bf6-8b93-4b02-8888-6c2a417a34a2@linaro.org>
 <6d26b188-189c-4714-81a7-6061bb8a6ff6@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6d26b188-189c-4714-81a7-6061bb8a6ff6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gMy8xMy8yNSAxMTowNSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTMv
MjUgMDk6NTksIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gK3N0YXRpYyBpbmxpbmUg
aW50DQo+Pj4gK2NwdV9sZHN3X2JlX21tdWlkeF9yYShDUFVBcmNoU3RhdGUgKmVudiwgYWJp
X3B0ciBhZGRyLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaW50IG1tdV9pZHgsIHVpbnRwdHJfdCByYSkNCj4+PiArew0KPj4+ICvCoMKgwqAg
cmV0dXJuIChpbnQxNl90KWNwdV9sZHV3X2JlX21tdWlkeF9yYShlbnYsIGFkZHIsIG1tdV9p
ZHgsIHJhKTsNCj4+DQo+PiBGb3IgbXkgcGVyc29uYWwgY3VsdHVyZSwgaXMgdGhhdCBzdHJp
Y3RseSBlcXVpdmFsZW50IHRvIGRvaW5nIHRoZSBsb2FkIHdpdGggTU9fQkVTVz8NCj4gDQo+
IElmIHlvdSdyZSBhc2tpbmcgaWYgaXQncyB0aGUgc2FtZSBhcyBwYXNzaW5nIE1PX0JFU1cg
dG8gdGNnX2dlbl9xZW11X2xkX2kzMigpLCB5ZXMuICBUaGUNCj4gdGNnIGNvZGUgZ2VuZXJh
dG9yIHRha2VzIGNhcmUgb2YgbWFraW5nIHRoZSB2YWx1ZSBzaWduLWV4dGVuZGVkLg0KPiAN
Cj4gSWYgeW91J3JlIGFza2luZyBpZiBpdCdzIHRoZSBzYW1lIGFzIHBhc3NpbmcgTU9fQkVT
VyB0byBjcHVfbGR3X21tdSgpLCBuby4gIFRoZSBjb3JlDQo+IGZ1bmN0aW9ucyBvbmx5IGhh
bmRsZSB1bnNpZ25lZCB2YWx1ZXMuICBUaGlzIG9sZGVyIGFwaSBjb250YWluZWQgZnVuY3Rp
b25zIHdpdGggYSBzaWduZWQNCj4gcmV0dXJuIHZhbHVlLCBzbyB3ZSBwcmVzZXJ2ZSB0aGF0
Lg0KPiANCg0KVGhhdCB3YXMgbXkgcXVlc3Rpb24sIHRoYW5rcy4NClNvIHdlIG5lZWQgdG8g
a2VlcCBvbiBkb2luZyB0aGUgaW50ZWdyYWwgY2FzdCBpbnN0ZWFkIG9mIGNhbGxpbmcgDQpj
cHVfbGR3X21tdSB3aXRoIE1PX0JFU1cuDQoNCj4gDQo+IHJ+DQoNCg==

