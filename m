Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E003D15DB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2uln-0006RC-NJ; Mon, 21 Oct 2024 11:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2ulj-0006Qr-Sh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:56:32 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2uli-0001Da-2g
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:56:31 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ea79711fd4so3174874a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729526188; x=1730130988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kpbGSa6HGcceZxL53Z/Wqh7calC+0RtAMlPE6Wm9uwU=;
 b=LoioXiXjTnpsXyP2Oi63iiBYHjXr7wlY4fl3ryhwMBuv/VoZ67jD77Eu9/dw70R39h
 /39p2/JWh/hDNSBmqsnN/UY50mR6CYwMvibmSiBlOkSZCN/Ore57E8q61io7fUCA+lde
 svhlMsCij2jCK3b9DNqKUVRQQtWTEyYbsZsFGdvr59rMR20ut6EirN3C2ReCm6POnbkD
 cSHskJ78R31BA5V5g4UBiG8JYBwBWQUl5+cYChBAVLslPuIEQ/ABh/HqzNV4agA0mHql
 itoCLWR7oAIQbgVEmM1WKf5tVOuAMLad2tcCMtnS2zwtOVVJo7i1kJkF1JKOGX9pQwkG
 gMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729526188; x=1730130988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kpbGSa6HGcceZxL53Z/Wqh7calC+0RtAMlPE6Wm9uwU=;
 b=Iw67BqnL9OyNu89iSPRsAXnEx0RWq3J+H97qgwM8A/mWwER7WEQEydevnORGJgHJZ2
 Gks7yj7fbH0Q9okr+1McGfzxTTsQbevkBLrQuUWEfr3x6G4G6rd6QpJ+uhhqfsApOL4h
 U6BT4KtF0T9+kr1PoxeOCAeejzp5Lmcoaf1+lWJHfLo87/79P5Fm2glIkvW7R7qZWf+H
 K/lL8fr/wRGVGUX+1EA52AiqXLHXg2NDrcdgzRS5yj8xIVI7MNBocfDuPwVVEqylGFVO
 VmRV3N17VKEcADIayeEXa7F8mBdn8A90lMborWiSLwl9Wh5Yg90gECWi0P8jedkU+PVv
 Eudg==
X-Gm-Message-State: AOJu0YyZUTcvygIBFLPoR/KPinylOeKfr8x6XXy6yylXtZTLbgR2mDp5
 yIuqArXr2yrCOm6O4t1PLq7qeEUQAdlRliHxysikQ+xJKQscJJJWyeqpm/SX71BYWuRlX4D+xM5
 FvqnChI/A
X-Google-Smtp-Source: AGHT+IFRx93pkRJBwM9k2SFxq+kVGvADz3k1LXfNrTh5wlS0XiXN+LhZyuoUzSZdEh+jnprJqUX+ZQ==
X-Received: by 2002:a05:6a21:330b:b0:1d9:61:e783 with SMTP id
 adf61e73a8af0-1d92c5890f0mr15095346637.36.1729526187793; 
 Mon, 21 Oct 2024 08:56:27 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab583d9sm3267585a12.49.2024.10.21.08.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 08:56:27 -0700 (PDT)
Message-ID: <7eaf2db4-596e-4786-9fbc-8bb6bb363565@linaro.org>
Date: Mon, 21 Oct 2024 08:56:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins: fix qemu_plugin_reset
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241015003819.984601-1-pierrick.bouvier@linaro.org>
 <87msixoiv0.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87msixoiv0.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

T24gMTAvMjEvMjQgMDM6MjIsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gMzRl
NWUxIHJlZmFjdG9yZWQgdGhlIHBsdWdpbiBjb250ZXh0IGluaXRpYWxpemF0aW9uLiBBZnRl
ciB0aGlzIGNoYW5nZSwNCj4+IHRjZ19jdHgtPnBsdWdpbl9pbnNuIGlzIG5vdCByZXNldCBp
bmNvbmRpdGlvbm5hbGx5IGFueW1vcmUsIGJ1dCBvbmx5IGlmDQo+PiBvbmUgcGx1Z2luIGF0
IGxlYXN0IGlzIGFjdGl2ZS4NCj4+DQo+PiBXaGVuIHVuaW5zdGFsbGluZyB0aGUgbGFzdCBw
bHVnaW4gYWN0aXZlLCB3ZSBzdG9wcGVkIHJlaW5pdGlhbGl6aW5nDQo+PiB0Y2dfY3R4LT5w
bHVnaW5faW5zbiwgd2hpY2ggbGVhZHMgdG8gbWVtb3J5IGNhbGxiYWNrcyBiZWluZyBlbWl0
dGVkLg0KPj4gVGhpcyByZXN1bHRzIGluIGFuIGVycm9yIGFzIHRoZXkgZG9uJ3QgYXBwZWFy
IGluIGEgcGx1Z2luIG9wIHNlcXVlbmNlIGFzDQo+PiBleHBlY3RlZC4NCj4+DQo+PiBUaGUg
Y29ycmVjdCBmaXggaXMgdG8gbWFrZSBzdXJlIHdlIHJlc2V0IHBsdWdpbiB0cmFuc2xhdGlv
biB2YXJpYWJsZXMNCj4+IGFmdGVyIGN1cnJlbnQgYmxvY2sgdHJhbnNsYXRpb24gZW5kcy4g
VGhpcyB3YXksIHdlIGNhbiBjYXRjaCBhbnkNCj4+IHBvdGVudGlhbCBtaXN1c2Ugb2YgdGhv
c2UgYWZ0ZXIgYSBnaXZlbiBibG9jaywgaW4gbW9yZSB0aGFuIGZpeGluZyB0aGUNCj4+IGN1
cnJlbnQgYnVnLg0KPj4NCj4+IHYyOiBkbyBub3QgcmVzZXQgdGNnX2N0eC0+cGx1Z2luX3Ri
IGFzIGl0IGdldHMgcmV1c2VkIGJldHdlZW4NCj4+IHRyYW5zbGF0aW9ucy4NCj4gDQo+IEZv
ciByZWZlcmVuY2UgcHV0IHZlcnNpb24gaW5mb3JtYXRpb24gYmVsbG93DQo+IA0KPiAtLS0N
Cj4gDQo+IGFuZCB0aGVuIHRoZSBnaXQgdG9vbHMgd2lsbCB0cmltIGl0IG91dCBvZiB0aGUg
Y29tbWl0IG1lc3NhZ2UuDQo+IA0KPiBRdWV1ZWQgdG8gcGx1Z2lucy9uZXh0LCB0aGFua3Mu
DQo+IA0KDQpUaGFua3MsIEkgd2FzIG5vdCBzdXJlIGhvdyB0byBkZWFsIHdpdGggdmVyc2lv
bmluZyBmb3IgaW5kaXZpZHVhbCANCnBhdGNoZXMg8J+RjS4NCg0KPj4NCj4+IEZpeGVzOiBo
dHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMjU3MA0KPj4g
UmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KPj4gLS0tDQo+PiAgIGFjY2VsL3RjZy9wbHVnaW4tZ2Vu
LmMgfCA0ICsrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9hY2NlbC90Y2cvcGx1Z2luLWdlbi5jIGIvYWNjZWwvdGNnL3Bs
dWdpbi1nZW4uYw0KPj4gaW5kZXggMmVlNGMyMmJlZmQuLjBmNDdiZmJiNDg5IDEwMDY0NA0K
Pj4gLS0tIGEvYWNjZWwvdGNnL3BsdWdpbi1nZW4uYw0KPj4gKysrIGIvYWNjZWwvdGNnL3Bs
dWdpbi1nZW4uYw0KPj4gQEAgLTQ2Nyw0ICs0NjcsOCBAQCB2b2lkIHBsdWdpbl9nZW5fdGJf
ZW5kKENQVVN0YXRlICpjcHUsIHNpemVfdCBudW1faW5zbnMpDQo+PiAgIA0KPj4gICAgICAg
LyogaW5qZWN0IHRoZSBpbnN0cnVtZW50YXRpb24gYXQgdGhlIGFwcHJvcHJpYXRlIHBsYWNl
cyAqLw0KPj4gICAgICAgcGx1Z2luX2dlbl9pbmplY3QocHRiKTsNCj4+ICsNCj4+ICsgICAg
LyogcmVzZXQgcGx1Z2luIHRyYW5zbGF0aW9uIHN0YXRlIChwbHVnaW5fdGIgaXMgcmV1c2Vk
IGJldHdlZW4gYmxvY2tzKSAqLw0KPj4gKyAgICB0Y2dfY3R4LT5wbHVnaW5fZGIgPSBOVUxM
Ow0KPj4gKyAgICB0Y2dfY3R4LT5wbHVnaW5faW5zbiA9IE5VTEw7DQo+PiAgIH0NCj4gDQo=


