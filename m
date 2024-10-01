Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCAECEACEB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svgBO-00015O-2E; Tue, 01 Oct 2024 12:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svgBH-0000ur-9i
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:56:59 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svgBE-0008Bs-15
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:56:59 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20b95359440so19590415ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801815; x=1728406615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pi3dvg6ZaeE5oQ9Te2cnzQ7jFHxC8EMgsyWm5nwTG4w=;
 b=YK4kYqXbu2Zla1RT8gyl1O0dpMK29p6HnVXCElFNfIi2X1EpGOeUGxyRQsRnjmhKVD
 ptLmXhEVPd1yovGM67lJv18cUXGxvG9X55N9PHZLiw/wZTtjCEuN1/+FKT0nCdcnf3kq
 LzBeDq7f4/oNLXBIRIkBdlYLnlBWNaaweaB8G43QuCao96mBR9kQW5UaFyErXlEDhIwI
 VrHQEkfQjBl+8T3rMXAAgSUYH2zkjP5RP+//s1wXlijFoeDV//bDLUTd3WWzWCgApSTh
 R1PsWL3imXJRJjkiuNBKthpu0IRRgEnx0476vst1z/F4vujf+y5AZtfYhzu9YkFaBiuT
 D5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801815; x=1728406615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pi3dvg6ZaeE5oQ9Te2cnzQ7jFHxC8EMgsyWm5nwTG4w=;
 b=JKM6U/6d4YOVczRCDhR9fp9WhugMLgozwL8GIJ/Vka4WDyCiJL7c6XUKG199XmEsFB
 0JglUJEoFdQNKgKzfwiWbjb+SxIzWwiYDre5P3YQw2V9WGtgm7GALp70Z0iXHdGQNQZn
 nUv3L5b1JxUlCFg/odwNF504IGmrudKguVrTFu/QD4hFq6m+Nat8MmrzDqqFc4gON+ZG
 gdAtCKvsjbbDUycOboWPBGTVO0Xz7OD+/zKzTjQGnG0NMKyZetXJvE6xIIo0bKjeKD+Y
 IrkY/k7/lGu0MVCFT7ZaT9v8Kqo3xUwFmL3GKSfiE1TSgpuVlblj65QmYDr8DLcWGRn5
 5rdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLegWlxkdRY16/uYvPMPavPR1XRXe1tTHIOe8YOibxf7mF4wJElAKlIGBmGDCNL9SFYl4nNCEYQRe6@nongnu.org
X-Gm-Message-State: AOJu0Yyz0kd8Da5ReLGJWPIZcY8zboxOXA3TDMPdAHxOHykMBHweL1NT
 bArGQ245sMq9bPOYtse7ZhH4NhQ292l8I6TInxHqZL0wRSCl1fKGtcJM9SxsrKw=
X-Google-Smtp-Source: AGHT+IFeCsSLqm3NJncFYAB1f+41eZ1ZsX4d45KKhqS52K/sfespom6SNYtfTN4ghzRlBQLVorHBGQ==
X-Received: by 2002:a17:903:240a:b0:20b:983c:f095 with SMTP id
 d9443c01a7336-20bc5aa3877mr3285525ad.51.1727801814752; 
 Tue, 01 Oct 2024 09:56:54 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37d6717fsm72062295ad.14.2024.10.01.09.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:56:54 -0700 (PDT)
Message-ID: <353265a0-cef8-4a01-863a-5c9495263acb@linaro.org>
Date: Tue, 1 Oct 2024 09:56:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] hw/pci/pci_device: Add PCI_DMA_DEFINE_LDST_END()
 macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-12-philmd@linaro.org>
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

DQoNCk9uIDkvMzAvMjQgMDA6MzQsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
PiBEZWZpbmUgYm90aCBlbmRpYW5uZXNzIHZhcmlhbnRzIHdpdGggYSBzaW5nbGUgbWFjcm8u
DQo+IFVzZWZ1bCB0byBhZGQgeWV0IG90aGVyIGVuZGlhbiBzcGVjaWZpYyBkZWZpbml0aW9u
cw0KPiBpbiB0aGUgbmV4dCBjb21taXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1
ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaCB8IDEzICsrKysrKystLS0tLS0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaCBiL2luY2x1ZGUvaHcvcGNpL3Bj
aV9kZXZpY2UuaA0KPiBpbmRleCA5MWRmNDBmOTg5Li5mZjYxOTI0MWE0IDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmgNCj4gKysrIGIvaW5jbHVkZS9ody9w
Y2kvcGNpX2RldmljZS5oDQo+IEBAIC0yOTgsMTMgKzI5OCwxNCBAQCBzdGF0aWMgaW5saW5l
IE1lbVR4UmVzdWx0IHBjaV9kbWFfd3JpdGUoUENJRGV2aWNlICpkZXYsIGRtYV9hZGRyX3Qg
YWRkciwNCj4gICAgICAgICAgIHJldHVybiBzdCMjX3MjI19kbWEocGNpX2dldF9hZGRyZXNz
X3NwYWNlKGRldiksIGFkZHIsIHZhbCwgYXR0cnMpOyBcDQo+ICAgICAgIH0NCj4gICANCj4g
KyNkZWZpbmUgUENJX0RNQV9ERUZJTkVfTERTVF9FTkQoX2wsIF9zLCBfYml0cykgXA0KPiAr
ICAgIFBDSV9ETUFfREVGSU5FX0xEU1QoX2wjI19sZSwgX3MjI19sZSwgX2JpdHMpIFwNCj4g
KyAgICBQQ0lfRE1BX0RFRklORV9MRFNUKF9sIyNfYmUsIF9zIyNfYmUsIF9iaXRzKQ0KPiAr
DQo+ICAgUENJX0RNQV9ERUZJTkVfTERTVCh1YiwgYiwgOCk7DQo+IC1QQ0lfRE1BX0RFRklO
RV9MRFNUKHV3X2xlLCB3X2xlLCAxNikNCj4gLVBDSV9ETUFfREVGSU5FX0xEU1QobF9sZSwg
bF9sZSwgMzIpOw0KPiAtUENJX0RNQV9ERUZJTkVfTERTVChxX2xlLCBxX2xlLCA2NCk7DQo+
IC1QQ0lfRE1BX0RFRklORV9MRFNUKHV3X2JlLCB3X2JlLCAxNikNCj4gLVBDSV9ETUFfREVG
SU5FX0xEU1QobF9iZSwgbF9iZSwgMzIpOw0KPiAtUENJX0RNQV9ERUZJTkVfTERTVChxX2Jl
LCBxX2JlLCA2NCk7DQo+ICtQQ0lfRE1BX0RFRklORV9MRFNUX0VORCh1dywgdywgMTYpDQo+
ICtQQ0lfRE1BX0RFRklORV9MRFNUX0VORChsLCAgbCwgMzIpDQo+ICtQQ0lfRE1BX0RFRklO
RV9MRFNUX0VORChxLCAgcSwgNjQpDQo+ICAgDQo+ICAgI3VuZGVmIFBDSV9ETUFfREVGSU5F
X0xEU1QNCj4gICANCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNr
LmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

