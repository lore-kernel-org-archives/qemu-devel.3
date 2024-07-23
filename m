Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2D1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 21:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWN2D-0004qi-TO; Tue, 23 Jul 2024 17:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWN2C-0004pg-AA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 17:27:00 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWN2A-000404-Fj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 17:27:00 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7a2123e9ad5so178275a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721770016; x=1722374816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGUNEapNRTLn2xmOyDa8BjUOFOZRV6WkBqacHrqi2fo=;
 b=VD+rY0tibTmrjG9F3ItdnNTMDs4qrHMX/l9WMWuF86pg3w7ZP78wnvsAZXf85sJvOW
 iwppPuXrmHTFQAZswn6H/qqWhKtN/jMVxbTtMn2RTgXx9tz2lncV/Pkh1TM5+BTS6v/A
 dvyncK0TGQ9FDTIEGTdmyvwe0qSGimphCwnmmEWtBHXQhSmmDVwAdbxE87ROuToaVYBO
 29WpBq+0BNQbHtDgq4eMuNvQbFInWTNuBGc/FfFLcQZBv7kCLZh0nnIJyI98DbTJfi0L
 6EMvwmZCImtPIQB+XszlUCbnfPeAkw9EWYMRDIfdd/yxC9prQYtrovd5f5c+kBcp+4ek
 Bh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721770016; x=1722374816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QGUNEapNRTLn2xmOyDa8BjUOFOZRV6WkBqacHrqi2fo=;
 b=pfKU/wHy7t9/apXNok+RKuLoVudbHqzJwqcW3hlDgB9LsfBJkp+V3CJtOALme1SEUU
 RNaAlm3APD0ppysEbEOR4CvyT2VglEBG4omIjwOPB+/qer5VLin+HgW3UF+/6dAF1ZsN
 Bw7CRUwzLrT47MbWoVn/bg2KG43NEad3onhTUnw7QEotxAFSd9lahYfgDWwmvIwtGVeS
 z5mAvDwCa1ElknWegyeqDpTnckHI8IEhuA6g+xaHu8/gZBrrGrdRc/tS+huMig5meyi6
 KVD+wkcVb+JLSswiHivYpuwu5sFUSDpd+DwnbCBpP14YhF0I6ABVIUUxLp9gIiwxSbdW
 HGuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKHMixGf7qhjTwmHNbSXQ4FMmTkoNe1Bcl4qibDZyNZEtB8OfRQeiWDqCthxLNHtyPEjzgvgjQLP/ndOSdc7o7AhyfvGE=
X-Gm-Message-State: AOJu0YyX/ylUn3FJsT21LPSpkFDsiwNNxXIOy6zl10FevPybPGDSusdh
 XA2BMphD2nGEeSUSy+OjMHw4wxbiFhIg3MgmQ/HIuYqJK1GPrQq+aq9QrpMfVf4=
X-Google-Smtp-Source: AGHT+IE3GU94kJU+9/KDHB6coyttrNsdsKTE4aCYxho3I3k6ua4O69nstYOxidwWV3k/28/eAKlz3w==
X-Received: by 2002:a17:90a:9a4:b0:2c9:75a7:5c25 with SMTP id
 98e67ed59e1d1-2cd8d0e1e08mr5303427a91.15.1721770016402; 
 Tue, 23 Jul 2024 14:26:56 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb743219csm63752a91.25.2024.07.23.14.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 14:26:55 -0700 (PDT)
Message-ID: <353e33d8-f766-40c7-b371-331d14b6a1a2@linaro.org>
Date: Tue, 23 Jul 2024 14:26:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: update tcg-plugins page
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240723205451.504193-1-pierrick.bouvier@linaro.org>
 <06420e5f-a493-44b0-8d32-1a4dc2a9db59@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <06420e5f-a493-44b0-8d32-1a4dc2a9db59@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

T24gNy8yMy8yNCAxMzo1OSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDIzLzcvMjQgMjI6NTQsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBSZWZsZWN0IHJl
Y2VudCBjaGFuZ2VzIG9uIEFQSSAoaW5saW5lIG9wcykgYW5kIG5ldyBwbHVnaW5zLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
bGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gICAgZG9jcy9kZXZlbC90Y2ctcGx1Z2lucy5yc3Qg
fCAxMDEgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4gICAgMSBm
aWxlIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KPiANCj4g
DQo+PiAgICAgICRRRU1VICRPVEhFUl9RRU1VX0FSR1MgXA0KPj4gLSAgICAgIC1wbHVnaW4g
Y29udHJpYi9wbHVnaW4vbGliaG93dmVjLnNvLGlubGluZT1vbixjb3VudD1oaW50IFwNCj4+
IC0gICAgICAtcGx1Z2luIGNvbnRyaWIvcGx1Z2luL2xpYmhvdGJsb2Nrcy5zbw0KPj4gKyAg
ICAgIC1wbHVnaW4gY29udHJpYi9wbHVnaW5zL2xpYmhvd3ZlYy5zbyxpbmxpbmU9b24sY291
bnQ9aGludCBcDQo+PiArICAgICAgLXBsdWdpbiBjb250cmliL3BsdWdpbnMvbGliaG90Ymxv
Y2tzLnNvDQo+IA0KPiANCj4+IC0tIHRlc3RzL3BsdWdpbnMvZW1wdHkuYw0KPj4gKy0gdGVz
dHMvcGx1Z2luL2VtcHR5LmMNCj4gDQo+IA0KPiBDb3VsZCB3ZSB1c2UgdGhlIHNhbWUgZGly
ZWN0b3J5IG5hbWUgZm9yIGNvbnRyaWIvIGFuZCB0ZXN0cy8NCj4gdG8gYXZvaWQgdGhhdCBr
aW5kIG9mIGNvbmZ1c2lvbj8NCg0KSSBhZ3JlZSB3aXRoIHRoYXQsIGJ1dCBpdCdzIG91dCBv
ZiB0aGUgc2NvcGUgZm9yIHRoaXMgc2ltcGxlIHBhdGNoIChqdXN0IA0Kd2FudCB0byB1cGRh
dGUgZG9jIGZvciA5LjEgcmVsZWFzZSB0aGF0IGlzIGNvbWluZykuIFRoYXQgc2FpZDoNCg0K
QSB0aGluZyB0aGF0IGFzIGJlZW4gYXNrZWQgc29tZSB0aW1lIGFnbyB3YXMgdG8gYnVpbGQg
Y29udHJpYiBwbHVnaW5zIA0KdXNpbmcgbWVzb24gdG9vLg0KKHNlZTogaHR0cHM6Ly9naXRs
YWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzE3MTApLg0KSSBzZWUgdGhhdCBh
cyBhIGdvb2Qgb3Bwb3J0dW5pdHkgdG8gc29sdmUgYm90aCBpc3N1ZXMsIGJ5IGtlZXBpbmcg
YWxsIA0KcGx1Z2lucyBpbiBhIHNpbmdsZSBmb2xkZXIgKHRlc3RzL3BsdWdpbiksIGV2ZW50
dWFsbHkgd2l0aCANCnRlc3RzL3BsdWdpbi9jb250cmliIGlmIHByZWZlcnJlZC4NCg0KVXBk
YXRpbmcgQVBJIHdpdGggdGhlIGNvbnRyaWIgZm9sZGVyIGJlaW5nIGJ1aWx0IHdpdGggYSBt
YWtlZmlsZSBpcyBhIA0KcGFpbiwgYW5kIHNvbWUgdGFyZ2V0IGFyY2ggaGF2ZSB3YXJuaW5n
cyB3aGVuIGJ1aWxkaW5nIHRoZW0sIHNvIGl0IHdvdWxkIA0KYmUgYSBnb29kIG1vdmUuIEFu
ZCBwZW9wbGUgY2FuIHN0aWxsIGJ1aWxkIHRoZW0gb3V0IG9mIHRyZWUgbWFudWFsbHkgaWYg
DQp0aGV5IHdhbnQuIFBsdXMsIHRob3NlIHBsdWdpbnMgd291bGQgcnVuIGluIENJLCBzbyB0
aGV5IHdvdWxkIGJlIG1vcmUgDQpyb2J1c3QuDQoNCkBBbGV4OiB3b3VsZCB5b3UgYmUga2Vl
biB0byBzZWUgdGhvc2UgY2hhbmdlcyAoZm9yIDkuMik/DQpJJ20ga2VlbiB0byBtYWtlIGl0
LCBhbmQgZml4IGFsbCB3YXJuaW5ncywgYXMgc29vbiBhcyB3ZSBhZ3JlZSB3aGVyZSB0byAN
Cm1vdmUgdGhvc2UgbmljZSBsaXR0bGUgcGx1Z2lucy4NCg==

