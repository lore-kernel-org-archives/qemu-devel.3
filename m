Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C01CC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 00:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS4HP-0008AP-Ek; Thu, 11 Jul 2024 20:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sS4HO-00089q-0c
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 20:36:54 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sS4HL-0005Xf-F1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 20:36:53 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b0013cf33so1351328b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 17:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720744609; x=1721349409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JsERMz3/k3DenXb11GoFdrVSpCLWNvZI7plrW/yHXAg=;
 b=qqj7Ph4lI5o8+ApBIEZWckIor7uBk+FDBOu4/+CDsNI4qeAhRCCcBYZe2L1iHS2pXv
 o4wYT6aiA/sefyxCeRfYFs2JYSOdsR7iaDvMFsgP8ijwpqVcglmR7IhbHyRAFGuaDCCF
 sS2LvIkrteNiORoleIy1HD3+rXy7XjBjSv/rS37L91zEnp5fD2LvzCV6nAQpIoFYc/dF
 JjVGsMHeol6KMck6/V2Di7P0BYcwKtBaSOUeVcSHYUAEKCAfjlNRFeF2ZgGYC7+UW+P2
 XCaeycYRzJeEFmuW0ewa3EPnoNsMq9vaokT/0mTU/EHeVMu52soBval9pHAKNImGmiAu
 VXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720744609; x=1721349409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JsERMz3/k3DenXb11GoFdrVSpCLWNvZI7plrW/yHXAg=;
 b=KrbYuOMROR+uF49aAheSEaE1Eu1cSBIYMXhml6sNkF7h03Nu5F/mgdDAF3La1C0gMA
 VfXlJhtznobiORHgOAj3/qtmf4VJ18YqN4yFPtFUFLbUOV1QVoCFoXu6QWz6CUNSyo4W
 2MsBHbKThQqXEiTqpuiqtPzdR7UpfbXIGwA9HblgKXYe24vJEqECDA4Nn55m3Xu5Unpn
 3XtjwLunf+NfMzlw3oms/H5Pz+8QQfyuIjZ0rxFehi9K4JadRw1UwPNP8MP9iQvuJioS
 iJv+JyrG3RLxpyVCJ128PE0h68Ew8xWV9hEmnPrK2XKs+VcoQKIrM4oaCMhonQ5hYpUR
 pzew==
X-Gm-Message-State: AOJu0Yw+viOFRRfos2C16jx0kuttYJ+SkXyvXKdzh6eTAL8i4GS6xSQH
 A+Nk93dH6HxYUpSy43osntm4LaOMKiapKbNKE8zeMLsSyI9WFrDYomFljDqkxQU=
X-Google-Smtp-Source: AGHT+IHJzVhBp+mg1LSyfOjfvB3rutaTb0dAFk2TC3y+gryQ3BbKh8ZOn+CwUwtEHJ0vz0P+gW9Mbw==
X-Received: by 2002:a05:6a20:394a:b0:1c0:f17d:d81f with SMTP id
 adf61e73a8af0-1c298220948mr10792726637.21.1720744609378; 
 Thu, 11 Jul 2024 17:36:49 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd3e4a52sm199521a91.19.2024.07.11.17.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 17:36:48 -0700 (PDT)
Message-ID: <3a65b37b-b6d7-459b-b8ca-edd70aa03a72@linaro.org>
Date: Thu, 11 Jul 2024 17:36:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] tests/tcg: allow to check output of plugins
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-6-pierrick.bouvier@linaro.org>
 <878qybuavr.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <878qybuavr.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

T24gNy84LzI0IDA5OjA2LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IEEgc3Bl
Y2lmaWMgcGx1Z2luIHRlc3QgY2FuIG5vdyByZWFkIGFuZCBjaGVjayBhIHBsdWdpbiBvdXRw
dXQsIHRvIGVuc3VyZQ0KPj4gaXQgY29udGFpbnMgZXhwZWN0ZWQgdmFsdWVzLg0KPj4NCj4+
IFRlc3RlZC1ieTogWGluZ3RhbyBZYW8gPHlhb3h0LmZuc3RAZnVqaXRzdS5jb20+DQo+PiBS
ZXZpZXdlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFy
by5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgdGVzdHMvdGNnL01ha2VmaWxlLnRh
cmdldCB8IDcgKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXQgYi90ZXN0
cy90Y2cvTWFrZWZpbGUudGFyZ2V0DQo+PiBpbmRleCA1MjYxNjU0NGQ1Mi4uNmY1MGIwMTc2
ZWEgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0cy90Y2cvTWFrZWZpbGUudGFyZ2V0DQo+PiArKysg
Yi90ZXN0cy90Y2cvTWFrZWZpbGUudGFyZ2V0DQo+PiBAQCAtOTAsNiArOTAsNyBAQCBDRkxB
R1M9DQo+PiAgIExERkxBR1M9DQo+PiAgIA0KPj4gICBRRU1VX09QVFM9DQo+PiArQ0hFQ0tf
UExVR0lOX09VVFBVVF9DT01NQU5EPXRydWUNCj4+ICAgDQo+PiAgIA0KPj4gICAjIElmIFRD
RyBkZWJ1Z2dpbmcsIG9yIFRDSSBpcyBlbmFibGVkIHRoaW5ncyBhcmUgYSBsb3Qgc2xvd2Vy
DQo+PiBAQCAtMTgwLDYgKzE4MSw5IEBAIHJ1bi1wbHVnaW4tJToNCj4+ICAgCQktcGx1Z2lu
ICQoUExVR0lOX0xJQikvJChjYWxsIGV4dHJhY3QtcGx1Z2luLCRAKSQoUExVR0lOX0FSR1Mp
IFwNCj4+ICAgCQktZCBwbHVnaW4gLUQgJCoucG91dCBcDQo+PiAgIAkJICQoY2FsbCBzdHJp
cC1wbHVnaW4sJDwpKQ0KPj4gKwkkKGNhbGwgcXVpZXQtY29tbWFuZCwgJChDSEVDS19QTFVH
SU5fT1VUUFVUX0NPTU1BTkQpICQqLnBvdXQsIFwNCj4+ICsJICAgICAgIFRFU1QsIGNoZWNr
IHBsdWdpbiAkKGNhbGwgZXh0cmFjdC1wbHVnaW4sJEApIG91dHB1dCBcDQo+PiArCSAgICAg
ICB3aXRoICQoY2FsbCBzdHJpcC1wbHVnaW4sJDwpKQ0KPj4gICBlbHNlDQo+PiAgIHJ1bi0l
OiAlDQo+PiAgIAkkKGNhbGwgcnVuLXRlc3QsICQ8LCBcDQo+PiBAQCAtMTk0LDYgKzE5OCw5
IEBAIHJ1bi1wbHVnaW4tJToNCj4+ICAgCSAgIAkgIC1wbHVnaW4gJChQTFVHSU5fTElCKS8k
KGNhbGwgZXh0cmFjdC1wbHVnaW4sJEApJChQTFVHSU5fQVJHUykgXA0KPj4gICAJICAgIAkg
IC1kIHBsdWdpbiAtRCAkKi5wb3V0IFwNCj4+ICAgCQkgICQoUUVNVV9PUFRTKSAkKGNhbGwg
c3RyaXAtcGx1Z2luLCQ8KSkNCj4+ICsJJChjYWxsIHF1aWV0LWNvbW1hbmQsICQoQ0hFQ0tf
UExVR0lOX09VVFBVVF9DT01NQU5EKSAkKi5wb3V0LCBcDQo+PiArCSAgICAgICBURVNULCBj
aGVjayBwbHVnaW4gJChjYWxsIGV4dHJhY3QtcGx1Z2luLCRAKSBvdXRwdXQgXA0KPj4gKwkg
ICAgICAgd2l0aCAkKGNhbGwgc3RyaXAtcGx1Z2luLCQ8KSkNCj4gDQo+IE5vIG5lZWQgdG8g
aGF2ZSBhIG51bGwgdGVzdCwgd2UgY2FuIHdyYXAgdGhlIGNhbGwgaW4gYW4gaWY6DQo+IA0K
PiAtLTg8LS0tLS0tLS0tLS0tLS0tY3V0IGhlcmUtLS0tLS0tLS0tLS0tLS1zdGFydC0tLS0t
LS0tLS0tLS0+OC0tLQ0KPiBtb2RpZmllZCAgIHRlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXQN
Cj4gQEAgLTkwLDcgKzkwLDcgQEAgQ0ZMQUdTPQ0KPiAgIExERkxBR1M9DQo+ICAgDQo+ICAg
UUVNVV9PUFRTPQ0KPiAtQ0hFQ0tfUExVR0lOX09VVFBVVF9DT01NQU5EPXRydWUNCj4gK0NI
RUNLX1BMVUdJTl9PVVRQVVRfQ09NTUFORD0NCj4gICANCj4gICANCj4gICAjIElmIFRDRyBk
ZWJ1Z2dpbmcsIG9yIFRDSSBpcyBlbmFibGVkIHRoaW5ncyBhcmUgYSBsb3Qgc2xvd2VyDQo+
IEBAIC0xODEsOSArMTgxLDEwIEBAIHJ1bi1wbHVnaW4tJToNCj4gICAJCS1wbHVnaW4gJChQ
TFVHSU5fTElCKS8kKGNhbGwgZXh0cmFjdC1wbHVnaW4sJEApJChQTFVHSU5fQVJHUykgXA0K
PiAgIAkJLWQgcGx1Z2luIC1EICQqLnBvdXQgXA0KPiAgIAkJICQoY2FsbCBzdHJpcC1wbHVn
aW4sJDwpKQ0KPiAtCSQoY2FsbCBxdWlldC1jb21tYW5kLCAkKENIRUNLX1BMVUdJTl9PVVRQ
VVRfQ09NTUFORCkgJCoucG91dCwgXA0KPiAtCSAgICAgICBURVNULCBjaGVjayBwbHVnaW4g
JChjYWxsIGV4dHJhY3QtcGx1Z2luLCRAKSBvdXRwdXQgXA0KPiAtCSAgICAgICB3aXRoICQo
Y2FsbCBzdHJpcC1wbHVnaW4sJDwpKQ0KPiArCSQoaWYgJChDSEVDS19QTFVHSU5fT1VUUFVU
X0NPTU1BTkQpLAkJXA0KPiArCQkkKGNhbGwgcXVpZXQtY29tbWFuZCwgJChDSEVDS19QTFVH
SU5fT1VUUFVUX0NPTU1BTkQpICQqLnBvdXQsIFwNCj4gKwkJICAgICAgIFRFU1QsIGNoZWNr
IHBsdWdpbiAkKGNhbGwgZXh0cmFjdC1wbHVnaW4sJEApIG91dHB1dCBcDQo+ICsJICAgICAg
IAkJd2l0aCAkKGNhbGwgc3RyaXAtcGx1Z2luLCQ8KSkpDQo+ICAgZWxzZQ0KPiAgIHJ1bi0l
OiAlDQo+ICAgCSQoY2FsbCBydW4tdGVzdCwgJDwsIFwNCj4gQEAgLTE5OCw5ICsxOTksMTAg
QEAgcnVuLXBsdWdpbi0lOg0KPiAgIAkgICAJICAtcGx1Z2luICQoUExVR0lOX0xJQikvJChj
YWxsIGV4dHJhY3QtcGx1Z2luLCRAKSQoUExVR0lOX0FSR1MpIFwNCj4gICAJICAgIAkgIC1k
IHBsdWdpbiAtRCAkKi5wb3V0IFwNCj4gICAJCSAgJChRRU1VX09QVFMpICQoY2FsbCBzdHJp
cC1wbHVnaW4sJDwpKQ0KPiAtCSQoY2FsbCBxdWlldC1jb21tYW5kLCAkKENIRUNLX1BMVUdJ
Tl9PVVRQVVRfQ09NTUFORCkgJCoucG91dCwgXA0KPiAtCSAgICAgICBURVNULCBjaGVjayBw
bHVnaW4gJChjYWxsIGV4dHJhY3QtcGx1Z2luLCRAKSBvdXRwdXQgXA0KPiAtCSAgICAgICB3
aXRoICQoY2FsbCBzdHJpcC1wbHVnaW4sJDwpKQ0KPiArCSQoaWYgJChDSEVDS19QTFVHSU5f
T1VUUFVUX0NPTU1BTkQpLAkJXA0KPiArCQkkKGNhbGwgcXVpZXQtY29tbWFuZCwgJChDSEVD
S19QTFVHSU5fT1VUUFVUX0NPTU1BTkQpICQqLnBvdXQsIFwNCj4gKwkJICAgICAgIFRFU1Qs
IGNoZWNrIHBsdWdpbiAkKGNhbGwgZXh0cmFjdC1wbHVnaW4sJEApIG91dHB1dCBcDQo+ICsJ
ICAgICAgIAl3aXRoICQoY2FsbCBzdHJpcC1wbHVnaW4sJDwpKSkNCj4gLS04PC0tLS0tLS0t
LS0tLS0tLWN1dCBoZXJlLS0tLS0tLS0tLS0tLS0tZW5kLS0tLS0tLS0tLS0tLS0tPjgtLS0N
Cj4gDQo+PiAgIGVuZGlmDQo+PiAgIA0KPj4gICBnZGItJTogJQ0KPiANCg0KVGhhbmtzLCBJ
IHdhcyBsb29raW5nIGV4YWN0bHkgZm9yIHRoaXMgY29uc3RydWN0aW9uIGluaXRpYWxseSEg
V2lsbCANCmNoYW5nZSB0byB0aGF0Lg0K

