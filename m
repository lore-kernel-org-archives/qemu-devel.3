Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1286C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0FM-0004bA-IM; Mon, 22 Jul 2024 17:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0FF-0004Fs-2D
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:06:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0FD-0005BE-Ei
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:06:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d2b27c115so966865b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682413; x=1722287213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHheaBbdivCBNrjkMc5BpEzF1l75/EsEBipNIOMuwxk=;
 b=wvV7gqbyGMmJG2o2RnOtDzpyRU+n9LHAH2ppjshYE76WirFxSYhmE3+gQJGaLHiY1e
 2KS/BgBvpbzdHCbUBHydM6T8POFl/0eaok7FLjDZze0pXr8jDP7scpFBePfheCVHBzD0
 dqUZrVTrD1u7Z+Cn3Nuee4/8K7C3vhcbViTP5mby6lqgfpUHxHFCoOGruvlLR7qEuFsj
 zmFM+axpznzkpDlT7HIaCLLpXRLTsLP6F8AuZ3rgtT4P3legBwOciCR//cob4Rj1iEYE
 aIN19fEonnJs9+f53BX7VVTzjXXiHcVEjSf1zQSuDcRKJcLZ8T6t/T0EEF9F37xcLN/K
 EhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682413; x=1722287213;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHheaBbdivCBNrjkMc5BpEzF1l75/EsEBipNIOMuwxk=;
 b=X0eNALKY9Q2bmpZJPivoa7B0R3qJATAufjX/crlPOrkdUiDCs9l3LfzDzPHecSN5QZ
 1r0pgVa7uBABmAcYFVXKuV1cBbBUYE3lLw8cZ9RUC1ItUNpybtjh0slgZAtiHjciFmFm
 P0JDqQ1WDSx+nDVJZELRhUf+RW9h6+7KgKMs/hrGmhoUgmxYis6DEgR1jQoaOlNeHw4+
 H/qiAQtiljcCIf5GdwDhbn6/UjFGkvr+1sx4N/PyIXiewfHvR9rKFOIrIMrqLmMx/lh7
 2vU4c0OA49h4eo1flqWjLzukvpwPoq3b80FGICFzvoIvklbffKOlE8yg/d61PBNuE6aM
 njdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYk8ykIgxWTfjGImzc4OFURY7Q1TlnuhAKRzfxsvRtVUpAvt7Sp59SZ+OZ8qVOilBNI0nQ4w9fonVR7M+WwBuF2f+4oCE=
X-Gm-Message-State: AOJu0Yy+SdE3fg5wwdKFoC4d2w8oSKIjDm7M2EwY6fkF1kYMn8app7C5
 TPV44rPsmlCKWjrexBjh+l4sDDCUWDYOR++vfAPUrRj52Jc+BzRkgN72ZQ2fU2I=
X-Google-Smtp-Source: AGHT+IEIAl516jCeCNyPrk9/Fwk3RRpe479rs2ph73c4Hbr0+of3olrH1gi7fmbAAOY1sxWyfAECyw==
X-Received: by 2002:a05:6a20:a11f:b0:1c0:e1bf:4c23 with SMTP id
 adf61e73a8af0-1c4285d4640mr11228334637.20.1721682413175; 
 Mon, 22 Jul 2024 14:06:53 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf7c57a58sm7594707a91.23.2024.07.22.14.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:06:52 -0700 (PDT)
Message-ID: <c0eb2331-4242-4058-be43-ddded418eb2d@linaro.org>
Date: Mon, 22 Jul 2024 14:06:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] chardev/char-fe: Document returned value on error
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240722160745.67904-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gNy8yMi8yNCAwOTowNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IHFl
bXVfY2hyX2ZlX2FkZF93YXRjaCgpIGFuZCBxZW11X2Nocl9mZV93cml0ZVtfYWxsXSgpDQo+
IHJldHVybiAtMSBvbiBlcnJvci4gTWVudGlvbiBpdCBpbiB0aGUgZG9jdW1lbnRhdGlvbi4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
bGluYXJvLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IE1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2
ZS1heWxhbmRAaWxhbmRlLmNvLnVrPg0KPiAtLS0NCj4gICBpbmNsdWRlL2NoYXJkZXYvY2hh
ci1mZS5oIHwgMyArKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9jaGFyZGV2L2NoYXItZmUuaCBiL2luY2x1ZGUv
Y2hhcmRldi9jaGFyLWZlLmgNCj4gaW5kZXggZWNlZjE4MjgzNS4uMzMxMDQ0OWVhZiAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9jaGFyZGV2L2NoYXItZmUuaA0KPiArKysgYi9pbmNsdWRl
L2NoYXJkZXYvY2hhci1mZS5oDQo+IEBAIC0yMjgsNiArMjI4LDcgQEAgZ3VpbnQgcWVtdV9j
aHJfZmVfYWRkX3dhdGNoKENoYXJCYWNrZW5kICpiZSwgR0lPQ29uZGl0aW9uIGNvbmQsDQo+
ICAgICogaXMgdGhyZWFkLXNhZmUuDQo+ICAgICoNCj4gICAgKiBSZXR1cm5zOiB0aGUgbnVt
YmVyIG9mIGJ5dGVzIGNvbnN1bWVkICgwIGlmIG5vIGFzc29jaWF0ZWQgQ2hhcmRldikNCj4g
KyAqICAgICAgICAgIG9yIC0xIG9uIGVycm9yLg0KPiAgICAqLw0KPiAgIGludCBxZW11X2No
cl9mZV93cml0ZShDaGFyQmFja2VuZCAqYmUsIGNvbnN0IHVpbnQ4X3QgKmJ1ZiwgaW50IGxl
bik7DQo+ICAgDQo+IEBAIC0yNDIsNiArMjQzLDcgQEAgaW50IHFlbXVfY2hyX2ZlX3dyaXRl
KENoYXJCYWNrZW5kICpiZSwgY29uc3QgdWludDhfdCAqYnVmLCBpbnQgbGVuKTsNCj4gICAg
KiBhdHRlbXB0ZWQgdG8gYmUgd3JpdHRlbi4gIFRoaXMgZnVuY3Rpb24gaXMgdGhyZWFkLXNh
ZmUuDQo+ICAgICoNCj4gICAgKiBSZXR1cm5zOiB0aGUgbnVtYmVyIG9mIGJ5dGVzIGNvbnN1
bWVkICgwIGlmIG5vIGFzc29jaWF0ZWQgQ2hhcmRldikNCj4gKyAqICAgICAgICAgIG9yIC0x
IG9uIGVycm9yLg0KPiAgICAqLw0KPiAgIGludCBxZW11X2Nocl9mZV93cml0ZV9hbGwoQ2hh
ckJhY2tlbmQgKmJlLCBjb25zdCB1aW50OF90ICpidWYsIGludCBsZW4pOw0KPiAgIA0KPiBA
QCAtMjUzLDYgKzI1NSw3IEBAIGludCBxZW11X2Nocl9mZV93cml0ZV9hbGwoQ2hhckJhY2tl
bmQgKmJlLCBjb25zdCB1aW50OF90ICpidWYsIGludCBsZW4pOw0KPiAgICAqIFJlYWQgZGF0
YSB0byBhIGJ1ZmZlciBmcm9tIHRoZSBiYWNrIGVuZC4NCj4gICAgKg0KPiAgICAqIFJldHVy
bnM6IHRoZSBudW1iZXIgb2YgYnl0ZXMgcmVhZCAoMCBpZiBubyBhc3NvY2lhdGVkIENoYXJk
ZXYpDQo+ICsgKiAgICAgICAgICBvciAtMSBvbiBlcnJvci4NCj4gICAgKi8NCj4gICBpbnQg
cWVtdV9jaHJfZmVfcmVhZF9hbGwoQ2hhckJhY2tlbmQgKmJlLCB1aW50OF90ICpidWYsIGlu
dCBsZW4pOw0KPiAgIA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBsaW5hcm8ub3JnPg0K

