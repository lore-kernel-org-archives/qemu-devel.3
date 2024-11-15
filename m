Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153F4D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC0N0-0008HH-Jo; Fri, 15 Nov 2024 12:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tC0My-0008H5-Oa
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:44:33 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tC0Mx-0003yP-6a
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:44:32 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so22830195ad.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731692669; x=1732297469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VS4PCHlxUzVCbdRuIBEHa31/oVP1J0wX0ZE3kRk84Es=;
 b=B7lcqvXOkdZ1la7qzoLUBdBEAZGJnVeUc0+Ec7642uW8dfRM90c5HP6AW6bRWdr/cA
 4lOdH38vbd8xMynWFHFGYlvIk9+yRAjGmm9K0zhABT4XOeMhcnKtg/gVJD+G30TVza4L
 RwrDe85/1spIkNY+mVt/zle61bC3faWG14+FpIRYdgkcKK3d7tB5S7XvZD5cwKRLyg8/
 vw4rqTS51BfwDEfO/e43jwD5aPG06BGL3L5a51SlQLeU8joDOBWSfVY6BxCFzdaYJzoB
 WL8ju7jv2eAIAdKKdcGnBtDInv8WnMEmQAMOHNN8FbTUQ4OsM88Lbi6auCNty43Jq0d9
 rvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731692669; x=1732297469;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VS4PCHlxUzVCbdRuIBEHa31/oVP1J0wX0ZE3kRk84Es=;
 b=kbrkZN0Io92a6tIXIl7jlU+L20DnE6DVaMS76lemCBTFKISoW6d/099T8STpU6HpAP
 8ue84QJYSRneFxEcVXp0b3A+FM8fiJPRe1Has+Lxy8XjHq2Av226Xv6qGs/gq/WONcyY
 jXWAThlMAmJwcb0w0POZWRAER/XUOqBsQzF494q3Y5l4oRrU0OeS48cRT9lqOa/qGVk4
 mYjvaIWD/em7XELThdmbF2QzjEbGg/BOr3If8WFT3kdV0QGNR424VR4Gsf/BAFf8QGPC
 4tQJj2h/4M3gOJzzzfr3I75HtOnycqxsXSpAqin7O/uGcizm0tNc0u5ZP56NRWYg9KeB
 WVbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3yFAH2bnsRp5saSY7tiZLhzBr3ptBWJWLLr6EfmQ8k9cF90JGIkMA9IN9CiBsdNU/BhR5+ZwayV1B@nongnu.org
X-Gm-Message-State: AOJu0Yxm6iNkIw1/6tojKhDsVtbHG8XMAqDSkogKC2hM1G6Di6EHGtno
 8xdG/YSGOF8A6+VLW2DaoZLEFcCFPehnIE7b8S1hE/SuAeU3OZmbxBZuswsXN5k=
X-Google-Smtp-Source: AGHT+IFAKvcHHzHgHyTMyMFb090Mbc7hWy5gITq6EVwZ/Ro9MTFIqloD6EJkhavQwdFHmPcLx9Jfiw==
X-Received: by 2002:a17:902:db11:b0:20c:7c09:b2ac with SMTP id
 d9443c01a7336-211d0ed2d5amr49571085ad.52.1731692668915; 
 Fri, 15 Nov 2024 09:44:28 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f54c8csm14893435ad.251.2024.11.15.09.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 09:44:28 -0800 (PST)
Message-ID: <2a768300-00b8-436b-89c9-995b9a8d3001@linaro.org>
Date: Fri, 15 Nov 2024 09:44:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 v2 00/54] accel/tcg: Convert victim tlb to
 IntervalTree
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <eaa2ecf4-74ce-49e1-846e-8f0c9c16d1af@linaro.org>
 <fea58b9b-9fad-4729-9f29-2f05d636d004@linaro.org>
 <970a751f-bae2-46b1-86d3-3bc97132f21e@linaro.org>
 <87ttc8rabm.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ttc8rabm.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gMTEvMTUvMjQgMDM6NDMsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gT24g
MTEvMTQvMjQgMTI6NTgsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPj4+IE9uIDExLzE0
LzI0IDExOjU2LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBJIHRlc3RlZCB0aGlz
IGNoYW5nZSBieSBib290aW5nIGEgZGViaWFuIHg4Nl82NCBpbWFnZSwgaXQgd29ya3MgYXMg
ZXhwZWN0ZWQuDQo+Pj4+DQo+Pj4+IEkgbm90aWNlZCB0aGF0IHRoaXMgY2hhbmdlIGRvZXMg
bm90IGNvbWUgZm9yIGZyZWUgKDY0cyBiZWZvcmUsIDgycyBhZnRlciAtIDEuM3gpLiBJcyB0
aGF0DQo+Pj4+IGFjY2VwdGFibGU/DQo+Pj4gV2VsbCwgbm8uICBCdXQgSSBkaWRuJ3Qgbm90
aWNlIGFueSBjaGFuZ2UgZHVyaW5nIGJvb3QgdGVzdHMuICBJIHVzZWQgaHlwZXJmaW5lIG92
ZXIgJ21ha2UNCj4+PiBjaGVjay1mdW5jdGlvbmFsJy4NCj4+PiBJIHdvdWxkIG9ubHkgZXhw
ZWN0IGJlbmVmaXRzIHRvIGJlIHNlZW4gZHVyaW5nIGxvbmdlciBsaXZlZCB2bSdzLA0KPj4+
IHNpbmNlIGEgYm9vdCB0ZXN0DQo+Pj4gZG9lc24ndCBydW4gYXBwbGljYXRpb25zIGxvbmcg
ZW5vdWdoIHRvIHNlZSB0bGIgZW50cmllcyBhY2N1bXVsYXRlLiAgSSBoYXZlIG5vdCBhdHRl
bXB0ZWQNCj4+PiB0byBjcmVhdGUgYSByZXByb2R1Y2libGUgdGVzdCBmb3IgdGhhdCBzbyBm
YXIuDQo+Pj4NCj4+DQo+PiBJIGRpZG4ndCB1c2UgY2hlY2stZnVuY3Rpb25hbCBuZWl0aGVy
Lg0KPj4gSSB1c2VkIGEgdmFuaWxsYSBkZWJpYW4gYm9va3dvcm0gaW5zdGFsbCwgd2l0aCBh
IG1vZGlmaWVkDQo+PiAvZXRjL3JjLmxvY2FsIGNhbGxpbmcgcG93ZXJvZmYsIGFuZCByYW4g
MyB0aW1lcyB3aXRoL3dpdGhvdXQgY2hhbmdlDQo+PiB3aXRoIHR1cmJvIGRpc2FibGVkIG9u
IG15IGNwdS4NCj4gDQo+IElmIHlvdSB3YW50IHRvIHJlYWxseSBzdHJlc3MgdGhlIFZNIGhh
bmRsaW5nIHlvdSBzaG91bGQgdXNlIHN0cmVzcy1uZyB0bw0KPiBleGVyY2lzZSBwYWdlIGZh
dWx0aW5nIGFuZCByZWNvdmVyeS4gV3JhcCBpdCB1cCBpbiBhIHN5c3RlbWQgdW5pdCBmb3Ig
YQ0KPiByZXByb2R1Y2libGUgdGVzdDoNCj4gDQo+ICAgIGNhdCAvZXRjL3N5c3RlbWQvc3lz
dGVtL2JlbmNobWFyay1zdHJlc3Mtbmcuc2VydmljZQ0KPiAgICAjIEEgYmVuY2htYXJrIHRh
cmdldA0KPiAgICAjDQo+ICAgICMgVGhpcyBzaHV0c2Rvd24gb25jZSB0aGUgYm9vdCBoYXMg
Y29tcGxldGVkDQo+IA0KPiAgICBbVW5pdF0NCj4gICAgRGVzY3JpcHRpb249RGVmYXVsdA0K
PiAgICBSZXF1aXJlcz1iYXNpYy50YXJnZXQNCj4gICAgQWZ0ZXI9YmFzaWMudGFyZ2V0DQo+
ICAgIEFsbG93SXNvbGF0ZT15ZXMNCj4gDQo+ICAgIFtTZXJ2aWNlXQ0KPiAgICBUeXBlPW9u
ZXNob3QNCj4gICAgRXhlY1N0YXJ0PXN0cmVzcy1uZyAtLXBlcmYgLS1pb21peCA0IC0tdm0g
MiAtLXRpbWVvdXQgMTBzDQo+ICAgIEV4ZWNTdGFydFBvc3Q9L3NiaW4vcG93ZXJvZmYNCj4g
DQo+ICAgIFtJbnN0YWxsXQ0KPiAgICBXYW50ZWRCeT1tdWx0aS11c2VyLnRhcmdldA0KPiAN
Cj4gYW5kIHRoZW4gY2FsbCB3aXRoIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gICAgLWFwcGVu
ZCAicm9vdD0vZGV2L3NkYTIgY29uc29sZT10dHlBTUEwIHN5c3RlbWQudW5pdD1iZW5jaG1h
cmstc3RyZXNzLW5nLnNlcnZpY2UiDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBhZHZpY2UuDQoN
Cj4+DQo+Pj4gcn4NCj4gDQoNCg==

