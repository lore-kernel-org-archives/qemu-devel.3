Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8166CFA463
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 20:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hb1-0007A8-NB; Wed, 23 Oct 2024 16:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3haz-000799-Or
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:04:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3hay-0004wR-3O
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:04:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so896345ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 13:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729713878; x=1730318678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IVuVmlXUrxjWZiadwQhyCE987o5t/oQEz7uWJawF0dg=;
 b=SkBOi4gCnFAURukfwNGOAhyCxYCQxzlq/d4vC0tjVcZPOWO8qmTPHE1K4hTmm9yk6c
 Z+4ZTUdDEV00RNq7okMErnNqrynlcRo2r6iBleHY5bzioYwzou25HtpssVLunZYu+Nd2
 CWyrCGQ61xf0vuHWhgv0Llu2LA0g7eKEgMAoIitD+bZ5wiK/j5D+C2C6+XdZ8jMuQB3G
 swCaGA5kf3KwA2dJyV/5ScbKKKZ3cQ42R/nbt4i+PrCjGr+TE949pJeH50XfIEFY6lzA
 wsNRVaHonVWI5vGlFUE94Kobuq/DMzaLV1KcTM1IFF8uGRfgGXEaTE5KgCuTt6h0cMrh
 yyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729713878; x=1730318678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IVuVmlXUrxjWZiadwQhyCE987o5t/oQEz7uWJawF0dg=;
 b=AfdY9+8qTGwJ1g5yDerXsginqVagG/jOQNtDXJ5k5XfT0xf7IsqDkSGnQR1dhBcFJI
 T3kuFxUFumTI6ZlfU2HMBXwWwXWkA2mjQmim7ITdMSM9F8n3XlvDQvcG9D1lLcyS+xlY
 wc7OdStn9meh60IGfdhLiJkTTzxdfAKtWYZYQhCsqEPIQfavUTxR9nNEZcwNFduryOy0
 U3Y8bB3OfPjemvMtz7ajr0OCU5QB74AFXMuuoWy9FZ05ATOEz1qfCfBoKc5tgUKrFsvC
 8UKzbaNCH3Fhc+8kNLcW0f8fb54I9Zxjx5RWQ72jogkjwbVl1Ypq2sxqfKC2t9ido9Ew
 hRNw==
X-Gm-Message-State: AOJu0YzBYchMTboC+dSmr30gCbdH9U8xNJMHxg+Cjsi44yjqn46qwNBr
 XqQrRe6jZS3WeHMosO7W40Kj7X60GdPXHpof6OaFMFZ6s2SdjcfGq+uannN4vvXZ6a2YT0wCwCh
 5++TXvg==
X-Google-Smtp-Source: AGHT+IHX+K2b/sM/7I9nLv41CC25HZHYeVyfrx6GnNCV9LC2Y4QSWRShKJPyeB2q4Ecvy3u2HoIxWA==
X-Received: by 2002:a17:902:da91:b0:20c:f3be:2f82 with SMTP id
 d9443c01a7336-20fa9e647c6mr52894395ad.33.1729713878451; 
 Wed, 23 Oct 2024 13:04:38 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd599sm61270945ad.145.2024.10.23.13.04.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 13:04:38 -0700 (PDT)
Message-ID: <0b140b1c-7174-4108-b504-98f9506f3fb8@linaro.org>
Date: Wed, 23 Oct 2024 13:04:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: remove unused but set variable
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20241023182922.1040964-1-pierrick.bouvier@linaro.org>
 <87zfmuk34y.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87zfmuk34y.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

T24gMTAvMjMvMjQgMTI6NTMsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gZml4
ZXMgYXNzb2NpYXRlZCB3YXJuaW5nIHdoZW4gYnVpbGRpbmcgb24gTWFjT1MuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5h
cm8ub3JnPg0KPj4gLS0tDQo+PiAgIHRhcmdldC9pMzg2L2h2Zi94ODZfdGFzay5jIHwgMTAg
KysrKystLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9odmYveDg2X3Rh
c2suYyBiL3RhcmdldC9pMzg2L2h2Zi94ODZfdGFzay5jDQo+PiBpbmRleCBmMDliZmJkZGE1
Yi4uY2RlYTJlYTY5ZDkgMTAwNjQ0DQo+PiAtLS0gYS90YXJnZXQvaTM4Ni9odmYveDg2X3Rh
c2suYw0KPj4gKysrIGIvdGFyZ2V0L2kzODYvaHZmL3g4Nl90YXNrLmMNCj4+IEBAIC0xMjIs
NyArMTIyLDYgQEAgdm9pZCB2bXhfaGFuZGxlX3Rhc2tfc3dpdGNoKENQVVN0YXRlICpjcHUs
IHg2OF9zZWdtZW50X3NlbGVjdG9yIHRzc19zZWwsIGludCByZWENCj4+ICAgICAgIGxvYWRf
cmVncyhjcHUpOw0KPj4gICANCj4+ICAgICAgIHN0cnVjdCB4ODZfc2VnbWVudF9kZXNjcmlw
dG9yIGN1cnJfdHNzX2Rlc2MsIG5leHRfdHNzX2Rlc2M7DQo+PiAtICAgIGludCByZXQ7DQo+
PiAgICAgICB4Njhfc2VnbWVudF9zZWxlY3RvciBvbGRfdHNzX3NlbCA9IHZteF9yZWFkX3Nl
Z21lbnRfc2VsZWN0b3IoY3B1LCBSX1RSKTsNCj4+ICAgICAgIHVpbnQ2NF90IG9sZF90c3Nf
YmFzZSA9IHZteF9yZWFkX3NlZ21lbnRfYmFzZShjcHUsIFJfVFIpOw0KPj4gICAgICAgdWlu
dDMyX3QgZGVzY19saW1pdDsNCj4+IEBAIC0xMzgsNyArMTM3LDcgQEAgdm9pZCB2bXhfaGFu
ZGxlX3Rhc2tfc3dpdGNoKENQVVN0YXRlICpjcHUsIHg2OF9zZWdtZW50X3NlbGVjdG9yIHRz
c19zZWwsIGludCByZWENCj4+ICAgICAgIGlmIChyZWFzb24gPT0gVFNSX0lEVF9HQVRFICYm
IGdhdGVfdmFsaWQpIHsNCj4+ICAgICAgICAgICBpbnQgZHBsOw0KPj4gICANCj4+IC0gICAg
ICAgIHJldCA9IHg4Nl9yZWFkX2NhbGxfZ2F0ZShjcHUsICZ0YXNrX2dhdGVfZGVzYywgZ2F0
ZSk7DQo+PiArICAgICAgICB4ODZfcmVhZF9jYWxsX2dhdGUoY3B1LCAmdGFza19nYXRlX2Rl
c2MsIGdhdGUpOw0KPiANCj4gSWYgd2UgZG9uJ3QgY2FyZSBhbmQgdGhpcyBpcyB0aGUgb25s
eSBjYWxsZXIgd2UgZml4IHVwDQo+IHg4Nl9yZWFkX2NhbGxfZ2F0ZSBub3QgdG8gcmV0dXJu
IGEgdmFsdWUuIEl0IGxvb2tzIGxpa2UgaXQgZmFpbHMgc2FmZQ0KPiB3aXRoIGFuIGVtcHR5
IGVudHJ5IChidXQgYWxzbyB0aGUgZnVuY3Rpb24geDg2X3JlYWRfY2FsbF9nYXRlIG5lZWRz
IHRoZQ0KPiBwcmludGYgcmVtb3ZpbmcpLg0KPiANClllcywgb3IgbWF5YmUgd2Ugc2hvdWxk
IGNoZWNrIGlmIHRoZSByZWFkIHdhcyBhIHN1Y2Nlc3MsIG9yIGVsc2UgY2FsbCANClZNX1BB
TklDKCJ4ODZfcmVhZF9jYWxsX2dhdGUiKS4NCkFueSBhZHZpY2UgZnJvbSBodmYgbWFpbnRh
aW5lcnM/DQoNCj4+ICAgDQo+PiAgICAgICAgICAgZHBsID0gdGFza19nYXRlX2Rlc2MuZHBs
Ow0KPj4gICAgICAgICAgIHg2OF9zZWdtZW50X3NlbGVjdG9yIGNzID0gdm14X3JlYWRfc2Vn
bWVudF9zZWxlY3RvcihjcHUsIFJfQ1MpOw0KPj4gQEAgLTE2NywxMSArMTY2LDEyIEBAIHZv
aWQgdm14X2hhbmRsZV90YXNrX3N3aXRjaChDUFVTdGF0ZSAqY3B1LCB4Njhfc2VnbWVudF9z
ZWxlY3RvciB0c3Nfc2VsLCBpbnQgcmVhDQo+PiAgICAgICAgICAgeDg2X3dyaXRlX3NlZ21l
bnRfZGVzY3JpcHRvcihjcHUsICZuZXh0X3Rzc19kZXNjLCB0c3Nfc2VsKTsNCj4+ICAgICAg
IH0NCj4+ICAgDQo+PiAtICAgIGlmIChuZXh0X3Rzc19kZXNjLnR5cGUgJiA4KQ0KPj4gLSAg
ICAgICAgcmV0ID0gdGFza19zd2l0Y2hfMzIoY3B1LCB0c3Nfc2VsLCBvbGRfdHNzX3NlbCwg
b2xkX3Rzc19iYXNlLCAmbmV4dF90c3NfZGVzYyk7DQo+PiAtICAgIGVsc2UNCj4+ICsgICAg
aWYgKG5leHRfdHNzX2Rlc2MudHlwZSAmIDgpIHsNCj4+ICsgICAgICAgIHRhc2tfc3dpdGNo
XzMyKGNwdSwgdHNzX3NlbCwgb2xkX3Rzc19zZWwsIG9sZF90c3NfYmFzZSwgJm5leHRfdHNz
X2Rlc2MpOw0KPj4gKyAgICB9IGVsc2Ugew0KPj4gICAgICAgICAgIC8vcmV0ID0gdGFza19z
d2l0Y2hfMTYoY3B1LCB0c3Nfc2VsLCBvbGRfdHNzX3NlbCwgb2xkX3Rzc19iYXNlLCAmbmV4
dF90c3NfZGVzYyk7DQo+PiAgICAgICAgICAgVk1fUEFOSUMoInRhc2tfc3dpdGNoXzE2Iik7
DQo+PiArICAgIH0NCj4+ICAgDQo+PiAgICAgICBtYWN2bV9zZXRfY3IwKGNwdS0+YWNjZWwt
PmZkLCBydm1jcyhjcHUtPmFjY2VsLT5mZCwgVk1DU19HVUVTVF9DUjApIHwNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUjBfVFNfTUFTSyk7DQo+IA0K

