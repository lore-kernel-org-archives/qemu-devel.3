Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D780C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWvpl-0007XS-M7; Mon, 05 Feb 2024 05:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rWvpk-0007X9-G8
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:04:12 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rWvph-0000ma-Bp
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:04:12 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40fccd090c2so19093215e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 02:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707127447; x=1707732247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MkdkvJQftVnKaY82EdCy5JeXX30Cnmo5Kyr9u/FMSvk=;
 b=tR0W7v5uJiZhCC0R5DCTITdS2/H99hOKrRmZfC/SKq1GnYNcwse4dJPLo6s2uNBHYu
 vXZTg6eQeT9BzEDbyKy9qnanWfuA71jFyewELaeK5Qfh1zW7C7MFwzMA/GNQtDJQr9DW
 +AXTn+R2sK8FzK6hr5q5GdzOmZyVwuTA0JUAb0GAkDNDUozrbnvect46hhMwkG2m9QMy
 cTEYPxIzk6bExP3lpoDoikxPCH15xvPWHqTrRIYRixU04jjBWIxcSQydo+dpGxUuOHOp
 qO+rLQZ717djpfLF285P3zI+U23F43iWBFLxeO4O+0F0bmXMLwjOQn4meahOMfZOwetR
 8EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707127447; x=1707732247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MkdkvJQftVnKaY82EdCy5JeXX30Cnmo5Kyr9u/FMSvk=;
 b=qI7+NiXWQtCtszDAuvkMuzHQRiSxmgVo3qVxUYAth9BMOroDWhpyS3ajD8teRqK4c1
 6FXB7zU2FJbe4eD2rjWJf7D2JDcCdPcS3OIDcEiDS0N8Of6I6i642Krrvsa2vvx7NRMv
 o+zsNkvZNskPdyGvUFEHlKZfINa89V9uCmAsxrQ1B3f7qt9VzD1G4nOdfTYe2l28Hpf8
 PYos+JOa5t0GJGOlkVCw9S/aG2+stGrxb7hqVTnwGF3yt6S8/jLJPxk6TLz+A3OI6JgB
 mM+v1E/AefvHOFHoqcr1ARMdWhGRVABnKRs9BqtJVlvoFk+41bxaju315jdYfE5NJDF1
 cWfQ==
X-Gm-Message-State: AOJu0Yyb77x0J7Nd/1Ywpo5RSQ9cvp+IEF2a70qn4js5WFXHHQPwg0L7
 zSQrR394fxLCnKsMH33wAq1HJUnL8HDn1KhtTxR4uUCueN4UhqM7fMjah/pfbRs=
X-Google-Smtp-Source: AGHT+IGM3ptTmB9qPfAviYIKwlw15mjRd4IbG1pf4jmWokNTmAc6WcdZEQzldUCXsBapKOEJdAx+5w==
X-Received: by 2002:a05:600c:4ec7:b0:40e:5ed3:ccf4 with SMTP id
 g7-20020a05600c4ec700b0040e5ed3ccf4mr4398883wmq.16.1707127447199; 
 Mon, 05 Feb 2024 02:04:07 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUtKZUM2z/oiJ59vug8nNg6UXO9pzKBtFnJaDjZdBoFR7OnqIPMqr+lXBfyUzbdXl4V3AXDqm0lxDb91QCLZUpS+iSR97Aguyv62XIeIj2Y+SQmCA7z6NKC5JXLIbWeym+AiFzp/D3PkJ52q2Vnu6onzjQujoA718b/gQnIVsFfuFhtqc9CJ4g34Ml5vv8HmXyfha3EUhPTJ/Kad6iOl6KBKlWRQkJi5UjmFwy8m97WDCtPzJeRHf7aWaNt6Eg6mmTgT94GaD4hst87Y2MHxoBg7VkO7xjIteA0vweufM/qX6bojs4/cvonxj8awGECNmV29U+kgGev5JJXKLjUdLXBW3HMmv3p2r35761Nm/Bbo63k5jvb795acjUVONliqwlKZeWaoqfYfDtWkUnLXhxFDqfIjWNVzzLyFf5vzW/symbJrXup8e/5eCQc0hvXG7rrDqdApQVEwy6ZFRk34E9dgJyJLAUR3HULIKaQzbOS7d36zh/rQL9h5g==
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adfe512000000b0033946c0f9e7sm7705992wrm.17.2024.02.05.02.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 02:04:06 -0800 (PST)
Message-ID: <612315ae-2132-4e41-8d16-6635dab54a1b@linaro.org>
Date: Mon, 5 Feb 2024 14:03:59 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/3] gdbstub and TCG plugin improvements
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
 <87bk8xpzyl.fsf@draig.linaro.org>
 <b34c4013-1aca-466e-b94e-55d9802928b3@daynix.com>
 <87zfwhodit.fsf@draig.linaro.org>
 <7fae3d1a-5af2-4557-a2b3-13b911e73382@daynix.com>
 <8734u7gsv0.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8734u7gsv0.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

T24gMi81LzI0IDEzOjMxLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IEFraWhpa28gT2Rha2kg
PGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4gd3JpdGVzOg0KPiANCj4+IE9uIDIwMjQvMDIv
MDMgMjI6NTgsIEFsZXggQmVubsOpZSB3cm90ZToNCj4+PiBBa2loaWtvIE9kYWtpIDxha2lo
aWtvLm9kYWtpQGRheW5peC5jb20+IHdyaXRlczoNCj4+Pg0KPj4+PiBPbiAyMDI0LzAyLzAz
IDIwOjA4LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4+PiBBa2loaWtvIE9kYWtpIDxha2lo
aWtvLm9kYWtpQGRheW5peC5jb20+IHdyaXRlczoNCj4+Pj4+DQo+Pj4+Pj4gVGhpcyBzZXJp
ZXMgZXh0cmFjdHMgZml4ZXMgYW5kIHJlZmFjdG9yaW5ncyB0aGF0IGNhbiBiZSBhcHBsaWVk
DQo+Pj4+Pj4gaW5kZXBlbmRlbnRseSBmcm9tICJbUEFUQ0ggdjkgMDAvMjNdIHBsdWdpbnM6
IEFsbG93IHRvIHJlYWQgcmVnaXN0ZXJzIi4NCj4+Pj4+Pg0KPj4+Pj4+IFRoZSBwYXRjaCAi
dGFyZ2V0L3Jpc2N2OiBNb3ZlIE1JU0EgbGltaXRzIHRvIGNsYXNzIiB3YXMgcmVwbGFjZWQg
d2l0aA0KPj4+Pj4+IHBhdGNoICJ0YXJnZXQvcmlzY3Y6IE1vdmUgbWlzYV9teGxfbWF4IHRv
IGNsYXNzIiBzaW5jZSBJIGZvdW5kIGluc3RhbmNlcw0KPj4+Pj4+IG1heSBoYXZlIGRpZmZl
cmVudCBtaXNhX2V4dF9tYXNrLg0KPj4+Pj4gQXMgdGhpcyBpcyByZS1iYXNlZCBvbiBBbGlz
dGFpcidzIHJpc2N2LXRvLWFwcGx5Lm5leHQgdHJlZSBJJ2xsIHdhaXQNCj4+Pj4+IGZvcg0K
Pj4+Pj4gdGhpcyB0byBnbyB0aHJvdWdoIHRoZSBSaXNjViB0cmVlcyBhbmQgdGhlbiByZS1i
YXNlIHRoZSBwbHVnaW4gcGF0Y2hlcw0KPj4+Pj4gYW5kIGRyb3BwaW5nIHRoZSBtZXJnZWQg
cmlzY3YgcGF0Y2hlcyBmcm9tIG15IHRyZWUuDQo+Pj4+PiBJbiB0aGUgbWVhbnRpbWUgZmVl
bCBmcmVlIHRvIHJldmlldzoNCj4+Pj4+ICAgICAgTWVzc2FnZS1JZDogPDIwMjQwMTIyMTQ1
NjEwLjQxMzgzNi0xLWFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+Pj4+PiAgICAgIERhdGU6
IE1vbiwgMjIgSmFuIDIwMjQgMTQ6NTU6NDkgKzAwMDANCj4+Pj4+ICAgICAgU3ViamVjdDog
W1BBVENIIHYzIDAwLzIxXSBwbHVnaW4gdXBkYXRlcyAocmVnaXN0ZXIgYWNjZXNzKSBmb3Ig
OS4wIChwcmUtUFI/KQ0KPj4+Pj4gICAgICBGcm9tOiA9P1VURi04P3E/QWxleD0yMEJlbm49
QzM9QTllPz0gPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+Pj4+PiBGb3I6DQo+Pj4+PiAg
ICAgIGNvbnRyaWIvcGx1Z2luczogZXh0ZW5kIGV4ZWNsb2cgdG8gdHJhY2sgcmVnaXN0ZXIg
Y2hhbmdlcw0KPj4+Pj4gICAgICBnZGJzdHViOiBleHBvc2UgYXBpIHRvIGZpbmQgcmVnaXN0
ZXJzDQo+Pj4+PiBTbyBJIGNhbiBhZGQgdGhpcyB0byBteSBtYWludGFpbmVyIG9tbmlidXMg
c2VyaWVzIGZvciB0aGUgbmV4dCBQUiBJDQo+Pj4+PiBzZW5kLg0KPj4+Pg0KPj4+PiBJIGFk
ZGVkIG9uZSB0cml2aWFsIGNvbW1lbnQgdG86ICJnZGJzdHViOiBleHBvc2UgYXBpIHRvIGZp
bmQgcmVnaXN0ZXJzIg0KPj4+Pg0KPj4+PiAiY29udHJpYi9wbHVnaW5zOiBleHRlbmQgZXhl
Y2xvZyB0byB0cmFjayByZWdpc3RlciBjaGFuZ2VzIiBkZXBlbmRzIG9uDQo+Pj4+ICJwbHVn
aW5zOiBhZGQgYW4gQVBJIHRvIHJlYWQgcmVnaXN0ZXJzIi4gVGhlIGNvbW1lbnRzIGZvciB0
aGUgcGF0Y2ggaW4NCj4+Pj4gdGhlIGZvbGxvd2luZyBlbWFpbCBhcmUgbm90IGFkZHJlc3Nl
ZCB5ZXQ6DQo+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC80YjIxNTZlZC02ODhk
LTQ2MTctYjUyZC0yMDA0MTNmMDExNTZAZGF5bml4LmNvbS8NCj4+PiBJIGRvbid0IHRoaW5r
IHdlIG5lZWQgdG8gc2VyaWFsaXNlIHdpdGggdGhlIEJRTCBhcyB0aGUgc3RydWN0dXJlcw0K
Pj4+IGFyZQ0KPj4+IHBlci1DUFUgKGFuZCBjcmVhdGVkIG9uIHZDUFUgY3JlYXRpb24pLg0K
Pj4NCj4+IHFlbXVfcGx1Z2luX2dldF9yZWdpc3RlcnMoKSBoYXMgdmNwdSBwYXJhbWV0ZXIs
IHdoaWNoIGNhbiByZWZlciB0byBhDQo+PiBkaWZmZXJlbnQgdmNwdSB0aGUgY2FsbGVyIGlz
IG9uIChvciB0aGUgY2FsbGVyIG1heSBub3QgYmUgaW4gYSB2Y3B1DQo+PiBjb250ZXh0IGF0
IGFsbCkuDQo+IA0KPiBJdCBzaG91bGQgb25seSBiZSBjYWxsZWQgZnJvbSB0aGUgY3VycmVu
dCBjcHUgY29udGV4dC4gV2UgY2FuIGVpdGhlcg0KPiBhc3NlcnQgdGhhdCBvciBtYWtlIGl0
IGltcGxpY2l0IGxpa2UgcWVtdV9wbHVnaW5faW5zbl9kaXNhcyBkb2VzLg0KPiBIb3dldmVy
IHdlIHdpbGwgbmVlZCB0byBlbnN1cmUgY3VycmVudF9jcHUgaXMgc2V0IGJlZm9yZSB0aGUg
dmNwdV9pbml0DQo+IGNhbGxiYWNrLg0KPiANCj4gUGllcnJpY2sgaGFzIGhhZCB0byBtb3Zl
IHRoZXNlIGluaXRpYWxpc2F0aW9ucyBhcm91bmQgZm9yIHRoZSBzY29yZWJvYXJkDQo+IHdv
cmsgc28gdGhleSBhcmUgbm93IHJ1biB3aXRoIHNhZmUgd29yayBvbmNlIHRoZSB0aHJlYWQg
c3RhcnRzLg0KPiANCg0KQXMgYSBjb21wbGVtZW50LCBpbiB0aGUgc2VyaWVzIEknbGwgcG9z
dCwgdGhlIHdvcmsgaXMgcnVuIA0KYXN5bmNocm9ub3VzbHksIGJ1dCBub3QgInNhZmVfYXN5
bmMiLCB3aGljaCBtZWFucyBpdCdzIG5vdCB1bmRlciBhbiANCmV4Y2x1c2l2ZSBzZWN0aW9u
Lg0KDQpJZiB5b3UgbmVlZCB0aGlzIGd1YXJhbnRlZSBmb3IgcmVnaXN0ZXJzIEFQSSwgaXQn
cyBiZXR0ZXIgdG8gYWRkIHRoaXMuDQoNCj4+DQo+Pj4gQXMgZmFyIGFzIHRoZSByZXN0cnVj
dHVyaW5nIHdlIGNhbiBtb3ZlIGl0IGludG8gZ2Ric3R1YiBsYXRlciBpZg0KPj4+IHRoZXJl
DQo+Pj4gaXMgYSBuZWVkIHRvLiBBdCB0aGUgbW9tZW50IHRoZSBzdHJ1Y3R1cmUgaXMganVz
dCBob3VzZWtlZXBpbmcgZm9yDQo+Pj4gcGx1Z2lucy4NCj4+DQo+PiBDZXJ0YWlubHkgd2Ug
Y2FuIG1vdmUgaXQgbGF0ZXIsIGJ1dCBhZGRpbmcgdGhlIGNvZGUgaW4gdGhlIHBsdWdpbg0K
Pj4gaW5mcmFzdHJ1Y3R1cmUgbm93IHdvbid0IGhlbHAgaW4gdGhhdCBjYXNlLg0KPiANCg==


