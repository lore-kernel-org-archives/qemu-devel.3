Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E659C27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHU3T-0003Mh-S1; Wed, 12 Jun 2024 15:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU3P-0003Lm-SZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:54:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU3O-0001tr-3z
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:54:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f8395a530dso2985655ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718222080; x=1718826880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=014mCvmsneMMkuLx+Xyiw1WdgpnbnmCM9FvWncbYNgI=;
 b=JtOe9FF0S2d20uc+P4prQAqxCKhV6R8mX7Y5fIFEfBwRl7Cm6JFQfIIfjd78JHgmQr
 tNmKACx5IxS4vhWli7BFYzds79TxSF8m87r5M1+QMjMIGJXGEUSQp+a+m0LOZGeP+coC
 qB3BOMECohSYd/BNWh0+gqtoEOue4exEA/01de7Wrj+T8BHCrMGllRuErOt+Uwxf03vD
 +g2VUL31E/J/jj+q/l2vtx63jKclZiM4LW1/zCxC2wXUbtcGpwRzHn4sUQDf8N82ImTr
 kMEO9v4hKFVaQ/q0TV7OJ/m4jMaVURM5QqumpTW7DqGZKR3PU7RHqcZTbSGvwnwov4Nh
 jo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718222080; x=1718826880;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=014mCvmsneMMkuLx+Xyiw1WdgpnbnmCM9FvWncbYNgI=;
 b=cMFbb7cx8dWB9eQ45xO+UygSED6AG8xeUSn+FVGTJimQK8L9W29mieQg5bZkpeLkdh
 G7Wt1VH1LwJbI+o7PxKOKwkynZd8lmJBBNlVrKbQRNTjSiKqwmXDBAESuRVRgr6nrZkU
 H3wBZp7xAUquFAWKPexqeCdaUXHlDpUvWFB6YxxOwVm629EErpf6JeEZTaQMw0/VmRAC
 +wCckxT+15E64fPlzyXFhgj9w05T6EIgD91cigd4CAzUsWvvxf+u6f2mVnro8rMxypF5
 SkXNvxLf7x69DGdruE6AAcCuO7A2v1hi6ljKX/xzIFaEw0V70uXykOZTmlWbxe366mdW
 Va3g==
X-Gm-Message-State: AOJu0YwedXEJRoHJapYZCU4814Y9Gq0hBAC1WlIn0ji8iyCWdAYd6viw
 3/p++sYewdUFo8vof13wa+/eH1zmdSVBh87wBb2FFmY+xBB4QP/v3x4R9QaiRr0=
X-Google-Smtp-Source: AGHT+IFiZMLDHj1AGhVp8Sgaq2CBrQxTQCF/xc8ZKCR3TczAc73j+H0Z3wRTa2yTgiR8xyhFeQrcYg==
X-Received: by 2002:a17:90b:2250:b0:2c4:b300:1b4c with SMTP id
 98e67ed59e1d1-2c4b3001d74mr1876019a91.24.1718222080434; 
 Wed, 12 Jun 2024 12:54:40 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a7602690sm2256310a91.28.2024.06.12.12.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 12:54:40 -0700 (PDT)
Message-ID: <ec9ded4e-4a06-4472-84fc-1942010b34c8@linaro.org>
Date: Wed, 12 Jun 2024 12:54:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] plugins: add time control API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-9-alex.bennee@linaro.org>
 <abe88b9b-621a-4956-877d-dd311a7fd58b@linaro.org>
 <87ikyevtoc.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <87ikyevtoc.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

T24gNi8xMi8yNCAxMjozNywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBIaSBB
bGV4LA0KPj4NCj4+IEkgbm90aWNlZCB0aGUgbmV3IHN5bWJvbHMgbGFjayBRRU1VX1BMVUdJ
Tl9BUEkgcXVhbGlmaWVyIGluDQo+PiBpbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaDoNCj4+
IC0gcWVtdV9wbHVnaW5fdXBkYXRlX25zDQo+PiAtIHFlbXVfcGx1Z2luX3JlcXVlc3RfdGlt
ZV9jb250cm9sDQo+Pg0KPj4gU28gaXQgd291bGQgYmUgaW1wb3NzaWJsZSB0byB1c2UgdGhv
c2Ugc3ltYm9scyBvbiB3aW5kb3dzLg0KPj4NCj4+IEkga2VwdCBhIHJlbWluZGVyIHRvIHNl
bmQgYSBuZXcgcGF0Y2ggYWZ0ZXIgeW91IHB1bGxlZCB0aGlzLCBidXQgaWYgd2UNCj4+IGdv
IHRvIGEgbmV3IHNlcmllcywgaXQgY291bGQgYmUgYXMgZmFzdCBmb3IgeW91IHRvIGp1c3Qg
YWRkIHRoaXMNCj4+IGRpcmVjdGx5Lg0KPiANCj4gU3VyZSBpZiB5b3Ugc2VuZCB0aGUgcGF0
Y2ggSSdsbCBqdXN0IG1lcmdlIGl0IGludG8gdGhlIHNlcmllcy4NCj4gDQoNCkkgcG9zdGVk
IHRoZSBzZXJpZXMgPDIwMjQwNjEyMTk1MTQ3LjkzMTIxLTEtcGllcnJpY2suYm91dmllckBs
aW5hcm8ub3JnPiANCndpdGggdGhpcyBmaXgsIGFuZCBhIHNlY29uZCBmb3IgaXNzdWUgcmVw
b3J0ZWQgYnkgUmljaGFyZC4NCg0KSWYgeW91IGNvdWxkIGludGVncmF0ZSB0aG9zZSBpbiBj
dXJyZW50IHNlcmllcywgdGhhdCB3b3VsZCBiZSBwZXJmZWN0IDopDQoNClRoYW5rcyENClBp
ZXJyaWNrDQo=

