Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BB0CCF9E8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVo8-00039N-IX; Wed, 25 Sep 2024 13:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stVo6-00037w-P8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:28:06 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stVo4-0002yM-SI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:28:06 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2da4e84c198so139844a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727285282; x=1727890082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+GlcJzBhj8xuwWboDHC6Ga0djIrTHTSFQCqmHJwpHc=;
 b=rhwsshmuOqlDJKXg8b3j8x0DyN8Ywury8q/aieDbTK7zku92CF+O2jg6ipWw/jj5j/
 QnhtSqJfrZDgWI3mXGHpD+bwZetvUp1IFAQX1IcHUd6Wychrc7XBw2wU97bob/UiHb53
 hslgc+E5jBepeXprMxp3vPqmbWceH2Zhp4QHzeBYpykdHD5JQuzkZe0/fTyf1QVgn11B
 P/YsdQfgwIZckMj8W/nz9OxMWKKfQKXyeBdkyUUMvRKz3AIpDdYc/XfR+/Q3TmxqwEnm
 KUqKnLMf/y5n2y/htvJHDmbFUbFhjhztIC4WiMUN+8i4dymZ1fbtoknn1HDvBVmexgLS
 C/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285282; x=1727890082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+GlcJzBhj8xuwWboDHC6Ga0djIrTHTSFQCqmHJwpHc=;
 b=cU71gSmqw+0QM+gp1w/SwnyjoMr4u+R96/pQFBDnP1kDKllEzcqeAASPPdg41Lkfdf
 DXLK4dbPibwO1gkhHTXwLruNEwOeenkvdWuOpLtPJpN+GxYt3Wr47XiwYXN4KSSbh854
 XCV7O7kY1SRBIslY2jbqzgGAODo9aQLCxdWQV1UJ2+DGcTCQHNLVba9P16y3cshLY4Ta
 2bsuEUvsqqf/hZ3kb5HqXLq7TxrtA4shOhquO5t8MghWsJdzEgdUAMcexgdGYX7eh79i
 vIWX0O7Rw+XiIjnO01YS/BP/ISK6QzjQLWr8gDgBRgOuSXoC+K9poCeEQCZWuTMSo3rH
 g6Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWupIjAbwReuKhYYDKmcxTYd8YUimUT9kj7t7YgplEBM3/Py1bVbdO7/KmIyAQfxBfvXVLWNbNZYTqS@nongnu.org
X-Gm-Message-State: AOJu0Yyhue1mSe4YDpKlQPwjKqB78L2cMYNzGsIIidQ3XV1BVkKvC6nf
 qAy1RwFIPk2nusp46D+9r6aNdj0c8IFnhBzlRq4ReLV9S4dv+tn9JToKiCjxDi8=
X-Google-Smtp-Source: AGHT+IGLuI1meuwLjIXwGxeMLkCg5+sCPiKLL2EDDdcZ64QB2GGXD+iT7D2LZMueoZolnAqvhbbpoQ==
X-Received: by 2002:a17:90b:4a11:b0:2d8:a672:1869 with SMTP id
 98e67ed59e1d1-2e06afbfe3cmr4276068a91.32.1727285282417; 
 Wed, 25 Sep 2024 10:28:02 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e06e2d3ec2sm1781429a91.56.2024.09.25.10.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 10:28:01 -0700 (PDT)
Message-ID: <8b3732ad-ff9b-40eb-a4d6-46a010f549cd@linaro.org>
Date: Wed, 25 Sep 2024 10:28:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add -build-info and -build-info-json CLI arguments
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240923-feature-build-info-cli-v2-1-66b3462f16a1@linaro.org>
 <ZvGbRWSPPLJDx7BX@redhat.com> <ka5ia.wqlrej2ef9q@linaro.org>
 <ZvJ8JblXVH-kJGi1@redhat.com>
 <CAAjaMXZ8q0is2-7-kjyBs=YsBc03=0R2XcYiR-fp05=bcerD6Q@mail.gmail.com>
 <87setpcl9p.fsf@draig.linaro.org> <ZvKrqCR5L21-6k54@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ZvKrqCR5L21-6k54@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

T24gOS8yNC8yNCAwNTowOCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gVHVl
LCBTZXAgMjQsIDIwMjQgYXQgMDE6MDI6MjZQTSArMDEwMCwgQWxleCBCZW5uw6llIHdyb3Rl
Og0KPj4gTWFub3MgUGl0c2lkaWFuYWtpcyA8bWFub3MucGl0c2lkaWFuYWtpc0BsaW5hcm8u
b3JnPiB3cml0ZXM6DQo+Pg0KPj4+IEhlbGxvIERhbmllbCwNCj4+Pg0KPj4+IE9uIFR1ZSwg
MjQgU2VwdCAyMDI0IGF0IDExOjQ1LCBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gT24gTW9uLCBTZXAgMjMsIDIwMjQgYXQg
MTA6MDk6MzJQTSArMDMwMCwgTWFub3MgUGl0c2lkaWFuYWtpcyB3cm90ZToNCj4+Pj4+IEhl
bGxvIERhbmllbCwNCj4+Pj4+DQo+Pj4+PiBPbiBNb24sIDIzIFNlcCAyMDI0IDE5OjQ1LCAi
RGFuaWVsIFAuIEJlcnJhbmfDqSIgPGJlcnJhbmdlQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+
Pj4+IE9uIE1vbiwgU2VwIDIzLCAyMDI0IGF0IDA5OjA1OjI0QU0gKzAzMDAsIE1hbm9zIFBp
dHNpZGlhbmFraXMgd3JvdGU6DQo+PiA8c25pcD4NCj4+Pj4+PiBpZSwgbG9vayBhIHF1ZXJ5
LWF1ZGlvZGV2cyB0byBkaXNjb3ZlciB3aGF0IGF1ZGlvIGJheGNrZW5kcyBhcmUNCj4+Pj4+
PiBidWlsdC1pbiwgZG9uJ3QgbG9vayBmb3IgQ09ORklHX1hYWCBzZXR0aW5ncyByZWxhdGVk
IHRvIGF1ZGlvLg0KPj4+Pj4+IElmIHRoZXJlIGFyZSBnYXBzIGluIGluZm9ybWF0aW9uIHdl
IGNhbiBxdWVyeSBmcm9tIFFNUCwgd2Ugc2hvdWxkDQo+Pj4+Pj4gYWltIHRvIGNsb3NlIHRo
b3NlIGdhcHMuDQo+Pj4+Pj4NCj4+Pj4+PiBJT1csIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxk
IGV4cG9zZSB0aGlzIGJ1aWxkIGluZm8gaW5mbyBpbiBlaXRoZXINCj4+Pj4+PiBodW1hbiBy
ZWFkYWJsZSBvciBtYWNoaW5lIHJlYWRhYmxlIGZvcm1hdC4NCj4+Pj4+DQo+Pj4+PiBRQVBJ
L1FNUCBpcyBub3QgdGhlIHBlcnNwZWN0aXZlIG9mIHRoaXMgcGF0Y2gsIHRoaXMgaXMgZm9y
IHBlb3BsZSB3aG8gdXNlDQo+Pj4+PiBjdXN0b20tYnVpbHQgKGkuZS4gbm90IGZyb20gYSBk
aXN0cm8pIGJpbmFyaWVzIGFuZCB3YW50IHRvIGJlIGFibGUgdG8NCj4+Pj4+IGlkZW50aWZ5
IGhvdyBpdCB3YXMgYnVpbHQuIExhdW5jaGluZyBhIGJpbmFyeSB0byBxdWVyeSBzdHVmZiBp
cw0KPj4+Pj4gdW5uZWNlc3NhcmlseSBjb21wbGV4IGZvciB0aGlzIHRhc2ssIGFuZCB0aGUg
aW5mbyBpcyBub3QgZ2VuZXJhbGx5DQo+Pj4+PiBpbnRlcmVzdGluZyB0byB0aGUgQVBJIGNv
bnN1bWVycyBhcyB5b3Ugc2FpZC4NCj4+Pj4NCj4+Pj4gTGF1bmNoaW5nIFFFTVUgdG8gdGFs
ayBRTVAgaXMgb3VyIGRlZmluZWQgcHVibGljIEFQSSBmb3IgcXVlcnlpbmcNCj4+Pj4gYW55
dGhpbmcgYWJvdXQgdGhlIGNhcGFiaWxpdGllcyBvZiBRRU1VLiBXZSdyZSB3b3JrZWQgaGFy
ZCB0byBnZXQNCj4+Pj4gYXdheSBmcm9tIHByb3ZpZGluZyBhZC1ob2Mgd2F5cyB0byBxdWVy
eSBRRU1VIGZyb20gdGhlIGNvbW1hbmQNCj4+Pj4gbGluZSBhbmQgZ29pbmcgYmFjayB0byB0
aGF0IGlzIG5vdCBkZXNpcmFibGUuIEl0IG1heSBiZSBzbGlnaHRseQ0KPj4+PiBtb3JlIGNv
bXBsaWNhdGVkLCBidXQgbm90IGJ5IHZlcnkgbXVjaC4NCj4+Pg0KPj4+IEFnYWluLCB0aGlz
IGlzIG5vdCBhICJjYXBhYmlsaXRpZXMgZGlzY292ZXJ5IiBBUEkuIEl0IGxpc3RzIHRoZQ0K
Pj4+IGJ1aWxkLXRpbWUgY29uZmlndXJhdGlvbiBvZiB0aGUgYmluYXJ5LiBQZXJoYXBzIHdl
IGNhbiBleHBvc2UgaXQgaW4gYQ0KPj4+IGRpZmZlcmVudCB3YXkgc28gdGhhdCBwZW9wbGUg
ZG9uJ3QgZW5kIHVwIGNvbmZ1c2VkPw0KPj4NCj4+IEkgdGhpbmsgdGhlIHByb2JsZW0gaXMg
aG93ZXZlciBtdWNoIHdlIG1pZ2h0IHNheSBpdCdzIG5vdCBhIGNhcGFiaWxpdGllcw0KPj4g
ZGlzY292ZXJ5IEFQSSBpdCdzIHZlcnkgZXhpc3RlbmNlIGVuY291cmFnZXMgdXNlcnMgdG8g
dXNlIGl0IGFzIG9uZS4NCj4+DQo+PiBXaGF0IGFib3V0IGEgc2NyaXB0Og0KPj4NCj4+ICAg
IHFlbXUtZ2V0LWJ1aWxkLWluZm8gPC9wYXRoL3RvL3FlbXU+DQo+Pg0KPj4gd2hpY2ggd291
bGQgbGF1bmNoIHRoZSBiaW5hcnkgYW5kIHF1ZXJ5IGl0IG92ZXIgUU1QPyBXb3VsZCB0aGF0
IHdvcms/DQo+IA0KPiBJZiB0aGlzIGlzIHB1cmVseSBhIGRlYnVnZ2luZyBhaWQsIHdlIGNv
dWxkIG1ha2UgdXNlIG9mIEVMRiBub3RlcyB0bw0KPiBqdXN0IHN0aWNrIHRoZSBjb25maWct
aG9zdC5oIGNvbnRlbnQgaW50byB0aGUgYmluYXJ5LiBUaGlzIGhhcyBwcmVjZWRlbnQNCj4g
aW4gc3lzdGVtZCBwYWNrYWdlIG5vdGVzIChodHRwczovL2dpdGh1Yi5jb20vc3lzdGVtZC9w
YWNrYWdlLW5vdGVzKSBhbmQNCj4gaXMgbW9yZSBjbGVhcmx5ICpOT1QqIGFuIGVuZCB1c2Vy
IENMSSBvcHRpb24sIG5vciBhIHB1YmxpYyBBUEkgaW4gUU1QLg0KPiANCj4gUXVlcnlpbmcg
aXMgdGhlbg0KPiANCj4gICAgICBvYmpkdW1wIC1qIC5ub3RlLnFlbXUtY29uZmlnLWggLXMg
L3VzcmJpbi9xZW11LXN5c3RlbS14ODZfNjQNCj4gDQo+IA0KPiBXaXRoIHJlZ2FyZHMsDQo+
IERhbmllbA0KDQpUaGlzIGlzIG5lYXQhDQpATWFub3M6IGl0IHdvdWxkIGJlIGNvbnZlbmll
bnQgdG8gc3RpbGwgaGF2ZSBhIHNjcmlwdCBhcyBBbGV4IG1lbnRpb25lZCwgDQphcyByZW1l
bWJlcmluZyBpbiB3aGljaCBub3RlcyB0aGUgaW5mb3JtYXRpb24gaXMgaGlkZGVuIG1pZ2h0
IGJlIGFubm95aW5nLg0K

