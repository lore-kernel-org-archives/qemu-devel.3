Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC23C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1Gj-0006uQ-GI; Thu, 11 Jul 2024 17:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sS1Gi-0006tw-3o
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:24:00 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sS1Gg-00012C-Dh
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:23:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fb05ac6b77so9663245ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720733036; x=1721337836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lQT5fCKa8lnBO+12cnB5rIunQwN0+veeBL3rURPgahY=;
 b=b2C6wOUGDF5JXB63u5IhNw8ZKou6GCBBr4xGaew2yO2VpSrvOc/KmamXSRRkznZFjS
 w5iTln3h/J4H3mpD7ekiHrD7dy4U1oqZLQz72KjHcZ/qAk/J1pYt1JcRLDIkS4cVctDx
 8A0e4dv73zCI+5LcibkTADwxcf4nty8uVkcrLpgAId/QFMxj3PPec8E+z1Xzgc7xKF0w
 rVaUT3E1cfDI3PM1qiVa0MahKIDWVnw7WlcHEwdyIbe9PVWWtzGdksa42+KazpXAp+Qc
 6oG9SxTXXX/M1g8LSjtSsQYcAfnwUTvvBOwuVWBz26Rdo5XeyMetr6yTfBD3ix92JY95
 9UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733036; x=1721337836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lQT5fCKa8lnBO+12cnB5rIunQwN0+veeBL3rURPgahY=;
 b=EYIKcK7BOr8lEc3s1+vEqlIZ62Lm39nSwheuDeDJ3h66qJXD4w9w2SxL/VCy2C22cO
 OfwBMtywuaNaQt7qNydUrSmzl0nUHmoRVFYR9mhxkiQdHvp5HmaGku006+Y/SnksQgOq
 IdFPzBHBcwfDFZrwhIOcj0+WsS1RM7nCnTUCLTbqSMnmBOZtK1uiBvostZKZDFPgUF6L
 cRLDJ970sGmZKLZ/mafTVhVmkUvpWUl7yeQ4lUcWOAcJvGeABEl7GkOmjcEFTrhHaB4g
 rK9WHbYAIaROMBr0pgGlfjR1C5TIWXLAm9buH0mgA6pOkbxgy2sy1W8POCncQ4FScQdZ
 N+qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYEzjQPu57CFPI8n81+EqGPi/Uf6n+268cU/p0ta0kjwFqJH6aVRzoQjnHp7ckW6jQVwy8Nk4G9BA3mIY+sFAttMnI5Fk=
X-Gm-Message-State: AOJu0YwHV8Ulla3t5MiVsPuP8Zhz6B1YGKROZKZbKzHr06+yYtYaEGns
 pCyGmZ1gcT5FyAOgGtbdtS6wzQSlGY6mZgyAEUj7iMyPEU9AMuZzlwklLvUtsss=
X-Google-Smtp-Source: AGHT+IFBygD1ssyXUz97EztUf/3XVLIzyyWMbQP7sfagym/83SJLM8qzO2VW+cyKn3cT2KI+DYqE6w==
X-Received: by 2002:a17:902:f688:b0:1fa:643:f434 with SMTP id
 d9443c01a7336-1fbb6f0de9dmr80044785ad.66.1720733035964; 
 Thu, 11 Jul 2024 14:23:55 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a0fbfbsm54955125ad.49.2024.07.11.14.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 14:23:55 -0700 (PDT)
Message-ID: <641f264e-81ff-40fa-880d-bda18339ac57@linaro.org>
Date: Thu, 11 Jul 2024 14:23:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 rowan.hart@intel.com, Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
 <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
 <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
 <Zo00iKKtRRDTTslY@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Zo00iKKtRRDTTslY@redhat.com>
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

T24gNy85LzI0IDA2OjAwLCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiBPbiBUdWUs
IEp1bCAwOSwgMjAyNCBhdCAwMjoyODozOFBNICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3Rl
Og0KPj4gT24gVHVlLCBKdWwgOSwgMjAyNCBhdCAyOjA54oCvUE0gUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiB3cm90ZToNCj4+PiAgICogd2hhdCBpcyB0aGUg
YWN0dWFsIGJhc2VsaW5lIHJlcXVpcmVtZW50PyBXZSBkZWZpbml0ZWx5IHdhbnQNCj4+PiAg
ICAgdG8gc3VwcG9ydCAidXNpbmcgcnVzdHVwIG9uIGFuIG9sZGVyIHN5c3RlbSIgKHNob3Vs
ZCBiZSBubw0KPj4+ICAgICBwcm9ibGVtKSBhbmQgImN1cnJlbnQgZGlzdHJvIGJ1aWxkaW5n
IFFFTVUgdXNpbmcgdGhlIGRpc3RybydzDQo+Pj4gICAgIHJ1c3QiLCBJIGFzc3VtZS4gSXQg
d291bGQgY2VydGFpbmx5IGJlIG5pY2UgdG8gaGF2ZSAiYnVpbGRpbmcNCj4+PiAgICAgUUVN
VSBvbiB0aGUgb2xkZXItYnV0LXN0aWxsLWluLW91ci1zdXBwb3J0LWxpc3QgZGlzdHJvIHJl
bGVhc2VzDQo+Pj4gICAgIHdpdGggdGhhdCBkaXN0cm8ncyBydXN0IiwgYnV0IHRoaXMgcHJv
YmFibHkgaW1wbGllcyBub3QganVzdA0KPj4+ICAgICBhIG1pbmltdW0gcnVzdCB2ZXJzaW9u
IGJ1dCBhbHNvIGEgbGltaXRlZCBzZXQgb2YgY3JhdGVzLg0KPj4NCj4+IEkgZG9uJ3QgdGhp
bmsgbGltaXRpbmcgb3Vyc2VsdmVzIHRvIHRoZSBzZXQgb2YgY3JhdGVzIGluIHRoZSBkaXN0
cm8gaXMNCj4+IGZlYXNpYmxlLiBJdCdzIG5vdCB0aGUgd2F5IHRoZSBsYW5ndWFnZSB3b3Jr
cywgZm9yIGV4YW1wbGUgSSB0cmllZA0KPj4gY2hlY2tpbmcgaWYgdGhlICJjc3RyIiBjcmF0
ZSBleGlzdHMgYW5kIEkgZGlkbid0IGZpbmQgaXQgaW4gRGViaWFuLg0KPiANCj4gWWVwLCBS
dXN0IGlzIG5ldyBlbm91Z2ggdGhhdCBpdCBpcyBoaWdobHkgbGlrZWx5IHRoYXQgY3JhdGVz
IHdpbGwgYmUNCj4gbWlzc2luZyBpbiBtdWx0aXBsZSBkaXN0cm9zLg0KPiANCj4gRm9yIG9y
ZGluYXJ5IHVzZXJzLCBjYXJnbyB3aWxsIGhhcHBpbHkgZG93bmxvYWQgdGhlIG1pc3Npbmcg
cGllY2VzDQo+IHNvIGl0cyBub3QgYW4gaXNzdWUuDQo+IA0KPiBGb3IgZGlzdHJvIHBhY2th
Z2VycywgdGhleSdsbCBqdXN0IGhhdmUgdG8gZWl0aGVyIHBhY2thZ2UgdXAgdGhlIGNyYXRl
cywNCj4gb3IgYnVuZGxlIHRoZW0gaW4gdGhlaXIgUUVNVSBidWlsZC4gQ2FyZ28gbWFrZXMg
dGhlIGxhdHRlciBlYXN5IGF0DQo+IGxlYXN0LiBJZiBkaXN0cm9zIGRvbid0IHdhbnQgYnVu
ZGxpbmcsIHRoZXknbGwgbmVlZCB0byBnbyB0aGUgbW9yZQ0KPiBpbnZvbHZlZCByb3V0ZSBv
ZiBwYWNrYWdpbmcgZGVwcy4NCj4gDQo+IElPVywgZnJvbSBhIGRpc3RybyBQT1YsIElNSE8s
IHdlIHNob3VsZCBmb2N1cyBvbiB0aGUgUnVzdCB0b29sY2hhaW4NCj4gdmVyc2lvbnMgd2Ug
bmVlZCBhcyB0aGUgbWluaW11bSBiYXIuDQo+IA0KPiBXaXRoIHJlZ2FyZHMsDQo+IERhbmll
bA0KDQpJIHdvdWxkIGxpa2UgdG8gYWRkIHRoYXQsIGNvbnRyYXJ5IHRvIHBpcCBwYWNrYWdl
cyBmb3IgcHl0aG9uLCBpdCBjYW4gYmUgDQoqdHJ1c3RlZCogdGhhdCBSdXN0IGNyYXRlcy5p
byB3aWxsIGtlZXAgcGFja2FnZXMgYW5kIHRoZWlyIGRpZmZlcmVudCANCnZlcnNpb25zLCBh
cyBpdCB3YXMgZGVzaWduZWQgdG8gYmUgYW4gaW1tdXRhYmxlIHJlZ2lzdHJ5Lg0KDQpJbmRl
ZWQsIHVzZXJzIGNhbid0IHJlbW92ZSB0aGVpciBwYWNrYWdlLCBleGNlcHQgZm9yIHN0cm9u
ZyBzZWN1cml0eSANCmlzc3VlcywgdG8gdGhlIG9wcG9zaXRlIG9mIHBpcC4NCg0KQmVzaWRl
cyBvZmZsaW5lIGNvbXBpbGF0aW9uIHNjZW5hcmlvLCBhcmUgdGhlcmUgYW55IG90aGVyIHJl
YXNvbiBmb3IgDQp3YW50aW5nIHRvIHVzZSBkaXN0cm8gcGFja2FnZXMgaW5zdGVhZCBvZiBs
ZXR0aW5nIGNhcmdvIGRvIHRoZSB3b3JrPw0K

