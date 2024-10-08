Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2749CED25F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 03:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy14T-0000Oz-Jg; Mon, 07 Oct 2024 23:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sy14P-0000OJ-9c
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:39:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sy14N-0004ca-BL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:39:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42e5e758093so44828945e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 20:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728358769; x=1728963569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/2QHPNuUKHh+7x96iKMO6DXK9Ho36Le/8pGsXBiiZM4=;
 b=B25/KlVKqPVjZDuYT2wc2A3NJZKfCf4+o+Cpt9FdcewwRls/xe14uBBtXpGyIEfBdw
 rbxv0S2JkYdTQNLbU3ks+boyqmqOWpFEVKPVPuFtgWIQwVEArdXgwvMXmmv+LuoGCpyX
 tJ54iXmrPuEQSoI0TxeSrDIN4dNHCMpggddAKVXQDKZFh79QwhbxnEenMJpGd104zhF8
 3YXxH7MKOhc+/l+jZaIovkVTRMfMPYe8H3b5Wwt7VubeuEFEJSqH+XippE15DFPQWJrS
 1y97CAPdk5jsI2GTRyw2zis8EsfXaWcf1cIDzN4+FOcebwJRIl4LhAL3w0whW24007L3
 Mvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728358769; x=1728963569;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/2QHPNuUKHh+7x96iKMO6DXK9Ho36Le/8pGsXBiiZM4=;
 b=P6TFJhz6ivftTucOUwl2AVXcRXAnmJmnUTy7j0jTVzsBXIaBIljr9Gd0p8TG16YEYv
 M+aQDXSPRHUqumewmZm805DFytcb5Jd+rry0TEjZQpuJaCNwbRTPnHCcwIJiSTXWtHBn
 lsdHsOtqClq77IJ535B24h3pzd+bwLiwAc/+zj0AZRnna/T50QKrAUR3MuIgv5aYWzRn
 hSb7RVC9pH6J4EbElgJDgDwOYMaU3Rp6NqjVniw1UpQvWcO0v5ZoJQVrEvxxGn3kov+0
 CK5Fq188aE0UWvQfawB2dvyQJoW69vWNt7suoS3kZtByoLJ0jUllzO1LlG5hMUAayTrK
 7uag==
X-Gm-Message-State: AOJu0YxDwUdefrXR58gBDeN2f9KYOFoNMRVxS691H7S15ArARXdmENhj
 CzAK95pL8z2p3DD7kuGFKUZv+/7FLfdGZGxytkrUAD7B0F1pRxfQNTIkguQ59DM=
X-Google-Smtp-Source: AGHT+IF/CtIblRud/Ypi/bQ9oDCFX3vQdNTlslJTs5lP9bEL+K49nxLGIhXzvtPmu6ytb5PaRoMRlw==
X-Received: by 2002:a05:600c:4711:b0:42c:d7da:737b with SMTP id
 5b1f17b1804b1-42f85ab3accmr103181255e9.9.1728358769380; 
 Mon, 07 Oct 2024 20:39:29 -0700 (PDT)
Received: from [10.141.170.78] ([146.70.184.62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d169733c5sm6969605f8f.110.2024.10.07.20.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 20:39:28 -0700 (PDT)
Message-ID: <4f7257d9-662e-43c7-9f02-2434e728f2a3@linaro.org>
Date: Mon, 7 Oct 2024 20:39:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Rust initial PoC + meson changes for 2024-10-07
To: Brian Cain <quic_bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, junjie.mao@intel.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
 <cf288711-259e-4b06-96aa-6c681b263bee@quicinc.com>
 <CABgObfa9Zsn47PEoNfDBOg3sbkzXa-Cz4QLocCH9E=3yz8T4Xg@mail.gmail.com>
 <ae024a03-17df-4636-87bb-3d0313f03596@quicinc.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <ae024a03-17df-4636-87bb-3d0313f03596@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

SGkgQnJpYW4sDQoNCk9uIDEwLzcvMjQgMjA6MjcsIEJyaWFuIENhaW4gd3JvdGU6Pj4NCj4+
ICAgICBBc2lkZTogUGFvbG8sIHRoYW5rcyBmb3IgeW91ciB3b3JrIGhlcmUhDQo+Pg0KPj4N
Cj4+IFRoYW5rcyB0byBNYW5vcywgSSBhbSBqdXN0IHRoZSBzaGVwaGVyZC4gOikNCj4+DQo+
PiAgICAgU28gZmFyIEkgdGhpbmsgdGhlIGZvY3VzIGZvciBSdXN0IHN1cHBvcnQgaGFzIGJl
ZW4gb24gZGV2aWNlDQo+PiAgICAgbW9kZWxzLsKgIEJ1dCBpcyB0aGVyZSBhbnkgaW50ZXJl
c3QgaW4NCj4+ICAgICBiZWluZyBhYmxlIHRvIHdyaXRlIFRDRyBwbHVnaW5zIGluIFJ1c3QN
Cj4+DQo+Pg0KPj4gSXMgdGhlcmUgYSBnb29kIGRlZ3JlZSBvZiBBQkkgY29tcGF0aWJpbGl0
eSBhY3Jvc3MgUUVNVSB2ZXJzaW9ucz8gSWYgDQo+PiBzbywgcGx1Z2lucyBhcmUgZXh0ZXJu
YWwgc2hhcmVkIGxpYnJhcmllcyBhbmQgdGhlcmVmb3JlIHRoZXkgY291bGQgYmUgDQo+PiBi
dWlsdCAod2l0aCBDYXJnbykgaW5kZXBlbmRlbnQgb2YgYW55IFFFTVUgY29kZS4NCj4+DQo+
PiBJIGFtIG5vdCBpbnZvbHZlZCBpbiBwbHVnaW5zIHdvcmssIHNvIEkgYW0gbm90IHRoZSBi
ZXN0IHBlcnNvbiB0byBhbnN3ZXIhDQo+IA0KPiANCj4gQWZ0ZXIgd2F0Y2hpbmcgdGhlIHJl
Y29yZGluZyBvZiBBbGV4J3MgS1ZNIEZvcnVtIHByZXNlbnRhdGlvbiBvbiB0aGUgDQo+IHBs
dWdpbnMsIGhlJ3MgYW5zd2VyZWQgbXkgcXVlc3Rpb24gLS0gaGUgZGVzY3JpYmVkIHRoZSBy
dXN0IGJpbmRpbmdzIA0KPiBzcGVjaWZpY2FsbHkgYXMgIi4uLm1pZ2h0IHJlcXVpcmUgdXMg
dG8gYmUgYSBsaXR0bGUgYml0IG1vcmUgZm9ybWFsIA0KPiBhYm91dCBzcGVjaWZ5aW5nIGEg
cHJvcGVyIEFQSS4uLiIgLS0gc28gbWF5YmUgbm90IGEgdG9wIHByaW9yaXR5IGZvciBub3cu
DQo+IA0KDQp0aGFua3MgZm9yIHlvdXIgaW50ZXJlc3QgYXJvdW5kIHBsdWdpbnMuDQpBcyB5
b3Ugbm90aWNlZCwgd2UgYXJlIGZvY3VzZWQgZm9yIG5vdyBvbiBtYWtpbmcgdGhlIEFQSSBt
b3JlIGNvbXBsZXRlIA0KYW5kIHVzZWZ1bCwgYmVmb3JlIHN0YXJ0aW5nIHRvIHRoaW5rIGFi
b3V0IGV4dGVuZGluZyBsYW5ndWFnZXMgYXZhaWxhYmxlIA0KdG8gd3JpdGUgdGhlbS4NCg0K
UnVzdCB3aWxsIGJlIG9uIHRvcCBvZiB0aGUgbGlzdCBmb3Igc3VyZSENCg0KUmVnYXJkcywN
ClBpZXJyaWNrDQo=

