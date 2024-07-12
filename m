Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920E2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 00:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS45V-0001Gf-VS; Thu, 11 Jul 2024 20:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sS45O-0001Fg-R2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 20:24:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sS45M-0000RF-VH
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 20:24:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-706524adf91so1276430b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720743867; x=1721348667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XQ3Gk3vXsdLMr929+ifcTOFfkudWYD1Yd0jG8T/YOnE=;
 b=EVmrPD8Snc47KdnEAtboHwghMwNzEHB/xpWyjVeVHLvnMCc6NlaM3vWoU9K+VubALa
 ckwjW7uNVfDkaQOg33alk70uC5CkFL3+TGUj70UeuTAzlIiWyR1zuozrOc0/kc1jwzEM
 3esuSz+eteHV5jFdGyq+575kAHSQuwSu6a3eNncJ94V7xSdV9XOoOJTeYWDgVp3e1oo/
 IOzuXfmmVEIxsEJnL9nTk+c9rXyzh5ELxjwN0SM9vheBBKe6s+++O+9iE7AlWQESHMhw
 ZNNOEU4oiOTuHvM3qu4+uo/Mm4zgFQ+f6FvtvZlP5C7NNp8efSWl4djmYojuQoskGbsN
 BpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720743867; x=1721348667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XQ3Gk3vXsdLMr929+ifcTOFfkudWYD1Yd0jG8T/YOnE=;
 b=OYKXW4nhSqmyDB9IQojCIxB3UPGJQowNvd4/he9opu6AkuHl3l4rTEtnxPOFWce0Xj
 6NG1f31Bi9xTkynwUj70iKWx2MJ2pHc4srwTYrqPbIJmRSIzMraOPkypVDN+YLKkpzAb
 GcbtrGUoYwP1n3vFUA8SlrsKAU7iN3U6qkL3b763xRzqEeq4do+3klKQnpbjlMXeF1fq
 5Up7tlRCu2uX0TCc5WLtUif4i8z1AHHGlAP9dVDM1+BQwO12gW+BYpqEzIeMhrQrnueV
 7ViyOdDvagdW0aRHXfZ0I1V89nkleUQBEDcb4PWPZWeGPqrxmYIr+ZPccGDPzW9XcIg6
 s2gw==
X-Gm-Message-State: AOJu0YxBBxQoMG7XpVhDYEWo3GQNbxunmormALLZWq44XeQkGVl7amBy
 t00HoLhyCpSSC1NIdaHu4hg78yQE9DPQClE18FTKQvj1zVQYOVfspGq3ldME7aQ=
X-Google-Smtp-Source: AGHT+IHWUOjumdTmqfZ+a7S0QI61nbi23ann3t2eeDLM7tau0K5WwxFEvrJo4uVUaRV0tFXgkLLOog==
X-Received: by 2002:a05:6a00:6c89:b0:705:be21:f2be with SMTP id
 d2e1a72fcca58-70b4356dc65mr11695790b3a.18.1720743867016; 
 Thu, 11 Jul 2024 17:24:27 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b4397e4fesm6251523b3a.152.2024.07.11.17.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 17:24:26 -0700 (PDT)
Message-ID: <0d790d77-062d-4cb6-866e-4ee965d47944@linaro.org>
Date: Thu, 11 Jul 2024 17:24:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] tests/tcg: add mechanism to run specific tests
 with plugins
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-5-pierrick.bouvier@linaro.org>
 <87ikxgtagz.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ikxgtagz.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

T24gNy84LzI0IDA0OjAwLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IE9ubHkg
bXVsdGlhcmNoIHRlc3RzIGFyZSBydW4gd2l0aCBwbHVnaW5zLCBhbmQgd2Ugd2FudCB0byBi
ZSBhYmxlIHRvIHJ1bg0KPj4gcGVyLWFyY2ggdGVzdCB3aXRoIHBsdWdpbnMgdG9vLg0KPj4N
Cj4+IFRlc3RlZC1ieTogWGluZ3RhbyBZYW8gPHlhb3h0LmZuc3RAZnVqaXRzdS5jb20+DQo+
PiBSZXZpZXdlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxp
bmFyby5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmlj
ay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgdGVzdHMvdGNnL01ha2VmaWxl
LnRhcmdldCB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL01ha2VmaWxl
LnRhcmdldCBiL3Rlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXQNCj4+IGluZGV4IGNiOGNmZWI2
ZGFjLi41MjYxNjU0NGQ1MiAxMDA2NDQNCj4+IC0tLSBhL3Rlc3RzL3RjZy9NYWtlZmlsZS50
YXJnZXQNCj4+ICsrKyBiL3Rlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXQNCj4+IEBAIC0xNTIs
MTAgKzE1MiwxMSBAQCBQTFVHSU5TPSQocGF0c3Vic3QgJS5jLCBsaWIlLnNvLCAkKG5vdGRp
ciAkKHdpbGRjYXJkICQoUExVR0lOX1NSQykvKi5jKSkpDQo+PiAgICMgb25seSBleHBhbmQg
TVVMVElBUkNIX1RFU1RTIHdoaWNoIGFyZSBjb21tb24gb24gbW9zdCBvZiBvdXIgdGFyZ2V0
cw0KPj4gICAjIHRvIGF2b2lkIGFuIGV4cG9uZW50aWFsIGV4cGxvc2lvbiBhcyBuZXcgdGVz
dHMgYXJlIGFkZGVkLiBXZSBhbHNvDQo+PiAgICMgYWRkIHNvbWUgc3BlY2lhbCBoZWxwZXJz
IHRoZSBydW4tcGx1Z2luLSBydWxlcyBjYW4gdXNlIGJlbG93Lg0KPj4gKyMgSW4gbW9yZSwg
ZXh0cmEgdGVzdHMgY2FuIGJlIGFkZGVkIHVzaW5nIFBMVUdJTlNfVEVTVFMgdmFyaWFibGUu
DQo+PiAgIA0KPj4gICBpZm5lcSAoJChNVUxUSUFSQ0hfVEVTVFMpLCkNCj4+ICAgJChmb3Jl
YWNoIHAsJChQTFVHSU5TKSwgXA0KPj4gLQkkKGZvcmVhY2ggdCwkKE1VTFRJQVJDSF9URVNU
UyksXA0KPj4gKwkkKGZvcmVhY2ggdCwkKE1VTFRJQVJDSF9URVNUUykgJChQTFVHSU5TX1RF
U1RTKSxcDQo+PiAgIAkJJChldmFsIHJ1bi1wbHVnaW4tJCh0KS13aXRoLSQocCk6ICR0ICRw
KSBcDQo+PiAgIAkJJChldmFsIFJVTl9URVNUUys9cnVuLXBsdWdpbi0kKHQpLXdpdGgtJChw
KSkpKQ0KPj4gICBlbmRpZiAjIE1VTFRJQVJDSF9URVNUUw0KPiANCj4gSSBoYXZlIG5vIHBh
cnRpY3VsYXIgb2JqZWN0aW9uIHRvIGFkZGluZyB0aGlzIChleGNlcHQgYSBtaW5vciBuaXQg
b2YNCj4gbWF5YmUgdGhlIG5hbWUgc2hvdWxkIGJlIEFERElUSU9OQUxfUExVR0lOX1RFU1RT
KS4gSG93ZXZlciB0aGUgdXNlIG9mDQo+IHRoaXMgbGF0ZXIgaXMgZm9yIHRoZSB0ZXN0Og0K
PiANCg0KSSdsbCByZW5hbWUgaXQgdG8gQURESVRJT05BTF9QTFVHSU5fVEVTVFMuDQoNCj4g
ICAgdGVzdHMvdGNnL3g4Nl82NC90ZXN0LXBsdWdpbi1tZW0tYWNjZXNzLmMNCj4gDQo+IGFu
ZCBhc2lkZSBmcm9tIHRoZSBpbmxpbmUgYXNtIEkgZG9uJ3Qgc2VlIHdoeSB0aGlzIGNvdWxk
bid0IGJlIGENCj4gbXVsdGktYXJjaCB0ZXN0LiBDb3VsZCB3ZSBub3QgdXNlIHRoZSBhdG9t
aWMgcHJpbWl0aXZlcyB0byBtYWtlIGl0IG11bHRpYXJjaD8NCj4gDQoNCldpbGwgYW5zd2Vy
IG9uIHJlbGF0ZWQgcGF0Y2guDQo=

