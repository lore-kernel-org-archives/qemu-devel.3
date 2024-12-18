Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4531E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNzS8-0005gZ-CA; Wed, 18 Dec 2024 14:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNzS3-0005Z2-U0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:11:20 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNzS1-0007IG-Hb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:11:18 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-725ee6f56b4so28709b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734549076; x=1735153876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TjD0XH5lcQXo8BWMn/mugtch0hAda217TjSow7t/CAs=;
 b=mep7iYH53nyACSYSLChGsHTSqWzhUAOHyiPC2A71h1K68OG+s+SHPeGM3DauCvC/yh
 xQM1asQFSU5z+xTNjgZd6402xAwt/Wn69a8wt/4Dyaq6Rek/U+uIp6wyPXPkj+XZ//Dn
 EPjAtlTnYE18oC8LdhYiyW+D8odGAolAxcPtTrbFcdEse+xBtZk/oqYZtUnF2vjUc4yp
 1ACfVmqV8+66KlsLoVpB8twm+kZpSDxP0SItpkSAVWIp6198ddCj8vYF+xKmTt9cccqI
 ef1GuwK1VtVwFnvGWyCnrNsgOVH9XwvaKpVCNdnfc//BzniMOjzJoi6E1wDGmBlFgREr
 oYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734549076; x=1735153876;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TjD0XH5lcQXo8BWMn/mugtch0hAda217TjSow7t/CAs=;
 b=Rdl65f15fVRGfzNGLeHvZK8sDCBlb7y6TNYe12j9neFzHb/kaAw9CAmDbNzIpe4+xe
 GkpRLkMDPVRO4C6OlugnqIIWd9MqUSOHPcjORy+V5hVTLACLqCBALi0cHTOxteU3fz71
 STj8U1RIA8v0rf/1ImAs7uUI5Xvqru/s30CL5PO7icwOgWkmhWT9y/cg4ah8JzikKTk2
 rkcC57HvYkyHW5Hcp/fV+pczV7XMuap38vJeW5AlNm+U8C10Owykh+YNmcmLqftM2j8C
 o/bJHy0bcLtNoKjlIanG2zJkT7Y65FR92NyoOZYq8n6dDLRVnysEjcKTKpbFGAix2McM
 7+yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAe/LCtmAcnSE0SFla/qjrR4klAp8I2QDy0WX1SAx/jsrpDjcdOc40wvEpOdNTWa6GxEBFMHJBSfaj@nongnu.org
X-Gm-Message-State: AOJu0YwWRQqAbbE0NrjR72gLlqzar++SXemF0+gk8mRAsIy3HH0vfzqc
 h7b+uYxq21jkoVnpD0f5CR5kLWlkW0XJErGi3sjTCrWVZd6o5hkR0cC7zM7Ysdc=
X-Gm-Gg: ASbGncvhckS5v8C9YHC+vxutAsfneiZVLs5o+Dmw6F+E2QM+C6tZ/n6jRW1f3OsvU8l
 nixO7a7DmnPdIq5djJub5Vgi1D6lON3olD6pcyVHTBy1Nz85d5Ubj+SKtBjiNZSNONLdWyICzvR
 Lya+4vIjv0jihd6XXNLPmsCdCRQNvsEIkrkitaJxlN0zjeAtdaHO1cJX3il6sy2XrmBz5/4Swpk
 mp+NvWAs/xBjCf4DB+xWcpfk4IjZmNhVLMLs2jzPB/i/9ANCjakjGURqRGk6xXJnqnR3g==
X-Google-Smtp-Source: AGHT+IEJT/rSDJJtfEWe1sy/5Peu2Kzj8quQosPvVsJGofD61oIHfHFZ7ijiLwpWtU2bWgD3zZUAwg==
X-Received: by 2002:a05:6a00:180b:b0:728:e27c:a9bc with SMTP id
 d2e1a72fcca58-72a8d237723mr4912068b3a.7.1734549075918; 
 Wed, 18 Dec 2024 11:11:15 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918b78976sm9124284b3a.127.2024.12.18.11.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 11:11:15 -0800 (PST)
Message-ID: <a034248f-77eb-4360-ae37-1f6a748bbce6@linaro.org>
Date: Wed, 18 Dec 2024 11:11:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/46] tcg/optimize: Add fold_masks_zsa, fold_masks_zs,
 fold_masks_z
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-4-richard.henderson@linaro.org>
 <f64769f6-ce7e-4502-9ce9-19bb57306752@linaro.org>
 <1b14277a-987e-4f69-b8a1-5a6891ff6fd6@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1b14277a-987e-4f69-b8a1-5a6891ff6fd6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

T24gMTIvMTcvMjQgMTk6MjAsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBPbiAxMi8x
Ny8yNCAxNDowMywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+PiArX19hdHRyaWJ1dGVf
XygodW51c2VkKSkNCj4+PiArc3RhdGljIGJvb2wgZm9sZF9tYXNrc196cyhPcHRDb250ZXh0
ICpjdHgsIFRDR09wICpvcCwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3Qgel9tYXNrLCB1aW50NjRfdCBzX21hc2sp
DQo+Pj4gK3sNCj4+PiArwqDCoMKgIHJldHVybiBmb2xkX21hc2tzX3pzYShjdHgsIG9wLCB6
X21hc2ssIHNfbWFzaywgLTEpOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtfX2F0dHJpYnV0ZV9f
KCh1bnVzZWQpKQ0KPj4+ICtzdGF0aWMgYm9vbCBmb2xkX21hc2tzX3ooT3B0Q29udGV4dCAq
Y3R4LCBUQ0dPcCAqb3AsIHVpbnQ2NF90IHpfbWFzaykNCj4+PiArew0KPj4+ICvCoMKgwqAg
cmV0dXJuIGZvbGRfbWFza3NfenNhKGN0eCwgb3AsIHpfbWFzaywgc21hc2tfZnJvbV96bWFz
ayh6X21hc2spLCAtMSk7DQo+Pj4gK30NCj4+PiArDQo+Pj4gK3N0YXRpYyBib29sIGZvbGRf
bWFza3MoT3B0Q29udGV4dCAqY3R4LCBUQ0dPcCAqb3ApDQo+Pj4gK3sNCj4+PiArwqDCoMKg
IHJldHVybiBmb2xkX21hc2tzX3pzYShjdHgsIG9wLCBjdHgtPnpfbWFzaywgY3R4LT5zX21h
c2ssIGN0eC0+YV9tYXNrKTsNCj4+PiArfQ0KPj4+ICsNCj4+PiAgwqAgLyoNCj4+PiAgwqDC
oCAqIENvbnZlcnQgQG9wIHRvIE5PVCwgaWYgTk9UIGlzIHN1cHBvcnRlZCBieSB0aGUgaG9z
dC4NCj4+PiAgwqDCoCAqIFJldHVybiB0cnVlIGYgdGhlIGNvbnZlcnNpb24gaXMgc3VjY2Vz
c2Z1bCwgd2hpY2ggd2lsbCBzdGlsbA0KPj4NCj4+IEkgc2VlIHRoZSBkaXJlY3Rpb24sIGJ1
dCB3aHkgbm90IHNpbXBseSB1c2UgYSBzdHJ1Y3R1cmUgZm9yIHRoaXM/DQo+Pg0KPj4gSWYg
SSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgd2UnbGwgb25seSBwYXNzIHRoZSBtYXNrcyB0byBj
YWxsZWVzLCBzbyBpdCdzIGVhc3kgdG8gcGFzcyB0aGUNCj4+IHBvaW50ZXIgZG93biAod2l0
aG91dCBhbnkgaGVhcCBhbGxvY2F0aW9uIG5lZWRlZCksIGFuZCB3ZSBjYW4gaGF2ZSBhc3Nv
Y2lhdGVkIGJ1aWxkZXINCj4+IGZ1bmN0aW9ucyB0byBjcmVhdGUgdGhlIHN0cnVjdCBvbmx5
IHdpdGggYSBsaW1pdGVkIHNldCBvZiBtYXNrcywgb3IgZGlyZWN0bHkgZnJvbSBhbg0KPj4g
ZXhpc3RpbmcgImN0eCIuDQo+IA0KPiBXaHkgd291bGQgd2Ugd2FudCB0byB1c2UgYSBzdHJ1
Y3R1cmU/ICBJJ20gY29uZnVzZWQgYnkgdGhlIHF1ZXN0aW9uLg0KPg0KDQpXaGVuIEkgc3Rh
cnRlZCByZWFkaW5nIHRoZSBzZXJpZXMsIEkgdGhvdWdodCB3ZSB3b3VsZCBrZWVwIHRoZSBm
bGFncyBpbiANCmN0eCBzdHJ1Y3R1cmUsIGJ1dCBhZnRlciBmaW5pc2hpbmcgaXQsIEkgdW5k
ZXJzdG9vZCBiZXR0ZXIgd2hhdCB3YXMgdGhlIA0KaW50ZW50aW9uLg0KDQpUaGF0IHNhaWQs
IGl0J3MganVzdCBhIG1hdHRlciBvZiBwcmVmZXJlbmNlLCBiZXR3ZWVuIGhhdmluZyBpbmRp
dmlkdWFsIA0KdmFyaWFibGVzIG9yIGhhdmluZyBhIHN0cnVjdCBjb250YWluaW5nIHRoZW0s
IHdpdGggZnVuY3Rpb25zIHRvIG9wZXJhdGUgDQpvbiBpdC4NCg0KPiANCj4gcn4NCg0K

