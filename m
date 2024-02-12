Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDBDC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 06:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZPjt-0008SD-DC; Mon, 12 Feb 2024 01:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZPjp-0008QP-Jd
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 01:24:23 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZPjo-00068f-2c
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 01:24:21 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-410d57a533dso3667855e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 Feb 2024 22:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707719058; x=1708323858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dlgdvAZfQiHDplPO9CEw23EpuxEmCKFYe130hbC3HtM=;
 b=jIxr7R2vP7Uw4CclEfWCQykhu8d/2cxztHK9NIt9rbPFBE/fqRffr/d0+iDFJpjvH1
 viyoB6OGU+uRdQ9dfyw6jPySJW11YyCuM8lcvx71ORl4ZoOdda/fO/ZeMu0oRoye9rIp
 GjkpOWd0OWRzA46KhcgWS5tOAuYzdZjxG/IGhrL6TsKvHVMeYGgz9vhrcyANW7e9oZZo
 d8nuwjC8ItIGBQ3F4sobGlsTeecO9wAx6tjgK0ye+nOK0Dw/gmFCoZgeYYW6WjARtqwG
 K0X26yjGPjaXSrQ6pKZ6+sERbCQI/jw0P8B9w8UdY7QzIe8vbLBHR7FZPih7IPcjC9wK
 B66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707719058; x=1708323858;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dlgdvAZfQiHDplPO9CEw23EpuxEmCKFYe130hbC3HtM=;
 b=oF3dqOt2+/Xfkz3LrCebnh3fA/WV7PQ4Zxr7kt/3o66AxFDS8vBKlMmBbGcZEW6GJo
 0EYgjq/0nw9yGi6DPivLn+YZGkQzLR84PFAnUemoGsgNQavEO6Cn1XQ1methE2fP9Flh
 DgkUjW9+bm/KIkitzo+HS4KJChZktgXkQnaP+Lvm4E2WSOnAYZ4iUKJLVGaIh5HnBssm
 poXjoBHNnJjJghAwxIKykl9NBoGSGpHiWHyIDGCn41YkGRcrQx0pwUX4bsh6GSC/3L9y
 U6JzUWraXc/Xc8pbGrv3MKQJv7qLyBj/PH1mDFYRXyNwAZyxHRZp+LHvFGUsO3Nwq287
 qKDQ==
X-Gm-Message-State: AOJu0YxWQBDfYuUW08MQAQRw4XrbGN9R2BqFO2UgLNUXxmhG9PD2k72H
 pgkc2RFWhJ98SEt8JnqGnjF8K87UJHvOTPXGr3dQFqGopbPL1IBNwhBQbZ/Wtv8=
X-Google-Smtp-Source: AGHT+IFKk1vft9KIg8h1nhbRh4CGlOBG6+K0bn+m6nv+V9A+Lm/OroVrgFRUj26GpAsBXTw6bTwueg==
X-Received: by 2002:a05:600c:a385:b0:410:9959:e40e with SMTP id
 hn5-20020a05600ca38500b004109959e40emr3816445wmb.10.1707719058149; 
 Sun, 11 Feb 2024 22:24:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUvFOuWOSQ6SflbB9KVokge9sG5BVvuF6ImDw8gK+FvmN7RDK3iO9V6jhc+61RkNMukMNXvOUlQEX3XyiEaFMchHbnTY2PgSSjdwsg1imLc91iZtfMuVSRvB4l6NAfKn6d6WmIfaRTGdp+O+er65mpJXxdohq9RQDh3DSbyKFbFfPHUDjSpcYEyo77Fvu588z4H1DDVse/ZXf7EMeaJ7feeZWboUQUSBaX3mWJ2h0QybC4YPQkh0TzU0YFG3TA6u60pUnQOsRxlOPmbsPaJ8GczdEH929c7QddDPTuSdhpJYT1kwk4b/jLeUxaZbfdLsq5beDJf4SZrUqWCM8Z0045T
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c154d00b0040fb783ad93sm7484790wmg.48.2024.02.11.22.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Feb 2024 22:24:17 -0800 (PST)
Message-ID: <3402d8b4-9092-465d-8660-9eeabb0a59d6@linaro.org>
Date: Mon, 12 Feb 2024 10:24:12 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] plugins: scoreboard API
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-6-pierrick.bouvier@linaro.org>
 <e4db51de-a040-4c9e-93fa-64a378e4e5fa@linaro.org>
 <3381ba3a-ae14-4160-b651-d88a7893189b@linaro.org>
 <73e5314b-5e92-4a57-9780-508a8f33fe72@linaro.org>
 <18e758f6-eb96-4418-9494-88092f8813dd@linaro.org>
 <acafbcf1-8606-4450-8720-d96078fe5b03@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <acafbcf1-8606-4450-8720-d96078fe5b03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

T24gMi8xMS8yNCAyMzoxMywgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDIvMTEv
MjQgMDQ6MjYsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAyLzExLzI0IDA0OjQx
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAyLzYvMjQgMTk6NTksIFBpZXJy
aWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+PiBXaHkgYSBoYXNoIHRhYmxlP8KgIEFsbCB5b3Ug
d2FudCBpcyB0byBiZSBhYmxlIHRvIGl0ZXJhdGUgdGhyb3VnaCBhbGwsIGFuZCBhZGQvcmVt
b3ZlDQo+Pj4+PiBlYXNpbHkuwqAgU2VlbXMgbGlrZSBRTElTVCBmcm9tIDxxZW11L3F1ZXVl
Lmg+IHdvdWxkIGJlIGJldHRlciwgYW5kIHRoZSBRTElTVF9FTlRSWSBtZW1iZXINCj4+Pj4+
IHdvdWxkIG1ha2Ugc3RydWN0IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmQgdXNlZnVsLg0KPj4+
Pj4NCj4+Pj4NCj4+Pj4gVGhvdWdodCB0aGF0IGhhdmluZyBPKDEpIHJlbW92YWwgd2FzIGEg
bmljZSBwcm9wZXJ0eSwgY29tcGFyZWQgdG8gYSBsaW5rZWQgbGlzdC4gSSBjYW4NCj4+Pj4g
c3dpdGNoIHRvIGEgUUxJU1QgaWYgeW91IHN0aWxsIHRoaW5rIGl0J3MgYmV0dGVyLg0KPj4+
DQo+Pj4gUUxJU1QgaXMgZG91YmxlLWxpbmtlZCwgc28gaXQncyBzdGlsbCBPKDEpLg0KPj4+
DQo+Pj4NCj4+DQo+PiBJcyBpdCBhbiAiaW50cnVzaXZlIiBsaW5rZWQgbGlzdCAod2hlcmUg
bmV4dCBhbmQgcHJldiBhcmUgcGFydCBvZiB0aGUgc3RydWN0IGVudHJ5IGl0c2VsZik/DQo+
IA0KPiBZZXMuDQo+DQoNClNvdW5kcyBnb29kIHRoZW4sIEknbGwgc3dpdGNoIHRvIFFMSVNU
Lg0KDQo+IA0KPiByfg0K

