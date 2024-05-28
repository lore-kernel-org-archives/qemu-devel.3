Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDC1C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC20t-0001jL-BC; Tue, 28 May 2024 14:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sC20r-0001j1-O1
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:57:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sC20q-00075z-60
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:57:33 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f480624d10so9798455ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 11:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716922650; x=1717527450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yxBF2d81P4cWreoBinwBHUGi/LjTFbHAeF3d3J1qeV4=;
 b=aDQa6RlipDsJZvOC44TZ9ih53vscfDzi+5ZEe2Ga8yslC1nPJARIMzecTSUGbpHFhl
 uHZcG/BAm4QLb6u+wjP0w2VC7AnkgciLBqFijpTmpUjsOSacMQ0IynGQy8BV5Ux+V323
 I+8oLleTevQwFZQxqKF5XGvxkrCzqHp/ACbc/2tOKt33uu6JIVLJpI4qh3ZigkZtu0vl
 ScnDmrkjBTdzgY3e43yWWNrcap67ZBdOjkyj9Vfi6vUu+WxU8/rHZy/gPAfFzb5PZ/v1
 JvQpo87QQK8aQhDJtTjjNOMVhwG4vF3vaLcdqdszNKDxlo88EBrlyG62ea4V5V4W5bEu
 9yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716922650; x=1717527450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yxBF2d81P4cWreoBinwBHUGi/LjTFbHAeF3d3J1qeV4=;
 b=wY6oextfTkF/0w46FZOBjavRBScNwZdka8PYGBCRQdMI6kKKU0ay1DEal2Z2d+og0V
 olhqRjnfAG+59ZVx/yPPIqGGt8oVXWtAS6ND5aMQGi17YW1zHEhPUbr7DQEr6f3Esrzv
 AxGtP3In6tWaklpl0n8a8sYxa2boznVkD0+9Rnd9NN22wZamAa6UUYsvho2UutBdS+zz
 DUQsns+mYPxh5X8/yWn99XOSyEiJ/a1mRx2czCkVKRW38Fm3Eqn7+ww9BIm3bbsueXv0
 MpAxcQTFzABUWf/28D6JFP1+7BIUGLLo67l3OcDA4qw56d+70zY4FL8mHVRBuThK+epb
 /gpg==
X-Gm-Message-State: AOJu0Yw1hEnSEU0d0E6GAnvGIE7v6JJreQH2G4tTScYayEoueZ6gaqUm
 TtA5zjIj776HchqYcDMk0G8Rid+PDpsD6/7lgoZgDeektADFhJn16yi9LEpd9jk=
X-Google-Smtp-Source: AGHT+IFj/MKJA8XWGTTofXNCVv9musv2S1DNiFgEnfVn3tfpGIkgM3DBf3ysSD7MsZ7aHwLD01jSCA==
X-Received: by 2002:a17:902:d2cd:b0:1f4:5685:b159 with SMTP id
 d9443c01a7336-1f45685b4f9mr149598375ad.31.1716922650537; 
 Tue, 28 May 2024 11:57:30 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c994626sm83578055ad.204.2024.05.28.11.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 11:57:30 -0700 (PDT)
Message-ID: <6eaafd48-f2a3-4440-bfbf-b1eb3dff5aa7@linaro.org>
Date: Tue, 28 May 2024 11:57:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] sysemu: add set_virtual_time to accel ops
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-2-pierrick.bouvier@linaro.org>
 <878qztg8uc.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <878qztg8uc.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gNS8yOC8yNCAxMDoxMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBGcm9t
OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+Pg0KPj4gV2UgYXJl
IGFib3V0IHRvIHJlbW92ZSBkaXJlY3QgY2FsbHMgdG8gaW5kaXZpZHVhbCBhY2NlbGVyYXRv
cnMgZm9yDQo+PiB0aGlzIGluZm9ybWF0aW9uIGFuZCB3aWxsIG5lZWQgYSBjZW50cmFsIHBv
aW50IGZvciBwbHVnaW5zIHRvIGhvb2sNCj4+IGludG8gdGltZSBjaGFuZ2VzLg0KPj4NCj4+
IEZyb206IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4+IFJl
dmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+
DQo+IA0KPiBKdXN0IGEgbm90ZSwgd2hlbiBwYXRjaGVzIHdyaXR0ZW4gYnkgb3RoZXIgcGVv
cGxlIGNvbWUgdmlhIHlvdXIgdHJlZSB5b3UNCj4gc2hvdWxkIGFkZCB5b3VyIHMtby1iIHRh
ZyB0byBpbmRpY2F0ZToNCj4gDQo+ICAgICJJJ20gbGVnYWxseSBva2F5IHRvIGNvbnRyaWJ1
dGUgdGhpcyBhbmQgaGFwcHkgZm9yIGl0IHRvIGdvIGludG8gUUVNVSINCj4gDQoNClRoYW5r
cyBmb3IgY2xhcmlmeWluZywgSSBkaWRuJ3Qga25vdyBpdCB3YXMgbmVlZGVkIGFzIGEgY29t
bWl0dGVyICh2cyANCmF1dGhvciksIGFuZCBjaGVja3BhdGNoLnBsIGRvZXMgbm90IHNlZW0g
dG8gY2hlY2sgZm9yIHRoaXMuDQoNCkknbGwgYWRkIHRoaXMgd2hlbiByZXBvc3RpbmcgdGhl
IHNlcmllcywgaWYgd2UgaGF2ZSBzb21lIGNvbW1lbnRzLg0K

