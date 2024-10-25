Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A5CD149EE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 20:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4QgF-0004J0-FE; Fri, 25 Oct 2024 16:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QgC-0004Ih-OK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:13:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QgB-0001e7-2Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:13:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c803787abso19199375ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729887181; x=1730491981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=esZSJuyFIbSO/os1ckzBEMtis0pcbxv0TgyRBTQhA+0=;
 b=tJSOyPnh+oXbjPEkVanaqcnoDyFI9xFVkasAqhetWND2omERXVSya1W9fn70ImCz+b
 M/j0wVsA6O6vw1/jP6/3BLL1bmglvkbUFvElUmmWm8YrrK2QIgdqn964xZiFVDjgBbSI
 Adx/Idv7m2kMvkaQyYw1ktFuRtCZQTM0//DeqnAjiu+1Ok9vGivRU6RfQGtyTJu6ihxo
 7aBxnf7DD/2YHnWRip4CjQF7ARYqe5oD9nhrzBDGmPlnCTNwskRlL8tzbNKIxSq3iiu2
 uEvMTCl6EHh85YAtjBExnXPKNToL6bplTbFwTmghu+eDwJmALQ3IQdeuFv6T1rZAReoR
 dyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729887181; x=1730491981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=esZSJuyFIbSO/os1ckzBEMtis0pcbxv0TgyRBTQhA+0=;
 b=kfzFm2HySqL6PaIX6H5r8JOJJdTit6HmOVCW0gKj+RKUWu8WhVO6h54wbGuSYbzdUy
 rGKlzMZgmml0vWI1O0jXMvQHyTSXAbpddOVPiqkD1d79sRdiONaaxgUOW/xTzcftmW2Z
 XaE45yvu/d361KaO/OcBfg/kZaYSB8Ig7uSOSXH259C41rWyLHAM473Pqdv35HZYt25u
 uI7A2RF5tl6XpHXCDMdz4Il5oeGd1ARHVI903Xohv5V3HHq2jMAGIEhTfaLC78Mu5y7K
 CpMUGFSlfEzrShUHBayRitaCYiuxbUcrL1Xx/c2r5l5mDkxQGhCKB99j4hACPWRGL8oh
 LnrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/oorcz89ICo811UrT74zeUb6WOcdw2LYsgu7BF+7KqtiP/z/E1A0FhHshCToU9N3eAZzi7CxRQ7NX@nongnu.org
X-Gm-Message-State: AOJu0YwbPjGiZ0sVfWkxfxvCspepXr1W2FZZwBcv6Tvi3gylEZydDgOB
 y1HZq5+nZavVPyTvysZw/9Wa6oI2dCY3dYTQRroG0jfsk8SWnM6/9hBpFGV1w/I=
X-Google-Smtp-Source: AGHT+IE47F3eLt5oAhTylB9mlM42HD8PYc3hvr0/bkznp8MHy1zieC8KvNbdrge8P1jmnGbWvzKiBw==
X-Received: by 2002:a17:902:d2c8:b0:20a:fd4e:fef6 with SMTP id
 d9443c01a7336-20fb88d5d7fmr98701305ad.8.1729887181491; 
 Fri, 25 Oct 2024 13:13:01 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc02df82sm13048565ad.189.2024.10.25.13.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 13:13:00 -0700 (PDT)
Message-ID: <ffeebb55-a3da-4676-acf5-186d9b861691@linaro.org>
Date: Fri, 25 Oct 2024 13:12:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] rust: do not use --generate-cstr
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-20-pbonzini@redhat.com>
 <b86de87b-99f3-4fce-9a33-3580d37d90dc@tls.msk.ru>
 <3a0a5685-8c8b-46ad-8933-0fff8715f47d@linaro.org>
 <89bfa733-4496-4128-bace-94099b96a9db@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <89bfa733-4496-4128-bace-94099b96a9db@tls.msk.ru>
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

T24gMTAvMjUvMjQgMTM6MTAsIE1pY2hhZWwgVG9rYXJldiB3cm90ZToNCj4gMjUuMTAuMjAy
NCAyMzowNiwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IE9uIDEwLzI1LzI0IDEzOjAz
LCBNaWNoYWVsIFRva2FyZXYgd3JvdGU6DQo+Pj4gMjUuMTAuMjAyNCAxOTowMiwgUGFvbG8g
Qm9uemluaSB3cm90ZToNCj4+Pj4gLS1nZW5lcmF0ZS1jc3RyIGlzIGEgZ29vZCBpZGVhIGFu
ZCBnZW5lcmFsbHkgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLA0KPj4+PiBidXQgaXQgaXMgbm90
IGF2YWlsYWJsZSBpbiBEZWJpYW4gMTIgYW5kIFVidW50dSAyMi4wNC7CoCBXb3JrIGFyb3Vu
ZA0KPj4+PiB0aGUgYWJzZW5jZS4NCj4+Pg0KPj4+IENhbid0IHdlIGp1c3QgaW5zdGFsbCBh
IG1vcmUgcmVjZW50IGJpbmRnZW4gYW5kIHVzZSBhbGwgdGhlIGN1cnJlbnQNCj4+PiBmZWF0
dXJlcyBvZiBpdCwgbGlrZSBpdCdzIGRvbmUgaW4gcGF0Y2ggMjIgZm9yIHVidW50dT8NCj4+
DQo+PiBVc2VycyB5ZXMsIGJ1dCBkaXN0cm9zIGV4cGVjdCB0byBiZSBhYmxlIHRvIHVzZSB0
aGVpciBwYWNrYWdlZCB2ZXJzaW9uLg0KPiANCj4gUHJldHR5IHBsZWFzZSBkbyBub3QgdGFy
Z2V0IHJ1c3QgaW4gcWVtdSBmb3IgKmN1cnJlbnRseSogc3VwcG9ydGVkDQo+IGRpc3Ryb3Mu
ICBGb3IgZGViaWFuIGJvb2t3b3JtIGl0IGlzIGFscmVhZHkgd2F5IHRvbyBsYXRlLCAtIGZv
cg0KPiBib29rd29ybSBhcyBhIGRpc3RybywgcWVtdSB3aXRoIHJ1c3QgaXMgaG9wZWxlc3Ms
IGl0IGlzIHBvc3NpYmxlDQo+IG9ubHkgd2l0aCB0cml4aWUgYW5kIHVwLg0KPiANCj4gVXNl
cnMgd2lzaGluZyB0byBleHBlcmltZW50IGNhbiBpbnN0YWxsIG1vcmUgcmVjZW50IHBhY2th
Z2VzLCBmb3INCj4gcWVtdSBjaSBpdCBpcyB0aGUgd2F5IHRvIGdvIHRvbyB1c2luZyB0aGUg
d2F5IGluIHBhdGNoIDIyLCBhbmQgdGhhdCdzDQo+IGl0LiAgVGhlcmUncyBubyBuZWVkIHRv
IHNhY3JpZmljZSBxZW11IHJ1c3QgY29kZSBmb3IgY3VycmVudCBkZWJpYW4NCj4gc3RhYmxl
LiAgcnVzdCBpcyBhbHJlYWR5IHRvbyB2b2xhdGlsZSBieSBpdHMgb3duLCBhbmQgdGFyZ2V0
aW5nDQo+IHRoYXQgd2lkZSByYW5nZSBvZiB2ZXJzaW9ucyBpcyBpbnNhbmUuDQo+IA0KDQpJ
dCdzIHRoZSBnb2FsIG9mIHRoaXMgc2VyaWVzLCBhbmQgd2l0aCBjaGFuZ2VzIGluY2x1ZGVk
LCBpdCBjYW4gYmUgYnVpbHQgDQpvbiBkZWJpYW4gc3RhYmxlICh3aXRoIHBhY2thZ2VkIHJ1
c3RjL2JpbmRnZW4pLg0KDQo+IC9tanQNCj4gDQo=

