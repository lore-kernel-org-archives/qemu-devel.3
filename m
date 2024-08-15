Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD60C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seeVc-0001PU-Pi; Thu, 15 Aug 2024 13:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeVb-0001Nw-4L
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:43:35 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeVZ-0002HG-AF
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:43:34 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc5296e214so12553425ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723743811; x=1724348611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qzx+J2Rjorlia6Ijm2PzI08MkOLH9bUdtHYX95Om4z0=;
 b=uHnD7dK62xE0zJvhU6ro/a5oD1pV+JmslchuUQFYEBaxxNxo8FAtou6OJCPGzV38j7
 G9i/p5DhL7auNqbXlcIleS38k9FHKYr4Kerk8fU/ZjMef7+U8IMDm3yIcGmhz+Bw+ZBV
 uV9SUpzjS5yHl+wwNPrZLwL5EPRTyhQqEtE1GmnpIGoUd7LDbzzeiRIc+8nxI++lQCZ7
 C5v0nVE7j2XbidGSHLaKl9GpH3U/Hsdm2o2XbnSng1AOPWQuKptG4Z9nw8E5Seu1W2y1
 qeZINOFHye8ou6oUO0E1z3GoX/YH4jWoDlxy7/xsfVSV2cRY5X8rIfkaKUVpBaoWmRos
 djdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723743811; x=1724348611;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qzx+J2Rjorlia6Ijm2PzI08MkOLH9bUdtHYX95Om4z0=;
 b=qHOZqFKect0h8i7f+w2bH5x7lXl2ZDcFPsnrn1TkpupUP23Ub+JQ1th1VZgrB/Mh/+
 I37kOoWfq+W6q92LypCFyI++wqRhVoX+1kuA3CSDMVTMbeOEAW0zyg4xz1zuNx9iKQrm
 RW35fgHU8E0fsf0e/T6fs31/zEDiN8XJpPHY4ar1Z4PovdLsnkungwKILyMyCWDwPgPX
 WvBkvyOkREohREJ6ig0wLCzZgwhenp5IH4KjqqW2JQGcAYjsA02pW7VR68k/lVDuQNz7
 DqSKhkQ6GOsmnw8AF/hi+xV7YNAYqEmFNVgWCcT+0hZ5LZSvAMwsgrr/bIFbpTps1CXP
 JkXA==
X-Gm-Message-State: AOJu0YyVwywqcDzI5C9ZUHC3aDx27dVx/RRclwbrnPfTxyMPEiV28GSE
 CfUqGvLNqkdPAZNkOZfanYVo+pakIPpgo0QZdDuI4Yut6KsNLaQKd7lpjFme6po=
X-Google-Smtp-Source: AGHT+IGy0FWb0inV+zTv8LG3647k9pDnEZPw+izVbNQR75Eo9w1/uQrFaOyKI3sg/7Ymn8GD4oqkMg==
X-Received: by 2002:a17:902:e84a:b0:202:117:929f with SMTP id
 d9443c01a7336-20203f52adamr5520275ad.57.1723743811592; 
 Thu, 15 Aug 2024 10:43:31 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f02faa77sm12632285ad.58.2024.08.15.10.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 10:43:31 -0700 (PDT)
Message-ID: <90c9de4b-5f4f-4614-8ceb-26a156c0cba5@linaro.org>
Date: Thu, 15 Aug 2024 10:43:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] meson: hide tsan related warnings
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-2-pierrick.bouvier@linaro.org>
 <CAFEAcA-EAm9mEdGz6m2Y-yxK16TgX6CpxnXc6hW59iAxhXhHtw@mail.gmail.com>
 <Zr3g7lEfteRpNYVC@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Zr3g7lEfteRpNYVC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

T24gOC8xNS8yNCAwNDowNSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gVGh1
LCBBdWcgMTUsIDIwMjQgYXQgMTE6MTI6MzlBTSArMDEwMCwgUGV0ZXIgTWF5ZGVsbCB3cm90
ZToNCj4+IE9uIFdlZCwgMTQgQXVnIDIwMjQgYXQgMjM6NDIsIFBpZXJyaWNrIEJvdXZpZXIN
Cj4+IDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+DQo+Pj4gV2hl
biBidWlsZGluZyB3aXRoIGdjYy0xMiAtZnNhbml0aXplPXRocmVhZCwgZ2NjIHJlcG9ydHMg
c29tZQ0KPj4+IGNvbnN0cnVjdGlvbnMgbm90IHN1cHBvcnRlZCB3aXRoIHRzYW4uDQo+Pj4g
Rm91bmQgb24gZGViaWFuIHN0YWJsZS4NCj4+Pg0KPj4+IHFlbXUvaW5jbHVkZS9xZW11L2F0
b21pYy5oOjM2OjUyOiBlcnJvcjog4oCYYXRvbWljX3RocmVhZF9mZW5jZeKAmSBpcyBub3Qg
c3VwcG9ydGVkIHdpdGgg4oCYLWZzYW5pdGl6ZT10aHJlYWTigJkgWy1XZXJyb3I9dHNhbl0N
Cj4+PiAgICAgMzYgfCAjZGVmaW5lIHNtcF9tYigpICAgICAgICAgICAgICAgICAgICAgKHsg
YmFycmllcigpOyBfX2F0b21pY190aHJlYWRfZmVuY2UoX19BVE9NSUNfU0VRX0NTVCk7IH0p
DQo+Pj4gICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+
Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+DQo+Pj4gLS0tDQo+Pj4gICBtZXNvbi5idWlsZCB8IDEwICsrKysr
KysrKy0NCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxk
DQo+Pj4gaW5kZXggODFlY2Q0YmFlN2MuLjUyZTVhYTk1Y2MwIDEwMDY0NA0KPj4+IC0tLSBh
L21lc29uLmJ1aWxkDQo+Pj4gKysrIGIvbWVzb24uYnVpbGQNCj4+PiBAQCAtNDk5LDcgKzQ5
OSwxNSBAQCBpZiBnZXRfb3B0aW9uKCd0c2FuJykNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwcmVmaXg6ICcjaW5jbHVkZSA8c2FuaXRpemVyL3RzYW5faW50ZXJmYWNlLmg+
JykNCj4+PiAgICAgICBlcnJvcignQ2Fubm90IGVuYWJsZSBUU0FOIGR1ZSB0byBtaXNzaW5n
IGZpYmVyIGFubm90YXRpb24gaW50ZXJmYWNlJykNCj4+PiAgICAgZW5kaWYNCj4+PiAtICBx
ZW11X2NmbGFncyA9IFsnLWZzYW5pdGl6ZT10aHJlYWQnXSArIHFlbXVfY2ZsYWdzDQo+Pj4g
KyAgdHNhbl93YXJuX3N1cHByZXNzID0gW10NCj4+PiArICAjIGdjYyAoPj0xMSkgd2lsbCBy
ZXBvcnQgY29uc3RydWN0aW9ucyBub3Qgc3VwcG9ydGVkIGJ5IHRzYW46DQo+Pj4gKyAgIyAi
ZXJyb3I6IOKAmGF0b21pY190aHJlYWRfZmVuY2XigJkgaXMgbm90IHN1cHBvcnRlZCB3aXRo
IOKAmC1mc2FuaXRpemU9dGhyZWFk4oCZIg0KPj4+ICsgICMgaHR0cHM6Ly9nY2MuZ251Lm9y
Zy9nY2MtMTEvY2hhbmdlcy5odG1sDQo+Pj4gKyAgIyBIb3dldmVyLCBjbGFuZyBkb2VzIG5v
dCBzdXBwb3J0IHRoaXMgd2FybmluZyBhbmQgdGhpcyB0cmlnZ2VycyBhbiBlcnJvci4NCj4+
PiArICBpZiBjYy5oYXNfYXJndW1lbnQoJy1Xbm8tdHNhbicpDQo+Pj4gKyAgICB0c2FuX3dh
cm5fc3VwcHJlc3MgPSBbJy1Xbm8tdHNhbiddDQo+Pj4gKyAgZW5kaWYNCj4+DQo+PiBUaGF0
IGxhc3QgcGFydCBzb3VuZHMgbGlrZSBhIGNsYW5nIGJ1ZyAtLSAtV25vLWZvbyBpcyBzdXBw
b3NlZA0KPj4gdG8gbm90IGJlIGFuIGVycm9yIG9uIGNvbXBpbGVycyB0aGF0IGRvbid0IGlt
cGxlbWVudCAtV2ZvbyBmb3INCj4+IGFueSB2YWx1ZSBvZiBmb28gKHVubGVzcyBzb21lIG90
aGVyIHdhcm5pbmcvZXJyb3Igd291bGQgYWxzbw0KPj4gYmUgZW1pdHRlZCkuDQo+IA0KPiAt
V25vLWZvbyBpc24ndCBhbiBlcnJvciwgYnV0IGl0IGlzIGEgd2FybmluZy4uLiB3aGljaCB3
ZSB0aGVuDQo+IHR1cm4gaW50byBhbiBlcnJvciBkdWUgdG8gLVdlcnJvciwgdW5sZXNzIHdl
IHBhc3MgLVduby11bmtub3duLXdhcm5pbmctb3B0aW9uDQo+IHRvIGNsYW5nLg0KPiANCg0K
UmlnaHQsIGl0J3MgYSBjb25zZXF1ZW5jZS4NCg0KPj4gICAgICAgICAgICAgICAgQXQgYW55
IHJhdGUsIHRoYXQncyBob3cgZ2NjIGRvZXMgaXQNCj4+IChzZWUgdGhlIHBhcmFncmFwaCAi
V2hlbiBhbiB1bnJlY29nbml6ZWQgd2FybmluZyBvcHRpb24gLi4uIg0KPj4gaW4gaHR0cHM6
Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy9XYXJuaW5nLU9wdGlvbnMuaHRtbCApDQo+
PiBhbmQgSSB0aG91Z2h0IGNsYW5nIGRpZCB0b28uLi4NCj4+DQo+PiB0aGFua3MNCj4+IC0t
IFBNTQ0KPj4NCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQo=

