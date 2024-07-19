Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABA3C3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc0b-0006Ce-R6; Thu, 18 Jul 2024 21:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sUc0Y-0006Bc-VC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:02:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sUc0U-0007Pr-NX
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:02:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc5296e214so12101075ad.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721350917; x=1721955717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MPwxpRb0meKPGrGK1lygWYn+f4tgI3WGv13ThiEreRw=;
 b=gWAayceDYVNWGARTE8aWqHiIPtdHQqOgTSOx/5H3rn5yLuzhg0Y95wmfpIvgiIxzfM
 sjtB7ocglnCYrIO4uSOVfx0HwYo3Yp4nGjKjxMx2M27kc2jUH9qSty+AkFjCqPFdTAfx
 Qnt7yYcfgYjJmSa86334G6NqZf9PrafuSwhzdY8eNWPbOKsI7f8wTIKWoyOBnnBTFRlC
 N6jnv8FSgb7fjik6pJ2HtvKr9HghqTgyTWR0g4qYjmnKHgcb9lvzTXnaai1XAgz0m47G
 q/hWrtwdRCPYxQqjGwv3pRJMbbMPeB/Po7iNnBGpmOF1Pva6fUb9EKjjsUJOmSelQcYl
 oS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721350917; x=1721955717;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MPwxpRb0meKPGrGK1lygWYn+f4tgI3WGv13ThiEreRw=;
 b=eabbC8ahvCawRSlLmq5C8Kwc8+bYg3mDBOy+tUC27Jgf/3fKoayES3w3XH3ZFc4EWa
 eUSyC2OknzYQis7dP5PiNgYYUfKsAKcT6qUvnj5d0f9dEyDw7xdf5rf43r9Fy349BBe0
 +kdooU66l0KZLVlanfChOfQkTjeM7+t/S4DWo8Dky8qyBsdzNd7D362EiZr3V3CBYMwv
 Mn5NqxYVBR4u1hYdBIeCr0wrGuZmbZjrV/u9PZIn9tUwpvmMZRgHzAaWfOR1wo2Vxu7N
 8ax/kTnaGHZ7S/aR6PSLPnVwlxQXpNuH99uVYzfrqJnoeAeUKw61V7Y/kTa+neH/ndYH
 5Wrg==
X-Gm-Message-State: AOJu0YwnYMb3oq3kSCq1y0BTrjWgUVDjk2pPPZvtbM82VMI0XO186vBz
 P4/ydQMZd8DHIWOc3xwoNwU6zJ1WCVp+KTQIQ64vkh82gtJsw97RnraQgrHI9kU=
X-Google-Smtp-Source: AGHT+IH+ZP4Qo1CBycOzHLGmAYC3lH528zQU5ZP1+GOAB0LA934CRcRdWySmgxPNN5EJLTNRq87ByQ==
X-Received: by 2002:a17:902:f651:b0:1fa:fbe1:284c with SMTP id
 d9443c01a7336-1fc4e130e08mr69067755ad.22.1721350917074; 
 Thu, 18 Jul 2024 18:01:57 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d25506sm2003365ad.213.2024.07.18.18.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 18:01:56 -0700 (PDT)
Message-ID: <f4042995-cf2e-473e-9d8b-78a263684fb7@linaro.org>
Date: Thu, 18 Jul 2024 18:01:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] tests/tcg/x86_64: add test for plugin memory access
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-8-pierrick.bouvier@linaro.org>
 <87zfqrsnjr.fsf@draig.linaro.org>
 <764d6e43-c18f-4683-ac03-eea8a9b2690b@linaro.org>
 <87ttgupss7.fsf@draig.linaro.org>
 <2c7e5d0a-7f75-4c3e-9127-695787622599@linaro.org>
Content-Language: en-US
In-Reply-To: <2c7e5d0a-7f75-4c3e-9127-695787622599@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gNy8xMi8yNCAxMDoxNCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gNy8xMi8y
NCAwNzo1MSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4gUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pg0KPj4+IE9uIDcvOC8yNCAx
MjoxNSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4+PiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4+Pj4NCj4+Pj4+IEFkZCBhbiBl
eHBsaWNpdCB0ZXN0IHRvIGNoZWNrIGV4cGVjdGVkIG1lbW9yeSB2YWx1ZXMgYXJlIHJlYWQv
d3JpdHRlbi4NCj4+Pj4+IEZvciBzaXplcyA4LCAxNiwgMzIsIDY0IGFuZCAxMjgsIHdlIGdl
bmVyYXRlIGEgbG9hZC9zdG9yZSBvcGVyYXRpb24uDQo+Pj4+PiBGb3Igc2l6ZSA4IC0+IDY0
LCB3ZSBnZW5lcmF0ZSBhbiBhdG9taWMgX19zeW5jX3ZhbF9jb21wYXJlX2FuZF9zd2FwIHRv
by4NCj4+Pj4+IEZvciAxMjhiaXRzIG1lbW9yeSBhY2Nlc3MsIHdlIHJlbHkgb24gU1NFMiBp
bnN0cnVjdGlvbnMuDQo+Pj4+Pg0KPj4+Pj4gQnkgZGVmYXVsdCwgYXRvbWljIGFjY2Vzc2Vz
IGFyZSBub24gYXRvbWljIGlmIGEgc2luZ2xlIGNwdSBpcyBydW5uaW5nLA0KPj4+Pj4gc28g
d2UgZm9yY2UgY3JlYXRpb24gb2YgYSBzZWNvbmQgb25lIGJ5IGNyZWF0aW5nIGEgbmV3IHRo
cmVhZCBmaXJzdC4NCj4+Pj4+DQo+Pj4+PiBsb2FkL3N0b3JlIGhlbHBlcnMgY29kZSBwYXRo
IGNhbid0IGJlIHRyaWdnZXJlZCBlYXNpbHkgaW4gdXNlciBtb2RlIChubw0KPj4+Pj4gc29m
dG1tdSksIHNvIHdlIGNhbid0IHRlc3QgaXQgaGVyZS4NCj4+Pj4+DQo+Pj4+PiBDYW4gYmUg
cnVuIHdpdGg6DQo+Pj4+PiBtYWtlIC1DIGJ1aWxkL3Rlc3RzL3RjZy94ODZfNjQtbGludXgt
dXNlciBydW4tcGx1Z2luLXRlc3QtcGx1Z2luLW1lbS1hY2Nlc3Mtd2l0aC1saWJtZW0uc28N
Cj4+Pj4+DQo+Pj4+PiBUZXN0ZWQtYnk6IFhpbmd0YW8gWWFvIDx5YW94dC5mbnN0QGZ1aml0
c3UuY29tPg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgICAgdGVzdHMvdGNn
L3g4Nl82NC90ZXN0LXBsdWdpbi1tZW0tYWNjZXNzLmMgICB8IDg5ICsrKysrKysrKysrKysr
KysrKysrKw0KPj4+Pj4gICAgIHRlc3RzL3RjZy94ODZfNjQvTWFrZWZpbGUudGFyZ2V0ICAg
ICAgICAgICAgfCAgNyArKw0KPj4+Pj4gICAgIHRlc3RzL3RjZy94ODZfNjQvY2hlY2stcGx1
Z2luLW1lbS1hY2Nlc3Muc2ggfCA0OCArKysrKysrKysrKw0KPj4+Pj4gICAgIDMgZmlsZXMg
Y2hhbmdlZCwgMTQ0IGluc2VydGlvbnMoKykNCj4+Pj4+ICAgICBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvdGNnL3g4Nl82NC90ZXN0LXBsdWdpbi1tZW0tYWNjZXNzLmMNCj4+Pj4+ICAg
ICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvdGNnL3g4Nl82NC9jaGVjay1wbHVnaW4tbWVt
LWFjY2Vzcy5zaA0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cveDg2XzY0
L3Rlc3QtcGx1Z2luLW1lbS1hY2Nlc3MuYyBiL3Rlc3RzL3RjZy94ODZfNjQvdGVzdC1wbHVn
aW4tbWVtLWFjY2Vzcy5jDQo+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+Pj4gaW5k
ZXggMDAwMDAwMDAwMDAuLjdmZGQ2YTU1ODI5DQo+Pj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+
PiArKysgYi90ZXN0cy90Y2cveDg2XzY0L3Rlc3QtcGx1Z2luLW1lbS1hY2Nlc3MuYw0KPj4+
Pj4gQEAgLTAsMCArMSw4OSBAQA0KPj4+Pj4gKyNpbmNsdWRlIDxlbW1pbnRyaW4uaD4NCj4+
Pj4+ICsjaW5jbHVkZSA8cHRocmVhZC5oPg0KPj4+Pj4gKyNpbmNsdWRlIDxzdGRpbnQuaD4N
Cj4+Pj4+ICsjaW5jbHVkZSA8c3RkbGliLmg+DQo+Pj4+PiArDQo+Pj4+PiArc3RhdGljIHZv
aWQgKmRhdGE7DQo+Pj4+PiArDQo+Pj4+PiArI2RlZmluZSBERUZJTkVfU1RPUkUobmFtZSwg
dHlwZSwgdmFsdWUpIFwNCj4+Pj4+ICtzdGF0aWMgdm9pZCBzdG9yZV8jI25hbWUodm9pZCkg
ICAgICAgICAgXA0KPj4+Pj4gK3sgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcDQo+Pj4+PiArICAgICooKHR5cGUgKilkYXRhKSA9IHZhbHVlOyAgICAgICAgICAg
IFwNCj4+Pj4+ICt9DQo+Pj4+PiArDQo+Pj4+PiArI2RlZmluZSBERUZJTkVfQVRPTUlDX09Q
KG5hbWUsIHR5cGUsIHZhbHVlKSAgICAgICAgICAgICAgICAgXA0KPj4+Pj4gK3N0YXRpYyB2
b2lkIGF0b21pY19vcF8jI25hbWUodm9pZCkgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
Cj4+Pj4+ICt7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcDQo+Pj4+PiArICAgICooKHR5cGUgKilkYXRhKSA9IDB4NDI7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4+Pj4gKyAgICBfX3N5bmNfdmFs
X2NvbXBhcmVfYW5kX3N3YXAoKHR5cGUgKilkYXRhLCAweDQyLCB2YWx1ZSk7IFwNCj4+Pj4g
U2hvdWxkIHdlIGV4ZXJjaXNlIHRoZSBvdGhlciBjb21wYXJlIGFuZCBzd2FwIG9wcz8gRG8g
dGhleSBhbGwgY29tZQ0KPj4+PiB0aHJvdWdoIHRoZSBzYW1lIHJ3bSBwYXRoPw0KPj4+Pg0K
Pj4+DQo+Pj4gVGhlcmUgYXJlIGRlZmluaXRlbHkgc2V2ZXJhbCBwYXRocyBkZXBlbmRpbmcg
b24gdGhlIGdlbmVyYXRlZCBhdG9taWMgb3AuDQo+Pj4gSG93ZXZlciwgdGhlIGNvZGUgaXMg
cHJldHR5IHN0cmFpZ2h0Zm9yd2FyZCAoYW5kIGltcGxlbWVudGVkIGluIGENCj4+PiBzaW5n
bGUgZnVuY3Rpb24pLCBzbyBteSB0aG91Z2h0IHdhcyB0aGF0IG9uZSB3YXkgdG8gdHJpZ2dl
ciB0aGlzIHdhcw0KPj4+IGVub3VnaC4NCj4+DQo+PiBJZiB0aGV5IGFsbCBjb21lIHRocm91
Z2ggdGhlIHNhbWUgcGF0aCBJIGd1ZXNzIHRoYXQncyBPSy4NCj4+DQo+Pj4+PiArfQ0KPj4+
Pj4gKw0KPj4+Pj4gKyNkZWZpbmUgREVGSU5FX0xPQUQobmFtZSwgdHlwZSkgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KPj4+Pj4gK3N0YXRpYyB2b2lkIGxvYWRfIyNuYW1lKHZvaWQp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4+Pj4gK3sgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4+Pj4gKyAgICBy
ZWdpc3RlciB0eXBlIHZhciBhc20oImVheCIpID0gKigodHlwZSAqKSBkYXRhKTsgICAgXA0K
Pj4+Pj4gKyAgICAodm9pZCl2YXI7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KPj4+PiBUaGlzIGlzIGEgYml0IHdlaXJkLiBJdCdzIHRoZSBvbmx5IGlu
bGluZSBhc20gbmVlZGVkIHRoYXQgbWFrZXMgdGhpcw0KPj4+PiBhDQo+Pj4+IG5vbi1tdWx0
aWFyY2ggdGVzdC4gV2h5Pw0KPj4+Pg0KPj4+DQo+Pj4gSSdsbCBhbnN3ZXIgaGVyZSBhYm91
dCB3aHkgdGhpcyB0ZXN0IGlzIGFyY2ggc3BlY2lmaWMsIGFuZCBub3QgYSBtdWx0aSBhcmNo
Lg0KPj4+DQo+Pj4gVGhlIHByb2JsZW0gSSBtZXQgaXMgdGhhdCBhbGwgdGFyZ2V0IGFyY2hp
dGVjdHVyZSBkbyBub3QgaGF2ZSBuYXRpdmUNCj4+PiA2NC8xMjggYml0cyB0eXBlcywgYW5k
IGRlcGVuZGluZyBob3cgY29kZSBpcyBjb21waWxlZCB3aXRoIGdjYywgeW91DQo+Pj4gbWF5
IG9yIG5vdCBnZW5lcmF0ZWQgZXhwZWN0ZWQgdmVjdG9yIGluc3RydWN0aW9ucyBmb3IgMTI4
Yml0cw0KPj4+IG9wZXJhdGlvbi4gU2FtZSBmb3IgYXRvbWljIG9wZXJhdGlvbnMuDQo+Pg0K
Pj4gU28gd2UgZG8gaGFuZGxlIHRoaXMgd2l0aCB0aGUgc2hhNTEyIHRlc3QsIGJ1aWxkaW5n
IHZhcmlhbnRzIG9mIGl0IHdpdGgNCj4+IHZhcmlvdXMgY29tcGlsZXIgZmxhZ3MgdG8gdHJp
Z2dlciB0aGUgdXNlIG9mIHZlY3RvcnMuIFNvIHRoZSBjb2RlIGlzDQo+PiBtdWx0aWFyY2gg
YnV0IHdlIGhhdmUgYXJjaCBzcGVjaWZpYyB2YXJpYW50cyBhcyBkaWN0YXRlZCBieSB0aGUN
Cj4+IE1ha2VmaWxlcywgaS5lLjoNCj4+DQo+PiAgICAgc2hhNTEyLXN2ZTogQ0ZMQUdTPS1P
MyAtbWFyY2g9YXJtdjguMS1hK3N2ZQ0KPj4gICAgIHNoYTUxMi1zdmU6IHNoYTUxMi5jDQo+
PiAgICAgICAgICAgICAkKENDKSAkKENGTEFHUykgJChFWFRSQV9DRkxBR1MpICQ8IC1vICRA
ICQoTERGTEFHUykNCj4+DQo+PiAgICAgVEVTVFMgKz0gc2hhNTEyLXN2ZQ0KPj4NCj4gDQo+
IEkgc3VzcGVjdCB0aGlzIGlzIGdvbm5hIG5lZWQgc2V2ZXJhbCBpdGVyYXRpb25zIHRvIHRy
eSBhbGwgYXJjaCwgYW5kIHNlZQ0KPiB3aGljaCBvbmVzIGhhdmUgbmF0aXZlIDY0LzEyOCBi
aXRzIGFuZCB3aGljaCBvbmVzIGhhdmUgYXRvbWljDQo+IGluc3RydWN0aW9ucy4gSXMgdGhh
dCByZWFsbHkgd2hlcmUgd2Ugd2FudCB0byBzcGVuZCBvdXIgKHByZWNpb3VzKSB0aW1lPw0K
PiBJJ20gbm90IGNvbnZpbmNlZCBvZiB0aGUgdmFsdWUgb2YgdGhhdC4gV2UgdHJ5IHRvIHRl
c3QgcGx1Z2lucw0KPiBpbXBsZW1lbnRhdGlvbiwgbm90IGhvdyBRRU1VIGhhbmRsZXMgbWVt
b3J5IGFjY2Vzc2VzIGluIGdlbmVyYWwuDQo+IA0KPiBUaGUgc3BlY2lmaWNpdHkgb2YgdGhp
cyB0ZXN0LCBpcyB3aGF0IHdlIGRvbid0IHRlc3QgdGhlIGNvcnJlY3Qgb3V0cHV0DQo+IG9m
IGEgcHJvZ3JhbSwgYnV0IHdlIG9ic2VydmUgYW4gZXhwZWN0ZWQgYmVoYXZpb3IsIHZpYSB0
aGUgcGx1Z2lucw0KPiB0cmFjZS4gU28gaXQncyBhIGJpdCBkaWZmZXJlbnQgZnJvbSBzaGE1
MTIgZXhhbXBsZS4NCj4gDQo+Pj4gVGh1cywgSSBjaG9zZSB0byBzcGVjaWFsaXplIHRoaXMg
dGVzdCBmb3IgeDg2XzY0LCBhbmQgdXNlIHNzZTINCj4+PiBkaXJlY3RseSBmb3IgMTI4IGJp
dHMgaW50ZWdlcnMuDQo+Pj4NCj4+PiBZb3UgbWlnaHQgc2F5ICJIb3cgYWJvdXQgYWRkaW5n
IGlmZGVmIGZvciB0aGlzIi4gWWVzIHN1cmUsIGJ1dCB0aGUNCj4+PiBjaGVjayBzY3JpcHQg
d291bGQgYmVjb21lIGNvbXBsaWNhdGVkIHRvbywgYW5kIEkganVzdCB3YW50ZWQgdG8ga2Vl
cA0KPj4+IGl0IHNpbXBsZS4NCj4+DQo+PiBXZSBjYW4ga2VlcCB0aGUgY2hlY2stc2NyaXB0
IHBlciBhcmNoIGlmIHdlIGhhdmUgdG8uDQo+Pg0KPiANCj4gSSB3b3VsZCBhZGQgYSB0YXJn
ZXQgYXJjaCBwYXJhbSwgYnV0IG5vdCBkdXBsaWNhdGUgdGhpcyB0byBiZSBob25lc3QuDQo+
IFdpbGwgYmUgYSBwYWluIHRvIHVwZGF0ZSBpZiBuZWVkZWQuDQo+IE15IGdvYWwgd2FzIHRv
IHJlcGxhY2UgdGhpcyB3aXRoIExMVk0gZmlsZWNoZWNrIGluIGEgZm9sbG93aW5nIHNlcmll
cy4NCj4gDQo+Pj4gT3VyIGludGVyZXN0IGhlcmUgaXMgbm90IHRvIGNoZWNrIHRoYXQgbWVt
b3J5IGFjY2Vzc2VzIGFyZQ0KPj4+IGNvcnJlY3RseSBpbXBsZW1lbnRlZCBpbiBRRU1VLCBi
dXQgdG8gY2hlY2sgdGhhdCBhIHNwZWNpZmljIGJlaGF2aW9yDQo+Pj4gb24gb25lIGFyY2gg
aXMgdGhlIG9uZSBleHBlY3RlZC4NCj4+DQo+PiBTbyB0aGUgcHJvYmxlbSB3aXRoIG5vdCBi
ZWluZyBtdWx0aWFyY2ggaXMgd2UgZG9uJ3QgYnVpbGQgYWxsIHRhcmdldHMgaW4NCj4+IGFs
bCBjb21iaW5hdGlvbnMuIFRvIGxpbWl0IENJIHRpbWUgd2Ugb2Z0ZW4gYnVpbGQgYSBzdWJz
ZXQgYW5kIG5vdyB0aGlzDQo+PiBwYXJ0aWN1bGFyIHN1YnNldCB3b24ndCB0ZXN0IHRoZSBw
bHVnaW4gcGF0aHMuDQo+Pg0KPiANCj4gT2suIElzIGxpbnV4LXVzZXIteDg2XzY0IGZyZXF1
ZW50bHkgc2tpcHBlZD8NCj4gSSBjb3VsZCBhZGQgc3VwcG9ydCBmb3IgYWFyY2g2NCB0b28s
IGlmIHlvdSB0aGluayBpdCdzIHdvcnRoIGl0LiBJDQo+IHN1c3BlY3Qgd2UgYWx3YXlzIGhh
dmUgYXQgbGVhc3Qgb25lIG9mIHRoZSB0d28gYXJjaCB0aGF0IGlzIHJ1bm5pbmcgaW4gQ0ku
DQo+IA0KPj4+DQo+Pj4gRG9lcyBpdCBtYWtlIG1vcmUgc2Vuc2UgZm9yIHlvdT8NCj4+Pg0K
Pj4gPHNuaXA+DQo+Pg0KDQpBZnRlciBkaXNjdXNzaW5nIHdpdGggQWxleCwgb3VyIGdvYWwg
d2lsbCBiZSB0byBoYXZlIGEgbXVsdGlhcmNoIHRlc3QuIA0KSSdsbCBkbyB0aGlzIGZvciB0
aGUgbmV4dCB2ZXJzaW9uLg0K

