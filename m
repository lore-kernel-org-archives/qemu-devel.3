Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A49C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 06:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Tae-0002HH-8c; Wed, 23 Apr 2025 02:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7Tab-0002Gz-Jg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:28:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7TaX-0003H9-4o
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:28:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2241053582dso84261365ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 23:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745389683; x=1745994483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rUHrpIwxYsrTJ4Wsfcc7umTzEJ/d26DyNx3Z1UTWhJM=;
 b=yMvOLVtfCfIZuCfziKQeJ8i4a8VDLgXinW64iDv88l2wikww0LpoP/6ZCX42ZaXIa5
 6wf2iqS9tAMqQ1RMHQCqoa2Jrh49ohL0ZZC7N4hWNpXCRZieqDYcOadXayQWh7vaYTL9
 cV8nzmzcj771WCZWBpkqeWhv2JJXMsdi4/D3QMsKgYLTiBe2QRR+vOFQLkQR9t7kOR5B
 D/pIEE4fBgKGS/7EVXqG0I1AYVcaAI3iIJC0o/h9CVBLRXZOaL4IqJmzckyTX7xODLbG
 FOrk262xr8HjtMKiGOXzc6gN/RRIYmvaMdXNxvc8RxpCt1XmblL6MquC12ev1jWH4Re/
 gwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745389683; x=1745994483;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rUHrpIwxYsrTJ4Wsfcc7umTzEJ/d26DyNx3Z1UTWhJM=;
 b=L6guodyz+zTZoDBGhET3OWetMOMCBMp+hEKgQ5q4vZYCrvJlwxUpEiKsKeOBl3sPP/
 kNuKPh83o2xYrfJ1pV+I96wjF0vMGJmWctJyBshh+yzdix1YtDxioYOnyAYvIHUSzSst
 cjcWYQBQ/T7t+1TkL25L9gsPVy3TEj9BWPruX10nHop57Ji0R+Xxmh8z7JfL6vCSCCzI
 zOIxkiffk2d1VeD4gfmOYWHHZ4/Dfd+aR7F1SWYQCCME+d9gxI1GeRIpzPd09uKWp+t9
 HZ8io/nDCT7ysbdBPgJRbiNaDw+vGjqJD0RzdMLNzrgxUrHbOqGtGEK6JsfJw1c2PEY1
 cLVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7i00rs9aTg+rzBCM2Llwp0AYxu+kTJq50VtqpANnjv/cfpXRgn76yJW6FTFUROKUTA2pvNvLqjPBa@nongnu.org
X-Gm-Message-State: AOJu0Yw29tfJP5yeaSOfoANj/lIPsVxAAEnt4nZZKcrY4Ypu+dwONT7N
 D46wnEDopxA7Nk66HyRgWYTOiA1mmcVHgYzDK3fILUdi0OBwfJfA6wT5st7qk2M=
X-Gm-Gg: ASbGncuL4PzdQBdwZNX2qQ2WO8umvDoXjBtm3s1e0Ow0McOafsvtijrG4CzqIgMEETG
 qPg1bxgjHB/ABeZje2Q1ttu8e3cTjrDNeb8LVJ+Xf4Gr96Neb3LvqVd6C39THX2nCYYBcz4Z7Ou
 gQiiBA/QD1/j+KFd6Rs/R8/ifqd4sQMPCywyCAOoDfwaIBOz4awPAhS5W58hOyGXggs73+OwWqU
 94btXXVJ+pMgM9S8KSm4RpKql/Ym7X/+/TmwxipObuLlE6X7x6imNFELS6/7eNQ/g78XW55FRWw
 tic2CG91pFUVeFT38RbgvbtO0u7suHf6eyJ/bBProilTMVpr955Wyg==
X-Google-Smtp-Source: AGHT+IGxAbR4r3Hj/JBdhVBInrRKmNcgqZGClzzDufMvfCCDVoKXPorI+W0zNwHK6PnuiNPMW92Wew==
X-Received: by 2002:a17:902:ce01:b0:21f:7082:1137 with SMTP id
 d9443c01a7336-22c5357d158mr319415975ad.22.1745389683449; 
 Tue, 22 Apr 2025 23:28:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309dfa29411sm753923a91.30.2025.04.22.23.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 23:28:03 -0700 (PDT)
Message-ID: <07fac8ed-cd24-46e0-b933-36fa278fd749@linaro.org>
Date: Tue, 22 Apr 2025 23:28:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
 <7c1d7d7b-f58d-40f6-9a1b-c80231681b89@linaro.org>
In-Reply-To: <7c1d7d7b-f58d-40f6-9a1b-c80231681b89@linaro.org>
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

T24gNC8yMi8yNSAyMzoyNCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gNC8yMi8y
NSAyMjozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+PiBPbiAyMi80LzI1
IDIwOjMwLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IE9uIDQvMjIvMjUgMTE6MjQs
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+PiBPbiAyMi80LzI1IDIwOjIw
LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+Pj4gT24gNC8yMi8yNSAwNzo1NCwgUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPj4+Pj4+IC0tLQ0K
Pj4+Pj4+ICAgwqDCoCBpbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8taW1wbC5owqDCoCB8IDQg
KysrKw0KPj4+Pj4+ICAgwqDCoCBjb25maWdzL3RhcmdldHMvYWFyY2g2NC1zb2Z0bW11LmMg
fCAxICsNCj4+Pj4+PiAgIMKgwqAgY29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmPCoMKg
wqDCoCB8IDEgKw0KPj4+Pj4+ICAgwqDCoCB0YXJnZXQtaW5mby1zdHViLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxICsNCj4+Pj4+PiAgIMKgwqAgNCBmaWxlcyBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKykNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3FlbXUvdGFyZ2V0LWluZm8taW1wbC5oIGIvaW5jbHVkZS9xZW11L3RhcmdldC0NCj4+
Pj4+PiBpbmZvLWltcGwuaA0KPj4+Pj4+IGluZGV4IDRlZjU0YzUxMzZhLi5lNWNkMTY5YjQ5
YSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9pbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8taW1wbC5o
DQo+Pj4+Pj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldC1pbmZvLWltcGwuaA0KPj4+Pj4+
IEBAIC0xMCwxMiArMTAsMTYgQEANCj4+Pj4+PiAgIMKgwqAgI2RlZmluZSBRRU1VX1RBUkdF
VF9JTkZPX0lNUExfSA0KPj4+Pj4+ICAgwqDCoCAjaW5jbHVkZSAicWVtdS90YXJnZXQtaW5m
by5oIg0KPj4+Pj4+ICsjaW5jbHVkZSAicWFwaS9xYXBpLXR5cGVzLW1hY2hpbmUuaCINCj4+
Pj4+PiAgIMKgwqAgdHlwZWRlZiBzdHJ1Y3QgVGFyZ2V0SW5mbyB7DQo+Pj4+Pj4gICDCoMKg
wqDCoMKgwqAgLyogcnVudGltZSBlcXVpdmFsZW50IG9mIFRBUkdFVF9OQU1FIGRlZmluaXRp
b24gKi8NCj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpjb25zdCB0YXJnZXRf
bmFtZTsNCj4+Pj4+PiArwqDCoMKgIC8qIHJlbGF0ZWQgdG8gVEFSR0VUX0FSQ0ggZGVmaW5p
dGlvbiAqLw0KPj4+Pj4+ICvCoMKgwqAgU3lzRW11VGFyZ2V0IHRhcmdldF9hcmNoOw0KPj4+
Pj4+ICsNCj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCAvKiBRT00gdHlwZW5hbWUgbWFjaGluZXMg
Zm9yIHRoaXMgYmluYXJ5IG11c3QgaW1wbGVtZW50ICovDQo+Pj4+Pj4gICDCoMKgwqDCoMKg
wqAgY29uc3QgY2hhciAqY29uc3QgbWFjaGluZV90eXBlbmFtZTsNCj4+Pj4+PiBkaWZmIC0t
Z2l0IGEvY29uZmlncy90YXJnZXRzL2FhcmNoNjQtc29mdG1tdS5jIGIvY29uZmlncy90YXJn
ZXRzLw0KPj4+Pj4+IGFhcmNoNjQtc29mdG1tdS5jDQo+Pj4+Pj4gaW5kZXggMzc1ZTZmYTBi
N2IuLmZmODk0MDFlYTM0IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2NvbmZpZ3MvdGFyZ2V0cy9h
YXJjaDY0LXNvZnRtbXUuYw0KPj4+Pj4+ICsrKyBiL2NvbmZpZ3MvdGFyZ2V0cy9hYXJjaDY0
LXNvZnRtbXUuYw0KPj4+Pj4+IEBAIC0xMyw2ICsxMyw3IEBADQo+Pj4+Pj4gICDCoMKgIHN0
YXRpYyBjb25zdCBUYXJnZXRJbmZvIHRhcmdldF9pbmZvX2FhcmNoNjRfc3lzdGVtID0gew0K
Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgIC50YXJnZXRfbmFtZSA9ICJhYXJjaDY0IiwNCj4+Pj4+
PiArwqDCoMKgIC50YXJnZXRfYXJjaCA9IFNZU19FTVVfVEFSR0VUX0FBUkNINjQsDQo+Pj4+
Pj4gICDCoMKgwqDCoMKgwqAgLm1hY2hpbmVfdHlwZW5hbWUgPSBUWVBFX1RBUkdFVF9BQVJD
SDY0X01BQ0hJTkUsDQo+Pj4+Pj4gICDCoMKgIH07DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2Nv
bmZpZ3MvdGFyZ2V0cy9hcm0tc29mdG1tdS5jIGIvY29uZmlncy90YXJnZXRzL2FybS0NCj4+
Pj4+PiBzb2Z0bW11LmMNCj4+Pj4+PiBpbmRleCBkNGFjZGFlNjRmMy4uMjJlYzllNGZhYTMg
MTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvY29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmMNCj4+
Pj4+PiArKysgYi9jb25maWdzL3RhcmdldHMvYXJtLXNvZnRtbXUuYw0KPj4+Pj4+IEBAIC0x
Myw2ICsxMyw3IEBADQo+Pj4+Pj4gICDCoMKgIHN0YXRpYyBjb25zdCBUYXJnZXRJbmZvIHRh
cmdldF9pbmZvX2FybV9zeXN0ZW0gPSB7DQo+Pj4+Pj4gICDCoMKgwqDCoMKgwqAgLnRhcmdl
dF9uYW1lID0gImFybSIsDQo+Pj4+Pj4gK8KgwqDCoCAudGFyZ2V0X2FyY2ggPSBTWVNfRU1V
X1RBUkdFVF9BUk0sDQo+Pj4+Pj4gICDCoMKgwqDCoMKgwqAgLm1hY2hpbmVfdHlwZW5hbWUg
PSBUWVBFX1RBUkdFVF9BUk1fTUFDSElORSwNCj4+Pj4+PiAgIMKgwqAgfTsNCj4+Pj4+PiBk
aWZmIC0tZ2l0IGEvdGFyZ2V0LWluZm8tc3R1Yi5jIGIvdGFyZ2V0LWluZm8tc3R1Yi5jDQo+
Pj4+Pj4gaW5kZXggMjE4ZTU4OThlN2YuLmU1NzNmNWMxOTc1IDEwMDY0NA0KPj4+Pj4+IC0t
LSBhL3RhcmdldC1pbmZvLXN0dWIuYw0KPj4+Pj4+ICsrKyBiL3RhcmdldC1pbmZvLXN0dWIu
Yw0KPj4+Pj4+IEBAIC0xMiw2ICsxMiw3IEBADQo+Pj4+Pj4gICDCoMKgIHN0YXRpYyBjb25z
dCBUYXJnZXRJbmZvIHRhcmdldF9pbmZvX3N0dWIgPSB7DQo+Pj4+Pj4gICDCoMKgwqDCoMKg
wqAgLnRhcmdldF9uYW1lID0gVEFSR0VUX05BTUUsDQo+Pj4+Pj4gK8KgwqDCoCAudGFyZ2V0
X2FyY2ggPSAtMSwNCj4+Pj4+DQo+Pj4+PiBJIHRoaW5rIHdlIHNob3VsZCBoYXZlIGEgZnVs
bCBpZmRlZiBsYWRkZXIgaGVyZSwgdG8gaGFuZGxlIGFsbA0KPj4+Pj4gYXJjaGl0ZWN0dXJl
cy4gU2V0dGluZyAtMSBpcyBub3QgYSBzYWZlIGRlZmF1bHQuDQo+Pj4+DQo+Pj4+IFRhcmdl
dEluZm8gZGVmaW5pdGlvbiBpcyBpbnRlcm5hbCB0byAicWVtdS90YXJnZXQtaW5mby1pbXBs
LmgiLA0KPj4+PiBvdGhlcndpc2UgaXRzIHR5cGUgaXMgZm9yd2FyZC1kZWNsYXJlZCBhcyBv
cGFxdWUuDQo+Pj4+DQo+Pj4NCj4+PiBGaW5lLCBidXQgd2UgbmVlZCB0byBiZSBhYmxlIHRv
IGFjY2VzcyB0byB0YXJnZXRfYXJjaCgpLCB3aGljaCByZXR1cm5zDQo+Pj4gdGhlIGVudW0g
dmFsdWUsIHdpdGhvdXQgaGF2aW5nIHRvIGRlYWwgd2l0aCAtMSBzaXR1YXRpb24sIHdoaWNo
IGlzIG5vdCBhDQo+Pj4gcHJvcGVyIGVudW0gdmFsdWUuDQo+Pj4NCj4+PiBzd2l0Y2ggKHRh
cmdldF9hcmNoKCkpIHsNCj4+PiBjYXNlIFNZU19FTVVfVEFSR0VUX0FSTToNCj4+PiBjYXNl
IFNZU19FTVVfVEFSR0VUX0FBUkNINjQ6DQo+Pj4gLi4uDQo+Pj4gZGVmYXVsdDoNCj4+PiAg
ICDCoMKgwqDCoGJyZWFrOw0KPj4+IH0NCj4+DQo+PiBJIGRpZG4ndCBtZW50aW9uZWQgdGhh
dCBiZWNhdXNlIGluDQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzMy
NDJjZWU2LTc0ODUtNDk1OC1hMTk4LTM4ZDBmYzY4ZThjZEBsaW5hcm8ub3JnLw0KPj4geW91
IHNhaWQ6DQo+Pg0KPj4gICAgICBBdCB0aGlzIHBvaW50LCBJIHdvdWxkIGxpa2UgdG8gZm9j
dXMgb24gaGF2aW5nIGEgZmlyc3QgdmVyc2lvbiBvZg0KPj4gICAgICBUYXJnZXRJbmZvIEFQ
SSwgYW5kIG5vdCByZXZpZXdpbmcgYW55IG90aGVyIGNoYW5nZXMsIGFzIHRoaW5ncyBtYXkN
Cj4+ICAgICAgYmUgbW9kaWZpZWQsIGFuZCB0aGV5IHdvdWxkIG5lZWQgdG8gYmUgcmV2aWV3
ZWQgYWdhaW4uIEl0J3MgaGFyZA0KPj4gICAgICB0byBmb2xsb3cgdGhlIHNhbWUgYWJzdHJh
Y3Rpb24gZG9uZSBtdWx0aXBsZSB0aW1lcyBpbiBtdWx0aXBsZSBzZXJpZXMuDQo+Pg0KPj4g
V2hhdCBpcyB5b3VyICJmdWxsIGlmZGVmIGxhZGRlciIgc3VnZ2VzdGlvbiB0byBhdm9pZCAt
MT8NCj4gDQo+ICNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0KPiAjIGRlZmluZSBUQVJHRVRfQVJD
SCBTWVNfRU1VX1RBUkdFVF9BQVJDSDY0DQo+ICNlbGlmIFRBUkdFVF9BUkNIX0FMUEhBDQo+
ICMgZGVmaW5lIFRBUkdFVF9BUkNIIFNZU19FTVVfVEFSR0VUX0FMUEhBDQo+IC4uLg0KPiAj
ZWxzZQ0KPiAjZXJyb3IgVGFyZ2V0IGFyY2hpdGVjdHVyZSBjYW4ndCBiZSBkZXRlY3RlZA0K
PiAjZW5kaWYNCj4gDQo+IHN0YXRpYyBjb25zdCBUYXJnZXRJbmZvIHRhcmdldF9pbmZvX3N0
dWIgPSB7DQo+ICAgICAgICAuLi4NCj4gICAgICAgIC50YXJnZXRfYXJjaCA9IFRBUkdFVF9B
UkNIOw0KPiAgICAgICAgLi4uDQo+IH0NCj4NCg0KVG8gYmUgY29tcGxldGUsIHdlIHNob3Vs
ZCBhbHNvIGFkZDoNCg0Kc3RhdGljIGlubGluZSBTeXNFbXVUYXJnZXQgdGFyZ2V0X2FyY2go
dm9pZCkgew0KCXJldHVybiB0YXJnZXRfaW5mbygpLT50YXJnZXRfYXJjaDsNCn0NCg0Kc28g
aXQgY2FuIGJlIHVzZWQgYnkgY29kZSBsYXRlciAoUUFQSSBnZW5lcmF0ZWQgZmlsZXMgd2ls
bCBuZWVkIHRoYXQsIA0KYW5kIHZpcnRpbyBkZXZpY2VzIGFzIHlvdSBub3RpY2VkKS4NClRv
IG1ha2UgaXQgdXNlZCB0aHJvdWdoIHRoZSBzZXJpZXMsIHRhcmdldF9hYXJjaDY0KCkgY2Fu
IGJlIHJld3JpdHRlbjoNCg0Kc3RhdGljIGlubGluZSBib29sIHRhcmdldF9hYXJjaDY0KHZv
aWQpIHsNCglyZXR1cm4gdGFyZ2V0X2FyY2goKSA9PSBTWVNfRU1VX1RBUkdFVF9BQVJDSDY0
Ow0KfQ0KDQo+IE9uZSBpbXBvcnRhbnQgc3R1ZmYgaXMgdG8gbWFrZSBzdXJlIHdlIHRyZWF0
IGNvcnJlY3RseSBiaXRuZXNzIHZhcmlhbnRzDQo+IG9mIGEgZ2l2ZW4gYXJjaDogVEFSR0VU
X0FBUkNINjQgc2hvdWxkIGJlIHRlc3RlZCAqYmVmb3JlKiBUQVJHRVRfQVJNLA0KPiBhbmQg
c2FtZSBmb3Igb3RoZXIgYmFzZSBhcmNoaXRlY3R1cmVzLg0KPiBCZXNpZGVzIHRoYXQsIGl0
J3Mgc3RyYWlnaHRmb3J3YXJkLCBhbmQgd2UgY2FuIGVhc2lseSBpbnRlZ3JhdGUgdGhhdCBp
bg0KPiB0aGlzIHNlcmllcy4NCg0K

