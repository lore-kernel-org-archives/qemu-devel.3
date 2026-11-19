Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213ED606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C9s+48U9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA1F-0001a5-Dw; Thu, 19 Nov 2026 16:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUA1E-0001Zx-EN
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:50:12 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUA1C-00062h-OX
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:50:12 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2e95bd1c14cso1645585ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 13:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795125009; x=1795729809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A8A36SWSMIK3Tt2rzJwXriKQEOpqeTCtAwdIlLyZpzg=;
 b=C9s+48U9NhZcijwo+CS7F+v5+S/lmoQ1KgZs0Kw0crZtt/T47Qe3Zvjxx1yBurkASv
 jjWzVZ+47brC0cryv/LZ9yMzGFn7HQcQ1B63LkSR+F2l/OrpeDjNh2zc/xCsOcwK6aDP
 U1lGu8AepgqZ5OGnfjJx/0YSgRQgHw09f4Kc82knN9jHEnyhS3yPP4ul1aC6appPU0Dz
 LV5HBo9PJq2PbrIvltUEqc37CdILtaOZZyhdcsV0GOyvJKUto8ITqckddbVwJj9xDudX
 F0IKOwiHYNjqJdckOflv1jvC5jHQkyySoDHDMZ20dGudxnv5zrMvsyb/pqQWIXpdiYpN
 qSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795125009; x=1795729809;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A8A36SWSMIK3Tt2rzJwXriKQEOpqeTCtAwdIlLyZpzg=;
 b=krkNvSbKfN+C77EFGlJ8GlRYtz9QL06juDHlAGEKcfQrGJrJ6pzXcWOAn69fB4qbGP
 mx3P/IfWIvuYEFVvG8li0p5ePn+96v097yiL0VLlM+WIMFx145zEJLsy/0o4Vf1G1sMH
 V2KEwcNZbHYnN+HhHOJYYvVGe6HOO1LawBg+oJdLAi3WQBK3ze1gGT4jLUsc42CZWPEq
 kziDrgQI9dM86lu5gYbQuQURo2VDsDRXIF7XAUD/4Re8WISyMpYaqTAvBd7t/4nkiTPy
 5osr9jaIdtusqezrC2pdnUSF6A2MMIzuh6yLyM1vKWLnhBAoELX8+Bb+e1lWcxqdkaVK
 55gA==
X-Forwarded-Encrypted: i=1;
 AL+hErHKCoMkmN997n9ah0SbtRqpHBzZrdP1PpaDpVa5QeK3nCNtRuYH6+owuLkm78qAvXNJ1TKWQWCquPYZ@nongnu.org
X-Gm-Message-State: APuU4Z+HfKAiMlrJU2B4SsF+nQZLUeOwf0ZTzRURK3uEaRTCysVHRB00
 tYTKTNt1tghEOPk2cveMIz4so73HSa3ZWgrB8sYmKPjizNH/QUL9fd+tHjdLFI6QHwY=
X-Gm-Gg: AZFdTZeCDl8DOTuQDORxcGWQkMrsekcA0qKBaaV30z3XIYe7Tduc02yihd1odF2ffN6
 ABs/hBpV5Pmkq6mwvH/jHkw3JkbasNB2q0vlUenaxEHJV1GV0QeWmf33oaX0HmCBL2mUw532i/H
 aeupuaAY+9isdTeoSNnfk2NmzACTZU+OFSqnmaEm42Ih15p6UPEXh1m4JxhTXHW6aYrTsmtFiwa
 xPoYmxDeUHmqKP3VHsYA+50/75pi6JoNvnHKhyBq3b28bHbngPvrVOFKVJTe2sqNXccPMSeiS+B
 L1YnBVsa0SZemTZw5ckJDBH5BPilKM6etPZ0cEgaD1NKFMGOgghkPYZRKtBADtgLBv+DrBPJjB9
 v1jz+Zoyevo3jVP8AL2u+J0tkAgcfzcAmKfQuj4qw2bWZpWstkkTkYmmvZ6L/TdwNNdd1JmbW9n
 viZeC0Ik0nYhxWvrwjZ2rorzOxGmDtZPC2AVIEZMhIRVRw2kV2Pru5CDTSwZ3jyo7sZ39G7AGtX
 7AcvPfpcI9qvRHCJGUHU5fdvZ1I+AdSZfKJpw+hNxfXJKNlj1qoyanZdLwNI+D2poFDNGMbh4Gm
 BJUqkYCFQkctIaeiriRgNUwWZg7Ae9yvdmFYLLU6Pq6puqMcfhLp321FMCt42hioSpHRgsw=
X-Received: by 2002:a17:903:2f87:b0:2ef:df75:337b with SMTP id
 d9443c01a7336-2f03f246f17mr12096565ad.48.1795125008744; 
 Thu, 19 Nov 2026 13:50:08 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03ee85466sm5314065ad.4.2026.11.19.13.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 13:50:08 -0800 (PST)
Message-ID: <a24f1221-5039-4cb8-888f-3ac19de414de@linaro.org>
Date: Thu, 19 Nov 2026 13:50:06 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] pc,virtio: fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1795081539.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1795081539.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 01:47, Michael S. Tsirkin wrote:
> The following changes since commit 29760efaf96bbe5928f8111881eddbf5ac06439e:
> 
>    Update version for v11.2.0-rc0 release (2026-11-10 14:47:54 -0800)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 902c849979ce2be367dc0a643310d6b45b76bcd4:
> 
>    hw/virtio/virtio-crypto: Drain in-flight operations before unrealizing (CVE-2026-50625) (2026-11-19 02:57:57 -0500)
> 
> ----------------------------------------------------------------
> pc,virtio: fixes
> 
> A collection of small fixes all over the place.
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

Applied, thanks.

r~

