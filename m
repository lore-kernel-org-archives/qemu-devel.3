Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B55C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 16:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUU8B-0007eA-Bx; Thu, 18 Jul 2024 12:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sUU8A-0007bt-PY
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:37:22 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sUU88-00052G-Li
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:37:22 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70b5117ae06so20672b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721320638; x=1721925438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqdi2BHBpEuI4VyEbfEKSvh1dxk1gfu947ZuFjPUVH8=;
 b=xIY5Iz2Ve3l/wETCXQOMd8IEwi5dCtJXt3ShxcRIZz+wj35JwrZcuteYB1Rwp3uwmF
 uJoKIAbFOeMtcIMtOzdFzsw8I3jUSaN6+MQ4snEMqURF5zloDRI3k0/WboMzb8Cn+3b1
 8AmaMbursJ8AJyHmSavPftgTM6aexUxcghUmqHGR6SDMO3VJjwiRZewwWZ2cYMtb3SDa
 B4r1qqugp4YOSu+7VfA0UIjZnl6ZXcwazNMhFc8Ihsr4x49JSwl65pGx0XI5ifSxvG67
 X1juJ4Np2SpVGguHeoEI97tLxfKWw+xvVpvuOgJS2dLuQpKbbbfhSFlkq1uS3LqWVehl
 Ad5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721320638; x=1721925438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqdi2BHBpEuI4VyEbfEKSvh1dxk1gfu947ZuFjPUVH8=;
 b=Q/Opei7CzHqnYT1UWQn1a8AT6QssvkB+THzfxrtoKAeIi1/BeVFQEeyw2LYYhm5Rob
 oZJkQZ3eMI0EUZ8dUkU+4kT63unjyUBv2//eZp2xc850c7eBlSVq6XfsaOClHDXaAkJx
 l95owdjgmdFNqnf4va7wXb5HHI/0xbw8E/rLFE4XKU6fhcH+YpsBSA6aPziC7qnCL9Nb
 ONfYDXex6AJ/gooRZgjCM43AxuTrUraD9o8/G/4Y9ZqZdg/JAl95EnR+gJTCzKA8HJR5
 zdNsxbVmZR0EIKo6yo1W4YYNseRv4iiRo0P9REKPBPGsU0nxO4+EDPV699txPDih6GM7
 K2Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv+k94JYHszzdhdU9BrjAUvin7t/JENpyHXtBvCu0iwM12k8vJWVxl1Bm6krG54LS4MkVkKY0ou42kuPySpajs+RjdeoU=
X-Gm-Message-State: AOJu0YzO76pyYeyWl9ObWpX8CuFgNETEq5fH2piCAt6y+JA8tYLQCnHr
 uzzbVO3bxaqqI+lRE3lyhmrP4NbRraIlO3BwIhKEFu0y52x54JeR3r1jJ9WJxR8=
X-Google-Smtp-Source: AGHT+IFJ+eZLrDTkGJvBiJm9OBAX0l1vKuJDb/lsh3rnxcuBr6/FV5EcJKeBL35tVlwgZh6InfgfsA==
X-Received: by 2002:a05:6a20:8423:b0:1c0:f6d5:be9a with SMTP id
 adf61e73a8af0-1c3fddc4176mr7580639637.36.1721320638318; 
 Thu, 18 Jul 2024 09:37:18 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-790c3ac9811sm5693865a12.52.2024.07.18.09.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 09:37:17 -0700 (PDT)
Message-ID: <0d515c6c-c046-4704-b69a-4b3cf535577c@linaro.org>
Date: Thu, 18 Jul 2024 09:37:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] tests/plugins: use qemu_plugin_outs for inline stats
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
 <20240718094523.1198645-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240718094523.1198645-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

T24gNy8xOC8yNCAwMjo0NSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBVc2luZyBiYXJlIHBy
aW50ZidzIGluIHBsdWdpbnMgaXMgcGVyZmVjdGx5IGFjY2VwdGFibGUgYnV0IHRoZXkgZG8N
Cj4gcmF0aGVyIG1lc3MgdXAgdGhlIG91dHB1dCBvZiAibWFrZSBjaGVjay10Y2ciLiBDb252
ZXJ0IHRoZSBwcmludGZzIHRvDQo+IHVzZSBnX3N0cmluZyBhbmQgdGhlbiBvdXRwdXQgd2l0
aCB0aGUgcGx1Z2luIG91dHB1dCBoZWxwZXIgd2hpY2ggd2lsbA0KPiBhbHJlYWR5IGJlIGNh
cHR1cmVkIHRvIC5wb3V0IGZpbGVzIGJ5IHRoZSB0ZXN0IGhhcm5lc3MuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0t
LQ0KPiAgIHRlc3RzL3BsdWdpbi9pbmxpbmUuYyB8IDU4ICsrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0
aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcGx1
Z2luL2lubGluZS5jIGIvdGVzdHMvcGx1Z2luL2lubGluZS5jDQo+IGluZGV4IGNkNjM4Mjdi
N2QuLjczZGRlOTk1NzggMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3BsdWdpbi9pbmxpbmUuYw0K
PiArKysgYi90ZXN0cy9wbHVnaW4vaW5saW5lLmMNCj4gQEAgLTcxLDEwICs3MSwxMiBAQCBz
dGF0aWMgdm9pZCBzdGF0c19pbnNuKHZvaWQpDQo+ICAgICAgIGNvbnN0IHVpbnQ2NF90IGNv
bmRfdHJhY2tfbGVmdCA9IHFlbXVfcGx1Z2luX3U2NF9zdW0oaW5zbl9jb25kX3RyYWNrX2Nv
dW50KTsNCj4gICAgICAgY29uc3QgdWludDY0X3QgY29uZGl0aW9uYWwgPQ0KPiAgICAgICAg
ICAgY29uZF9udW1fdHJpZ2dlciAqIGNvbmRfdHJpZ2dlcl9saW1pdCArIGNvbmRfdHJhY2tf
bGVmdDsNCj4gLSAgICBwcmludGYoImluc246ICUiIFBSSXU2NCAiXG4iLCBleHBlY3RlZCk7
DQo+IC0gICAgcHJpbnRmKCJpbnNuOiAlIiBQUkl1NjQgIiAocGVyIHZjcHUpXG4iLCBwZXJf
dmNwdSk7DQo+IC0gICAgcHJpbnRmKCJpbnNuOiAlIiBQUkl1NjQgIiAocGVyIHZjcHUgaW5s
aW5lKVxuIiwgaW5sX3Blcl92Y3B1KTsNCj4gLSAgICBwcmludGYoImluc246ICUiIFBSSXU2
NCAiIChjb25kIGNiKVxuIiwgY29uZGl0aW9uYWwpOw0KPiArICAgIGdfYXV0b3B0cihHU3Ry
aW5nKSBzdGF0cyA9IGdfc3RyaW5nX25ldygiIik7DQo+ICsgICAgZ19zdHJpbmdfYXBwZW5k
X3ByaW50ZihzdGF0cywgImluc246ICUiIFBSSXU2NCAiXG4iLCBleHBlY3RlZCk7DQo+ICsg
ICAgZ19zdHJpbmdfYXBwZW5kX3ByaW50ZihzdGF0cywgImluc246ICUiIFBSSXU2NCAiIChw
ZXIgdmNwdSlcbiIsIHBlcl92Y3B1KTsNCj4gKyAgICBnX3N0cmluZ19hcHBlbmRfcHJpbnRm
KHN0YXRzLCAiaW5zbjogJSIgUFJJdTY0ICIgKHBlciB2Y3B1IGlubGluZSlcbiIsIGlubF9w
ZXJfdmNwdSk7DQo+ICsgICAgZ19zdHJpbmdfYXBwZW5kX3ByaW50ZihzdGF0cywgImluc246
ICUiIFBSSXU2NCAiIChjb25kIGNiKVxuIiwgY29uZGl0aW9uYWwpOw0KPiArICAgIHFlbXVf
cGx1Z2luX291dHMoc3RhdHMtPnN0cik7DQo+ICAgICAgIGdfYXNzZXJ0KGV4cGVjdGVkID4g
MCk7DQo+ICAgICAgIGdfYXNzZXJ0KHBlcl92Y3B1ID09IGV4cGVjdGVkKTsNCj4gICAgICAg
Z19hc3NlcnQoaW5sX3Blcl92Y3B1ID09IGV4cGVjdGVkKTsNCj4gQEAgLTkxLDEwICs5Mywx
MiBAQCBzdGF0aWMgdm9pZCBzdGF0c190Yih2b2lkKQ0KPiAgICAgICBjb25zdCB1aW50NjRf
dCBjb25kX3RyYWNrX2xlZnQgPSBxZW11X3BsdWdpbl91NjRfc3VtKHRiX2NvbmRfdHJhY2tf
Y291bnQpOw0KPiAgICAgICBjb25zdCB1aW50NjRfdCBjb25kaXRpb25hbCA9DQo+ICAgICAg
ICAgICBjb25kX251bV90cmlnZ2VyICogY29uZF90cmlnZ2VyX2xpbWl0ICsgY29uZF90cmFj
a19sZWZ0Ow0KPiAtICAgIHByaW50ZigidGI6ICUiIFBSSXU2NCAiXG4iLCBleHBlY3RlZCk7
DQo+IC0gICAgcHJpbnRmKCJ0YjogJSIgUFJJdTY0ICIgKHBlciB2Y3B1KVxuIiwgcGVyX3Zj
cHUpOw0KPiAtICAgIHByaW50ZigidGI6ICUiIFBSSXU2NCAiIChwZXIgdmNwdSBpbmxpbmUp
XG4iLCBpbmxfcGVyX3ZjcHUpOw0KPiAtICAgIHByaW50ZigidGI6ICUiIFBSSXU2NCAiIChj
b25kaXRpb25hbCBjYilcbiIsIGNvbmRpdGlvbmFsKTsNCj4gKyAgICBnX2F1dG9wdHIoR1N0
cmluZykgc3RhdHMgPSBnX3N0cmluZ19uZXcoIiIpOw0KPiArICAgIGdfc3RyaW5nX2FwcGVu
ZF9wcmludGYoc3RhdHMsICJ0YjogJSIgUFJJdTY0ICJcbiIsIGV4cGVjdGVkKTsNCj4gKyAg
ICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKHN0YXRzLCAidGI6ICUiIFBSSXU2NCAiIChwZXIg
dmNwdSlcbiIsIHBlcl92Y3B1KTsNCj4gKyAgICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKHN0
YXRzLCAidGI6ICUiIFBSSXU2NCAiIChwZXIgdmNwdSBpbmxpbmUpXG4iLCBpbmxfcGVyX3Zj
cHUpOw0KPiArICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYoc3RhdHMsICJ0YjogJSIgUFJJ
dTY0ICIgKGNvbmRpdGlvbmFsIGNiKVxuIiwgY29uZGl0aW9uYWwpOw0KPiArICAgIHFlbXVf
cGx1Z2luX291dHMoc3RhdHMtPnN0cik7DQo+ICAgICAgIGdfYXNzZXJ0KGV4cGVjdGVkID4g
MCk7DQo+ICAgICAgIGdfYXNzZXJ0KHBlcl92Y3B1ID09IGV4cGVjdGVkKTsNCj4gICAgICAg
Z19hc3NlcnQoaW5sX3Blcl92Y3B1ID09IGV4cGVjdGVkKTsNCj4gQEAgLTEwNyw5ICsxMTEs
MTEgQEAgc3RhdGljIHZvaWQgc3RhdHNfbWVtKHZvaWQpDQo+ICAgICAgIGNvbnN0IHVpbnQ2
NF90IHBlcl92Y3B1ID0gcWVtdV9wbHVnaW5fdTY0X3N1bShjb3VudF9tZW0pOw0KPiAgICAg
ICBjb25zdCB1aW50NjRfdCBpbmxfcGVyX3ZjcHUgPQ0KPiAgICAgICAgICAgcWVtdV9wbHVn
aW5fdTY0X3N1bShjb3VudF9tZW1faW5saW5lKTsNCj4gLSAgICBwcmludGYoIm1lbTogJSIg
UFJJdTY0ICJcbiIsIGV4cGVjdGVkKTsNCj4gLSAgICBwcmludGYoIm1lbTogJSIgUFJJdTY0
ICIgKHBlciB2Y3B1KVxuIiwgcGVyX3ZjcHUpOw0KPiAtICAgIHByaW50ZigibWVtOiAlIiBQ
Ukl1NjQgIiAocGVyIHZjcHUgaW5saW5lKVxuIiwgaW5sX3Blcl92Y3B1KTsNCj4gKyAgICBn
X2F1dG9wdHIoR1N0cmluZykgc3RhdHMgPSBnX3N0cmluZ19uZXcoIiIpOw0KPiArICAgIGdf
c3RyaW5nX2FwcGVuZF9wcmludGYoc3RhdHMsICJtZW06ICUiIFBSSXU2NCAiXG4iLCBleHBl
Y3RlZCk7DQo+ICsgICAgZ19zdHJpbmdfYXBwZW5kX3ByaW50ZihzdGF0cywgIm1lbTogJSIg
UFJJdTY0ICIgKHBlciB2Y3B1KVxuIiwgcGVyX3ZjcHUpOw0KPiArICAgIGdfc3RyaW5nX2Fw
cGVuZF9wcmludGYoc3RhdHMsICJtZW06ICUiIFBSSXU2NCAiIChwZXIgdmNwdSBpbmxpbmUp
XG4iLCBpbmxfcGVyX3ZjcHUpOw0KPiArICAgIHFlbXVfcGx1Z2luX291dHMoc3RhdHMtPnN0
cik7DQo+ICAgICAgIGdfYXNzZXJ0KGV4cGVjdGVkID4gMCk7DQo+ICAgICAgIGdfYXNzZXJ0
KHBlcl92Y3B1ID09IGV4cGVjdGVkKTsNCj4gICAgICAgZ19hc3NlcnQoaW5sX3Blcl92Y3B1
ID09IGV4cGVjdGVkKTsNCj4gQEAgLTExOCw2ICsxMjQsNyBAQCBzdGF0aWMgdm9pZCBzdGF0
c19tZW0odm9pZCkNCj4gICBzdGF0aWMgdm9pZCBwbHVnaW5fZXhpdChxZW11X3BsdWdpbl9p
ZF90IGlkLCB2b2lkICp1ZGF0YSkNCj4gICB7DQo+ICAgICAgIGNvbnN0IHVuc2lnbmVkIGlu
dCBudW1fY3B1cyA9IHFlbXVfcGx1Z2luX251bV92Y3B1cygpOw0KPiArICAgIGdfYXV0b3B0
cihHU3RyaW5nKSBzdGF0cyA9IGdfc3RyaW5nX25ldygiIik7DQo+ICAgICAgIGdfYXNzZXJ0
KG51bV9jcHVzID09IG1heF9jcHVfaW5kZXggKyAxKTsNCj4gICANCj4gICAgICAgZm9yIChp
bnQgaSA9IDA7IGkgPCBudW1fY3B1cyA7ICsraSkgew0KPiBAQCAtMTM1LDIwICsxNDIsMjEg
QEAgc3RhdGljIHZvaWQgcGx1Z2luX2V4aXQocWVtdV9wbHVnaW5faWRfdCBpZCwgdm9pZCAq
dWRhdGEpDQo+ICAgICAgICAgICAgICAgcWVtdV9wbHVnaW5fdTY0X2dldChpbnNuX2NvbmRf
bnVtX3RyaWdnZXIsIGkpOw0KPiAgICAgICAgICAgY29uc3QgdWludDY0X3QgaW5zbl9jb25k
X2xlZnQgPQ0KPiAgICAgICAgICAgICAgIHFlbXVfcGx1Z2luX3U2NF9nZXQoaW5zbl9jb25k
X3RyYWNrX2NvdW50LCBpKTsNCj4gLSAgICAgICAgcHJpbnRmKCJjcHUgJWQ6IHRiICglIiBQ
Ukl1NjQgIiwgJSIgUFJJdTY0DQo+IC0gICAgICAgICAgICAgICAiLCAlIiBQUkl1NjQgIiAq
ICUiIFBSSXU2NCAiICsgJSIgUFJJdTY0DQo+IC0gICAgICAgICAgICAgICAiKSB8ICINCj4g
LSAgICAgICAgICAgICAgICJpbnNuICglIiBQUkl1NjQgIiwgJSIgUFJJdTY0DQo+IC0gICAg
ICAgICAgICAgICAiLCAlIiBQUkl1NjQgIiAqICUiIFBSSXU2NCAiICsgJSIgUFJJdTY0DQo+
IC0gICAgICAgICAgICAgICAiKSB8ICINCj4gLSAgICAgICAgICAgICAgICJtZW0gKCUiIFBS
SXU2NCAiLCAlIiBQUkl1NjQgIikiDQo+IC0gICAgICAgICAgICAgICAiXG4iLA0KPiAtICAg
ICAgICAgICAgICAgaSwNCj4gLSAgICAgICAgICAgICAgIHRiLCB0Yl9pbmxpbmUsDQo+IC0g
ICAgICAgICAgICAgICB0Yl9jb25kX3RyaWdnZXIsIGNvbmRfdHJpZ2dlcl9saW1pdCwgdGJf
Y29uZF9sZWZ0LA0KPiAtICAgICAgICAgICAgICAgaW5zbiwgaW5zbl9pbmxpbmUsDQo+IC0g
ICAgICAgICAgICAgICBpbnNuX2NvbmRfdHJpZ2dlciwgY29uZF90cmlnZ2VyX2xpbWl0LCBp
bnNuX2NvbmRfbGVmdCwNCj4gLSAgICAgICAgICAgICAgIG1lbSwgbWVtX2lubGluZSk7DQo+
ICsgICAgICAgIGdfc3RyaW5nX3ByaW50ZihzdGF0cywgImNwdSAlZDogdGIgKCUiIFBSSXU2
NCAiLCAlIiBQUkl1NjQNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICIsICUiIFBSSXU2
NCAiICogJSIgUFJJdTY0ICIgKyAlIiBQUkl1NjQNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICIpIHwgIg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgImluc24gKCUiIFBSSXU2
NCAiLCAlIiBQUkl1NjQNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICIsICUiIFBSSXU2
NCAiICogJSIgUFJJdTY0ICIgKyAlIiBQUkl1NjQNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICIpIHwgIg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIm1lbSAoJSIgUFJJdTY0
ICIsICUiIFBSSXU2NCAiKSINCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICJcbiIsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICBpLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgdGIsIHRiX2lubGluZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHRiX2NvbmRf
dHJpZ2dlciwgY29uZF90cmlnZ2VyX2xpbWl0LCB0Yl9jb25kX2xlZnQsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICBpbnNuLCBpbnNuX2lubGluZSwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgIGluc25fY29uZF90cmlnZ2VyLCBjb25kX3RyaWdnZXJfbGltaXQsIGluc25f
Y29uZF9sZWZ0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgbWVtLCBtZW1faW5saW5l
KTsNCj4gKyAgICAgICAgcWVtdV9wbHVnaW5fb3V0cyhzdGF0cy0+c3RyKTsNCj4gICAgICAg
ICAgIGdfYXNzZXJ0KHRiID09IHRiX2lubGluZSk7DQo+ICAgICAgICAgICBnX2Fzc2VydChp
bnNuID09IGluc25faW5saW5lKTsNCj4gICAgICAgICAgIGdfYXNzZXJ0KG1lbSA9PSBtZW1f
aW5saW5lKTsNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJv
dXZpZXJAbGluYXJvLm9yZz4NCg==

