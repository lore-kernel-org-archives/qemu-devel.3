Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE102606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GrcZhzUT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMk0B-0007G2-9I; Fri, 30 Oct 2026 06:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMk0A-0007Fo-Ev
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:38:26 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMk07-0006of-2e
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:38:25 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4a6f2825dd6so114302fac.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793356701; x=1793961501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kHwXobIj5KV9j80y3le3AfLG/CZL8Istolec8SV/lec=;
 b=GrcZhzUTFMa6w5NKwCRNDrj+g0djncp0pWvrlwySuAXKiyVAx6iXr6NtENJzgJIlXk
 bH4o80LkLZXjbqSu0KHCXk8gkfnDjdqylgKEKjUZOEDszLqlPZE72MS1/wy2RnEEjFz0
 uYWj14i5GjkYR2ETuLIfkRbGPR6e1x3gekOQJJMbJErgo2LyYPrK5DJ8t2UW6XsutyMe
 Im6r9v2DQ162ndlJOB34MJQUBODjgRRa5lnaRcVl2aU/hDSw/ezYT9DMBUFxy0iR+OjW
 +d5chVFEjqPXZKh01TEtWhoetWbIcHAR5hynfLIaaDkBqCA3z0Q7BRlI+rIBOEtBQNzd
 Uknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793356701; x=1793961501;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kHwXobIj5KV9j80y3le3AfLG/CZL8Istolec8SV/lec=;
 b=by/w5ZYxAnMLd5MuwlZhcn8FwemojUCEtGdosMkt5sqyCcjJHz1K2DIhZ1nGQqaRHB
 3Z7mMRpaS18XLAj3zwqAJGRw4U5mlOwyoJuxcZZ9SO9ow2NWcF1/SxP2vNbDeTNERRJi
 H7H1Hts0f1a6an4lqwC+gFE+QYH/iQop1Esd2YDay64iqbkIMQ0qxi1KewvjK8q3fKlt
 d/VYiNMSnHDL8/nluGuTq2CGfxfJm4ofI4vistPoQTOjKhcOgK3qu0eJl5XNlWRhRXwI
 2eEu1NF6u3yWYqCeyLbvjnGnaqd5UqYqUk5wAO/40tVifGp2RN98wvB4rzCB8Cy7uXqC
 2YyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIzwLmMnjCRdACpiQ8KDcVFhrc3tJLPuwKIT2LNFPFzUzYaS7OYiKoiJpHGMWSzokIEzljmMcnm6Jp@nongnu.org
X-Gm-Message-State: AFq9FYKSFanLl/X1dr6P9QfXCa3DiyAnzTQ4TbNCkMxv/XJihvn6NZ/G
 3hXgmUJoKcQhOZsUpxDi1/U/QSDBzKWbdQrrz1ApEetoBx6NwOzliEsPed+Kui4+0j3Vo7DhWE4
 j+yYv
X-Gm-Gg: AYBFou0h9fLdqWJ8nu/b4Y5hGt4pzo7yzMMNbS3ZqYMUCETpcB8GUXvJ4mg/nUf39MN
 h1o6CgDV4A4Y0j/fMPJ+Jp0h207kGFYsR0A1dH4EXxc6QDB6rbP5EDg2HqaOwHGHjw8Ic/vwvno
 zdGd3dwGURNrIlh1SJc2lle3RqZ4bvm3rnSCJIobFN6g2mTkux/oouYoU5T5YKtk7Er5/+Kyuyc
 u/CQFwdv1TcfioCTqoOuV8taGYDPjrg7kqjksh0Tqac0a6L8e4+Eor3K97DBl7pNPvAtb9Em4IL
 3UtK3WGcln2+jivGj5NmYtcanJyNQySKMUkl+0ew3N3LMyHBPYGgLHHQ1XZKLUPKOgOiAZ5BD29
 0mzQHwlLXxLL4wuKevsVVJwDiAyTtLi8FP8H6XW8ym8lBrCBRV/3PjtBYnTixbFN6epX7SDLwvB
 sTOW/heozFMBeEtKfi4niyWXPg89mMV0P7NV+q5bxyREldq5YZdntJDovZFRhzgm/WGpBfjtiX8
 1b/28hpbkUj2sxjiGmsOUDU2TkzU+HOxDk1Vf0soHCgZslCaM6wLDbDdDScn+B29RE8zWPOVuBN
 86UEjQ74pGAvt3yMacQhSH5T2JgiuygZEyy3tLdNKBJd
X-Received: by 2002:a05:6808:124d:b0:4d6:90f3:74b3 with SMTP id
 5614622812f47-5640de496bemr1237432b6e.51.1793356700487; 
 Fri, 30 Oct 2026 03:38:20 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e9absm1544491fac.4.2026.10.30.03.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 03:38:19 -0700 (PDT)
Message-ID: <007adea4-c2d7-4443-873e-fa4483e12ff5@linaro.org>
Date: Fri, 30 Oct 2026 05:38:17 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Qtest patches for 2026-10-29
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20261029210536.2260016-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029210536.2260016-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

On 10/29/26 16:05, Fabiano Rosas wrote:
> The following changes since commit 5624b266cdd513506fb333e9041778407b6d1ac4:
> 
>    Merge tag 'qga-pull-2026-10-28-2' ofhttps://github.com/kostyanf14/qemu into staging (2026-10-28 14:53:37 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/qtest-20261029-pull-request
> 
> for you to fetch changes up to d4a85ac217b653da355f256791d4abd15980022a:
> 
>    qtest: don't close listener socket in qtest_socket_accept (2026-10-29 15:55:29 -0300)
> 
> ----------------------------------------------------------------
> QTest pull request
> 
> - Lift limit of 256 intercepted IRQs
> - Fixes to socket_accept

Applied, thanks.

r~

