Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0DECCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stViz-0005vd-PZ; Wed, 25 Sep 2024 13:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stVix-0005o2-UT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:22:47 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stViw-00027S-0I
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:22:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-208e0a021cfso439275ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284964; x=1727889764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1cBi18DJbLbtKnO15ZDzgQjdA4tmaG19Gb/9h4A0AB8=;
 b=w8yuMbAlkekcJo1BOgBSS24uZ8uEq8dZOQVYJp+XHIEliThHqw0A2aeYo/qvq5XaIK
 D2G02VbjYyYzJLZthgA96GlfifrgZoIpweaG5AGueS6g8lpcvgp8gMSQEyHsu7K3hDM1
 UNu/RPwYF3qpmq3p4hIA8VqHdYdVFoQpjDJSwe6RBoS6Sks6XPM6X9Ri5dsZxXu09H9l
 jof+/Z7jrxO7jW0r4DOieAG1ksggzHPOqAYx0Ow5d0dN5lvIdSehWMA72/7jpuAucAcx
 RmCeNB2xszifBONZTADjkLCTNa1XOHEiPKQ1wGmSSRSfhefnpfXrO3+7H4kirs0WtN7y
 WAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284964; x=1727889764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1cBi18DJbLbtKnO15ZDzgQjdA4tmaG19Gb/9h4A0AB8=;
 b=XROZX0Oep9VyP/z30wwOLphfeDpAmBmJrI2f+x2E/B+zQL3WkelncC992k40k1tx6x
 yJsmyoR5q0wMQMeXpH8iZ9I2SfhJsPv40HrqK5QXHS+hW25dxlZ2yi3l3MuanA5exFgs
 yB2dzYNZKmz8WFk2jbsdlo3RCEjdxp9Vbp+o0ffUtql9q1WYfuFXWBUKpmAfYpwGkgPV
 wsbOrtzARQ4YHHfjPBiNo20OPR9HN1+i4cxBxiHKp8Dd6vLDlmSy57bo/2AVx+IXFTZX
 a967XJ4Rmy05w32CiRPbs2vDnwdS3jnlNUWItEx0EX9keBH5rtnFM2kXx8RCFPCkpdBt
 GdqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8iPpOdAPbF07/XUZ+yFO4oZvhr4NsGQ6QEsr4wYZq6cXXpnNX7FTM2YG9YQy5nt6UZoJU25otOY92@nongnu.org
X-Gm-Message-State: AOJu0Yyki2T05gT9P1Wisr1RIvxWih61dwEIjanTQNqU+gM27jFNULG5
 53oLouYWlK/OL6rmA4KNlmMdPF7SX1GAMms+BO065ABh7+UjKcQdGJYyze/1iF4=
X-Google-Smtp-Source: AGHT+IFpe3nBv2xJLPF27RAmV8/+xF723E+vmLXeSWgrX+X++h/lNUxM193xpCw5M0gVTtLxg2Bxwg==
X-Received: by 2002:a17:902:d2c9:b0:206:928c:bfda with SMTP id
 d9443c01a7336-20afc61cfaamr50046935ad.56.1727284963959; 
 Wed, 25 Sep 2024 10:22:43 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20afb021af7sm15136465ad.168.2024.09.25.10.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 10:22:43 -0700 (PDT)
Message-ID: <de455384-7929-45df-84fa-7e09c0e86043@linaro.org>
Date: Wed, 25 Sep 2024 10:22:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] maintainer updates (testing, gdbstub)
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, kvm@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>
References: <20240925171140.1307033-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240925171140.1307033-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

T24gOS8yNS8yNCAxMDoxMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBXZWxjb21lIHRvIHRo
ZSBmaXJzdCBwb3N0IEtWTSBmb3J1bSBzZXJpZXMuIFdlIGhhdmU6DQo+IA0KPiAgICAtIGZp
eCBmcm9tIElseWEgZm9yIG1pY3JvYmxhemUgYXRvbWljcw0KPiAgICAtIFBpZXJyaWNrJ3Mg
dHNhbiB1cGRhdGVzDQo+ICAgIC0gSSd2ZSBhZGRlZCBteSB0ZXN0aW5nIGFuZCBnZGJzdHVi
IHRyZWVzIHRvIE1BSU5UQUlORVJTDQo+ICAgIC0gZW5hYmxlZCBhIHZlcnkgYmFzaWMgYWFy
Y2g2NF9iZS1saW51eC11c2VyIHRlc3QNCj4gICAgLSBmaXhlZCB0aGUgbWlzc2luZyBnZGIg
WE1MIGZhaWxzIHRoYXQgY2F1c2UgYWFyY2g2NF9iZS1saW51eC11c2VyIHRvIGFzc2VydA0K
PiAgICAtIGZpbmFsbHkgSSd2ZSBtYWRlIHRoZSBtaXBzNjRlbCBjcm9zcyBjb21waWxlciBi
b29rd29ybSBhbmQgYWxsb3dfZmFpbA0KPiANCj4gQWxleCBCZW5uw6llICg2KToNCj4gICAg
dGVzdGluZzogYnVtcCBtaXBzNjRlbCBjcm9zcyB0byBib29rd29ybSBhbmQgYWxsb3cgdG8g
ZmFpbA0KPiAgICB0ZXN0cy9kb2NrZXI6IGFkZCBOT0ZFVENIIGVudiB2YXJpYWJsZSBmb3Ig
dGVzdGluZw0KPiAgICBNQUlOVEFJTkVSUzogbWVudGlvbiBteSB0ZXN0aW5nL25leHQgdHJl
ZQ0KPiAgICBNQUlOVEFJTkVSUzogbWVudGlvbiBteSBnZGJzdHViL25leHQgdHJlZQ0KPiAg
ICBjb25maWcvdGFyZ2V0czogdXBkYXRlIGFhcmNoNjRfYmUtbGludXgtdXNlciBnZGIgWE1M
IGxpc3QNCj4gICAgdGVzdHMvdGNnOiBlbmFibGUgYmFzaWMgdGVzdGluZyBmb3IgYWFyY2g2
NF9iZS1saW51eC11c2VyDQo+IA0KPiBJbHlhIExlb3Noa2V2aWNoICgxKToNCj4gICAgdGVz
dHMvZG9ja2VyOiBGaXggbWljcm9ibGF6ZSBhdG9taWNzDQo+IA0KPiBQaWVycmljayBCb3V2
aWVyICgzKToNCj4gICAgbWVzb246IGhpZGUgdHNhbiByZWxhdGVkIHdhcm5pbmdzDQo+ICAg
IHRhcmdldC9pMzg2OiBmaXggYnVpbGQgd2FybmluZyAoZ2NjLTEyIC1mc2FuaXRpemU9dGhy
ZWFkKQ0KPiAgICBkb2NzL2RldmVsOiB1cGRhdGUgdHNhbiBidWlsZCBkb2N1bWVudGF0aW9u
DQo+IA0KPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyICsrDQo+ICAgZG9jcy9kZXZlbC90ZXN0aW5nL21haW4ucnN0ICAgICAgICAgICAg
ICAgICAgIHwgMjYgKysrKysrKysrKystLS0NCj4gICBjb25maWd1cmUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgNSArKysNCj4gICBjb25maWdzL3RhcmdldHMv
YWFyY2g2NF9iZS1saW51eC11c2VyLm1hayAgICAgfCAgMiArLQ0KPiAgIG1lc29uLmJ1aWxk
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEwICsrKysrLQ0KPiAgIHRh
cmdldC9pMzg2L2t2bS9rdm0uYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICstLQ0K
PiAgIHRlc3RzL3RjZy9hYXJjaDY0X2JlL2hlbGxvLmMgICAgICAgICAgICAgICAgICB8IDM1
ICsrKysrKysrKysrKysrKysrKysNCj4gICAuZ2l0bGFiLWNpLmQvY29udGFpbmVyLWNyb3Nz
LnltbCAgICAgICAgICAgICAgfCAgMyArKw0KPiAgIHRlc3RzL2RvY2tlci9NYWtlZmlsZS5p
bmNsdWRlICAgICAgICAgICAgICAgICB8ICA1ICstLQ0KPiAgIC4uLi9idWlsZC10b29sY2hh
aW4uc2ggICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKysrDQo+ICAgLi4uL2RvY2tl
cmZpbGVzL2RlYmlhbi1taXBzNjRlbC1jcm9zcy5kb2NrZXIgIHwgMTAgKysrLS0tDQo+ICAg
Li4uL2RvY2tlcmZpbGVzL2RlYmlhbi10b29sY2hhaW4uZG9ja2VyICAgICAgIHwgIDcgKysr
Kw0KPiAgIHRlc3RzL2xjaXRvb2wvcmVmcmVzaCAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAyICstDQo+ICAgdGVzdHMvdGNnL01ha2VmaWxlLnRhcmdldCAgICAgICAgICAgICAgICAg
ICAgIHwgIDcgKysrLQ0KPiAgIHRlc3RzL3RjZy9hYXJjaDY0X2JlL01ha2VmaWxlLnRhcmdl
dCAgICAgICAgICB8IDE3ICsrKysrKysrKw0KPiAgIDE1IGZpbGVzIGNoYW5nZWQsIDEyNSBp
bnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdHMvdGNnL2FhcmNoNjRfYmUvaGVsbG8uYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0cy90Y2cvYWFyY2g2NF9iZS9NYWtlZmlsZS50YXJnZXQNCj4gDQoNClRoYW5rcyBmb3Ig
cHVsbGluZyB0c2FuIGNoYW5nZXMgYXMgcGFydCBvZiB0aGlzIHNlcmllcy4NCg==

