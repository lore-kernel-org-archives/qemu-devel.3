Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E547E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 21:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWMBp-00067j-Bl; Fri, 10 Jan 2025 16:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWMBn-00065q-4h
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:05:07 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWMBl-0001Yq-F5
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:05:06 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2164b1f05caso43764415ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736543104; x=1737147904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DSTtiL4Ie/99SivteTO1QsHaWPXoasaR/qAIbc6kB18=;
 b=rvoa2XpB/9u1vz2gHQG8jnH9dLPOtPu5TKwUhrp2yIzoE29SDwieh8RXrGaL+Uv5El
 daoy6TftsJIc3hcDHvuuZO+teytW9fKLlya7gmx+KDE/l40Y85IjRn7+OBBP3GrZP8Db
 1AFiyf4ChUNF9ntnaKY/9Qd6rKBJBSaiJ+Pl3F+fxg4QevfJdPZX2ZA8JV6xhvfAY3UD
 1tk0pIdYsa6IFVhYq3JTZg8at9eO0rfFlzNdpHG8jAJAFXHKJDjMT81sBFFHDibCyOQh
 G3u9VUCJBQ1/5KEdOItgs5zwivi66sWj9odEKMsXklToEynbQSFOL/mKlrtKDmZGYnWL
 U1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736543104; x=1737147904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DSTtiL4Ie/99SivteTO1QsHaWPXoasaR/qAIbc6kB18=;
 b=LpHkC9tGKVs3BVuDP1xgKJdFucahWKtrjNw1XwB3e5alVuEWaUxRSSHI4wwfjT12xP
 cVKvYjcEqLWudXJICaqsL4yUeODFJditl0Ch0kc8GBOhLSfb6mXpR79ngXJNSeIAZQIQ
 Yqze7+qqIWtaJJLc6VngxyNEpxOnpB/zd+cUZbanSgXjQHHItNs5OM4stSxhzm07MrMf
 60sj9H4IFSuVxCDY2WiiUE+crBW+2iAOims5GpOPbjErUnYk7OOYnyaWDE9uwktxpEhO
 hZvRkISMSGzKEd14yY+D1iLsD2KB7/zv5VoBXVRpooJxUbppzSwPjFKPiNXdeIztiflq
 OVFg==
X-Gm-Message-State: AOJu0Yw8GZYEVfvR/pEBOvxENBXCp53kjT4C0HksDIEOPntXOVYH7QEv
 EIgebZIe/EAg2j0E5MjVIFUbLjCG7MZquFNIwVUf9iG+gCr43dtLdvpn5UUxLlw=
X-Gm-Gg: ASbGncvV3uDshV5DM/lvyuVbnsslX5rKmxyy8cH/yFzjQEuQzQ4CcYW3Us1S6+mZPUG
 3ttbcXb+SQsOjmY3L5gg1lLhSYbCNwW8yHbMPVOjlFLMVWrTDpoOr3tKoZpYoqKhD+YZ+fKMjiu
 o3iZVdT2viru2w4z3Z7kNdl/WN6ndDmbmi2c7VeUErBnuOvQ4+mshzAxaDPcOZ14TG+Hc+utU9J
 b5DCjj/6k4ZcSpieIE1I7LgpNdziVRIsJIfiPyr9RUa2cQ88FyOy6uyFNwDy3gzphsMpw==
X-Google-Smtp-Source: AGHT+IEOCYOxTnPfAnZ0lBbzEKJUg+SZOZzENP7XosOD0YuJOo0SzN5h561P0r+iu258WdchvU3yBQ==
X-Received: by 2002:a17:903:2310:b0:215:352c:af73 with SMTP id
 d9443c01a7336-21a83f5943fmr156118815ad.18.1736543103701; 
 Fri, 10 Jan 2025 13:05:03 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22d5fcsm17251975ad.176.2025.01.10.13.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 13:05:03 -0800 (PST)
Message-ID: <f7caa6f6-a5c0-472e-a509-7719f39a203a@linaro.org>
Date: Fri, 10 Jan 2025 13:05:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] system: propagate Error to gdbserver_start (and
 other device setups)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-11-alex.bennee@linaro.org>
 <da769717-0823-45b4-8b1c-9fd2611d0092@linaro.org>
 <87bjwf6abf.fsf@draig.linaro.org>
 <b46d7d01-ae4d-4c47-a3df-93ad46ff6a1d@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b46d7d01-ae4d-4c47-a3df-93ad46ff6a1d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMS85LzI1IDE0OjI3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
OS8xLzI1IDIwOjQ1LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+PiBQaWVycmljayBCb3V2aWVy
IDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4+DQo+Pj4gT24gMS85
LzI1IDA5OjA2LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4+IFRoaXMgc3RhcnRlZCBhcyBh
IGNsZWFuLXVwIHRvIHByb3Blcmx5IHBhc3MgYSBFcnJvciBoYW5kbGVyIHRvIHRoZQ0KPj4+
PiBnZGJzZXJ2ZXJfc3RhcnQgc28gd2UgY291bGQgZG8gdGhlIHJpZ2h0IHRoaW5nIGZvciBj
b21tYW5kIGxpbmUgYW5kDQo+Pj4+IEhNUCBpbnZvY2F0aW9ucy4NCj4+Pj4gTm93IHRoYXQg
d2UgaGF2ZSBjbGVhbmVkIHVwIGZvcmVhY2hfZGV2aWNlX2NvbmZpZ19vcl9leGl0KCkgaW4N
Cj4+Pj4gZWFybGllcg0KPj4+PiBwYXRjaGVzIHdlIGNhbiBmdXJ0aGVyIHNpbXBsaWZ5IGJ5
IGl0IGJ5IHBhc3NpbmcgJmVycm9yX2ZhdGFsIGluc3RlYWQNCj4+Pj4gb2YgY2hlY2tpbmcg
dGhlIHJldHVybiB2YWx1ZS4gSGF2aW5nIGEgcmV0dXJuIHZhbHVlIGlzIHN0aWxsIHVzZWZ1
bA0KPj4+PiBmb3IgSE1QIHRob3VnaCBzbyB0d2VhayB0aGUgcmV0dXJuIHRvIHVzZSBhIHNp
bXBsZSBib29sIGluc3RlYWQuDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8
YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4+Pj4gQWNrZWQtYnk6IElseWEgTGVvc2hrZXZp
Y2ggPGlpaUBsaW51eC5pYm0uY29tPg0KPj4+Pg0KPj4+DQo+Pj4gPHNuaXA+DQo+Pj4NCj4+
Pj4gLXN0YXRpYyBpbnQgZ2Ric2VydmVyX29wZW5fcG9ydChpbnQgcG9ydCkNCj4+Pj4gK3N0
YXRpYyBpbnQgZ2Ric2VydmVyX29wZW5fcG9ydChpbnQgcG9ydCwgRXJyb3IgKiplcnJwKQ0K
Pj4+DQo+Pj4gRGlkIHlvdSBtZWFuOg0KPj4+IHN0YXRpYyBib29sIGdkYnNlcnZlcl9vcGVu
X3BvcnQuLi4/DQo+Pg0KPj4geWVzLCB5ZXMgSSBkaWQuIFdpbGwgZml4Lg0KPiANCj4gVGhp
cyBpcyByZXR1cm5pbmcgYSBzb2NrZXQgZmlsZSBkZXNjcmlwdG9yLCB3aHkgYm9vbD8NCj4g
DQoNCk9vcHMsIHllcyBteSBjb21tZW50IHdhcyB3cm9uZy4NCldlIHNob3VsZCByZXR1cm4g
LTEsIGFzIGl0IHdhcyB0aGUgY2FzZSBiZWZvcmUuDQoNCj4+DQo+Pj4NCj4+PiBXaXRoIHRo
YXQsDQo+Pj4gUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZp
ZXJAbGluYXJvLm9yZz4NCj4+DQo+IA0KDQo=

