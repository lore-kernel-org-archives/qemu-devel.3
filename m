Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EA8C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0Ul-0007H0-2y; Tue, 25 Feb 2025 14:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tn0Ui-0007GS-LQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:21:28 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tn0Ue-0006RX-FR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:21:28 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22185cddbffso2178165ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740511282; x=1741116082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eckVBLLJxOYQBpO5EZPfo/bhWZyBeQE/3SQkjuNLR0E=;
 b=vcOzuosyMxmz/TgkX9gjuhKayPnJi+fc3iS8Ax4u8+4jpNFjlxY0PN21hsES1p9rZy
 IrC9ViSy4CcoLIEp/QXaXhk/wIEahRdfQeaC8kpZig08F7nOyYTk96OD2kwqW9PLsXga
 EjHJnADlAamhWff5xBwtz3Png3+TWcoaUEReBuG533MNIaaBQatjo1l6q1RyUvF4yZTL
 f27JfNjbXVJCNXEAeIn/yLcnavBm8EchErDFVKZCeZfYWshYcMOkXmUgfG/GdBlZ9EQ1
 b3N2qDmVLM3o7U3ZdAQrFXXblvV45bn5cE4GT4dUjkKYXWAJGNnGZvktKBsSrmN8QFP1
 RbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740511282; x=1741116082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eckVBLLJxOYQBpO5EZPfo/bhWZyBeQE/3SQkjuNLR0E=;
 b=HbTi91WUXUN/yTeEl/lZ/nbOQ84lJn9O6vVkB4B9fmiJKV3mpWIGvWJtcfpZFYMHW3
 DFCjjEwZMrDgBHBeeAfj2uWrQ7lXzTZxc9AMqhOlC8wD9zh61oTAKgSCQ3HPJu5Q73uW
 V9vqE6sLaA+9qTVBhSJ+gqKWQyPPgHgM4eRhhqJ+aBdcJRpVQw6Vz3hpgvSoljDUOYlE
 6YlhuqxkgLBn3zorVHQAKJ/0yByrWWCMFqxbr+Iz97lnUMWbBq+s6fIthRA518cR0RJN
 O4Gvj9raZ2cmEEDMwg2Si71TWC9QbdPzVsFttN+YPM9nnzof5JizRNy+fJnkmK6HvVrt
 SdJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuOaNSm6kri1YJ1CCVlpVrh76tO72saHye959/FLO6ZhAeYRJgujqj0A/uTrfR3xkMdaxiGIGpysVG@nongnu.org
X-Gm-Message-State: AOJu0YzKDl32Ab3LiHsEZXyiQZNiE5+bPc2yigdYc7MMKbiHNLHpHlDC
 tN45zSdrv3mOzPxRC72v51Yn0kQwf5kdL/b+/ahA73pn8L+ec3vjzvaDs6GeGUk=
X-Gm-Gg: ASbGncv9TMYlSfa3gaDiMaeVLrGecOELNCp3CvHIPl0RWKNEOxv1AK3RNAcEng7KiYk
 1GQ0c3q9KrYeQOFNuiQs2LzZWKxKMaKKvs+1xsItgGCTD1sep8AZGzYnaMteDBg7jtR6U1saKfT
 HNOL43U0zbLSIIhVvUark9qoh6d7zXZiZ4pKAotesyIP3QK463VVfAz+q9lkn+RCZzfhglNwg68
 W0qeTzM6tUiGyUiqxd2j0agvqhpGu7dIEOKBHluMVVk40mZ8G/Jxk/iDISYArZYaJFcqCyOgNY9
 3xiPoO79OqC1fWjT8zM5oNRqcjXX/Ax8RjpCcus=
X-Google-Smtp-Source: AGHT+IEhS3qF+14z0mDsnZ+Jsy1GbgxYVl+Q+BFSy+uTiwlmXjp+ZkbsLUA3gLQ8rYsY+YtGaCNGSg==
X-Received: by 2002:a05:6a20:2d14:b0:1e1:a449:ff71 with SMTP id
 adf61e73a8af0-1eef3c5d155mr32476336637.1.1740511280633; 
 Tue, 25 Feb 2025 11:21:20 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aedaa6429a4sm1479327a12.52.2025.02.25.11.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 11:21:20 -0800 (PST)
Message-ID: <1555e5f6-080f-4e2d-a5ba-e35cad22bd61@linaro.org>
Date: Tue, 25 Feb 2025 11:21:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] plugins: reduce total number of build objects
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

SGkgQWxleCwNCg0KT24gMi8yNS8yNSAwMzowOCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBB
cyB3ZSBtb3ZlIHRvd2FyZHMgYSBtb3JlIG1vZHVsYXIgYnVpbGQgdGhpcyBzZXJpZXMgY29u
dmVydHMgYm90aA0KPiBsb2FkZXIgYW5kIGFwaSB0byBidWlsZCBvbmNlIG9iamVjdHMuIEZv
ciBib3RoIG9iamVjdHMgdGhlIG9ubHkgcmVhbA0KPiBkaWZmZXJlbmNlIGlzIGJldHdlZW4g
dXNlciBtb2RlIGFuZCBzeXN0ZW0gZW11bGF0aW9uIHNvIHRob3NlIGJpdHMNCj4gaGF2ZSBi
ZWVuIGhpdmVkIG9mZiBpbnRvIHRob3NlIHNvdXJjZSBzZXRzLg0KPiANCj4gVGhlIHJlbWFp
bmluZyBjb3JlIHBsdWdpbiBpcyBtb3JlIGludGltYXRlbHkgYWxpZ25lZCB3aXRoIHRoZSBU
Q0cNCj4gYmFja2VuZCBzbyByZXF1aXJlcyBkZWZpbml0aW9ucyBsaWtlIFRDR19UQVJHRVRf
TE9ORy4gSG9wZWZ1bGx5IHRoaXMNCj4gY2FuIGJlZW4gY2xlYW5lZCB1cCBvbmNlIFJpY2hh
cmRzIFRDRyByYXRpb25hbGlzYXRpb24gY29kZSBpcyBhZGRlZC4NCj4gDQo+IFBsZWFzZSBy
ZXZpZXcuDQo+IA0KPiBBbGV4Lg0KPiANCj4gQWxleCBCZW5uw6llICgxMCk6DQo+ICAgIHBs
dWdpbnMvYXBpOiB1c2UgdGNnX2N0eCB0byBnZXQgVEFSR0VUX1BBR0VfTUFTSw0KPiAgICBw
bHVnaW5zL2xvYWRlcjogcG9wdWxhdGUgdGFyZ2V0X25hbWUgd2l0aCB0YXJnZXRfbmFtZSgp
DQo+ICAgIGluY2x1ZGUvcWVtdTogcGx1Z2luLW1lbW9yeS5oIGRvZXNuJ3QgbmVlZCBjcHUt
ZGVmcy5oDQo+ICAgIHBsdWdpbnMvYXBpOiBjbGVhbi11cCB0aGUgaW5jbHVkZXMNCj4gICAg
cGx1Z2lucy9wbHVnaW4uaDogaW5jbHVkZSBxdWV1ZS5oDQo+ICAgIHBsdWdpbnMvbG9hZGVy
OiBjb21waWxlIGxvYWRlciBvbmx5IG9uY2UNCj4gICAgcGx1Z2lucy9hcGk6IHNwbGl0IG91
dCBiaW5hcnkgcGF0aC9zdGFydC9lbmQvZW50cnkgY29kZQ0KPiAgICBwbHVnaW5zL2FwaTog
c3BsaXQgb3V0IHRoZSB2YWRkci9od2FkZHIgaGVscGVycw0KPiAgICBwbHVnaW5zL2FwaTog
c3BsaXQgb3V0IHRpbWUgY29udHJvbCBoZWxwZXJzDQo+ICAgIHBsdWdpbnMvYXBpOiBidWls
ZCBvbmx5IG9uY2UNCj4gDQoNCmZvciBhbGwgdGhlIHNlcmllczoNClJldmlld2VkLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCkFkZGl0
aW9ubmFsbHksIEkgd291bGQgc3VnZ2VzdCB0byBnbyBmdXJ0aGVyIGFuZCBtZXJnZSBmdW5j
dGlvbnMgZm9yIA0Kc3lzdGVtIGFuZCB1c2VyIG1vZGUsIGJ5IGNoZWNraW5nIGF0IHJ1bnRp
bWUgd2hhdCBpcyB0aGUgbW9kZSwgYnkgDQppbnRyb2R1Y2luZyBhIGhlbHBlciBmdW5jdGlv
biBmb3IgdGhhdC4gVGhpcyB3YXksIGFsbCBmaWxlcyBjYW4gYmUgDQpyZWFsbHkgbGlua2Vk
IHRvZ2V0aGVyLCB3aXRob3V0IGhhdmluZyB0byBzZWxlY3QgYSBkaWZmZXJlbnQgc2V0IG9m
IA0Kc291cmNlcyBkZXBlbmRpbmcgb24gd2hpY2ggYmluYXJ5IGlzIGJ1aWx0Lg0KDQpSZWdh
cmRzLA0KUGllcnJpY2sNCg0KPiAgIGluY2x1ZGUvcWVtdS9wbHVnaW4tbWVtb3J5LmggfCAg
IDEgLQ0KPiAgIHBsdWdpbnMvcGx1Z2luLmggICAgICAgICAgICAgfCAgIDcgKysNCj4gICBs
aW51eC11c2VyL3BsdWdpbi1hcGkuYyAgICAgIHwgIDQzICsrKysrKysrKw0KPiAgIHBsdWdp
bnMvYXBpLXN5c3RlbS5jICAgICAgICAgfCAxMzEgKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAgcGx1Z2lucy9hcGktdXNlci5jICAgICAgICAgICB8ICA1NyArKysrKysrKysr
KysNCj4gICBwbHVnaW5zL2FwaS5jICAgICAgICAgICAgICAgIHwgMTcwICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgcGx1Z2lucy9sb2FkZXIuYyAgICAgICAg
ICAgICB8ICAxNSArLS0tDQo+ICAgcGx1Z2lucy9zeXN0ZW0uYyAgICAgICAgICAgICB8ICAy
NCArKysrKw0KPiAgIHBsdWdpbnMvdXNlci5jICAgICAgICAgICAgICAgfCAgMTkgKysrKw0K
PiAgIGxpbnV4LXVzZXIvbWVzb24uYnVpbGQgICAgICAgfCAgIDEgKw0KPiAgIHBsdWdpbnMv
bWVzb24uYnVpbGQgICAgICAgICAgfCAgIDggKy0NCj4gICAxMSBmaWxlcyBjaGFuZ2VkLCAy
OTIgaW5zZXJ0aW9ucygrKSwgMTg0IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBsaW51eC11c2VyL3BsdWdpbi1hcGkuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBw
bHVnaW5zL2FwaS1zeXN0ZW0uYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBwbHVnaW5zL2Fw
aS11c2VyLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgcGx1Z2lucy9zeXN0ZW0uYw0KPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBwbHVnaW5zL3VzZXIuYw0KPiANCg0K

