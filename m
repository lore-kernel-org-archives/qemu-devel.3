Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9DAE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWLxg-00067x-MR; Fri, 10 Jan 2025 15:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLxU-00063a-Fe
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:50:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLxR-0007Sy-Il
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:50:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21661be2c2dso40724985ad.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736542216; x=1737147016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Az979v3mljxpCMSSzoc8pd6K5xzpfzwsnTnjg1aTEdE=;
 b=Eiq2DUPHwePaCNPCWSe3cvYjs8XvVlpv4FksC5rIfa+QYdwRj5gZPziZoMQ3L3ptLC
 YNWHYLJGxuytKYb40V1yJL45lk+RM9RjHVEk7/NeHFm/gYuenIpFim8Es1EMjxcYye1Y
 kdSfcvPBBckcyQQ20LXJeooUvEIJ6bKBm9NJnthDEeNUFH2lj3X57eYqGjsObzC5ELUf
 KZysk+hjpqBavEA721QkhWeW/VEo/s6IIWZrVUY8HRPh1dsOkePuiKZeVKKPEe2XhYyQ
 cVqcgS4lR5gJDl9ArnCUSom+qhBBI7848ZB9ia2etkIhBGCCRf+muvwbY/8cHRtpZLSS
 UucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736542216; x=1737147016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Az979v3mljxpCMSSzoc8pd6K5xzpfzwsnTnjg1aTEdE=;
 b=r+1nwpbRWvUnSD2QPCgaNOKMa6qZFNJDEbSDIjS2MIhtwMfAgZVqjvjW1yyrxnWLfZ
 NcplP7Q9Ny23KQW7Od3XA+aU6KvRPwOUFWexseQf1FxXsYFNZPxMSYwCNaYcXuxKV8fF
 3HfsUHFHBNg4MnRRAayzOjXV9FV9jECZfXozbErPj2FjLxZlQcuHArEgLGL9EmH6eyFs
 2ZFfH1w5a9uGFvY7SiLQ3XEMCmDe4tBdTUy2Mkb8vMXPSH2HfaCNwTiQgJPvARxz7NH4
 KKGBxtXUER85TuDFhp1Zs3Mll+BKoFWmFrJ1j8hQ6odfrd/W16mLnUAhof+aEX9Xv8aW
 B2xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoXKF0HcQ96DXKyd5uXFfw10ibq/5Z9GcoeKNJLrQPHBoeQ/XY8/JW0Aq0Q7XwEubYkXlvhmydPFtq@nongnu.org
X-Gm-Message-State: AOJu0Yzl3n2KU+i1XkpUSBK1GDLbVVnZB785VykwLmS3GprWPzEUARJn
 xLMT6fFBFOVX6R21UM8RZ1FRRw9wEO7n/5ppbRbTyXXUYOcnCJ4XI23bDOwQZKc=
X-Gm-Gg: ASbGncsSmT7TfT4OdwEJGK+5XnKrLXYY075ePrGGdv/8Qbzdp+SG9XebFbwvWCKeIrd
 d9pzLeyVlbuemBZEf6KBixPyylJoc4ysG76CF0uHDsn/gx38Vl99h6SIO+Agn8bP2oYC8uKxtic
 MPsVP3wxavh4Faguv/4WqOwDbT7tehpG/zgykT35YwOD8n0YftgH8V4hyQ/3nDDyqtnf2wf4zYC
 kTJhR2Z0xxY6sUA7CU5DkYc5H5TvsGH0dBWnA7Rs3so0sRxf1vTDn5oWBvPfjVbYZHfqQ==
X-Google-Smtp-Source: AGHT+IGvqCiBERMCNY9V6/ZOsRgrq3grgBBIg0RyO2/rW6e2R+2Ix3uo6s1zKugDUX6rWA05QO5ALw==
X-Received: by 2002:a05:6a21:8906:b0:1e8:a374:ced7 with SMTP id
 adf61e73a8af0-1e8a374d2c4mr10843806637.23.1736542215868; 
 Fri, 10 Jan 2025 12:50:15 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a31ddb9e52csm3254497a12.72.2025.01.10.12.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 12:50:15 -0800 (PST)
Message-ID: <9ed5fa46-3dfb-4620-bb7b-dd8f84d800be@linaro.org>
Date: Fri, 10 Jan 2025 12:50:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/tricore/triboard: Remove use of &first_cpu
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20250110180909.83165-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250110180909.83165-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gMS8xMC8yNSAxMDowOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IHRy
aWJvYXJkX21hY2hpbmVfaW5pdCgpIGhhcyBhY2Nlc3MgdG8gdGhlIHNpbmdsZSBDUFUgdmlh
Og0KPiANCj4gICAgVHJpQm9hcmRNYWNoaW5lU3RhdGUgew0KPiAgICAgIFRDMjdYU29DU3Rh
dGUgew0KPiAgICAgICAgVHJpQ29yZUNQVSBjcHU7DQo+ICAgICAgICAuLi4NCj4gICAgICB9
IHRjMjd4X3NvYzsNCj4gICAgfSBtczsNCj4gDQo+IFBhc3MgaXQgYXMgYXJndW1lbnQgdG8g
dHJpY29yZV9sb2FkX2tlcm5lbCgpIHNvIHdlIGNhbg0KPiByZW1vdmUgdGhlICZmaXJzdF9j
cHUgZ2xvYmFsIHVzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaHcvdHJpY29yZS90cmli
b2FyZC5jIHwgNiArKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L3RyaWNvcmUvdHJpYm9h
cmQuYyBiL2h3L3RyaWNvcmUvdHJpYm9hcmQuYw0KPiBpbmRleCA0ZGJhMDI1OWNkMy4uOWNj
OGQyODJmZjIgMTAwNjQ0DQo+IC0tLSBhL2h3L3RyaWNvcmUvdHJpYm9hcmQuYw0KPiArKysg
Yi9ody90cmljb3JlL3RyaWJvYXJkLmMNCj4gQEAgLTMxLDExICszMSwxMCBAQA0KPiAgICNp
bmNsdWRlICJody90cmljb3JlL3RyaWJvYXJkLmgiDQo+ICAgI2luY2x1ZGUgImh3L3RyaWNv
cmUvdGMyN3hfc29jLmgiDQo+ICAgDQo+IC1zdGF0aWMgdm9pZCB0cmljb3JlX2xvYWRfa2Vy
bmVsKGNvbnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSkNCj4gK3N0YXRpYyB2b2lkIHRyaWNv
cmVfbG9hZF9rZXJuZWwoVHJpQ29yZUNQVSAqY3B1LCBjb25zdCBjaGFyICprZXJuZWxfZmls
ZW5hbWUpDQo+ICAgew0KPiAgICAgICB1aW50NjRfdCBlbnRyeTsNCj4gICAgICAgbG9uZyBr
ZXJuZWxfc2l6ZTsNCj4gLSAgICBUcmlDb3JlQ1BVICpjcHU7DQo+ICAgICAgIENQVVRyaUNv
cmVTdGF0ZSAqZW52Ow0KPiAgIA0KPiAgICAgICBrZXJuZWxfc2l6ZSA9IGxvYWRfZWxmKGtl
cm5lbF9maWxlbmFtZSwgTlVMTCwNCj4gQEAgLTQ2LDcgKzQ1LDYgQEAgc3RhdGljIHZvaWQg
dHJpY29yZV9sb2FkX2tlcm5lbChjb25zdCBjaGFyICprZXJuZWxfZmlsZW5hbWUpDQo+ICAg
ICAgICAgICBlcnJvcl9yZXBvcnQoIm5vIGtlcm5lbCBmaWxlICclcyciLCBrZXJuZWxfZmls
ZW5hbWUpOw0KPiAgICAgICAgICAgZXhpdCgxKTsNCj4gICAgICAgfQ0KPiAtICAgIGNwdSA9
IFRSSUNPUkVfQ1BVKGZpcnN0X2NwdSk7DQo+ICAgICAgIGVudiA9ICZjcHUtPmVudjsNCj4g
ICAgICAgZW52LT5QQyA9IGVudHJ5Ow0KPiAgIH0NCj4gQEAgLTYyLDcgKzYwLDcgQEAgc3Rh
dGljIHZvaWQgdHJpYm9hcmRfbWFjaGluZV9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkN
Cj4gICAgICAgc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJm1zLT50YzI3eF9zb2Mp
LCAmZXJyb3JfZmF0YWwpOw0KPiAgIA0KPiAgICAgICBpZiAobWFjaGluZS0+a2VybmVsX2Zp
bGVuYW1lKSB7DQo+IC0gICAgICAgIHRyaWNvcmVfbG9hZF9rZXJuZWwobWFjaGluZS0+a2Vy
bmVsX2ZpbGVuYW1lKTsNCj4gKyAgICAgICAgdHJpY29yZV9sb2FkX2tlcm5lbCgmbXMtPnRj
Mjd4X3NvYy5jcHUsIG1hY2hpbmUtPmtlcm5lbF9maWxlbmFtZSk7DQo+ICAgICAgIH0NCj4g
ICB9DQo+ICAgDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

