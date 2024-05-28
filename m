Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D88C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1zP-0000wu-3c; Tue, 28 May 2024 14:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sC1zM-0000w0-NI
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:56:00 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sC1zK-0006wu-UV
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:56:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f4a52b9413so8348875ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716922557; x=1717527357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xt0AgkvURMuCrgQ9OHuZXWOiip+lmcqM2Yhdz6/bdXU=;
 b=Fn92RgU1hpjvJW358DB/P0zTMVfR3yGahY43IU72jkljjyp9be9U695Uv4Ei/Fr26/
 XrUmONIiY1QrcvWujI2IdkenpcocZoU58dkUKA6zCAENGX/euZsWHo+8adAK2aS1OaBB
 AWwoZF8zv18EITIvb0j6NuhQg5mzIyTPxDfqLn3Gf6vAqa/JNGQ3acYUuFY4PrEWSpkg
 7qaTVbpYZEQf+8mTNgZVUCkcihHhKyRbMkqTn1rc4OHvHeKi+7lyv7RmEQ7Y8Qzv8aMe
 MnImUI1ztDqE2t7AL+dzR+jcKCd8TQWWQh0EXURQfkcw/TY4JBV/PZdIaT3LMTddVQpR
 EGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716922557; x=1717527357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xt0AgkvURMuCrgQ9OHuZXWOiip+lmcqM2Yhdz6/bdXU=;
 b=qOv+GxM9XGB4UkmD61QEsysr4i6o8kLknLHFhVaBcJqi25SuejNSArVNbjH5dh5wHD
 L2OfGSJt9ZY2tB2qwAQ5LZ1Tg9R2Rns+PXNORw8sZjPQoWTEI1RxAf4HICB6r2yHJrJM
 bELmaOkydKqZrqimmocUqqOcCRtiBhPWRDirdsWcklVsknqK5BvynobtQZNQDHemBirU
 z4O7ttfBOJqNenH+ciqE3AyIJ8KDxBHc7BL88FW1dsvwwXZWEg6Nx24SJ5ezKry64e0j
 BZnUguoQRF3//OCPl10hzgpKrZzzHIg7qaGAWW3c/KGH4Oe/A7Dq6QYngmS3DVIBeNvJ
 DBvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLkK18VgmZOlxCOoQ4mA2fHUIrkNCyy6Nqger4VrO6dwMBf18wOUKBhqxm4+9mJ6YnBeXCDJh0zSeGOtg2cZYtSXGRSak=
X-Gm-Message-State: AOJu0YxNvXhAKCGVfcMmB56DVirp5S778WqMF07ry1QsBfc9OHnmWsdt
 clz0EZTgwHU00rKAfs51aY2T5KeYGuSwUlRBap5C23xM/skiiOmYnmnJHZemHag=
X-Google-Smtp-Source: AGHT+IG4q8hp+0Zmu+3ZlO1Zu7lstZaEx+sLv70EBW7NcMC/05c1Usf8l+A3zM1IMkN8jnDhPeMkFg==
X-Received: by 2002:a17:902:e54c:b0:1f4:5088:33fa with SMTP id
 d9443c01a7336-1f450884f3dmr148123585ad.19.1716922557000; 
 Tue, 28 May 2024 11:55:57 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f4b412a5fesm33165005ad.239.2024.05.28.11.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 11:55:56 -0700 (PDT)
Message-ID: <badb9f77-de43-4ae6-bcba-8afdd8902409@linaro.org>
Date: Tue, 28 May 2024 11:55:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] accel: Restrict TCG plugin (un)registration to TCG
 accel
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240528145953.65398-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240528145953.65398-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gNS8yOC8yNCAwNzo1OSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6ID4gUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgDQooNik6DQo+ICAgIHN5c3RlbS9ydW5zdGF0ZTogUmVt
b3ZlIHVudXNlZCAncWVtdS9wbHVnaW4uaCcgaGVhZGVyDQo+ICAgIGFjY2VsL3RjZzogTW92
ZSBjb21tb24gZGVjbGFyYXRpb25zIHRvICdpbnRlcm5hbC1jb21tb24uaCcNCj4gICAgYWNj
ZWw6IENsYXJpZnkgYWNjZWxfY3B1X2NvbW1vbl9bdW5dcmVhbGl6ZSgpIHVzZSB1bmFzc2ln
bmVkIHZDUFUNCj4gICAgYWNjZWw6IEludHJvZHVjZSBhY2NlbF9jcHVfY29tbW9uX1t1bl1y
ZWFsaXplX2Fzc2lnbmVkKCkgaGFuZGxlcnMNCj4gICAgYWNjZWw6IFJlc3RyaWN0IFRDRyBw
bHVnaW4gKHVuKXJlZ2lzdHJhdGlvbiB0byBUQ0cgYWNjZWwNCj4gICAgYWNjZWwvdGNnOiBN
b3ZlIHFlbXVfcGx1Z2luX3ZjcHVfaW5pdF9fYXN5bmMoKSB0byBwbHVnaW5zLw0KPg0KDQpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8u
b3JnPg0K

