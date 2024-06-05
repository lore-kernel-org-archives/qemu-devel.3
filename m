Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5C8C27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 19:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEw7T-0004of-T8; Wed, 05 Jun 2024 15:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEw7Q-0004o3-8T
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 15:16:22 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEw7O-0000TC-GY
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 15:16:19 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c24115469bso974797a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717614975; x=1718219775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=46x/zdKHXPUz14fyEOqeupcQ6ne0xLfjfTCuWkaUv5g=;
 b=SQ84EGpsapOSXcoK/DVaI3H/T8q7yqVTrkvJDuZYAX43fC7LfgqCJBH8zZ/V+tKHvG
 I1Mno6a8JNtAb6PPj1qsSs8DNvmPGPfj2g8T3A4LBhcGiZoQJZU0gkpefg5PiYGnucDg
 AxwUG+6tDHx/DUUgrM+kRJqdT8TEtMQEiA9ANrNc5dKIo/OOQC2efaYeRyv93Ax6wb5W
 ZnEE5/8R3OX/yYDPlmdCZ9MFmEOVdqVG9GeMP1R+8KC65te1qQGvB/oFliEogtfCvBfW
 ZnoPFo1ZMD+i5sJF+ZFWsCht2j9pWWktoFHNcx6XyFLXWXtYr5BIhm7/ax1yD1ip+Sav
 NRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614975; x=1718219775;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46x/zdKHXPUz14fyEOqeupcQ6ne0xLfjfTCuWkaUv5g=;
 b=vsOYyEhBgC6QABsvYMZM1lS8zZtgiGnJqzml4fZrxmDKYPBf/xsiKTzKkGO3YOa518
 hlOd0p9vk27w5VXWhfdZ3Ps+8tmHp6fp/zQfImmmYtrbd/QNCvl/VXdkv55RP+T/wCmh
 ZgYltMVHK5J1fZEyeIHkrmwEmN5nl5cR4Uum6sBivSOkU16mbqNqlFHNoP8xGegMmVSB
 yF4z9c7HbufgQ0rrJdAaKxHkPjZaktJtuSrjTnXOgjDv2OCRikYgEdib7+Jcoeb5aB1u
 O/RN/1wKxwrFJO5n+USU67aFZjZIimiJGuXT4JS/b3iLY82ENR15AU8cJJh0gjNxVReJ
 XaoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOmhBi0KzEQ7CWC719EKyekzsainiy2WnsbTREn7Sr8IYHBr0Kjdqs2TtCrebn86PHEys1RK3OihjVOwbpVVB+uX0GE9M=
X-Gm-Message-State: AOJu0YymRkNV6xIKP8Z0lpra1vxpP/2Ss91/7lACUSK9sALhXSpram3Q
 eo4/reRZfO4HbHotrRn5jRF4ygX8ITXmmSXvDmFl/zQknMtjEjRKmLljWeN/3TY1NZ3f9H0s593
 LoXY=
X-Google-Smtp-Source: AGHT+IHcipQQecpVBbVJOEG7f7V3qhdOFZDzPIwUoBIsncZtkpLYTu7HbCUHRR0NigEoz2AfkCw+7A==
X-Received: by 2002:a17:90a:dd45:b0:2c1:9ea1:630c with SMTP id
 98e67ed59e1d1-2c299973d53mr734370a91.1.1717614975283; 
 Wed, 05 Jun 2024 12:16:15 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2806be1cbsm1825363a91.37.2024.06.05.12.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 12:16:14 -0700 (PDT)
Message-ID: <626f7346-39de-4895-a92d-b7fd09bc18e7@linaro.org>
Date: Wed, 5 Jun 2024 12:16:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/28] linux-user/i386: Properly align signal frame
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, laurent@vivier.eu,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
 <d644678a-815e-4c49-bc65-15394bf897e4@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <d644678a-815e-4c49-bc65-15394bf897e4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

SSdsbCB0YWtlIGEgbG9vaywgdGhhbmtzLg0KDQpPbiA2LzUvMjQgMTI6MDYsIFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBPbiAxNS81LzI0IDE3OjA4LCBSaWNoYXJkIEhl
bmRlcnNvbiB3cm90ZToNCj4+IHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRl
dmVsLzIwMjQwNDA5MDUwMzAyLjE1MjMyNzctMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8u
b3JnLw0KPj4NCj4+IERpc2Nvbm5lY3QgZnBzdGF0ZSBmcm9tIHNpZ2ZyYW1lLCBqdXN0IGxp
a2UgdGhlIGtlcm5lbCBkb2VzLg0KPj4gUmV0dXJuIHRoZSBzZXBhcmF0ZSBwb3J0aW9ucyBv
ZiB0aGUgZnJhbWUgZnJvbSBnZXRfc2lnZnJhbWUuDQo+PiBBbHRlciBhbGwgb2YgdGhlIHRh
cmdldCBmcHUgcm91dGluZXMgdG8gYWNjZXNzIG1lbW9yeSB0aGF0DQo+PiBoYXMgYWxyZWFk
eSBiZWVuIHRyYW5zbGF0ZWQgYW5kIHNpemVkLg0KPj4NCj4+IENoYW5nZXMgZm9yIHYzOg0K
Pj4gICAgIC0gQWRkcmVzcyByZXZpZXcgaXNzdWVzIChib256aW5pKS4NCj4+ICAgICAtIFJl
YmFzZS4NCj4+DQo+PiBQYXRjaGVzIG5lZWRpbmcgcmV2aWV3Og0KPj4gICAgIDAyLXRhcmdl
dC1pMzg2LUNvbnZlcnQtZG9fZmxkdC1kb19mc3R0LXRvLVg4NkFjY2Vzcy5wYXRjaA0KPj4g
ICAgIDE5LWxpbnV4LXVzZXItaTM4Ni1GaXgtbXJlZ3Bhcm0tMy1mb3Itc2lnbmFsLWRlbGl2
ZXIucGF0Y2gNCj4+ICAgICAyMy10YXJnZXQtaTM4Ni1Ib25vci14ZmVhdHVyZXMtaW4teHJz
dG9yX3NpZ2NvbnRleHQucGF0Y2gNCj4gDQo+IENjJ2luZyBQaWVycmljayAmIEd1c3Rhdm8u
DQo=

