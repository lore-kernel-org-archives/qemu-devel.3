Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1028C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 17:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1qES-0003DJ-6f; Mon, 07 Apr 2025 13:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u1qEG-0003BO-Q2
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:25:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u1qED-0005IY-Ln
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:25:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2260c91576aso38555805ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744046744; x=1744651544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rAJIt3z4/vpXRXn3CV1xXt7Ba1T9dESBWjnn2VOkbdg=;
 b=KBsjNgKYJ7teksINKC0hsfSP2VnymD98pAG8LdzOCVGJLlPLuD7UZAzU+P0xDJiStV
 9O4GX4hpJh4xSSsih2v3TBeKR1+U/gQ9BTRuXYH4/8wc2c5ezJyKRx9CX0vL41nEZiN1
 MI8rTulNSIJCRd0m4M7rFgw4e/nk/ri6eKOEK+zSmKbw5B1DJpCFNMG+o9KaMu8/O+Jx
 peXs+V+MXe4qS2XYcJ2sRSlHT4alSkfz3FkqLPtrXJoPcMAe84UsuXTTeTWcCS7oKuPR
 Ud3VC0ihFrb6J926Fo7EE6jP9dCsyKrZ+FvCip6Ln0K0EfFcfPLH9BXqrS9k3fqXjxBp
 gxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744046744; x=1744651544;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rAJIt3z4/vpXRXn3CV1xXt7Ba1T9dESBWjnn2VOkbdg=;
 b=fPyyQxrDXVfbc6+DIEolvIbtjxOcOInTvQVG1LRhCf5qmTv8V1aVx9z/DeqEXclUa1
 JBZ7Axr9XUx5SMeNXwLP2nOpWb7ELtYvNPWMMnqgW7PFahz2t0gq5eR9EIqitWgxtMK1
 BmIiAspu+cXj70na4LOtbzzsdGR0ouzhLnHNIOSsUTM65rE44BPh5W/67fozmOTdyL5G
 yhKm06By0b3EooFCfP9Jap0DNpkV7wW+qrhxSCBuf/eiwv1TCHaNmwHYUDPuFZ/gaCLd
 EJK64uVN/r9FvHUGaB+fDdSAmbcI/kjIxOc7bWa0nW/MqaiaYHGjtj01mKGK3LF0QCrQ
 msAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGRZ+z2TmO9xrO+Zggq8raBovlR3jkKxo/9jTSTE3jKUk6RvDwsR0h+chfBvU0zJX4TyeP2D+Jt8NT@nongnu.org
X-Gm-Message-State: AOJu0Yxlw3pdNGPc9QeMbhYCmiMv1Ax0wKa5sBWOjOY7iK7FekfMQsbU
 bWRHp0ivk97c3yYDwUSWPwDL1xwXOaZRQ1XSbNttCK4F2sJaZge2fkuXIOOJSD/Ubvbrx/E2N3B
 p
X-Gm-Gg: ASbGncuf0tN/3nw5UV7Eyiez0GuBbHSvHBDUsoewnKsI5POtbQAgXobV0lti5Hdduxf
 Ll/mtJrWf8N3T1eKwcb2GT2xehwrLJbcLWpHvc4ywRCtsNwKI5oOSy0LK49GFllJuMm9E8LSnuO
 oEgptLCJfYsi3PKGVH9Yu3sDuDchzwJyMRd9VRHjVVklY9IaVomhJQTS/MJfBWeqIN8hIzrLzWV
 tu+IT/9Goym7E+w7IQ6zTx6gSs50oY5k8OVNnOrATsHN3hnJCI3adfCGdlwVPlflGKuj8XtG977
 lWeHlIoa4s7h5oRpxzQ6O8L3WDk9bYsv6IvY+v/Y63pq1mgylif+NmTpnJ+04QEcwT4K
X-Google-Smtp-Source: AGHT+IHRimBW+cCn44i8U990B9b9tpXGZ45gfPBgAZYIFyiY8pFCo3vt5SXhilUsvKc+tkxzkWAvew==
X-Received: by 2002:a17:903:2f8c:b0:224:1780:c1ec with SMTP id
 d9443c01a7336-22a8a1bb283mr199010535ad.35.1744046743789; 
 Mon, 07 Apr 2025 10:25:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9ea0791sm8742662b3a.110.2025.04.07.10.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 10:25:43 -0700 (PDT)
Message-ID: <c048d251-6fc7-4807-b95a-9fd16f3c0050@linaro.org>
Date: Mon, 7 Apr 2025 10:25:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 20/39] target/arm: Extract PSCI definitions
 to 'psci.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-21-philmd@linaro.org>
 <09bd795d-e62d-44fb-b80a-374efee32034@linaro.org>
 <49ff72e2-24ac-41a8-8aee-f923d9b48cee@linaro.org>
 <04e14ec2-dbfc-4c92-b061-dd7108cd66f2@linaro.org>
 <cdd3bafb-fd69-463f-856b-ad1c95ee6978@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cdd3bafb-fd69-463f-856b-ad1c95ee6978@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

T24gNC81LzI1IDA3OjQzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
NS80LzI1IDAzOjAzLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNC80LzI1IDE0
OjU0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiA0LzQvMjUgMjA6
MjEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+IE9uIDQvMy8yNSAxNjo1OCwgUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+PiBFeHRyYWN0IFBTQ0kgZGVmaW5p
dGlvbnMgKHdoaWNoIGFyZSBub3QgdGFyZ2V0IHNwZWNpZmljKQ0KPj4+Pj4gdG8gdGhlIG5l
dyAidGFyZ2V0L2FybS9wc2NpLmgiLCBzbyBjb2RlIGZyb20gaHcvYXJtLyBjYW4NCj4+Pj4+
IHVzZSB0aGVtIHdpdGhvdXQgaGF2aW5nIHRvIGluY2x1ZGUgdGhlIHRhcmdldCBzcGVjaWZp
Yw0KPj4+Pj4gImNwdS5oIiBoZWFkZXIuDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBJbmNsdWRpbmcg
Y3B1LmggaXMgbm90IGEgcHJvYmxlbSB0byBoYXZlIGNvbW1vbiBjb2RlIChwZXIgYXJjaGl0
ZWN0dXJlKSwNCj4+Pj4gc28gdGhlcmUgaXMgbm8gbmVlZCB0byBkbyBhbnkgY2hhbmdlIGhl
cmUuDQo+Pj4NCj4+PiBBZ2FpbiwgdGhpcyBpcyBhbiBvbGQgcGF0Y2ggZnJvbSBteSBoZXRl
cm9nZW5lb3VzIFBvQyBicmFuY2guDQo+Pj4gSSdsbCByZW1vdmUgZnJvbSB0aGlzIHNlcmll
cyB0byBub3QgZGlzdHJhY3QgeW91Lg0KPj4+DQo+Pg0KPj4gSXQncyBub3QgZGlzdHJhY3Rp
bmcsIGJ1dCBzaW1wbHkgbm90IG5lZWRlZC4NCj4gDQo+IE5vdCBuZWVkZWQgZm9yIHNpbmds
ZS1iaW5hcnksIGJ1dCBuZWVkZWQgZm9yIGhldGVyb2dlbmVvdXMgZW11bGF0aW9uLA0KPiBh
cyB0aGUgc2FtZSBIVyBtaWdodCB1c2UgZGlzdGluY3QgYXJjaGl0ZWN0dXJlcy4NCj4gDQoN
CkluIHRoZSBsaXN0IG9mIGZpbGVzIG1vZGlmaWVkIGJ5IHRoZSBjdXJyZW50IGNoYW5nZSwg
dGhlIG9ubHkgDQpwb3RlbnRpYWxseSBjb25jZXJuZWQgZmlsZSBpcyBody92bWFwcGxlL3Zt
YXBwbGUuYywgYXMgYWxsIG90aGVycyBhcmUgaW4gDQpody9hcm0gb3IgdGFyZ2V0L2FybSwg
c28gY3B1LmggaXMgbm90IGFtYmlndW91cywgYW5kIGFscmVhZHkgYWNjZXNzaWJsZS4NCg0K
QXMgaXQncyBhbiBpbXBsZW1lbnRhdGlvbiBvZiAiQXBwbGUgYWFyY2g2NCBWaXJ0dWFsIE1h
Y2hpbmUiLCBlaXRoZXI6DQotIHdlIGNhbiBpbmNsdWRlIHRhcmdldC9hcm0vY3B1LmggZXhw
bGljaXRlbHkgKHNvIFFFTVVfUFNDSV8qIGVudW0gaXMgDQp2aXNpYmxlKS4NCi0gd2UgY2Fu
IGFkZCBpdCB0byBhcm1fY29tbW9uX3NzLCBzbyBjcHUuaCBiZWNvbWVzIHVuYW1iaWd1b3Vz
Lg0KLSBUaGUgbW9zdCBjb3JyZWN0OiBpdCBzaG91bGQgYmUgbW92ZWQgdG8gaHcvYXJtL3Zt
YXBwbGUvIGFuZCBhZGRlZCB0byANCmFybV9jb21tb25fc3MuDQoNCkkgZG9uJ3QgbWluZCB3
aGljaCBzb2x1dGlvbiB3ZSBwaWNrIHVwIGFtb25nIHRob3NlIHRocmVlIChwZXJzb25hbCAN
CnByZWZlcmVuY2UgZm9yIHRoZSB0aGlyZCBvbmUpLg0KDQpUaGF0IHNhaWQsIHRoZSBjdXJy
ZW50IGFwcHJvYWNoIHRvIGV4dHJhY3QgY29kZSBvbmx5IHRvIG1ha2UgaXQgDQphY2Nlc3Np
YmxlIGZvciBhIHNpbmdsZSBzb3VyY2UgZmlsZSB0aGF0IGlzIG5vdCBjb3JyZWN0bHkgbG9j
YXRlZCBpbiB0aGUgDQpjb2RlYmFzZSBpcyBub3QgdGhlIHJpZ2h0IG9uZS4NCg0KPj4NCj4+
Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAbGluYXJvLm9yZz4NCj4+Pj4+IFJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4+PiAtLS0NCj4+Pj4+ICDCoMKgIGlu
Y2x1ZGUvaHcvYXJtL2Jvb3QuaMKgwqDCoMKgwqAgfMKgIDMgKystDQo+Pj4+PiAgwqDCoCB0
YXJnZXQvYXJtL2NwdS5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgLS0tLS0tDQo+Pj4+
PiAgwqDCoCB0YXJnZXQvYXJtL3BzY2kuaMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE4ICsrKysr
KysrKysrKysrKysrKw0KPj4+Pj4gIMKgwqAgaHcvYXJtL2JhbmFuYXBpX20ydS5jwqDCoMKg
wqDCoCB8wqAgMSArDQo+Pj4+PiAgwqDCoCBody9hcm0vYm9vdC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4+Pj4gIMKgwqAgaHcvYXJtL2hpZ2hiYW5rLmPCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4+Pj4gIMKgwqAgaHcvYXJtL2lteDhtcC1ldmsu
Y8KgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+Pj4+ICDCoMKgIGh3L2FybS9tY2lteDZ1bC1l
dmsuY8KgwqDCoMKgwqAgfMKgIDEgKw0KPj4+Pj4gIMKgwqAgaHcvYXJtL21jaW14N2Qtc2Fi
cmUuY8KgwqDCoMKgIHzCoCAxICsNCj4+Pj4+ICDCoMKgIGh3L2FybS9vcmFuZ2VwaS5jwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+Pj4+ICDCoMKgIGh3L2FybS9zYnNhLXJlZi5j
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+Pj4+ICDCoMKgIGh3L2FybS92aXJ0LWFj
cGktYnVpbGQuY8KgwqAgfMKgIDEgKw0KPj4+Pj4gIMKgwqAgaHcvYXJtL3ZpcnQuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+Pj4+ICDCoMKgIGh3L2FybS94bG54
LXZlcnNhbC12aXJ0LmPCoCB8wqAgMSArDQo+Pj4+PiAgwqDCoCBody9hcm0veGxueC16Y3Ux
MDIuY8KgwqDCoMKgwqDCoCB8wqAgMSArDQo+Pj4+PiAgwqDCoCBody92bWFwcGxlL3ZtYXBw
bGUuY8KgwqDCoMKgwqDCoCB8wqAgMSArDQo+Pj4+PiAgwqDCoCB0YXJnZXQvYXJtL2hlbHBl
ci5jwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4+Pj4gIMKgwqAgdGFyZ2V0L2FybS9odmYv
aHZmLmPCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4+Pj4gIMKgwqAgdGFyZ2V0L2FybS90Y2cv
b3BfaGVscGVyLmMgfMKgIDEgKw0KPj4+Pj4gIMKgwqAgdGFyZ2V0L2FybS90Y2cvcHNjaS5j
wqDCoMKgwqDCoCB8wqAgMSArDQo+Pj4+PiAgwqDCoCAyMCBmaWxlcyBjaGFuZ2VkLCAzNyBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4+Pj4gIMKgwqAgY3JlYXRlIG1vZGUg
MTAwNjQ0IHRhcmdldC9hcm0vcHNjaS5oDQo+Pj4NCj4+DQo+IA0KDQo=

