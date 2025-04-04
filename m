Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE15C369A1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZ8-0002J9-HY; Fri, 04 Apr 2025 13:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZ6-0002IP-2w
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:48 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZ3-0005l3-C1
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22401f4d35aso25573385ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786642; x=1744391442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+8T2AuROtUNoXWnmSDgUdqPeHUYpxBzwCuXUuCN060=;
 b=UKo0auB1MiPkDibsMV2jqa7uMt+N57fIeWIevJN8t176tq3w6CD2JfbGoRxaOJX7r1
 O2LjfnSS9FetqYJIU3pqK6sKw2wTlbaoPtVSnbMWUi0TSZEKm6EIzcVD3Sh/KffeRMXd
 32PSO2L/bFiRsOT+X7iUvLSzqovB2e59x4NC0Y8m1CtFMNMxlvCoDwL4dZp5QRawhRJt
 uNzxixU+SICgXPwyfI66cGCyk3xfZYsKKc5lwtHIpupFTSY803YeENEtJEVpWhCqTohn
 rdL0HZz91ng+UqFvjDOGtGi9QUsPieYx9fzlOMoGjH0fFIXjEFq6DVfU4WC/sGOrNf9e
 MXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786642; x=1744391442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+8T2AuROtUNoXWnmSDgUdqPeHUYpxBzwCuXUuCN060=;
 b=qM6yRTeC8X6Y0SodMRkSif0Yd1Y77pFyLsGK4RMHD5soNPsryuxyaNWfPtDKwekmAZ
 dDScqAo7klNykFTzrLVYkB2B2XDHhC9j4g5S/qx5cN0UML6XplpjHIWuiJ76VLhqk+PN
 6u2qAddewROYtc7DhCI8camlMYZy8Z6zpJRfapdqcGDua3l2BJ8eK0R1jP1DmaLL/4Z4
 aTJ4UPhaE1X5itN0hlyHnQVcDvqdBMrn8wXXqGvIcj4E9lCZ6198KkIeuxC3KgIjav9x
 fML8+HwnZyCGAJ3I48JFaIV+t9w5ciG+lp6oOE3HaNXiwoqU/ZZUUcXRyhCDFgwg9iqq
 9V6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdkJwOt1r+sPN1wynX/FW1fbNMS32Kd6lsUVm7TkCWY6/4MTCbY7Ful4Bn0DJnLt9lZdrA0PP0rbWQ@nongnu.org
X-Gm-Message-State: AOJu0YwZYBHov6MoEZUMJRL5kk12E/qaVJLMNx7+zfNly7PwHpJ0w1f4
 6aQKLVS0m7/lU+9jkRW3ICPdCIhyIJVy/auCIrqauVRK+gzurqYPt8btZdCtQDo=
X-Gm-Gg: ASbGncsuIs6tgnt8diz2JjZBan+J9W488g8nsyOgSRuPtEbjFT/NNKYqGNihjXXTxI2
 7kzymFrvHgb1df/Iwf56okyI5ubCR55c8Lb5aFYSiOiBqm9HGLcJ5WB+/dBJUfGPhJehkV2eOru
 k+gNnPhGwI4Y70c4PndTglhJl66fs0r80LGjhbPN+UpoV8cPLnKG2q5KenL/Qaosu8h9uBdHt81
 L5wb9hoFw4xtdcKhqrqRAo6y4tZkuvLB8TSFDRH5b8eB2mvGvOC4r9njqHkPb/eQAC+e/oJ/d/A
 NJvtKzyR5GB47tB/9e8tTzPxEesEzsRQgQLsko7fnJ9QX/rPwRvV/Uewyg==
X-Google-Smtp-Source: AGHT+IGv1ocUdU2nJXILvo3WV9NncPGeJ1Yi4PlnQcQpOvzuDMe9PSsMmoQGVmTPIl7Y8zMJBcYtuA==
X-Received: by 2002:a17:902:cf4b:b0:224:1220:7f40 with SMTP id
 d9443c01a7336-22a9551417fmr4052075ad.3.1743786642104; 
 Fri, 04 Apr 2025 10:10:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0153sm34730435ad.65.2025.04.04.10.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:41 -0700 (PDT)
Message-ID: <0723c40c-e21e-455b-b99d-5f814a1bd2d9@linaro.org>
Date: Fri, 4 Apr 2025 09:41:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 01/19] qemu: Introduce TargetInfo API in
 'target_info.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-2-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gNC8zLzI1IDE2OjQ4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgIHwgIDkgKysr
KysrKysrDQo+ICAgaW5jbHVkZS9leGVjL3BvaXNvbi5oICAgICAgICAgICB8ICAxICsNCj4g
ICBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8taW1wbC5oIHwgMjEgKysrKysrKysrKysrKysr
KysrKysrDQo+ICAgaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLmggICAgICB8IDE4ICsrKysr
KysrKysrKysrKysrKw0KPiAgIHRhcmdldF9pbmZvLXN0dWIuYyAgICAgICAgICAgICAgfCAy
MyArKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIHRhcmdldF9pbmZvLmMgICAgICAgICAg
ICAgICAgICAgfCAxNiArKysrKysrKysrKysrKysrDQo+ICAgNiBmaWxlcyBjaGFuZ2VkLCA4
OCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvcWVtdS90
YXJnZXRfaW5mby1pbXBsLmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9xZW11
L3RhcmdldF9pbmZvLmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0X2luZm8tc3R1
Yi5jDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldF9pbmZvLmMNCj4gDQo+IGRpZmYg
LS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkDQo+IGluZGV4IGJjYjlkMzlhMzg3
Li5kZTljOWRhY2QzNSAxMDA2NDQNCj4gLS0tIGEvbWVzb24uYnVpbGQNCj4gKysrIGIvbWVz
b24uYnVpbGQNCj4gQEAgLTMyNjIsNiArMzI2Miw5IEBAIGhvc3Rfa2NvbmZpZyA9IFwNCj4g
ICANCj4gICBpZ25vcmVkID0gWyAnVEFSR0VUX1hNTF9GSUxFUycsICdUQVJHRVRfQUJJX0RJ
UicsICdUQVJHRVRfQVJDSCcgXQ0KPiAgIA0KPiArdGFyZ2V0X2luZm8gPSBbDQo+ICtdDQo+
ICsNCg0KVG8gZm9sbG93IHdoYXQgaXMgYWxyZWFkeSBpbXBsZW1lbnRlZCwgd2Ugc2hvdWxk
IHVzZSBhIGRpY3Rpb25hcnkgcGVyIA0KdGFyZ2V0LCBwb2ludGluZyB0byB0aGUgYXNzb2Np
YXRlZCBzb3VyY2UgZmlsZS4NClRoaXMgd2F5LCBpdCBhbGxvd3MgdG8gbW92ZSBmaWxlcyBs
aXN0aW5nIGRpcmVjdGx5IHRvIGVhY2ggYXJjaGl0ZWN0dXJlLCANCmFuZCB0aGUgdG9wIG1l
c29uLmJ1aWxkIG9ubHkgbmVlZHMgdG8gYWRkIHN0dWIgaWYgaXQgaXMgbm90IGRlZmluZWQu
DQoNCj4gICBkZWZhdWx0X3RhcmdldHMgPSAnQ09ORklHX0RFRkFVTFRfVEFSR0VUUycgaW4g
Y29uZmlnX2hvc3QNCj4gICBhY3R1YWxfdGFyZ2V0X2RpcnMgPSBbXQ0KPiAgIGZkdF9yZXF1
aXJlZCA9IFtdDQo+IEBAIC0zMzY4LDYgKzMzNzEsOSBAQCBmb3JlYWNoIHRhcmdldCA6IHRh
cmdldF9kaXJzDQo+ICAgICAgICAgY29uZmlnX3RhcmdldF9kYXRhLnNldChrLCB2KQ0KPiAg
ICAgICBlbmRpZg0KPiAgICAgZW5kZm9yZWFjaA0KPiArICBpZiB0YXJnZXQgbm90IGluIHRh
cmdldF9pbmZvDQo+ICsgICAgY29uZmlnX3RhcmdldF9kYXRhLnNldCgnVEFSR0VUX0lORk9f
U1RVQl9ORUVERUQnLCAxKQ0KPiArICBlbmRpZg0KDQpXaXRoIHRoZSBkaWN0aW9uYXJ5LCB0
aGlzIGlzIG5vdCBuZWVkZWQgYW55bW9yZS4NCg0KPiAgICAgY29uZmlnX3RhcmdldF9kYXRh
LnNldCgnUUVNVV9BUkNIJywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgJ1FFTVVf
QVJDSF8nICsgY29uZmlnX3RhcmdldFsnVEFSR0VUX0JBU0VfQVJDSCddLnRvX3VwcGVyKCkp
DQo+ICAgICBjb25maWdfdGFyZ2V0X2ggKz0ge3RhcmdldDogY29uZmlndXJlX2ZpbGUob3V0
cHV0OiB0YXJnZXQgKyAnLWNvbmZpZy10YXJnZXQuaCcsDQo+IEBAIC0zODA3LDYgKzM4MTMs
OSBAQCBlbmRpZg0KPiAgIGNvbW1vbl9zcy5hZGQocGFnZXZhcnkpDQo+ICAgc3BlY2lmaWNf
c3MuYWRkKGZpbGVzKCdwYWdlLXRhcmdldC5jJywgJ3BhZ2UtdmFyeS10YXJnZXQuYycpKQ0K
PiAgIA0KPiArc3BlY2lmaWNfc3MuYWRkKGZpbGVzKCd0YXJnZXRfaW5mby1zdHViLmMnKSkN
Cj4gK2NvbW1vbl9zcy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLmMnKSkNCj4gKw0KPiAgIHN1
YmRpcignYmFja2VuZHMnKQ0KPiAgIHN1YmRpcignZGlzYXMnKQ0KPiAgIHN1YmRpcignbWln
cmF0aW9uJykNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9wb2lzb24uaCBiL2luY2x1
ZGUvZXhlYy9wb2lzb24uaA0KPiBpbmRleCBiYzQyMjcxOWQ4MC4uMDBhZWRjNDFkODIgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvZXhlYy9wb2lzb24uaA0KPiArKysgYi9pbmNsdWRlL2V4
ZWMvcG9pc29uLmgNCj4gQEAgLTM4LDYgKzM4LDcgQEANCj4gICAjcHJhZ21hIEdDQyBwb2lz
b24gVEFSR0VUX0JJR19FTkRJQU4NCj4gICAjcHJhZ21hIEdDQyBwb2lzb24gVENHX0dVRVNU
X0RFRkFVTFRfTU8NCj4gICAjcHJhZ21hIEdDQyBwb2lzb24gVEFSR0VUX0hBU19QUkVDSVNF
X1NNQw0KPiArI3ByYWdtYSBHQ0MgcG9pc29uIFRBUkdFVF9JTkZPX1NUVUJfTkVFREVEDQo+
ICAgDQo+ICAgI3ByYWdtYSBHQ0MgcG9pc29uIFRBUkdFVF9MT05HX0JJVFMNCj4gICAjcHJh
Z21hIEdDQyBwb2lzb24gVEFSR0VUX0ZNVF9seA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9x
ZW11L3RhcmdldF9pbmZvLWltcGwuaCBiL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1pbXBs
LmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAuLmIzNDBl
MTkyZmNlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldF9p
bmZvLWltcGwuaA0KPiBAQCAtMCwwICsxLDIxIEBADQo+ICsvKg0KPiArICogUUVNVSBiaW5h
cnkgaGVscGVycw0KPiArICoNCj4gKyAqICBDb3B5cmlnaHQgKGMpIExpbmFybw0KPiArICoN
Cj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsg
Ki8NCj4gKw0KPiArI2lmbmRlZiBRRU1VX1RBUkdFVF9JTkZPX0lNUExfSA0KPiArI2RlZmlu
ZSBRRU1VX1RBUkdFVF9JTkZPX0lNUExfSA0KPiArDQo+ICsjaW5jbHVkZSAicWVtdS90YXJn
ZXRfaW5mby5oIg0KPiArDQo+ICtzdHJ1Y3QgQmluYXJ5VGFyZ2V0SW5mbyB7DQo+ICsNCg0K
SSB3b3VsZCBiZSBpbiBmYXZvciB0byByZW5hbWUgZXhpc2luZyBUYXJnZXRJbmZvIGluIFFN
UFRhcmdldEluZm8sIGFuZCANCnJldXNlIHRoYXQgbmFtZSBoZXJlLg0KDQo+ICsgICAgLyog
cnVudGltZSBlcXVpdmFsZW50IG9mIFRBUkdFVF9JTkZPX1NUVUJfTkVFREVEIGRlZmluaXRp
b24gKi8NCj4gKyAgICBib29sIGlzX3N0dWI7DQoNCldoeSBkbyB3ZSB3YW50IHRvIGtub3cg
aWYgaXQncyBhIHN0dWIgYXQgcnVudGltZT8NCg0KPiArDQo+ICt9Ow0KPiArDQo+ICsjZW5k
aWYNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby5oIGIvaW5jbHVk
ZS9xZW11L3RhcmdldF9pbmZvLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAuLmZhYjNmMzE1M2VhDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5j
bHVkZS9xZW11L3RhcmdldF9pbmZvLmgNCj4gQEAgLTAsMCArMSwxOCBAQA0KPiArLyoNCj4g
KyAqIFFFTVUgYmluYXJ5IGhlbHBlcnMNCj4gKyAqDQo+ICsgKiAgQ29weXJpZ2h0IChjKSBM
aW5hcm8NCj4gKyAqDQo+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
ci1sYXRlcg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYgUUVNVV9UQVJHRVRfSU5GT19IDQo+
ICsjZGVmaW5lIFFFTVVfVEFSR0VUX0lORk9fSA0KPiArDQo+ICt0eXBlZGVmIHN0cnVjdCBC
aW5hcnlUYXJnZXRJbmZvIEJpbmFyeVRhcmdldEluZm87DQo+ICsNCj4gK2NvbnN0IEJpbmFy
eVRhcmdldEluZm8gKnRhcmdldF9pbmZvKHZvaWQpOw0KPiArDQo+ICtib29sIHRhcmdldF9p
bmZvX2lzX3N0dWIodm9pZCk7DQo+ICsNCj4gKyNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0X2luZm8tc3R1Yi5jIGIvdGFyZ2V0X2luZm8tc3R1Yi5jDQo+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwLi5kNjgzYTA1OTc3ZA0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL3RhcmdldF9pbmZvLXN0dWIuYw0KPiBAQCAtMCwwICsxLDIzIEBADQo+
ICsvKg0KPiArICogUUVNVSB0YXJnZXQgaW5mbyBzdHVicw0KPiArICoNCj4gKyAqICBDb3B5
cmlnaHQgKGMpIExpbmFybw0KPiArICoNCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgInFlbXUvb3Nk
ZXAuaCINCj4gKyNpbmNsdWRlICJxZW11L3RhcmdldF9pbmZvLWltcGwuaCINCj4gKw0KPiAr
I2lmZGVmIFRBUkdFVF9JTkZPX1NUVUJfTkVFREVEDQo+ICsNCj4gK3N0YXRpYyBjb25zdCBC
aW5hcnlUYXJnZXRJbmZvIHRhcmdldF9pbmZvX3N0dWIgPSB7DQo+ICsgICAgLmlzX3N0dWIg
PSB0cnVlLA0KPiArfTsNCj4gKw0KPiArY29uc3QgQmluYXJ5VGFyZ2V0SW5mbyAqdGFyZ2V0
X2luZm8odm9pZCkNCj4gK3sNCj4gKyAgICByZXR1cm4gJnRhcmdldF9pbmZvX3N0dWI7DQo+
ICt9DQo+ICsNCj4gKyNlbmRpZiAvKiBUQVJHRVRfSU5GT19TVFVCX05FRURFRCAqLw0KPiBk
aWZmIC0tZ2l0IGEvdGFyZ2V0X2luZm8uYyBiL3RhcmdldF9pbmZvLmMNCj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAuLmNiMTdkMjliODZkDQo+IC0tLSAv
ZGV2L251bGwNCj4gKysrIGIvdGFyZ2V0X2luZm8uYw0KPiBAQCAtMCwwICsxLDE2IEBADQo+
ICsvKg0KPiArICogUUVNVSBsZWdhY3kgYmluYXJ5IGhlbHBlcnMNCj4gKyAqDQo+ICsgKiAg
Q29weXJpZ2h0IChjKSBMaW5hcm8NCj4gKyAqDQo+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlICJxZW11
L29zZGVwLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby1pbXBsLmgiDQo+ICsj
aW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby5oIg0KPiArDQo+ICtib29sIHRhcmdldF9pbmZv
X2lzX3N0dWIodm9pZCkNCj4gK3sNCj4gKyAgICByZXR1cm4gdGFyZ2V0X2luZm8oKS0+aXNf
c3R1YjsNCj4gK30NCg0K

