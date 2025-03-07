Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D082C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqffA-0003HD-QY; Fri, 07 Mar 2025 16:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqff6-0003DV-6g
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:55:20 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqff3-0001a7-3E
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:55:18 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22356471820so39611235ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384515; x=1741989315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iyKhzciLa27w8sC9sVDvMU2e3ZHeZ+YI/GDbHY0swV0=;
 b=cOCks1R6KT7kXRE9YDNjLcEB3Aj4U5umPE7N35ABvsjny6KVMMVkHhkzL0V2Jgyjq6
 0UAN2yaxS9VmAmhS0rOfK2vy3U1dGzg/Q0oEd5duzUOwwo8mv/mf5FzEgocGGvrPCfie
 OFmp9R3V8e3S9RL58VfImZ86AHJZre7oL2oH7XzDNV71DrePEMcGYGY1BRgVOQCiQhkA
 QIGoU/tbtYbQYE5JOinAGU77dSNWHfTtPryxy20dkTxBls/y1/GIabmBzWJOGcj+1U99
 BA+jHyDmfKb8bmPD7lOA/RWQA/A3W6CTNn/fJaPEW2YiYxZcXLLcpdMGaYGL25l1E7q6
 idQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384515; x=1741989315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iyKhzciLa27w8sC9sVDvMU2e3ZHeZ+YI/GDbHY0swV0=;
 b=C/zr3kZIGb4jtX/yN3kEMRdORr5gojXvi311CfVO3mZJOOGSigZSOZib2x+Itn0sTY
 7Bl3DK0VkBivePrcPgHvv4rLCZxN9pIxKjNFnMgGCffVVZilIFW4WqY6RmmxHhnCqhvt
 Ppb3VZlTszmLHC9bYzCeKoI0LRTRxWk9UhMnLo11NjGcUJouzihuihIKBlUC9UtIPKgj
 qopto0r0Eb5eBkvr7YUS3Mwn90LRZ0AIgBWIjU/Po04CH9s7WAyRm8DAc68gLJXRF22T
 N3MHBHRs+FgBtz4UmF2ce/riGOig8lHnUKloZLqMvhozCJ8zJtIHw+Sxzl13dDGNcDR4
 KiZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn2g+TxN6bbfS2RAWHUDrdC0+NEMtFBQmLXK6913f5nH3JxgRfZxgqvWdzhe5cJm4eZZBt0B6RdH8F@nongnu.org
X-Gm-Message-State: AOJu0Yxrhls2seDu4RzuK6v65Q0jk19CIgv1wxhT8KkursUHN9oHpZEW
 mjXiUEGZn9/voyCS0bTteBi4JZw2O1obyFu5rrTG/fEmrZMLAwcOpfiG3DCfxhI=
X-Gm-Gg: ASbGncuQQ8gI6oHOI2mQnG206EEYe8tU/UVGD32nQ8bfhRchF3+OE76izD79z9lnFNc
 W41D/2O0VrAHuT+K4DI9gLgynreWUGhVg4mJl6Qgrx4PzEjj6Wo7L9Hxid5MgHGuglf+zkLQNU+
 Tgkc6K2DgHFDQSJijyFu0N1F9fMdEMK35+soYYNx67pASCN6AbF2stROAAYDoGL7bhCu+6ZWi7E
 YRNAYUAdp6k8a30l6FW6mpZav3gAJXxOdd5jAuZ4vzO85SyZ9/68c3XJeEEQEv9h9jPiRHuVTKw
 3d8S+cJBOF4CizuSKkw7nOB7XU7d1FSPwPvMHmmvhqNh9u+lpQ370t49yw==
X-Google-Smtp-Source: AGHT+IHDrXYCnpd+cmLlmmfRn7Cqm+elPiQIIfu6ZdtRoOJxPEmvoxTqenGi2jJ5QT75juc7SA60bA==
X-Received: by 2002:a05:6a21:6d96:b0:1ee:c7c8:ca4 with SMTP id
 adf61e73a8af0-1f544c92b65mr10302325637.36.1741384515168; 
 Fri, 07 Mar 2025 13:55:15 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698451b53sm3763823b3a.75.2025.03.07.13.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:55:14 -0800 (PST)
Message-ID: <98804c05-f3e4-4c64-83e1-df3dbe6c7034@linaro.org>
Date: Fri, 7 Mar 2025 13:55:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] hw/hyperv/syndbg: common compilation unit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, kvm@vger.kernel.org, richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
 <20250307193712.261415-6-pierrick.bouvier@linaro.org>
 <0e40276f-c9e6-47e1-b70b-5a8b5f8fb30b@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0e40276f-c9e6-47e1-b70b-5a8b5f8fb30b@linaro.org>
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

T24gMy83LzI1IDEyOjU2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
Ny8zLzI1IDIwOjM3LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gUmVwbGFjZSBUQVJH
RVRfUEFHRS4qIGJ5IHJ1bnRpbWUgY2FsbHMNCj4+IFdlIGFzc3VtZSB0aGF0IHBhZ2Ugc2l6
ZSBpcyA0S0Igb25seSwgdG8gZGltZW5zaW9uIGJ1ZmZlciBzaXplIGZvcg0KPj4gcmVjZWl2
aW5nIG1lc3NhZ2UuDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxy
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4gLS0tDQo+PiAg
ICBody9oeXBlcnYvc3luZGJnLmMgICAgfCAxMCArKysrKysrLS0tDQo+PiAgICBody9oeXBl
cnYvbWVzb24uYnVpbGQgfCAgMiArLQ0KPj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2h5cGVy
di9zeW5kYmcuYyBiL2h3L2h5cGVydi9zeW5kYmcuYw0KPj4gaW5kZXggZDNlMzkxNzA3NzIu
LjBlYzcxZDliZmI4IDEwMDY0NA0KPj4gLS0tIGEvaHcvaHlwZXJ2L3N5bmRiZy5jDQo+PiAr
KysgYi9ody9oeXBlcnYvc3luZGJnLmMNCj4+IEBAIC0xNCw3ICsxNCw3IEBADQo+PiAgICAj
aW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4+ICAgICNpbmNsdWRlICJody9xZGV2
LXByb3BlcnRpZXMuaCINCj4+ICAgICNpbmNsdWRlICJody9sb2FkZXIuaCINCj4+IC0jaW5j
bHVkZSAiY3B1LmgiDQo+PiArI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X3BhZ2UuaCINCj4+ICAg
ICNpbmNsdWRlICJody9oeXBlcnYvaHlwZXJ2LmgiDQo+PiAgICAjaW5jbHVkZSAiaHcvaHlw
ZXJ2L3ZtYnVzLWJyaWRnZS5oIg0KPj4gICAgI2luY2x1ZGUgImh3L2h5cGVydi9oeXBlcnYt
cHJvdG8uaCINCj4+IEBAIC0xODMsMTIgKzE4MywxNCBAQCBzdGF0aWMgYm9vbCBjcmVhdGVf
dWRwX3BrdChIdlN5bkRiZyAqc3luZGJnLCB2b2lkICpwa3QsIHVpbnQzMl90IHBrdF9sZW4s
DQo+PiAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAgICB9DQo+PiAgICANCj4+ICsjZGVmaW5l
IE1TR19CVUZTWiA0MDk2DQo+IA0KPiAoNCAqIEtpQikgaXMgbW9yZSByZWFkYWJsZSwgYnV0
LCBhcyBhIG1hdHRlciBvZiBzdHlsZSwgSSB3b24ndA0KPiBvYmplY3QgaWYgeW91IGluc2lz
dC4NCj4gDQoNClN1cmUsIEkgY2FuIGNoYW5nZSB0byB0aGF0Lg0KDQo+IFJldmlld2VkLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IA0KDQo=


