Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAC9C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 20:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trjnu-0006k3-Qk; Mon, 10 Mar 2025 16:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trjn3-0006Ws-AY
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:32:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trjmz-0000Iq-UH
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:31:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-225477548e1so40495115ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741638710; x=1742243510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l/+Oq4Vxh2Scq7DC466zapJzsgZ8EN71lZ/6+082Zvc=;
 b=HEfoE6eHS2qVAfilXY8TKTtFnoqJpwcI4X48Ojoi9izmTzZWjBmKvD2QPUTvdqRAVs
 M6fd8Ko6Q0ufOw0Z2wfZXNenmP2QP44jzoG8mHwhDY+WZH7x/SKAp1ljSVeH+utPnp1f
 KCrbaMRMxeCfYSGOmRoUJKvZhQFIIRe7f5C7bOn6D7dp25wCQBuyHAgFZmrsQMutOCZg
 gpG/NseFJdvUeW/K5mHq1X5GfQeffH94VV8GUXTcIIFGU1RcwQ5zD0jTQr59MIXzxEEU
 enUbQ53myj63MCKDk0hofsW4g9FfK8/q/b1YIZZRmKQidsQN/A4GFSQvvbO0MSzm1okD
 aNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741638710; x=1742243510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l/+Oq4Vxh2Scq7DC466zapJzsgZ8EN71lZ/6+082Zvc=;
 b=rAQVwcYmi46kqm0OBYdNwnEjkt4/cdC+qdacIE5VQlPaa18uNDu3YTYqCw49cryiIF
 dnSXkwef1txS1vUCJrl1ylqwWu3HsvFGtgMAZl1B+Hc6upyE6Ga98+b9MMfVl15fWZch
 +Sash2Og+mWZxEPzf0i1mF+UBx1xHuuiQiwerGIO8+epaZidrU5WaeWb1ocPmO6iuNSf
 uTqJA5ViQ23l6kPW07Ty0skJBRf4UaPrlSzfMl0LzUVI54DEqOQOv+IkdkpgsQtJEXvp
 vxcePr8OeSjnPvjDcoWgOwORZPY3c9T+h/ee5WxuIFM3q8lP/jpKRP+MscdILX9UdowI
 hbHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKkye3dTugfMeMf2kYTUf33qpx41+i7NTS230oS5BmVc42HfSJwaWZHbaTxjyNoDlHB9sVikkepREV@nongnu.org
X-Gm-Message-State: AOJu0YzZIZ+hkJ07DFtv9hrvILYbf1hukf0Rpbm1+L1O64035K9XSIzj
 IkU1r+gjiKfPFWO7QlBPJcJKzlYYD2Wq5EECqZ+LeuGMTT45M92C3QQhVRv9XB8=
X-Gm-Gg: ASbGncuFg/O4sqZ1/6whJvH9HmvvcHUBrK+4Efy5eLZH58AU+/Jh0PU0XDiIG4P86oa
 xZ90JHG2cpYzpTc2HihBez2KqaAwRkBr+jyA3WPHTZnFTOfTEPEGHy7OfgaYYLbvmz9GqdAvCks
 t4LNtj/1MfjhxoLOu7RCMyfW0Nma/RHBqw7+cc1bie0n4pN4mgN+16VhoycRpJ4f8fmCOg5MsYr
 g+kYzoziQbgi27lnKM95HCA9XDWyhUyDLyrj21KBJ/dofFpceK8+SYAtkqNYCU8YjIwMjXPWQ2+
 TLi24tDDH4zIzPpQ9W1VOqwbL2R5vF4Wrh3saML/sAs2cRme/4pgf96pDA==
X-Google-Smtp-Source: AGHT+IHv60NYH7I4yZYtgcrgyzlzj58QoWxB+SxwqmXaD6dXzaxtkCINcoNLCCqFlyw2WpuAW5DXVA==
X-Received: by 2002:a17:903:41c2:b0:220:e9f5:4b7c with SMTP id
 d9443c01a7336-2242889f0abmr227102735ad.17.1741638709878; 
 Mon, 10 Mar 2025 13:31:49 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm10409550a91.12.2025.03.10.13.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 13:31:49 -0700 (PDT)
Message-ID: <d857d05b-3e55-4ec6-9aa7-9de0e5a3046a@linaro.org>
Date: Mon, 10 Mar 2025 13:31:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] qemu/bswap: implement {ld,st}.*_p as functions
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
 <4ac28725-33bc-4b29-a941-03784566d330@linaro.org>
 <6a0cd17e-1c76-4b2d-b781-ea7f438cc4b2@linaro.org>
 <6dc11a37-06d7-400a-b45e-a151d660eb6f@linaro.org>
 <15816b7b-f120-4235-a1a9-333bc0f69fe1@linaro.org>
 <e20b6a44-b371-4154-8dc9-5f3cb4a3f570@linaro.org>
 <4c2ee71d-6d7c-436d-8608-e4aec71c4df0@linaro.org>
 <d2b5f9b9-f567-5434-d9b3-05c0ea9b5b1c@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d2b5f9b9-f567-5434-d9b3-05c0ea9b5b1c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gMy8xMC8yNSAxMzoxNywgQkFMQVRPTiBab2x0YW4gd3JvdGU6DQo+IE9uIE1vbiwgMTAg
TWFyIDIwMjUsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzEwLzI1IDA5OjUz
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzEwLzI1IDA5OjQzLCBQaWVy
cmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBPbiAzLzEwLzI1IDA5OjM3LCBSaWNoYXJkIEhl
bmRlcnNvbiB3cm90ZToNCj4+Pj4+IE9uIDMvMTAvMjUgMDk6MTQsIFBpZXJyaWNrIEJvdXZp
ZXIgd3JvdGU6DQo+Pj4+Pj4gT24gMy8xMC8yNSAwOTowOCwgUmljaGFyZCBIZW5kZXJzb24g
d3JvdGU6DQo+Pj4+Pj4+IE9uIDMvOS8yNSAyMTo1OCwgUGllcnJpY2sgQm91dmllciB3cm90
ZToNCj4+Pj4+Pj4+IEZvciBub3csIHRoZXkgYXJlIGR1cGxpY2F0ZSBvZiB0aGUgc2FtZSBt
YWNyb3MgaW4gY3B1LWFsbC5oIHRoYXQgd2UNCj4+Pj4+Pj4+IGVsaW1pbmF0ZSBpbiBuZXh0
IGNvbW1pdC4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBLZWVwIGNvZGUgcmVhZGFibGUgYnkgbm90
IGRlZmluaW5nIHRoZW0gd2l0aCBtYWNyb3MsIGJ1dCBzaW1wbHkgdGhlaXINCj4+Pj4+Pj4+
IGltcGxlbWVudGF0aW9uLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+Pj4+Pj4N
Cj4+Pj4+Pj4gV2h5IGRvIHlvdSB3YW50IHRoZXNlIGluIGJzd2FwLmgsIHJhdGhlciB0aGFu
IHRzd2FwLmg/DQo+Pj4+Pj4+IFRoZXkncmUgdGFyZ2V0IHN3YXBzLCBhZnRlciBhbGwuDQo+
Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IHJ+DQo+Pj4+Pj4NCj4+Pj4+PiBObyBwcmVmZXJl
bmNlIG9uIHRoYXQsIEkgc2ltcGx5IGFkZGVkIHRoZW0gdG8gdGhlIHNhbWUgZmlsZSB0aGFu
IHRoZWlyDQo+Pj4+Pj4gZXhwbGljaXQgZW5kaWFubmVzcw0KPj4+Pj4+IHZhcmlhbnQuIFdv
dWxkIHlvdSBwcmVmZXIgdGhlIGVuZGlhbm5lc3MgYWdub3N0aWMgdmFyaWFudCB0byBiZSBp
bg0KPj4+Pj4+IHRzd2FwLmggaW5zdGVhZD8NCj4+Pj4+DQo+Pj4+PiBJIHRoaW5rIEkgd291
bGQuDQo+Pj4+DQo+Pj4+IE9rLCBJIHdpbGwgbW92ZSBpdC4NCj4+Pj4NCj4+Pj4+DQo+Pj4+
PiBJbiBhZGRpdGlvbiwgSSB0aGluayB3ZSB3YW50DQo+Pj4+Pg0KPj4+Pj4gI2lmZGVmIENP
TVBJTElOR19QRVJfVEFSR0VUDQo+Pj4+PiAjZGVmaW5lIHRhcmdldF93b3Jkc19iaWdlbmRp
YW4oKcKgIFRBUkdFVF9CSUdfRU5ESUFODQo+Pj4+PiAjZWxzZQ0KPj4+Pj4gYm9vbCB0YXJn
ZXRfd29yZHNfYmlnZW5kaWFuKHZvaWQpOw0KPj4+Pj4gI2VuZGlmDQo+Pj4+Pg0KPj4+Pj4g
bW92aW5nIHRoZSBjb25kaXRpb25hbCBmcm9tIGFyb3VuZCB0YXJnZXRfbmVlZHNfYnN3YXAg
anVzdCBiZWxvdy4NCj4+Pj4+DQo+Pj4+PiBXaXRoIHRoYXQsIHdlIGVsaW1pbmF0ZSB0aGUg
ZXh0cmEgYnJhbmNoIHRoYXQgeW91J3JlIG90aGVyd2lzZQ0KPj4+Pj4gYWRkaW5nIHRvIHRh
cmdldC1zcGVjaWZpYyBjb2RlIHdpdGggdGhpcyBwYXRjaC4NCj4+Pj4+DQo+Pj4+DQo+Pj4+
IEkgdW5kZXJzdGFuZCB0aGUgY2hhbmdlIHJlcXVlc3RlZCwgYnV0IHNob3VsZCB3ZSByZWFs
bHkgYWltIGluIHRoYXQNCj4+Pj4gZGlyZWN0aW9uPyBJbiB0aGUgZW5kLA0KPj4+PiBpZiB3
ZSBwdXJzdWUgdGhlIGNvbXBpbGF0aW9uIHVuaXRzIGRlZHVwbGljYXRpb24sIHRoZSBicmFu
Y2ggd2lsbCBiZQ0KPj4+PiBwcmVzZW50IGFueXdheS4NCj4+Pj4NCj4+Pj4gSSdtIG9rIHdp
dGggeW91ciBjaGFuZ2UsIGp1c3QgYXNraW5nIGlmIHdlIHJlYWxseSB3YW50IHRvIHByZXNl
cnZlIHRhcmdldA0KPj4+PiBzcGVjaWZpYyBjb2RlDQo+Pj4+IHVudGlsIHRoZSAiZW5kIi4N
Cj4+Pg0KPj4+IEFsbCBvZiB0YXJnZXQvIGlzIHRhcmdldCBzcGVjaWZpYy4gIERlLWR1cGxp
Y2F0aW9uIHdpbGwgbm90IGVsaW1pbmF0ZSB0aGF0Lg0KPj4+DQo+Pg0KPj4gTXkgdm9jYWJ1
bGFyeSB3YXMgd3JvbmcgaGVyZS4gSSBtZWFudCAiaWYgd2Ugd2FudCB0byBwcmVzZXJ2ZSB0
YXJnZXQgc3BlY2lmaWMNCj4+IG1hY3JvcyIgdW50aWwgdGhlIGVuZC4NCj4+IFN1cmUsIHRo
ZXJlIHdpbGwgYWx3YXlzIGJlIGNvbXBpbGF0aW9uIHVuaXRzIChkZXZpY2VzLCBjcHVzLCBo
ZWxwZXJzLCAuLi4pDQo+PiBzcGVjaWZpYyB0byBhIHRhcmdldC4gSSBqdXN0IHdvbmRlciBp
ZiBzdGlja2luZyB0byBpZmRlZiBwYXJhZGlnbSBmb3IgdGhpcw0KPj4ga2luZCBvZiBjb2Rl
IGlzIHdvcnRoIHRoZSAib3B0aW1pemF0aW9uIiB3ZSBhcmUgc3VwcG9zZWQgdG8gZ2V0Lg0K
PiANCj4gSSd2ZSBhbHJlYWR5IHRyaWVkIHRvIHNheSB0aGF0IGluIHRoZSBwcmV2aW91cyBy
ZXBseSBidXQgbWF5YmUgSSBjYW4NCj4gZXhwbGFpbiBpdCBiZXR0ZXIgaGVyZS4gSSB0aGlu
ayBrZWVwaW5nIHBlciB0YXJnZXQgYmluYXJpZXMgd291bGQgYmUNCj4gZGVzaXJlZCBzbyBz
aW5nbGUgYmluYXJ5IHdvdWxkIG5vdCByZXBsYWNlIGl0IGp1c3QgYmVjb21lIGFuIGFkZGl0
aW9uYWwNCj4gb3B0aW9uLiBGb3IgZXhhbXBsZSB3aGVuIEkgd2FudCB0byBwbGF5IHdpdGgg
b2xkIHN0dWZmIEkgY29tcGlsZSB3aXRoDQo+IC0tdGFyZ2V0LWxpc3Q9cHBjLXNvZnRtbXUg
YW5kIGRvbid0IHdhbnQgdG8gd2FpdCBjb21waWxpbmcgYWxsIHRoZSBvdGhlcg0KPiB0YXJn
ZXRzIEkgZG9uJ3QgdXNlIGFuZCBub3QgZXZlbiBpbnRlcmVzdGVkIGluIFBQQzY0LiBBIGRp
c3RybyBtYXkgd2FudCB0bw0KPiBzaGlwIGEgc2luZ2xlIHFlbXUtc3lzdGVtIGJpbmFyeSBp
bnN0ZWFkIGJ1dCBvdGhlciBkaXN0cm9zIG1heSBwcmVmZXIgcGVyDQo+IHRhcmdldCBwYWNr
YWdlcyBub3Qgb25lIGh1Z2UgcGFja2FnZSBzbyB1c2VycyBjYW4gZGVjaWRlIHdoaWNoIG9u
ZXMgdG8NCj4gaW5zdGFsbC4gQWxsIG9mIHRoZXNlIGFyZSB2YWxpZCB1c2UgY2FzZXMsIHRo
ZXJlZm9yZSB0aGlzIHNpbmdsZSBiaW5hcnkNCj4gc2hvdWxkIGJlIGFuIGFkZGl0aW9uYWwg
b3B0aW9uIG5vdCB0aGUgb25seSB0cnVlIHdheSBmcm9tIG5vdyBvbg0KPiByZXBsYWNpbmcg
ZXhpc3RpbmcgcGVyIHRhcmdldCBidWlsZHMuDQo+IA0KDQpUaGlzIHZhbGlkIHVzZSBjYXNl
IGlzIGFuZCAqd2lsbCogc3RheSB0aGUgZGVmYXVsdC4gVGhlcmUgaXMgbm8gc2VjcmV0IA0K
ZXZpbCBwbGFuIHRvIGJyZWFrIHBlb3BsZSBoYWJpdHMgaGVyZSA6KS4NCg0KRm9yIG5vdywg
d2UgZG9uJ3QgZXZlbiBpbnRyb2R1Y2UgYSAic2luZ2xlIGJpbmFyeSIgY29uZmlndXJlIG9w
dGlvbiwgDQpzaW1wbHkgYmVjYXVzZSB0aGUgcmVzdWx0aW5nIGNvZGUgY291bGQgbm90IGxp
bmssIHNvIHRoZXJlIGlzIG5vIHBvaW50Lg0KDQpJZiB5b3UncmUgY3VyaW91cyBhYm91dCB0
aGlzLCBpdCBpcyB0aGUgY29tbWFuZCB3ZSB1c2UgdG8gY2hlY2sgdGhlIHdvcmsgDQpsZWZ0
IGJlZm9yZSBiZWluZyBhYmxlIHRvIGRvIGl0Og0KIyBjb25maWd1cmUgd2l0aCBhbnkgdGFy
Z2V0IGxpc3QsIHdlIHVzZSBhbGwgaW4gb3VyIGNhc2UNCiQgLi9jb25maWd1cmUgLi4uDQok
IGpxIC0tcmF3LW91dHB1dCA8IGJ1aWxkL2NvbXBpbGVfY29tbWFuZHMuanNvbiAnLltdLmZp
bGUnIHwgc29ydCB8DQogICB1bmlxIC1jIHwgc29ydCAtcm4gfCBncmVwIC12ICdeXHMqMSAn
DQoNCk9uY2UgdGhpcyBsaXN0IGlzIGVtcHR5LCB3ZSdsbCBiZSBhYmxlIHRvIGxpbmsgYW5k
IGV4ZWN1dGUgYSBzaW5nbGUgDQpiaW5hcnkgKGFuZCBhZGRpbmcgYSBhZGRpdGlvbmFsIG5l
dyBtYWluKCkgZm9yIHRoYXQpLiBCdXQgZmlyc3QgdGhpbmdzIA0KZmlyc3QuDQoNCj4gUmVn
YXJkcywNCj4gQkFMQVRPTiBab2x0YW4NCj4gDQo+PiBJJ2xsIGFkZCB0aGUgY2hhbmdlIHJl
cXVlc3RlZC4NCj4+DQo+Pj4NCj4+PiByfg0KPj4NCj4+DQoNCg==

