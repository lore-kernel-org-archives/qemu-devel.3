Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D231EC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 18:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOM9L-00019q-Et; Mon, 01 Jul 2024 14:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOM9J-00019g-RW
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 14:53:13 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOM9G-00047V-UL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 14:53:13 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5b9a35a0901so1145158eaf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719859989; x=1720464789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M9uo/qebLVRCe1N1WcKipmPbR6rj8HHmxcukxrxRWOc=;
 b=qnV2l433bNpPfZCJSW6dmTOvIKk1v2sVMAtJeL5OmH/b2xov+/YxOUlW778vbzHc/B
 YRot3bXdzHgXejdFzgdJpvFMC+r/+NcpedymqPqk9mBrJrxR8YrAjdSipMs4gO63lW7d
 QqOV6hQVz53b+FDTge3zfn9g6ExkOPe1QiJLjGHwKXQjm7+9+Ejh81e3Renqb4m+6CRR
 /7pQZcC6Mu0FiwfzCtX8KolPp5Sw7lbFtZJtXhNqC2QkNf9TvnQMXj+WClYxMtkDgvm5
 Q2wnxoZc4s1WWMPc48h5vJ2LMTnFBZABfeo4KMkPy6ykmRM7dart9YcuNJzira3yPVor
 29kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719859989; x=1720464789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M9uo/qebLVRCe1N1WcKipmPbR6rj8HHmxcukxrxRWOc=;
 b=SFi/fMxrqgMM3wG5gOFFPpZM68n3neT9548c/3ve+aEIJZqxWgA+AfUsA88hmWQE9u
 +81xkjyb/yiYgRLD0O/nPST8r8V1jFDRF/MxCnaLubx4ahJXF6gvfX1QHRz3FuSndgkO
 Q1eC1qATqh1Vg3KRZEx1ySMTsi5dHvBvE5fGapApZ+wsJKC9NwSW3UwkqWud3KOHiuqS
 S9XKrRhDuDPZv/lDoYvUFcYodfivzJ4PFA+KixQDHbaFGc2c1++Z9I99gINYjbr/Z/4z
 TTyrQCiFr8GIesqYtZS13dj/VS8eh20p02/6eIB/ptb0gKpfZsLVKm0TlVrJ5XpsEFgQ
 iJbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXpzAziEmbtMstu+ZI8hlIMM4ebP0ccVJJsQegRkYvkpwQUo98FdW8w+pq9QxBkFg1ckEhufPA0XUVAXPgym7+IqdjC/g=
X-Gm-Message-State: AOJu0YwYaaSyfwG4Lna6O9DZqgbg9+90Yk0Qm+RCbU96dOQ8yJ1DaY7O
 dYMnXihgpvsdDiB5JHj6hYVsprD9JZjiJ3nLCbEo3Egdt4gL7bcorKKDV2Hyi30=
X-Google-Smtp-Source: AGHT+IECUhrJBiyP33JtAoqDo3IKLWCLb5vkdKFyyVBytzJZQ9RyzXp7oUwSyXSIOTW6ESi2xJekcw==
X-Received: by 2002:a05:6358:2910:b0:1a6:72f7:6ad0 with SMTP id
 e5c5f4694b2df-1a6acef59b9mr680992755d.21.1719859988848; 
 Mon, 01 Jul 2024 11:53:08 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6afb8ef1sm5426340a12.40.2024.07.01.11.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 11:53:08 -0700 (PDT)
Message-ID: <3d48a27a-b9fd-44a7-8fc8-5bfd028db37e@linaro.org>
Date: Mon, 1 Jul 2024 11:53:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnlGlOGORQkOsoO5@intel.com> <fl60u.ry7sk6d8fv39@linaro.org>
 <ZnrpgW+CopiJAGZF@intel.com> <fnew7.3urdmuxnhe3l@linaro.org>
 <27f52dce-b659-446d-8358-50b6001f7307@linaro.org>
 <dfa7bc8f-378f-4876-b630-fe1182dca937@linaro.org>
 <CABgObfYOE0HsmuCmHauOPDVpz2Og-jixkV7iHYSgkg2zmaahXw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfYOE0HsmuCmHauOPDVpz2Og-jixkV7iHYSgkg2zmaahXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oo1-xc2e.google.com
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

U2VlbXMgbGlrZSB0aGUgdXNpbmcgY2ZnX2F0dHIgd2FzIHRha2VuIGZyb20gdGhpcyBjcmF0
ZSwgc28gaXQgc2hvdWxkIGJlIA0KZXF1aXZhbGVudCB0byB1c2luZyBpdC4NCg0KT24gNi8y
OC8yNCAxNDo1MCwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gT24gRnJpLCBKdW4gMjgsIDIw
MjQgYXQgOToxMuKAr1BNIFBpZXJyaWNrIEJvdXZpZXINCj4gPHBpZXJyaWNrLmJvdXZpZXJA
bGluYXJvLm9yZz4gd3JvdGU6DQo+PiBIb3dldmVyLCBldmVuIHRvdWdoIEkgY2FuIGJ1aWxk
IHRoZSBleGVjdXRhYmxlLCBJIGdldCB0aGlzIGVycm9yOg0KPj4gJCAuL2J1aWxkL3FlbXUt
c3lzdGVtLWFhcmNoNjQgLU0gdmlydA0KPj4gQzpcd1xxZW11XGJ1aWxkXHFlbXUtc3lzdGVt
LWFhcmNoNjQuZXhlOiB1bmtub3duIHR5cGUgJ3gtcGwwMTEtcnVzdCcNCj4+DQo+PiBBbnkg
aWRlYSBvZiB3aGF0IGNvdWxkIGJlIG1pc3NpbmcgaGVyZT8NCj4gDQo+IE1heWJlIHRoZSB1
bmRlcmx5aW5nIG1lY2hhbmlzbSB0byBpbnZva2UgY29uc3RydWN0b3JzIGlzIGRpZmZlcmVu
dD8NCj4gDQo+IFBlcmhhcHMgd2UgY291bGQgdXNlIGh0dHBzOi8vY3JhdGVzLmlvL2NyYXRl
cy9jdG9yIGluc3RlYWQ/DQo+IA0KPiBQYW9sbw0KPiANCg==

