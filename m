Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235F5EE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPMI-00053g-Kp; Wed, 11 Sep 2024 11:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPMG-0004tD-4h
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:34:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPMC-0003jg-Gn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:34:15 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71798661a52so854475b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726068851; x=1726673651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eA+709nEJaGWuuqo4euF6T+QcJULW+fZtN6qnIYUmcY=;
 b=f5O32MIkJ6KkP9fanlNhfHjbKJfGn93vrSaDCVQtgi/vlcqKCcFZ1d/jpIDqejY/7Y
 c8at+J3MN8kW/S5LoJApnY+cljg/Lz/g5FK3UPdlqMzzNA9X39a5sCuyqB07EA4oMcGp
 3M8QnyNdErz7Wy8fDX/CS6h6eSsJItoSjiaYbGZmzXBsLVeZOmMvt4Do7nHrL+NPKhbm
 UWeRr0q90+oCR7apXz8ZFYCcA0K5TkjBWP2rm6W/QjjP+ScQSJZtfMwOSMav0FKmRtbI
 bSu+f979YD1fILtYUsfUAO0FqeAd0KobVKaIrBvcZLvMT3sbBDdbLFb10J42qY/hwlIW
 t79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726068851; x=1726673651;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eA+709nEJaGWuuqo4euF6T+QcJULW+fZtN6qnIYUmcY=;
 b=l5FpvAU2xzuysdFM3MOMSDpuE3G/Klg/He6WjDBhOvP+IU15fZ2mCEouSD4G18euL4
 5xLQGrAf7MthJXA+j5BugtVQE98DWizR3L13tT/xN39qbWdRWSM3xP3kV0srEyukoWii
 jF+Uoy+VQ1pyRSmKFYj/sEUFcTRax1NulcaZAhr1HhoZ892ci604KJMZuXrCyg3IIoLF
 rHyAu96GXFzZ6+kttpq99N37+k/g/I7xh8klh+NhdIYfKnlpHzUUF+laJ02S4f+gzWqF
 0gE6BjquO3bSJ4UFG5iQWwi5JUfo/+by4VZFvODqsS+pGGb3tSqfRNNlZvgVvdwwMdUC
 kJ1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE2ADHRrL/Olo5K4zJV4C5OCjo2D5tCMqdUx+nudo6Cfjah/Xr45bzf14sl79tmqRstO0Y8QAB3hte@nongnu.org
X-Gm-Message-State: AOJu0YxHZq+rIXe7l3PEMMeYxcwMK9E2CqGnVgUZcjhljbUNeuDr1Hcp
 I/6JNqmeZKI9CppHQ5gLH7NKl4ojoezoG8Zir1CS4BPMm01FN6QgSHzaIwy2htU=
X-Google-Smtp-Source: AGHT+IFppOMwSoql1QLOJ+22ancIMUpNoJdbhH59Q3aBWEWte2FEb8Yn5UIVH+O8hp1Oz/TnqhIL4A==
X-Received: by 2002:a05:6a00:2f9b:b0:718:d4e4:a10a with SMTP id
 d2e1a72fcca58-71907ea941emr10052359b3a.4.1726068850740; 
 Wed, 11 Sep 2024 08:34:10 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm3222002b3a.93.2024.09.11.08.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 08:34:10 -0700 (PDT)
Message-ID: <b58a2188-3652-4a7a-af10-c7f32b2c6f62@linaro.org>
Date: Wed, 11 Sep 2024 08:34:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/39] Use g_assert_not_reached instead of
 (g_)assert(0,false)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <cd6c5970-9a1c-4d58-b8af-483909c3c0ca@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cd6c5970-9a1c-4d58-b8af-483909c3c0ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gOS8xMS8yNCAwMTozOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDExLzkvMjQgMDA6MTUsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+IA0KPj4gUGllcnJp
Y2sgQm91dmllciAoMzkpOg0KPj4gICAgIGRvY3Mvc3BpbjogcmVwbGFjZSBhc3NlcnQoMCkg
d2l0aCBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpDQo+PiAgICAgaHcvYWNwaTogcmVwbGFjZSBh
c3NlcnQoMCkgd2l0aCBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpDQo+PiAgICAgaHcvYXJtOiBy
ZXBsYWNlIGFzc2VydCgwKSB3aXRoIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkNCj4+ICAgICBo
dy9jaGFyOiByZXBsYWNlIGFzc2VydCgwKSB3aXRoIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkN
Cj4+ICAgICBody9jb3JlOiByZXBsYWNlIGFzc2VydCgwKSB3aXRoIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCkNCj4+ICAgICBody9uZXQ6IHJlcGxhY2UgYXNzZXJ0KDApIHdpdGggZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKQ0KPj4gICAgIGh3L3dhdGNoZG9nOiByZXBsYWNlIGFzc2VydCgw
KSB3aXRoIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkNCj4+ICAgICBtaWdyYXRpb246IHJlcGxh
Y2UgYXNzZXJ0KDApIHdpdGggZ19hc3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4gICAgIHFvYmpl
Y3Q6IHJlcGxhY2UgYXNzZXJ0KDApIHdpdGggZ19hc3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4g
ICAgIHN5c3RlbTogcmVwbGFjZSBhc3NlcnQoMCkgd2l0aCBnX2Fzc2VydF9ub3RfcmVhY2hl
ZCgpDQo+PiAgICAgdGFyZ2V0L3BwYzogcmVwbGFjZSBhc3NlcnQoMCkgd2l0aCBnX2Fzc2Vy
dF9ub3RfcmVhY2hlZCgpDQo+PiAgICAgdGVzdHMvcXRlc3Q6IHJlcGxhY2UgYXNzZXJ0KDAp
IHdpdGggZ19hc3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4gICAgIHRlc3RzL3VuaXQ6IHJlcGxh
Y2UgYXNzZXJ0KDApIHdpdGggZ19hc3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4gICAgIGluY2x1
ZGUvaHcvczM5MHg6IHJlcGxhY2UgYXNzZXJ0KGZhbHNlKSB3aXRoIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCkNCj4+ICAgICBibG9jazogcmVwbGFjZSBhc3NlcnQoZmFsc2UpIHdpdGggZ19h
c3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4gICAgIGh3L2h5cGVydjogcmVwbGFjZSBhc3NlcnQo
ZmFsc2UpIHdpdGggZ19hc3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4gICAgIGh3L25ldDogcmVw
bGFjZSBhc3NlcnQoZmFsc2UpIHdpdGggZ19hc3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4gICAg
IGh3L252bWU6IHJlcGxhY2UgYXNzZXJ0KGZhbHNlKSB3aXRoIGdfYXNzZXJ0X25vdF9yZWFj
aGVkKCkNCj4+ICAgICBody9wY2k6IHJlcGxhY2UgYXNzZXJ0KGZhbHNlKSB3aXRoIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCkNCj4+ICAgICBody9wcGM6IHJlcGxhY2UgYXNzZXJ0KGZhbHNl
KSB3aXRoIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkNCj4+ICAgICBtaWdyYXRpb246IHJlcGxh
Y2UgYXNzZXJ0KGZhbHNlKSB3aXRoIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkNCj4+ICAgICB0
YXJnZXQvaTM4Ni9rdm06IHJlcGxhY2UgYXNzZXJ0KGZhbHNlKSB3aXRoIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCkNCj4+ICAgICB0ZXN0cy9xdGVzdDogcmVwbGFjZSBhc3NlcnQoZmFsc2Up
IHdpdGggZ19hc3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4gICAgIGFjY2VsL3RjZzogcmVtb3Zl
IGJyZWFrIGFmdGVyIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkNCj4+ICAgICBibG9jazogcmVt
b3ZlIGJyZWFrIGFmdGVyIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkNCj4+ICAgICBody9hY3Bp
OiByZW1vdmUgYnJlYWsgYWZ0ZXIgZ19hc3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4gICAgIGh3
L2dwaW86IHJlbW92ZSBicmVhayBhZnRlciBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpDQo+PiAg
ICAgaHcvbWlzYzogcmVtb3ZlIGJyZWFrIGFmdGVyIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkN
Cj4+ICAgICBody9uZXQ6IHJlbW92ZSBicmVhayBhZnRlciBnX2Fzc2VydF9ub3RfcmVhY2hl
ZCgpDQo+PiAgICAgaHcvcGNpLWhvc3Q6IHJlbW92ZSBicmVhayBhZnRlciBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpDQo+PiAgICAgaHcvc2NzaTogcmVtb3ZlIGJyZWFrIGFmdGVyIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCkNCj4+ICAgICBody90cG06IHJlbW92ZSBicmVhayBhZnRlciBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpDQo+PiAgICAgdGFyZ2V0L2FybTogcmVtb3ZlIGJyZWFr
IGFmdGVyIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkNCj4+ICAgICB0YXJnZXQvcmlzY3Y6IHJl
bW92ZSBicmVhayBhZnRlciBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpDQo+PiAgICAgdGVzdHMv
cXRlc3Q6IHJlbW92ZSBicmVhayBhZnRlciBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpDQo+PiAg
ICAgdWk6IHJlbW92ZSBicmVhayBhZnRlciBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpDQo+PiAg
ICAgZnB1OiByZW1vdmUgYnJlYWsgYWZ0ZXIgZ19hc3NlcnRfbm90X3JlYWNoZWQoKQ0KPj4g
ICAgIHRjZy9sb29uZ2FyY2g2NDogcmVtb3ZlIGJyZWFrIGFmdGVyIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCkNCj4+ICAgICBzY3JpcHRzL2NoZWNrcGF0Y2gucGw6IGVtaXQgZXJyb3Igd2hl
biB1c2luZyBhc3NlcnQoZmFsc2UpDQo+IA0KPiBJJ20gcXVldWluZyByZXZpZXdlZCBwYXRj
aGVzIDQsNSw3LDEwLDI3LDI4LDMwLDM2IHNvIHlvdSBkb24ndA0KPiBoYXZlIHRvIGNhcnJ5
IHRoZW0gaW4gdjIuDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gUGhpbC4NCg0KSnVzdCBmb3Ig
dGhlIHNha2Ugb2Ygc2ltcGxpY2l0eSwgYW5kIHRvIG5vdCBtaXNzIGFueXRoaW5nIChvbiBt
eSBzaWRlKSwgDQpJJ2xsIGtlZXAgdGhvc2UgaW4gdjIuIFdoZW4gcmViYXNpbmcsIG9uY2Ug
bWVyZ2VkIG9uIG1hc3RlciwgdGhleSB3aWxsIA0KYmUgc2tpcHBlZCBhdXRvbWF0aWNhbGx5
Lg0KDQpUaGFua3MsDQpQaWVycmljaw0K

