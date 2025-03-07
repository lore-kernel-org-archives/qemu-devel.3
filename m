Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CCCC28B27
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdHH-0003Ha-5K; Fri, 07 Mar 2025 14:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdF6-0007kS-KA
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:20:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdF4-0006QY-Ds
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:20:20 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so47772775ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375217; x=1741980017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QnZzQ8xIkaMXC8cGThBUN9qjyauvWJ30D/qPq+dR2KA=;
 b=To3ah4FwXmhryvSrg39y5Otq7DwIh17wjt+7voq1zivRvQgTTPsb9IkxorBfNG73jO
 lbVhJwmeoxeT3KVEC0i8pzlzNytVtf6ARiEJ9itI9PYI0C22OIerWkvD5Emhe11MMcI0
 8ASwV2YU0bx8EJGYOVTK9eYBt2sUd4ZMDIwZtJ/lyuq7RUKSccroy+J5VDmg/vxNueU3
 X5KHyrBj8m7GFDoL3hcAyF3kRkHwMQqZhEwMunrn6LAtaP4hCRP7YREZ1d8FeC7ROtoz
 gx7M4GERCnmbbnkw6UZfz4MuauHtzhvwahM0RayHCzyv+46CtMchNIFr7Tcb9LJ9JFO3
 UEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375217; x=1741980017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QnZzQ8xIkaMXC8cGThBUN9qjyauvWJ30D/qPq+dR2KA=;
 b=VL705RLp/jCpGb3eFuarCxyc5Gxs2hZU+CcZoxp/KqYB2mCtUk12OQ5Xd307Ejh3Hd
 w66ZIy2WdMNjy9tQL+xo3LojDf3Cht4CeHDrII43f/aAnyWzmB3ydfR5nxL9SSlvjdqT
 0twU1A0DATjyB9/RuuUyAO8tFxVtWfHyIn2shhZjl969GvOfy2au4EOMKdu0SXORV38t
 GZJXzXDAATbIkKwINx+3PQ6oOoq6UJIXXi046GN/vbbeyfm4lMQO+KAKFFyIkA0AefnP
 /deOeU0GU6pyo+tMEASNSHnsKqSHYVd9AsmZOhaC3IkE57j8bBG4M7wCNJfpSkByO561
 /VKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIAvyqIt3c2OV3wgtGvUYEHkXeMayOPq58PVnPyF/esa7QLebTngThZ8egDIoEXes3pjkg8WJKTdVd@nongnu.org
X-Gm-Message-State: AOJu0Ywy7jCjVOrKXkgECMAkekmssT87n/BXTOHrCwOPZgrO2myz4Y86
 TZ2e/BP3kKWaa7nBr0fZ1yUbmewxEfvSz7AtJDDz1h3faYoDx22W1Y2kcWP8oyk=
X-Gm-Gg: ASbGncs/6z7y6a5BjBoAjXx2OxWzzyeN130wrYfycNmMcJUXLgprAypeqq08QlalKM2
 bct+KI3MPFo+rMB6xEFVA6tyhIaPO7mPai8eEgeKhyC2oNrfhS8QYE0R8309JIoChywOOIjKnK9
 f9uVYxKX4uzqL+9OezotkadXL++wKPKFGg222+hq2v9KTQ5K8Tn1gnqIm74UKAKtBPdYht1sh4l
 8AlFfkObbHEZyyWbRfIF6X8/07MDzRkx1qIvJv5SnBErNuSEnoIg4FTCDf0uzig8NHtjDIkj696
 bH9g7/UrCb3J3DvX4y4q3MGJ4G0lTTfTCi1WlLYUZXdHrPzYUVQBXAFkRA==
X-Google-Smtp-Source: AGHT+IEw4kycfkExnTF4ehnxSH6o0twQeGdPU6hW4taR7U1Qi6yn3fbpGFFzlNqdG8L8FTLqPdU/aA==
X-Received: by 2002:a05:6a20:7fa1:b0:1f0:e706:1370 with SMTP id
 adf61e73a8af0-1f544cac82amr9581732637.35.1741375216875; 
 Fri, 07 Mar 2025 11:20:16 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698519395sm3618435b3a.153.2025.03.07.11.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:20:16 -0800 (PST)
Message-ID: <8e8b6f27-9247-4154-a276-e51267c04d18@linaro.org>
Date: Fri, 7 Mar 2025 11:20:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] hw/vfio/platform: Check CONFIG_IOMMUFD at runtime
 using iommufd_builtin
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-15-philmd@linaro.org>
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ29u
dmVydCB0aGUgY29tcGlsZSB0aW1lIGNoZWNrIG9uIHRoZSBDT05GSUdfSU9NTVVGRCBkZWZp
bml0aW9uDQo+IGJ5IGEgcnVudGltZSBvbmUgYnkgY2FsbGluZyBpb21tdWZkX2J1aWx0aW4o
KS4NCj4gDQo+IFNpbmNlIHRoZSBmaWxlIGRvZXNuJ3QgdXNlIGFueSB0YXJnZXQtc3BlY2lm
aWMga25vd2xlZGdlIGFueW1vcmUsDQo+IG1vdmUgaXQgdG8gc3lzdGVtX3NzW10gdG8gYnVp
bGQgaXQgb25jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaHcvdmZpby9wbGF0Zm9ybS5j
ICB8IDI1ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICBody92ZmlvL21lc29uLmJ1
aWxkIHwgIDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGxhdGZvcm0uYyBi
L2h3L3ZmaW8vcGxhdGZvcm0uYw0KPiBpbmRleCA2N2JjNTc0MDljMS4uMjY1YzU1MGI3NDcg
MTAwNjQ0DQo+IC0tLSBhL2h3L3ZmaW8vcGxhdGZvcm0uYw0KPiArKysgYi9ody92ZmlvL3Bs
YXRmb3JtLmMNCj4gQEAgLTE1LDcgKzE1LDYgQEANCj4gICAgKi8NCj4gICANCj4gICAjaW5j
bHVkZSAicWVtdS9vc2RlcC5oIg0KPiAtI2luY2x1ZGUgQ09ORklHX0RFVklDRVMgLyogQ09O
RklHX0lPTU1VRkQgKi8NCj4gICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiAgICNpbmNs
dWRlIDxzeXMvaW9jdGwuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvdmZpby5oPg0KPiBAQCAt
NjM3LDEwICs2MzYsMTEgQEAgc3RhdGljIGNvbnN0IFByb3BlcnR5IHZmaW9fcGxhdGZvcm1f
ZGV2X3Byb3BlcnRpZXNbXSA9IHsNCj4gICAgICAgREVGSU5FX1BST1BfVUlOVDMyKCJtbWFw
LXRpbWVvdXQtbXMiLCBWRklPUGxhdGZvcm1EZXZpY2UsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICBtbWFwX3RpbWVvdXQsIDExMDApLA0KPiAgICAgICBERUZJTkVfUFJPUF9CT09M
KCJ4LWlycWZkIiwgVkZJT1BsYXRmb3JtRGV2aWNlLCBpcnFmZF9hbGxvd2VkLCB0cnVlKSwN
Cj4gLSNpZmRlZiBDT05GSUdfSU9NTVVGRA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0
IFByb3BlcnR5IHZmaW9fcGxhdGZvcm1fZGV2X2lvbW11ZmRfcHJvcGVydGllc1tdID0gew0K
PiAgICAgICBERUZJTkVfUFJPUF9MSU5LKCJpb21tdWZkIiwgVkZJT1BsYXRmb3JtRGV2aWNl
LCB2YmFzZWRldi5pb21tdWZkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfSU9N
TVVGRF9CQUNLRU5ELCBJT01NVUZEQmFja2VuZCAqKSwNCj4gLSNlbmRpZg0KPiAgIH07DQo+
ICAgDQo+ICAgc3RhdGljIHZvaWQgdmZpb19wbGF0Zm9ybV9pbnN0YW5jZV9pbml0KE9iamVj
dCAqb2JqKQ0KPiBAQCAtNjUyLDEyICs2NTIsMTAgQEAgc3RhdGljIHZvaWQgdmZpb19wbGF0
Zm9ybV9pbnN0YW5jZV9pbml0KE9iamVjdCAqb2JqKQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgIERFVklDRSh2ZGV2KSwgZmFsc2UpOw0KPiAgIH0NCj4gICANCj4gLSNpZmRlZiBDT05G
SUdfSU9NTVVGRA0KPiAgIHN0YXRpYyB2b2lkIHZmaW9fcGxhdGZvcm1fc2V0X2ZkKE9iamVj
dCAqb2JqLCBjb25zdCBjaGFyICpzdHIsIEVycm9yICoqZXJycCkNCj4gICB7DQo+ICAgICAg
IHZmaW9fZGV2aWNlX3NldF9mZCgmVkZJT19QTEFURk9STV9ERVZJQ0Uob2JqKS0+dmJhc2Vk
ZXYsIHN0ciwgZXJycCk7DQo+ICAgfQ0KPiAtI2VuZGlmDQo+ICAgDQo+ICAgc3RhdGljIHZv
aWQgdmZpb19wbGF0Zm9ybV9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAq
ZGF0YSkNCj4gICB7DQo+IEBAIC02NjYsOSArNjY0LDEwIEBAIHN0YXRpYyB2b2lkIHZmaW9f
cGxhdGZvcm1fY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQo+
ICAgDQo+ICAgICAgIGRjLT5yZWFsaXplID0gdmZpb19wbGF0Zm9ybV9yZWFsaXplOw0KPiAg
ICAgICBkZXZpY2VfY2xhc3Nfc2V0X3Byb3BzKGRjLCB2ZmlvX3BsYXRmb3JtX2Rldl9wcm9w
ZXJ0aWVzKTsNCj4gLSNpZmRlZiBDT05GSUdfSU9NTVVGRA0KPiAtICAgIG9iamVjdF9jbGFz
c19wcm9wZXJ0eV9hZGRfc3RyKGtsYXNzLCAiZmQiLCBOVUxMLCB2ZmlvX3BsYXRmb3JtX3Nl
dF9mZCk7DQo+IC0jZW5kaWYNCj4gKyAgICBpZiAoaW9tbXVmZF9idWlsdGluKCkpIHsNCj4g
KyAgICAgICAgZGV2aWNlX2NsYXNzX3NldF9wcm9wcyhkYywgdmZpb19wbGF0Zm9ybV9kZXZf
aW9tbXVmZF9wcm9wZXJ0aWVzKTsNCj4gKyAgICAgICAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5
X2FkZF9zdHIoa2xhc3MsICJmZCIsIE5VTEwsIHZmaW9fcGxhdGZvcm1fc2V0X2ZkKTsNCj4g
KyAgICB9DQo+ICAgICAgIGRjLT52bXNkID0gJnZmaW9fcGxhdGZvcm1fdm1zdGF0ZTsNCj4g
ICAgICAgZGMtPmRlc2MgPSAiVkZJTy1iYXNlZCBwbGF0Zm9ybSBkZXZpY2UgYXNzaWdubWVu
dCI7DQo+ICAgICAgIHNiYy0+Y29ubmVjdF9pcnFfbm90aWZpZXIgPSB2ZmlvX3N0YXJ0X2ly
cWZkX2luamVjdGlvbjsNCj4gQEAgLTY5MiwxMSArNjkxLDExIEBAIHN0YXRpYyB2b2lkIHZm
aW9fcGxhdGZvcm1fY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEp
DQo+ICAgICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24oa2xhc3Ms
IC8qIDIuNiAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICJzeXNmc2RldiIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIkhvc3Qgc3lzZnMgcGF0aCBvZiBhc3NpZ25lZCBkZXZpY2UiKTsNCj4gLSNp
ZmRlZiBDT05GSUdfSU9NTVVGRA0KPiAtICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9zZXRf
ZGVzY3JpcHRpb24oa2xhc3MsIC8qIDkuMCAqLw0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgImlvbW11ZmQiLA0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIlNldCBob3N0IElPTU1VRkQgYmFja2VuZCBkZXZp
Y2UiKTsNCj4gLSNlbmRpZg0KPiArICAgIGlmIChpb21tdWZkX2J1aWx0aW4oKSkgew0KPiAr
ICAgICAgICBvYmplY3RfY2xhc3NfcHJvcGVydHlfc2V0X2Rlc2NyaXB0aW9uKGtsYXNzLCAv
KiA5LjAgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiaW9tbXVmZCIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIlNldCBob3N0IElPTU1VRkQgYmFja2VuZCBkZXZpY2UiKTsNCj4gKyAg
ICB9DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBUeXBlSW5mbyB2ZmlvX3BsYXRm
b3JtX2Rldl9pbmZvID0gew0KPiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9tZXNvbi5idWlsZCBi
L2h3L3ZmaW8vbWVzb24uYnVpbGQNCj4gaW5kZXggYmQ2ZTFkOTk5ZTQuLmU1MDEwZGIyYzcx
IDEwMDY0NA0KPiAtLS0gYS9ody92ZmlvL21lc29uLmJ1aWxkDQo+ICsrKyBiL2h3L3ZmaW8v
bWVzb24uYnVpbGQNCj4gQEAgLTcsNyArNyw2IEBAIHZmaW9fc3MuYWRkKHdoZW46ICdDT05G
SUdfUFNFUklFUycsIGlmX3RydWU6IGZpbGVzKCdzcGFwci5jJykpDQo+ICAgdmZpb19zcy5h
ZGQod2hlbjogJ0NPTkZJR19WRklPX1BDSScsIGlmX3RydWU6IGZpbGVzKA0KPiAgICAgJ3Bj
aS1xdWlya3MuYycsDQo+ICAgKSkNCj4gLXZmaW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJ
T19QTEFURk9STScsIGlmX3RydWU6IGZpbGVzKCdwbGF0Zm9ybS5jJykpDQo+ICAgDQo+ICAg
c3BlY2lmaWNfc3MuYWRkX2FsbCh3aGVuOiAnQ09ORklHX1ZGSU8nLCBpZl90cnVlOiB2Zmlv
X3NzKQ0KPiAgIA0KPiBAQCAtMjYsNiArMjUsNyBAQCBzeXN0ZW1fc3MuYWRkKHdoZW46IFsn
Q09ORklHX1ZGSU8nLCAnQ09ORklHX0lPTU1VRkQnXSwgaWZfdHJ1ZTogZmlsZXMoDQo+ICAg
KSkNCj4gICBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJT19BUCcsIGlmX3RydWU6
IGZpbGVzKCdhcC5jJykpDQo+ICAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZGSU9f
Q0NXJywgaWZfdHJ1ZTogZmlsZXMoJ2Njdy5jJykpDQo+ICtzeXN0ZW1fc3MuYWRkKHdoZW46
ICdDT05GSUdfVkZJT19QTEFURk9STScsIGlmX3RydWU6IGZpbGVzKCdwbGF0Zm9ybS5jJykp
DQo+ICAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZGSU9fUENJJywgaWZfdHJ1ZTog
ZmlsZXMoDQo+ICAgICAnZGlzcGxheS5jJywNCj4gICAgICdwY2kuYycsDQoNClJldmlld2Vk
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoN
Cg==

