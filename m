Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45739D1CA05
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85a6-0001mI-2t; Mon, 04 Nov 2024 17:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85a3-0001lS-Qq
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:29:51 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85a2-0004bs-6q
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:29:51 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2d1858cdfso3462681a91.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730759388; x=1731364188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fandZ6O+BAiYXTkQCjX+YXzhimBNpgD6Cdab3966J/c=;
 b=pR0RxkrmmX0pua8D3GbqUASMkml14Ie3Zy3/6VGu5mtS9gFkeVmHzYZmFCuY5lFesq
 NIHrTclyZC5grB/+6oieNkLPnrlhEChaFspkPF5QW1ikLjZSvdjdkcfHoiXeIXDFj6+9
 9/8MjHP0pIRoLSdYS4KUl6bG09O5rqu2fM+O/+OCGFA4SwlqavApQTpgz4d193Kx7dk+
 GjmkNJz+strToQIiNnptJaYfORCFPXJA/W/BiB87yuDkOKrKysSV/ZARCsz5VgmRT4iI
 sZO4hqkPLwlY9UD5B+BwVyZr8ujmCl84DGFpMpsupcO4TgJaFnFQIBJPCH8chpPBXwQV
 qgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730759388; x=1731364188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fandZ6O+BAiYXTkQCjX+YXzhimBNpgD6Cdab3966J/c=;
 b=ddLPs9peXVqeE8ewaYTE/CY5GpexhYdmh3syX7d2cGLD85Cxb7+Yj2zauQhs//92v4
 3tUWu+RpvvsmH8nxVFwbTQNI8HwC/nR0fWkHKqvuXnVu9XmDd6rjsX0iH0Lm1aAIvxqg
 4Fkf6eCr4XZUkkJwwCqBN6CHKQbvP1/1ZeHcLiMzUZZNWIrWu/WtjR6VdgsoxnDqH0vq
 xImBV6ibVTz7WHnw6tbnL+owbFe0ps/KOOXfk87SeBGOXjcWFPg9DIM8a/E43B/zCI3P
 kkyUgvtFIQHhFl/UOKpTCRGNZl6e69Hyv0p8tbjDX2jAZLxhHIM3fuzt8SzExkMOEw7j
 kWBA==
X-Gm-Message-State: AOJu0YzTRnJFmehp94ZfxfNAbT36SKpTJCwCmXFo2xjvyPVDuDqYi003
 NPTKYj39rxLeWjyr+4k1oJ/s08ZlxlQC8d4mYNWTEFXsaRdt2VJTn8g36yUlLmc=
X-Google-Smtp-Source: AGHT+IFuGl6JqyqhbQ1y9UTn4z9q0MC3tFvL90LdmtlRR69oOIoJm5XrVgUuimh7phwmYBU/A87rCQ==
X-Received: by 2002:a17:902:da8d:b0:20c:d76b:a7a0 with SMTP id
 d9443c01a7336-210c6879efbmr441838185ad.8.1730759388591; 
 Mon, 04 Nov 2024 14:29:48 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057c9783sm65957805ad.236.2024.11.04.14.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 14:29:48 -0800 (PST)
Message-ID: <80e9a9b5-5898-4b7e-ad16-6eb6d02f9d16@linaro.org>
Date: Mon, 4 Nov 2024 14:29:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] build contrib/plugins using meson
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241023212812.1376972-1-pierrick.bouvier@linaro.org>
 <87cyjpkds5.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87cyjpkds5.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

SGkgQWxleCwNCg0KT24gMTAvMjQvMjQgMDM6MTUsIEFsZXggQmVubsOpZSB3cm90ZToNCj4g
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6
DQo+IA0KPj4gQ29udHJpYiBwbHVnaW5zIGhhdmUgYmVlbiBidWlsdCBvdXQgb2YgdHJlZSBz
byBmYXIsIHRoYW5rcyB0byBhIE1ha2VmaWxlLg0KPj4gSG93ZXZlciwgaXQgaXMgcXVpdGUg
aW5jb252ZW5pZW50IGZvciBtYWludGVuYW5jZSwgYXMgd2UgbWF5IGJyZWFrIHRoZW0sDQo+
PiBlc3BlY2lhbGx5IGZvciBzcGVjaWZpYyBhcmNoaXRlY3R1cmVzLg0KPj4NCj4+IEZpcnN0
IHBhdGNoZXMgYXJlIGZpeGluZyB3YXJuaW5ncyBmb3IgZXhpc3RpbmcgcGx1Z2lucywgdGhl
biB3ZSBhZGQgbWVzb24NCj4+IHN1cHBvcnQsIGFuZCBmaW5hbGx5LCB3ZSByZW1vdmUgTWFr
ZWZpbGUgZm9yIGNvbnRyaWIvcGx1Z2lucy4NCj4+DQo+PiBCYXNlZCBvbiB0aGUgcHJvcG9z
YWwgb2YgQW50b24gS29jaGtvdiBvbiBhc3NvY2lhdGVkIGdpdGxhYiBpc3N1ZS4NCj4+IFNv
bHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzE3
MTANCj4+DQo+PiBQbHVnaW5zIGFyZSBub3cgZGVhY3RpdmF0ZWQgYnkgZGVmYXVsdCBvbiAz
Mi1iaXRzIGhvc3RzIChzaW5jZSBjZjJhNzgpLCBzbyB3ZQ0KPj4gY2FuIGVuYWJsZSB3aXRo
IG1lc29uIHdpdGhvdXQgd29ycnlpbmcgb2Ygd2FybmluZ3Mgd2hlbiBidWlsZGluZyBwbHVn
aW5zIGZvciAzMg0KPj4gYml0cy4NCj4+DQo+PiBSZW1vdmVkIHBhdGNoZXMgZm9yIGluZGl2
aWR1YWwgcGx1Z2lucy4NCj4gDQo+IFF1ZXVlZCB0byBwbHVnaW5zL25leHQsIHRoYW5rcy4N
Cj4gDQp0aGFua3MgZm9yIHF1ZXVpbmcgaXQuDQpXb3VsZCB0aGF0IGJlIHBvc3NpYmxlIHRv
IGhhdmUgYSBQUiBpbnRlZ3JhdGluZyB0aGlzIGZvciA5LjIgcmVsZWFzZT8NCkl0IHdvdWxk
IGJlIGNvbnZlbmllbnQsIHRvIGF2b2lkIG5lZWRpbmcgdG8ga2VlcCBpdCBpbiBzeW5jIHdo
ZW4gbmV3IA0KcGx1Z2lucyBhcmUgcG9zdGVkLg0KDQpUaGFua3MsDQpQaWVycmljaw0K

