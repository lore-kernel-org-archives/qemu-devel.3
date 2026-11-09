Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016ED606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u8pspJbj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnoX-0000C6-FN; Tue, 10 Nov 2026 10:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQnoL-00009L-Oc
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:31:03 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQnoK-0004Hz-4Y
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:31:01 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso1210120a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794324658; x=1794929458; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zzUgmlUgI1srxgZ/TSxVCawsbtJ9k5U7vJfICGX2Q5U=;
 b=u8pspJbjLnefIixgazS1GtmIWk1C3fbvi5mzpCw753NcVk4rjNRuT2ar+wR/kh+mXD
 ECGiRSvIekm3ehdaemggVtIoaTb0L4A3316iX7kvUgBNFn0mRPNo1F4H2F9gKT7BMdRa
 yyx1Nhzf+yJm2rOSwqo2zkMdErU49MwMCf8IHPJMKrqbDX5EXGGhs6mF65rtSkWyj1Xo
 oJQiqzJ5Km3kT0YBB6fEi2IThDqmQGGr0L0lA2atzQTnUIKjlq6IMxFfIsWvkuHuvYuH
 lQicYKGUHd+cvD7Y3pvCVrh2sd7J6lbEEI6mWqVFnzAv1lHLli6icimn77PdMNLZxaRD
 uSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794324658; x=1794929458;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zzUgmlUgI1srxgZ/TSxVCawsbtJ9k5U7vJfICGX2Q5U=;
 b=dNTjV3yNSGczuvYJt2gSFMAJmVIRe5cBcMp95E5qFGJAExCWkBiM/2EpI+JAhpSgCb
 P+Xb/3frwNWQsc4E8XYyYISPXubocPloZYPhk+tA7a3Qm15Sh/8BfJBVWRdeMbI7/FpZ
 sEJVKWef2FbNxx3lgbzr0ZSFUdOCF4AkvpUoejv40NhV2uSZuboW8pV5xcFiDqAjjzo0
 BGpyX9a8dLTKM1wNuC8Dhq8TBoL+tXBCgXG88Qyh57Mkh3msMyU8ToeUxdC5AC/UbBFQ
 seQK8tUvN+rlylTUMy9QTvL5mlLgd2v/e1u+zYBA/dGnfP8+Sa2/K+jcLKav5koTS+hH
 jGYA==
X-Gm-Message-State: APuU4Z/N/VmpvZWxT/4B59oG4XTlEnHZd4qp5sRVCnYCSSbCpYZ+fUQA
 uDMDokIVNuvvMoxdXdmZ6zk/H0lDyI1UimxFe0ozA1b2Rx4NgTKDsZKtFMc8MNgjfgmadG6Qax1
 /gJ6y
X-Gm-Gg: AYBFou1koPbfxMiMgxeRu/+7JAUoBu1NykBQ4I3vWi5Maz5p6KR4/zJTZ/0qItXsEE0
 PYE4LtS8aXlUuAL3DP7Dup0XUQ+L5bIVapw/6JS7F0f/qhiEmc/aeXzi7OuHlvhTUoh7y4R0Wmn
 upDQiNbM0wSVzfgORSCkPlT2QtWI5HyGoM8eByBB4kkOIVUbvA+RGIMfF/0Bba0cxlQosKETDYv
 DWSI92ASxrqhqGtnHxxiJIgpmRcAtB9uAzSrkawtD4dPa4PYeqmuIAG1Np173uxPEExDPy0v0t5
 vRUbSaOg60mvwpQoSVU1+vrWUBNjrC690fnavw9QDZ/OJjjgLYqRkTh4IYL90meuFGo2/x7iZSk
 YinTCPpGYZkSnjlD/hNlivbOs0sQ0MiKOFhR5GVtdtIkK3/iFLs3DDJ8gBfxvGtNYyhlFo80A9F
 SElktLOp5IY7XYVQsShsGmxBKoBwhDoG6cZwSRHayTy71KuV5Kn7snIk0mY/C1FYmtJAun+LP5W
 0OVE0ardngZUSvbv2cJoa+J5AuihTKhcYtxm38prB3RR0JbszeCzhbP2BpKZBdpZx1+7oXBD+GE
 JxDCu96KInHwR7d6attjuFm940Jz8VoHqgP9ZqRTwPgD8FhM2BTapGfqbzuwZFcxPhxpWQ==
X-Received: by 2002:a17:90b:4b8a:b0:3ac:9a03:20ae with SMTP id
 98e67ed59e1d1-3b167b6c445mr2275987a91.44.1794324657978; 
 Tue, 10 Nov 2026 07:30:57 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdd8d7cf07dsm894994a12.28.2026.11.10.07.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 07:30:56 -0800 (PST)
Message-ID: <53bdbe0d-0030-49b4-89ea-ddeffa494792@linaro.org>
Date: Mon, 9 Nov 2026 12:53:31 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20261109164533.293487-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261109164533.293487-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 08:45, Kevin Wolf wrote:
> The following changes since commit 71f25c75417d31c214ba2cd26b273c114fc99987:
> 
>    Merge tag 'pbouvier/pr/multi_target-20261106' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-11-06 12:28:21 -0800)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 67198583a1ef3432c784f2802c5cda914bc14ca8:
> 
>    block/vhdx: Prevent out-of-bounds BAT accesses with malicious vhdx files (2026-11-09 16:32:35 +0100)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - qcow2: fix snapshot data corruption with discard-no-unref=on
> - vmdk: Fix various bugs in handling malicious image files
> - vhdx: Prevent out-of-bounds BAT accesses with malicious vhdx files
> - iotests: add --quiet arg to hide env variable dump

Applied, thanks.

r~

