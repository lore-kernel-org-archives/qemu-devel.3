Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54430EF06EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpHCC-0008Iw-4J; Sun, 08 Feb 2026 21:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpHC9-0008H0-9z
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:40:13 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpHC5-0002lF-8b
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:40:12 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aaf5d53eaaso1601885ad.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 18:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770604808; x=1771209608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jgQwmBPbpDMi0njIL8aQhufwlpoFZ3zV0a89BTmUKYw=;
 b=DTXH86k985sYh1HY1pMiqlVgfYGduOE4TaUWkTHPk9kX07H2ElJkJjuPCzsd2X3ddj
 l5025J3eXXB6I2yJX8KosH8WzVZ4ovSrBUYWSiithKTKLC/0uA85rzSv2CEnmGLNKV0g
 sBzmFEYtF5mW6MzyU23A50HkSsNDfovZktyRXxXpxRjf+a5ZvYfn75xa6KhE/84bL+NX
 MA9JAhkuq+Rscng/7PS0tI8Q5RW24yFb1Z23lsoSl9kaO2Yru//PVBqJ3vtk2Znpj8/g
 yIEJRmm2LPQYZllAplAFjy+YUGrcE/92BSF4DUWniGYgW7fbRY9VaPEPl8B5E3PrnaGL
 iH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770604808; x=1771209608;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jgQwmBPbpDMi0njIL8aQhufwlpoFZ3zV0a89BTmUKYw=;
 b=mpgZkfTLCTdX4Mr6mBKqjsYS5+MqmkIYMc926RgFHo7N5Oem0Xqd5FXqaYU9ZEmrH9
 HAgpFLkueHhM6U7RuDHrm8vCvyGqGm2YK8tz5a4mMp18XCflzDzHrFD2VSj1RqMnyudM
 3r56H7RhjaPeoKlVMu8yUatfdgiOmCv+/4zzMZnc1yRQh3mLrUV8Mx0HPyTMVsIkRHui
 3t36+5uWH2zt4irys6T+dw32+qp63j812TUdNfPAjf/1bbm1+6Ylag0o2gfMDMtaGAWz
 DurvivPf+YA7vY4vrp3Y0rnAb3/WmJNgFqhLv/9s3gOEWb7dSM64+SrzcdDkDva7QFse
 npcA==
X-Gm-Message-State: AOJu0YzKedn0PmQKFsnf7MedsCKOoHXw+Y0WqnqDBbWvPjy59DTu5h3s
 ASNKODaWjKoqVKqJISi1RJfwaDKayOoVnT+xgbQU+OOfPxoZ3gPcvxeG9O3HSDBsNdOF6hBoS0o
 TjW6Gm1A=
X-Gm-Gg: AZuq6aILk+tTD00KDfqhgsLolr/eAPLlFE2Cgvvuk0KqJlyTioFtzuXVhIOdKCE7XGk
 MUT/mBa208wS//8ZJkk3jIvpsbb1yOdGUjEtd6fyzr5IAMjDz1cWj2sDH1xjiA/b06zRyIS0xR0
 DSvze2Pb6+XGw8W4KMJdclnmmowQT3NHEQKetN0tqJvbX/bF+1HDaqhltDNBhxKuSjfOfboQBF3
 REiIW/GPho0DKODrS9danAwt+KWzeDieFMj3Wyn5glwbgAlCO5WdVcZIVInQeZ9rtLc/+17YylU
 k/hLrARAy1BXmVqFOotw0UcmiteBM2R5lc/dPH4m6Y00suiM0E4d0gBJM+LEfn+thHFnS1E3fQ0
 XI0pPgx9SdCiK2htWkgrv5gynAJ2O2kpAW1q/H8KiFAz2krlIHMmVZBKcrl9474pX4ThCg+Dktp
 +3RnQTFTD1M8+QBz80dz7kSTPkpz9RgGjTlqc94MAQXdJrVXMoBKNe1+gXvO3027U=
X-Received: by 2002:a17:903:2f4b:b0:2aa:d5ea:4cfb with SMTP id
 d9443c01a7336-2aad5ea4f5cmr38186335ad.9.1770604807390; 
 Sun, 08 Feb 2026 18:40:07 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951a644a6sm122204205ad.8.2026.02.08.18.40.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 18:40:07 -0800 (PST)
Message-ID: <0a9d5151-df73-4e9e-9dfa-dfd2ae8cf483@linaro.org>
Date: Mon, 9 Feb 2026 12:40:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/24] bsd-user: Implement System V semaphore calls
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-22-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-22-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/9/26 05:26, Warner Losh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Wire up semget(2) and semop(2) syscalls to get System V semaphore
> implementation, as well the undocumented __semctl used to implement the
> bits of the interface in libc.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

