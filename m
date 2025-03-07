Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6385FC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdI5-0005Ee-OX; Fri, 07 Mar 2025 14:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdEG-0005uv-FF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:19:31 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdEE-0005NS-1q
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:19:27 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22435603572so11789875ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375164; x=1741979964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CwGeDAcGlrIg3UuUXUXJHyQU+nMyCUI9TS4YSn5Ch5w=;
 b=PxXypKUIi3qWjvRpWUWIPAcy+cavwKuUnyHFaMwFDPDLxqoENtx1hj+rYV7TD71IHf
 r2E0D0LJmFk09/ivWR2Mv0XOF8ci4eGmk2TEmVg8diIJPV4uvmJBJKnCNJBGBDpGtSDP
 I0asATw+McgGBZ4F9basz8Zzk9wYyS7G75cHu0IUg2RFv4v49bM3HdmZzoAi2a8UVKQz
 nQrq8afWRdYjDV0XCDTOOiPvJiXhculK7BRgrXtqdHOnPn0gQplG++YOML2OD6WhgIrr
 zz1nUiDmInsBVL79wOiB12VWQ5xGv6jkslZYvnZ0Wc0FUA+0T5EsRPrEbdi3TpjXzFAW
 BAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375164; x=1741979964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CwGeDAcGlrIg3UuUXUXJHyQU+nMyCUI9TS4YSn5Ch5w=;
 b=NHzQ8/A47DcJBgkTw66Df/OWFIgkXLHDx1nkb/DHvkZ++JGE4Gkbu8MkeGagS22VTy
 uXEcl0pwEXxB5qGws6XhYV0El7qM+eHUUDvtDeewPrvXddPGJYnzZwuD9htBplJ3r8R6
 NlHgR/EwaWUJQTSWaI/hMcP6VddvoPUqbEV6Sqb8+5wUVoa7apv25Gispts8JT6F9ElY
 C/ZVUJXXwS28kv3yTe2CqIqB8bfV9084X2CLZHWkAYCwUMX7w7OmkMAbFKAmCMTfQos6
 hO31C3s8hSOPDxB3W8Sscch4cYCwkshoBDrA9pgKOsoNyfm6be52ErI8VGHXG8jpR4T/
 D7kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrw9XlCbF0xnSbUx7V1mOEE7weiDR/GuK0oegWgLih9kvzdDDaSZK23xRYFPgOEpY1ksLRWW7oVJjy@nongnu.org
X-Gm-Message-State: AOJu0YxyyeDIDZFHhfTeaQX0WOR2idqEVb60UadPm4ZYsHpWHB3N3pKL
 BpztjXiad5Pgsn8e1Xgl3dfQ25OUJ37azlVKpk7msHugRCT8fu0C36gRqiRrJRI=
X-Gm-Gg: ASbGncvoqEsek4ILBjFrQF/RkPEieOn5hFQ4LkNzBFda7zh4k3M36kCDcDNJB/jse+8
 ftEaZQWhY4byOMcKpIoUnzYdLzi2FaKYnXbQEKS9DGL7pFzOpoBIYq4D4gzen/RCy2vOTHtZhPg
 xRpfKUfw88nDQJE66I4Qh7DYvkEzZ6Puiia7IGFfytgBO/u4r1Q3+Nbs3/iDNwgnsSWr4v0kkQr
 DyHNcoLtKFl8JyhtecHwGXME8L6maSq8qBhct4Aiy25+nTN9mG/4YPkh5f4XemfwD0j0/oy0PC3
 SeCgV/LgJc8WrIkx+NjYfm4AvJY0DykoNdMG9aOsNlkiNLDtEE+OC3kgzQ==
X-Google-Smtp-Source: AGHT+IG7w5mw5HnSJKXZr5RM/WkHkvBxEsrVuPUoKkyboUmCtKU0grP1Dihy3YlMH57nYdyK0m+VfQ==
X-Received: by 2002:a17:902:dac8:b0:220:d439:2485 with SMTP id
 d9443c01a7336-22428aa4033mr76277085ad.29.1741375163941; 
 Fri, 07 Mar 2025 11:19:23 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa8a86sm33714705ad.240.2025.03.07.11.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:19:23 -0800 (PST)
Message-ID: <b66a9a03-9f8e-4a91-a138-b25af0bf62f9@linaro.org>
Date: Fri, 7 Mar 2025 11:19:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
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
 <20250307180337.14811-13-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ29u
dmVydCB0aGUgY29tcGlsZSB0aW1lIGNoZWNrIG9uIHRoZSBDT05GSUdfSU9NTVVGRCBkZWZp
bml0aW9uDQo+IGJ5IGEgcnVudGltZSBvbmUgYnkgY2FsbGluZyBpb21tdWZkX2J1aWx0aW4o
KS4NCj4gDQo+IFNpbmNlIHRoZSBmaWxlIGRvZXNuJ3QgdXNlIGFueSB0YXJnZXQtc3BlY2lm
aWMga25vd2xlZGdlIGFueW1vcmUsDQo+IG1vdmUgaXQgdG8gc3lzdGVtX3NzW10gdG8gYnVp
bGQgaXQgb25jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgdGFyZ2V0L3MzOTB4L2t2bS9r
dm1fczM5MHguaCB8ICAyICstDQo+ICAgaHcvdmZpby9hcC5jICAgICAgICAgICAgICAgICB8
IDI3ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgIGh3L3ZmaW8vbWVzb24uYnVp
bGQgICAgICAgICAgfCAgMiArLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9u
cygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3MzOTB4
L2t2bS9rdm1fczM5MHguaCBiL3RhcmdldC9zMzkweC9rdm0va3ZtX3MzOTB4LmgNCj4gaW5k
ZXggNjQ5ZGFlNTk0OGEuLjdiMWNjZTNlNjBkIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvczM5
MHgva3ZtL2t2bV9zMzkweC5oDQo+ICsrKyBiL3RhcmdldC9zMzkweC9rdm0va3ZtX3MzOTB4
LmgNCj4gQEAgLTEwLDcgKzEwLDcgQEANCj4gICAjaWZuZGVmIEtWTV9TMzkwWF9IDQo+ICAg
I2RlZmluZSBLVk1fUzM5MFhfSA0KPiAgIA0KPiAtI2luY2x1ZGUgImNwdS1xb20uaCINCj4g
KyNpbmNsdWRlICJ0YXJnZXQvczM5MHgvY3B1LXFvbS5oIg0KPiAgIA0KPiAgIHN0cnVjdCBr
dm1fczM5MF9pcnE7DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9ody92ZmlvL2FwLmMgYi9ody92
ZmlvL2FwLmMNCj4gaW5kZXggYzdhYjRmZjU3YWQuLjgzMmI5ODUzMmVhIDEwMDY0NA0KPiAt
LS0gYS9ody92ZmlvL2FwLmMNCj4gKysrIGIvaHcvdmZpby9hcC5jDQo+IEBAIC0xMSw3ICsx
MSw2IEBADQo+ICAgICovDQo+ICAgDQo+ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4g
LSNpbmNsdWRlIENPTkZJR19ERVZJQ0VTIC8qIENPTkZJR19JT01NVUZEICovDQo+ICAgI2lu
Y2x1ZGUgPGxpbnV4L3ZmaW8uaD4NCj4gICAjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+ICAg
I2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4gQEAgLTI0LDcgKzIzLDcgQEANCj4gICAjaW5j
bHVkZSAicWVtdS9tb2R1bGUuaCINCj4gICAjaW5jbHVkZSAicWVtdS9vcHRpb24uaCINCj4g
ICAjaW5jbHVkZSAicWVtdS9jb25maWctZmlsZS5oIg0KPiAtI2luY2x1ZGUgImt2bS9rdm1f
czM5MHguaCINCj4gKyNpbmNsdWRlICJ0YXJnZXQvczM5MHgva3ZtL2t2bV9zMzkweC5oIg0K
PiAgICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPiAgICNpbmNsdWRlICJody9x
ZGV2LXByb3BlcnRpZXMuaCINCj4gICAjaW5jbHVkZSAiaHcvczM5MHgvYXAtYnJpZGdlLmgi
DQo+IEBAIC0xOTMsMTAgKzE5MiwxMSBAQCBzdGF0aWMgdm9pZCB2ZmlvX2FwX3VucmVhbGl6
ZShEZXZpY2VTdGF0ZSAqZGV2KQ0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBQcm9wZXJ0eSB2
ZmlvX2FwX3Byb3BlcnRpZXNbXSA9IHsNCj4gICAgICAgREVGSU5FX1BST1BfU1RSSU5HKCJz
eXNmc2RldiIsIFZGSU9BUERldmljZSwgdmRldi5zeXNmc2RldiksDQo+IC0jaWZkZWYgQ09O
RklHX0lPTU1VRkQNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBQcm9wZXJ0eSB2Zmlv
X2FwX2lvbW11ZmRfcHJvcGVydGllc1tdID0gew0KPiAgICAgICBERUZJTkVfUFJPUF9MSU5L
KCJpb21tdWZkIiwgVkZJT0FQRGV2aWNlLCB2ZGV2LmlvbW11ZmQsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgVFlQRV9JT01NVUZEX0JBQ0tFTkQsIElPTU1VRkRCYWNrZW5kICopLA0K
PiAtI2VuZGlmDQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMgdm9pZCB2ZmlvX2FwX3Jlc2V0
KERldmljZVN0YXRlICpkZXYpDQo+IEBAIC0yMzQsMjEgKzIzNCwyMCBAQCBzdGF0aWMgdm9p
ZCB2ZmlvX2FwX2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopDQo+ICAgICAgIHZiYXNlZGV2
LT5tZGV2ID0gdHJ1ZTsNCj4gICB9DQo+ICAgDQo+IC0jaWZkZWYgQ09ORklHX0lPTU1VRkQN
Cj4gICBzdGF0aWMgdm9pZCB2ZmlvX2FwX3NldF9mZChPYmplY3QgKm9iaiwgY29uc3QgY2hh
ciAqc3RyLCBFcnJvciAqKmVycnApDQo+ICAgew0KPiAgICAgICB2ZmlvX2RldmljZV9zZXRf
ZmQoJlZGSU9fQVBfREVWSUNFKG9iaiktPnZkZXYsIHN0ciwgZXJycCk7DQo+ICAgfQ0KPiAt
I2VuZGlmDQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgdmZpb19hcF9jbGFzc19pbml0KE9iamVj
dENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4gICB7DQo+ICAgICAgIERldmljZUNsYXNz
ICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQo+ICAgDQo+ICAgICAgIGRldmljZV9jbGFz
c19zZXRfcHJvcHMoZGMsIHZmaW9fYXBfcHJvcGVydGllcyk7DQo+IC0jaWZkZWYgQ09ORklH
X0lPTU1VRkQNCj4gLSAgICBvYmplY3RfY2xhc3NfcHJvcGVydHlfYWRkX3N0cihrbGFzcywg
ImZkIiwgTlVMTCwgdmZpb19hcF9zZXRfZmQpOw0KPiAtI2VuZGlmDQo+ICsgICAgaWYgKGlv
bW11ZmRfYnVpbHRpbigpKSB7DQo+ICsgICAgICAgIGRldmljZV9jbGFzc19zZXRfcHJvcHMo
ZGMsIHZmaW9fYXBfaW9tbXVmZF9wcm9wZXJ0aWVzKTsNCj4gKyAgICAgICAgb2JqZWN0X2Ns
YXNzX3Byb3BlcnR5X2FkZF9zdHIoa2xhc3MsICJmZCIsIE5VTEwsIHZmaW9fYXBfc2V0X2Zk
KTsNCj4gKyAgICB9DQo+ICAgICAgIGRjLT52bXNkID0gJnZmaW9fYXBfdm1zdGF0ZTsNCj4g
ICAgICAgZGMtPmRlc2MgPSAiVkZJTy1iYXNlZCBBUCBkZXZpY2UgYXNzaWdubWVudCI7DQo+
ICAgICAgIHNldF9iaXQoREVWSUNFX0NBVEVHT1JZX01JU0MsIGRjLT5jYXRlZ29yaWVzKTsN
Cj4gQEAgLTI2MSwxMSArMjYwLDExIEBAIHN0YXRpYyB2b2lkIHZmaW9fYXBfY2xhc3NfaW5p
dChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQo+ICAgICAgIG9iamVjdF9jbGFz
c19wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24oa2xhc3MsIC8qIDMuMSAqLw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJzeXNmc2RldiIsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkhvc3Qgc3lzZnMg
cGF0aCBvZiBhc3NpZ25lZCBkZXZpY2UiKTsNCj4gLSNpZmRlZiBDT05GSUdfSU9NTVVGRA0K
PiAtICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24oa2xhc3MsIC8q
IDkuMCAqLw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ImlvbW11ZmQiLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIlNldCBob3N0IElPTU1VRkQgYmFja2VuZCBkZXZpY2UiKTsNCj4gLSNlbmRpZg0KPiAr
ICAgIGlmIChpb21tdWZkX2J1aWx0aW4oKSkgew0KPiArICAgICAgICBvYmplY3RfY2xhc3Nf
cHJvcGVydHlfc2V0X2Rlc2NyaXB0aW9uKGtsYXNzLCAvKiA5LjAgKi8NCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiaW9tbXVmZCIsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlNldCBob3N0
IElPTU1VRkQgYmFja2VuZCBkZXZpY2UiKTsNCj4gKyAgICB9DQo+ICAgfQ0KPiAgIA0KPiAg
IHN0YXRpYyBjb25zdCBUeXBlSW5mbyB2ZmlvX2FwX2luZm8gPSB7DQo+IGRpZmYgLS1naXQg
YS9ody92ZmlvL21lc29uLmJ1aWxkIGIvaHcvdmZpby9tZXNvbi5idWlsZA0KPiBpbmRleCA5
YTAwNDk5MmMxMS4uNTEwZWJlNmQ3MjAgMTAwNjQ0DQo+IC0tLSBhL2h3L3ZmaW8vbWVzb24u
YnVpbGQNCj4gKysrIGIvaHcvdmZpby9tZXNvbi5idWlsZA0KPiBAQCAtOSw3ICs5LDYgQEAg
dmZpb19zcy5hZGQod2hlbjogJ0NPTkZJR19WRklPX1BDSScsIGlmX3RydWU6IGZpbGVzKA0K
PiAgICkpDQo+ICAgdmZpb19zcy5hZGQod2hlbjogJ0NPTkZJR19WRklPX0NDVycsIGlmX3Ry
dWU6IGZpbGVzKCdjY3cuYycpKQ0KPiAgIHZmaW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJ
T19QTEFURk9STScsIGlmX3RydWU6IGZpbGVzKCdwbGF0Zm9ybS5jJykpDQo+IC12ZmlvX3Nz
LmFkZCh3aGVuOiAnQ09ORklHX1ZGSU9fQVAnLCBpZl90cnVlOiBmaWxlcygnYXAuYycpKQ0K
PiAgIA0KPiAgIHNwZWNpZmljX3NzLmFkZF9hbGwod2hlbjogJ0NPTkZJR19WRklPJywgaWZf
dHJ1ZTogdmZpb19zcykNCj4gICANCj4gQEAgLTI2LDYgKzI1LDcgQEAgc3lzdGVtX3NzLmFk
ZCh3aGVuOiAnQ09ORklHX1ZGSU8nLCBpZl90cnVlOiBmaWxlcygNCj4gICBzeXN0ZW1fc3Mu
YWRkKHdoZW46IFsnQ09ORklHX1ZGSU8nLCAnQ09ORklHX0lPTU1VRkQnXSwgaWZfdHJ1ZTog
ZmlsZXMoDQo+ICAgICAnaW9tbXVmZC5jJywNCj4gICApKQ0KPiArc3lzdGVtX3NzLmFkZCh3
aGVuOiAnQ09ORklHX1ZGSU9fQVAnLCBpZl90cnVlOiBmaWxlcygnYXAuYycpKQ0KPiAgIHN5
c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19WRklPX1BDSScsIGlmX3RydWU6IGZpbGVzKA0K
PiAgICAgJ2Rpc3BsYXkuYycsDQo+ICAgICAncGNpLmMnLA0KDQpSZXZpZXdlZC1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

