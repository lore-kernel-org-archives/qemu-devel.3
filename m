Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C90E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxZu-00084H-Uf; Thu, 09 Jan 2025 13:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVxZt-00083t-Em
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:48:21 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVxZr-0005GJ-RR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:48:20 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-219f8263ae0so21135675ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 10:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736448498; x=1737053298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fm1h4Zc8HbM3X11KIImlwlypPiorDYvWnC+2TzfZk4o=;
 b=UqVOI3bgDSfmhcaVUC3aMzjyvz6sjKf5qMfg5n5q8/KaLARUTvF0THbSkKYztSIB7f
 BMnEpQsuXdcucj9WFb+WGNhJsuGdJ1rYLsvWmuL4q3bXkNzuHZUOXfof+Y4PduY9Gx/1
 BtwbGpRQB6XskLibK3IPsCB2XwwzVOF+ukhrnrCIUQq4/4H1duWDmjwOfh4cURgO9Wmn
 tg3xeHfuk5tq7DC37Qo2yfQwE9Zel44uaVx0eQrr4WZ6GgswKk2/Q+2HeCteCrD470NZ
 JyKnIA//+5v5LDhLfsVtIm8SPdp2hY9mIcKgsyEIDVAdTpVTC8fCE+PhzMgj3O1cVaA1
 vmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736448498; x=1737053298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fm1h4Zc8HbM3X11KIImlwlypPiorDYvWnC+2TzfZk4o=;
 b=KyKOuRPhl/cUz3Bi4MHYc94ScQtWkTT8WzVpyv3zssDK0dl4lt9D+ncKWs/XGHfAqj
 ZwOsiRr7kbiJZ5tQjCNE1rqREuIfdxlue1mIsw39A3yXLdGtZTJ4PuCSIqN/ipCwwo4x
 f/MKcOS3CG2nM+npf1KHDwdwN+sWDxVOQPeEdPZWLdFJkXf/IdtLWMY/y+quVOYPe35d
 s45W9qk00m53yejsIrXD8VlBXLiQCO2sISF03cCyYSUIRONbedV5390GfK5U++xCDLr+
 qgQhoAaa6G5pFj8X1MBBr9CL52AXE6cXiSpDrpTV/foq3S2cQx8VEwNc4s7B9BrO3D0t
 igbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmh9I9ig9PE9TQq8zQX1vUWFkjYLUbUo4YeUPXay9G92HSJ2m0/3KvAOsB19xsK7TUmA/HTGuLuhRp@nongnu.org
X-Gm-Message-State: AOJu0Yz62DXjarnsg1SZvkzY4qi3T4AzDVQ1Co11S40puOIn2o7IFxp4
 PCZUojFGJkJOnbPeXvuLwmAUQYLs4HbD74Vtflra0O96VoLqY/iJsqGyg4RL3UY=
X-Gm-Gg: ASbGnctyByJuQNvbF1yT+UJca28p0mpbGGq3chGUQybTZrYkdRQYuQqb+pfkuaiH2yx
 1Cqega30U8AQktqRbqRcAU50k8oSC+feCpTRCJQe0Baf0bWjep/bWi6ZYOc/AZYOZBYhSFjdYzw
 QDCbScMMHdoQf5VMb2S3AeqC8k+j6Hfj5tiCoaHNYSv53SIeGupptNZ/R5FGQhQFArp35PDPUcd
 LJAW6x0FRdJr5rAeKmfEV+YdaQcXjuARApkhaHmoLjx5Wt7tBwyephUgfPhY+HA1gbA7g==
X-Google-Smtp-Source: AGHT+IHq3PQR7DuKsJt8W3+b/RQ1TGGeaxxbLXe045yK1Wcs/qziqH3+yVverrmUbt0YBMuLoV6p2g==
X-Received: by 2002:a17:902:f689:b0:21a:8769:302e with SMTP id
 d9443c01a7336-21a87693e51mr106235365ad.14.1736448498359; 
 Thu, 09 Jan 2025 10:48:18 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22e4aesm1077595ad.162.2025.01.09.10.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 10:48:17 -0800 (PST)
Message-ID: <2b40af08-d13a-4815-8401-cbbaa5e06feb@linaro.org>
Date: Thu, 9 Jan 2025 10:48:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] semihosting: add guest_error logging for failed
 opens
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250109170619.2271193-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

T24gMS85LzI1IDA5OjA1LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFRoaXMgdXN1YWxseSBp
bmRpY2F0ZXMgdGhlIHNlbWlob3N0aW5nIGNhbGwgd2FzIGV4cGVjdGluZyB0byBmaW5kDQo+
IHNvbWV0aGluZyBidXQgZGlkbid0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5u
w6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBzZW1paG9zdGluZy9z
eXNjYWxscy5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9zZW1paG9zdGluZy9zeXNjYWxscy5jIGIvc2VtaWhvc3Rp
bmcvc3lzY2FsbHMuYw0KPiBpbmRleCBjNDAzNDhmOTk2Li5mNjQ1MWQ5YmIwIDEwMDY0NA0K
PiAtLS0gYS9zZW1paG9zdGluZy9zeXNjYWxscy5jDQo+ICsrKyBiL3NlbWlob3N0aW5nL3N5
c2NhbGxzLmMNCj4gQEAgLTcsNiArNyw3IEBADQo+ICAgICovDQo+ICAgDQo+ICAgI2luY2x1
ZGUgInFlbXUvb3NkZXAuaCINCj4gKyNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiAgICNpbmNs
dWRlICJjcHUuaCINCj4gICAjaW5jbHVkZSAiZ2Ric3R1Yi9zeXNjYWxscy5oIg0KPiAgICNp
bmNsdWRlICJzZW1paG9zdGluZy9ndWVzdGZkLmgiDQo+IEBAIC0yODcsNiArMjg4LDcgQEAg
c3RhdGljIHZvaWQgaG9zdF9vcGVuKENQVVN0YXRlICpjcywgZ2RiX3N5c2NhbGxfY29tcGxl
dGVfY2IgY29tcGxldGUsDQo+ICAgDQo+ICAgICAgIHJldCA9IG9wZW4ocCwgaG9zdF9mbGFn
cywgbW9kZSk7DQo+ICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICsgICAgICAgIHFlbXVfbG9n
X21hc2soTE9HX0dVRVNUX0VSUk9SLCAiJXM6IGZhaWxlZCB0byBvcGVuICVzXG4iLCBfX2Z1
bmNfXywgcCk7DQo+ICAgICAgICAgICBjb21wbGV0ZShjcywgLTEsIGVycm5vKTsNCj4gICAg
ICAgfSBlbHNlIHsNCj4gICAgICAgICAgIGludCBndWVzdGZkID0gYWxsb2NfZ3Vlc3RmZCgp
Ow0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBs
aW5hcm8ub3JnPg0KDQo=

