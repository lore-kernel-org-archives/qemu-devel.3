Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBD606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jvqq30dJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMlmb-0003AU-Cs; Fri, 30 Oct 2026 08:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMlmR-00039k-DP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:32:25 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMlmL-0000ki-TF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:32:20 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-85c1135c286so404983a34.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793363536; x=1793968336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GEzBcN4HnNQB0PZOTgVqneMAxFVjIWAdC9Z+FjCE5ns=;
 b=jvqq30dJM6PC8yZ8ZIzkfx8sxvSH0/7hxKJkAIlve2oCLm7yMF0T4vtf0mTcRsf09l
 faRiIQR0QZKAY52m1l0Erww2wbaocWlKIDyCUbIUOmRuYyZyuuLBTDK363UKKDxp1Gtp
 Kk5WLq7BnP8RRs6XALbbDuZV2/AeHKw0WrwqxvyWAaJAFBsfEHJQs09AU6mGuTdWwD5m
 Q5phdetHKb1d7+9/ZjzF7EghuS9433fPboUa1eXOJtovRUZ6YT+WI/RfUbNe23O4pgv7
 IIxlaa/9Qj7acOE4dQdsHT1VrlkjNnBt4xg6oLGjHXi7WlmKLEDmo0Y8ayV25OKvPRC8
 /MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363536; x=1793968336;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GEzBcN4HnNQB0PZOTgVqneMAxFVjIWAdC9Z+FjCE5ns=;
 b=2ImBedVFULWHJvGtbont/inkj+NEuVyFDUdQMY5V6yCT5QVPnxBmaTAE6C+5DmtLDy
 H/UFyRUMKue/9P5VGb92upy5oPfdqoqyWvCWxw957BpwrebRyBIPs2X/npGunftVo+pd
 rjiZUc6Py86/9EYJGE1YsmF+TBOoPqKMLHjbbqBpviJLIdvDpC+a3EX3ENACKCMzQ8Dr
 E9XJPWtDVrmWuMl0KVPcOKoYZvOcsaDNuzOD5pz2yirl017wNuDD6wdFuYev1bBUwyZ9
 vJkZRCVjaQPsbGH7Xa3Cc/cEzjZW2+a1l7DObyown5peSOdoSZfFRx0YkM/tMp6lhoA2
 qgFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMKjKOgi3IKvyXcnOFUYNURMW7Q+p+QHVpr+8RhrTmBmjr6Nixv/QWd/04ROD+BKSY/V6IMUYSO9aG@nongnu.org
X-Gm-Message-State: AFq9FYJ/3BdEvUqCve5pO6RaaQuGfUP5F06QI6JNFgnEEPznklzCjYIM
 3zYIVTNTVAABrWVYjM4wwLtq/WyIkwkiJXD5Zce3UFsMH9J+cnhBAxsHsDgXUW+3jew=
X-Gm-Gg: AYBFou0GihuHbJEBKIGtkGI6HE8mT2Toc+aKBcrMljagsw5KPrWoMKP//mP9PmfbO12
 gNbrqcNEjt3eySMrgJhEw1p5L2oEbu7VqBw7NwUn7o55iPLuxlGG1weAQwsAltOgK3CjkT193iI
 nw11KB7769Dj7tMIz1lldcGgjdjsepn9h7I75QvqQWv4d99DukJtLJMxh7qffzQ3HR+wAvzrJ2l
 ZqsqRMscnMu29Wb3UVMQMTrkspsQ1f/8/7PBJ86pwRjrwWe6YV9iayFngsIBBmIhLDM1m+iOpON
 AsAUADhddHYC7moXuS0OHV74n/h2N6VoDwij8j7sIxISR5UWlzxnetYW6UbIBYG5w8E1ApN+X6q
 Mi0lplCecByCV1gD0Uw1z47wYGXNvAi5YWsF2o5BcCxfBGUOc/cK/CgFOvt6bG46k0GzItTyTTD
 I87r0rROhuBbvJ17Vv7UI0JEJRWa8cwrVaoyMvFXwJEE+2V0HCzCnMD6MVfLUu9nO6tYn79UlUK
 cpvNKnXJE3IdlELo8xEyOZ+GUSrVfeQ+OvEnwzfBv199869G6yv/4SyYF4aoNU12ueLp0N7PzD5
 yITGBIJ0Ig58RaV9Y0QNMgFVP453QdWG0t71btpO3+3t
X-Received: by 2002:a05:6830:4393:b0:817:bb8:cb7d with SMTP id
 46e09a7af769-85d36575f5emr1651821a34.18.1793363535850; 
 Fri, 30 Oct 2026 05:32:15 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354f660csm1834294a34.22.2026.10.30.05.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 05:32:15 -0700 (PDT)
Message-ID: <9abb58e0-70f9-4a73-be31-ad65f569b718@linaro.org>
Date: Fri, 30 Oct 2026 07:32:12 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] UFS command fixes and fault injection tests
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 daejun7.park@samsung.com, stanleyjhu@google.com, dridiha98@gmail.com,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 10/30/26 03:14, Jeuk Kim wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> The following changes since commit b574eaf640f02c4edf28cbee6417378f0d79cda0:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-10-29 13:47:40 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20261030
> 
> for you to fetch changes up to cc145a41586bde12c94b7e8932988cff323ad3a7:
> 
>    tests/qtest/ufs-test: Add QOM fault injection task abort test (2026-10-30 17:00:58 +0900)
> 
> ----------------------------------------------------------------
> UFS command fixes and fault injection tests
> 
> - Add REPORT LUNS support for well-known LUNs
> - Fix PRDT validation and SYNCHRONIZE CACHE handling
> - Add fault injection and reset/task management tests

Applied, thanks.

r~

