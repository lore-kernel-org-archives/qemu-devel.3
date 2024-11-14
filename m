Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053E6D637DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRDy-00077K-13; Wed, 13 Nov 2024 23:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRDu-0006pr-MZ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:12:50 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRDq-0003op-Ca
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:12:50 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2114214c63eso1063695ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557565; x=1732162365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wRDVQUllrBRYv6rny84HKQVaKvEZvtUPh5K3yJfI6Cg=;
 b=NvsY62tTPy6d8codqmq3U2YsrdbhJSOK2lTdpLQwsgMBJTF+UcwVIjQB7onI0gMTdB
 yUdsZdQHHY/X/no4epE85ILLEHpslV+jHR8bCtcV+LMDOFwA3U687F0Tsb0ijlRKfNXg
 ejCgQIUxK+G33kOXwG5oTZRhaSdQIhB7ZH1U1LYbFerrEV/VTBe2rO+S1kvrh8lWUCNt
 urgPwpmtbd29pl9M/V+CLls7EYrUVCnRzt6bRxWBCH4f5Wf0XxT9bR209FRpyUhnPs/g
 3XZaD3D+Io+XqFp9SZGkGYMzpX2fqjiD1yMSGfTg5Uved10Uls+DeVKaMQTWkwvzXpNS
 gWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557565; x=1732162365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wRDVQUllrBRYv6rny84HKQVaKvEZvtUPh5K3yJfI6Cg=;
 b=fKhV5PuUmTNSXIUwYzwPQjxQa+ExRuno3PQ9sprWkysr3w+3espvB03hLN69IpSXDo
 O9MPXw+/D2TV7/MYioPOr5KS9i6O7G/8vweUYFrsk8VeNgJfr2adKvvNxRMiCDrPo3bU
 8Cr19kh9Tr3sSl8ARlFKucNHJAW4/rZFHD3+7Mos7MI/PXNEX9wB49mGmTKN1jR7PNxI
 lwtyltPTSSAk5v0JOMxbqfF0aNMlOr3KAtwf6t6TrymOfMIFdfOYHltKH6tJxREdm4a7
 iKFT7SzxVYGMHltYT3ImsjekFqmOjo+nq7pUZj/YPmTgmw7RLga3vaOJFx1yMNwsb2Qp
 3wng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeVMoXywYINwWoHAfX6RUpLyHOBnJhBJat4iRoXFWdlokhWR4/Xbkoe235+DuGMrTWgI1IHjnbNYys@nongnu.org
X-Gm-Message-State: AOJu0Yy5ZVktCgeeX5vyGSpbIU2RL7lb66KnU7n5f8AH6aeworH7ajmD
 qUi+tTLHJV+wQB+boq72hNOLVTjBmuJfSHIRfiAj/QJTrTLVZj8UnukUWIAdnB4=
X-Google-Smtp-Source: AGHT+IF+S2XirUDimkdKvMiEJsVH7iRRx9lheHPdhuThgvThwyw9kn6yO/wwzpuAwMtiMMbI0fzp3Q==
X-Received: by 2002:a17:903:11c9:b0:20c:cccd:17a3 with SMTP id
 d9443c01a7336-2118359c11amr310889535ad.46.1731557564850; 
 Wed, 13 Nov 2024 20:12:44 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d018e9sm1412135ad.174.2024.11.13.20.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:12:44 -0800 (PST)
Message-ID: <c2f927c3-321e-43a5-b9c3-7cf41cb746ba@linaro.org>
Date: Wed, 13 Nov 2024 20:12:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/24] accel/tcg: Have tlb_vaddr_to_host() use vaddr type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-13-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-13-philmd@linaro.org>
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

T24gMTEvMTMvMjQgMTc6MTIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBh
YmlfcHRyIGlzIGV4cGVjdGVkIHRvIGJlIHVzZWQgaW4gdXNlciBlbXVsYXRpb24uDQo+IHRs
Yl92YWRkcl90b19ob3N0KCkgdXNlcyBpdCwgYnV0IGNhbiBiZSB1c2VkIGluDQo+IHN5c3Rl
bSBlbXVsYXRpb24uIFJlcGxhY2UgdGhlIHR5cGUgYnkgJ3ZhZGRyJyB3aGljaA0KPiBpcyBl
cXVpdmFsZW50IG9uIHVzZXIgZW11bGF0aW9uIGJ1dCBhbHNvIHdvcmtzIG9uDQo+IHN5c3Rl
bS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9leGVjL2NwdV9sZHN0LmggfCAz
ICsrLQ0KPiAgIGFjY2VsL3RjZy9jcHV0bGIuYyAgICAgIHwgMiArLQ0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvZXhlYy9jcHVfbGRzdC5oIGIvaW5jbHVkZS9leGVjL2NwdV9sZHN0
LmgNCj4gaW5kZXggYTI2YWI0OWIwYi4uNzY5ZTlmYzQ0MCAxMDA2NDQNCj4gLS0tIGEvaW5j
bHVkZS9leGVjL2NwdV9sZHN0LmgNCj4gKysrIGIvaW5jbHVkZS9leGVjL2NwdV9sZHN0LmgN
Cj4gQEAgLTY3LDYgKzY3LDcgQEANCj4gICAjZW5kaWYNCj4gICANCj4gICAjaW5jbHVkZSAi
ZXhlYy9tZW1vcGlkeC5oIg0KPiArI2luY2x1ZGUgImV4ZWMvdmFkZHIuaCINCj4gICAjaW5j
bHVkZSAiZXhlYy9hYmlfcHRyLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvbW11LWFjY2Vzcy10
eXBlLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvaW50MTI4LmgiDQo+IEBAIC0zMzAsNyArMzMx
LDcgQEAgc3RhdGljIGlubGluZSB2b2lkICp0bGJfdmFkZHJfdG9faG9zdChDUFVBcmNoU3Rh
dGUgKmVudiwgYWJpX3B0ciBhZGRyLA0KPiAgICAgICByZXR1cm4gZzJoKGVudl9jcHUoZW52
KSwgYWRkcik7DQo+ICAgfQ0KPiAgICNlbHNlDQo+IC12b2lkICp0bGJfdmFkZHJfdG9faG9z
dChDUFVBcmNoU3RhdGUgKmVudiwgYWJpX3B0ciBhZGRyLA0KPiArdm9pZCAqdGxiX3ZhZGRy
X3RvX2hvc3QoQ1BVQXJjaFN0YXRlICplbnYsIHZhZGRyIGFkZHIsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSwgaW50IG1tdV9pZHgp
Ow0KPiAgICNlbmRpZg0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvdGNnL2NwdXRsYi5j
IGIvYWNjZWwvdGNnL2NwdXRsYi5jDQo+IGluZGV4IGI3NmE0ZWFjNGUuLjA4MGNiY2IzNGQg
MTAwNjQ0DQo+IC0tLSBhL2FjY2VsL3RjZy9jcHV0bGIuYw0KPiArKysgYi9hY2NlbC90Y2cv
Y3B1dGxiLmMNCj4gQEAgLTE1MDQsNyArMTUwNCw3IEBAIHZvaWQgKnByb2JlX2FjY2VzcyhD
UFVBcmNoU3RhdGUgKmVudiwgdmFkZHIgYWRkciwgaW50IHNpemUsDQo+ICAgICAgIHJldHVy
biBob3N0Ow0KPiAgIH0NCj4gICANCj4gLXZvaWQgKnRsYl92YWRkcl90b19ob3N0KENQVUFy
Y2hTdGF0ZSAqZW52LCBhYmlfcHRyIGFkZHIsDQo+ICt2b2lkICp0bGJfdmFkZHJfdG9faG9z
dChDUFVBcmNoU3RhdGUgKmVudiwgdmFkZHIgYWRkciwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBNTVVBY2Nlc3NUeXBlIGFjY2Vzc190eXBlLCBpbnQgbW11X2lkeCkNCj4gICB7
DQo+ICAgICAgIENQVVRMQkVudHJ5RnVsbCAqZnVsbDsNCg0KUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

