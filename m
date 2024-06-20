Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E7EC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMhl-0003Nw-Ex; Thu, 20 Jun 2024 14:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sKMhi-0003N8-SC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:40:15 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sKMhd-0004VG-8B
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:40:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-701b0b0be38so1131703b3a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718908803; x=1719513603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t7ugR8LyJ4yhjJE6jRVvqgPt4wBlmHq1ns/6Tho+3ic=;
 b=xm+U9GCVa7b/XgD77mWtwsvmTuqowfi/HzGGp1exVclNwWPmJ83/rM/ZvBj+08CdQe
 ud40wgy7k+Nr34SMy4ymLPL2LxSgJIu++eomRYNnh6/IblP/lsJsMQvyTKDW2Y5HlUrr
 5Hi9+u7bdaVelSh1JtqVMpvcYblwhV/v+E2C5pkcyOXcaDoAEVyl2/oFOv4PX9cGMQTb
 vpFgKhX5jN79aPpr93RyjjCnvOAcdWm+Wns/uDGqxHQtBE2/NA3u2jVQPMp6zFCvHbh9
 sv2oUWoh63KQnxprzYXklmQk1Gx+8p3zwRhEPVbUFJB5h1mL3edeb8HLhToy8JvVAlL9
 Samg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718908803; x=1719513603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t7ugR8LyJ4yhjJE6jRVvqgPt4wBlmHq1ns/6Tho+3ic=;
 b=OgS7pHUKveFvkJjJmWcrr+ZF6TgnEstIDxTWHa1dcZZYsaCH8YrnpXA0apv2sAGS8t
 Qq4r6DXze4tVaePY9dsEsIFJqzw2eqXdCPdAmS62ka7k0/SWC7uguHhbM9+kC/Qv3zwf
 8JcI25YQWtYZzx6f41ZsPDGlV9RcxthiwmsougOlUWbkNIq3XnlCVZqEm0ND+rDYWt4L
 L6qZg/SYdPx7/Lxb/dUjTVUIH7SAaH/YEuUOWS5U9dScGQwxF1nQUWD5RplOd6he3UeD
 OpgJ4p+gqShdUjTUtnYQLy15TE3OzKS9DacTWTFCyIsTK5C/6dWiDX3PvSusHPGMS/GN
 f7ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtxXsJEWqatJBmErhS2PC8NA6IlslEf3RgoPtl3xouGUjF3ZfP1u46PpGDzon/KxNyp4lauk92gMPQmHc01cMpWH9DZko=
X-Gm-Message-State: AOJu0YyvkbWq3Umxk2emrIXpD6J1dbZ+RwqYtLSmrh8FZitGcgmg+gog
 P6Xi9ORzOsUmK9iR2uoiYlsw/k2U9BOpGodyo8otkFslN1iVBwy/stqT/7Euy4M=
X-Google-Smtp-Source: AGHT+IH9ViMIWfbt0h1UCKQ/eJd8MvZzPCQ22Cxn984MQSLtU3vwcXljPn1bCtC/O7uwoBqYxsye6Q==
X-Received: by 2002:a05:6a20:b202:b0:1b8:6ed5:a70 with SMTP id
 adf61e73a8af0-1bcbb5d5116mr6437613637.49.1718908802848; 
 Thu, 20 Jun 2024 11:40:02 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70649012058sm939903b3a.35.2024.06.20.11.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 11:40:02 -0700 (PDT)
Message-ID: <59ef28a2-7a29-4214-893c-67d27bea8377@linaro.org>
Date: Thu, 20 Jun 2024 11:40:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] accel/tcg: Avoid unnecessary call overhead from
 qemu_plugin_vcpu_mem_cb
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>, Mark Burton
 <mburton@qti.qualcomm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Chou <max.chou@sifive.com>, Frank Chang <frank.chang@sifive.com>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
 <20240620152220.2192768-13-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240620152220.2192768-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

T24gNi8yMC8yNCAwODoyMiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBGcm9tOiBNYXggQ2hv
dSA8bWF4LmNob3VAc2lmaXZlLmNvbT4NCj4gDQo+IElmIHRoZXJlIGFyZSBub3QgYW55IFFF
TVUgcGx1Z2luIG1lbW9yeSBjYWxsYmFjayBmdW5jdGlvbnMsIGNoZWNraW5nDQo+IGJlZm9y
ZSBjYWxsaW5nIHRoZSBxZW11X3BsdWdpbl92Y3B1X21lbV9jYiBmdW5jdGlvbiBjYW4gcmVk
dWNlIHRoZQ0KPiBmdW5jdGlvbiBjYWxsIG92ZXJoZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTWF4IENob3UgPG1heC5jaG91QHNpZml2ZS5jb20+DQo+IFJldmlld2VkLWJ5OiBSaWNo
YXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4gUmV2aWV3
ZWQtYnk6IEZyYW5rIENoYW5nIDxmcmFuay5jaGFuZ0BzaWZpdmUuY29tPg0KPiBNZXNzYWdl
LUlkOiA8MjAyNDA2MTMxNzUxMjIuMTI5OTIxMi0yLW1heC5jaG91QHNpZml2ZS5jb20+DQo+
IC0tLQ0KPiAgIGFjY2VsL3RjZy9sZHN0X2NvbW1vbi5jLmluYyB8IDggKysrKysrLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9sZHN0X2NvbW1vbi5jLmluYyBiL2FjY2VsL3Rj
Zy9sZHN0X2NvbW1vbi5jLmluYw0KPiBpbmRleCBjODIwNDhlMzc3Li44N2NlYjk1NDg3IDEw
MDY0NA0KPiAtLS0gYS9hY2NlbC90Y2cvbGRzdF9jb21tb24uYy5pbmMNCj4gKysrIGIvYWNj
ZWwvdGNnL2xkc3RfY29tbW9uLmMuaW5jDQo+IEBAIC0xMjUsNyArMTI1LDkgQEAgdm9pZCBo
ZWxwZXJfc3RfaTEyOChDUFVBcmNoU3RhdGUgKmVudiwgdWludDY0X3QgYWRkciwgSW50MTI4
IHZhbCwgTWVtT3BJZHggb2kpDQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgcGx1Z2luX2xvYWRf
Y2IoQ1BVQXJjaFN0YXRlICplbnYsIGFiaV9wdHIgYWRkciwgTWVtT3BJZHggb2kpDQo+ICAg
ew0KPiAtICAgIHFlbXVfcGx1Z2luX3ZjcHVfbWVtX2NiKGVudl9jcHUoZW52KSwgYWRkciwg
b2ksIFFFTVVfUExVR0lOX01FTV9SKTsNCj4gKyAgICBpZiAoY3B1X3BsdWdpbl9tZW1fY2Jz
X2VuYWJsZWQoZW52X2NwdShlbnYpKSkgew0KPiArICAgICAgICBxZW11X3BsdWdpbl92Y3B1
X21lbV9jYihlbnZfY3B1KGVudiksIGFkZHIsIG9pLCBRRU1VX1BMVUdJTl9NRU1fUik7DQo+
ICsgICAgfQ0KPiAgIH0NCj4gICANCj4gICB1aW50OF90IGNwdV9sZGJfbW11KENQVUFyY2hT
dGF0ZSAqZW52LCBhYmlfcHRyIGFkZHIsIE1lbU9wSWR4IG9pLCB1aW50cHRyX3QgcmEpDQo+
IEBAIC0xODgsNyArMTkwLDkgQEAgSW50MTI4IGNwdV9sZDE2X21tdShDUFVBcmNoU3RhdGUg
KmVudiwgYWJpX3B0ciBhZGRyLA0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIHBsdWdpbl9zdG9y
ZV9jYihDUFVBcmNoU3RhdGUgKmVudiwgYWJpX3B0ciBhZGRyLCBNZW1PcElkeCBvaSkNCj4g
ICB7DQo+IC0gICAgcWVtdV9wbHVnaW5fdmNwdV9tZW1fY2IoZW52X2NwdShlbnYpLCBhZGRy
LCBvaSwgUUVNVV9QTFVHSU5fTUVNX1cpOw0KPiArICAgIGlmIChjcHVfcGx1Z2luX21lbV9j
YnNfZW5hYmxlZChlbnZfY3B1KGVudikpKSB7DQo+ICsgICAgICAgIHFlbXVfcGx1Z2luX3Zj
cHVfbWVtX2NiKGVudl9jcHUoZW52KSwgYWRkciwgb2ksIFFFTVVfUExVR0lOX01FTV9XKTsN
Cj4gKyAgICB9DQo+ICAgfQ0KPiAgIA0KPiAgIHZvaWQgY3B1X3N0Yl9tbXUoQ1BVQXJjaFN0
YXRlICplbnYsIGFiaV9wdHIgYWRkciwgdWludDhfdCB2YWwsDQoNCllvdSBtaWdodCB3YW50
IHRvIGFkZCB0aGUgc2FtZSB0aGluZyBpbjogYWNjZWwvdGNnL2F0b21pY19jb21tb24uYy5p
bmMNCg0KUGllcnJpY2sNCg==

