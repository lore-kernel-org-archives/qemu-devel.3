Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BF7C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdHK-0003UO-Ng; Fri, 07 Mar 2025 14:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdGQ-00011y-I0
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:21:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdGO-0008Jm-Lr
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:21:42 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22435603572so11817575ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375299; x=1741980099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6CRQvV/IrhP6tOwCqvKLV9ntEizODFkOvWlcJ3hDMrQ=;
 b=Xql/N/66Aufdd1R0iqdinAKeYM5id3FBclXpi5E/z2f9buuiiROxT5nvyF2PZJFKhr
 xdNIRXLan6zOedIHcmiLT6Wgp+u9PPa4y7GvOAUO6/4xgaf7emK+BZiyEQq8dWT3CGYP
 aTggwZLnX+nMJfaeFEI9behkv9e0jhTO96+40D9S7ZA6KSUrJIB78WiGOPI4FLFCsQtm
 9t4AJzwwCGKgyL1D57n4HIYigI1s/CvyZoB1a+UPuF9VP24u5UI4Bet7LnEwaHEgfU9y
 w4MJ0u4luemkC+JLY9vA4DXipKzuwH0KnsP5sE9O1itgvrPdgsSexEQ8rPVZ0YGDWW3o
 nEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375299; x=1741980099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6CRQvV/IrhP6tOwCqvKLV9ntEizODFkOvWlcJ3hDMrQ=;
 b=ook3B/LpfKWtVgN5hwia2cg0CqeKwZcbjcNd+BBVn/DXXIU/HGdqFia7p07I6VetEb
 PfLTgNzMEo/hjtu+EqIjN6RzDXrb48kLZqxpoCRa5t1MFIYti/kl8C798jCemzbHsbvt
 y+gbVaE+/e+koy0JVWOlhPQKVcW7crDCLXa8+unm6lyGUmSxUA0HOjn6C3XZ8ADvXDuW
 m3E7CvZIh2SyB2N+qw/s2B/zin5mNSCr/EkPeFa9OX+FRZ8FKgps3OHj/2o7sQYPpP0J
 CHsn1PNi/+PGafj+GOiZQlSydbSUVhs5TxbvzxV2qo7mru7NltbYYZ1j5/50WPUuGcP0
 JzTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrMHDs3P2x8MGCiSAk1vCiBtb8cM6NDi8kk+gko577GnuD5ZMn5YTrEKnJKTqG18Ge4dv7Ac8pFPZG@nongnu.org
X-Gm-Message-State: AOJu0Yw9MVFvalqs3NLYOFX4MMvCEArB/pMJJRGk6WALNZVjHxccupP1
 zSsbLrhaDvq427XLdIqwKGINU274Qelokb126oFL48I+UzooikNlKbsmV5JA/hk=
X-Gm-Gg: ASbGncv+mCKIcKDQrHpOy9uZOhPh63Jdhy+1VJsIp10+P2bV79BUd+ysSzYtc+uW4ZC
 In3e2DE7qNYlxK6xgdlmebo7kWwVv6MuOoPgTvAxO0YhCziJdVeRuj1yamXz93ZAlDfn6REJ20L
 IHQ0hcnFYhUxyN8uV5FAkRezc2m29hp5L2zP9EX9VyRulpeEXpL6F+vRWZ2eQoyvoWqhE9WdjVq
 pyw5rP+GzxL173hkJJVieo352pAVbUIno3MKEQZccR3fhkz6iEFyVIwF+0GgomfPjE1XVk1VLmd
 fYtuZiq9Aj66RvSSVEyXzkCYXsl4O53JW0v82mQ/8mHhmHSYTktRYwJuXQ==
X-Google-Smtp-Source: AGHT+IE+fjRgYIeRU3un/vA0q8/mTKknBzAwYFFPgdhm8AToQqHSbS365WGnt98CsDC1qtuumft3Tw==
X-Received: by 2002:a17:902:ec90:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-22428a9fdcemr70727115ad.25.1741375299139; 
 Fri, 07 Mar 2025 11:21:39 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91c0asm33970955ad.201.2025.03.07.11.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:21:38 -0800 (PST)
Message-ID: <79266711-f219-49fb-b629-0e5344bd385e@linaro.org>
Date: Fri, 7 Mar 2025 11:21:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/virtio/virtio-mem: Remove CONFIG_DEVICES include
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307151543.8156-5-philmd@linaro.org>
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

T24gMy83LzI1IDA3OjE1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gUmF0
aGVyIHRoYW4gY2hlY2tpbmcgQUNQSSBhdmFpbGFiaWxpdHkgYXQgY29tcGlsZSB0aW1lIGJ5
DQo+IGNoZWNraW5nIHRoZSBDT05GSUdfQUNQSSBkZWZpbml0aW9uIGZyb20gQ09ORklHX0RF
VklDRVMsDQo+IGNoZWNrIGF0IHJ1bnRpbWUgdmlhIGFjcGlfYnVpbHRpbigpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8u
b3JnPg0KPiAtLS0NCj4gICBody92aXJ0aW8vdmlydGlvLW1lbS5jIHwgNiArKy0tLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8tbWVtLmMgYi9ody92aXJ0aW8vdmly
dGlvLW1lbS5jDQo+IGluZGV4IDdiMTQwYWRkNzY1Li41ZjU3ZWNjYmI2NiAxMDA2NDQNCj4g
LS0tIGEvaHcvdmlydGlvL3ZpcnRpby1tZW0uYw0KPiArKysgYi9ody92aXJ0aW8vdmlydGlv
LW1lbS5jDQo+IEBAIC0yOCw3ICsyOCw3IEBADQo+ICAgI2luY2x1ZGUgIm1pZ3JhdGlvbi9t
aXNjLmgiDQo+ICAgI2luY2x1ZGUgImh3L2JvYXJkcy5oIg0KPiAgICNpbmNsdWRlICJody9x
ZGV2LXByb3BlcnRpZXMuaCINCj4gLSNpbmNsdWRlIENPTkZJR19ERVZJQ0VTDQo+ICsjaW5j
bHVkZSAiaHcvYWNwaS9hY3BpLmgiDQo+ICAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ICAgDQo+
ICAgc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX3ZpcnRpb19tZW1f
ZGV2aWNlX2Vhcmx5Ow0KPiBAQCAtODgzLDEwICs4ODMsOCBAQCBzdGF0aWMgdWludDY0X3Qg
dmlydGlvX21lbV9nZXRfZmVhdHVyZXMoVmlydElPRGV2aWNlICp2ZGV2LCB1aW50NjRfdCBm
ZWF0dXJlcywNCj4gICAgICAgTWFjaGluZVN0YXRlICptcyA9IE1BQ0hJTkUocWRldl9nZXRf
bWFjaGluZSgpKTsNCj4gICAgICAgVmlydElPTUVNICp2bWVtID0gVklSVElPX01FTSh2ZGV2
KTsNCj4gICANCj4gLSAgICBpZiAobXMtPm51bWFfc3RhdGUpIHsNCj4gLSNpZiBkZWZpbmVk
KENPTkZJR19BQ1BJKQ0KPiArICAgIGlmIChtcy0+bnVtYV9zdGF0ZSAmJiBhY3BpX2J1aWx0
aW4oKSkgew0KPiAgICAgICAgICAgdmlydGlvX2FkZF9mZWF0dXJlKCZmZWF0dXJlcywgVklS
VElPX01FTV9GX0FDUElfUFhNKTsNCj4gLSNlbmRpZg0KPiAgICAgICB9DQo+ICAgICAgIGFz
c2VydCh2bWVtLT51bnBsdWdnZWRfaW5hY2Nlc3NpYmxlICE9IE9OX09GRl9BVVRPX0FVVE8p
Ow0KPiAgICAgICBpZiAodm1lbS0+dW5wbHVnZ2VkX2luYWNjZXNzaWJsZSA9PSBPTl9PRkZf
QVVUT19PTikgew0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KDQo=

