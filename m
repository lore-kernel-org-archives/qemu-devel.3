Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C807DD0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJIq-0001rq-VH; Fri, 11 Oct 2024 13:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1szJB6-0002zL-5p
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:11:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1szJB2-0003ed-3G
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:11:45 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c8c50fdd9so12474265ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728666702; x=1729271502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QUd54pwP6EOP85eXh652Wvn0CGawhBfeKi1JF6erDvM=;
 b=gKMzsHOyuhCM3Jcr+hPPa6bsyRR7OKw4nYZgYY6mm0+/P0rBa9AS2xLdE/wTK446wX
 BCe9r7pOR59+V18eSd5/0CHPZdkdFx+MCwcMaQyd6EwK99H8WCk7jgIUe2vXJS7KHL6r
 p0pdnJbTDjizym31j4uuQRTgW4dX3WkJS8O3SeZ/QzYh6MuJhcwJMi7Yet6GrEHiVErZ
 HiQOUFGZwpJYzdr+UbSlva7TI2sp4Kc7gdky+7y0/6ts7YjRAy0zIkK6GdnJeM2idUFr
 Os9szwi88ykwsutRhilactLNBKLzpF4yriqP5qk6rW2b+4Jr+5VgBYqscDatN6qd+4Ou
 rxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728666702; x=1729271502;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QUd54pwP6EOP85eXh652Wvn0CGawhBfeKi1JF6erDvM=;
 b=B/lSgysnzcxhI8advNIypoIxSN8w1Qg6eeCmHxZNKn630vBSASDLmdHfjLlDCcsXGZ
 An1M23HFeiv+hMOkP/mZhPLW4Lv/IuXr0w3k/55mvUS5CAIKVzlSj/5LF9YDygHF8t8g
 eymVgnKe6eZm+g053Fa+0N600hd5hiOM2+zyhR08lOtM9UtnY5lrXXAinqhCqV4jyPZP
 Ft3hIkUjT83lCwgNlWZSbjL4lOMAqxE3NNlLoX+oRvYogFTccRuQgSLLPR16nC2LlvYr
 omBXhox1EL0TYIRV9R8j7QsV46Z1UR8X6D3004M6EULsuOce1iTUC7rglfY+K/NIRrNe
 NuvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN+LdHnRGcg2PtzsUvT38l4CYiYwrCRDgbxK4rqzqmCyMaJgUNixDtZx2FaczGl2uwDbIjiDnbO9nq@nongnu.org
X-Gm-Message-State: AOJu0Yz3SfKSbKRJQaGIAl3e2aDnMZnkluZujPeKrfIlMeTifZYbmxFM
 9z3U0+RB+cqARLQHtV7fd58lxe4nYtcb+cR8kUgN4xhFakKUVKJLxGwnnWNQFq8=
X-Google-Smtp-Source: AGHT+IED2bKFmKdbYhleXZOGeq15z7OlNbu8/1LgCpFybidz/O1f2+E9d+BurdJ3Y/JjUv9K3oMyWA==
X-Received: by 2002:a17:902:f647:b0:205:8b84:d5e8 with SMTP id
 d9443c01a7336-20ca03a6a5cmr47347055ad.18.1728666701850; 
 Fri, 11 Oct 2024 10:11:41 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc0d3c4sm25441765ad.91.2024.10.11.10.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 10:11:41 -0700 (PDT)
Message-ID: <748172c0-a157-414e-a3ac-baa91b600b34@linaro.org>
Date: Fri, 11 Oct 2024 10:11:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/23] accel/tcg: Replace victim_tlb_hit with tlbtree_hit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-15-richard.henderson@linaro.org>
 <a55f268b-ca9c-49b9-b6f2-8bb9c0b966d0@linaro.org>
 <79708a5a-be2b-486e-91ba-9c39e1dab3fc@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <79708a5a-be2b-486e-91ba-9c39e1dab3fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

DQoNCk9uIDEwLzEwLzI0IDEyOjI5LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4gT24g
MTAvOS8yNCAxNzoxMCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+PiArc3RhdGljIGJv
b2wgdGxidHJlZV9oaXQoQ1BVU3RhdGUgKmNwdSwgaW50IG1tdV9pZHgsDQo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTU1VQWNjZXNzVHlw
ZSBhY2Nlc3NfdHlwZSwgdmFkZHIgYWRkcikNCj4+PiAgwqAgew0KPj4+IC3CoMKgwqAgc2l6
ZV90IHZpZHg7DQo+Pj4gK8KgwqDCoCBDUFVUTEJEZXNjICpkZXNjID0gJmNwdS0+bmVnLnRs
Yi5kW21tdV9pZHhdOw0KPj4+ICvCoMKgwqAgQ1BVVExCRGVzY0Zhc3QgKmZhc3QgPSAmY3B1
LT5uZWcudGxiLmZbbW11X2lkeF07DQo+Pj4gK8KgwqDCoCBDUFVUTEJFbnRyeVRyZWUgKm5v
ZGU7DQo+Pj4gK8KgwqDCoCBzaXplX3QgaW5kZXg7DQo+Pj4gIMKgwqDCoMKgwqAgYXNzZXJ0
X2NwdV9pc19zZWxmKGNwdSk7DQo+Pj4gLcKgwqDCoCBmb3IgKHZpZHggPSAwOyB2aWR4IDwg
Q1BVX1ZUTEJfU0laRTsgKyt2aWR4KSB7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIENQVVRMQkVu
dHJ5ICp2dGxiID0gJmNwdS0+bmVnLnRsYi5kW21tdV9pZHhdLnZ0YWJsZVt2aWR4XTsNCj4+
PiAtwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgY21wID0gdGxiX3JlYWRfaWR4KHZ0bGIsIGFj
Y2Vzc190eXBlKTsNCj4+PiAtDQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChjbXAgPT0gcGFn
ZSkgew0KPiAuLi4NCj4+PiArwqDCoMKgIGlmICghdGxiX2hpdCh0bGJfcmVhZF9pZHgoJm5v
ZGUtPmNvcHksIGFjY2Vzc190eXBlKSwgYWRkcikpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAg
LyogVGhpcyBhY2Nlc3MgaXMgbm90IHBlcm1pdHRlZC4gKi8NCj4+PiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIGZhbHNlOw0KPj4+ICvCoMKgwqAgfQ0KPj4NCj4+IFRoaXMgaXMgbm90IHNv
bWV0aGluZyB3ZSB3ZXJlIGNoZWNraW5nIGJlZm9yZS4gSWYgdGhpcyBpcyBhbiBhZGRpdGlv
biwgbWF5YmUgaXQgd291bGQgYmUNCj4+IGJldHRlciB0byBzcGxpdCB0aGlzIG91dCBvZiB0
aGlzIGNvbW1pdC4gT3IgbWF5YmUgSSBtaXNzZWQgYSBzdGVwIGluIHByZXZpb3VzIGNvbW1p
dHMgOikNCj4gDQo+IEl0J3MgdGhlcmUsIHdpdGggdGhlIGNvbXBhcmlzb24gYW5kIHBhZ2Ug
bWFzaywgYnV0IEkgYWdyZWUgaXQncyBub3Qgb2J2aW91cy4NCj4gDQo+IA0KPiByfg0KDQpT
dWJ0bGUgaW5kZWVkLCB5b3UgZG9uJ3QgZXhwZWN0ICYgVEFSR0VUX1BBR0VfTUFTSyB0byBp
bXBseSB0aGF0IA0KcHJvdGVjdGlvbiBpcyBjaGVja2VkLCBldmVuIGlmIHRoYXQgbWFrZXMg
c2Vuc2Ugb25jZSBzYWlkLg0K

