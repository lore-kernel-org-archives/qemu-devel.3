Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861EAE6F08C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 20:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ydA-0000U8-Ab; Fri, 01 Nov 2024 16:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6yd8-0000TL-NA
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 16:52:26 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6yd6-0003wK-I3
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 16:52:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72061bfec2dso2094466b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730494342; x=1731099142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qcP0H1VuyjaIk0yAOUjRFMza1siH9KuulMw/B1LjizY=;
 b=JzEnvXpcVU4h0IO4CcHu/ShSJof4zs6oJ++5f3oN/XiuHH7IhKa1mnEjccnpkTKbhs
 ynpHwlGEkv5iVji+z+WKQjCS5NvY2k4urObnRSIbzSgrizlxKXRhpUQdMtck/jfJnlov
 s0wNcBYqhI+SIgIEZswWuXe2lKs8O3B0C3uqcHE2/kWm71Ya59sKlddOunGRy80DaN61
 e+nhyGtfr7wYaPWrixe0Nbf3bcN0x0NhVJtBuUmdySdKZI2OIwu4zrcMZYUJknm4+Za+
 f0QIEmkpZ3OPaOOliuGyAWOD8pv8kUeNWqapbMyoio992pDmsN2BWBNJ1AX9C319o9l2
 /ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730494342; x=1731099142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qcP0H1VuyjaIk0yAOUjRFMza1siH9KuulMw/B1LjizY=;
 b=T+DcSqs94oHYLKrCW1rionaWLYOWzaiQzJnsNdObafUFQkyiDJAMtKAbQfPRGLjtNa
 jdsYH1tIEcSUqY0nQCJRhvk31lJDK5QpKrMu0lHeIcK1IYzh5zV5/rsBIRVHVIeByTkh
 ERZY1KdYR8aR9avmvsvCf61xNji7X6gGItYq6aIBCHhY9q7FcUPm1MIlv1xFa0ZRvAMP
 UEav4BE8x6eCSwomwAHt7D9Zi/xbMcatgtFY4IuD4Akj0GstxySOdCyKU0P4kJMEz+/T
 m/uN3FNE8F27VHExTAACAGzLGkFIvyAtzUBgXZ1RH239gY4+QnyCqUxE8BzzH2nfWdQb
 2w9g==
X-Gm-Message-State: AOJu0YyJOzlYnXvGQRprw3FxBYI0FYwUTOldDpwI4ULjIfRf0LMZDr4i
 3i0kFrb7FUKPKGIVHXCsvppHuivK3hb9ijf85+gWewUoXyDWe/pvvqHvGK88LLVEArLXcoJXixt
 +tpo=
X-Google-Smtp-Source: AGHT+IGRKjeTP7SK4QgxJQQhcV/KULrAiy0TDvjYxgYHlo3oo8y07eyrAZnLUU2yy+d73o3YBhsNYA==
X-Received: by 2002:a05:6a00:9293:b0:71e:6b8:2f4a with SMTP id
 d2e1a72fcca58-720c98fbd29mr7482200b3a.12.1730494342503; 
 Fri, 01 Nov 2024 13:52:22 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1b8d2fsm3102233b3a.9.2024.11.01.13.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 13:52:22 -0700 (PDT)
Message-ID: <aba76f0a-efde-4a75-b174-f2eb19886931@linaro.org>
Date: Fri, 1 Nov 2024 13:52:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: fix build error with clang
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
 <2e1af830-a90a-447f-ab47-1c3d49463134@ventanamicro.com>
 <CAFEAcA92CuvGUJQk5LFE1X3a8dH21ksE_QXETjVPnU3v1bVSzw@mail.gmail.com>
 <fd9ee34a-24e1-43fb-950b-aba585473085@ventanamicro.com>
 <CAFEAcA_SYAC_UsEs+xy7aZEHsA1bC0umnsAF5ZmtjmZKEVSA+Q@mail.gmail.com>
 <CAH2o1u4ZAkH-bWN8SRkNj8-n9i3NtJpodopUpQyE=pwO5mKkDw@mail.gmail.com>
 <e23a19e8-3755-4fc3-8789-eca2af97104f@ventanamicro.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e23a19e8-3755-4fc3-8789-eca2af97104f@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

T24gMTEvMS8yNCAxMzo0NiwgRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgd3JvdGU6DQo+IA0K
PiANCj4gT24gMTEvMS8yNCA0OjIzIFBNLCBUb21hc3ogSmV6bmFjaCB3cm90ZToNCj4+IE9u
IEZyaSwgTm92IDEsIDIwMjQgYXQgMTE6NDnigK9BTSBQZXRlciBNYXlkZWxsIDxwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+DQo+Pj4gT24gRnJpLCAxIE5vdiAyMDI0
IGF0IDE4OjEzLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0KPj4+IDxkYmFyYm96YUB2ZW50
YW5hbWljcm8uY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gKENjaW5nIFRvbWFzeikNCj4+Pj4N
Cj4+Pj4gT24gMTEvMS8yNCAyOjQ4IFBNLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0KPj4+Pj4g
T24gRnJpLCAxIE5vdiAyMDI0IGF0IDE3OjM2LCBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0K
Pj4+Pj4gPGRiYXJib3phQHZlbnRhbmFtaWNyby5jb20+IHdyb3RlOg0KPj4+Pj4+DQo+Pj4+
Pj4NCj4+Pj4+Pg0KPj4+Pj4+IE9uIDExLzEvMjQgMjowOCBQTSwgUGllcnJpY2sgQm91dmll
ciB3cm90ZToNCj4+Pj4+Pj4gSW50cm9kdWNlZCBpbiAwYzU0YWMsICJody9yaXNjdjogYWRk
IFJJU0MtViBJT01NVSBiYXNlIGVtdWxhdGlvbiINCj4+Pj4+Pj4NCj4+Pj4+Pj4gLi4vaHcv
cmlzY3YvcmlzY3YtaW9tbXUuYzoxODc6MTc6IGVycm9yOiByZWRlZmluaXRpb24gb2YgJ19w
ZXh0X3U2NCcNCj4+Pj4+Pj4NCj4+Pj4+Pj4gICAgICAgMTg3IHwgc3RhdGljIHVpbnQ2NF90
IF9wZXh0X3U2NCh1aW50NjRfdCB2YWwsIHVpbnQ2NF90IGV4dCkNCj4+Pj4+Pj4NCj4+Pj4+
Pj4gICAgICAgICAgIHwgICAgICAgICAgICAgICAgIF4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gRDov
YS9fdGVtcC9tc3lzNjQvY2xhbmc2NC9saWIvY2xhbmcvMTgvaW5jbHVkZS9ibWkyaW50cmlu
Lmg6MjE3OjE6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gaXMgaGVyZQ0KPj4+Pj4+Pg0K
Pj4+Pj4+PiAgICAgICAyMTcgfCBfcGV4dF91NjQodW5zaWduZWQgbG9uZyBsb25nIF9fWCwg
dW5zaWduZWQgbG9uZyBsb25nIF9fWSkNCj4+Pj4+Pj4NCj4+Pj4+Pj4gICAgICAgICAgIHwg
Xg0KPj4+Pj4+Pg0KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4+Pj4+IC0tLQ0KPj4+Pj4+PiAgICAg
IGh3L3Jpc2N2L3Jpc2N2LWlvbW11LmMgfCA0ICsrLS0NCj4+Pj4+Pj4gICAgICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4+Pg0KPj4+
Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvcmlzY3YtaW9tbXUuYyBiL2h3L3Jpc2N2L3Jp
c2N2LWlvbW11LmMNCj4+Pj4+Pj4gaW5kZXggZmViNjUwNTQ5YWMuLmY3Mzg1NzBiYWMyIDEw
MDY0NA0KPj4+Pj4+PiAtLS0gYS9ody9yaXNjdi9yaXNjdi1pb21tdS5jDQo+Pj4+Pj4+ICsr
KyBiL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LmMNCj4+Pj4+Pj4gQEAgLTE4NCw3ICsxODQsNyBA
QCBzdGF0aWMgdm9pZCByaXNjdl9pb21tdV9wcmkoUklTQ1ZJT01NVVN0YXRlICpzLA0KPj4+
Pj4+PiAgICAgIH0NCj4+Pj4+Pj4NCj4+Pj4+Pj4gICAgICAvKiBQb3J0YWJsZSBpbXBsZW1l
bnRhdGlvbiBvZiBwZXh0X3U2NCwgYml0LW1hc2sgZXh0cmFjdGlvbi4gKi8NCj4+Pj4+Pj4g
LXN0YXRpYyB1aW50NjRfdCBfcGV4dF91NjQodWludDY0X3QgdmFsLCB1aW50NjRfdCBleHQp
DQo+Pj4+Pj4+ICtzdGF0aWMgdWludDY0X3QgcGV4dF91NjQodWludDY0X3QgdmFsLCB1aW50
NjRfdCBleHQpDQo+Pj4+Pj4NCj4+Pj4+PiBJIHN1Z2dlc3QgbmFtZSBpdCAncmlzY3ZfaW9t
bXVfcGV4dF91NjQnIHRvIGJlIGNsZWFyIHRoYXQgdGhpcyBpcyBhIGxvY2FsIHNjb3BlIGZ1
bmN0aW9uLA0KPj4+Pj4+IG5vdCB0byBiZSBtaXN0YWtlbiB3aXRoIGFueXRoaW5nIGF2YWls
YWJsZSBpbiBjbGFuZyBvciBhbnkgb3RoZXIgY29tcGlsZXIuDQo+Pj4+Pg0KPj4+Pj4gTW9y
ZSBnZW5lcmFsbHksIHdlIHNob3VsZCBhdm9pZCB1c2luZyBsZWFkaW5nICdfJyBpbiBRRU1V
IGZ1bmN0aW9uDQo+Pj4+PiBuYW1lczsgdGhvc2UgYXJlIHJlc2VydmVkIGZvciB0aGUgc3lz
dGVtLg0KPj4+Pj4NCj4+Pj4+IEFsc28sIHdoYXQgZG9lcyB0aGlzIGZ1bmN0aW9uIGRvPyBU
aGUgY29tbWVudCBhc3N1bWVzIHRoYXQNCj4+Pj4+IHRoZSByZWFkZXIga25vd3Mgd2hhdCBh
ICJwZXh0X3U2NCIgZnVuY3Rpb24gZG9lcywgYnV0IGlmIHlvdQ0KPj4+Pj4gZG9uJ3QgdGhl
biBpdCdzIGZhaXJseSBpbnNjcnV0YWJsZSBiaXQtdHdpZGRsaW5nLg0KPj4+Pj4gImJpdC1t
YXNrIGV4dHJhY3Rpb24iIHN1Z2dlc3RzIG1heWJlIHdlIHNob3VsZCBiZSB1c2luZw0KPj4+
Pj4gdGhlIGJpdG9wcy5oIGV4dHJhY3QgZnVuY3Rpb25zIGluc3RlYWQgPw0KPj4+Pg0KPj4+
PiBUaGlzIGlzIHRoZSBmdW5jdGlvbjoNCj4+Pj4NCj4+Pj4NCj4+Pj4gLyogUG9ydGFibGUg
aW1wbGVtZW50YXRpb24gb2YgcGV4dF91NjQsIGJpdC1tYXNrIGV4dHJhY3Rpb24uICovDQo+
Pj4+IHN0YXRpYyB1aW50NjRfdCBfcGV4dF91NjQodWludDY0X3QgdmFsLCB1aW50NjRfdCBl
eHQpDQo+Pj4+IHsNCj4+Pj4gICAgICAgIHVpbnQ2NF90IHJldCA9IDA7DQo+Pj4+ICAgICAg
ICB1aW50NjRfdCByb3QgPSAxOw0KPj4+Pg0KPj4+PiAgICAgICAgd2hpbGUgKGV4dCkgew0K
Pj4+PiAgICAgICAgICAgIGlmIChleHQgJiAxKSB7DQo+Pj4+ICAgICAgICAgICAgICAgIGlm
ICh2YWwgJiAxKSB7DQo+Pj4+ICAgICAgICAgICAgICAgICAgICByZXQgfD0gcm90Ow0KPj4+
PiAgICAgICAgICAgICAgICB9DQo+Pj4+ICAgICAgICAgICAgICAgIHJvdCA8PD0gMTsNCj4+
Pj4gICAgICAgICAgICB9DQo+Pj4+ICAgICAgICAgICAgdmFsID4+PSAxOw0KPj4+PiAgICAg
ICAgICAgIGV4dCA+Pj0gMTsNCj4+Pj4gICAgICAgIH0NCj4+Pj4NCj4+Pj4gICAgICAgIHJl
dHVybiByZXQ7DQo+Pj4+IH0NCj4+Pg0KPj4+IFllcywgYnV0IHdoYXQgZG9lcyBpdCBhY3R1
YWxseSAqZG8qID8gOi0pICBQcmVzdW1hYmx5DQo+Pj4gaXQgZXh0cmFjdHMgc29tZSBzdWJw
YXJ0IG9mICd2YWwnIGJhc2VkIG9uICdleHQnLCBidXQNCj4+PiB3aGF0IGlzIHRoZSBmb3Jt
YXQgaXQgZXhwZWN0cyAnZXh0JyB0byBiZSBpbiwgYW5kIHdoYXQNCj4+PiBraW5kcyBvZiBp
bnB1dCBhcmUgdmFsaWQ/DQo+Pj4NCj4+PiBGb3IgY29tcGFyaXNvbiwgb3VyIGV4dHJhY3Q2
NCBmdW5jdGlvbiBzYXlzOg0KPj4+DQo+Pj4gICAgKiBleHRyYWN0NjQ6DQo+Pj4gICAgKiBA
dmFsdWU6IHRoZSB2YWx1ZSB0byBleHRyYWN0IHRoZSBiaXQgZmllbGQgZnJvbQ0KPj4+ICAg
ICogQHN0YXJ0OiB0aGUgbG93ZXN0IGJpdCBpbiB0aGUgYml0IGZpZWxkIChudW1iZXJlZCBm
cm9tIDApDQo+Pj4gICAgKiBAbGVuZ3RoOiB0aGUgbGVuZ3RoIG9mIHRoZSBiaXQgZmllbGQN
Cj4+PiAgICAqDQo+Pj4gICAgKiBFeHRyYWN0IGZyb20gdGhlIDY0IGJpdCBpbnB1dCBAdmFs
dWUgdGhlIGJpdCBmaWVsZCBzcGVjaWZpZWQgYnkgdGhlDQo+Pj4gICAgKiBAc3RhcnQgYW5k
IEBsZW5ndGggcGFyYW1ldGVycywgYW5kIHJldHVybiBpdC4gVGhlIGJpdCBmaWVsZCBtdXN0
DQo+Pj4gICAgKiBsaWUgZW50aXJlbHkgd2l0aGluIHRoZSA2NCBiaXQgd29yZC4gSXQgaXMg
dmFsaWQgdG8gcmVxdWVzdCB0aGF0DQo+Pj4gICAgKiBhbGwgNjQgYml0cyBhcmUgcmV0dXJu
ZWQgKGllIEBsZW5ndGggNjQgYW5kIEBzdGFydCAwKS4NCj4+Pg0KPj4+IHNvIGV2ZW4gaWYg
eW91IGhhdmVuJ3QgY29tZSBhY3Jvc3MgaXQgYmVmb3JlIHlvdSBjYW4gc2VlDQo+Pj4gd2hh
dCB0aGUgZnVuY3Rpb24gaXMgaW50ZW5kZWQgdG8gZG8sIHdoYXQgaW5wdXRzIGFyZSB2YWxp
ZA0KPj4+IGFuZCB3aGF0IGFyZSBub3QsIGFuZCBzbyBvbiwgYW5kIHlvdSBkb24ndCBuZWVk
IHRvIHRyeSB0bw0KPj4+IHJldmVyc2UtZW5naW5lZXIgdGhvc2UgZnJvbSB0aGUgYml0IG9w
ZXJhdGlvbnMuDQo+Pj4NCj4+PiBJJ20gbm90IG5lY2Vzc2FyaWx5IG9wcG9zZWQgdG8gaGF2
aW5nIHNlcGFyYXRlIGltcGxlbWVudGF0aW9ucw0KPj4+IG9mIHRoZXNlIHRoaW5ncyBpZiBp
dCBtZWFucyB0aGUgY29kZSBmb2xsb3dzIHRoZSBhcmNoaXRlY3R1cmFsDQo+Pj4gc3BlY2lm
aWNhdGlvbnMgbW9yZSBjbG9zZWx5LCBidXQgaWYgd2UgZG8gaGF2ZSB0aGVtIGNhbg0KPj4+
IHdlIGhhdmUgZG9jdW1lbnRhdGlvbiBjb21tZW50cyB0aGF0IGRlc2NyaWJlIHRoZSBiZWhh
dmlvdXI/DQo+Pj4NCj4+DQo+PiBIZXksDQo+Pg0KPj4gVGhhbmsgeW91IGZvciB0aGUgZml4
LiBVc2luZyBhIGNvbW1vbiBuYW1lIGFuZCB1bmRlcnNjb3JlIHdhcyBub3QgYSBnb29kIGlk
ZWEgOykNCj4+IFRoZSBmdW5jdGlvbiBpcyBhbiBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgYml0
IGV4dHJhY3Rpb24gZnVuY3Rpb24gYXMNCj4+IGRvY3VtZW50ZWQgaW4gUklTQy1WIElPTU1V
IFNwZWMgWzFdLCBzZWN0aW9uICcyLjMuMy4gUHJvY2VzcyB0bw0KPj4gdHJhbnNsYXRlIGFk
ZHJlc3NlcyBvZiBNU0lzJy4NCj4+DQo+PiBJdCBpcyBhbHNvIGtub3duIGFzIFBFWFQgaW5z
dHJ1Y3Rpb24gaW4geDg2L0FWWDIgYXJjaGl0ZWN0dXJlLCBmb3INCj4+IG5vbi1jb250aWd1
b3VzIGJpdHMgZXh0cmFjdGlvbiwgdGhhdCdzIHdoeSBJJ3ZlIHVzZWQgdGhpcyBuYW1lLCBh
cyBpdA0KPj4gbWlnaHQgYmUgbW9yZSBmYW1pbGlhciB0byB0aGUgcmVhZGVycywgYW5kIHRv
IGF2b2lkIGNvbmZ1c2lvbiB3aXRoDQo+PiBleGlzdGluZyBleHRyYWN0NjQoKSBmdW5jdGlv
biBpbiBiaXRvcHMuaC4NCj4+DQo+Pg0KPj4gWzFdIGxpbms6IGh0dHBzOi8vZ2l0aHViLmNv
bS9yaXNjdi1ub24taXNhL3Jpc2N2LWlvbW11L3JlbGVhc2VzL3RhZy92MS4wLjANCj4gDQo+
IFRoYW5rcyBmb3IgY2xhcmlmeWluZyENCj4gDQo+IA0KPiBQaWVycmljaywgSSBjb3BpZWQg
dGhlIGRlc2NyaXB0aW9uIG9mIHRoaXMgZnVuY3Rpb24gZnJvbSB0aGUgcmlzY3YtaXNhIHNw
ZWMNCj4gYW5kIHB1dCBpbiBhIGNvbW1lbnQuIFRoaXMgaXMgaG93IGl0IHdvdWxkIGxvb2sg
bGlrZToNCj4gDQo+ICQgZ2l0IGRpZmYNCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3Jpc2N2
LWlvbW11LmMgYi9ody9yaXNjdi9yaXNjdi1pb21tdS5jDQo+IGluZGV4IGZlYjY1MDU0OWEu
Ljk2OWViNTZjNTMgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LmMNCj4g
KysrIGIvaHcvcmlzY3YvcmlzY3YtaW9tbXUuYw0KPiBAQCAtMTgzLDggKzE4MywyNSBAQCBz
dGF0aWMgdm9pZCByaXNjdl9pb21tdV9wcmkoUklTQ1ZJT01NVVN0YXRlICpzLA0KPiAgICAg
ICAgfQ0KPiAgICB9DQo+ICAgIA0KPiAtLyogUG9ydGFibGUgaW1wbGVtZW50YXRpb24gb2Yg
cGV4dF91NjQsIGJpdC1tYXNrIGV4dHJhY3Rpb24uICovDQo+IC1zdGF0aWMgdWludDY0X3Qg
X3BleHRfdTY0KHVpbnQ2NF90IHZhbCwgdWludDY0X3QgZXh0KQ0KPiArLyoNCj4gKyAqIERp
c2NhcmRzIGFsbCBiaXRzIGZyb20gJ3ZhbCcgd2hvc2UgbWF0Y2hpbmcgYml0cyBpbiB0aGUg
c2FtZQ0KPiArICogcG9zaXRpb25zIGluIHRoZSBtYXNrICdleHQnIGFyZSB6ZXJvcywgYW5k
IHBhY2tzIHRoZSByZW1haW5pbmcNCj4gKyAqIGJpdHMgZnJvbSAndmFsJyBjb250aWd1b3Vz
bHkgYXQgdGhlIGxlYXN0LXNpZ25pZmljYW50IGVuZCBvZiB0aGUNCj4gKyAqIHJlc3VsdCwg
a2VlcGluZyB0aGUgc2FtZSBiaXQgb3JkZXIgYXMgJ3ZhbCcgYW5kIGZpbGxpbmcgYW55DQo+
ICsgKiBvdGhlciBiaXRzIGF0IHRoZSBtb3N0LXNpZ25pZmljYW50IGVuZCBvZiB0aGUgcmVz
dWx0IHdpdGggemVyb3MuDQo+ICsgKg0KPiArICogRm9yIGV4YW1wbGUsIGZvciB0aGUgZm9s
bG93aW5nICd2YWwnIGFuZCAnZXh0JywgdGhlIHJldHVybiAncmV0Jw0KPiArICogd2lsbCBi
ZToNCj4gKyAqDQo+ICsgKiB2YWwgPSBhIGIgYyBkIGUgZiBnIGgNCj4gKyAqIGV4dCA9IDEg
MCAxIDAgMCAxIDEgMA0KPiArICogcmV0ID0gMCAwIDAgMCBhIGMgZiBnDQo+ICsgKg0KPiAr
ICogVGhpcyBmdW5jdGlvbiwgdGFrZW4gZnJvbSB0aGUgcmlzY3YtaW9tbXUgMS4wIHNwZWMs
IHNlY3Rpb24gMi4zLjMNCj4gKyAqICJQcm9jZXNzIHRvIHRyYW5zbGF0ZSBhZGRyZXNzZXMg
b2YgTVNJcyIsIGlzIHNpbWlsYXIgdG8gYml0IG1hbmlwDQo+ICsgKiBmdW5jdGlvbiBQRVhU
IChQYXJhbGxlbCBiaXRzIGV4dHJhY3QpIGZyb20geDg2Lg0KPiArICovDQo+ICtzdGF0aWMg
dWludDY0X3QgcmlzY3ZfaW9tbXVfcGV4dF91NjQodWludDY0X3QgdmFsLCB1aW50NjRfdCBl
eHQpDQo+IA0KPiANCj4gDQo+IEZlZWwgZnJlZSB0byB0YWtlIHRoaXMgZGlmZiBhbmQgc3F1
YXNoIGl0IGluIHlvdXIgdjIuIFRoaXMgd2F5IHdlJ2xsIGZpeCB0aGUgY2xhbmcNCj4gaXNz
dWUgYW5kIHB1dCBzb21lIGRvY3MgaW4gdGhlIGZ1bmN0aW9uLCBhIDIgZm9yIDEuDQo+IA0K
DQpTdXJlIQ0KDQpQZXRlciwgaXMgdGhpcyBjb21wcm9taXNlIHNhdGlzZnlpbmcgZm9yIHlv
dT8NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gRGFuaWVsDQo+IA0KPiANCj4+DQo+PiBIb3Bl
IHRoaXMgaGVscHMsDQo+PiAtIFRvbWFzeg0KPj4NCj4+PiB0aGFua3MNCj4+PiAtLSBQTU0N
Cg==

