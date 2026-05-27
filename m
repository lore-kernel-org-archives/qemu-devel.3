Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BE7CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSA2I-0008Ig-DO; Wed, 27 May 2026 04:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1wSA2G-0008Hy-8t
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:54:44 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1wSA2C-0002ci-Py
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:54:44 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d75312379so9677271f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1779872078; x=1780476878; darn=nongnu.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=94NmT0UuxN7nUB+lGkz8NcatiaMHMVe0NdCcTf9iuTg=;
 b=eof0HrKV+ACND47X96kn0A6QBEVJJ8xBfWUvvFxMDsyTVYOrvp2cNZn0frTgwFf+XO
 bszoWtNZ+CM7vdZwCQMg186CqJQQyZvS0xoOh+HAH2bgQyHx293pItxk2pRXXeqem9vJ
 QKtvHO0T6mP9KdL6j7VqEB8d+Rfgx26FHjRzT65Q1r8D5PByPHl3puL0znH8jZzEiFVZ
 mI3GOEDVzgsz0DCg2h1J62n7srj6z19sR0uUyLNHp92Ogs1jZAlOs27UxtaTOf+lDpR3
 M8gP3LlFi+TTVXH1GjrqobG7HphFKTZpYoKL9wcWakAeLbkemxfP5M1GOnkfXqQcGu5v
 Prmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779872078; x=1780476878;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=94NmT0UuxN7nUB+lGkz8NcatiaMHMVe0NdCcTf9iuTg=;
 b=p1dptBjY4Fs2XeOt6lnv3kkqQFREAIs15sIfKtGBkSqTy74wG+IO1wM14eOE4wllZq
 RAelZTaEoQXVr7vMq62WbK2lKhhW09G1gKzNXgufG9MtAa0sev32NGJtvwInWroJgblw
 jvIpofosy8YY/qLJfT/tli+S7YPbQiiqfUKas5pgjYdPaQrRnucJ303+9hYcF2+h2S1K
 J5BN4blLOwzV2FxIp/xT9uKeFe0qskxFUVQ/X/STpque73mXXc2ndTfQBMc5tous6l2S
 sh7w2hitLw77sj0FRssThq3xrcKZBJaF8RcOCPLJLhGKdgY7JtEwMyLPCq7WJBaO29Xv
 TeEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CzwRkzgqfjKWgEJCOILpgREv05kpbwk9Ob/RDfZCT/5isbHu/xKkHWmKUUUc1ZjSYJOgj1NUSaIGx@nongnu.org
X-Gm-Message-State: AOJu0YzuVCrBLvsMQEayVvvxFqk+zcUFJ7CkRGBVFO9LfbVQAZTge8fw
 m9Hf82PKQdgdWLi9U92KQVFwPjRBooF1X5a/kGOuAd72I6ZMLBnkpgDlOvI81g43YmQ=
X-Gm-Gg: Acq92OFEoZFU8mNcpc16l6RsPNzlbScgvC5yl2KgqY2ekCxisXoJ2MqMWBiPMMCHSix
 jH2O/2lHuxqRRbh/xjQfV0vrV55AqW8OtYM3Hiwb38h56AsWvlMLr3Um0U3eUCheBCLAUgtRvM7
 M9ZCkCTtsw8LSFgQtXq/Ocl1IzKMyU0U01436KBybc80qAHfg7zv4J8Bk1EG+T9VWIIfsEogv2e
 0MjZYiCosqB1m8QKpdGC5Y06Mfyp4zKGaBfUa44OIXdpEAkn9we/s9tl9k/8GvF65f82wXEARyj
 HCUXjzyHJm8sS49ucQf4oWQ0modQ1MGguAM4VsCnoKs3JpbYxr6hKESEXvJmfIfX2Qbp5ljm8zF
 oz82AveR+fdKefCmVIySgpPHadrzew6hZpQDYLcQ+xFsafI05OEzYzxKiJEQPGsspIXQpgshwQ1
 agw/QrEAd3ne445vKX0BpOOoot6kkfsYujoQ==
X-Received: by 2002:a05:6000:480f:b0:45e:8a9c:608c with SMTP id
 ffacd0b85a97d-45ea3128da8mr40301454f8f.2.1779872078312; 
 Wed, 27 May 2026 01:54:38 -0700 (PDT)
Received: from [192.168.102.59] ([217.155.172.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5c27e7sm4613183f8f.35.2026.05.27.01.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 01:54:37 -0700 (PDT)
Message-ID: <b814cf42-f860-4cde-a5ca-6e3af71024ad@lowrisc.org>
Date: Wed, 27 May 2026 09:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v4 3/9] ot_uart: update register defs, switch to
 Fifo8 for tx/rx buffers
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-3@git.sr.ht>
 <CAKmqyKPvR7pkKz15_f_Nw7Nrf9e=+kVvJwdF61qtGK3pK-NCGg@mail.gmail.com>
Content-Language: en-US
From: Lex Bailey <lex.bailey@lowrisc.org>
Autocrypt: addr=lex.bailey@lowrisc.org; keydata=
 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
 WZXWKp/svUI=
In-Reply-To: <CAKmqyKPvR7pkKz15_f_Nw7Nrf9e=+kVvJwdF61qtGK3pK-NCGg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LRS1rCwRWXBxPQsU02CAJ0MK"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=lex.bailey@lowrisc.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LRS1rCwRWXBxPQsU02CAJ0MK
Content-Type: multipart/mixed; boundary="------------0WxEvlwEixeY10x0uSNoV31C";
 protected-headers="v1"
From: Lex Bailey <lex.bailey@lowrisc.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Message-ID: <b814cf42-f860-4cde-a5ca-6e3af71024ad@lowrisc.org>
Subject: Re: [PATCH qemu v4 3/9] ot_uart: update register defs, switch to
 Fifo8 for tx/rx buffers
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-3@git.sr.ht>
 <CAKmqyKPvR7pkKz15_f_Nw7Nrf9e=+kVvJwdF61qtGK3pK-NCGg@mail.gmail.com>
In-Reply-To: <CAKmqyKPvR7pkKz15_f_Nw7Nrf9e=+kVvJwdF61qtGK3pK-NCGg@mail.gmail.com>

--------------0WxEvlwEixeY10x0uSNoV31C
Content-Type: multipart/mixed; boundary="------------9hS2l4LDQSKLRdAhdNbSgPLq"

--------------9hS2l4LDQSKLRdAhdNbSgPLq
Content-Type: multipart/alternative;
 boundary="------------V0PmjR0s0uqpuJX0irl8u5iE"

--------------V0PmjR0s0uqpuJX0irl8u5iE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAyNi8wNS8yMDI2IDA0OjU4LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBPbiBG
cmksIE1heSAxLCAyMDI2IGF0IDI6MDXigK9BTSB+bGV4YmFpbGV5bG93cmlzYw0KPiA8bGV4
YmFpbGV5bG93cmlzY0BnaXQuc3IuaHQ+IHdyb3RlOg0KPj4gRnJvbTogTGV4IEJhaWxleTxs
ZXguYmFpbGV5QGxvd3Jpc2Mub3JnPg0KPj4NCj4+IFRoZSByZWdpc3RlciBkZWZpbml0aW9u
cyBmb3IgdGhlIFVBUlQgZGV2aWNlIG5lZWQgdG8gYmUgdXBkYXRlZCB0byBtYXRjaA0KPj4g
dGhlIGRvY3VtZW50YXRpb24gYXRodHRwczovL29wZW50aXRhbi5vcmcvYm9vay9ody9pcC91
YXJ0L2RvYy9yZWdpc3RlcnMuaHRtbA0KPj4NCj4+IFRoaXMgY29tbWl0IGRvZXMgdGhhdCwg
YW5kIGFsc28gc3dpdGNoZXMgdG8gdXNpbmcgRmlmbzggZm9yIG1hbmFnaW5nIHRoZQ0KPj4g
dHJhbnNtaXQgYW5kIHJlY2VpdmUgYnVmZmVycy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBM
ZXggQmFpbGV5PGxleC5iYWlsZXlAbG93cmlzYy5vcmc+DQo+PiAtLS0NCj4+ICAgaHcvY2hh
ci9vdF91YXJ0LmMgICAgICAgICB8IDMzOCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLQ0KPj4gICBpbmNsdWRlL2h3L2NoYXIvb3RfdWFydC5oIHwgIDE4ICstDQo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAxIGluc2VydGlvbnMoKyksIDE1NSBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvY2hhci9vdF91YXJ0LmMgYi9ody9jaGFyL290
X3VhcnQuYw0KPj4gaW5kZXggOTQ3OGFmNDBmOS4uM2ZlN2M1ZWZlNSAxMDA2NDQNCj4+IC0t
LSBhL2h3L2NoYXIvb3RfdWFydC5jDQo+PiArKysgYi9ody9jaGFyL290X3VhcnQuYw0KPj4g
QEAgLTI3LDYgKzI3LDcgQEANCj4+DQo+PiAgICNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+
PiAgICNpbmNsdWRlICJody9jaGFyL290X3VhcnQuaCINCj4+ICsjaW5jbHVkZSAicWVtdS9m
aWZvOC5oIg0KPj4gICAjaW5jbHVkZSAiaHcvY29yZS9pcnEuaCINCj4+ICAgI2luY2x1ZGUg
Imh3L2NvcmUvcWRldi1jbG9jay5oIg0KPj4gICAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXBy
b3BlcnRpZXMuaCINCj4+IEBAIC0zNywxNiArMzgsMjIgQEANCj4+ICAgI2luY2x1ZGUgInFl
bXUvbW9kdWxlLmgiDQo+Pg0KPj4gICBSRUczMihJTlRSX1NUQVRFLCAweDAwKQ0KPj4gLSAg
ICBGSUVMRChJTlRSX1NUQVRFLCBUWF9XQVRFUk1BUkssIDAsIDEpDQo+PiAtICAgIEZJRUxE
KElOVFJfU1RBVEUsIFJYX1dBVEVSTUFSSywgMSwgMSkNCj4+IC0gICAgRklFTEQoSU5UUl9T
VEFURSwgVFhfRU1QVFksIDIsIDEpDQo+PiAtICAgIEZJRUxEKElOVFJfU1RBVEUsIFJYX09W
RVJGTE9XLCAzLCAxKQ0KPj4gKyAgICBTSEFSRURfRklFTEQoSU5UUl9UWF9XQVRFUk1BUkss
IDAsIDEpDQo+PiArICAgIFNIQVJFRF9GSUVMRChJTlRSX1JYX1dBVEVSTUFSSywgMSwgMSkN
Cj4+ICsgICAgU0hBUkVEX0ZJRUxEKElOVFJfVFhfRE9ORSwgMiwgMSkNCj4+ICsgICAgU0hB
UkVEX0ZJRUxEKElOVFJfUlhfT1ZFUkZMT1csIDMsIDEpDQo+PiArICAgIFNIQVJFRF9GSUVM
RChJTlRSX1JYX0ZSQU1FX0VSUiwgNCwgMSkNCj4+ICsgICAgU0hBUkVEX0ZJRUxEKElOVFJf
UlhfQlJFQUtfRVJSLCA1LCAxKQ0KPj4gKyAgICBTSEFSRURfRklFTEQoSU5UUl9SWF9USU1F
T1VULCA2LCAxKQ0KPj4gKyAgICBTSEFSRURfRklFTEQoSU5UUl9SWF9QQVJJVFlfRVJSLCA3
LCAxKQ0KPj4gKyAgICBTSEFSRURfRklFTEQoSU5UUl9UWF9FTVBUWSwgOCwgMSkNCj4+ICAg
UkVHMzIoSU5UUl9FTkFCTEUsIDB4MDQpDQo+PiAgIFJFRzMyKElOVFJfVEVTVCwgMHgwOCkN
Cj4+ICAgUkVHMzIoQUxFUlRfVEVTVCwgMHgwQykNCj4+ICsgICAgRklFTEQoQUxFUlRfVEVT
VCwgRkFUQUxfRkFVTFQsIDAsIDEpDQo+PiAgIFJFRzMyKENUUkwsIDB4MTApDQo+PiAtICAg
IEZJRUxEKENUUkwsIFRYX0VOQUJMRSwgMCwgMSkNCj4+IC0gICAgRklFTEQoQ1RSTCwgUlhf
RU5BQkxFLCAxLCAxKQ0KPj4gKyAgICBGSUVMRChDVFJMLCBUWCwgMCwgMSkNCj4+ICsgICAg
RklFTEQoQ1RSTCwgUlgsIDEsIDEpDQo+PiAgICAgICBGSUVMRChDVFJMLCBORiwgMiwgMSkN
Cj4+ICAgICAgIEZJRUxEKENUUkwsIFNMUEJLLCA0LCAxKQ0KPj4gICAgICAgRklFTEQoQ1RS
TCwgTExQQkssIDUsIDEpDQo+PiBAQCAtNTgsNDMgKzY1LDc0IEBAIFJFRzMyKFNUQVRVUywg
MHgxNCkNCj4+ICAgICAgIEZJRUxEKFNUQVRVUywgVFhGVUxMLCAwLCAxKQ0KPj4gICAgICAg
RklFTEQoU1RBVFVTLCBSWEZVTEwsIDEsIDEpDQo+PiAgICAgICBGSUVMRChTVEFUVVMsIFRY
RU1QVFksIDIsIDEpDQo+PiArICAgIEZJRUxEKFNUQVRVUywgVFhJRExFLCAzLCAxKQ0KPj4g
ICAgICAgRklFTEQoU1RBVFVTLCBSWElETEUsIDQsIDEpDQo+PiAgICAgICBGSUVMRChTVEFU
VVMsIFJYRU1QVFksIDUsIDEpDQo+PiAgIFJFRzMyKFJEQVRBLCAweDE4KQ0KPj4gKyAgICBG
SUVMRChSREFUQSwgUkRBVEEsIDAsIDgpDQo+PiAgIFJFRzMyKFdEQVRBLCAweDFDKQ0KPj4g
KyAgICBGSUVMRChXREFUQSwgV0RBVEEsIDAsIDgpDQo+PiAgIFJFRzMyKEZJRk9fQ1RSTCwg
MHgyMCkNCj4+ICAgICAgIEZJRUxEKEZJRk9fQ1RSTCwgUlhSU1QsIDAsIDEpDQo+PiAgICAg
ICBGSUVMRChGSUZPX0NUUkwsIFRYUlNULCAxLCAxKQ0KPj4gICAgICAgRklFTEQoRklGT19D
VFJMLCBSWElMVkwsIDIsIDMpDQo+PiAtICAgIEZJRUxEKEZJRk9fQ1RSTCwgVFhJTFZMLCA1
LCAyKQ0KPj4gKyAgICBGSUVMRChGSUZPX0NUUkwsIFRYSUxWTCwgNSwgMykNCj4+ICAgUkVH
MzIoRklGT19TVEFUVVMsIDB4MjQpDQo+PiAtICAgIEZJRUxEKEZJRk9fU1RBVFVTLCBUWExW
TCwgMCwgNSkNCj4+IC0gICAgRklFTEQoRklGT19TVEFUVVMsIFJYTFZMLCAxNiwgNSkNCj4+
ICsgICAgRklFTEQoRklGT19TVEFUVVMsIFRYTFZMLCAwLCA4KQ0KPj4gKyAgICBGSUVMRChG
SUZPX1NUQVRVUywgUlhMVkwsIDE2LCA4KQ0KPj4gICBSRUczMihPVlJELCAweDI4KQ0KPj4g
KyAgICBGSUVMRChPVlJELCBUWEVOLCAwLCAxKQ0KPj4gKyAgICBGSUVMRChPVlJELCBUWFZB
TCwgMSwgMSkNCj4+ICAgUkVHMzIoVkFMLCAweDJDKQ0KPj4gKyAgICBGSUVMRChWQUwsIFJY
LCAwLCAxNikNCj4+ICAgUkVHMzIoVElNRU9VVF9DVFJMLCAweDMwKQ0KPj4gKyAgICBGSUVM
RChUSU1FT1VUX0NUUkwsIFZBTCwgMCwgMjQpDQo+PiArICAgIEZJRUxEKFRJTUVPVVRfQ1RS
TCwgRU4sIDMxLCAxKQ0KPj4gKw0KPj4gKyNkZWZpbmUgSU5UUl9NQVNLIFwNCj4+ICsgICAg
KElOVFJfVFhfV0FURVJNQVJLX01BU0sgfCBJTlRSX1JYX1dBVEVSTUFSS19NQVNLIHwgSU5U
Ul9UWF9ET05FX01BU0sgfCBcDQo+PiArICAgICBJTlRSX1JYX09WRVJGTE9XX01BU0sgfCBJ
TlRSX1JYX0ZSQU1FX0VSUl9NQVNLIHwgSU5UUl9SWF9CUkVBS19FUlJfTUFTSyB8IFwNCj4+
ICsgICAgIElOVFJfUlhfVElNRU9VVF9NQVNLIHwgSU5UUl9SWF9QQVJJVFlfRVJSX01BU0sg
fCBJTlRSX1RYX0VNUFRZX01BU0spDQo+PiArDQo+PiArI2RlZmluZSBDVFJMX01BU0sgXA0K
Pj4gKyAgICAoUl9DVFJMX1RYX01BU0sgfCBSX0NUUkxfUlhfTUFTSyB8IFJfQ1RSTF9ORl9N
QVNLIHwgUl9DVFJMX1NMUEJLX01BU0sgfCBcDQo+PiArICAgICBSX0NUUkxfTExQQktfTUFT
SyB8IFJfQ1RSTF9QQVJJVFlfRU5fTUFTSyB8IFJfQ1RSTF9QQVJJVFlfT0REX01BU0sgfCBc
DQo+PiArICAgICBSX0NUUkxfUlhCTFZMX01BU0sgfCBSX0NUUkxfTkNPX01BU0spDQo+PiAr
DQo+PiArI2RlZmluZSBPVF9VQVJUX05DT19CSVRTICAgICAxNg0KPj4gKyNkZWZpbmUgT1Rf
VUFSVF9UWF9GSUZPX1NJWkUgMTI4DQo+PiArI2RlZmluZSBPVF9VQVJUX1JYX0ZJRk9fU0la
RSAxMjgNCj4+ICsNCj4+ICsjZGVmaW5lIFIzMl9PRkYoX3JfKSAoKF9yXykgLyBzaXplb2Yo
dWludDMyX3QpKQ0KPj4gKw0KPj4gKyNkZWZpbmUgUl9MQVNUX1JFRyAoUl9USU1FT1VUX0NU
UkwpDQo+PiArI2RlZmluZSBSRUdTX0NPVU5UIChSX0xBU1RfUkVHICsgMXUpDQo+PiArI2Rl
ZmluZSBSRUdTX1NJWkUgIChSRUdTX0NPVU5UICogc2l6ZW9mKHVpbnQzMl90KSkNCj4+DQo+
PiAgIHN0YXRpYyB2b2lkIG90X3VhcnRfdXBkYXRlX2lycXMoT3RVQVJUU3RhdGUgKnMpDQo+
PiAgIHsNCj4+IC0gICAgaWYgKHMtPnVhcnRfaW50cl9zdGF0ZSAmIHMtPnVhcnRfaW50cl9l
bmFibGUgJiBSX0lOVFJfU1RBVEVfVFhfV0FURVJNQVJLX01BU0spIHsNCj4+ICsgICAgaWYg
KHMtPnJlZ3NbUl9JTlRSX1NUQVRFXSAmIHMtPnJlZ3NbUl9JTlRSX0VOQUJMRV0NCj4+ICsg
ICAgICAgICYgSU5UUl9UWF9XQVRFUk1BUktfTUFTSykgew0KPj4gICAgICAgICAgIHFlbXVf
c2V0X2lycShzLT50eF93YXRlcm1hcmssIDEpOw0KPj4gICAgICAgfSBlbHNlIHsNCj4+ICAg
ICAgICAgICBxZW11X3NldF9pcnEocy0+dHhfd2F0ZXJtYXJrLCAwKTsNCj4+ICAgICAgIH0N
Cj4+DQo+PiAtICAgIGlmIChzLT51YXJ0X2ludHJfc3RhdGUgJiBzLT51YXJ0X2ludHJfZW5h
YmxlICYgUl9JTlRSX1NUQVRFX1JYX1dBVEVSTUFSS19NQVNLKSB7DQo+PiArICAgIGlmIChz
LT5yZWdzW1JfSU5UUl9TVEFURV0gJiBzLT5yZWdzW1JfSU5UUl9FTkFCTEVdDQo+PiArICAg
ICAgICAmIElOVFJfUlhfV0FURVJNQVJLX01BU0spIHsNCj4+ICAgICAgICAgICBxZW11X3Nl
dF9pcnEocy0+cnhfd2F0ZXJtYXJrLCAxKTsNCj4+ICAgICAgIH0gZWxzZSB7DQo+PiAgICAg
ICAgICAgcWVtdV9zZXRfaXJxKHMtPnJ4X3dhdGVybWFyaywgMCk7DQo+PiAgICAgICB9DQo+
Pg0KPj4gLSAgICBpZiAocy0+dWFydF9pbnRyX3N0YXRlICYgcy0+dWFydF9pbnRyX2VuYWJs
ZSAmIFJfSU5UUl9TVEFURV9UWF9FTVBUWV9NQVNLKSB7DQo+PiArICAgIGlmIChzLT5yZWdz
W1JfSU5UUl9TVEFURV0gJiBzLT5yZWdzW1JfSU5UUl9FTkFCTEVdICYgSU5UUl9UWF9FTVBU
WV9NQVNLKSB7DQo+PiAgICAgICAgICAgcWVtdV9zZXRfaXJxKHMtPnR4X2VtcHR5LCAxKTsN
Cj4+ICAgICAgIH0gZWxzZSB7DQo+PiAgICAgICAgICAgcWVtdV9zZXRfaXJxKHMtPnR4X2Vt
cHR5LCAwKTsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIGlmIChzLT51YXJ0X2ludHJfc3Rh
dGUgJiBzLT51YXJ0X2ludHJfZW5hYmxlICYgUl9JTlRSX1NUQVRFX1JYX09WRVJGTE9XX01B
U0spIHsNCj4+ICsgICAgaWYgKHMtPnJlZ3NbUl9JTlRSX1NUQVRFXSAmIHMtPnJlZ3NbUl9J
TlRSX0VOQUJMRV0NCj4+ICsgICAgICAgICYgSU5UUl9SWF9PVkVSRkxPV19NQVNLKSB7DQo+
PiAgICAgICAgICAgcWVtdV9zZXRfaXJxKHMtPnJ4X292ZXJmbG93LCAxKTsNCj4+ICAgICAg
IH0gZWxzZSB7DQo+PiAgICAgICAgICAgcWVtdV9zZXRfaXJxKHMtPnJ4X292ZXJmbG93LCAw
KTsNCj4+IEBAIC0xMDUsMTIyICsxNDMsMTMzIEBAIHN0YXRpYyBpbnQgb3RfdWFydF9jYW5f
cmVjZWl2ZSh2b2lkICpvcGFxdWUpDQo+PiAgIHsNCj4+ICAgICAgIE90VUFSVFN0YXRlICpz
ID0gb3BhcXVlOw0KPj4NCj4+IC0gICAgaWYgKChzLT51YXJ0X2N0cmwgJiBSX0NUUkxfUlhf
RU5BQkxFX01BU0spDQo+PiAtICAgICAgICAgICAmJiAhKHMtPnVhcnRfc3RhdHVzICYgUl9T
VEFUVVNfUlhGVUxMX01BU0spKSB7DQo+PiAtICAgICAgICByZXR1cm4gMTsNCj4+ICsgICAg
aWYgKHMtPnJlZ3NbUl9DVFJMXSAmIFJfQ1RSTF9SWF9NQVNLKSB7DQo+PiArICAgICAgICBy
ZXR1cm4gKGludClmaWZvOF9udW1fZnJlZSgmcy0+cnhfZmlmbyk7DQo+PiAgICAgICB9DQo+
Pg0KPj4gICAgICAgcmV0dXJuIDA7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIHVpbnQzMl90
IG90X3VhcnRfZ2V0X3J4X3dhdGVybWFya19sZXZlbChjb25zdCBPdFVBUlRTdGF0ZSAqcykN
Cj4+ICt7DQo+PiArICAgIHVpbnQzMl90IHJ4X2lsdmwgPSBGSUVMRF9FWDMyKHMtPnJlZ3Nb
Ul9GSUZPX0NUUkxdLCBGSUZPX0NUUkwsIFJYSUxWTCk7DQo+PiArDQo+PiArICAgIHJldHVy
biByeF9pbHZsIDwgNyA/ICgxIDw8IHJ4X2lsdmwpIDogMTI2Ow0KPj4gK30NCj4+ICsNCj4+
ICAgc3RhdGljIHZvaWQgb3RfdWFydF9yZWNlaXZlKHZvaWQgKm9wYXF1ZSwgY29uc3QgdWlu
dDhfdCAqYnVmLCBpbnQgc2l6ZSkNCj4+ICAgew0KPj4gICAgICAgT3RVQVJUU3RhdGUgKnMg
PSBvcGFxdWU7DQo+PiAtICAgIHVpbnQ4X3QgcnhfZmlmb19sZXZlbCA9IChzLT51YXJ0X2Zp
Zm9fY3RybCAmIFJfRklGT19DVFJMX1JYSUxWTF9NQVNLKQ0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA+PiBSX0ZJRk9fQ1RSTF9SWElMVkxfU0hJRlQ7DQo+PiAtDQo+PiAt
ICAgIHMtPnVhcnRfcmRhdGEgPSAqYnVmOw0KPj4gKyAgICB1aW50MzJfdCByeF93YXRlcm1h
cmtfbGV2ZWw7DQo+PiArICAgIHNpemVfdCBjb3VudCA9IE1JTihmaWZvOF9udW1fZnJlZSgm
cy0+cnhfZmlmbyksIChzaXplX3Qpc2l6ZSk7DQo+Pg0KPj4gLSAgICBzLT51YXJ0X3N0YXR1
cyAmPSB+Ul9TVEFUVVNfUlhJRExFX01BU0s7DQo+PiAtICAgIHMtPnVhcnRfc3RhdHVzICY9
IH5SX1NUQVRVU19SWEVNUFRZX01BU0s7DQo+PiAtICAgIC8qIFRoZSBSWEZVTEwgaXMgc2V0
IGFmdGVyIHJlY2VpdmluZyBhIHNpbmdsZSBieXRlDQo+PiAtICAgICAqIGFzIHRoZSBGSUZP
IGJ1ZmZlcnMgYXJlIG5vdCB5ZXQgaW1wbGVtZW50ZWQuDQo+PiAtICAgICAqLw0KPj4gLSAg
ICBzLT51YXJ0X3N0YXR1cyB8PSBSX1NUQVRVU19SWEZVTExfTUFTSzsNCj4+IC0gICAgcy0+
cnhfbGV2ZWwgKz0gMTsNCj4+ICsgICAgZm9yIChpbnQgaW5kZXggPSAwOyBpbmRleCA8IHNp
emU7IGluZGV4KyspIHsNCj4+ICsgICAgICAgIGZpZm84X3B1c2goJnMtPnJ4X2ZpZm8sIGJ1
ZltpbmRleF0pOw0KPj4gKyAgICB9DQo+Pg0KPj4gLSAgICBpZiAoc2l6ZSA+IHJ4X2ZpZm9f
bGV2ZWwpIHsNCj4+IC0gICAgICAgIHMtPnVhcnRfaW50cl9zdGF0ZSB8PSBSX0lOVFJfU1RB
VEVfUlhfV0FURVJNQVJLX01BU0s7DQo+PiArICAgIC8qIHVwZGF0ZSBJTlRSX1NUQVRFICov
DQo+PiArICAgIGlmIChjb3VudCAhPSBzaXplKSB7DQo+PiArICAgICAgICBzLT5yZWdzW1Jf
SU5UUl9TVEFURV0gfD0gSU5UUl9SWF9PVkVSRkxPV19NQVNLOw0KPj4gKyAgICB9DQo+PiAr
ICAgIHJ4X3dhdGVybWFya19sZXZlbCA9IG90X3VhcnRfZ2V0X3J4X3dhdGVybWFya19sZXZl
bChzKTsNCj4+ICsgICAgaWYgKHJ4X3dhdGVybWFya19sZXZlbCAmJiBzaXplID49IHJ4X3dh
dGVybWFya19sZXZlbCkgew0KPj4gKyAgICAgICAgcy0+cmVnc1tSX0lOVFJfU1RBVEVdIHw9
IElOVFJfUlhfV0FURVJNQVJLX01BU0s7DQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgb3Rf
dWFydF91cGRhdGVfaXJxcyhzKTsNCj4+ICAgfQ0KPj4NCj4+IC1zdGF0aWMgZ2Jvb2xlYW4g
b3RfdWFydF94bWl0KHZvaWQgKmRvX25vdF91c2UsIEdJT0NvbmRpdGlvbiBjb25kLA0KPj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlKQ0KPj4gK3N0YXRp
YyB2b2lkIG90X3VhcnRfcmVzZXRfdHhfZmlmbyhPdFVBUlRTdGF0ZSAqcykNCj4+ICAgew0K
Pj4gLSAgICBPdFVBUlRTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4+IC0gICAgdWludDhfdCB0eF9m
aWZvX2xldmVsID0gKHMtPnVhcnRfZmlmb19jdHJsICYgUl9GSUZPX0NUUkxfVFhJTFZMX01B
U0spDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgID4+IFJfRklGT19DVFJMX1RY
SUxWTF9TSElGVDsNCj4+IC0gICAgaW50IHJldDsNCj4+IC0NCj4+IC0gICAgLyogaW5zdGFu
dCBkcmFpbiB0aGUgZmlmbyB3aGVuIHRoZXJlJ3Mgbm8gYmFjay1lbmQgKi8NCj4+IC0gICAg
aWYgKCFxZW11X2Nocl9mZV9iYWNrZW5kX2Nvbm5lY3RlZCgmcy0+Y2hyKSkgew0KPj4gLSAg
ICAgICAgcy0+dHhfbGV2ZWwgPSAwOw0KPj4gLSAgICAgICAgcmV0dXJuIEdfU09VUkNFX1JF
TU9WRTsNCj4+ICsgICAgZmlmbzhfcmVzZXQoJnMtPnR4X2ZpZm8pOw0KPj4gKyAgICBzLT5y
ZWdzW1JfSU5UUl9TVEFURV0gfD0gSU5UUl9UWF9FTVBUWV9NQVNLOw0KPj4gKyAgICBzLT5y
ZWdzW1JfSU5UUl9TVEFURV0gfD0gSU5UUl9UWF9ET05FX01BU0s7DQo+PiArICAgIGlmIChz
LT50eF93YXRlcm1hcmtfbGV2ZWwpIHsNCj4+ICsgICAgICAgIHMtPnJlZ3NbUl9JTlRSX1NU
QVRFXSB8PSBJTlRSX1RYX1dBVEVSTUFSS19NQVNLOw0KPj4gKyAgICAgICAgcy0+dHhfd2F0
ZXJtYXJrX2xldmVsID0gMDsNCj4+ICAgICAgIH0NCj4+ICt9DQo+Pg0KPj4gLSAgICBpZiAo
IXMtPnR4X2xldmVsKSB7DQo+PiAtICAgICAgICBzLT51YXJ0X3N0YXR1cyAmPSB+Ul9TVEFU
VVNfVFhGVUxMX01BU0s7DQo+PiAtICAgICAgICBzLT51YXJ0X3N0YXR1cyB8PSBSX1NUQVRV
U19UWEVNUFRZX01BU0s7DQo+PiAtICAgICAgICBzLT51YXJ0X2ludHJfc3RhdGUgfD0gUl9J
TlRSX1NUQVRFX1RYX0VNUFRZX01BU0s7DQo+PiAtICAgICAgICBzLT51YXJ0X2ludHJfc3Rh
dGUgJj0gflJfSU5UUl9TVEFURV9UWF9XQVRFUk1BUktfTUFTSzsNCj4+IC0gICAgICAgIG90
X3VhcnRfdXBkYXRlX2lycXMocyk7DQo+PiAtICAgICAgICByZXR1cm4gR19TT1VSQ0VfUkVN
T1ZFOw0KPj4gK3N0YXRpYyB2b2lkIG90X3VhcnRfcmVzZXRfcnhfZmlmbyhPdFVBUlRTdGF0
ZSAqcykNCj4+ICt7DQo+PiArICAgIGZpZm84X3Jlc2V0KCZzLT5yeF9maWZvKTsNCj4+ICsg
ICAgcy0+cmVnc1tSX0lOVFJfU1RBVEVdICY9IH5JTlRSX1JYX1dBVEVSTUFSS19NQVNLOw0K
Pj4gKyAgICBzLT5yZWdzW1JfSU5UUl9TVEFURV0gJj0gfklOVFJfUlhfT1ZFUkZMT1dfTUFT
SzsNCj4+ICsgICAgaWYgKEZJRUxEX0VYMzIocy0+cmVnc1tSX0NUUkxdLCBDVFJMLCBSWCkp
IHsNCj4+ICsgICAgICAgIHFlbXVfY2hyX2ZlX2FjY2VwdF9pbnB1dCgmcy0+Y2hyKTsNCj4+
ICAgICAgIH0NCj4+ICt9DQo+Pg0KPj4gLSAgICByZXQgPSBxZW11X2Nocl9mZV93cml0ZSgm
cy0+Y2hyLCBzLT50eF9maWZvLCBzLT50eF9sZXZlbCk7DQo+PiArc3RhdGljIHVpbnQzMl90
IG90X3VhcnRfZ2V0X3R4X3dhdGVybWFya19sZXZlbChjb25zdCBPdFVBUlRTdGF0ZSAqcykN
Cj4+ICt7DQo+PiArICAgIHVpbnQzMl90IHR4X2lsdmwgPSBGSUVMRF9FWDMyKHMtPnJlZ3Nb
Ul9GSUZPX0NUUkxdLCBGSUZPX0NUUkwsIFRYSUxWTCk7DQo+Pg0KPj4gLSAgICBpZiAocmV0
ID49IDApIHsNCj4+IC0gICAgICAgIHMtPnR4X2xldmVsIC09IHJldDsNCj4+IC0gICAgICAg
IG1lbW1vdmUocy0+dHhfZmlmbywgcy0+dHhfZmlmbyArIHJldCwgcy0+dHhfbGV2ZWwpOw0K
Pj4gLSAgICB9DQo+PiArICAgIHJldHVybiB0eF9pbHZsIDwgNyA/ICgxIDw8IHR4X2lsdmwp
IDogNjQ7DQo+PiArfQ0KPj4NCj4+IC0gICAgaWYgKHMtPnR4X2xldmVsKSB7DQo+PiAtICAg
ICAgICBndWludCByID0gcWVtdV9jaHJfZmVfYWRkX3dhdGNoKCZzLT5jaHIsIEdfSU9fT1VU
IHwgR19JT19IVVAsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG90X3VhcnRfeG1pdCwgcyk7DQo+PiAtICAgICAgICBpZiAoIXIpIHsNCj4+IC0gICAg
ICAgICAgICBzLT50eF9sZXZlbCA9IDA7DQo+PiAtICAgICAgICAgICAgcmV0dXJuIEdfU09V
UkNFX1JFTU9WRTsNCj4+IC0gICAgICAgIH0NCj4+ICtzdGF0aWMgdm9pZCBvdF91YXJ0X3ht
aXQoT3RVQVJUU3RhdGUgKnMpDQo+PiArew0KPj4gKyAgICBjb25zdCB1aW50OF90ICpidWY7
DQo+PiArICAgIHVpbnQzMl90IHNpemU7DQo+PiArICAgIGludCByZXQ7DQo+PiArDQo+PiAr
ICAgIGlmIChmaWZvOF9pc19lbXB0eSgmcy0+dHhfZmlmbykpIHsNCj4+ICsgICAgICAgIHJl
dHVybjsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIC8qIENsZWFyIHRoZSBUWCBGdWxsIGJp
dCAqLw0KPj4gLSAgICBpZiAocy0+dHhfbGV2ZWwgIT0gT1RfVUFSVF9UWF9GSUZPX1NJWkUp
IHsNCj4+IC0gICAgICAgIHMtPnVhcnRfc3RhdHVzICY9IH5SX1NUQVRVU19UWEZVTExfTUFT
SzsNCj4+ICsgICAgLyogaW5zdGFudCBkcmFpbiB0aGUgZmlmbyB3aGVuIHRoZXJlJ3Mgbm8g
YmFjay1lbmQgKi8NCj4+ICsgICAgaWYgKCFxZW11X2Nocl9mZV9iYWNrZW5kX2Nvbm5lY3Rl
ZCgmcy0+Y2hyKSkgew0KPj4gKyAgICAgICAgb3RfdWFydF9yZXNldF90eF9maWZvKHMpOw0K
Pj4gKyAgICAgICAgb3RfdWFydF91cGRhdGVfaXJxcyhzKTsNCj4+ICsgICAgICAgIHJldHVy
bjsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIC8qIERpc2FibGUgdGhlIFRYX1dBVEVSTUFS
SyBJUlEgKi8NCj4+IC0gICAgaWYgKHMtPnR4X2xldmVsIDwgdHhfZmlmb19sZXZlbCkgew0K
Pj4gLSAgICAgICAgcy0+dWFydF9pbnRyX3N0YXRlICY9IH5SX0lOVFJfU1RBVEVfVFhfV0FU
RVJNQVJLX01BU0s7DQo+PiArICAgIC8qIGdldCBhIGNvbnRpbnVvdXMgYnVmZmVyIGZyb20g
dGhlIEZJRk8gKi8NCj4+ICsgICAgYnVmID0NCj4+ICsgICAgICAgIGZpZm84X3BlZWtfYnVm
cHRyKCZzLT50eF9maWZvLCBmaWZvOF9udW1fdXNlZCgmcy0+dHhfZmlmbyksICZzaXplKTsN
Cj4+ICsgICAgLyogc2VuZCBhcyBtdWNoIGFzIHBvc3NpYmxlICovDQo+PiArICAgIHJldCA9
IHFlbXVfY2hyX2ZlX3dyaXRlKCZzLT5jaHIsIGJ1ZiwgKGludClzaXplKTsNCj4+ICsgICAg
LyogaWYgc29tZSBjaGFyYWN0ZXJzIHdoZXJlIHNlbnQsIHJlbW92ZSB0aGVtIGZyb20gdGhl
IEZJRk8gKi8NCj4+ICsgICAgaWYgKHJldCA+PSAwKSB7DQo+PiArICAgICAgICBmaWZvOF9k
cm9wKCZzLT50eF9maWZvLCByZXQpOw0KPj4gICAgICAgfQ0KPj4NCj4+IC0gICAgLyogU2V0
IFRYIGVtcHR5ICovDQo+PiAtICAgIGlmIChzLT50eF9sZXZlbCA9PSAwKSB7DQo+PiAtICAg
ICAgICBzLT51YXJ0X3N0YXR1cyB8PSBSX1NUQVRVU19UWEVNUFRZX01BU0s7DQo+PiAtICAg
ICAgICBzLT51YXJ0X2ludHJfc3RhdGUgfD0gUl9JTlRSX1NUQVRFX1RYX0VNUFRZX01BU0s7
DQo+PiArICAgIC8qIHVwZGF0ZSBJTlRSX1NUQVRFICovDQo+PiArICAgIGlmIChmaWZvOF9p
c19lbXB0eSgmcy0+dHhfZmlmbykpIHsNCj4+ICsgICAgICAgIHMtPnJlZ3NbUl9JTlRSX1NU
QVRFXSB8PSBJTlRSX1RYX0VNUFRZX01BU0s7DQo+PiArICAgICAgICBzLT5yZWdzW1JfSU5U
Ul9TVEFURV0gfD0gSU5UUl9UWF9ET05FX01BU0s7DQo+PiArICAgIH0NCj4+ICsgICAgaWYg
KHMtPnR4X3dhdGVybWFya19sZXZlbCAmJg0KPj4gKyAgICAgICAgZmlmbzhfbnVtX3VzZWQo
JnMtPnR4X2ZpZm8pIDwgcy0+dHhfd2F0ZXJtYXJrX2xldmVsKSB7DQo+PiArICAgICAgICBz
LT5yZWdzW1JfSU5UUl9TVEFURV0gfD0gSU5UUl9UWF9XQVRFUk1BUktfTUFTSzsNCj4+ICsg
ICAgICAgIHMtPnR4X3dhdGVybWFya19sZXZlbCA9IDA7DQo+PiAgICAgICB9DQo+Pg0KPj4g
ICAgICAgb3RfdWFydF91cGRhdGVfaXJxcyhzKTsNCj4+IC0gICAgcmV0dXJuIEdfU09VUkNF
X1JFTU9WRTsNCj4+ICAgfQ0KPj4NCj4+IC1zdGF0aWMgdm9pZCB1YXJ0X3dyaXRlX3R4X2Zp
Zm8oT3RVQVJUU3RhdGUgKnMsIGNvbnN0IHVpbnQ4X3QgKmJ1ZiwNCj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW50IHNpemUpDQo+PiArc3RhdGljIHZvaWQgdWFydF93
cml0ZV90eF9maWZvKE90VUFSVFN0YXRlICpzLCB1aW50OF90IHZhbCkNCj4+ICAgew0KPj4g
ICAgICAgdWludDY0X3QgY3VycmVudF90aW1lID0gcWVtdV9jbG9ja19nZXRfbnMoUUVNVV9D
TE9DS19WSVJUVUFMKTsNCj4+IC0gICAgdWludDhfdCB0eF9maWZvX2xldmVsID0gKHMtPnVh
cnRfZmlmb19jdHJsICYgUl9GSUZPX0NUUkxfVFhJTFZMX01BU0spDQo+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgID4+IFJfRklGT19DVFJMX1RYSUxWTF9TSElGVDsNCj4+IC0N
Cj4+IC0gICAgaWYgKHNpemUgPiBPVF9VQVJUX1RYX0ZJRk9fU0laRSAtIHMtPnR4X2xldmVs
KSB7DQo+PiAtICAgICAgICBzaXplID0gT1RfVUFSVF9UWF9GSUZPX1NJWkUgLSBzLT50eF9s
ZXZlbDsNCj4+ICsgICAgaWYgKGZpZm84X2lzX2Z1bGwoJnMtPnR4X2ZpZm8pKSB7DQo+PiAg
ICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsICJvdF91YXJ0OiBUWCBG
SUZPIG92ZXJmbG93Iik7DQo+PiArICAgICAgICByZXR1cm47DQo+PiAgICAgICB9DQo+Pg0K
Pj4gLSAgICBtZW1jcHkocy0+dHhfZmlmbyArIHMtPnR4X2xldmVsLCBidWYsIHNpemUpOw0K
Pj4gLSAgICBzLT50eF9sZXZlbCArPSBzaXplOw0KPj4gKyAgICBmaWZvOF9wdXNoKCZzLT50
eF9maWZvLCB2YWwpOw0KPj4NCj4+IC0gICAgaWYgKHMtPnR4X2xldmVsID4gMCkgew0KPj4g
LSAgICAgICAgcy0+dWFydF9zdGF0dXMgJj0gflJfU1RBVFVTX1RYRU1QVFlfTUFTSzsNCj4+
ICsgICAgcy0+dHhfd2F0ZXJtYXJrX2xldmVsID0gb3RfdWFydF9nZXRfdHhfd2F0ZXJtYXJr
X2xldmVsKHMpOw0KPj4gKyAgICBpZiAoZmlmbzhfbnVtX3VzZWQoJnMtPnR4X2ZpZm8pIDwg
cy0+dHhfd2F0ZXJtYXJrX2xldmVsKSB7DQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAg
ICogVFggd2F0ZXJtYXJrIGludGVycnVwdCBpcyByYWlzZWQgd2hlbiBGSUZPIGRlcHRoIGdv
ZXMgZnJvbSBhYm92ZQ0KPj4gKyAgICAgICAgICogd2F0ZXJtYXJrIHRvIGJlbG93LiBJZiB3
ZSBoYXZlbid0IHJlYWNoZWQgd2F0ZXJtYXJrLCByZXNldCBjYWNoZWQNCj4+ICsgICAgICAg
ICAqIHdhdGVybWFyayBsZXZlbA0KPj4gKyAgICAgICAgICovDQo+PiArICAgICAgICBzLT50
eF93YXRlcm1hcmtfbGV2ZWwgPSAwOw0KPj4gICAgICAgfQ0KPiBEb24ndCB3ZSBuZWVkIHRv
IHVwZGF0ZSB0aGUgaW50ZXJydXB0cyBhdCB0aGlzIHBvaW50Pw0KQ2FuIHlvdSBjbGFyaWZ5
IHdoYXQgeW91IG1lYW4gYnkgdGhpcz8gQXJlIHlvdSB3YW50aW5nIG1lIHRvIHNxdWFzaCB0
aGUgDQpuZXh0IGNvbW1pdCBpbiB0byB0aGlzIG9uZSBzbyB0aGF0IHRoZSBJUlEgY2hhbmdl
IGhhcHBlbnMgc2ltdWx0YW5lb3VzbHkgDQp3aXRoIHRoaXMgb25lPw0KPg0KPiBBbGlzdGFp
cg0KLS0gDQpMZXggQmFpbGV5ICh0aGV5L3RoZW0pDQpsb3dSSVNDIEMuSS5DLiA3IEhpbGxz
IFJvYWQsIENhbWJyaWRnZSwgQ0IyIDFHRSwgVUsuIFJlZ2lzdGVyZWQgaW4gDQpFbmdsYW5k
ICYgV2FsZXMgMDkyNzIyODMgbGV4LmJhaWxleUBsb3dyaXNjLm9yZw0K
--------------V0PmjR0s0uqpuJX0irl8u5iE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 26/05/2026 04:58, Alistair Francis
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAKmqyKPvR7pkKz15_f_Nw7Nrf9e=3D+kVvJwdF61qtGK3pK-NCGg@mail.gm=
ail.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">On Fri, May 1, 2026 at 2:05=E2=
=80=AFAM ~lexbaileylowrisc
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:lexbaileylowrisc@git.sr=
=2Eht">&lt;lexbaileylowrisc@git.sr.ht&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">
From: Lex Bailey <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:lex.ba=
iley@lowrisc.org">&lt;lex.bailey@lowrisc.org&gt;</a>

The register definitions for the UART device need to be updated to match
the documentation at <a class=3D"moz-txt-link-freetext" href=3D"https://o=
pentitan.org/book/hw/ip/uart/doc/registers.html">https://opentitan.org/bo=
ok/hw/ip/uart/doc/registers.html</a>

This commit does that, and also switches to using Fifo8 for managing the
transmit and receive buffers.

Signed-off-by: Lex Bailey <a class=3D"moz-txt-link-rfc2396E" href=3D"mail=
to:lex.bailey@lowrisc.org">&lt;lex.bailey@lowrisc.org&gt;</a>
---
 hw/char/ot_uart.c         | 338 ++++++++++++++++++++++----------------
 include/hw/char/ot_uart.h |  18 +-
 2 files changed, 201 insertions(+), 155 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 9478af40f9..3fe7c5efe5 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -27,6 +27,7 @@

 #include "qemu/osdep.h"
 #include "hw/char/ot_uart.h"
+#include "qemu/fifo8.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
@@ -37,16 +38,22 @@
 #include "qemu/module.h"

 REG32(INTR_STATE, 0x00)
-    FIELD(INTR_STATE, TX_WATERMARK, 0, 1)
-    FIELD(INTR_STATE, RX_WATERMARK, 1, 1)
-    FIELD(INTR_STATE, TX_EMPTY, 2, 1)
-    FIELD(INTR_STATE, RX_OVERFLOW, 3, 1)
+    SHARED_FIELD(INTR_TX_WATERMARK, 0, 1)
+    SHARED_FIELD(INTR_RX_WATERMARK, 1, 1)
+    SHARED_FIELD(INTR_TX_DONE, 2, 1)
+    SHARED_FIELD(INTR_RX_OVERFLOW, 3, 1)
+    SHARED_FIELD(INTR_RX_FRAME_ERR, 4, 1)
+    SHARED_FIELD(INTR_RX_BREAK_ERR, 5, 1)
+    SHARED_FIELD(INTR_RX_TIMEOUT, 6, 1)
+    SHARED_FIELD(INTR_RX_PARITY_ERR, 7, 1)
+    SHARED_FIELD(INTR_TX_EMPTY, 8, 1)
 REG32(INTR_ENABLE, 0x04)
 REG32(INTR_TEST, 0x08)
 REG32(ALERT_TEST, 0x0C)
+    FIELD(ALERT_TEST, FATAL_FAULT, 0, 1)
 REG32(CTRL, 0x10)
-    FIELD(CTRL, TX_ENABLE, 0, 1)
-    FIELD(CTRL, RX_ENABLE, 1, 1)
+    FIELD(CTRL, TX, 0, 1)
+    FIELD(CTRL, RX, 1, 1)
     FIELD(CTRL, NF, 2, 1)
     FIELD(CTRL, SLPBK, 4, 1)
     FIELD(CTRL, LLPBK, 5, 1)
@@ -58,43 +65,74 @@ REG32(STATUS, 0x14)
     FIELD(STATUS, TXFULL, 0, 1)
     FIELD(STATUS, RXFULL, 1, 1)
     FIELD(STATUS, TXEMPTY, 2, 1)
+    FIELD(STATUS, TXIDLE, 3, 1)
     FIELD(STATUS, RXIDLE, 4, 1)
     FIELD(STATUS, RXEMPTY, 5, 1)
 REG32(RDATA, 0x18)
+    FIELD(RDATA, RDATA, 0, 8)
 REG32(WDATA, 0x1C)
+    FIELD(WDATA, WDATA, 0, 8)
 REG32(FIFO_CTRL, 0x20)
     FIELD(FIFO_CTRL, RXRST, 0, 1)
     FIELD(FIFO_CTRL, TXRST, 1, 1)
     FIELD(FIFO_CTRL, RXILVL, 2, 3)
-    FIELD(FIFO_CTRL, TXILVL, 5, 2)
+    FIELD(FIFO_CTRL, TXILVL, 5, 3)
 REG32(FIFO_STATUS, 0x24)
-    FIELD(FIFO_STATUS, TXLVL, 0, 5)
-    FIELD(FIFO_STATUS, RXLVL, 16, 5)
+    FIELD(FIFO_STATUS, TXLVL, 0, 8)
+    FIELD(FIFO_STATUS, RXLVL, 16, 8)
 REG32(OVRD, 0x28)
+    FIELD(OVRD, TXEN, 0, 1)
+    FIELD(OVRD, TXVAL, 1, 1)
 REG32(VAL, 0x2C)
+    FIELD(VAL, RX, 0, 16)
 REG32(TIMEOUT_CTRL, 0x30)
+    FIELD(TIMEOUT_CTRL, VAL, 0, 24)
+    FIELD(TIMEOUT_CTRL, EN, 31, 1)
+
+#define INTR_MASK \
+    (INTR_TX_WATERMARK_MASK | INTR_RX_WATERMARK_MASK | INTR_TX_DONE_MASK=
 | \
+     INTR_RX_OVERFLOW_MASK | INTR_RX_FRAME_ERR_MASK | INTR_RX_BREAK_ERR_=
MASK | \
+     INTR_RX_TIMEOUT_MASK | INTR_RX_PARITY_ERR_MASK | INTR_TX_EMPTY_MASK=
)
+
+#define CTRL_MASK \
+    (R_CTRL_TX_MASK | R_CTRL_RX_MASK | R_CTRL_NF_MASK | R_CTRL_SLPBK_MAS=
K | \
+     R_CTRL_LLPBK_MASK | R_CTRL_PARITY_EN_MASK | R_CTRL_PARITY_ODD_MASK =
| \
+     R_CTRL_RXBLVL_MASK | R_CTRL_NCO_MASK)
+
+#define OT_UART_NCO_BITS     16
+#define OT_UART_TX_FIFO_SIZE 128
+#define OT_UART_RX_FIFO_SIZE 128
+
+#define R32_OFF(_r_) ((_r_) / sizeof(uint32_t))
+
+#define R_LAST_REG (R_TIMEOUT_CTRL)
+#define REGS_COUNT (R_LAST_REG + 1u)
+#define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))

 static void ot_uart_update_irqs(OtUARTState *s)
 {
-    if (s-&gt;uart_intr_state &amp; s-&gt;uart_intr_enable &amp; R_INTR_=
STATE_TX_WATERMARK_MASK) {
+    if (s-&gt;regs[R_INTR_STATE] &amp; s-&gt;regs[R_INTR_ENABLE]
+        &amp; INTR_TX_WATERMARK_MASK) {
         qemu_set_irq(s-&gt;tx_watermark, 1);
     } else {
         qemu_set_irq(s-&gt;tx_watermark, 0);
     }

-    if (s-&gt;uart_intr_state &amp; s-&gt;uart_intr_enable &amp; R_INTR_=
STATE_RX_WATERMARK_MASK) {
+    if (s-&gt;regs[R_INTR_STATE] &amp; s-&gt;regs[R_INTR_ENABLE]
+        &amp; INTR_RX_WATERMARK_MASK) {
         qemu_set_irq(s-&gt;rx_watermark, 1);
     } else {
         qemu_set_irq(s-&gt;rx_watermark, 0);
     }

-    if (s-&gt;uart_intr_state &amp; s-&gt;uart_intr_enable &amp; R_INTR_=
STATE_TX_EMPTY_MASK) {
+    if (s-&gt;regs[R_INTR_STATE] &amp; s-&gt;regs[R_INTR_ENABLE] &amp; I=
NTR_TX_EMPTY_MASK) {
         qemu_set_irq(s-&gt;tx_empty, 1);
     } else {
         qemu_set_irq(s-&gt;tx_empty, 0);
     }

-    if (s-&gt;uart_intr_state &amp; s-&gt;uart_intr_enable &amp; R_INTR_=
STATE_RX_OVERFLOW_MASK) {
+    if (s-&gt;regs[R_INTR_STATE] &amp; s-&gt;regs[R_INTR_ENABLE]
+        &amp; INTR_RX_OVERFLOW_MASK) {
         qemu_set_irq(s-&gt;rx_overflow, 1);
     } else {
         qemu_set_irq(s-&gt;rx_overflow, 0);
@@ -105,122 +143,133 @@ static int ot_uart_can_receive(void *opaque)
 {
     OtUARTState *s =3D opaque;

-    if ((s-&gt;uart_ctrl &amp; R_CTRL_RX_ENABLE_MASK)
-           &amp;&amp; !(s-&gt;uart_status &amp; R_STATUS_RXFULL_MASK)) {=

-        return 1;
+    if (s-&gt;regs[R_CTRL] &amp; R_CTRL_RX_MASK) {
+        return (int)fifo8_num_free(&amp;s-&gt;rx_fifo);
     }

     return 0;
 }

+static uint32_t ot_uart_get_rx_watermark_level(const OtUARTState *s)
+{
+    uint32_t rx_ilvl =3D FIELD_EX32(s-&gt;regs[R_FIFO_CTRL], FIFO_CTRL, =
RXILVL);
+
+    return rx_ilvl &lt; 7 ? (1 &lt;&lt; rx_ilvl) : 126;
+}
+
 static void ot_uart_receive(void *opaque, const uint8_t *buf, int size)
 {
     OtUARTState *s =3D opaque;
-    uint8_t rx_fifo_level =3D (s-&gt;uart_fifo_ctrl &amp; R_FIFO_CTRL_RX=
ILVL_MASK)
-                            &gt;&gt; R_FIFO_CTRL_RXILVL_SHIFT;
-
-    s-&gt;uart_rdata =3D *buf;
+    uint32_t rx_watermark_level;
+    size_t count =3D MIN(fifo8_num_free(&amp;s-&gt;rx_fifo), (size_t)siz=
e);

-    s-&gt;uart_status &amp;=3D ~R_STATUS_RXIDLE_MASK;
-    s-&gt;uart_status &amp;=3D ~R_STATUS_RXEMPTY_MASK;
-    /* The RXFULL is set after receiving a single byte
-     * as the FIFO buffers are not yet implemented.
-     */
-    s-&gt;uart_status |=3D R_STATUS_RXFULL_MASK;
-    s-&gt;rx_level +=3D 1;
+    for (int index =3D 0; index &lt; size; index++) {
+        fifo8_push(&amp;s-&gt;rx_fifo, buf[index]);
+    }

-    if (size &gt; rx_fifo_level) {
-        s-&gt;uart_intr_state |=3D R_INTR_STATE_RX_WATERMARK_MASK;
+    /* update INTR_STATE */
+    if (count !=3D size) {
+        s-&gt;regs[R_INTR_STATE] |=3D INTR_RX_OVERFLOW_MASK;
+    }
+    rx_watermark_level =3D ot_uart_get_rx_watermark_level(s);
+    if (rx_watermark_level &amp;&amp; size &gt;=3D rx_watermark_level) {=

+        s-&gt;regs[R_INTR_STATE] |=3D INTR_RX_WATERMARK_MASK;
     }

     ot_uart_update_irqs(s);
 }

-static gboolean ot_uart_xmit(void *do_not_use, GIOCondition cond,
-                             void *opaque)
+static void ot_uart_reset_tx_fifo(OtUARTState *s)
 {
-    OtUARTState *s =3D opaque;
-    uint8_t tx_fifo_level =3D (s-&gt;uart_fifo_ctrl &amp; R_FIFO_CTRL_TX=
ILVL_MASK)
-                            &gt;&gt; R_FIFO_CTRL_TXILVL_SHIFT;
-    int ret;
-
-    /* instant drain the fifo when there's no back-end */
-    if (!qemu_chr_fe_backend_connected(&amp;s-&gt;chr)) {
-        s-&gt;tx_level =3D 0;
-        return G_SOURCE_REMOVE;
+    fifo8_reset(&amp;s-&gt;tx_fifo);
+    s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
+    s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
+    if (s-&gt;tx_watermark_level) {
+        s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
+        s-&gt;tx_watermark_level =3D 0;
     }
+}

-    if (!s-&gt;tx_level) {
-        s-&gt;uart_status &amp;=3D ~R_STATUS_TXFULL_MASK;
-        s-&gt;uart_status |=3D R_STATUS_TXEMPTY_MASK;
-        s-&gt;uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
-        s-&gt;uart_intr_state &amp;=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
-        ot_uart_update_irqs(s);
-        return G_SOURCE_REMOVE;
+static void ot_uart_reset_rx_fifo(OtUARTState *s)
+{
+    fifo8_reset(&amp;s-&gt;rx_fifo);
+    s-&gt;regs[R_INTR_STATE] &amp;=3D ~INTR_RX_WATERMARK_MASK;
+    s-&gt;regs[R_INTR_STATE] &amp;=3D ~INTR_RX_OVERFLOW_MASK;
+    if (FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, RX)) {
+        qemu_chr_fe_accept_input(&amp;s-&gt;chr);
     }
+}

-    ret =3D qemu_chr_fe_write(&amp;s-&gt;chr, s-&gt;tx_fifo, s-&gt;tx_le=
vel);
+static uint32_t ot_uart_get_tx_watermark_level(const OtUARTState *s)
+{
+    uint32_t tx_ilvl =3D FIELD_EX32(s-&gt;regs[R_FIFO_CTRL], FIFO_CTRL, =
TXILVL);

-    if (ret &gt;=3D 0) {
-        s-&gt;tx_level -=3D ret;
-        memmove(s-&gt;tx_fifo, s-&gt;tx_fifo + ret, s-&gt;tx_level);
-    }
+    return tx_ilvl &lt; 7 ? (1 &lt;&lt; tx_ilvl) : 64;
+}

-    if (s-&gt;tx_level) {
-        guint r =3D qemu_chr_fe_add_watch(&amp;s-&gt;chr, G_IO_OUT | G_I=
O_HUP,
-                                        ot_uart_xmit, s);
-        if (!r) {
-            s-&gt;tx_level =3D 0;
-            return G_SOURCE_REMOVE;
-        }
+static void ot_uart_xmit(OtUARTState *s)
+{
+    const uint8_t *buf;
+    uint32_t size;
+    int ret;
+
+    if (fifo8_is_empty(&amp;s-&gt;tx_fifo)) {
+        return;
     }

-    /* Clear the TX Full bit */
-    if (s-&gt;tx_level !=3D OT_UART_TX_FIFO_SIZE) {
-        s-&gt;uart_status &amp;=3D ~R_STATUS_TXFULL_MASK;
+    /* instant drain the fifo when there's no back-end */
+    if (!qemu_chr_fe_backend_connected(&amp;s-&gt;chr)) {
+        ot_uart_reset_tx_fifo(s);
+        ot_uart_update_irqs(s);
+        return;
     }

-    /* Disable the TX_WATERMARK IRQ */
-    if (s-&gt;tx_level &lt; tx_fifo_level) {
-        s-&gt;uart_intr_state &amp;=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
+    /* get a continuous buffer from the FIFO */
+    buf =3D
+        fifo8_peek_bufptr(&amp;s-&gt;tx_fifo, fifo8_num_used(&amp;s-&gt;=
tx_fifo), &amp;size);
+    /* send as much as possible */
+    ret =3D qemu_chr_fe_write(&amp;s-&gt;chr, buf, (int)size);
+    /* if some characters where sent, remove them from the FIFO */
+    if (ret &gt;=3D 0) {
+        fifo8_drop(&amp;s-&gt;tx_fifo, ret);
     }

-    /* Set TX empty */
-    if (s-&gt;tx_level =3D=3D 0) {
-        s-&gt;uart_status |=3D R_STATUS_TXEMPTY_MASK;
-        s-&gt;uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
+    /* update INTR_STATE */
+    if (fifo8_is_empty(&amp;s-&gt;tx_fifo)) {
+        s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
+        s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
+    }
+    if (s-&gt;tx_watermark_level &amp;&amp;
+        fifo8_num_used(&amp;s-&gt;tx_fifo) &lt; s-&gt;tx_watermark_level=
) {
+        s-&gt;regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
+        s-&gt;tx_watermark_level =3D 0;
     }

     ot_uart_update_irqs(s);
-    return G_SOURCE_REMOVE;
 }

-static void uart_write_tx_fifo(OtUARTState *s, const uint8_t *buf,
-                               int size)
+static void uart_write_tx_fifo(OtUARTState *s, uint8_t val)
 {
     uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    uint8_t tx_fifo_level =3D (s-&gt;uart_fifo_ctrl &amp; R_FIFO_CTRL_TX=
ILVL_MASK)
-                            &gt;&gt; R_FIFO_CTRL_TXILVL_SHIFT;
-
-    if (size &gt; OT_UART_TX_FIFO_SIZE - s-&gt;tx_level) {
-        size =3D OT_UART_TX_FIFO_SIZE - s-&gt;tx_level;
+    if (fifo8_is_full(&amp;s-&gt;tx_fifo)) {
         qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
+        return;
     }

-    memcpy(s-&gt;tx_fifo + s-&gt;tx_level, buf, size);
-    s-&gt;tx_level +=3D size;
+    fifo8_push(&amp;s-&gt;tx_fifo, val);

-    if (s-&gt;tx_level &gt; 0) {
-        s-&gt;uart_status &amp;=3D ~R_STATUS_TXEMPTY_MASK;
+    s-&gt;tx_watermark_level =3D ot_uart_get_tx_watermark_level(s);
+    if (fifo8_num_used(&amp;s-&gt;tx_fifo) &lt; s-&gt;tx_watermark_level=
) {
+        /*
+         * TX watermark interrupt is raised when FIFO depth goes from ab=
ove
+         * watermark to below. If we haven't reached watermark, reset ca=
ched
+         * watermark level
+         */
+        s-&gt;tx_watermark_level =3D 0;
     }
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">
Don't we need to update the interrupts at this point?</pre>
    </blockquote>
    Can you clarify what you mean by this? Are you wanting me to squash
    the next commit in to this one so that the IRQ change happens
    simultaneously with this one?
    <blockquote type=3D"cite"
cite=3D"mid:CAKmqyKPvR7pkKz15_f_Nw7Nrf9e=3D+kVvJwdF61qtGK3pK-NCGg@mail.gm=
ail.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">

Alistair
</pre>
    </blockquote>
    <div class=3D"moz-signature">-- <br>
      Lex Bailey (they/them)<br>
      <span style=3D"font-size:0.5em;color:#777777;">lowRISC C.I.C. 7
        Hills Road, Cambridge, CB2 1GE, UK. Registered in England &amp;
        Wales 09272283
        <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lex.bailey@l=
owrisc.org">lex.bailey@lowrisc.org</a></span></div>
  </body>
</html>

--------------V0PmjR0s0uqpuJX0irl8u5iE--

--------------9hS2l4LDQSKLRdAhdNbSgPLq
Content-Type: application/pgp-keys; name="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Disposition: attachment; filename="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
WZXWKp/svUI=3D
=3DQ1uI
-----END PGP PUBLIC KEY BLOCK-----

--------------9hS2l4LDQSKLRdAhdNbSgPLq--

--------------0WxEvlwEixeY10x0uSNoV31C--

--------------LRS1rCwRWXBxPQsU02CAJ0MK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEq6gR1Rj7FCIRoDCVfLsg1AtVWCwFAmoWsUsFAwAAAAAACgkQfLsg1AtVWCyZ
4gv8CDFY0iMWnFl8+bZiG9pmpAApavmZj6Ix+ySDOGoDNdi1b40EE1sPUPNgX7fma02BuwS+ZYzy
2pIkKmVQKvG/IXAtSqfZm3RrHbwpIRxTtIMPFfH/P+FWdVPK3qkQoa9R6Q4mDkSxtqIhV2v1PTZA
dlU0G6UucCGjXh31em8K5D5QZXiaHz1s9JwiPJJVbSW2trukx0WHJuaCu1wz/rNmk7iHJtAEX7Mk
cNf2InC5+YLj4vts5QuI9AVGtR2/iZ/LVdp+6GzwA+Fy48RoYubWjEW4xGDF1hqeu2feGj4GS3JH
lYMgL1CLkr+/zKRGX/MO2LUNuyvRjUVJTOs2ibc/xty7jvKl32/kZH2eCRaWIK9cmFd2dw0Gp+R3
IRu2GDon/damIKtBpJ2RbRSgHixCmBlVSAYvDiD1UqUSrLhaDGdT1AfVGeTPRlgqemcIq7Rs4a6Z
/EqGB4MpwRMcqsz/V84vfmLAfZJCNKUv16hNru897pgx2j5K68lg14gQ6Wz3
=QgQF
-----END PGP SIGNATURE-----

--------------LRS1rCwRWXBxPQsU02CAJ0MK--

