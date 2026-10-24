Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E4606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AIvZN1zx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKdQc-0008A7-9x; Sat, 24 Oct 2026 11:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKdQY-00089c-KC
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:12:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKdQW-0003WQ-S8
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:12:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so7061215e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792854773; x=1793459573; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bHmzIiamyXGFkuAm13j814cI3oNHsVTGk/DbCM6elsI=;
 b=AIvZN1zxivaMw2M+DCse91IBI14ZjXaHs2Raly0rdul+AlqzM6Xbz7bIMh3Z6OVUxa
 gi5fcgfRCz1uekzh4Xq3BXjhAHVx2sBX1N5EPZA2n1lG7l4t5KE13GBa/fCTEjBLBYTK
 QRriRvnpyb7dUi/EgkR9BpC1x9byTi6oSa0Q1V3VUsbPhDoBhtLoIGfnEc908PMg62Qo
 pdSSZJZAwkJ9p0/meea2gmHNCcDyqGOi5v5/zoe07xOXoAlSDe39VP/pKKrJR13WRFw9
 wUu5cjARD5ayms09bqLwDmQc0B5/WGvxNCJZUl2ER82meYiGh6gnqKfy5rvvjdoUDXoQ
 AnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792854773; x=1793459573;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bHmzIiamyXGFkuAm13j814cI3oNHsVTGk/DbCM6elsI=;
 b=CPOtUBQb3W6WfXNqir/8ITHZOYY/3gHVEYc1Mq5/WsMeXnoHUsc95qfVVC6aB24xj6
 TyW8dUkPssLZrejPiIZqhUZ9KRacW4FM2bDT8jFeNHXmcHMrH03Dppw0tCL5aBjDcOTI
 C7/LC0cmZyIPrNVd3oAY3moJb2tmramgXe2EF22fwiU7y1c8G2UALV4gHDJ39GVuRzpl
 vah+axoAlZtM7sD+aqezKGogEjz0WKG4ExNZrCxxaScEHuaYoTLz6nSSBxkGfeK5UPhf
 f5SjDnLUd7eJ15wnfMGICHPYGkeumdByleCEprSYxHQyWqstOy0Kz3TY+kCYxEBIiY1q
 1XyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGqC1LaqSEvTAVkdAs649qIVuA4+B7beON63w6DDpACscGoUz7Tp/999AJAqYIEKtmdELrcJ5CXkYy@nongnu.org
X-Gm-Message-State: AFq9FYL0aUIAst0Sf6KlOaN1lSihKEl+/zAe5rfiivxwwKce7tUdul2h
 SoledvxrftEngZXmB8LILLrLCAHz7/tXMohM73MIL1VcJ39Vv0nE89NF82uxrSD14Oc=
X-Gm-Gg: AYBFou1Pze4vzkvQQHa83NuGLr30V5v3av4LsBsI7ZgRvkihHTK5TYre103Efv6D5wj
 Gw1ZQ51ngy0Zw+uDztpssfyDlR3la7deFd3jbGIb1u9IkEzewj1lZ1+3mMaz+ZvLBOlnUbd7gpP
 7qZFYICc76vGNYHK217+eA2a9120m9TrmKUd4PETFZzYF45vLfL0mZstoLdF6m31ttUKlI09xlT
 xICSpVY+qWXINrODKAh+EWwjjARfiROcuH2yh7+FDw5+j4DD4fdzFrmwhCq8CdubxDwbQs4CaGC
 LtH7EOjZ72MAyKGWzYvwJqi3nS5UpH7F+UpCXD0VC0GTTF4qBYu52rTK/nMzohlIOC8c+SNgz1U
 gngG8Q17TtWJNSXkUI7WUFn88nxL9qfgldOMfy1d+6QjMvtCzgWFQySkJm9RfUQJKLQT22Re147
 P8DjGqUC1xj1hWorxWpardZnigpHMJsQWUJtkHAlcPmGdPGfRwAiMN/ZaIKaVf8Ij2q9WZCel+I
 OABYBYIfJu23rb9yLNfzOs8GVQnW7msD2df+pEzVBBlweq3upZ0MlU7FXWYiMPLC85X
X-Received: by 2002:a05:600c:a318:b0:4a3:5aee:2c25 with SMTP id
 5b1f17b1804b1-4a35aee2cfdmr26019665e9.31.1792854773027; 
 Sat, 24 Oct 2026 08:12:53 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fbb725sm60977215e9.0.2026.10.24.08.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 08:12:52 -0700 (PDT)
Message-ID: <7b03da0d-89ee-46b7-8a1b-f9c3876c3ecd@linaro.org>
Date: Sat, 24 Oct 2026 17:12:50 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] testing updates (tcg, gdbstub)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 10/23/26 20:05, Alex Bennée wrote:
> The following changes since commit b6c4b7e86dec12d07f5cac65265b986d38ee9002:
> 
>    Merge tag 'pbouvier/pr/tcg_tests-20261022' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-23 09:09:11 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-11.2-gdbstub-kvm-231026-1
> 
> for you to fetch changes up to e0a7139b213487a59023d88e7d56b7e95d90d553:
> 
>    tests/functional: add tuxrun kvm gdb test for s390x (2026-10-23 17:32:05 +0100)
> 
> ----------------------------------------------------------------
> testing updates (tcg, gdbstub):
> 
>    - make sure we have TCG to run test_acpi_bits
>    - fix overflow in linux-sigrtminmax
>    - make .dir-locals aware of PYTHONPATH
>    - detect gdb in top-level meson
>    - fetch kernel assets with symbols for x86, aarch64 and s390 tuxruns
>    - use arrays in gdb run-test to make quoting less messy
>    - add support for --symbols and --kargs to gdbstub run-test.py
>    - restore old kvm gdb test script with a few fixes
>    - add tuxrun_kvm_gdb tests for x86,aarch64 and s390

Applied, thanks.

r~

