Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E41606A31B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dO8CF6NY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xONDP-00055S-Tf; Tue, 03 Nov 2026 17:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xONDO-000551-0T
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 17:42:50 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xONDM-000322-BA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 17:42:49 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8a070781f63so67355b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 14:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793745766; x=1794350566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CyIn1hvuV//14ZcizxnbsnDVMkJnnWWmAzbTH+nS8u8=;
 b=dO8CF6NYx5hXZuP8/DhJ2GSNfATJ0vLkuOUjLQoUpIR+GmhFavdI09wiepbuoqsqj5
 iab3Lb2IApqcQq9CyBXnc9vTeusdY8IXnzCmwSVRXpFQFCsezD44gTHIRBupKLf7Lfg+
 Lyvq1S50SJaMuCG4JY9t/HiSNP9DgQehznVQbYkfE8KZhAb1TlNCS9rbR/6XIF1YcCAl
 ip89AivHLVhvqeX+qAyVLW9ugJAxpCC8GTIqfC8+k7NPdcPNL77cM7TdPMJG1LMUiwJS
 ObUASK8Z1AWmLzv/SqhiwLcEzHN7qfSi/JT/ALeW0x8NvLDtRD/FoQMcpxyEo3tGulC3
 Tvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793745766; x=1794350566;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CyIn1hvuV//14ZcizxnbsnDVMkJnnWWmAzbTH+nS8u8=;
 b=C4zLsD8M73cY1vgz+UoXBDPGBxb49iIEynkkcGXCscY4t8MLq3S0/SYsIIxWe6JUIz
 82oX2Nae98cxJxH3g+iR+hgg7xeCVlw0PlAmN0DmZJTmw7cwG/Na4KFXzucrytaHAiiW
 VDZvNSkmSvDHj18txHxrAiK4zR8QHkt1FlCPSFnLFeU7UN0Q2rf6Yy2Agt/4TIJqPlt8
 eY2N9zJiI1fH+w501bF4FFWucPL3TmavBRajG51aIf2OshYcoPOm6csjMtzaynQmMSWm
 cKxM0/oaWhemQDtTg9QF6AA4zgR5cz7njs7h6RuMWOuueQH1f2tKD3GDWdObkhm6DSdP
 +xvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXjFUg1yzUqmBAdpSBjacczVjx0Q31RrckIKO597dODDkITZPndUYJjAkA9C2hOETpWHwbMmNQWoW1@nongnu.org
X-Gm-Message-State: APuU4Z+ZhmrOT4bg9m3CLMb59egHD2FrBJOt82OPAjJ8HhDeqC42t7EM
 yJDe5HEDUoM3Oh88GSL7Bw9AAopo2/M1L+vrGQuuqf06+T0E803fPtWdrDjNgjQrsqM=
X-Gm-Gg: AYBFou2pq3ePnPcA05zyn3+8RzJk9bv5ZqyL7qcIKALHk1MKMFLPEx0Z3ylK2N9WM3G
 HtQBxcvYqZbMlcdb4FqdnhGog9u3U1gEDGIh/8Agbw3p14wtOv9qcFryrth2KpZiL2qN1U1Tphl
 Gm6bJxwnDU1QraUmAadHp/a0riy5dTx5H6c0sP0Lrv+IM9vSIFDQm37w7p+xTHBd0SJ+lQ6KsX7
 0Vs89tHLD+mQBFakOVQQbahfEKieT40mV+6VpQBwov0FfRohyX19hHFXjoPm0xkOItwIOf696dK
 suemB6Wwc+dn68YBVIGqZR1Ckx/39+vVty2SSbQA3X77jL81CJYUsIMe0SaOrABEBSsMAosfet7
 tbteTXaIfkE5C/FXVCWVswwhicvGnuRtp/FmDCzkPXdwEw9bFy6ShygIgiAoPBiwtK34K+Wx517
 a9/z3d85BK2Ofs6p0T7uH6lxPEQkWvyxbPHRRyF9rrLJQtqBcCAEB/umA28hu2udvXfRXbFA/Fg
 NXvpt8BrompjPxMLEzK7DVQ0zKGa88nM41dDMuYPePmcp7Sa632kdzeEfbdxNfka4uAAoZtJr2f
 uXZbrSXOvmgbDJrQZ5TXjPMfAknD5sbj5IkqnsDiKDuUa2eG7Lzoa4T6n78qfqRIYm8B4w==
X-Received: by 2002:a05:6a21:3a82:b0:3e1:d99a:8e82 with SMTP id
 adf61e73a8af0-3e928aacaa2mr12185895637.3.1793745766185; 
 Tue, 03 Nov 2026 14:42:46 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09bc3d1f2sm138541b3a.50.2026.11.03.14.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 14:42:45 -0800 (PST)
Message-ID: <b1eecf8e-1df8-4195-9bd9-2559d5ef63b8@linaro.org>
Date: Tue, 3 Nov 2026 14:42:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] pci: fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1793706601.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 11/3/26 03:50, Michael S. Tsirkin wrote:
> The following changes since commit 4075aa42daecf701cd3869da8b3271dc3c04a4b1:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-30 15:26:36 -0500)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to cc82fad46af62a3f5488538b6261eb7d54837294:
> 
>    qtest/libqos/pci: Factor msix entry helpers into pci common code (2026-11-02 03:52:53 -0500)
> 
> ----------------------------------------------------------------
> pci: fixes
> 
> pcie_sriov: fix for user-creation of VFs replaced by v2
> pcie sriov: a couple more robustness improvements
> pci: id docs clarified
> pci: a bunch of test fixes, robustness

Applied, thanks.

r~

