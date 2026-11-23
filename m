Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC5606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=On6xizxO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWJi-0003aR-AI; Mon, 23 Nov 2026 10:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVWJg-0003aJ-4s
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:50:52 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVWJe-00052b-E3
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:50:51 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2f0458cc9easo25534135ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795449045; x=1796053845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zXAYZLWdMIZ8zZBlWmkItUiOvGLsDZDuabUtUp0Hn/I=;
 b=On6xizxOPux9CTnwj5kv8W5cQHDqd/9pDT0STJkcNjaY/t3pzhpvbt61r1h74++HRD
 LeUaII6YMTuCNII/GuOOjwMrIgUzCP2MZWCjvj4Bd7RCMPEpnFbjZ1j4ol9yXMowqRO2
 mX0Lxzjd4lIWTzf8rwQLFfmOmvyQfPP7wWRhdVTpeMVuPjAFTHWqBf5jRfShEsRBvQKJ
 1fK5sIMAL3C47hy9H8N9yCvSO3hIZprKh63TUKF8DdnHjWVbvJIkPXzx/1N8tja/M22Y
 PxieAg7pHIwMCj2phuzfEUzfCUZX/JAhRUZ0AYyhLdvEYvpJZ2VzfeKpNoic757aEYku
 FTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795449045; x=1796053845;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zXAYZLWdMIZ8zZBlWmkItUiOvGLsDZDuabUtUp0Hn/I=;
 b=qeWsLRIJ4QCzfTnVQu4/MOg4gGvkzZ8HJunD06gMp+OTCGO7Rz6eGSkXVh1c+f465G
 lqo9XDzfFe7bN2s94GgpuUrTc3qOKTpQPXmjka2fKAljA6RtT2bh+/9q1eFIu32Sw5cY
 9CAzUEaH0h3fm8XuYDhfAolHR74WPhkKHDLCl5KOJ/KvdmvwZmaOZhpY5wapRFeMGt4/
 re4ANqsL+y8zDE4lSaEvdIS+GjDNJWsSpg+dKXp5osKaUq1eIJuH6Sc5d+nxqa7EHjdk
 11UVWl+GSeKRzFD+N5IY7NVRDyTSbhC2WQSYMYI5WsOwTVgAY3fiefaADKdgkyGYamfE
 4JMw==
X-Gm-Message-State: APuU4Z9fD2FWsS0ABRFMCAPmKxfK04sRn8Qn53VMmLyf/anpuGpC955W
 m2B7GtHA+GtE+7c9Uc78Cwv+Z9aOjhhJH+jyxrAiIc4/ZZPkodhRgJiLV6BC4HDtaA8=
X-Gm-Gg: AZFdTZeA2ifO1p+wpvz52krIzIsCq/aVIItx+XlFiNwM6XYNK0NZDwhTrMHTHMsiEZx
 qYklhp4SAgI/EuSxRWsBHXVMuh8G6T0padbWP0A/MVBTgvh9LnQp0tj46STwH74QddmG5CsqU2S
 T9JVG6fIjM+6MhoK8AV2nKXvDJa+arem+4LQVMhrMAjb1JkJDrNYqt/+AaJfRkzscAkJ5wQ8X2p
 wTCSsAsucyQgIKsCNnmYB7+Qo4eF6eVqpxutauRkmGlKUQ90IA0iJ3l8WUCxnzAsMnVOjol4XIe
 N8VnA/e4l9IS4Qa1y7LcTkd7EAuGvSEV4jAQxOtomNjy4CgQ0rMYVt+yHzc+mdlO9UePLwusTjN
 GckMo60tEmkSNt1c1+xn0UFCg2yzsInoOg/eT1i6kDzjjOlAz6RTqMBmLyQa/iXB9GXl/TiuYIR
 zuwvZD20IWqQY3tKat+E41kCVE7QZ8UcGDRgZ/zAPYNKlkDKmhGGZptGPOfSFl6jk6zcnErgov4
 jSk3yKTB95NsQ+SfIqZvpH64kSbrw/8gnGyHt31m5NVNTMqGGJzIi5LmloNHEfkXQTEYMX/PEh8
 REc8bscOPXqR8d2/NUp/ErDIO8eOdfjxPXZXzZtfa7Q=
X-Received: by 2002:a17:903:2805:b0:2e5:54b9:6b5c with SMTP id
 d9443c01a7336-2f03f17d1f3mr77667795ad.20.1795449042994; 
 Mon, 23 Nov 2026 07:50:42 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f1276c5sm59403665ad.67.2026.11.23.07.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 07:50:42 -0800 (PST)
Message-ID: <b27ae4a0-d9b4-43c9-8f84-0135a2b1b2a5@linaro.org>
Date: Mon, 23 Nov 2026 07:50:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] target/i386: use separate MMU indexes for
 instruction fetch
To: mdspan <mdspan.github@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com
References: <20261120104431.733136-1-mdspan.github@gmail.com>
 <20261120104431.733136-4-mdspan.github@gmail.com>
 <e4159fa3-e122-43f7-8ce3-e108ce8dcbf9@linaro.org>
 <CALU8FV_p8we36GXdsMB5QR3LO2VfKwiTZ68gAKb37Q5UrXK+Rg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CALU8FV_p8we36GXdsMB5QR3LO2VfKwiTZ68gAKb37Q5UrXK+Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/21/26 13:31, mdspan wrote:
> Yes, that seems like a more logical approach. I'll do that in v3.
> Masking only changes 64-bit linear addresses, so I plan to add masked
> forms of the three 64-bit data indexes (KSMAP64, KNOSMAP64, USER64).
> While LAM is enabled, x86_mmu_index_pl() and x86_mmu_index_kernel_pl()
> would return them, and the walk would mask only for those indexes.
> x86_cpu_mmu_index() would return the normal index when ifetch is true,
> so the fetch indexes from v2 go away.
> 
> One question before I write it. With this, the data mmu_idx depends on
> CR3.LAM_U48/LAM_U57 and CR4.LAM_SUP, and translate.c captures it in
> dc->mem_index. So the LAM state has to be part of the TB flags. I'd add
> an hflags bit, set when any of those three bits is set, and update it
> in cpu_x86_update_cr3() and cpu_x86_update_cr4(). Is an hflags bit
> acceptable for this, or would you rather it be handled another way?
Yes, adding a single "LAM enabled" bit is acceptable, and seems to be 
the easiest way in the short term.

You could also store the complete mmu_idx in 4 bits, but I think you'd 
only do that if you could eliminate some of the other bits currently 
stored in hflags that would be redundant with the complete mmu_idx.


r~

