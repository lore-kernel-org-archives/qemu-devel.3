Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CFFC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TyZ-0003XB-U5; Thu, 17 Apr 2025 14:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5TyV-0003SF-Jz
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:28:36 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5TyS-0006l2-Ed
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:28:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224191d92e4so14552225ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744914509; x=1745519309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZVcXrtZT02pJwqzz+JNp3ideFbZg4voWp8UCH0aLd40=;
 b=rvhzsgWF684/me6Xl9Y2cMMMedYpFJYQ4Hsw/opx4OybUbU/C2ClJRSr+HS4soGRAc
 c8hhiz0GrFPSMpXmCxiATq5rLTjSpcdrwCCVQWdhLKqvR4YouVeYo/gxTqLuXCa8JHq4
 mhh5APLgEz9dw4ZMdHURAe3iXiWbm0AA2QVB5AGS8uj9q9qxFpK+s9QqIU1gu3QW9b79
 PH1Jmztes8xWkk9p4l42VTADqjprk5Patqd75g6agV61c8s4+z/GOP5IZ1LZwyCkM0og
 XyeqnZqJSJc6vCmpRTC7g40qDUuhAkkbUT9ZRv/PK0petuDBpqRFbsd0k3VQaG4jZdv7
 KdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744914509; x=1745519309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVcXrtZT02pJwqzz+JNp3ideFbZg4voWp8UCH0aLd40=;
 b=k1jeVBB3r7AucqkiZ3Jad109hLd8hG3NytwrFrTRyqAcNvnmAOpBAyG8uKPMbyapv+
 91BFAd5yKxkJ2THJnrqARwHGgBV/p1odlfo5rODdEEzn9TZGZ3mUsqg78Myrmt1lQiHp
 S2BRQkBk9r7COJQ95jdLLgnKDzrXVfzEhD0+9K4U8ZZ4TUQeU0jltqXGh/Xj1PXdRy8v
 yuQcqyjgXnNI4Exs+SWP9VetHN0oCC0a1khaYZ5eLmVZvPgxceItXCr1ob/2ty2D4RAu
 YzpYvMkYEzvUGmwJFXnO7peKE6/WjXDHuTyBcr9DxmrAmI7tzSOEhp04d/qBH6e9IpCO
 n16w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEbJ8JzB3ORxQrSBZIcyAfYgw54i2mL4F5kR6G82kvsJ4NLfvGaYLmdCH8ETHGi8ohu4vePHuoj6NC@nongnu.org
X-Gm-Message-State: AOJu0Ywa1d72s+GAsRAQcgZViTyas1DmpBisu3QK/fsLwr55hisBw12A
 g3zTcNAcx+KqC68voVuSmk7xLO4L8fSafVfIsh7nHpA0p0N3PoPXLmtMnp4Pdj7q223LztbUZ32
 D
X-Gm-Gg: ASbGnctnPnqTFWH1o+uV4buxKa1u6lUJXHf5g73k5NtSbNpFmnoUAsAg9IDFW0mi5IX
 MiLxPs3urUUB+Vhit+raS9jkxL3Z+PVWSBAJ06TdzBXFMOWta6IwMzpKsyXJBJoDWziZUm5f9a8
 J3UdiFSeL2M31ZkJRl4Ttp657TSqjdPI6i40mAXHIX/MxsYEO8WinjPnck5eL0W2Od0xG9KJueI
 RAO2p3/ISfRYNtIfWDAoEUiCH41TFMEh3jvt2YCgl7qDiopJLqtgb1iDk5Gfl+S3zBaW4G1DH5w
 Np/3yqglxEnyX+BCji2S9k+jzrVjSfYQgiUaA8GsnJrDMKeksvSDdw==
X-Google-Smtp-Source: AGHT+IGN2v242tOA3H/0wpqu04cLQW0x+WIX8O6cfuvimruQJXqNfTqS6i4KXPQCmPWY6AVS4FfrKA==
X-Received: by 2002:a17:903:98f:b0:224:f12:3746 with SMTP id
 d9443c01a7336-22c535aca10mr87285ad.30.1744914509307; 
 Thu, 17 Apr 2025 11:28:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fda18esm3053195ad.212.2025.04.17.11.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 11:28:28 -0700 (PDT)
Message-ID: <84eaddaa-ad02-4cf9-be3d-3d8da7a2d312@linaro.org>
Date: Thu, 17 Apr 2025 11:28:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250417165430.58213-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

TWF5YmUgaXQgd291bGQgYmUgcHJlZmVyYWJsZSB0byBmb2N1cyBvbiBwcm92aWRpbmcgYSBt
aW5pbWFsIGJ1dCANCipjb21wbGV0ZSogVGFyZ2V0SW5mbyBiZWZvcmUgdXBzdHJlYW1pbmcg
YW55IG9mIHRoaXMsIGFzIGl0J3MgcmVhbGx5IA0KYmxvY2tpbmcgdGhlIHJlc3Qgb2YgdGhl
IHdvcmsgZm9yIHNpbmdsZSBiaW5hcnkuDQoNCk1pbmltYWwgcmVxdWlyZW1lbnRzIHRvIGhh
dmUgYSBjb21wbGV0ZSBzZXJpZXMgd291bGQgYmU6DQotIFJlbmFtZSBRTVAgVGFyZ2V0SW5m
byBzdHJ1Y3QgdG8gdXNlIHRoYXQgbmFtZQ0KLSBCZSBhYmxlIHRvIHF1ZXJ5IHRhcmdldCBj
cHUgdHlwZSAod2hhdCB0aGlzIHNlcmllcyBkb2VzKQ0KLSBCZSBhYmxlIHRvIHF1ZXJ5IG1h
Y2hpbmUgY3B1IHR5cGUNCi0gTW9kaWZ5IGdlbmVyaWMgZnVuY3Rpb25zIGxpc3RpbmcgbWFj
aGluZXMvY3B1cyB0byB0YWtlIHRoaXMgaW50byBhY2NvdW50DQotIFRhZyBsYWJlbGVkIGJv
YXJkcy9jcHUgaW4gaHcvYXJtIHRvIHByb3ZlIHRoaXMgaXMgd29ya2luZyAod2l0aG91dCAN
CmRvaW5nIGFueSBvdGhlciBjbGVhbnVwIHRvIHRob3NlIGZpbGVzIGFuZCAqbm90KiBtYWtl
IHRoZW0gY29tbW9uKQ0KLSBObyBvdGhlciBhZGRpdGlvbmFsIHRhcmdldCBpbmZvcm1hdGlv
biBmb3IgdGhlIHYxLCBsZXQncyBrZWVwIHRoYXQgZm9yIA0KbGF0ZXIuDQoNCk5vdGU6IHRh
cmdldF9jcHVfdHlwZSB3aWxsIG5vdCBiZSBUWVBFX0FSTV9DUFUsIGFzIGl0IHdyb25nbHkg
d3JhcHMgDQphcm0zMiBhbmQgYWFyY2g2NCBjcHVzLCB3aGlsZSBpdCBzaG91bGQgY29ycmVj
dGx5IGlkZW50aWZ5IG9uZSBvciB0aGUgDQpvdGhlci4gSSBzdWdnZXN0ZWQgVFlQRV9UQVJH
RVRfQ1BVX0FSTSwgVFlQRV9UQVJHRVRfQ1BVX0FBUkNINjQsIGFuZCANCnNhbWUgZm9yIG1h
Y2hpbmVzOiBUWVBFX1RBUkdFVF9NQUNISU5FX0FSTSwgVFlQRV9UQVJHRVRfTUFDSElORV9B
QVJDSDY0Lg0KU28gd2UgY2FuIHJldXNlIHRoaXMgbmFtaW5nIGNvbnZlbnRpb24gd2l0aCBh
bnkgb3RoZXIgdGFyZ2V0IHdlJ2xsIHJldXNlIA0KaW4gdGhlIGZ1dHVyZS4NCg0KUGllcnJp
Y2sNCg0KT24gNC8xNy8yNSAwOTo1NCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6
DQo+IChTZXJpZXMgZnVsbHkgcmV2aWV3ZWQsIEkgcGxhbiB0byBxdWV1ZSBpdCB2aWEgbXkg
dHJlZSkNCj4gDQo+IFRoaXMgc2VyaWVzIHJlcGxhY2UgdGhlIHRhcmdldC1zcGVjaWZpYyBD
UFVfUkVTT0xWSU5HX1RZUEUNCj4gYnkgY2FsbHMgdG8gdGhlIHRhcmdldC1hZ25vc3RpYyB0
YXJnZXRfY3B1X3R5cGUoKSBtZXRob2QuDQo+IA0KPiBTaW5jZSBSRkN2MToNCj4gLSBTcGxp
dCBmcm9tIGJpZ2dlci91bnJlbGF0ZWQgVGFyZ2V0SW5mbyBzZXJpZXMgKFBpZXJyaWNrKQ0K
PiAtIEFkZGVkIFBpZXJyaWNrIFItYiB0YWdzDQo+IC0gQWRkZWQgY29tbWl0IGRlc2NyaXB0
aW9ucw0KPiANCj4gUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgKDcpOg0KPiAgICBxZW11OiBJ
bnRyb2R1Y2UgdGFyZ2V0X2NwdV90eXBlKCkNCj4gICAgY3B1czogUmVwbGFjZSBDUFVfUkVT
T0xWSU5HX1RZUEUgLT4gdGFyZ2V0X2NwdV90eXBlKCkNCj4gICAgY3B1czogTW92ZSB0YXJn
ZXQtYWdub3N0aWMgbWV0aG9kcyBvdXQgb2YgY3B1LXRhcmdldC5jDQo+ICAgIGFjY2VsOiBJ
bXBsZW1lbnQgYWNjZWxfaW5pdF9vcHNfaW50ZXJmYWNlcygpIGZvciBib3RoIHN5c3RlbS91
c2VyIG1vZGUNCj4gICAgYWNjZWw6IEluY2x1ZGUgbWlzc2luZyAncWVtdS9hY2NlbC5oJyBo
ZWFkZXIgaW4gYWNjZWwtaW50ZXJuYWwuaA0KPiAgICBhY2NlbDogTWFrZSBBY2NlbENQVUNs
YXNzIHN0cnVjdHVyZSB0YXJnZXQtYWdub3N0aWMNCj4gICAgYWNjZWw6IE1vdmUgdGFyZ2V0
LWFnbm9zdGljIGNvZGUgZnJvbSBhY2NlbC10YXJnZXQuYyAtPiBhY2NlbC1jb21tb24uYw0K
PiANCj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDQgKy0NCj4gICBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDIgKw0KPiAgIGFjY2VsL3thY2NlbC1zeXN0ZW0uaCA9PiBhY2NlbC1pbnRlcm5hbC5o
fSB8ICAxMCArLQ0KPiAgIGluY2x1ZGUvYWNjZWwvYWNjZWwtY3B1LXRhcmdldC5oICAgICAg
ICAgICB8ICAxMiArLQ0KPiAgIGluY2x1ZGUvYWNjZWwvYWNjZWwtY3B1LmggICAgICAgICAg
ICAgICAgICB8ICAyMyArKysrDQo+ICAgaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLmggICAg
ICAgICAgICAgICAgIHwgIDE5ICsrKw0KPiAgIGFjY2VsL2FjY2VsLWNvbW1vbi5jICAgICAg
ICAgICAgICAgICAgICAgICB8IDE0MiArKysrKysrKysrKysrKysrKysrKysNCj4gICBhY2Nl
bC9hY2NlbC1zeXN0ZW0uYyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gICBh
Y2NlbC9hY2NlbC10YXJnZXQuYyAgICAgICAgICAgICAgICAgICAgICAgfCAxMzQgLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgIGFjY2VsL2FjY2VsLXVzZXIuYyAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgNiArDQo+ICAgYWNjZWwvdGNnL3RjZy1hbGwuYyAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA1ICstDQo+ICAgY3B1LXRhcmdldC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDc2ICstLS0tLS0tLS0tDQo+ICAgaHcvY29yZS9jcHUtY29tbW9u
LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDc0ICsrKysrKysrKysrDQo+ICAgdGFyZ2V0
X2luZm8tZGVmcy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICsrKw0KPiAgIGFj
Y2VsL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAg
MTUgZmlsZXMgY2hhbmdlZCwgMjk5IGluc2VydGlvbnMoKyksIDIyOSBkZWxldGlvbnMoLSkN
Cj4gICByZW5hbWUgYWNjZWwve2FjY2VsLXN5c3RlbS5oID0+IGFjY2VsLWludGVybmFsLmh9
ICg1NiUpDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvYWNjZWwvYWNjZWwtY3B1
LmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLmgN
Cj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYWNjZWwvYWNjZWwtY29tbW9uLmMNCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgdGFyZ2V0X2luZm8tZGVmcy5jDQo+IA0KDQo=

