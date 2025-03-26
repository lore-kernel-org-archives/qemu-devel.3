Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FFEC3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txShQ-00010G-Bi; Wed, 26 Mar 2025 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txShI-0000yV-Dp
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:40 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txShA-0005kC-QU
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:38 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227a8cdd241so22622285ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002970; x=1743607770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6E3MsxkTjq+tdQAcO9NZzROiyEx+bKy7et/+xK1c40=;
 b=rCPBXy9oDe0ZlVZsswT6wuX7xcBX2ucfF59mYiOT1404qVi6jpdyIs9bluDpd3bLtK
 +JsX2nGdW4fRF8SJEuCuqPUaav3C7b1KWKxjTivTvvGhJsXuURKoToZI6cupaXBzF5Wd
 2HbIDk3vlwit10ZHcZO7ehsw+2CsUAu+L+F+QGDeeeYdSFHiCoRYBc2NWcFIf8Ift1ej
 Uc0dTo/SejZIz/YYMp2ztgkk1LJ0YFBIuUrkx+aGvLiVmUbCYDfVdxERDaZK4ojx6LH/
 bojvcO0aPZwZWMfT06N0t84wuVfitXF/4AMIJP1HyLBoyj0j2NwQB5yX+IyfcTjG0JFs
 Y+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002970; x=1743607770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O6E3MsxkTjq+tdQAcO9NZzROiyEx+bKy7et/+xK1c40=;
 b=UYMtk6tMo+m/DQnPk3beq1VONFZ22rejHCuCtq3NYrXgyoOxt8AdLL2d1ANq1Zy37D
 axgwg3a/El9VU5DdVGSGHd6t6sc1VWpbfICEPeN3G1peOTvZR2vWfxKWJpkEtdK18YuE
 tomHopc6pNAOPTzZlR7vF/4KAY+htvr5xLk08nW9jq+Pu+NvyHhpiLiMIS2HoOOcHK1L
 lUiuTQRqdgppqaIITQDW6x3tS9p349wfvutEUCkL0+QkNRvR2kikzhAk0S/ezG3p7TEQ
 s97Mv4Zw5scprU84RssmWJ0QdhWiAr+45vA+JRyfbYCjV2lOpKEyyZokItOWZ+dFNwYl
 N1NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL+3G3LGnZzCZlJydhqVFBY7jie3UnmruVNRB3CwZePZOfB3tW86IwvdtHYJoD8l64pM/ZWQdbTJwW@nongnu.org
X-Gm-Message-State: AOJu0Yzn7uVlPyDdGFoqvwZJlA43GfPgP2H5jA6IptuVicvnM1n/ctYC
 vln+Bs80gwMKZghaeIGEeggaIhl3Ldr5Is+u8s9kNZogPB3LE5gtAM3yWVxU6Ps=
X-Gm-Gg: ASbGncv9Rv/vnlEuA2pIQ2rMAs7wmcT+yMhSOnvhuNhXiOxalbkvg9cChLj/4EGwaFS
 WTUxMfDuE+02zN2dB3aHfYGk4oskAp/sQPN1buM2Jymk/BVAFy1sWoinl4Vz1xldtNDnBl/hM0m
 rzAvNrYQKBbbt/G1M/6TiWbZcKg2sEEpAwmPvCEHqthTLPUjmbKXKDxrvwl4ZqDACLBhlWo/zK1
 4osUS+8P+sBqyeGDamIfjQvA9bvR7gAg4VuxqfgAXpKQmUbDcaCgOF4N9fG77fcUSHRP5VgFfLB
 91P4FF5yqbZI/PA6v3UvPd0azJRdP/LJF7TfTzdOvTfUxuvJ+zZTG0XdvA==
X-Google-Smtp-Source: AGHT+IHap3X7W6blFkpkoc9rURas261A7fi+LW1UZ0XGhZah38z+pFeaBKW+0Xr+yTNNq5zkGiGJVA==
X-Received: by 2002:a17:902:d48b:b0:21f:52e:939e with SMTP id
 d9443c01a7336-22780d8ff5bmr337496485ad.28.1743002969679; 
 Wed, 26 Mar 2025 08:29:29 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:29 -0700 (PDT)
Message-ID: <9109ce8a-f857-4a4c-b12d-6127a75b0399@linaro.org>
Date: Wed, 26 Mar 2025 08:29:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 8/8] target/mips: Introduce
 mips_env_64bit_enabled() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250325154058.92735-1-philmd@linaro.org>
 <20250325154058.92735-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325154058.92735-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMy8yNS8yNSAwODo0MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IG1p
cHNfZW52XzY0Yml0X2VuYWJsZWQoKSByZXR1cm5zIHdoZXRoZXIgdGhlIENQVSBpcyBydW5u
aW5nDQo+IGluIDMyLWJpdCBvciA2NC1iaXQgKGJlaGF2aW9yIHdoaWNoIG1pZ2h0IGNoYW5n
ZSBhdCBydW50aW1lKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgdGFyZ2V0L21pcHMvaW50
ZXJuYWwuaCB8IDUgKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L21pcHMvaW50ZXJuYWwuaCBiL3RhcmdldC9t
aXBzL2ludGVybmFsLmgNCj4gaW5kZXggMjhlYjI4OTM2YmEuLjgxMDdhNTliOTA4IDEwMDY0
NA0KPiAtLS0gYS90YXJnZXQvbWlwcy9pbnRlcm5hbC5oDQo+ICsrKyBiL3RhcmdldC9taXBz
L2ludGVybmFsLmgNCj4gQEAgLTIyNSw2ICsyMjUsMTEgQEAgc3RhdGljIGlubGluZSB2b2lk
IG1pcHNfZW52X3NldF9wYyhDUFVNSVBTU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIHZhbHVl
KQ0KPiAgICAgICB9DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIGlubGluZSBib29sIG1pcHNf
ZW52XzY0Yml0X2VuYWJsZWQoQ1BVTUlQU1N0YXRlICplbnYpDQo+ICt7DQo+ICsgICAgcmV0
dXJuIGVudi0+aGZsYWdzICYgTUlQU19IRkxBR182NDsNCj4gK30NCj4gKw0KPiAgIHN0YXRp
YyBpbmxpbmUgYm9vbCBtaXBzX2Vudl9pc19iaWdlbmRpYW4oQ1BVTUlQU1N0YXRlICplbnYp
DQo+ICAgew0KPiAgICAgICByZXR1cm4gZXh0cmFjdDMyKGVudi0+Q1AwX0NvbmZpZzAsIENQ
MEMwX0JFLCAxKTsNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNr
LmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

