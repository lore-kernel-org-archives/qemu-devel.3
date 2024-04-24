Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139ECC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 18:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzhg9-0001MH-PO; Wed, 24 Apr 2024 14:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzhg8-0001Lr-RF
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 14:49:12 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzhg7-0007dN-57
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 14:49:12 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5f80aa2d4a3so178269a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713984549; x=1714589349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S3YoezPwM++88pXamL9qr5E2EFfvVj2MrzJGO5XsWb8=;
 b=ylu4Dvs4x3OJ0AxsWk/Ue5jDT7UUk8CVAnmluF3nOeMiaClpVHfiWzXnByriIq2SDN
 IK7EAnaUip3KpJ5UKOi/5A6iWikEvwSfOAcxtjkMNHFCOnv+YHQdwLacyeZIPxaAszIl
 5otdZWGyVNmw0mL2REC0G7af9Ocl/0HFnCaNnrm6WkX6wQrOz6Rgk/BxiYxOyZGaSaS/
 jZL8J7Ftm8nzvRu4Ukk8loDSMN4o4ffFj9QHtkp2R6ixOlnX40IpQCcvhgKKxFy6HWXB
 jPX000WNN8CpcK1I6kW2ItgoA1ybemJnzSsQgNq9L839RwfSSZZjBLytZqH6vwm8kiHV
 Eetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713984549; x=1714589349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S3YoezPwM++88pXamL9qr5E2EFfvVj2MrzJGO5XsWb8=;
 b=XJI/aqH1q3s3AY+NrzSBbJ2uHYaAj7wkPvSY7sbNMUSjmwkyKKw8QSDeKPuhdnSGsD
 Lfs4b53IzmaOqrkcOe/oNWaEWLptD7vNmYMmMBMblgoEAXJ7rdl46vNQf7hqMBFOjbkw
 JT8HWdU70bCpG8uYjdenV9OZzZm1MnufvRG2ouyajTdBYrk5qzS3SmN2kBZNvpvQUQRg
 n7r5swZtMNwWtHgGv6KjUSLkNxTqQHcDS8uEYoDpul5i0YJSlaep6KdA5eriWo6CrINS
 RCActsWI5TmD2f04kr/nQyDlxU/Zmz89HhTDzG1VT7eTN7u2EpqY2aIkBMJ5SIw1U174
 yGeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBzRQvKCybmzW/9f5hQnfxjpYFbsnGcYUmOLQtucQSv+tijkb1Z5lY5wLN7ROhIEV6/nai+PhVjXZ3QQLYFF945jhY5VM=
X-Gm-Message-State: AOJu0Yz4mm4MF5zdKb1xMyi2XZegKv0dapjaunlDvYjiFGsPtzSVXUuZ
 F5rJyEJoDyMqFSDh2VIOK8XAN3Antbx9VN5ce0viUxHholUKV3W4DOXa72QuHq8LMKABvkpCB8A
 e
X-Google-Smtp-Source: AGHT+IFgy2eMXvf3oy3EII6WvOa0l4Bg0U15RNprtqMaiUVNfYf+dsgd0ereA6njFSu1h1Uif4qImQ==
X-Received: by 2002:a17:90b:38cb:b0:2a5:24dd:bd34 with SMTP id
 nn11-20020a17090b38cb00b002a524ddbd34mr2917336pjb.27.1713984549302; 
 Wed, 24 Apr 2024 11:49:09 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a17090a7d1500b002a574ab7f5esm11520282pjl.53.2024.04.24.11.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 11:49:08 -0700 (PDT)
Message-ID: <7217032f-2d44-4c9b-aa73-1b97787de03e@linaro.org>
Date: Wed, 24 Apr 2024 11:49:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/63] First batch of i386 and build system patch for
 QEMU 9.1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240424081443.75869-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240424081443.75869-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 4/24/24 01:14, Paolo Bonzini wrote:
> The following changes since commit 62dbe54c24dbf77051bafe1039c31ddc8f37602d:
> 
>    Update version for v9.0.0-rc4 release (2024-04-16 18:06:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 7653b44534d3267fa63ebc9d7221eaa7b48bf5ae:
> 
>    target/i386/translate.c: always write 32-bits for SGDT and SIDT (2024-04-23 17:35:26 +0200)

Sorry, I've already merged v1.  You'll need to adjust the fix on top.


r~

