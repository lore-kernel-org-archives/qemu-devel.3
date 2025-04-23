Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FBCC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 06:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7TWv-0001Jy-Qm; Wed, 23 Apr 2025 02:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7TWr-0001Jg-Po
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:24:17 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7TWp-0002k4-Eq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:24:17 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso5758883b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745389453; x=1745994253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uYLNFbV2mBhrjSmZYGXIrQyigFWpGWQSQPqU8Bj8NOE=;
 b=KRr2vRqKDmQnVmvNl35kLmHtZCAkb1LDqwv78ycb1c4p4WkjXBGxBpO23iqHf7ect3
 gwAuqAjCzcIvuviWEStpQDe7EI/Bx5lYFuhPucBhcC9ApGCJV3I+jSa3zQMUw9I2aIIS
 fJ46InPClKYZEUS7JN2H4d5V203D4NpeoJfwnky3QNKJqw0Q4htxwC8wau9ijbzOcej/
 DsNLi6edrT7tm70af4NvxDU0zsjjyRp91ntbmxA9yPAXg7U9MNY3QMV8ALwSe9BMbCA3
 j9mvbGEhDiYacunFTvQoLduVxpqkTIa53PDpatzLNWg6o2QUBV4DjyOBzdZFnawfOocB
 4Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745389453; x=1745994253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uYLNFbV2mBhrjSmZYGXIrQyigFWpGWQSQPqU8Bj8NOE=;
 b=u1WEJbtlqCEbLaq/meC+dyvt4bo5P+gjVylcKaMnsLQomgZmJ9KK2v8n4lr3wGtPef
 tFS1wUVeI07JjqZNcBBw11eDX+uSJ/9UTbDl0rcxYujiKSDyZpw6qz1/OxqT+lWqKK9G
 BUxMUVKUxjRaec3zRydGtkMShU9YrXH6gT4eeTrvFflNvbCMZzWc3V9bDhEqikZCK5iJ
 oHHuF88vlIusipnMQSTfpj4iqb2SE5yCVZi7JkG4sqODSne+XNkM5wR5t7Kir/91a3UI
 jOEcQN/9BAG+5xq3RPZifW+awRI8+G7+xabujUYKaQCI47+aeAia9rJFU2DZ/1cRhGUU
 eMFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI6XLfjg/hJKUcaWirrzxcRFmnCYG2JFrEZJCN0zRYwUpFa+Iibl+UaRXYoTZ3aHg2j4tKUkr+qSiZ@nongnu.org
X-Gm-Message-State: AOJu0YxhG6kbFR+7yZg+DIt/cGZ1z/Ra0dxG4zaWv74W6zExf9OT+XWJ
 Pc1zg84Jxpc0z1eRPknpMq02+OOdAojUkQHxJ6jXo29lrZU3EJdmCCQoc3LJq5w=
X-Gm-Gg: ASbGncsjUPfov180WhQiH2WVVaHmqf+aWBvlgIlczGHpI3yKMfeOAaPSBGjr48xsqah
 c+Xv6i7cz47tz3JFazf0VjJkWZmWt/wjidg1UZZZ+ebwxIS+inAiH19MSp82xcWoYrJuMYkwd7J
 w4Lguz9K9CPCF5VeEkoLViOm6U1EKoxBnwRABffzckboNW+wsw31DXDnHB4od2+0LGBrx2WYMaC
 nOVcMUO8SLZ0+vdZIeT091fSTT/gCcb0gwqOWIAzdgyM4uDfhvK/suPskUQlXQ0Q9QHa8QxWTkW
 M7tKbXDNvemJwIyAYgVf/CtpV6zH4fLsOHsPZ3MA+spp8HSNN5NgTQ==
X-Google-Smtp-Source: AGHT+IEeHADJ8NxZmL57PBp7P4ZKHOU974arlbmiAu2ILAR8/AHzIjO9fKVbWhPKWh2ihNXAvUWPDg==
X-Received: by 2002:a05:6a21:158d:b0:1f5:591b:4f73 with SMTP id
 adf61e73a8af0-203cbd36613mr29585169637.34.1745389452731; 
 Tue, 22 Apr 2025 23:24:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e46e3sm10140312b3a.59.2025.04.22.23.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 23:24:12 -0700 (PDT)
Message-ID: <7c1d7d7b-f58d-40f6-9a1b-c80231681b89@linaro.org>
Date: Tue, 22 Apr 2025 23:24:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-15-philmd@linaro.org>
 <cc5114fe-c17d-4e02-96f2-135ee1c7fa09@linaro.org>
 <a8a701b4-9da5-45d1-88e2-6a708b425146@linaro.org>
 <5c3cebf7-665d-4c07-97d8-cf913e78c3f0@linaro.org>
 <65ae1a3d-0376-4b66-8354-227303d8b90c@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <65ae1a3d-0376-4b66-8354-227303d8b90c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

T24gNC8yMi8yNSAyMjozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDIyLzQvMjUgMjA6MzAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzIyLzI1
IDExOjI0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAyMi80LzI1
IDIwOjIwLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBPbiA0LzIyLzI1IDA3OjU0
LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4+Pj4+IC0t
LQ0KPj4+Pj4gIMKgwqAgaW5jbHVkZS9xZW11L3RhcmdldC1pbmZvLWltcGwuaMKgwqAgfCA0
ICsrKysNCj4+Pj4+ICDCoMKgIGNvbmZpZ3MvdGFyZ2V0cy9hYXJjaDY0LXNvZnRtbXUuYyB8
IDEgKw0KPj4+Pj4gIMKgwqAgY29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmPCoMKgwqDC
oCB8IDEgKw0KPj4+Pj4gIMKgwqAgdGFyZ2V0LWluZm8tc3R1Yi5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMSArDQo+Pj4+PiAgwqDCoCA0IGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUv
dGFyZ2V0LWluZm8taW1wbC5oIGIvaW5jbHVkZS9xZW11L3RhcmdldC0NCj4+Pj4+IGluZm8t
aW1wbC5oDQo+Pj4+PiBpbmRleCA0ZWY1NGM1MTM2YS4uZTVjZDE2OWI0OWEgMTAwNjQ0DQo+
Pj4+PiAtLS0gYS9pbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8taW1wbC5oDQo+Pj4+PiArKysg
Yi9pbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8taW1wbC5oDQo+Pj4+PiBAQCAtMTAsMTIgKzEw
LDE2IEBADQo+Pj4+PiAgwqDCoCAjZGVmaW5lIFFFTVVfVEFSR0VUX0lORk9fSU1QTF9IDQo+
Pj4+PiAgwqDCoCAjaW5jbHVkZSAicWVtdS90YXJnZXQtaW5mby5oIg0KPj4+Pj4gKyNpbmNs
dWRlICJxYXBpL3FhcGktdHlwZXMtbWFjaGluZS5oIg0KPj4+Pj4gIMKgwqAgdHlwZWRlZiBz
dHJ1Y3QgVGFyZ2V0SW5mbyB7DQo+Pj4+PiAgwqDCoMKgwqDCoMKgIC8qIHJ1bnRpbWUgZXF1
aXZhbGVudCBvZiBUQVJHRVRfTkFNRSBkZWZpbml0aW9uICovDQo+Pj4+PiAgwqDCoMKgwqDC
oMKgIGNvbnN0IGNoYXIgKmNvbnN0IHRhcmdldF9uYW1lOw0KPj4+Pj4gK8KgwqDCoCAvKiBy
ZWxhdGVkIHRvIFRBUkdFVF9BUkNIIGRlZmluaXRpb24gKi8NCj4+Pj4+ICvCoMKgwqAgU3lz
RW11VGFyZ2V0IHRhcmdldF9hcmNoOw0KPj4+Pj4gKw0KPj4+Pj4gIMKgwqDCoMKgwqDCoCAv
KiBRT00gdHlwZW5hbWUgbWFjaGluZXMgZm9yIHRoaXMgYmluYXJ5IG11c3QgaW1wbGVtZW50
ICovDQo+Pj4+PiAgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKmNvbnN0IG1hY2hpbmVfdHlw
ZW5hbWU7DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvY29uZmlncy90YXJnZXRzL2FhcmNoNjQtc29m
dG1tdS5jIGIvY29uZmlncy90YXJnZXRzLw0KPj4+Pj4gYWFyY2g2NC1zb2Z0bW11LmMNCj4+
Pj4+IGluZGV4IDM3NWU2ZmEwYjdiLi5mZjg5NDAxZWEzNCAxMDA2NDQNCj4+Pj4+IC0tLSBh
L2NvbmZpZ3MvdGFyZ2V0cy9hYXJjaDY0LXNvZnRtbXUuYw0KPj4+Pj4gKysrIGIvY29uZmln
cy90YXJnZXRzL2FhcmNoNjQtc29mdG1tdS5jDQo+Pj4+PiBAQCAtMTMsNiArMTMsNyBAQA0K
Pj4+Pj4gIMKgwqAgc3RhdGljIGNvbnN0IFRhcmdldEluZm8gdGFyZ2V0X2luZm9fYWFyY2g2
NF9zeXN0ZW0gPSB7DQo+Pj4+PiAgwqDCoMKgwqDCoMKgIC50YXJnZXRfbmFtZSA9ICJhYXJj
aDY0IiwNCj4+Pj4+ICvCoMKgwqAgLnRhcmdldF9hcmNoID0gU1lTX0VNVV9UQVJHRVRfQUFS
Q0g2NCwNCj4+Pj4+ICDCoMKgwqDCoMKgwqAgLm1hY2hpbmVfdHlwZW5hbWUgPSBUWVBFX1RB
UkdFVF9BQVJDSDY0X01BQ0hJTkUsDQo+Pj4+PiAgwqDCoCB9Ow0KPj4+Pj4gZGlmZiAtLWdp
dCBhL2NvbmZpZ3MvdGFyZ2V0cy9hcm0tc29mdG1tdS5jIGIvY29uZmlncy90YXJnZXRzL2Fy
bS0NCj4+Pj4+IHNvZnRtbXUuYw0KPj4+Pj4gaW5kZXggZDRhY2RhZTY0ZjMuLjIyZWM5ZTRm
YWEzIDEwMDY0NA0KPj4+Pj4gLS0tIGEvY29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmMN
Cj4+Pj4+ICsrKyBiL2NvbmZpZ3MvdGFyZ2V0cy9hcm0tc29mdG1tdS5jDQo+Pj4+PiBAQCAt
MTMsNiArMTMsNyBAQA0KPj4+Pj4gIMKgwqAgc3RhdGljIGNvbnN0IFRhcmdldEluZm8gdGFy
Z2V0X2luZm9fYXJtX3N5c3RlbSA9IHsNCj4+Pj4+ICDCoMKgwqDCoMKgwqAgLnRhcmdldF9u
YW1lID0gImFybSIsDQo+Pj4+PiArwqDCoMKgIC50YXJnZXRfYXJjaCA9IFNZU19FTVVfVEFS
R0VUX0FSTSwNCj4+Pj4+ICDCoMKgwqDCoMKgwqAgLm1hY2hpbmVfdHlwZW5hbWUgPSBUWVBF
X1RBUkdFVF9BUk1fTUFDSElORSwNCj4+Pj4+ICDCoMKgIH07DQo+Pj4+PiBkaWZmIC0tZ2l0
IGEvdGFyZ2V0LWluZm8tc3R1Yi5jIGIvdGFyZ2V0LWluZm8tc3R1Yi5jDQo+Pj4+PiBpbmRl
eCAyMThlNTg5OGU3Zi4uZTU3M2Y1YzE5NzUgMTAwNjQ0DQo+Pj4+PiAtLS0gYS90YXJnZXQt
aW5mby1zdHViLmMNCj4+Pj4+ICsrKyBiL3RhcmdldC1pbmZvLXN0dWIuYw0KPj4+Pj4gQEAg
LTEyLDYgKzEyLDcgQEANCj4+Pj4+ICDCoMKgIHN0YXRpYyBjb25zdCBUYXJnZXRJbmZvIHRh
cmdldF9pbmZvX3N0dWIgPSB7DQo+Pj4+PiAgwqDCoMKgwqDCoMKgIC50YXJnZXRfbmFtZSA9
IFRBUkdFVF9OQU1FLA0KPj4+Pj4gK8KgwqDCoCAudGFyZ2V0X2FyY2ggPSAtMSwNCj4+Pj4N
Cj4+Pj4gSSB0aGluayB3ZSBzaG91bGQgaGF2ZSBhIGZ1bGwgaWZkZWYgbGFkZGVyIGhlcmUs
IHRvIGhhbmRsZSBhbGwNCj4+Pj4gYXJjaGl0ZWN0dXJlcy4gU2V0dGluZyAtMSBpcyBub3Qg
YSBzYWZlIGRlZmF1bHQuDQo+Pj4NCj4+PiBUYXJnZXRJbmZvIGRlZmluaXRpb24gaXMgaW50
ZXJuYWwgdG8gInFlbXUvdGFyZ2V0LWluZm8taW1wbC5oIiwNCj4+PiBvdGhlcndpc2UgaXRz
IHR5cGUgaXMgZm9yd2FyZC1kZWNsYXJlZCBhcyBvcGFxdWUuDQo+Pj4NCj4+DQo+PiBGaW5l
LCBidXQgd2UgbmVlZCB0byBiZSBhYmxlIHRvIGFjY2VzcyB0byB0YXJnZXRfYXJjaCgpLCB3
aGljaCByZXR1cm5zDQo+PiB0aGUgZW51bSB2YWx1ZSwgd2l0aG91dCBoYXZpbmcgdG8gZGVh
bCB3aXRoIC0xIHNpdHVhdGlvbiwgd2hpY2ggaXMgbm90IGENCj4+IHByb3BlciBlbnVtIHZh
bHVlLg0KPj4NCj4+IHN3aXRjaCAodGFyZ2V0X2FyY2goKSkgew0KPj4gY2FzZSBTWVNfRU1V
X1RBUkdFVF9BUk06DQo+PiBjYXNlIFNZU19FTVVfVEFSR0VUX0FBUkNINjQ6DQo+PiAuLi4N
Cj4+IGRlZmF1bHQ6DQo+PiAgIMKgwqDCoMKgYnJlYWs7DQo+PiB9DQo+IA0KPiBJIGRpZG4n
dCBtZW50aW9uZWQgdGhhdCBiZWNhdXNlIGluDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMzI0MmNlZTYtNzQ4NS00OTU4LWExOTgtMzhkMGZjNjhlOGNkQGxpbmFy
by5vcmcvDQo+IHlvdSBzYWlkOg0KPiANCj4gICAgIEF0IHRoaXMgcG9pbnQsIEkgd291bGQg
bGlrZSB0byBmb2N1cyBvbiBoYXZpbmcgYSBmaXJzdCB2ZXJzaW9uIG9mDQo+ICAgICBUYXJn
ZXRJbmZvIEFQSSwgYW5kIG5vdCByZXZpZXdpbmcgYW55IG90aGVyIGNoYW5nZXMsIGFzIHRo
aW5ncyBtYXkNCj4gICAgIGJlIG1vZGlmaWVkLCBhbmQgdGhleSB3b3VsZCBuZWVkIHRvIGJl
IHJldmlld2VkIGFnYWluLiBJdCdzIGhhcmQNCj4gICAgIHRvIGZvbGxvdyB0aGUgc2FtZSBh
YnN0cmFjdGlvbiBkb25lIG11bHRpcGxlIHRpbWVzIGluIG11bHRpcGxlIHNlcmllcy4NCj4N
Cj4gV2hhdCBpcyB5b3VyICJmdWxsIGlmZGVmIGxhZGRlciIgc3VnZ2VzdGlvbiB0byBhdm9p
ZCAtMT8NCg0KI2lmZGVmIFRBUkdFVF9BQVJDSDY0DQojIGRlZmluZSBUQVJHRVRfQVJDSCBT
WVNfRU1VX1RBUkdFVF9BQVJDSDY0DQojZWxpZiBUQVJHRVRfQVJDSF9BTFBIQQ0KIyBkZWZp
bmUgVEFSR0VUX0FSQ0ggU1lTX0VNVV9UQVJHRVRfQUxQSEENCi4uLg0KI2Vsc2UNCiNlcnJv
ciBUYXJnZXQgYXJjaGl0ZWN0dXJlIGNhbid0IGJlIGRldGVjdGVkDQojZW5kaWYNCg0Kc3Rh
dGljIGNvbnN0IFRhcmdldEluZm8gdGFyZ2V0X2luZm9fc3R1YiA9IHsNCiAgICAgIC4uLg0K
ICAgICAgLnRhcmdldF9hcmNoID0gVEFSR0VUX0FSQ0g7DQogICAgICAuLi4NCn0NCg0KT25l
IGltcG9ydGFudCBzdHVmZiBpcyB0byBtYWtlIHN1cmUgd2UgdHJlYXQgY29ycmVjdGx5IGJp
dG5lc3MgdmFyaWFudHMgDQpvZiBhIGdpdmVuIGFyY2g6IFRBUkdFVF9BQVJDSDY0IHNob3Vs
ZCBiZSB0ZXN0ZWQgKmJlZm9yZSogVEFSR0VUX0FSTSwgDQphbmQgc2FtZSBmb3Igb3RoZXIg
YmFzZSBhcmNoaXRlY3R1cmVzLg0KQmVzaWRlcyB0aGF0LCBpdCdzIHN0cmFpZ2h0Zm9yd2Fy
ZCwgYW5kIHdlIGNhbiBlYXNpbHkgaW50ZWdyYXRlIHRoYXQgaW4gDQp0aGlzIHNlcmllcy4N
Cg==

