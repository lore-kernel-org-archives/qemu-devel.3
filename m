Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C49C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RXo-0000BD-9j; Thu, 03 Apr 2025 16:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0RXg-0000AC-LV
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:52:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0RXb-0007XI-Vn
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:52:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22401f4d35aso15088985ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743713518; x=1744318318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cfmDUdPihd+z19y0bvw3CWkjyMc6bzG9tSOZrmHq3+0=;
 b=hHaVHt+IBPEdN5B9SwWYZx98Khx4iVuIEbU6XPASX3MCOhfBLhGzffJKX+9gOSGfZL
 4kqKPZi3kShYuJt2Twezas3uv+A2LzhgbbLEriQedln8tI5Ulyyl2LZUs5RsGsVNmM4M
 Ndc37ZOIbVHLGaZ2olx02F3UpSJKgYu51k/VT8Rql+DbUexgx6RUdKbn1xbdcfrvJC48
 MUXcxTyjBIKvBu0VozTnYl8xlMz5fJNlUqQT2AhLBBOqOb/tkGihch6Jtu0dMvvT1YPT
 FY1yBcyf4tRpWd5n6tt/QRl7U08B3sZyiccb4sc084oVUfP7cK5DSgfodDUmZNOYROH5
 d8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743713518; x=1744318318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cfmDUdPihd+z19y0bvw3CWkjyMc6bzG9tSOZrmHq3+0=;
 b=LlH3T9H81I76neTZn7/8sQtN0QT2DwP95jOV5CQnpGI4ODrKdDcZENwxzT9BmTVFCH
 iMFPMZ82RPGJreQUsPFVQ0qASGi46yGrP0XGmroF/8PZRCaKfuHz+wPld5/7NUx7GOrZ
 ly3erty0yUiqLMeB8Qx0kuyUtFXJBBYzWSCHPoiQC7S9Ia/6LXXfV9siqaJR274cfMaB
 r8KpuLWW4Gf9Pvlp1kQRlWOcIDWe1zoK7ojEcV6VB+CvNy8Ij+qUiXuctGantTOrjGHR
 ZCfLG/f/NZwk9F48wtD8BrktozSJS0gUlqpyvf7sKgoSZ3FpGuqxNUfQp7cTrlMlWDim
 1FVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcDpHK0XRH5wOrwNMVHQKdnWbZ/rn/Hh9xmeHbn9TeU8vbKx1XlYhOzFaK1SJal/Xiw9WdjAGUlL/W@nongnu.org
X-Gm-Message-State: AOJu0YyW/cPIpeCUCNcsWCVzvjnAC/SibF+C5wJCeW8C3IMIIAsXEedr
 dmaCG/yA6EcnPRVEAD26DWMu6oy3VLT68YlPVwFeulOLMHF21tWeI8ET9K0qhb0=
X-Gm-Gg: ASbGnct7aaF9jj/CCPEFAK6F68EKfu2Nd9VWt8GOb+HuJhRr0AMyI+dkADRDjYaTAbp
 l/vKT9174YVlIMeYYYH69xBZ1OVN76lSxS5AiWC//PA8MUG/7EyG7UYRQ1NFhvx+54om2U70iWz
 FhWTJzKpRlGnxuO9jt0JCBSzoVsZceLTcsgLmy70ebZRuGTTRncEicuJ/bQmH1affBHTVPhkIa5
 KGA2hODpM2ESqdXWG84sLQRDRoT0QSXgbBPekbDFj07ADaCqqvKAH5N0/zKP1xBVFcCXDDxW9NB
 GiV8iQPMRO2Ip3m7rDTK14VOzpwQzPbl0jsgIgR7O1Zv0/75NvVPOxEDNw==
X-Google-Smtp-Source: AGHT+IHgK2WlQPL48R1mq49CCBu0HR3Y5olCGGlaQzncFTl2/vFm3GAfEnbDvqetQAnlVBzdwAmaIA==
X-Received: by 2002:a17:902:ce0f:b0:223:325c:89f6 with SMTP id
 d9443c01a7336-22a8a032810mr8992855ad.10.1743713518443; 
 Thu, 03 Apr 2025 13:51:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785adad8sm19147135ad.35.2025.04.03.13.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 13:51:58 -0700 (PDT)
Message-ID: <e6a91ce2-f22f-4abd-a28c-5f6e5c404b2a@linaro.org>
Date: Thu, 3 Apr 2025 13:51:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 00/13] arm: Spring header cleanups
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
 <cecbab0f-56f2-434a-8508-8a4df2992259@linaro.org>
 <0ddb4f55-853b-4f52-935c-51ebed73d38b@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0ddb4f55-853b-4f52-935c-51ebed73d38b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gNC8zLzI1IDEyOjMxLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
My80LzI1IDIwOjIyLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNC8yLzI1IDE1
OjIzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBUaGlzIHNlcmllcyBp
cyBtb3JlIHVzZWZ1bCBmb3IgaGV0ZXJvZ2VuZW91cyBlbXVsYXRpb24gcHJlcGFyYXRpb24N
Cj4+PiB0aGFuIHNpbmdsZSBiaW5hcnksIGJlY2F1c2UgaXQgYWxsb3dzIG5vbi1BUk0gaHcv
IGNvZGUgdG8gY29uZmlndXJlDQo+Pj4gQVJNIGNvcmVzLCBzbyBub3QgdXNpbmcgdGFyZ2V0
LXNwZWNpZmljIEFQSXMuIEkgZmlndXJlZCBzb21lDQo+Pj4gcGF0Y2hlcyBjb3VsZCBiZSB1
c2VmdWwgdG8gUGllcnJpY2sgImJ1aWxkIGh3L2FybSBvbmNlIiBzZXJpZXMgKGluDQo+Pj4g
cGFydGljdWxhciBhcm1fY3B1X2hhc19mZWF0dXJlKS4NCj4+Pg0KPj4NCj4+IEknbSBvayB3
aXRoIHRoZSBjbGVhbnVwIHBhcnQsIGFzIEkgc2VudCBhIHJldmlld2VkLWJ5Lg0KPj4NCj4+
IEhvd2V2ZXIsIEknbSBub3Qgc3VyZSBpbiB3aGljaCBjb250ZXh0IG5vbi1BUk0gaHcvIGNv
ZGUgd2lsbCByZWFsbHkgbmVlZA0KPj4gdG8gZG8gaXQuIEl0IHdvdWxkIGJlIGJldHRlciBp
ZiB3ZSBzdGljayB0byBtYW5kYXRvcnkgY2hhbmdlcyBmb3Igbm93LA0KPj4gaW5zdGVhZCBv
ZiBhbnRpY2lwYXRpbmcgZnV0dXJlIG5lZWRzLCB3aGljaCBtaWdodCBiZSByZWFsIG9yIG5v
dC4NCj4+IFdlIGNhbiBpbXBsZW1lbnQgdGhvc2UgY2hhbmdlcyBvbmx5IGFzIHBhcnQgb2Yg
YSBzZXJpZXMgdGhhdCByZWFsbHkNCj4+IG5lZWRzIGl0Lg0KPiANCj4gSSB1bmRlcnN0YW5k
IHlvdXIgdmlldy4gSSBoYWQgdG8gcmViYXNlIHRoZXNlIG5vdyBvbGQgcGF0Y2hlcywgYW5k
DQo+IGZpZ3VyZWQgaXQgd2lsbCBjb3N0IG1lIGxlc3MgaWYgSSBnZXQgdGhlbSBtZXJnZWQs
IHJhdGhlciB0aGFuDQo+IGtlZXBpbmcgcmViYXNpbmcgdGhlbSBmb3IgNCBvciA1IHJlbGVh
c2VzLg0KPiANCg0KU3VyZSwgdGhhdCdzIHRoZSBiZXN0IGFwcHJvYWNoLiBGb3IgdGhlIHJl
dmlld2VyLCBpdCdzIG5vdCBvYnZpb3VzIHdoZW4gDQp5b3UgaW1wbGVtZW50ZWQgdGhpcyB0
aG91Z2gsIHNvIHRoZSBvbmx5IHF1ZXN0aW9uIHdlIGNhbiBhc2sgaXMgIldoeSBpcyANCnRo
YXQgbmVlZGVkPyIuDQoNCj4gU2luZ2xlIGJpbmFyeSBlZmZvcnQgaXMganVzdCBhIG1pbGVz
dG9uZSB0b3dhcmQgaGV0ZXJvZ2VuZW91cyBlbXVsYXRpb24uDQoNClllcy4gVGhhdCBzYWlk
LCBpdCBkb2VzIG5vdCBjaGFuZ2UgdGhlIGZhY3QgdGhhdCBhbnRpY2lwYXRpbmcgbmVlZHMg
DQooaS5lLiBub3QgZXhwbGljaXRlbHkgcmVxdWlyZWQgdG8gY29tcGlsZS9leGVjdXRlIHJp
Z2h0IG5vdykgY2FuIGRldG91ciANCnVzIGZyb20gdGhlIGdvYWwsIHdoZXRoZXIgaXQncyB0
aGUgc2luZ2xlIGJpbmFyeSwgaGV0ZXJvZ2VuZW91cyANCmVtdWxhdGlvbiwgb3IgYW55IGZl
YXR1cmUgd2Ugd2FudCB0byBhZGQgdG8gUUVNVS4NCg0KSW4gdGhlIGNvbnRleHQgb2YgdGhp
cyBzZXJpZXMsIGl0J3Mgc3RpbGwgbm90IG9idmlvdXMgZm9yIG1lIHdoeSBhIHBpZWNlIA0K
b2YgaGFyZHdhcmUgbm90IHJlbGF0ZWQgdG8gQXJtIHdvdWxkIHBva2UgaW50ZXJuYWwgcmVn
aXN0ZXJzIHRvIGRldGVjdCANCmlmIGEgZmVhdHVyZSBpcyBpbXBsZW1lbnRlZCBvciBub3Qu
IFRodXMsIGl0J3Mgbm90IG9idmlvdXMgd2h5IHdlIG5lZWQgDQp0byBleHBvc2UgdGhhdCBu
b3cuIElmIHdlIGRvbid0IGhhdmUgYW4gYW5zd2VyIHRvIHRoYXQsIEkgc3VnZ2VzdCB0byAN
CnBvc3Rwb25lIHRoaXMgcGFydCBvZiB0aGUgc2VyaWVzIHVudGlsIHdlIGdldCBhIHJlYWwg
dXNlIGNhc2UuDQoNCkZvciB0aGUgY2xlYW51cCBwYXJ0LCBhcyBJIG1lbnRpb25lZCBiZWZv
cmUsIEknbSB0b3RhbGx5IG9rIHdpdGggaXQuDQo=

