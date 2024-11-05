Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1015AD3177B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Nvh-0000Vi-84; Tue, 05 Nov 2024 13:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8Nvf-0000VF-0s
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:05:23 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8Nvc-0004Ym-SN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:05:22 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cb47387ceso56302225ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730829919; x=1731434719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/QDP/oJs6K1LWgzEBfMb7OYv+OzCyp73FL7wDudZOM=;
 b=ZlM2df1jBmh0hgIm7Cn08+mWkE+xxBOga85j0/EMfqNyCnerAf3X5399U8S64oLvTu
 Fxn6fMYFO1QtdLu3mFj3km17tFJK0DWp7RzhK9hxy52z3OMmykMHg29jLcA/Dq/LBcl/
 UCVMIdvnXZLa0tBP3Wn/Kx9/vqm2o19GejXL0+YbATBBAzp3GQP/BaFo6cggaprqLjFw
 wnUF6shX5UEIwN7xaIQfgOJTfT/dnLVl+0p0UDKtwS/UFKNG4EI5DKDZFFbPpW3NTIPy
 ywqkNrmzxgdABA4j4cs1QS8TpMgxKGu/9lyg0BlHUNcjT/UvfzyoRoEV/42ce8hwEUkn
 DU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730829919; x=1731434719;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/QDP/oJs6K1LWgzEBfMb7OYv+OzCyp73FL7wDudZOM=;
 b=hVGIP6a5wWMAV5FZdXAydmI7pSOo1rnagPYh6S490Fqx4GSeriX3tkr6lv+PRQaDJj
 tvoMx8xQdbQMfRNsbFxQA+SxO1BboG6AuznxaOh8W/m5U33e0Rz4F2ivYKnVUndAHyYX
 IEv8R+9zwQVuHfk4WeobP0suG3ASIYMsar0fOKDZh6HIunSHtTa2VnM2RpS7HXOiywsj
 5EKrJQQFBVILUhzJsY19QkMNNKsuB/zxMGcGziOjFUK8OGiw8m3RS7fHJ3iO+DFeGnN3
 hKMM/P9b9mraFRqRumDdwmVmihWj6IquTnjpICFU4BdW/b+/2+dCKw4JbGea5y4ngjTW
 x5zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmDpFxkOzkW23Ptbz/GyR8q/RaOwDFa7eih4TC44srk7b7IPSHGZZia+Jga7Vi1QnvqpcCGC1KzoQ9@nongnu.org
X-Gm-Message-State: AOJu0YwxU3Sg8/HkvVzLvYRE+9VwgSgVgSPxMZ1hnhEdyZU5SYEiXRNm
 pnRnBnYAu4S5wvrvBqFURlyjAIsKgOuVOebXhgNAjTKTvnzRYa0GeUoORuPhXKI=
X-Google-Smtp-Source: AGHT+IEtNspWmTRnZt3cv8vBE/A+AHLo7WTffC7HEfwn8eM2WIqDXro/efGHgPwmdnlXLNpcVce6Zw==
X-Received: by 2002:a17:902:e80b:b0:20b:5b16:b16b with SMTP id
 d9443c01a7336-210c6b08be4mr480262525ad.36.1730829918823; 
 Tue, 05 Nov 2024 10:05:18 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a2f08sm81415505ad.154.2024.11.05.10.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 10:05:18 -0800 (PST)
Message-ID: <64ed0302-0049-41bb-a284-aaff7ab913bd@linaro.org>
Date: Tue, 5 Nov 2024 10:05:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: test regression - qemu:block-slow+slow / io-raw-055
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>
References: <b8806360-a2b6-4608-83a3-db67e264c733@linaro.org>
 <ZypKrpbo28zrEamP@x1n>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ZypKrpbo28zrEamP@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gMTEvNS8yNCAwODo0MSwgUGV0ZXIgWHUgd3JvdGU6DQo+IE9uIE1vbiwgTm92IDA0LCAy
MDI0IGF0IDA3OjQxOjQ0UE0gLTA4MDAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBI
aSwNCj4+DQo+PiB0aGlzIHRlc3Qgd2FzIHJlY2VudGx5IGJyb2tlbiBieSAzNGE4ODkgKG1p
Z3JhdGlvbjogRHJvcA0KPj4gbWlncmF0aW9uX2lzX2lkbGUoKSkuDQo+Pg0KPj4gUmVwcm9k
dWNlIHdpdGg6DQo+PiBtZXNvbiB0ZXN0IC1DIGJ1aWxkIC10IDEgLS1zZXR1cCBzbG93ICAt
LW51bS1wcm9jZXNzZXMgMSAtLXByaW50LWVycm9ybG9ncw0KPj4gaW8tcmF3LTA1NSAtLXZl
cmJvc2UNCj4+DQo+PiAxLzEgcWVtdTpibG9jay1zbG93K3Nsb3cgLyBpby1yYXctMDU1ICAg
ICAgICBSVU5OSU5HDQo+Pj4+PiBBU0FOX09QVElPTlM9aGFsdF9vbl9lcnJvcj0xOmFib3J0
X29uX2Vycm9yPTE6cHJpbnRfc3VtbWFyeT0xIFVCU0FOX09QVElPTlM9aGFsdF9vbl9lcnJv
cj0xOmFib3J0X29uX2Vycm9yPTE6cHJpbnRfc3VtbWFyeT0xOnByaW50X3N0YWNrdHJhY2U9
MQ0KPj4gTUFMTE9DX1BFUlRVUkJfPTI5IE1FU09OX1RFU1RfSVRFUkFUSU9OPTENCj4+IFBZ
VEhPTj0vaG9tZS91c2VyLy53b3JrL3FlbXUvYnVpbGQvcHl2ZW52L2Jpbi9weXRob24zIEdf
VEVTVF9TTE9XPTENCj4+IFNQRUVEPXNsb3cgTVNBTl9PUFRJT05TPWhhbHRfb25fZXJyb3I9
MTphYm9ydF9vbl9lcnJvcj0xOnByaW50X3N1bW1hcnk9MTpwcmludF9zdGFja3RyYWNlPTEN
Cj4+IC9ob21lL3VzZXIvLndvcmsvcWVtdS9idWlsZC9weXZlbnYvYmluL3B5dGhvbjMNCj4+
IC9ob21lL3VzZXIvLndvcmsvcWVtdS9idWlsZC8uLi90ZXN0cy9xZW11LWlvdGVzdHMvY2hl
Y2sgLXRhcCAtcmF3IDA1NQ0KPj4gLS1zb3VyY2UtZGlyIC9ob21lL3VzZXIvLndvcmsvcWVt
dS90ZXN0cy9xZW11LWlvdGVzdHMgLS1idWlsZC1kaXINCj4+IC9ob21lL3VzZXIvLndvcmsv
cWVtdS9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMNCj4+IOKWtiAxLzEgcmF3IDA1NSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRkFJTA0KPj4gMS8xIHFlbXU6YmxvY2stc2xv
dytzbG93IC8gaW8tcmF3LTA1NSAgICAgICAgRVJST1IgICAgICAgICAgIDExLjA2cyBleGl0
DQo+PiBzdGF0dXMgMQ0KPj4g4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCVDQo+PiDinIAg4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCVDQo+
PiBzdGRlcnI6DQo+PiAtLS0gL2hvbWUvdXNlci8ud29yay9xZW11L3Rlc3RzL3FlbXUtaW90
ZXN0cy8wNTUub3V0DQo+PiArKysgL2hvbWUvdXNlci8ud29yay9xZW11L2J1aWxkL3NjcmF0
Y2gvcmF3LWZpbGUtMDU1LzA1NS5vdXQuYmFkDQo+PiBAQCAtMSw1ICsxLDIxNSBAQA0KPj4g
LS4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCj4+ICsuLi4uLi5F
UlJPUjpxZW11LnFtcC5xbXBfY2xpZW50LnFlbXUtMTg1NjM4ODpGYWlsZWQgdG8gcmVjZWl2
ZSBHcmVldGluZzoNCj4+IEVPRkVycm9yDQo+PiArRVJST1I6cWVtdS5xbXAucW1wX2NsaWVu
dC5xZW11LTE4NTYzODg6RmFpbGVkIHRvIGVzdGFibGlzaCBzZXNzaW9uOg0KPj4gRU9GRXJy
b3INCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCj4gDQo+IEkgZG9uJ3Qga25vdyBo
b3cgdGhpcyB3YXMgdHJpZ2dlcmVkLCBsb29rcyBsaWtlIGN1cnJlbnRfbWlncmF0aW9uIHdh
c24ndA0KPiBzZXQgYXQgYWxsIGZvciBzb21lIHJlYXNvbi4uDQo+IA0KPiBDb3VsZCB5b3Ug
dHJ5IGJlbG93IGNoYW5nZSB0byBzZWUgd2hldGhlciBpdCBjYW4gZml4IHRoZXJlIHRvbyAo
aXQgd29ya2VkDQo+IGhlcmUpPw0KPiANCj4gPT09ODw9PT0NCj4gIEZyb20gZDMzYWQzMzg1
NGQzNmMwNDI2MDE1MGVlODE3Yjk4NGY0OGRhNDZjNiBNb24gU2VwIDE3IDAwOjAwOjAwIDIw
MDENCj4gRnJvbTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiBEYXRlOiBUdWUs
IDUgTm92IDIwMjQgMTE6Mjk6MDcgLTA1MDANCj4gU3ViamVjdDogW1BBVENIXSBtaWdyYXRp
b246IENoZWNrIGN1cnJlbnRfbWlncmF0aW9uIGluIG1pZ3JhdGlvbl9pc19ydW5uaW5nKCkN
Cj4gDQo+IFJlcG9ydCBzaG93cyB0aGF0IGNvbW1pdCAzNGE4ODkyZGVjIGJyb2tlIGlvdGVz
dCAwNTU6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL2I4ODA2MzYwLWEyYjYt
NDYwOC04M2EzLWRiNjdlMjY0YzczM0BsaW5hcm8ub3JnDQo+IA0KPiBXaGVuIHJlcGxhY2lu
ZyBtaWdyYXRpb25faXNfaWRsZSgpIHdpdGggIiFtaWdyYXRpb25faXNfcnVubmluZygpIiwg
aXQgd2FzDQo+IG92ZXJsb29rZWQgdGhhdCB0aGUgaWRsZSBoZWxwZXIgYWxzbyBjaGVja3Mg
Zm9yIGN1cnJlbnRfbWlncmF0aW9uIGJlaW5nDQo+IGF2YWlsYWJsZSBmaXJzdC4NCj4gDQo+
IFRoZSBjaGVjayB3b3VsZCBiZSB0aGVyZSBpZiB0aGUgd2hvbGUgc2VyaWVzIHdhcyBhcHBs
aWVkLCBidXQgc2luY2UgdGhlDQo+IGxhc3QgcGF0Y2hlcyBpbiB0aGUgcHJldmlvdXMgc2Vy
aWVzIHJlbHkgb24gc29tZSBvdGhlciBwYXRjaGVzIHRvIGxhbmQNCj4gZmlyc3QsIHdlIG5l
ZWQgdG8gcmVjb3ZlciB0aGUgYmVoYXZpb3Igb2YgbWlncmF0aW9uX2lzX2lkbGUoKSBmaXJz
dCBiZWZvcmUNCj4gdGhhdCB3aG9sZSBzZXQgd2lsbCBiZSBtZXJnZWQuDQo+IA0KPiBJIGxl
ZnQgbWlncmF0aW9uX2lzX2FjdGl2ZSAvIG1pZ3JhdGlvbl9pc19kZXZpY2UgYWxvbmUsIGFz
IEkgZG9uJ3QgdGhpbmsNCj4gaXQncyBwb3NzaWJsZSBmb3IgdGhlbSB0byBoaXQgaGlzIGNh
c2UgKGN1cnJlbnRfbWlncmF0aW9uIG5vdCBpbml0aWFsaXplZCkuDQo+IEFsc28gdGhleSdy
ZSBwcm9uZSB0byByZW1vdmFsIHNvb24gZnJvbSBWRklPIHNpZGUuDQo+IA0KPiBDYzogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPiBDYzogRmFi
aWFubyBSb3NhcyA8ZmFyb3Nhc0BzdXNlLmRlPg0KPiBGaXhlczogMzRhODg5MmRlYyAoIm1p
Z3JhdGlvbjogRHJvcCBtaWdyYXRpb25faXNfaWRsZSgpIikNCj4gU2lnbmVkLW9mZi1ieTog
UGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBtaWdyYXRpb24vbWln
cmF0aW9uLmMgfCA0ICsrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL21pZ3JhdGlvbi5jIGIvbWlncmF0aW9u
L21pZ3JhdGlvbi5jDQo+IGluZGV4IGFlZGY3ZjA3NTEuLjhjNWJkMGE3NWMgMTAwNjQ0DQo+
IC0tLSBhL21pZ3JhdGlvbi9taWdyYXRpb24uYw0KPiArKysgYi9taWdyYXRpb24vbWlncmF0
aW9uLmMNCj4gQEAgLTExMTcsNiArMTExNywxMCBAQCBib29sIG1pZ3JhdGlvbl9pc19ydW5u
aW5nKHZvaWQpDQo+ICAgew0KPiAgICAgICBNaWdyYXRpb25TdGF0ZSAqcyA9IGN1cnJlbnRf
bWlncmF0aW9uOw0KPiAgIA0KPiArICAgIGlmICghcykgew0KPiArICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgIHN3aXRjaCAocy0+c3RhdGUpIHsNCj4g
ICAgICAgY2FzZSBNSUdSQVRJT05fU1RBVFVTX0FDVElWRToNCj4gICAgICAgY2FzZSBNSUdS
QVRJT05fU1RBVFVTX1BPU1RDT1BZX0FDVElWRToNCg0KSGkgUGV0ZXIsDQpJIGNvbmZpcm0g
dGhpcyBmaXggdGhlIHRlc3QgbWVudGlvbmVkLiBZb3UgY2FuIHBvc3QgdGhpcyBwYXRjaC4N
Cg0KUmVnYXJkcywNClBpZXJyaWNrDQo=

