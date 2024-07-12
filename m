Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E50C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 17:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJr6-0000LP-04; Fri, 12 Jul 2024 13:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sSJr4-0000KU-53
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 13:14:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sSJr1-0001Hu-Rd
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 13:14:45 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fb4a807708so20992845ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720804481; x=1721409281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0UmvGYCUgKesS8vU0kMDXJ99SV2mq6tM8KrAn4UAwP0=;
 b=w/qmBsfj8hYd9bgJ0X7VKW7m4C8a8XfL5Qd95mTrDiIAJ0uQTIRB1LbcfjyuphMYwV
 38osirShWXSITIIdF/zOeUDvVnFWlZyXhQs9mnpEsZQsSLhoOaikvFeMkAiUgeyxuLdU
 VVVhJNIXwynlWgOp2GGcximiKaYPBeBM1kgmNUHfz6vDrBYcg2NPBLdFu/DMEUBDxWqT
 Lfvt+N48oIadSS9XCMD/qhYkVMnrZXXBJS6KP8za8vM5YLaWWIt1+DIg4QRLo/ExGUpk
 nd2T33JHzLtnNaKVSLe4xdfU16XbMS9BNQaPf2LneKDxAbe+QhI55z70+3w+69kj/O6l
 ZoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720804481; x=1721409281;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0UmvGYCUgKesS8vU0kMDXJ99SV2mq6tM8KrAn4UAwP0=;
 b=Rr8kOJMSm9buA+OPC2Jk932wmwNmNfmqUQt5M4Fp4pvzYymYoaLhekSkYHyZvfzcOd
 f1T6mjx1f5nLGLqamSpnvYr5gWSOqES1XJp1SzMLKsNUAY7VKpb2oxDnlCAJAsmGCpdd
 Lixba7EmmMV8qpH2jfmsgnqefy9atKUV/1eTn2gbfRCg+6DhDxYLcmAKqlqDzc/4ZSM3
 M/OBJZrtHUAjzi8S/ZVVcsQ6bcNY3ELKlqRgfCiEyvkfJViC5mMYR54Jo5KeMuuHLfSU
 x8rGwQZyTyJjbpRkwD3N2yu9uKZp7VoXK5CZmUsdCGvVYuBtHUUUFVB7Jcb/iKLv3/9Y
 mYPg==
X-Gm-Message-State: AOJu0Yz3MRpA3ktJB7WIvZ2ublrcC/qe7Hlx7PY1V/3kSViqhhtfzR7q
 nJiDLpM9rDPMWkW3/UbjE5kymEJjm+Z+aPjvr++ODbkoUf82CzBJDIeKBxAcuBY=
X-Google-Smtp-Source: AGHT+IE0sbYMD2SvOeWwR1LQa8CfpEb99go0m1+LDXbVLAkL3edCT9B6QVYECUn14c3815/prfTAuQ==
X-Received: by 2002:a17:902:ea04:b0:1fb:438a:5e5c with SMTP id
 d9443c01a7336-1fbb6edb408mr115358085ad.43.1720804481004; 
 Fri, 12 Jul 2024 10:14:41 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a29198sm69540045ad.71.2024.07.12.10.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 10:14:40 -0700 (PDT)
Message-ID: <2c7e5d0a-7f75-4c3e-9127-695787622599@linaro.org>
Date: Fri, 12 Jul 2024 10:14:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] tests/tcg/x86_64: add test for plugin memory access
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <87ttgupss7.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

T24gNy8xMi8yNCAwNzo1MSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiA3
LzgvMjQgMTI6MTUsIEFsZXggQmVubsOpZSB3cm90ZToNCj4+PiBQaWVycmljayBCb3V2aWVy
IDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4+Pg0KPj4+PiBBZGQg
YW4gZXhwbGljaXQgdGVzdCB0byBjaGVjayBleHBlY3RlZCBtZW1vcnkgdmFsdWVzIGFyZSBy
ZWFkL3dyaXR0ZW4uDQo+Pj4+IEZvciBzaXplcyA4LCAxNiwgMzIsIDY0IGFuZCAxMjgsIHdl
IGdlbmVyYXRlIGEgbG9hZC9zdG9yZSBvcGVyYXRpb24uDQo+Pj4+IEZvciBzaXplIDggLT4g
NjQsIHdlIGdlbmVyYXRlIGFuIGF0b21pYyBfX3N5bmNfdmFsX2NvbXBhcmVfYW5kX3N3YXAg
dG9vLg0KPj4+PiBGb3IgMTI4Yml0cyBtZW1vcnkgYWNjZXNzLCB3ZSByZWx5IG9uIFNTRTIg
aW5zdHJ1Y3Rpb25zLg0KPj4+Pg0KPj4+PiBCeSBkZWZhdWx0LCBhdG9taWMgYWNjZXNzZXMg
YXJlIG5vbiBhdG9taWMgaWYgYSBzaW5nbGUgY3B1IGlzIHJ1bm5pbmcsDQo+Pj4+IHNvIHdl
IGZvcmNlIGNyZWF0aW9uIG9mIGEgc2Vjb25kIG9uZSBieSBjcmVhdGluZyBhIG5ldyB0aHJl
YWQgZmlyc3QuDQo+Pj4+DQo+Pj4+IGxvYWQvc3RvcmUgaGVscGVycyBjb2RlIHBhdGggY2Fu
J3QgYmUgdHJpZ2dlcmVkIGVhc2lseSBpbiB1c2VyIG1vZGUgKG5vDQo+Pj4+IHNvZnRtbXUp
LCBzbyB3ZSBjYW4ndCB0ZXN0IGl0IGhlcmUuDQo+Pj4+DQo+Pj4+IENhbiBiZSBydW4gd2l0
aDoNCj4+Pj4gbWFrZSAtQyBidWlsZC90ZXN0cy90Y2cveDg2XzY0LWxpbnV4LXVzZXIgcnVu
LXBsdWdpbi10ZXN0LXBsdWdpbi1tZW0tYWNjZXNzLXdpdGgtbGlibWVtLnNvDQo+Pj4+DQo+
Pj4+IFRlc3RlZC1ieTogWGluZ3RhbyBZYW8gPHlhb3h0LmZuc3RAZnVqaXRzdS5jb20+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
bGluYXJvLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+ICAgIHRlc3RzL3RjZy94ODZfNjQvdGVzdC1w
bHVnaW4tbWVtLWFjY2Vzcy5jICAgfCA4OSArKysrKysrKysrKysrKysrKysrKysNCj4+Pj4g
ICAgdGVzdHMvdGNnL3g4Nl82NC9NYWtlZmlsZS50YXJnZXQgICAgICAgICAgICB8ICA3ICsr
DQo+Pj4+ICAgIHRlc3RzL3RjZy94ODZfNjQvY2hlY2stcGx1Z2luLW1lbS1hY2Nlc3Muc2gg
fCA0OCArKysrKysrKysrKw0KPj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDE0NCBpbnNlcnRp
b25zKCspDQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cveDg2XzY0L3Rl
c3QtcGx1Z2luLW1lbS1hY2Nlc3MuYw0KPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVz
dHMvdGNnL3g4Nl82NC9jaGVjay1wbHVnaW4tbWVtLWFjY2Vzcy5zaA0KPj4+Pg0KPj4+PiBk
aWZmIC0tZ2l0IGEvdGVzdHMvdGNnL3g4Nl82NC90ZXN0LXBsdWdpbi1tZW0tYWNjZXNzLmMg
Yi90ZXN0cy90Y2cveDg2XzY0L3Rlc3QtcGx1Z2luLW1lbS1hY2Nlc3MuYw0KPj4+PiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRleCAwMDAwMDAwMDAwMC4uN2ZkZDZhNTU4MjkN
Cj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+PiArKysgYi90ZXN0cy90Y2cveDg2XzY0L3Rlc3Qt
cGx1Z2luLW1lbS1hY2Nlc3MuYw0KPj4+PiBAQCAtMCwwICsxLDg5IEBADQo+Pj4+ICsjaW5j
bHVkZSA8ZW1taW50cmluLmg+DQo+Pj4+ICsjaW5jbHVkZSA8cHRocmVhZC5oPg0KPj4+PiAr
I2luY2x1ZGUgPHN0ZGludC5oPg0KPj4+PiArI2luY2x1ZGUgPHN0ZGxpYi5oPg0KPj4+PiAr
DQo+Pj4+ICtzdGF0aWMgdm9pZCAqZGF0YTsNCj4+Pj4gKw0KPj4+PiArI2RlZmluZSBERUZJ
TkVfU1RPUkUobmFtZSwgdHlwZSwgdmFsdWUpIFwNCj4+Pj4gK3N0YXRpYyB2b2lkIHN0b3Jl
XyMjbmFtZSh2b2lkKSAgICAgICAgICBcDQo+Pj4+ICt7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KPj4+PiArICAgICooKHR5cGUgKilkYXRhKSA9IHZhbHVl
OyAgICAgICAgICAgIFwNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArI2RlZmluZSBERUZJTkVf
QVRPTUlDX09QKG5hbWUsIHR5cGUsIHZhbHVlKSAgICAgICAgICAgICAgICAgXA0KPj4+PiAr
c3RhdGljIHZvaWQgYXRvbWljX29wXyMjbmFtZSh2b2lkKSAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPj4+PiAreyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXA0KPj4+PiArICAgICooKHR5cGUgKilkYXRhKSA9IDB4
NDI7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4+PiArICAgIF9fc3lu
Y192YWxfY29tcGFyZV9hbmRfc3dhcCgodHlwZSAqKWRhdGEsIDB4NDIsIHZhbHVlKTsgXA0K
Pj4+IFNob3VsZCB3ZSBleGVyY2lzZSB0aGUgb3RoZXIgY29tcGFyZSBhbmQgc3dhcCBvcHM/
IERvIHRoZXkgYWxsIGNvbWUNCj4+PiB0aHJvdWdoIHRoZSBzYW1lIHJ3bSBwYXRoPw0KPj4+
DQo+Pg0KPj4gVGhlcmUgYXJlIGRlZmluaXRlbHkgc2V2ZXJhbCBwYXRocyBkZXBlbmRpbmcg
b24gdGhlIGdlbmVyYXRlZCBhdG9taWMgb3AuDQo+PiBIb3dldmVyLCB0aGUgY29kZSBpcyBw
cmV0dHkgc3RyYWlnaHRmb3J3YXJkIChhbmQgaW1wbGVtZW50ZWQgaW4gYQ0KPj4gc2luZ2xl
IGZ1bmN0aW9uKSwgc28gbXkgdGhvdWdodCB3YXMgdGhhdCBvbmUgd2F5IHRvIHRyaWdnZXIg
dGhpcyB3YXMNCj4+IGVub3VnaC4NCj4gDQo+IElmIHRoZXkgYWxsIGNvbWUgdGhyb3VnaCB0
aGUgc2FtZSBwYXRoIEkgZ3Vlc3MgdGhhdCdzIE9LLg0KPiANCj4+Pj4gK30NCj4+Pj4gKw0K
Pj4+PiArI2RlZmluZSBERUZJTkVfTE9BRChuYW1lLCB0eXBlKSAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQo+Pj4+ICtzdGF0aWMgdm9pZCBsb2FkXyMjbmFtZSh2b2lkKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4+Pj4gK3sgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4+PiArICAgIHJlZ2lzdGVyIHR5
cGUgdmFyIGFzbSgiZWF4IikgPSAqKCh0eXBlICopIGRhdGEpOyAgICBcDQo+Pj4+ICsgICAg
KHZvaWQpdmFyOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
Cj4+PiBUaGlzIGlzIGEgYml0IHdlaXJkLiBJdCdzIHRoZSBvbmx5IGlubGluZSBhc20gbmVl
ZGVkIHRoYXQgbWFrZXMgdGhpcw0KPj4+IGENCj4+PiBub24tbXVsdGlhcmNoIHRlc3QuIFdo
eT8NCj4+Pg0KPj4NCj4+IEknbGwgYW5zd2VyIGhlcmUgYWJvdXQgd2h5IHRoaXMgdGVzdCBp
cyBhcmNoIHNwZWNpZmljLCBhbmQgbm90IGEgbXVsdGkgYXJjaC4NCj4+DQo+PiBUaGUgcHJv
YmxlbSBJIG1ldCBpcyB0aGF0IGFsbCB0YXJnZXQgYXJjaGl0ZWN0dXJlIGRvIG5vdCBoYXZl
IG5hdGl2ZQ0KPj4gNjQvMTI4IGJpdHMgdHlwZXMsIGFuZCBkZXBlbmRpbmcgaG93IGNvZGUg
aXMgY29tcGlsZWQgd2l0aCBnY2MsIHlvdQ0KPj4gbWF5IG9yIG5vdCBnZW5lcmF0ZWQgZXhw
ZWN0ZWQgdmVjdG9yIGluc3RydWN0aW9ucyBmb3IgMTI4Yml0cw0KPj4gb3BlcmF0aW9uLiBT
YW1lIGZvciBhdG9taWMgb3BlcmF0aW9ucy4NCj4gDQo+IFNvIHdlIGRvIGhhbmRsZSB0aGlz
IHdpdGggdGhlIHNoYTUxMiB0ZXN0LCBidWlsZGluZyB2YXJpYW50cyBvZiBpdCB3aXRoDQo+
IHZhcmlvdXMgY29tcGlsZXIgZmxhZ3MgdG8gdHJpZ2dlciB0aGUgdXNlIG9mIHZlY3RvcnMu
IFNvIHRoZSBjb2RlIGlzDQo+IG11bHRpYXJjaCBidXQgd2UgaGF2ZSBhcmNoIHNwZWNpZmlj
IHZhcmlhbnRzIGFzIGRpY3RhdGVkIGJ5IHRoZQ0KPiBNYWtlZmlsZXMsIGkuZS46DQo+IA0K
PiAgICBzaGE1MTItc3ZlOiBDRkxBR1M9LU8zIC1tYXJjaD1hcm12OC4xLWErc3ZlDQo+ICAg
IHNoYTUxMi1zdmU6IHNoYTUxMi5jDQo+ICAgICAgICAgICAgJChDQykgJChDRkxBR1MpICQo
RVhUUkFfQ0ZMQUdTKSAkPCAtbyAkQCAkKExERkxBR1MpDQo+IA0KPiAgICBURVNUUyArPSBz
aGE1MTItc3ZlDQo+DQoNCkkgc3VzcGVjdCB0aGlzIGlzIGdvbm5hIG5lZWQgc2V2ZXJhbCBp
dGVyYXRpb25zIHRvIHRyeSBhbGwgYXJjaCwgYW5kIHNlZSANCndoaWNoIG9uZXMgaGF2ZSBu
YXRpdmUgNjQvMTI4IGJpdHMgYW5kIHdoaWNoIG9uZXMgaGF2ZSBhdG9taWMgDQppbnN0cnVj
dGlvbnMuIElzIHRoYXQgcmVhbGx5IHdoZXJlIHdlIHdhbnQgdG8gc3BlbmQgb3VyIChwcmVj
aW91cykgdGltZT8gDQpJJ20gbm90IGNvbnZpbmNlZCBvZiB0aGUgdmFsdWUgb2YgdGhhdC4g
V2UgdHJ5IHRvIHRlc3QgcGx1Z2lucyANCmltcGxlbWVudGF0aW9uLCBub3QgaG93IFFFTVUg
aGFuZGxlcyBtZW1vcnkgYWNjZXNzZXMgaW4gZ2VuZXJhbC4NCg0KVGhlIHNwZWNpZmljaXR5
IG9mIHRoaXMgdGVzdCwgaXMgd2hhdCB3ZSBkb24ndCB0ZXN0IHRoZSBjb3JyZWN0IG91dHB1
dCANCm9mIGEgcHJvZ3JhbSwgYnV0IHdlIG9ic2VydmUgYW4gZXhwZWN0ZWQgYmVoYXZpb3Is
IHZpYSB0aGUgcGx1Z2lucyANCnRyYWNlLiBTbyBpdCdzIGEgYml0IGRpZmZlcmVudCBmcm9t
IHNoYTUxMiBleGFtcGxlLg0KDQo+PiBUaHVzLCBJIGNob3NlIHRvIHNwZWNpYWxpemUgdGhp
cyB0ZXN0IGZvciB4ODZfNjQsIGFuZCB1c2Ugc3NlMg0KPj4gZGlyZWN0bHkgZm9yIDEyOCBi
aXRzIGludGVnZXJzLg0KPj4NCj4+IFlvdSBtaWdodCBzYXkgIkhvdyBhYm91dCBhZGRpbmcg
aWZkZWYgZm9yIHRoaXMiLiBZZXMgc3VyZSwgYnV0IHRoZQ0KPj4gY2hlY2sgc2NyaXB0IHdv
dWxkIGJlY29tZSBjb21wbGljYXRlZCB0b28sIGFuZCBJIGp1c3Qgd2FudGVkIHRvIGtlZXAN
Cj4+IGl0IHNpbXBsZS4NCj4gDQo+IFdlIGNhbiBrZWVwIHRoZSBjaGVjay1zY3JpcHQgcGVy
IGFyY2ggaWYgd2UgaGF2ZSB0by4NCj4gDQoNCkkgd291bGQgYWRkIGEgdGFyZ2V0IGFyY2gg
cGFyYW0sIGJ1dCBub3QgZHVwbGljYXRlIHRoaXMgdG8gYmUgaG9uZXN0LiANCldpbGwgYmUg
YSBwYWluIHRvIHVwZGF0ZSBpZiBuZWVkZWQuDQpNeSBnb2FsIHdhcyB0byByZXBsYWNlIHRo
aXMgd2l0aCBMTFZNIGZpbGVjaGVjayBpbiBhIGZvbGxvd2luZyBzZXJpZXMuDQoNCj4+IE91
ciBpbnRlcmVzdCBoZXJlIGlzIG5vdCB0byBjaGVjayB0aGF0IG1lbW9yeSBhY2Nlc3NlcyBh
cmUNCj4+IGNvcnJlY3RseSBpbXBsZW1lbnRlZCBpbiBRRU1VLCBidXQgdG8gY2hlY2sgdGhh
dCBhIHNwZWNpZmljIGJlaGF2aW9yDQo+PiBvbiBvbmUgYXJjaCBpcyB0aGUgb25lIGV4cGVj
dGVkLg0KPiANCj4gU28gdGhlIHByb2JsZW0gd2l0aCBub3QgYmVpbmcgbXVsdGlhcmNoIGlz
IHdlIGRvbid0IGJ1aWxkIGFsbCB0YXJnZXRzIGluDQo+IGFsbCBjb21iaW5hdGlvbnMuIFRv
IGxpbWl0IENJIHRpbWUgd2Ugb2Z0ZW4gYnVpbGQgYSBzdWJzZXQgYW5kIG5vdyB0aGlzDQo+
IHBhcnRpY3VsYXIgc3Vic2V0IHdvbid0IHRlc3QgdGhlIHBsdWdpbiBwYXRocy4NCj4gDQoN
Ck9rLiBJcyBsaW51eC11c2VyLXg4Nl82NCBmcmVxdWVudGx5IHNraXBwZWQ/DQpJIGNvdWxk
IGFkZCBzdXBwb3J0IGZvciBhYXJjaDY0IHRvbywgaWYgeW91IHRoaW5rIGl0J3Mgd29ydGgg
aXQuIEkgDQpzdXNwZWN0IHdlIGFsd2F5cyBoYXZlIGF0IGxlYXN0IG9uZSBvZiB0aGUgdHdv
IGFyY2ggdGhhdCBpcyBydW5uaW5nIGluIENJLg0KDQo+Pg0KPj4gRG9lcyBpdCBtYWtlIG1v
cmUgc2Vuc2UgZm9yIHlvdT8NCj4+DQo+IDxzbmlwPg0KPiANCg==

