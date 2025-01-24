Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA38C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMOe-0003bi-1P; Fri, 24 Jan 2025 11:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tbMOb-0003bK-Mc
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:19:01 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tbMOa-0004Am-5B
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:19:01 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so4083945a91.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737735538; x=1738340338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P/yOFRSJP0dnAXT9SWTjM1K8xFvmEgyjb1DPUQOqjXE=;
 b=h7A27os0ikvS5peR7nV3AU0uipIrB/JqNnkzVdY0OJMLHoXnfMU21swmvKQKv7j1Ue
 A+zmv1vBpD5uxgA4u26dkI0TLCZGcWjoFIRrLmWCbEi2KvDiFk+EB0JNfpDy9Tg/k473
 GiYee3pj6MA4iHE/9K6oNfO2TJsGpscikvpdhDzNPRh3ZnUBUdwkcAeWehfxRKdINAb8
 3qqcmGj9TM7SEVxaYJTzGBznMQti7gJE86r25+LK1Co1YfQMaJ64LErgu9AA0Z6tt/+7
 lo/WrIruyfwPA+kU1ZhXdJqPjbfVeIM9C9Pim0FbX5BqQ3xPsPjhbN+g1hVb927nRq5E
 oWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737735538; x=1738340338;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P/yOFRSJP0dnAXT9SWTjM1K8xFvmEgyjb1DPUQOqjXE=;
 b=BhIfD2cKuCzwjTAWM+d3opJxxPYWtE2N1uykXbsX08E+iUoFt3DEGQ8OvtTcRqn24W
 LZDj3xICwnyX5fvGJorJe+kmom3sAYk4/gXYtZCVyo1ONuP2RIr3o0M+pJJ3JwPh/fIz
 Gdo/JdCR4TuHoSDydY09rKxQ18s8+DZ5nda1lGdNcTX71Nk9Qj96rBxUJZA4RWqdg0vd
 tINqp7CIKmDzKmPY7lAqTf+9Hirt4dnDYoPBFuIqg4ZCcXbrsGMHmC/j00zdNiNt90wu
 7xSEoyTNQBPGqlI6NTxy4wBCSvV8DcsSA3YhoB1dC0SzE0YMf2eGv5FiVmgIY02k3ynY
 RUHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOhUkPHldVd1MSAr1QCwfLSmKM7Jna1xtvtvrGX1YdjJAzPugfTlkiYnBmVeqrVDIrVM5PyvpwfyTK@nongnu.org
X-Gm-Message-State: AOJu0Yz+5aS2j+oXmIzEEyVB4L2t0lXnEqYQ6Kfe2g+iB1xRvFro3Ftr
 olXQa6hpzcDyMpSt63oD/nEudTORSn4jO56KbgN21A3Bi+3P08HbXjhJHP1NL1g=
X-Gm-Gg: ASbGncvc7jYDeTtjw5iyF0yOkdIzD7SjxDMAfQeyW0pWbgPyShtsQ9KmEtv8gy1TOG8
 NJoOKAhF4PAdBmk/9GLORJhtYCG/jGRWADXkG5WRTOG6sGSbqKGCweHyR2G8JBFm0I1nBy1G31C
 B3xtkwwmxQXZ1HbQcCO6R0MXDBlkYZTqiJTGL0QSa6xxydV+sNOcxmOQ8SUE4cJ9anoePW2m9R5
 zzvGRD/rMn53XTd35nio9wZkvO+CwFCb2iVqx51d/daIzlqiQ9BlG/juHLkScVqGJcsmwDPkTnn
 R/2yL1VmUMXljYd0Fg==
X-Google-Smtp-Source: AGHT+IFuO84JLZv19/L2uyk3Ve5xzyH9g5fJvaRcj2q4RodoWfyczUzW5d3BF/qMLdVaYoiXHqE5CQ==
X-Received: by 2002:a17:90b:2703:b0:2ee:d63f:d71 with SMTP id
 98e67ed59e1d1-2f782c7252dmr51019266a91.14.1737735537910; 
 Fri, 24 Jan 2025 08:18:57 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa44cb8sm1916187a91.6.2025.01.24.08.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:18:57 -0800 (PST)
Message-ID: <a5f10050-1914-4f58-a71e-0703ab9a5a19@linaro.org>
Date: Fri, 24 Jan 2025 08:18:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/32] tests/functional/aarch64: add tests for FEAT_RME
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-16-alex.bennee@linaro.org>
 <d9094d1e-10bc-4b15-9efe-ebc8bab5d158@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d9094d1e-10bc-4b15-9efe-ebc8bab5d158@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgVGhvbWFzLA0KDQpPbiAxLzI0LzI1IDA1OjI5LCBUaG9tYXMgSHV0aCB3cm90ZToNCj4g
T24gMTAvMDEvMjAyNSAxNC4xNywgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4gRnJvbTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4NCj4+IFRo
aXMgYm9vdCBhbiBPUC1URUUgZW52aXJvbm1lbnQsIGFuZCBsYXVuY2ggYSBuZXN0ZWQgZ3Vl
c3QgVk0gaW5zaWRlIGl0DQo+PiB1c2luZyB0aGUgUmVhbG1zIGZlYXR1cmUuIFdlIGRvIGl0
IGZvciB2aXJ0IGFuZCBzYnNhLXJlZiBwbGF0Zm9ybXMuDQo+IA0KPiAgICBIaSwNCj4gDQo+
IEZXSVcsIEkganVzdCBzYXcgdGhpcyB0ZXN0X2FhcmNoNjRfcm1lX3ZpcnQgdGVzdCBmYWls
aW5nIG9uY2UuIExvb2tpbmcgYXQNCj4gdGhlIGNvbnNvbGUubG9nLCBpdCBzZWVtcyBsaWtl
IHRoZSBndWVzdCBjcmFzaGVkIHNvbWV3aGVyZSBhdCB0aGUgZW5kIG9mIHRoZQ0KPiBmaXJt
d2FyZSBvciB2ZXJ5IGVhcmx5IGluIHRoZSBrZXJuZWw6DQo+IA0KPiBFRkkgc3R1YjogQm9v
dGluZyBMaW51eCBLZXJuZWwuLi4NCj4gMjAyNS0wMS0yNCAxMzoyNToyOCwyMjY6DQo+IDIw
MjUtMDEtMjQgMTM6MjU6MjgsMjI2Og0KPiAyMDI1LTAxLTI0IDEzOjI1OjI4LDIyNzogU3lu
Y2hyb25vdXMgRXhjZXB0aW9uIGF0IDB4MDAwMDAwMDBCRjUyNjQ5OA0KPiAyMDI1LTAxLTI0
IDEzOjI1OjI4LDIyNzoNCj4gMjAyNS0wMS0yNCAxMzoyNToyOCwyMjc6DQo+IDIwMjUtMDEt
MjQgMTM6MjU6MjgsMjI4OiBTeW5jaHJvbm91cyBFeGNlcHRpb24gYXQgMHgwMDAwMDAwMEJG
NTI2NDk4DQo+IA0KPiBJIHdhc24ndCBhYmxlIHRvIHJlcHJvZHVjZSBpdCBhZnRlcndhcmRz
IGFueW1vcmUsIGJ1dCBpbiBjYXNlIHNvbWVib2R5IHJ1bnMNCj4gaW50byB0aGlzIGxhdGVy
IGFnYWluIGFuZCB3b25kZXJzIGlmIGl0IGlzIGEgbGF0ZXIgcmVncmVzc2lvbjogSXQgaGFw
cGVuZWQNCj4gZm9yIG1lIHdpdGggY29tbWl0IGNmODY3NzBjN2FhMzFlYmQuDQo+IA0KPiAg
ICBUaG9tYXMNCj4gDQoNCkkgbWV0IHRoaXMga2luZCBvZiBlcnJvciBiZWZvcmUgKG5vdCBv
biBybWUpLCBhbmQgaWYgSSByZW1lbWJlciB3ZWxsLCANCml0J3MgY29taW5nIGZyb20gRURL
Mi4NCg0KV2UgbWlnaHQgaGF2ZSBhIHJhY2UgY29uZGl0aW9uIGhlcmUuDQo=

