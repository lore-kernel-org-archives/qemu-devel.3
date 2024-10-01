Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13682CEACEA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svgBk-0001bp-RD; Tue, 01 Oct 2024 12:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svgBQ-0001Fm-2B
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:57:11 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svgBO-0008CW-6n
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:57:07 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e26d148991so4028569b6e.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801825; x=1728406625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9K26eAWpFzCtgx7TP1tqa2ef3xpXuNU688WzvLxpEM4=;
 b=zucLpiEgQZKzrQqFcd5bRdggrv/+B+Ig3j8TCMsKQ0PxJOYuZv+hoI/YtmvjID73RK
 fq4dvYpf2lVAC1qC1wxahO7Mbu8CIxurxSRcbRJacTnXjNLBvPic34OnZ0Q7FIMo9SAK
 7rJGrpUk/AFguu5OgZmhoq5vAn5LChfegE1H3ZuzXzL9uk0PvbQX57KsZNS8dfVWj1Vr
 h5Ndz+kaAGhkKNoyLxytgBUGbSbq9zqiZl/uN7HzBnLmQbVOXhnFV2HpRaqIpb1PMJGq
 J5EbRPJt6Md2n1xw1poT1SeWQeOo09+JbbDEcTdNlFYDP/q2GeRKDLTa6f0vLGJg+V29
 O4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801825; x=1728406625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9K26eAWpFzCtgx7TP1tqa2ef3xpXuNU688WzvLxpEM4=;
 b=dxLA1pYlkqxybnuV4FXNftE4BTqe+JpWBa6lepsm6nTng7vr7dblWygn3B503eto2E
 /ItbfbqPf6FYS20cKpqBA1vqsFj7/WoF+dBgeconR8Gzl1tmPjsKmAL+876pyTwkc2jt
 YN2D2z0iGLhx9JMJqXy8qJZiGFD8UeTDWMl72crTBPYPUxtjQA3VzP7iyroXMTSbVBp0
 v2krgAXvDdoLE/wGN9w3ngitFitmopeJdcWOqj/+pQ0ymkjzHsQeqyxhV223nLKETxLN
 aS6B3filfPZPUc79WisTZxAvid6HOgBRXBTkbzmu8EjiqKlYFIeWJvzlnekVl3uHmmsK
 U2mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6GNntnv+H3IGGJcVY/oMQhkX5N1B4eyUES8jD2Nl8ZNQAYW/MFMkllDCnTVbhI3JFvlcm/c7DQqAq@nongnu.org
X-Gm-Message-State: AOJu0Yw0t4GHI59Kk0Qzh/hrTkeYXD6OpNWkcg3thZuGYEZfA7q3lf6v
 Pgqq3jwXJnxkI5GmWhn6+yYYHG5Y9Lfc6/BiFCEsQIQ+v21/bt1Ix48xuz0jhPc=
X-Google-Smtp-Source: AGHT+IH2dp9fdxumN68lPcohwDx3nAiFYxoJAwviJ80Zmiizg+2nuaO5niRJhroAqpwVoJsn2YneaQ==
X-Received: by 2002:a05:6808:22ac:b0:3e2:8698:5a74 with SMTP id
 5614622812f47-3e3b40e8c17mr579037b6e.5.1727801824712; 
 Tue, 01 Oct 2024 09:57:04 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6db17c3b8sm8734994a12.0.2024.10.01.09.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:57:04 -0700 (PDT)
Message-ID: <8cade88a-ec3b-43f0-8445-48846ece5e0f@linaro.org>
Date: Tue, 1 Oct 2024 09:57:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] hw/pci/pci_device: Introduce ld/st_endian_pci_dma()
 API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-13-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oi1-x232.google.com
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

T24gOS8zMC8yNCAwMDozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElu
dHJvZHVjZSB0aGUgbGQvc3RfZW5kaWFuX3BjaV9kbWEoKSBBUEksIHdoaWNoIHRha2VzIGFu
IGV4dHJhDQo+IGJvb2xlYW4gYXJndW1lbnQgdG8gZGlzcGF0Y2ggdG8gbGQvc3Rfe2JlLGxl
fV9wY2lfZG1hKCkgbWV0aG9kcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+IFRPRE86IFVwZGF0
ZSBkb2NzdHJpbmcgcmVnZXhwDQo+IC0tLQ0KPiAgIGluY2x1ZGUvaHcvcGNpL3BjaV9kZXZp
Y2UuaCB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpX2Rldmlj
ZS5oDQo+IGluZGV4IGZmNjE5MjQxYTQuLmRjOWIxN2RkZWQgMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaA0KPiArKysgYi9pbmNsdWRlL2h3L3BjaS9wY2lf
ZGV2aWNlLmgNCj4gQEAgLTMwMCw3ICszMDAsMjkgQEAgc3RhdGljIGlubGluZSBNZW1UeFJl
c3VsdCBwY2lfZG1hX3dyaXRlKFBDSURldmljZSAqZGV2LCBkbWFfYWRkcl90IGFkZHIsDQo+
ICAgDQo+ICAgI2RlZmluZSBQQ0lfRE1BX0RFRklORV9MRFNUX0VORChfbCwgX3MsIF9iaXRz
KSBcDQo+ICAgICAgIFBDSV9ETUFfREVGSU5FX0xEU1QoX2wjI19sZSwgX3MjI19sZSwgX2Jp
dHMpIFwNCj4gLSAgICBQQ0lfRE1BX0RFRklORV9MRFNUKF9sIyNfYmUsIF9zIyNfYmUsIF9i
aXRzKQ0KPiArICAgIFBDSV9ETUFfREVGSU5FX0xEU1QoX2wjI19iZSwgX3MjI19iZSwgX2Jp
dHMpIFwNCj4gKyAgICBzdGF0aWMgaW5saW5lIE1lbVR4UmVzdWx0IGxkIyNfbCMjX2VuZGlh
bl9wY2lfZG1hKGJvb2wgaXNfYmlnX2VuZGlhbiwgXA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJRGV2aWNlICpkZXYsIFwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRtYV9hZGRyX3QgYWRkciwgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludCMjX2JpdHMjI190ICp2YWwsIFwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IE1lbVR4QXR0cnMgYXR0cnMpIFwNCj4gKyAgICB7IFwNCj4gKyAgICAgICAgQWRkcmVzc1Nw
YWNlICpwY2lfYXMgPSBwY2lfZ2V0X2FkZHJlc3Nfc3BhY2UoZGV2KTsgXA0KPiArICAgICAg
ICByZXR1cm4gaXNfYmlnX2VuZGlhbiBcDQo+ICsgICAgICAgICAgICAgICA/IGxkIyNfbCMj
X2JlX2RtYShwY2lfYXMsIGFkZHIsIHZhbCwgYXR0cnMpIFwNCj4gKyAgICAgICAgICAgICAg
IDogbGQjI19sIyNfbGVfZG1hKHBjaV9hcywgYWRkciwgdmFsLCBhdHRycyk7IFwNCj4gKyAg
ICB9IFwNCj4gKyAgICBzdGF0aWMgaW5saW5lIE1lbVR4UmVzdWx0IHN0IyNfcyMjX2VuZGlh
bl9wY2lfZG1hKGJvb2wgaXNfYmlnX2VuZGlhbiwgXA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJRGV2aWNlICpkZXYsIFwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRtYV9hZGRyX3QgYWRkciwgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludCMjX2JpdHMjI190IHZhbCwgXA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
TWVtVHhBdHRycyBhdHRycykgXA0KPiArICAgIHsgXA0KPiArICAgICAgICBBZGRyZXNzU3Bh
Y2UgKnBjaV9hcyA9IHBjaV9nZXRfYWRkcmVzc19zcGFjZShkZXYpOyBcDQo+ICsgICAgICAg
IHJldHVybiBpc19iaWdfZW5kaWFuIFwNCj4gKyAgICAgICAgICAgICAgID8gc3QjI19zIyNf
YmVfZG1hKHBjaV9hcywgYWRkciwgdmFsLCBhdHRycykgXA0KPiArICAgICAgICAgICAgICAg
OiBzdCMjX3MjI19sZV9kbWEocGNpX2FzLCBhZGRyLCB2YWwsIGF0dHJzKTsgXA0KPiArICAg
IH0NCj4gICANCj4gICBQQ0lfRE1BX0RFRklORV9MRFNUKHViLCBiLCA4KTsNCj4gICBQQ0lf
RE1BX0RFRklORV9MRFNUX0VORCh1dywgdywgMTYpDQoNClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

