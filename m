Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD80FF60CE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SVe-0002L5-PH; Tue, 31 Mar 2026 02:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7SVY-0002K5-69
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:23:24 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7SVW-0004Bh-2R
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:23:23 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c76682834a3so2060787a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774938200; x=1775543000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PMMPbCg0XxO8WGIaejuxvkmJLtYY6S3Ss2Mc575yXXo=;
 b=x156q+DLS9TmqhLq2d7HGYyQMz44/gTzhK0zswSw20PMKCr+/QJuR5ZqBUmRxR2Ik+
 FFP6/V0ZQk1oOEYh92udFqDDKPHea2pA3ZTmH7f1h5+YW6/kE4+4uPaMVrbDXLIIFlme
 Wg4PX/GC6Fj2mrhxfPlAljp4JcHzVXkgv0ATO5WlXxbZpwuj2SxhyKlbEAhyXfAfJgt9
 7tew/W/tQ4sDX7OBHd5yDgOeDIqjE11ZZjRecPIxtBU9RTSOnmcyZ7zrSIg6TeNGrq7x
 jol3aXYPd2v7MGl8cqy4YOafW2y4aTN+V298NefIkmlBJttJ05VPDHoTfhA74IPRiWG9
 qh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774938200; x=1775543000;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMMPbCg0XxO8WGIaejuxvkmJLtYY6S3Ss2Mc575yXXo=;
 b=Yvo70/eaMMrFRB0ihoDNynVQG1wG7d8250IcCq6Tu8YjcY2dXeMaQ6i4Qb+tqwvAv6
 GQxIszyUyvFsbzRVuntcwtYBG5/c5lso2WNBsFDUx1r9kex+g2dAJmxugiXaoaqeDjH5
 el/zcfRi9wgxEsqcKcdnGa/dVS2aPIhCk8tVWHzqBRTDI+BhTCqLjmmMFYhmVbwjImn8
 UNhIo/P8MzyMVdiRHP46l6n8rKD9wE3IH91/TuaAzHh6Tpw3iSA1gzAYZj7mpAxS3Dfs
 dr5x3nx+95IkWg/7MPI4cQeDlpJwQHkeRN1/uQvFOcTei7Jx6ePHwXyh1VwslCn7eEmx
 LNrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+E0s06IwnHYcV8ySEqrUG3EOcHY+wBzpp1MVvm3hfyNwzmBHRZWRGWfQM4lKJoedvQwQiWieZ4EsM@nongnu.org
X-Gm-Message-State: AOJu0Yytae7Q018QP4MaqA5Z/y7i8VMrBcyBAPUHNqeZY/4QHG4J5K6D
 u1ZuML/5ErXjVvPa14GeEageLdUaLUzAGH0D/VvaFmqDupJFrVcLQSAormM44kfIMc4=
X-Gm-Gg: ATEYQzxxL9PYQqZsbjlona935ZR1vV3+VJ1PIgytzZ0Zo66i1P4yelDIvVXoKuAerkU
 1wdla7GekK9ca/SI4AbAd2+hdTdNVPP0bPqAaQtJkMPuJVPJji1TIddpYKktnS3omnCnlMyWi8k
 Kb94YH9D3YoDc1VPR3gqs5JvCCzW7Oz7Pd1go0mYFIeTcNnfwl/7jHJkStiLtaaCjh4B7cQCv+2
 AekMY/HFoPEtWoUTw22Wy2y4m1Loxlbm0P+eUp+5MckZnGvk4S7o4Nffw8uOTfJ5wINzaVky09z
 dHgFsh4AhZAynz9HtjMRhf+hLHhNiKvCd3GHo5CgJXKDWAUoNKvUYEO0uIaw94OOL08ZO1cctFt
 TkwO6f32UXrryh/4kOIJ5Cl1wvSsNkqfFih3bGTfRrELJSy0kfiSmQoARUo7xq/ZnRU1DKIt0jM
 i8cCsAhdtQWfI7ykqsCfchGa0u36aivkpqSXogobA=
X-Received: by 2002:a17:903:18b:b0:2b0:4ec8:fb92 with SMTP id
 d9443c01a7336-2b0cdcf7be1mr152706425ad.39.1774938200228; 
 Mon, 30 Mar 2026 23:23:20 -0700 (PDT)
Received: from [192.168.4.112] ([103.73.85.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b25ca51aefsm27529085ad.16.2026.03.30.23.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 23:23:18 -0700 (PDT)
Message-ID: <2ca121f0-c6ec-4649-b3ee-7cf7e3c1df29@linaro.org>
Date: Tue, 31 Mar 2026 16:23:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] include/user/guest-host.h: Provide g2h etc for both
 abi_ptr and vaddr
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
 <20260330143123.1685142-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260330143123.1685142-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/31/26 00:31, Peter Maydell wrote:
> In commit 7804c84a ("include/user: Use vaddr in guest-host.h") we
> changed all the functions in guest-host.h that took or returned their
> guest address argument in type abi_ptr to instead use vaddr.
> 
> This introduced regressions for the case of a 32-bit guest and an
> address above 2GB for the common situation where the address is a
> syscall argument stored in a variable of type 'abi_long'.  With
> abi_ptr (which will be an unsigned 32-bit type for 32-bit guests),
> the address is cast to unsigned 32-bit, and then zero-extended to
> 64-bits in g2h_untagged_vaddr().  With the switch to vaddr (which is
> always a 64-bit unsigned type), the guest address will instead be
> sign-extended to 64 bits, which gives the wrong answer.
> 
> Fix this by providing two versions of the affected functions: the
> standard names (g2h(), g2h_untagged(), guest_addr_valid_untagged(),
> guest_range_valid_untagged(), cpu_untagged_addr()) return to using
> the logically-correct abi_ptr type; new versions with a _vaddr()
> prefix use the vaddr type.
> 
> accel/tcg/user-exec.c must change to use the _vaddr() versions; this
> is the only file that uses guest-host.h that we want to compile once.
> All the other uses are in linux-user and bsd-user code that
> inherently has to know the sizes of target-ABI types.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 7804c84a ("include/user: Use vaddr in guest-host.h")
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/3333
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   accel/tcg/user-exec.c     | 26 ++++++++--------
>   include/user/guest-host.h | 62 +++++++++++++++++++++++++++++++++++----
>   2 files changed, 69 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

