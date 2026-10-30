Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1951606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uvDpf+V6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkf1-0000xX-JB; Fri, 30 Oct 2026 07:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMkez-0000xH-AA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:20:37 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMkex-0002iz-Qu
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:20:37 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43bf9548df4so606089fac.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793359234; x=1793964034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GEtG9UmqBW/FbA48PlssneKgSB5XwM6Exif9C+it3TQ=;
 b=uvDpf+V662j5DpQUh6HgsukoffljzJCGgPl8N+F/LWmSE2x3s2foX5HzWc2m2kLi3N
 86uAD6OtjrCpniKuqoG0VeY5ocNF90tehpZYcqJ1PKusa0K5j9c4M7ri50fQQasNjQVr
 QZd1kIvw15VnUCI7dr60iztvd5ObB+d8IjdfLkic9bJ9KVCzqQWsxzl2R6t7dDDvasy/
 upg48lisbfi9/xbZU2R6POHgKQOIBhYYe+7CVVcSDSfoQdH4tHRsdD1KJzSOsVFMNYtk
 /NCtipKbxXOCWPG3UJIXCiBDpPKcZwWyxHtohFJbfcE7zJtZ1FiDuIpD4oe9HVP0r1S7
 mcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359234; x=1793964034;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GEtG9UmqBW/FbA48PlssneKgSB5XwM6Exif9C+it3TQ=;
 b=hkchbApz7f89Je9Uypszt5bOhUn2ya6Pzgit6+wA9kf7kYdSVGV7413Z7z1XZUadtP
 OIjcKnDlkf7WSvFvnIF6rLbA88FZLfBHtwms7ezFt23o7QfgBCZkumb0shVQBLr20NyP
 prccHJyELB4UDMswGmhrda+vTgyBzo+Qv0s/fatFOtfegcRJVyd7LgpLGov/g8VEybZz
 kk0g+vV2X9rRtxjvajpiNqK3QhiUxWdD7DS9qsQcZNF2U5FBpb2hahoisgu9DjZ/1eU7
 Z9HPWvhbPTrJAUPPivQ702p3K5XpC72SA1myyF+3s2Q8YnzAT9R40M7i8soDpQPbJf45
 kVWQ==
X-Gm-Message-State: AFq9FYIoMilnVyaY9jjPNmY2vASn6OnLrJk+o/YjZ0t3ZEvOJG3Jwd0I
 S/6JyEl0F5vPgivnhNgLOtSuNF9Leb0SUjTT4ZTCDcbkmTj8kS/Yd72vgMS0Q/Cr4Xmgtj8wJwc
 4SECq
X-Gm-Gg: AYBFou1qrLCg6dp58Wt3Z/G+Vo2Oz6BTigRjVlXfYGz1wW2B4hu0//kpPddMiYuI5SI
 DvdsGGUNmsxMEQdjxQPXcRyL7ZJRb4jHTR4drPNavOLcRe+xXJnLd2AAyBL2NONaQbJR1SVhXA6
 EHVx6vUThjDHltmeRTnEJL1TM/OLc2CnP9Hyzf91Kj36qqDef0N6WqoLhrWW9zedxQX38HMV5Yp
 dZ5WsxUZpw42RnLrRY5GbJOVf6rhNfqtVCQoa9CK+YljksUXvglIiXvyhIbv+xN4seUdgrsfrOR
 zTWUXdvPUkuXpEXuSxed/m5ddjF8sTTtrxoBXz42ggoLtE33OegvJ+TuCitUZKrQibThBgqQGCk
 cJG/bBBtvvGSFjf/7F9Fqj0N/PxMULtwbBD5LSwmh6hDUjN0sT7JhSPY71a6rNt9eqQ3QpD9Gfu
 n2bwkbS6ZpDs5xo+L1EGD0M0MjcvnHu9a4gzZX1fUWs1yRzmwIhM9NtWpHSid0ySVK8VcPXklya
 /Zu0roKDRJrOHuNa2tWVwnyOFFyG3Pq0HEXIo5u4HqQmlW0UC9xVCxi077o5kOQ+z5DWZwRsL7Z
 ExJlZGTkhTCpVPTGQugQTHutgTw5hlF7FT14JqEcfT7XgA==
X-Received: by 2002:a05:6870:1690:b0:499:c29b:93b7 with SMTP id
 586e51a60fabf-4a90781d156mr1113528fac.53.1793359234293; 
 Fri, 30 Oct 2026 04:20:34 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90aead7a2sm1599256fac.8.2026.10.30.04.20.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 04:20:33 -0700 (PDT)
Message-ID: <e9a4751d-645b-4374-84f7-82357e07d28b@linaro.org>
Date: Fri, 30 Oct 2026 06:20:31 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/m68k/next-cube: Show deprecation notice to users
To: qemu-devel@nongnu.org
References: <20261030100659.781819-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261030100659.781819-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 05:06, Peter Maydell wrote:
> In commit 5d3333e12a034 we deprecated the next-cube machine, but
> forgot to set its MachineClass::deprecation_reason. Add that, so
> that anybody running the machine is shown the warning that it's
> now deprecated.
> 
> Fixes: 5d3333e12a034 ("docs/about: Deprecate the 'next-cube' m68k machine")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/m68k/next-cube.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

