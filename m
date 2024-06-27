Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D5CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 18:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMttr-0000qD-2M; Thu, 27 Jun 2024 14:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMttm-0000pu-2U
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:31:12 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMttj-0004lu-N3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:31:09 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-706680d3a25so4258717b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719513065; x=1720117865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ofZSilqbUyy+OIqI1oyQtcKbXn2k1YsSLYdrzc/ULWc=;
 b=OVozFBotjxIrZPS3b88qCK7f2VWERPQ6VbfVcd9Hbuthc1sNwF0Zd7RRqsYFquUazX
 w5MY2OPib5ONoGh/NPClkTBFcho7ergkPANOcarfU+Fowxtq6vnquNjcnX73W7yVKi2v
 YIju9fz0uU5XlUSgpjLHuwVLlPF/B/DYWQWltw/OyeXFFxg6bCeSiYsQDlUu39I748Cj
 UD/R3+i2H+PwGbPooHmRmw9LYSI84rfGaf689vuXWGjf6U8lwtcomR2Hdi5aUXmHG6fz
 VMpx94NcNbYPHNnGC2/L0uai6aUcjQYjVDBP1HWKExYzEB4fyirtnkMX/E+jgwPo90Bw
 3y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719513065; x=1720117865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ofZSilqbUyy+OIqI1oyQtcKbXn2k1YsSLYdrzc/ULWc=;
 b=EiyksJOG2oZPWjppl20W+uTytYbIG/5ejc0z3TlUiz9ZEKcttwSFIoEHys02Nh8kEY
 86sRTlTmMN2LTuGBPmnEe3cJmg1fSeHdWhYFlUM7KnvbFrrTgMbrkC5jB/xlaHih/ODo
 QIkLCfDRKPXgpKEaVFO8pecW7aDrK7ofwYsEHV/g6+5J24THIkXYTc2r0A+MMP+FSmij
 xjsSRvikFttEMubY34zmM3I/JYGlbUwn7Rn3f+mDyG5BADi2NNUgR7vADUH7izrF3+tb
 NHwiOCCJ0ltP54Lql7Tl7wvM8dQhUQVm8EUbMMDjdAMpNsHj/OoOTvmgSwgiibj8QW3l
 6iww==
X-Forwarded-Encrypted: i=1;
 AJvYcCV27PLQsK2rYlTiH7nq2GPEe4eYX3Eox6omLdF1t3AMe4Vq00070arBqywFmk3vmW5qs+Q3HbSwUcHS7biTCq+N6Ovrdr0=
X-Gm-Message-State: AOJu0YzjTld/I28+coMeQvArFCYJxuLvABMyKBlCyEY5u+vp4J7qsQMo
 Vvr0LkAFkUZlXwjt0lRGT+YPRi7cLKVw3HAtiALlEqbvhkN9J6gDZJQ0nBIVcKA=
X-Google-Smtp-Source: AGHT+IFsMl68KoRl/giqBvRqfdqIxC7o3jrIjAWBkZItbr31xGGSLF7+O7Cx4eIAKD79j4f1mbOHUA==
X-Received: by 2002:a05:6a00:b21:b0:704:32dc:c4e4 with SMTP id
 d2e1a72fcca58-70670e7a958mr13165160b3a.1.1719513064931; 
 Thu, 27 Jun 2024 11:31:04 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ed3a64sm27972b3a.119.2024.06.27.11.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 11:31:04 -0700 (PDT)
Message-ID: <5ea158f6-4ff1-4d48-b2bf-ee9d393b7a5c@linaro.org>
Date: Thu, 27 Jun 2024 11:31:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] tests/plugin/mem: add option to print memory
 accesses
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
 <20240626233757.375083-7-pierrick.bouvier@linaro.org>
 <OSZPR01MB6453C257EED6AFD784FFFCDB8DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <b34d0699-42cc-405c-a511-e58445bc362d@linaro.org>
 <OSZPR01MB645303F9F5E92FD3384D4E8A8DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <OSZPR01MB645303F9F5E92FD3384D4E8A8DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

T24gNi8yNi8yNCAyMzowNCwgWGluZ3RhbyBZYW8gKEZ1aml0c3UpIHdyb3RlOg0KPiANCj4g
DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4gU2VudDogVGh1cnNkYXks
IEp1bmUgMjcsIDIwMjQgMToyOSBQTQ0KPj4gVG86IFlhbywgWGluZ3Rhby/lp5og5bm45rab
IDx5YW94dC5mbnN0QGZ1aml0c3UuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+PiBD
YzogQWxleGFuZHJlIElvb3NzIDxlcmRuYXhlQGNyYW5zLm9yZz47IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpDQo+PiA8cGhpbG1kQGxpbmFyby5vcmc+OyBNYWhtb3VkIE1hbmRvdXIgPG1h
Lm1hbmRvdXJyQGdtYWlsLmNvbT47IFBhb2xvDQo+PiBCb256aW5pIDxwYm9uemluaUByZWRo
YXQuY29tPjsgRWR1YXJkbyBIYWJrb3N0IDxlZHVhcmRvQGhhYmtvc3QubmV0PjsNCj4+IFJp
Y2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgQWxleCBC
ZW5uw6llDQo+PiA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgNi83XSB0ZXN0cy9wbHVnaW4vbWVtOiBhZGQgb3B0aW9uIHRvIHByaW50IG1l
bW9yeQ0KPj4gYWNjZXNzZXMNCj4+DQo+PiBIaSBYaW5ndGFvLA0KPj4NCj4+IE9uIDYvMjYv
MjQgMjA6MTcsIFhpbmd0YW8gWWFvIChGdWppdHN1KSB3cm90ZToNCj4+PiBIaSwgUGllcnJp
Y2sNCj4+Pg0KPj4+PiArc3RhdGljIHZvaWQgcHJpbnRfYWNjZXNzKHVuc2lnbmVkIGludCBj
cHVfaW5kZXgsIHFlbXVfcGx1Z2luX21lbWluZm9fdA0KPj4+PiBtZW1pbmZvLA0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHZhZGRyLCB2b2lkICp1ZGF0YSkN
Cj4+Pj4gK3sNCj4+Pj4gKyAgICB1bnNpZ25lZCBzaXplID0gOCA8PCBxZW11X3BsdWdpbl9t
ZW1fc2l6ZV9zaGlmdChtZW1pbmZvKTsNCj4+Pj4gKyAgICBjb25zdCBjaGFyICp0eXBlID0g
cWVtdV9wbHVnaW5fbWVtX2lzX3N0b3JlKG1lbWluZm8pID8gInN0b3JlIiA6DQo+PiAibG9h
ZCI7DQo+Pj4+ICsgICAgdWludDY0X3QgdXBwZXIgPSBxZW11X3BsdWdpbl9tZW1fZ2V0X3Zh
bHVlX3VwcGVyX2JpdHMobWVtaW5mbyk7DQo+Pj4+ICsgICAgdWludDY0X3QgbG93ZXIgPSBx
ZW11X3BsdWdpbl9tZW1fZ2V0X3ZhbHVlX2xvd2VyX2JpdHMobWVtaW5mbyk7DQo+Pj4+ICsg
ICAgY29uc3QgY2hhciAqc3ltID0gdWRhdGEgPyB1ZGF0YSA6ICIiOw0KPj4+PiArICAgIGdf
YXV0b3B0cihHU3RyaW5nKSBvdXQgPSBnX3N0cmluZ19uZXcoIiIpOw0KPj4+PiArICAgIGdf
c3RyaW5nX3ByaW50ZihvdXQsICJhY2Nlc3M6IDB4JS4wIlBSSXg2NCIlIlBSSXg2NCIsJWQs
JXMsJXNcbiIsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgIHVwcGVyLCBsb3dlciwgc2l6
ZSwgdHlwZSwgc3ltKTsNCj4+Pj4gKyAgICBxZW11X3BsdWdpbl9vdXRzKG91dC0+c3RyKTsN
Cj4+Pj4gK30NCj4+PiBJIHRoaW5rIGl0IG1heSBiZSBoZWxwZnVsIHRvIG91dHB1dCB0aGUg
R1ZBIGFuZCBHUEEsIGNhbiB5b3UgYXBwZW5kIHRoZXNlDQo+PiBpbmZvcm1hdGlvbj8NCj4+
Pg0KPj4NCj4+IFlvdSBtZWFuIHZpcnR1YWwgYW5kIHBoeXNpY2FsIGFkZHJlc3Nlcz8NCj4g
WWVzLiBjdXJyZW50bHkgd2Ugb25seSBrbm93biB0aGUgbWVtb3J5IHZhbHVlLCBhcHBlbmRp
bmcgdGhlc2UgaW5mbyBtYXkgaGVscCB1cyB0byB0cmFjZSB0aGUNCj4gbWVtb3J5IGFjY2Vz
cy4NCj4gDQoNClNvdW5kcyBnb29kLCBJJ2xsIGFkZCB0aGlzIGluIHYzLg0KDQo+Pg0KPj4+
DQo+Pj4gVGhhbmtzDQo+Pj4gWGluZ3Rhbw0K

