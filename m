Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27311606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m6zuk4Pz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRigJ-0004pD-KX; Thu, 12 Nov 2026 23:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRigI-0004p4-Bh
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 23:14:30 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRigG-0004g5-Mv
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 23:14:30 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-93efc0452b5so26988185a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 20:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794543267; x=1795148067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pRXzYIV5qDRL0NYGCmZFMfgPU/mZJwA/6wSyhSiaj+I=;
 b=m6zuk4Pzu6KjUp5B5zuNOxuB3mQdfwIhekafTc0OwdqagQPAaM5KjoVA0P0QNxB/kG
 J9Pg2bnyaTCr633oMgGNv7py2OgDDV8vgQTnMO0tWyDbu3iKuqBPWvkI7ZYmytFPiBQS
 u68c0fhGJuRc02i4NhNY/aT85C2d93V1uBq1Ee6J1abTuKGDUalTE/0F3OHERZblV6DQ
 2Ds7DbtBBkjSouMIG4zC2R8sBx5/7oOzupOlQeAQOosPsiAYRtM/CXl/Lh0TExNM403W
 XUNLFeYutRii9GHax0TszE7eP2+YqFVFqwnVFyW2wYxpLkHe0h8yj2T5HZZK6wt/L/vS
 ZBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794543267; x=1795148067;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pRXzYIV5qDRL0NYGCmZFMfgPU/mZJwA/6wSyhSiaj+I=;
 b=vkvRftEA+PC7dCzscbG8DJLfTOJnbX5K6sIMQvmd1VmTW7YtPbRNB6Cr8oXSNZ+TCV
 RD00lLJySeC5TneEUT2dKye9/2Dv+qCNdn4Zqw/nBrzg14dTec/Nb0TWlb/0EfYtPWQG
 yxV2dbZtc35U/5Q2VL64h+F4743W+Y415tm7a05jN1THPSk2kcLcyO20fo5Zid1gdlth
 Y/UvxN5owWINyu4Niqz6vpEHb/YxlfM7PuI1wR0wOFIRA78yghWjkNMlfoswIefa/N67
 3kgwIAPNtL+v/fAAj97Q0Azmtov39cXNdJqatg6ASLBCj2E69mstHQ1YHxNWDQ3P+zct
 J+tQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHYvV6vpEpQg/qOSo3uiaxWZE+UMkkq5y9kd1RD29F8kmsi9M7lDER3KMrd0kt9IJCslRrBPWMjLB9j@nongnu.org
X-Gm-Message-State: APuU4Z/pwAAjl8l4q/6cMXNt/TSuh10+rr/k2jUj8jjHJhVqEQjNepXO
 wSDPiCHazt79ZnoxpfF2cOmztB0Ef4shLIFWUwB4duGh+2Kw2ALoAKwfwxfjQqUdvE0=
X-Gm-Gg: AYBFou2mYU8nrNFCopnW1pr89ojwG27CFmekM6M5sIpPN5QOjH+Ubn1NdiUwIQ4AFBz
 8ROVFEKyHu7K52iSblUhm2xlEWGF32XdeYOgzGioELmlUpRVsELQGSwheMqZDEaaANhL3foswkH
 R5Ifyzj56SRPSpu78P6NjILreSYWimvWSY5wvAzdW2QEv9o87PEQfZdMKnTOJcNcoiM9i8wQw46
 I/EfzcoXdVTFW3ofJhok2xAw2SAWWlj2Ueuzf8l6Q0x8wFa8aJcFMcgZ6Re4EtwEUCNNnmh/gbI
 a+ej+DQqYzvBym2/lVyl/Rtqejw+vK54tjHw3GZPboT/7B1DFrg/mON0h95oI05UIZNSdsOecUn
 dDc/0MoWi10mN0n2hfG7pbZRv8uMcDzRm2KFQFDgdjQXDHTrG7EzFr887nrH94Y738zxVEqe3l9
 e3/1p9XjIr/e7txZd5t04QcAzdSwtExI7iz/x9Clh2Kg6zCJyc1dluSGLi0UGVImZkcwPYn+43u
 ugWpfG9E3Ea4kKuS1BKw0XwZLfBBZ3N5escOLealymVCR+AvVm9+FZP3rWxsxQEJQ7L8siUlyx+
 +leXC7R6g0hvlLIX1Lg6f0N9Yx69m2DyeMbpHeA33uo=
X-Received: by 2002:a05:620a:3941:b0:93f:2236:a61 with SMTP id
 af79cd13be357-9494bc4ab53mr252387185a.61.1794543267130; 
 Thu, 12 Nov 2026 20:14:27 -0800 (PST)
Received: from [172.31.6.239] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d73258sm11525366d6.24.2026.11.12.20.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 20:14:26 -0800 (PST)
Message-ID: <d0ebbc3f-465a-4e9d-a138-166b244e7dc2@linaro.org>
Date: Thu, 12 Nov 2026 21:14:22 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] MSHV fixes for 2026-11-11
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Doru Blanzeanu <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261111204155.36683-1-magnuskulke@linux.microsoft.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261111204155.36683-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 12:41, Magnus Kulke wrote:
> Various bug fixes for the Microsoft Hypervisor (MSHV) accelerator.
> The fixes have been rebased and re-tested individually.
> 
> My public certificate is available at:
> https://mkulke.github.io/magnuskulke.asc
> 
> Primary key fingerprint:
> 5255 B617 7982 9168 7022 31CA 68D9 BB56 DD17 8417
> 
> The following changes since commit 29760efaf96bbe5928f8111881eddbf5ac06439e:
> 
>    Update version for v11.2.0-rc0 release (2026-11-10 14:47:54 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/mkulke/qemu.git tags/mkulke-pull-20261111
> 
> for you to fetch changes up to fcc504b77076b936ce79e33d9be68d6b73cc5dbe:
> 
>    target/i386/mshv: add MshvPutState for vcpu writes (2026-11-11 20:51:04 +0100)
> 
> ----------------------------------------------------------------
> mshv fixes for 2026-11-11

Applied, thanks.

r~

