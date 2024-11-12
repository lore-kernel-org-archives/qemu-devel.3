Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401D3D597A7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 21:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAyQ6-0004DL-FA; Tue, 12 Nov 2024 16:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyQ5-0004CZ-3J
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:27:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyQ3-0004Wf-GZ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:27:28 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-431481433bdso54274935e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 13:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731446846; x=1732051646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mKGjSOcBFbGhHb2RTO6KhC/b1YcJbWL5HXNJSJMoTN0=;
 b=sRR45Z3+nraMbkcsCEsWzuDqkOmrKTTm1MKFTAWW6r33ZfQs1chQxTK9cNw5ZJasiW
 TZ5E6M90LXZlS6AQYWXjIOwkyZoFptnu1BtFtN3e6nryu65jT4mRHLaHXAdkp0Wf424t
 rZNUNgEM47uStxIMxJVkppfgSr8NuWWj4n/FgRVHPXoklot5866Nzc6Q5rB76Me1bb+T
 +tRboUBnjs78pM3eefAJm3kVhb+woUTmF6fEjL1k7pgn5Y4LV3kuRzxZtBNnsvo7v5Sl
 +Fa0c9xADP05Yt1bsvd+tW4fHqaqydcpT3TKKo+p3FGg8NJ/gkNcxUU3WZinWImsNLC3
 JbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731446846; x=1732051646;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mKGjSOcBFbGhHb2RTO6KhC/b1YcJbWL5HXNJSJMoTN0=;
 b=HsNSvlq2muQwarmxZhZSkpCIhNWKxYkVqqWXFElDnzuNvLLiVlVrQW9oLd6CWLbD3i
 LNVNP0d6pffxJAO4NP7H9JdhtasVRCPyaEda3eAUXLRvZ63uuRZf6ib/pMlXgGorR0QP
 ZqeWFkxJtmEQQeECJmAAoabAoOvzlIq3sPlBjxUqbkC5+adlZUpp1/OMIonyfhyCdiI9
 dhcbPqPosrY+Qwt5ms7v62pQ4clJBRXZrtu38iVFBAU5FQMSz9pyR6kLgwwieO1tJiZt
 gNMcypBuTV7CZdaJKCE3HugkIsF8EkbZCA5dTaqVV+ibilci8LxtI6SNLfQ9K5fxK0IT
 1CYg==
X-Gm-Message-State: AOJu0YwNl1VNajPr7Ujkn3H97z4aCVTB+xCyXS1CRUG9/AyAj+H69Kv8
 CQ578O1gVe92K5kIJvjZNxB5WE/HLC8bSKEemPV5qKCkQ3t+eG6As+MjewFfJDs=
X-Google-Smtp-Source: AGHT+IHPem24eBjM25szq1cFjKyK1WoMX7w6Cu/w/oL00W/uzjKRmo4F/b6ShFeQ4mrz1whIAW+eHQ==
X-Received: by 2002:a05:600c:3488:b0:431:588a:44a2 with SMTP id
 5b1f17b1804b1-432d4ab0f0dmr5638465e9.12.1731446846086; 
 Tue, 12 Nov 2024 13:27:26 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d54e0e40sm93035e9.5.2024.11.12.13.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 13:27:25 -0800 (PST)
Message-ID: <694ebcfa-7e5e-47c8-a3d5-9da2ca3f734e@linaro.org>
Date: Tue, 12 Nov 2024 13:27:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] plugins: generate list of symbols automatically
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>
References: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
 <877c98upm0.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <877c98upm0.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32e.google.com
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

T24gMTEvMTIvMjQgMTM6MDgsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gTm93
IHRoYXQgbWVzb24gYnVpbGQgZm9yIHBsdWdpbnMgd2FzIG1lcmdlZCwgd2UgY2FuIGNsZWFu
dXAgYW5vdGhlciBwYXJ0IHdpdGgNCj4+IHRoZSBzeW1ib2xzIGZpbGUuDQo+PiBJdCBoYXMg
dG8gYmUga2VwdCBpbiBzeW5jIGJldHdlZW4gdGhlIGhlYWRlciAocWVtdS1wbHVnaW4uaCkg
YW5kIHRoZSBzeW1ib2xzDQo+PiBmaWxlLiBUaGlzIGhhcyBwcm92ZWQgdG8gYmUgZXJyb3Ig
cHJvbmUgYW5kIHRlZGlvdXMuDQo+Pg0KPj4gV2Ugc29sdmUgdGhpcyBieSBnZW5lcmF0aW5n
IHRoaXMgbGlzdCBmcm9tIGhlYWRlciBkaXJlY3RseSB1c2luZyBhIHB5dGhvbg0KPj4gc2Ny
aXB0LiBEZXBlbmRlbmNpZXMgYXJlIHRyaWdnZXJlZCBjb3JyZWN0bHksIGFuZCB0aGUgZmls
ZSBpcyByZWdlbmVyYXRlZCBpZiB0aGUNCj4+IGhlYWRlciBpcyBtb2RpZmllZCwgYXMgZXhw
ZWN0ZWQuDQo+Pg0KPj4gUGllcnJpY2sgQm91dmllciAoMyk6DQo+PiAgICBwbHVnaW5zOiBh
ZGQgbWlzc2luZyBleHBvcnQgZm9yIHFlbXVfcGx1Z2luX251bV92Y3B1cw0KPj4gICAgcGx1
Z2luczogZGV0ZWN0IHFlbXUgcGx1Z2luIEFQSSBzeW1ib2xzIGZyb20gaGVhZGVyDQo+PiAg
ICBwbHVnaW5zOiBlcmFkaWNhdGUgcWVtdS1wbHVnaW5zLnN5bWJvbHMgc3RhdGljIGZpbGUN
Cj4+DQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4+ICAg
aW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmggICAgIHwgIDEgKw0KPj4gICBwbHVnaW5zL21l
c29uLmJ1aWxkICAgICAgICAgICAgfCAxMiArKysrKy0tDQo+IA0KPiB0aGlzIGZhaWxlZCB0
byBhcHBseSBjbGVhbmx5Lg0KDQpTb3JyeSBhYm91dCB0aGF0LiBUaGUgY29tbWl0IGlzIGNv
cnJlY3QgYnV0IHRoZSBwYXRjaCBjb250ZXh0IGlzIA0KaW5jb3JyZWN0LiBGaXhlZCBpbiB2
NC4NCg0KPiANCj4+ICAgcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scyAgIHwgNTkgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICBzY3JpcHRzL3FlbXUtcGx1
Z2luLXN5bWJvbHMucHkgfCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICA1
IGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDYyIGRlbGV0aW9ucygtKQ0KPj4g
ICBkZWxldGUgbW9kZSAxMDA2NDQgcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scw0KPj4g
ICBjcmVhdGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9xZW11LXBsdWdpbi1zeW1ib2xzLnB5DQo+
IA0KDQo=

