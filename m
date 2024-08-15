Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B24FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seegV-0003jB-Vj; Thu, 15 Aug 2024 13:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seegT-0003hu-Tv
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:54:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seegS-0004M0-AJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:54:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so10883625ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723744486; x=1724349286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2YKSJ2n8OS/IVEPWotzaXg/8leJ6lDGmmxdPVmQ8FW4=;
 b=KQ9eKbLNtupRgEm1wEE4yWZwWi+t/vRaCazrDKPe5e7xz/5XL2inXxvuJ8MlFwfI67
 W4Vun+/IbX0FObHqK9Xut1H5GP87cklBiKYoXNzm9uWYG3EqjwdvCiOtKh9o8UofqNQ0
 5zc7bdyyS11OA0AiJPQFfMEShPjzwNRKPU1V46WAO4oqseRkuhBhpDADaHzVnWDCr5oB
 vJ0K5OGWrEkVvHruw3TUihX+EWFt8u40iEvMfGiuAUkJ5l+Xje3rnci4hVZ+ZxwCGDeH
 NXIO93dF2NPW4tp3HbH/h9lBGlhs49CBVerOv2eDxFIg6ExkqA1kgNzwQDsGFNTZ2e89
 Tw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723744486; x=1724349286;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2YKSJ2n8OS/IVEPWotzaXg/8leJ6lDGmmxdPVmQ8FW4=;
 b=EBYIRHqDFA3aFwhV3ZZ5HnjkLk9ElEDJHSMxky52/dex5rYix/YJEhQAfTO6CkQHEk
 spUOf7McCAh1VUyE9G1fKi0V06VpOQCX7nmC9Jf13rqtPHLzIzwyzLMRA0PF/3vMdYFM
 eqYJjf48/iAdhHRpIopZ16yIxVQMbpE92fu5KPK+HLk+aQ4lHSGzfEES5wsmeZ1Rw+Sj
 WncYNYcmBGTRitwfIPA9X1pP8fUDZppzFOokUb4+tS82qKh6GrZIA+Zk+3AsauibAL2O
 lWoFGw7Qg2AUYMDq710pwoXEK9uEDhT6UAfxXJNMtoACd8GrRWyLM8lny1JxNjRNFM/V
 5bKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl4SbVrAkPhAHrbwsEVi45dfsE8lFj9wr2hQ3Ai8jGcSH0GU+zHJK0dmDp92XK7m2PIFlyNb7ZMP+kCRokQ9hEK0v4j+4=
X-Gm-Message-State: AOJu0Yx4okpEhlRZAU6xi9j4E7G9PDt1oA/8Lx3l5a9ul7WDtdv8ZtDE
 2Mu0H3sKY98S02lIMd7iwV6Bal7wL2ikmnSHutQTkYqydfArzQARV2kr8jD6NX4=
X-Google-Smtp-Source: AGHT+IGMQqCJqnKW2gjSndaYQi9xoii055n1pRyA9QIu2ijf7Iitiam2BinlQZ2bNY5BIjXEaZaMrA==
X-Received: by 2002:a17:903:2307:b0:1fd:9590:6550 with SMTP id
 d9443c01a7336-2020405f461mr6108655ad.64.1723744486179; 
 Thu, 15 Aug 2024 10:54:46 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038df95sm12675915ad.227.2024.08.15.10.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 10:54:45 -0700 (PDT)
Message-ID: <2f025274-5b25-46a5-a745-6b0647dd677a@linaro.org>
Date: Thu, 15 Aug 2024 10:54:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/i386: fix build warning (gcc-12
 -fsanitize=thread)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-3-pierrick.bouvier@linaro.org>
 <efd7aaab-081c-47b1-b0f5-6a959f04c9af@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <efd7aaab-081c-47b1-b0f5-6a959f04c9af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gOC8xNC8yNCAxNTo0NywgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDgvMTUv
MjQgMDg6NDEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBGb3VuZCBvbiBkZWJpYW4g
c3RhYmxlLg0KPj4NCj4+IC4uL3RhcmdldC9pMzg2L2t2bS9rdm0uYzogSW4gZnVuY3Rpb24g
4oCYa3ZtX2hhbmRsZV9yZG1zcuKAmToNCj4+IC4uL3RhcmdldC9pMzg2L2t2bS9rdm0uYzo1
MzQ1OjE6IGVycm9yOiBjb250cm9sIHJlYWNoZXMgZW5kIG9mIG5vbi12b2lkIGZ1bmN0aW9u
IFstV2Vycm9yPXJldHVybi10eXBlXQ0KPj4gICAgNTM0NSB8IH0NCj4+ICAgICAgICAgfCBe
DQo+PiAuLi90YXJnZXQvaTM4Ni9rdm0va3ZtLmM6IEluIGZ1bmN0aW9uIOKAmGt2bV9oYW5k
bGVfd3Jtc3LigJk6DQo+PiAuLi90YXJnZXQvaTM4Ni9rdm0va3ZtLmM6NTM2NDoxOiBlcnJv
cjogY29udHJvbCByZWFjaGVzIGVuZCBvZiBub24tdm9pZCBmdW5jdGlvbiBbLVdlcnJvcj1y
ZXR1cm4tdHlwZV0NCj4+ICAgIDUzNjQgfCB9DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4gLS0tDQo+
PiAgICB0YXJnZXQvaTM4Ni9rdm0va3ZtLmMgfCA0ICsrLS0NCj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL3RhcmdldC9pMzg2L2t2bS9rdm0uYyBiL3RhcmdldC9pMzg2L2t2bS9rdm0uYw0KPj4g
aW5kZXggMzFmMTQ5Yzk5MDIuLmRkZWMyN2VkZDViIDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0
L2kzODYva3ZtL2t2bS5jDQo+PiArKysgYi90YXJnZXQvaTM4Ni9rdm0va3ZtLmMNCj4+IEBA
IC01NzcwLDcgKzU3NzAsNyBAQCBzdGF0aWMgaW50IGt2bV9oYW5kbGVfcmRtc3IoWDg2Q1BV
ICpjcHUsIHN0cnVjdCBrdm1fcnVuICpydW4pDQo+PiAgICAgICAgICAgIH0NCj4+ICAgICAg
ICB9DQo+PiAgICANCj4+IC0gICAgYXNzZXJ0KGZhbHNlKTsNCj4+ICsgICAgZ19hc3NlcnRf
bm90X3JlYWNoZWQoKTsNCj4gDQo+IFdoaWxlIGEgZ29vZCBjaGFuZ2UsIGFuZCB3aGlsZSBJ
IGhhdmUgYWx3YXlzIGhhdGVkIHRoZSBhc3NlcnQoZmFsc2UpIGlkaW9tLCBJIGJlbGlldmUg
dGhpcw0KPiBwb2ludHMgdG8gYSBjb21waWxlciBidWcgYW5kIG1pZ2h0IGJlIHdvcnRoIHJl
cG9ydGluZyAtLSBhc3N1bWluZyBhIGxhdGVyIHZlcnNpb24gb2YgZ2NjDQo+IHN0aWxsIHdh
cm5zLg0KPiANCg0KUmVwb3J0ZWQgaXQ6IGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEv
c2hvd19idWcuY2dpP2lkPTExNjM4Ng0KDQo+IFJldmlld2VkLWJ5OiBSaWNoYXJkIEhlbmRl
cnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4gDQo+IA0KPiByfg0K

