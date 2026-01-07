Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0747DD0D17E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 23:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdcvh-0006wt-Nn; Wed, 07 Jan 2026 18:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdcve-0006w5-5K
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:27:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdcvc-0004mk-GN
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:27:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so25184725ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 15:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767828417; x=1768433217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GIzwcNfYvu5EJRSG9kzfYF+RXja7NfhMzY0q4WYCaIg=;
 b=W9g/XvKbt55gJgwb91Hn2yLT0Ejo1homL7X+K23VrgGqjOciB13KB9md28L9WZ10g4
 RzZjKBswGY+5s/b0vfGmWPePp3UqQKSFgVD4VRf7KKrcu7BOSHlIKkDX1P8JgC9AVgNs
 kn/PvMFnaTjWag33fXLMNSGXkichQ4UcYRsGL5x428mGNBZyK/5EB1ksns3+0GPNJYIB
 WJqppjBq2IDj9IIdsBl0VTQgEVHTCieb7kSpe8cssmeJZ1culX0bzcYc8A7KQ7MZBWU4
 94Pb/8wBF5KCXWZfwRrbJV4rCE5IxMC0dcb1nYLQ8PxQjfIH8BFuwInduyiyQn4/xf8I
 O3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767828417; x=1768433217;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GIzwcNfYvu5EJRSG9kzfYF+RXja7NfhMzY0q4WYCaIg=;
 b=Kf155u0iE0vkx/sN1f2qG+dtjZzfzVVCl8k9HejDPBynRHo8qW4gSK2tMkZMJfrtfU
 D49D2qCnFzH71tD0hVb+nyt9QyWAjULukgR4x1rrZksduVdjIHPnIoskCrjhOhSGjfNU
 HL1aLiaI3he6TDkUW1dLQqN5KvT2m3nJ2lkUkKKbpgv4452l3AGhkBSDNWMBBipP+9ML
 jXmy3DA4Rmb5xi2c7W/727HAmB4sn/u+XBPZIx1FV9oHEJYWbguszWwfUOTIBw0We4Uk
 zi5sWlhnNezfUBb4UkWtshEFXCc+tW2Mxh1wh+mC3kj+ZkPK+DN48h6RFYWozgXQoVLP
 O3lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxDIFe45h7+ODUANy5f988S4bhh1m/IzGXJR/xGfJiu/eTElgCVThhbuUMqxgLu6LDRrAvo6+vymp5@nongnu.org
X-Gm-Message-State: AOJu0YxxsnUYIIaaLQ+7mlwiBe8xmyU98/6xYY8SpmtCR5lE6YdNaI50
 PKduCPisAvPHDfFvEM5GPl6+wOy3xLDCyd4ihncRMgOJ38eV1pTk4ke66XMW5D58MVc=
X-Gm-Gg: AY/fxX5JawWBV8fPbcLkUW4jxSMK8u1ABCqCWze66++XC/AMkl0N8JvKfDfyBDtu2Oz
 P8WEHOZy0fyqi2Uieu0jiif3NcXNal5jYpVtUebLpmZiZRuSdJ4oFkpxqhxS/rbuJ8Ai46w72+z
 4eb06H5Bldk07IwsdhFm3NnVpqf6AJ829NEaL7K2uBe1c3v3dx8+hdULnF3xg6HXqkjZy1MWdd2
 13v8UuE2fRAL3sCBkK/Iq5FOk74bkC/JN6F4aAiqAN/DQFJQMJWAnsaLxvO6bNfZ1Bm1HkxWT6U
 z9VeYEapXeRMQWq5Pjuzxmb3KVNNnyEbDcH9m/l7utoB1rCByfIeViy8PsG6eG61FmK+au7FczA
 nXapHFp9NgIgUINShXoid5y5RIBHSrve9UmXDSgcOkypgEMCB5ndrzA3vOy+FiNQgZWzGV1UY0a
 G88St4X7BxRMrvqdCwsn59GltUbTGhvQ==
X-Google-Smtp-Source: AGHT+IHz/pRLdNdHEgWMdo0gCkuduGvy/vvofcg5pm5HGODMufSVjGHB6FZa4RbogY6U0DYRrd96WQ==
X-Received: by 2002:a17:902:d4c8:b0:297:ebb2:f4a1 with SMTP id
 d9443c01a7336-2a3ee4e82efmr34094315ad.38.1767828416706; 
 Wed, 07 Jan 2026 15:26:56 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e7a3c6fdsm49943715ad.15.2026.01.07.15.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 15:26:56 -0800 (PST)
Message-ID: <6d2af03d-db4e-48d1-a4ed-0b9a8969e7ba@linaro.org>
Date: Thu, 8 Jan 2026 10:26:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/i386/tcg: remove dead code
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260107151400.273916-1-pbonzini@redhat.com>
 <20260107151400.273916-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107151400.273916-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/8/26 02:13, Paolo Bonzini wrote:
> Remove dead code; it arose when I noticed that, because 0x3? opcodes do
> have a pop, case 0x32 works just fine as fcomp (even though 0x?2 is fcom):
> there is no need to hack the op to 0x03.
> 
> Reported by Coverity as CID 1643922.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 7c444d5006d..460848e4223 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -2543,9 +2543,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
>                   break;
>               }
>               break;
> -            /* map to fcomp; op & 7 == 2 would not pop  */
> -            op = 0x03;
> -            /* fallthrough */
>           case 0x00 ... 0x07: /* fxxx st, sti */
>           case 0x22 ... 0x23: /* fcom2 and fcomp3, undocumented ops */
>           case 0x32: /* fcomp5, undocumented op */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

