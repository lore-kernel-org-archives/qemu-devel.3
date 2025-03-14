Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B60C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 16:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8Hd-0007sF-9j; Fri, 14 Mar 2025 12:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8Ha-0007r3-VG
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:53:16 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8HU-00039l-Ko
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:53:14 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso3883101a91.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741971184; x=1742575984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iNubRIb9M8RY3ls2mjQtKLOZPpK+1Omx3xhI4KVZRyA=;
 b=LRywXnQ5Pl19iDmeaBHn3CWy08X7eFilSEZqq7CvWcFkK9QZdg/vYe87GjGi6gCCF4
 JQR8/ztqFG6YGazaqDPAf3mTy5f/s1ys0PPMkbUECkU+JFSu4Fn4YkPNERH5qN8RyEoJ
 /AWWS8RSa4cqfF+PsbKhHDwtpvhbEglZ14pfp7BS8UWJZahSnAa0taSMM4AaX/w/tQ2A
 UiR0BWjoeocet6z3/HTrbPtheAVbDx28Nx6IvC46JJzktxDh/c5khmhV7t4lcTPbpBJo
 cSXlmXAG1qKKEwgZ6MPoHn+yIFxXylbqYU2Yv4a1JffP1jOZzVvcF/ewYJLXS004Q882
 gHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741971184; x=1742575984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iNubRIb9M8RY3ls2mjQtKLOZPpK+1Omx3xhI4KVZRyA=;
 b=NHPZcSDoa+pjNXD6Ck9SWXaWTB7B2vzZgft/7wfgMOUfM9cZx42G0LcurS/hRyuUcp
 oWFhFMlS3gLogkTERe15+rFFJcP9bnn/eeROzcV9xeENExCMmDn+tfZIk6jDzSzH5Uhx
 7o9H5JunrqeEqfPc3kDMawEwSRe7ME5x8HHnyOVVX0seTD2rA1xzKF06ov6ZKBGd9y23
 YDMDENmu+hccjqi1OvhJxdDvccPaNUlm3mSZv3wtyctpufHdat29lNvGrwgrLxFgpvEt
 yi183x3vCG4o+g8O6HgTO195hWZuMKMS2UuA/PdM85BlOaQgVTJrIbjN+ZO/0CDvHjWt
 uZow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgGmt5+rhcRzwAqNqD/IsyrBMlq8Muv9S+M9bKJICavITKwdAKzPyJ5g23TAkNq9f2s1vz7SqkoKGR@nongnu.org
X-Gm-Message-State: AOJu0YzzPzeZSvZJhE7CjN/aVmA3rgMV/CwPoNsShIIkGfDkcc0vQZXa
 LZqxOfBKB7RsIToCnUcs5BRs5ZIwRm4jeXiadB1sc5uDWsBi7YVvN/jlO/00eNE=
X-Gm-Gg: ASbGncv4sjLzyTX/hTgU6NrG7218160aiCf9N4/37HkdCIOC3NOY40Lpyznr/qovEuP
 A0DCFWhb1YUoGv5oGJ50jsWaAhQ2tmtifOSk9PXxbHXMec3EqQSXIbFXwOl3pf6PrTsxvOVcG6t
 gTDoao+F+1YAH7PSlSe893/gw6TmkI2d9F0QdwYZ4X827HSKG0txLZoy+tTEqXe6AIMArq2MAl2
 MyD5CIwamVlpZauYrsNUeQOth89fLTQTrFKu1KFhpuHTrzcZC9MVizN/QrU6gm3egFXjnY0yolw
 8YStw/1tjS266wbHndyJAiVm1vS63UrKPbzYY8j09+sm8fu/UYhDDTsRP2wWffuKgxuN
X-Google-Smtp-Source: AGHT+IHWbLLB0JDV3q9QoRtUB6m8MX/fi08tPTelSHgJ5rnm9cHTgifEBE44ePXGMloMLjsrTN9fuA==
X-Received: by 2002:a17:90b:3b46:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-30151ca0bf3mr3926112a91.19.1741971184155; 
 Fri, 14 Mar 2025 09:53:04 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30153b01204sm1358619a91.29.2025.03.14.09.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 09:53:03 -0700 (PDT)
Message-ID: <45baac7c-c489-497f-a618-3af0ce750ab9@linaro.org>
Date: Fri, 14 Mar 2025 09:53:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/37] common-user: Split out watchpoint-stub.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-26-richard.henderson@linaro.org>
 <36f7e651-4df6-457d-a7ef-df7a7c4b2570@linaro.org>
 <00d707e4-5e60-43fc-b372-72336d7af293@linaro.org>
 <27446562-38b0-46a1-8975-1c4ce24cf4c3@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <27446562-38b0-46a1-8975-1c4ce24cf4c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

T24gMy8xNC8yNSAwOTozNywgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTMv
MjUgMDM6MzksIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+PiAtLS0gL2Rl
di9udWxsDQo+Pj4+ICsrKyBiL2NvbW1vbi11c2VyL3dhdGNocG9pbnQtc3R1Yi5jDQo+Pj4+
IEBAIC0wLDAgKzEsMjggQEANCj4+Pj4gKy8qDQo+Pj4+ICsgKiBDUFUgd2F0Y2hwb2ludCBz
dHVicw0KPj4+PiArICoNCj4+Pj4gKyAqIENvcHlyaWdodCAoYykgMjAwMyBGYWJyaWNlIEJl
bGxhcmQNCj4+Pj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBMR1BMLTIuMS1vci1s
YXRlcg0KPj4+PiArICovDQo+Pj4+ICsNCj4+Pj4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgi
DQo+Pj4+ICsjaW5jbHVkZSAiaHcvY29yZS9jcHUuaCINCj4+Pj4gKw0KPj4+PiAraW50IGNw
dV93YXRjaHBvaW50X2luc2VydChDUFVTdGF0ZSAqY3B1LCB2YWRkciBhZGRyLCB2YWRkciBs
ZW4sDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpbnQgZmxhZ3MsIENQVVdhdGNocG9pbnQgKip3YXRjaHBvaW50KQ0KPj4+PiAr
ew0KPj4+PiArwqDCoMKgIHJldHVybiAtRU5PU1lTOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+
ICtpbnQgY3B1X3dhdGNocG9pbnRfcmVtb3ZlKENQVVN0YXRlICpjcHUsIHZhZGRyIGFkZHIs
IHZhZGRyIGxlbiwgaW50IGZsYWdzKQ0KPj4+PiArew0KPj4+PiArwqDCoMKgIHJldHVybiAt
RU5PU1lTOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICt2b2lkIGNwdV93YXRjaHBvaW50X3Jl
bW92ZV9ieV9yZWYoQ1BVU3RhdGUgKmNwdSwgQ1BVV2F0Y2hwb2ludCAqd3ApDQo+Pj4+ICt7
DQo+Pj4NCj4+PiBBZ2FpbiwgY2FuIHRoaXMgYmUgZWxpZGU/IE90aGVyd2lzZSBiZXR0ZXIg
dXNlIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkuDQo+Pg0KPj4gV2UgY2FuLCBpbmNsdWRpbmc6
DQo+Pg0KPj4gLS0gPjggLS0NCj4+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9jcHUuYyBi
L3RhcmdldC9pMzg2L2NwdS5jDQo+PiBpbmRleCBkYmExYjNmZmVmLi41NGQzODc5YzU2IDEw
MDY0NA0KPj4gLS0tIGEvdGFyZ2V0L2kzODYvY3B1LmMNCj4+ICsrKyBiL3RhcmdldC9pMzg2
L2NwdS5jDQo+PiBAQCAtNzU0NSw0ICs3NTQ1LDYgQEAgc3RhdGljIHZvaWQgeDg2X2NwdV9y
ZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkNCj4+ICAgwqDCoMKgwqAg
ZW52LT5kcls3XSA9IERSN19GSVhFRF8xOw0KPj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05M
WQ0KPj4gICDCoMKgwqDCoCBjcHVfYnJlYWtwb2ludF9yZW1vdmVfYWxsKGNzLCBCUF9DUFUp
Ow0KPj4gICDCoMKgwqDCoCBjcHVfd2F0Y2hwb2ludF9yZW1vdmVfYWxsKGNzLCBCUF9DUFUp
Ow0KPj4gKyNlbmRpZg0KPiANCj4gQnV0IGRvIHdlIHJlYWxseSB3YW50IHRvIGFkZCBhbGwg
dGhvc2UgaWZkZWZzPw0KPiANCg0KSSBhZ3JlZSB3aXRoIFJpY2hhcmQsIHRyYWRpbmcgaWZk
ZWZzIGlzIG5vdCBhIHdpbiBpbiB0aGUgZW5kLg0KSGVyZSwgd2UgcmVwbGFjZSBoZWFkZXIg
c3R1YnMgKHdoaWNoIGFyZSBhIHByb2JsZW0sIGJlY2F1c2UgdGhleSByZWx5IG9uIA0KaWZk
ZWYgYnkgZGVzaWduKSB0byBkaWZmZXJlbnQgY29tcGlsYXRpb24gdW5pdHMsIHdoaWNoIGNh
biBiZSBzZWxlY3RlZCANCmF0IGxpbmsgdGltZS4NCg0KSW4gdGhlIGVuZCwgd2UgbWlnaHQg
ZXZlbiBoYXZlIHRvIHVuaWZ5IHNvbWUgc3R1YnMgYW5kIHRoZWlyIA0KaW1wbGVtZW50YXRp
b25zLCB0byBoYXZlIGEgc2luZ2xlIGRlZmluaXRpb24gb2YgdGhvc2Ugc3ltYm9scy4NCg0K
PiANCj4gcn4NCg0K

