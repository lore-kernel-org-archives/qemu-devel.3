Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D8BC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 18:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhp4-0002wd-GR; Mon, 10 Mar 2025 14:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trhp2-0002ux-64
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:25:52 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trhox-0004zr-3j
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:25:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22435603572so46817415ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741631145; x=1742235945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSKBNUoOMaSJMJbZ9WQrcFIJV7xoz2EWdS5LY2oMTCU=;
 b=jS0GSv2867WsMlQZRfrjXZkd7gM56ZAnGp/HOOdhwLoNVUK/Q14+Tjvbsixbm/LsZx
 hJHnMSwJ+1SGCIAD9iDm30IQDxapuX/aaLZuUxW3Lzkp+pslupVhUckJOMsRyNUw6FLP
 Y+GzF+rf5vBskXW5lpboARx/4vFiw7HOOUzJGtM+bOAGT8YMhzu9ISpNnI72hLtYlj/i
 RjA0JdqpLDTxyy3PRJXHCsRMMzmn/xqcfLZxBZbQCKWtCN7prtIAslrwoo/megsuqNVC
 jEPou4CLNnGiOh0But+g1zDZHeuIo0FyrPo+gTKAUpW3PkqAHzMkl6P30iC50IGhLYeV
 dnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741631145; x=1742235945;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSKBNUoOMaSJMJbZ9WQrcFIJV7xoz2EWdS5LY2oMTCU=;
 b=h8gS8kZB8J7FpiT6Ihat65oH1bc/5C5cziZSZGh8HvDlVNuGsBwXwJHum45p0qbCAu
 BT2iWEV3TGepxa1p4y7qsoSkV0mD5KUdQX6WkFoBOnUisZFu4UtKvpTvEJGHcv+A/N0w
 OS5OI1stgW7HZVsO8KlB34qGWhVjF9VLKQcS4CuYRBhURdTPqqd0O1A3o78DlgHz+/V+
 iqb++zbNvay+QwxBXi9BsjTCXRFFNtvA+dp4Woj01lrivumabAgAB3TFhKrBl7CHbRwQ
 5p3k5WQ//kw4+oDtT1G2vvsFRTYwxw5i8T1ZGP7BzIxGGnXN1VK0Fl7t/Z7SLhJ/Gmo7
 Q2Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC978U2Vdq0vSlC5m4hixR42Bz+o0oUTIUdXlHgewHJ5rrC9W3zj/FjAueE8rCNn7NaYWeb2uafCZ8@nongnu.org
X-Gm-Message-State: AOJu0YzUhq5FKKUa88heeQbnN5mzVJ2rTs1fKYB0djMjD8zkDgFXjR6v
 figc1Svhn8ApgpDhi9udfc8OUDGRMW2wb8XTZ7jeuhPZ/bZOFpTPLx7xZwlJkaI=
X-Gm-Gg: ASbGncvPIgZ5HD5bvJMm5LbaQT1zvrY1vM76pmJ7im0pRmHtDwJ7OO0jB+AL2xHzK22
 VnwRh7wY57JnDkykvevZ64m1seRFkvvxFvXzDiXgAjKZKt12qF9nPkNXHpTocLOkPp5Euoe26RW
 zKr/0wQgFrVFKTSHrmmiDG3nrlAuCZqtH0jdXfMumIUWCyFHcZig0lRIrjZVQzMBt43HnKGqmSG
 9kfh0qpDKLtkPteTXkfEDV338nPVY5Dv3pMTLr1zvlMMq8Z0b/QWuaF7To8IXBIWMw/o7lCqQQl
 pDP3Z6toxozJsd9d/p8I9u6fnLrcmgnpH8UO1sOMAY0LMqkdOGXsZsmpCQ==
X-Google-Smtp-Source: AGHT+IFLXONTXd00z7yIexpr1dJ5yz68pgcY1g64VUr5JpbmUzYrrAsoFI9nGxJQE1d7JX8bKB9Gyw==
X-Received: by 2002:a17:902:e745:b0:223:fabd:4f99 with SMTP id
 d9443c01a7336-22428886adcmr248964255ad.5.1741631144735; 
 Mon, 10 Mar 2025 11:25:44 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736adabdd0esm7012805b3a.68.2025.03.10.11.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 11:25:44 -0700 (PDT)
Message-ID: <ca1e9b24-74d6-4b5a-a8df-c62429fd0b3a@linaro.org>
Date: Mon, 10 Mar 2025 11:25:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] system/memory: make compilation unit common
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
 <76b4e445-0676-4982-a2c8-d273c49a9170@linaro.org>
 <2d631838-e8a5-48d9-8235-9a41ffc3381c@linaro.org>
 <76269a95-652a-4064-8f2f-6584b0677191@linaro.org>
 <b411c27f-3f38-4d22-97ff-fa36ae77fb6e@linaro.org>
 <0decdead-5d97-4623-8d3d-22bd8d7c8980@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0decdead-5d97-4623-8d3d-22bd8d7c8980@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMy8xMC8yNSAxMToxMCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTAv
MjUgMTE6MDQsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzEwLzI1IDEwOjU4
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzEwLzI1IDEwOjQ3LCBQaWVy
cmljayBCb3V2aWVyIHdyb3RlOg0KPj4+Pj4gTWF5YmUgYmV0dGVyIGFzDQo+Pj4+Pg0KPj4+
Pj4gIMKgwqDCoMKgwqDCoCBNZW1PcCBtb3AgPSAodGFyZ2V0X3dvcmRzX2JpZ2VuZGlhbigp
ID8gTU9fQkUgOiBNT19MRSkgfCBzaXplX21lbW9wKHNpemUpOw0KPj4+Pj4gIMKgwqDCoMKg
wqDCoCBhZGp1c3RfZW5kaWFubmVzcyhtciwgJm1yZmQuZGF0YSwgc2l6ZV9tZW1vcChzaXpl
KSwgbW9wKTsNCj4+Pj4+DQo+Pj4+DQo+Pj4+IERvIHlvdSB0aGluayBkZWZpbmluZyBNT19U
RSBhcyB0aGlzIGV4cHJlc3Npb24gaXMgYSBnb29kIGlkZWE/DQo+Pj4NCj4+PiBUaGVyZSBh
cmUgbm90IHNvIG1hbnkgcmVmZXJlbmNlcyB0byBNT19URSBvdXRzaWRlIHRhcmdldC8gb3Ig
YWNjZWwvdGNnLy4NCj4+Pg0KPj4+IEluZGVlZCwgYWZ0ZXIgdGhpcyBjaGFuZ2UsIHRoZSBv
bmx5IG9uZXMgbGVmdCBhcmUgaW4gaHcvYXJtL2FybXY3bS5jLA0KPj4+IHdoaWNoIChiZWNh
dXNlIGl0J3MgQXJtKSBjYW4gYmUgY2hhbmdlZCB0byBNT19MRS4NCj4+Pg0KPj4NCj4+IEkg
c2VlIGEgYml0IG1vcmUgdGhhbiB0aGF0ICgxNyBmaWxlcyk6DQo+PiBody9hcm0vYXJtdjdt
LmMNCj4+IGluY2x1ZGUvZXhlYy9tZW1vcC5oDQo+PiB0YXJnZXQvYXJtL3RjZy9oZWxwZXIt
YTY0LmMNCj4+IHRhcmdldC9hcm0vdGNnL3RyYW5zbGF0ZS5jDQo+PiB0YXJnZXQvaGV4YWdv
bi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jDQo+PiB0YXJnZXQvaHBwYS90cmFuc2xh
dGUuYw0KPj4gdGFyZ2V0L2kzODYvdGNnL2VtaXQuYy5pbmMNCj4+IHRhcmdldC9sb29uZ2Fy
Y2gvdGNnL2luc25fdHJhbnMvdHJhbnNfdmVjLmMuaW5jDQo+PiB0YXJnZXQvbTY4ay90cmFu
c2xhdGUuYw0KPj4gdGFyZ2V0L21pcHMvdGNnL21pcHMxNmVfdHJhbnNsYXRlLmMuaW5jDQo+
PiB0YXJnZXQvcmlzY3YvdHJhbnNsYXRlLmMNCj4+IHRhcmdldC9yeC90cmFuc2xhdGUuYw0K
Pj4gdGFyZ2V0L3MzOTB4L3RjZy9tZW1faGVscGVyLmMNCj4+IHRhcmdldC9zMzkweC90Y2cv
dHJhbnNsYXRlLmMNCj4+IHRhcmdldC9zMzkweC90Y2cvdHJhbnNsYXRlX3Z4LmMuaW5jDQo+
PiB0YXJnZXQvc3BhcmMvbGRzdF9oZWxwZXIuYw0KPj4gdGFyZ2V0L3NwYXJjL3RyYW5zbGF0
ZS5jDQo+Pg0KPj4gUGx1cyBtb3JlICgyMiBmaWxlcykgd2hvIHJlbGllcyBvbjoNCj4+IE1P
X1RFKiB2YXJpYW50cyAod2hpY2ggcmVsaWVzIG9uIE1PX1RFIHRyYW5zaXRpdmVseSkNCj4g
DQo+IEFzIEkgc2FpZCwgKm91dHNpZGUqIHRhcmdldC8gYW5kIGFjY2VsL3RjZy8uDQo+IA0K
DQpHb3QgaXQuDQpXZSBjYW4gcmVwbGFjZSB0aGUgaHcvYXJtIGVudHJ5IHdoZW4gdGFja2xp
bmcgdGhpcyBwYXJ0IGxhdGVyLg0KDQo+PiBUaHVzIG15IHByb3Bvc2FsIHRvIGhhdmUgYSBm
aXJzdCBjaGFuZ2UgdG8gTU9fVEUgZGVmaW5pdGlvbiwgYW5kIGV2ZW50dWFsbHkgZG8gdGhl
IGNoYW5nZQ0KPj4gbGF0ZXIuDQo+Pg0KPj4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBJ
IGRvbid0IHRoaW5rIGEgY2hhbmdlIHRvIE1PX1RFIGlzIG5lY2Vzc2FyeS4NCj4gDQo+IA0K
PiByfg0KDQo=

