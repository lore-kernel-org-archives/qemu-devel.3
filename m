Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58842C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAu2-0005f6-6b; Fri, 14 Jun 2024 13:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sIAtt-0005dE-Nq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:39:47 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sIAtq-00082W-Vd
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:39:44 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c1ab9e17f6so2015548a91.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718386781; x=1718991581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LZVk0DXKOWm6MvJWNYzIbrwLlYqE1AU9Mbeh1DO6+c0=;
 b=FcXM1s3nHscg0rLNKjTvMVu4GALfehibzhoY1Jwaak4a0Tgs2oWk3lPjpz40Asts/S
 MOwuIjnXOsMdUR0bggsaFfD/dxEzZ2xOgpheNPH5we/48+xI1VSB2yBr4oXVUxWXmp85
 Bp0GaUmlFUJR6wmsDO74rCRMr4DSeO4F2krVNT5do8Qy4m+Z0GUalqdgtO6InEa4L1Ri
 mud0Dt1zaUkj9/sgQcQZWkf5OH8p8tSC7xx2ND6sET8vgrJ5ldF9MGNTtzhMqEE5N4VJ
 +nrgc9Ml7qKTX7RHVSNrAcSK2e6STru02aDcoGgOadknoHuf+pRJsf2StnBgljI3B24F
 Twvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718386781; x=1718991581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LZVk0DXKOWm6MvJWNYzIbrwLlYqE1AU9Mbeh1DO6+c0=;
 b=kU1y5gvADVB2a7EvAQNlFFjtslhYlSmz4G2Y9woTx5U4Xm4voqiVPb2ANkldUo19Ov
 wDH2SqT8FAJYwrcuUds3EnOJWPMsmWIJvzSpS1wp5HaJgI81PSfeyTu0qQbYtSSlsTYa
 W4WMXDwfECRr0zA9UJZxz9DOzxFo3dW01v/lWJR06cHJKpr63Yt7OXCHWnTvez/R6Ehs
 YigsV4GwIPlcudSLMVx9N1OuQwmd3OWQJwR+1WwIe8e/kM5+8KO8FET6vWLInZOBht4B
 szzml7IrVK14tyQUdbqO16Y9xlYj6mjrqVzlNj7LxRwFvOeFurk3Qmz7jNfIhKdBbNvY
 M5qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjsCOcVU6yLwI7/Ibvt/t4KmHKG+iiQlvMURUeQcZKQMHYXVjrG5InSeS6PhJtzexXiDgSgTrZQf/47RwR+g4gzmVyzqs=
X-Gm-Message-State: AOJu0YxmcKrrxVt3wRZQEMtfTy4Efg/LU8JQr8ZKyADeLDqPdOVRGU2M
 WhaE0AnvgG+BK1CUUj0hadCnZFYHS/FcY++CT6QwmdLBmWJypC7oNbY9p5pOB+8=
X-Google-Smtp-Source: AGHT+IE5urql5YpawKC+jj7jv8LyLVzZJYw6QrDSxegrz2UowPKK9+FYNMnJ8E7y9V5qTR8ntxVfEQ==
X-Received: by 2002:a17:90a:2d82:b0:2c3:8d6:eb38 with SMTP id
 98e67ed59e1d1-2c4db44ba1fmr3944452a91.26.1718386780132; 
 Fri, 14 Jun 2024 10:39:40 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00:5b09:8db7:b002:cf61?
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fede169c6bsm2860610a12.22.2024.06.14.10.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 10:39:39 -0700 (PDT)
Message-ID: <db8d82d4-c88d-45ac-bc99-e85a4240add2@linaro.org>
Date: Fri, 14 Jun 2024 10:39:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] contrib/plugins: add ips plugin example for cost
 modeling
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-10-alex.bennee@linaro.org>
 <31ba8570-9009-4530-934d-3b73b07520d0@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <31ba8570-9009-4530-934d-3b73b07520d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

T24gNi8xMy8yNCAwMTo1NCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDEyLzYvMjQgMTc6MzUsIEFsZXggQmVubsOpZSB3cm90ZToNCj4+IEZyb206IFBpZXJyaWNr
IEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+DQo+PiBUaGlzIHBs
dWdpbiB1c2VzIHRoZSBuZXcgdGltZSBjb250cm9sIGludGVyZmFjZSB0byBtYWtlIGRlY2lz
aW9ucw0KPj4gYWJvdXQgdGhlIHN0YXRlIG9mIHRpbWUgZHVyaW5nIHRoZSBlbXVsYXRpb24u
IFRoZSBhbGdvcml0aG0gaXMNCj4+IGN1cnJlbnRseSB2ZXJ5IHNpbXBsZS4gVGhlIHVzZXIg
c3BlY2lmaWVzIGFuIGlwcyByYXRlIHdoaWNoIGFwcGxpZXMNCj4gDQo+IC4uLiBJUFMgcmF0
ZSAoSW5zdHJ1Y3Rpb25zIFBlciBTZWNvbmQpIHdoaWNoIC4uLg0KPiANCj4+IHBlciBjb3Jl
LiBJZiB0aGUgY29yZSBydW5zIGFoZWFkIG9mIGl0cyBhbGxvY2F0ZWQgZXhlY3V0aW9uIHRp
bWUgdGhlDQo+PiBwbHVnaW4gc2xlZXBzIGZvciBhIGJpdCB0byBsZXQgcmVhbCB0aW1lIGNh
dGNoIHVwLiBFaXRoZXIgd2F5IHRpbWUgaXMNCj4+IHVwZGF0ZWQgZm9yIHRoZSBlbXVsYXRp
b24gYXMgYSBmdW5jdGlvbiBvZiB0b3RhbCBleGVjdXRlZCBpbnN0cnVjdGlvbnMNCj4+IHdp
dGggc29tZSBhZGp1c3RtZW50cyBmb3IgY29yZXMgdGhhdCBpZGxlLg0KPj4NCj4+IEV4YW1w
bGVzDQo+PiAtLS0tLS0tLQ0KPj4NCj4+IFNsb3cgZG93biBleGVjdXRpb24gb2YgL2Jpbi90
cnVlOg0KPj4gJCBudW1faW5zbj0kKC4vYnVpbGQvcWVtdS14ODZfNjQgLXBsdWdpbiAuL2J1
aWxkL3Rlc3RzL3BsdWdpbi9saWJpbnNuLnNvIC1kIHBsdWdpbiAvYmluL3RydWUgfCYgZ3Jl
cCB0b3RhbCB8IHNlZCAtZSAncy8uKjogLy8nKQ0KPj4gJCB0aW1lIC4vYnVpbGQvcWVtdS14
ODZfNjQgLXBsdWdpbiAuL2J1aWxkL2NvbnRyaWIvcGx1Z2lucy9saWJpcHMuc28saXBzPSQo
KCRudW1faW5zbi80KSkgL2Jpbi90cnVlDQo+PiByZWFsIDQuMDAwcw0KPj4NCj4+IEJvb3Qg
YSBMaW51eCBrZXJuZWwgc2ltdWxhdGluZyBhIDI1ME1IeiBjcHU6DQo+PiAkIC9idWlsZC9x
ZW11LXN5c3RlbS14ODZfNjQgLWtlcm5lbCAvYm9vdC92bWxpbnV6LTYuMS4wLTIxLWFtZDY0
IC1hcHBlbmQgImNvbnNvbGU9dHR5UzAiIC1wbHVnaW4gLi9idWlsZC9jb250cmliL3BsdWdp
bnMvbGliaXBzLnNvLGlwcz0kKCgyNTAqMTAwMCoxMDAwKSkgLXNtcCAxIC1tIDUxMg0KPj4g
Y2hlY2sgdGltZSB1bnRpbCBrZXJuZWwgcGFuaWMgb24gc2VyaWFsMA0KPj4NCj4+IFRlc3Rl
ZCBpbiBzeXN0ZW0gbW9kZSBieSBib290aW5nIGEgZnVsbCBkZWJpYW4gc3lzdGVtLCBhbmQg
dXNpbmc6DQo+PiAkIHN5c2JlbmNoIGNwdSBydW4NCj4+IFBlcmZvcm1hbmNlIGRlY3JlYXNl
IGxpbmVhcmx5IHdpdGggdGhlIGdpdmVuIG51bWJlciBvZiBpcHMuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3Jn
Pg0KPj4gTWVzc2FnZS1JZDogPDIwMjQwNTMwMjIwNjEwLjEyNDU0MjQtNy1waWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgIGNvbnRyaWIvcGx1Z2lucy9pcHMu
YyAgICB8IDE2NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+
ICAgIGNvbnRyaWIvcGx1Z2lucy9NYWtlZmlsZSB8ICAgMSArDQo+PiAgICAyIGZpbGVzIGNo
YW5nZWQsIDE2NSBpbnNlcnRpb25zKCspDQo+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgY29u
dHJpYi9wbHVnaW5zL2lwcy5jDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lu
cy9pcHMuYyBiL2NvbnRyaWIvcGx1Z2lucy9pcHMuYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAuLmRiNzc3MjkyNjQNCj4+IC0tLSAvZGV2L251bGwN
Cj4+ICsrKyBiL2NvbnRyaWIvcGx1Z2lucy9pcHMuYw0KPj4gQEAgLTAsMCArMSwxNjQgQEAN
Cj4+ICsvKg0KPj4gKyAqIGlwcyByYXRlIGxpbWl0aW5nIHBsdWdpbi4NCj4gDQo+IFRoZSBw
bHVnaW4gbmFtZXMgYXJlIHJlYWxseSB0byBwYWNrZWQgdG8gbXkgdGFzdGUgKGVhY2ggdGlt
ZSBJIGxvb2sgZm9yDQo+IG9uZSBJIGhhdmUgdG8gb3BlbiBtb3N0IHNvdXJjZSBmaWxlcyB0
byBmaWd1cmUgb3V0IHRoZSBjb3JyZWN0IG9uZSk7IHNvDQo+IHBsZWFzZSBlYXNlIG15IGxp
ZmUgYnkgdXNpbmcgYSBtb3JlIGRlc2NyaXB0aXZlIGhlYWRlciBhdCBsZWFzdDoNCj4gDQo+
ICAgICAgICBJbnN0cnVjdGlvbnMgUGVyIFNlY29uZCAoSVBTKSByYXRlIGxpbWl0aW5nIHBs
dWdpbi4NCj4gDQo+IFRoYW5rcy4NCj4gDQoNCkkgYWdyZWUgbW9zdCBvZiB0aGUgcGx1Z2lu
IG5hbWVzIGFyZSBwcmV0dHkgY3J5cHRpYywgYW5kIHRoZXkgYXJlIA0KbGFja2luZyBhIGNv
bW1vbiAiaGVscCIgc3lzdGVtLCB0byBkZXNjcmliZSB3aGF0IHRoZXkgZG8sIGFuZCB3aGlj
aCANCm9wdGlvbnMgYXJlIGF2YWlsYWJsZSBmb3IgdGhlbS4gSXQncyBkZWZpbml0ZWx5IHNv
bWV0aGluZyB3ZSBjb3VsZCBhZGQgDQppbiB0aGUgZnV0dXJlLg0KDQpSZWdhcmRpbmcgd2hh
dCB5b3UgcmVwb3J0ZWQsIEknbSB0b3RhbGx5IG9rIHdpdGggdGhlIGNoYW5nZS4NCg0KSG93
ZXZlciwgc2luY2UgdGhpcyBpcyBhIG5ldyBzZXJpZXMsIEknbSBub3QgaWYgSSBvciBBbGV4
IHNob3VsZCBjaGFuZ2UgDQppdC4gSWYgaXQncyBvayBmb3IgeW91IHRvIG1vZGlmeSB0aGlz
IEFsZXgsIGl0IGNvdWxkIGJlIHNpbXBsZXIgdGhhbiANCndhaXRpbmcgZm9yIG1lIHRvIHB1
c2ggYSBuZXcgcGF0Y2ggd2l0aCBqdXN0IHRoaXMuDQoNCkxldCBtZSBrbm93IGhvdyB5b3Ug
ZGVhbCB3aXRoIHRoaXMgdXN1YWxseSwgYW5kIEknbGwgZG8gd2hhdCBpcyBuZWVkZWQuDQoN
ClRoYW5rcywNClBpZXJyaWNrDQoNCj4+ICsgKiBUaGlzIHBsdWdpbiBjYW4gYmUgdXNlZCB0
byByZXN0cmljdCB0aGUgZXhlY3V0aW9uIG9mIGEgc3lzdGVtIHRvIGENCj4+ICsgKiBwYXJ0
aWN1bGFyIG51bWJlciBvZiBJbnN0cnVjdGlvbnMgUGVyIFNlY29uZCAoaXBzKS4gVGhpcyBj
b250cm9scw0KPj4gKyAqIHRpbWUgYXMgc2VlbiBieSB0aGUgZ3Vlc3Qgc28gd2hpbGUgd2Fs
bC1jbG9jayB0aW1lIG1heSBiZSBsb25nZXINCj4+ICsgKiBmcm9tIHRoZSBndWVzdHMgcG9p
bnQgb2YgdmlldyB0aW1lIHdpbGwgcGFzcyBhdCB0aGUgbm9ybWFsIHJhdGUuDQo+PiArICoN
Cj4+ICsgKiBUaGlzIHVzZXMgdGhlIG5ldyBwbHVnaW4gQVBJIHdoaWNoIGFsbG93cyB0aGUg
cGx1Z2luIHRvIGNvbnRyb2wNCj4+ICsgKiBzeXN0ZW0gdGltZS4NCj4+ICsgKg0KPj4gKyAq
IENvcHlyaWdodCAoYykgMjAyMyBMaW5hcm8gTHRkDQo+PiArICoNCj4+ICsgKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPj4gKyAqLw0KPiANCg==

