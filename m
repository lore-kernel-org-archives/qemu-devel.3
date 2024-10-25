Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701AAD149EF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 20:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Qha-0006OF-SA; Fri, 25 Oct 2024 16:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QhQ-0006Do-0q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:14:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QhN-0001m4-Ug
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:14:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20cceb8d8b4so13666865ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729887256; x=1730492056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SltKOQQlLsCnj/IuYuUDuweGkDCs+hr7S/e3vrOBwDw=;
 b=NY2x8DvD5EJPY+7ejHmgKfi1xSKoM3mw1KDjf2p1BWSqPvn3KKByIW72/jTYOeCSmP
 OtyiU4dvJDmoNf/ORLpoTq7GNmVNsE0ATOSb/s4dpqfxWP972djXLYO+aUDx6nG+JfGH
 /kfwrRvOzf+f6S1+/Y14LA+nuIeuUpDsEJAxlG6FpSwL8bNVk7Q1OiYGfKbzliSQA3od
 p1P7dBLIaQJeLaMrW6KWuaAd5grNd/c7cnHHP6+GUVgL2pxgrl/NkqsKLheZ1zy6B/yE
 YUcF0YqNG/x43qNGMen88BP5omlqSJQF77XEcaCUuuLmXuyz1XoNHUgyQ2TEBeJhuyS7
 RleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729887256; x=1730492056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SltKOQQlLsCnj/IuYuUDuweGkDCs+hr7S/e3vrOBwDw=;
 b=bxbD7Ja4dw/aiJsC5RjyRpiKx4hoNhZa1N9HYlnpOy9JiIliUxXSpokbAOemRx9CBu
 40u95yxhRoJV3F4M279kMoUGeTgB37ZP+014hzY0KGnmjI094UPoKl5yQpdClWgy6LBa
 43CPn9SwIXnMdXlS+O6hLzyLVRW3ZzPTUJTn37V2VABGZyPknyKw5M8uilmFyksNGrys
 +O2lBFeOlcRlaEG0uw/iGZYfJF/El2QbBbrP9Esf8Dwin6xpYZjivJxNabiGNxlTB7al
 QoFsSP4Til4wAolQCttX9sB/5HreGr44FCjR8jBjY028Hw6R/K4xQMSw7atMK8QzBh1B
 tGNg==
X-Gm-Message-State: AOJu0Yw+JHVEiydA/5zX5dGRX17oMA7VqDK/Jytzh6gAgWoZ/Ly4P0Zg
 k01y75upsV354GcuhJUaC6DIdMGqKkhpwrSERljyub9QNx5q2sYL0jHJ4dAODnI=
X-Google-Smtp-Source: AGHT+IEdq4HWEZt0y+sK5HlT75jJ9Pfx5YW0yyg7JNj/o2iYzqJuGelBL8wk5hBYX8Y+uAoTBtm18w==
X-Received: by 2002:a17:902:f693:b0:20c:5d5a:af6f with SMTP id
 d9443c01a7336-210c599a1f3mr9895535ad.10.1729887256606; 
 Fri, 25 Oct 2024 13:14:16 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc044f00sm13083415ad.260.2024.10.25.13.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 13:14:15 -0700 (PDT)
Message-ID: <20e6ac63-3580-4472-a6c4-b43df2ca3269@linaro.org>
Date: Fri, 25 Oct 2024 13:14:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/23] dockerfiles: install bindgen from cargo on Ubuntu
 22.04
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Junjie Mao <junjie.mao@hotmail.com>,
 "P. Berrange, Daniel" <berrange@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-23-pbonzini@redhat.com>
 <580f10bc-4d37-4ece-b9d8-496ba66b7966@linaro.org>
 <CABgObfbhJLeAon9rfpSpFG4cwDvCEMnK+1tkmOR5-+mkSdGOUQ@mail.gmail.com>
 <91bedb1f-8c66-4dac-ae1f-bbf0769293b6@linaro.org>
 <CABgObfZAccOxgDDGcgM9nNWbg5rTng-eddLGY60=Bdn2FVzcOQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfZAccOxgDDGcgM9nNWbg5rTng-eddLGY60=Bdn2FVzcOQ@mail.gmail.com>
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

T24gMTAvMjUvMjQgMTM6MDgsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IA0KPiANCj4gSWwg
dmVuIDI1IG90dCAyMDI0LCAyMTo0NyBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmcgDQo+IDxtYWlsdG86cGllcnJpY2suYm91dmllckBsaW5hcm8ub3Jn
Pj4gaGEgc2NyaXR0bzoNCj4gDQo+ICAgICAgPsKgwqBpbiB0aGUgZW5kIHRoZSBvcGVyYXRp
b24gb2YgYmluZGdlbiBpcyBxdWl0ZSBkZXRlcm1pbmlzdGljLCBzbyBpZg0KPiAgICAgID4g
dGhlIGNvdmVyYWdlIGlzIGltcHJvdmVkIHdlIGNhbiBpbmRlZWQgaW5zdGFsbCAwLjYwLngu
IEZvcg0KPiAgICAgZXhhbXBsZSwgaWYNCj4gICAgICA+IHdlIHRoaW5rIHRoYXQgdXNlciBv
biBEZWJpYW4gMTIgbWlnaHQgdXNlIGRpc3RybyBiaW5kZ2VuIHRvZ2V0aGVyDQo+ICAgICB3
aXRoIGENCj4gICAgICA+IHJlY2VudCBydXN0YyAoaW4gdGhlaXIgY2FzZSwgcnVzdHVwLWlu
c3RhbGxlZCksIHRoZW4gaW5zdGFsbGluZw0KPiAgICAgYmluZGdlbg0KPiAgICAgID4gMC42
MC54IG9uIFVidW50dSB3b3VsZCBwcm92aWRlIGEgc2ltaWxhciBlZmZlY3QuDQo+ICAgICAg
Pg0KPiANCj4gICAgIEkgbWlzc2VkIHRoYXQgdGhlIGRlYmlhbiBqb2IgY292ZXJzIHRoaXMg
dXNlIGNhc2UuIFNvIGluZGVlZCwgd2UgY2FuDQo+ICAgICB1c2UNCj4gICAgIGEgcmVjZW50
IG9uZSBvbiB1YnVudHUuDQo+IA0KPiAgICAgV2hlcmUgaXMgdGhlIGNoYW5nZSBmb3IgdGhl
IGRlYmlhbiBjb250YWluZXI/DQo+IA0KPiANCj4gSGVyZTogDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDEwMTUxMzM5MjUuMzExNTg3LTItYmVycmFuZ2VA
cmVkaGF0LmNvbS8gPGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDEw
MTUxMzM5MjUuMzExNTg3LTItYmVycmFuZ2VAcmVkaGF0LmNvbS8+DQo+IA0KDQpHb29kLiBB
cyB0aGVyZSBpcyBubyBiYXNlZC1vbiB0YWcgaW4gdGhlIGNvdmVyIGxldHRlciwgSSBleHBl
Y3RlZCB0aGlzIA0KdG8gYXBwbHkgb24gY3VycmVudCBtYXN0ZXIuDQoNCj4gV2l0aG91dCB0
aGlzIHNlcmllcywgdGhhdCBwYXRjaCB3YXMgYWxyZWFkeSBpbnN0YWxsaW5nIGJpbmRnZW4g
YW5kIHJ1c3RjIA0KPiB0byB0ZXN0IHRoYXQgLS1lbmFibGUtcnVzdCB3YXMgbm90IGVuYWJs
ZWQgaW1wbGljaXRseS4NCj4gDQo+IFBhb2xvDQo+IA0KPiAgICAgID4gT24gdGhlIG90aGVy
IGhhbmQgSSBleHBlY3QgdGhhdCB1c2VycyB3aWxsIGp1c3QgZG8gImNhcmdvIGluc3RhbGwN
Cj4gICAgICA+IGJpbmRnZW4tY2xpIiwgYW5kIFVidW50dSBpcyBhIHByZXR0eSBjb21tb24g
ZGlzdHJvLCBzbyB0aGF0J3Mgd2hhdCBJDQo+ICAgICAgPiB3ZW50IGZvciBoZXJlLg0KPiAN
Cj4gICAgIEl0J3MgYSByZWFzb25hYmxlIGV4cGVjdGF0aW9uIGluZGVlZC4NCj4gDQo=

