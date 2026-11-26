Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028E606A33E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qMwDXGOs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWXsZ-0003nt-LS; Thu, 26 Nov 2026 06:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWXsY-0003nc-82
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 06:43:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWXsW-0008Dk-6f
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 06:43:05 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so4331257f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795693382; x=1796298182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1YZyuCp9CDq/4HayMk8Ztf6mWj6fbrjRO3QD8T7MezQ=;
 b=qMwDXGOsrCJ8WTTcPW7PJNQPMm9bpO+WAWe8naMw6wX0Hsw+HL90un7pGpyxS1blsf
 BDl7Vt3wuif5sOP6p6UYY+rLVFpZ59CM+HIvB8y4WC4XoVxLbe4ZvGgpBgfZaJJdc7NQ
 EChTz7N7woLsSKPdKOExVKTaeeqUrZ4x2IEgswWuUNTRaNf7n1ky6BCWckl0mRjOPgR+
 jK0ge5gdKtO9Y2rwZT16xdKshODXPPKtsbP7VvROfbCsmYljGaN47U3MVJ39Iha+znz2
 94Cn/fyLRqjUCuZNQFgJeTnQjfcRKGeVMAcx2S5QkKd482+6vp4qTTr1Qh+Gm/Yy1J0M
 85Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795693382; x=1796298182;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1YZyuCp9CDq/4HayMk8Ztf6mWj6fbrjRO3QD8T7MezQ=;
 b=BUFISIN97F7Jd5NyANvaMIaTuvsN5Fm0F+cTWQ8AKzSNApzqzygDCjPoN5pDP4ljv/
 ht6a8DoAnILPZjIFiYbKO7d6z+37hjGKJbZye80N5ZZYcM3+66TVn6uyodf47j25SOXd
 rUOabC6sonIZR/d759nZ08TfqH4ooRFs5/CU1G7wN9H6GQAq1StqE0ACfrslE7vOLRn/
 Cr7J3m3/8hGYyljBqC1Va9hW2h1sm9iImXuClyrNrwGYiKwxcRd6LOQRPK+9yEnjn5YL
 Ie8mwvnKKaGrkU77YTkTYLjyB6BHZ/psokoy32xaKVVinkRg2ThF1ztaTouS1YCJxEwa
 uAWw==
X-Gm-Message-State: APuU4Z93y/o83QAJoE+uJIXmWVxzSV9sXxMEXHIlHnCZW82VeooNjGXF
 cahQYzOnMDenrgzh+9slxyRcXc1CH++9m/pWYnQOszHI/AzBLNFFZMz3cnJ8/3glbvw=
X-Gm-Gg: AZFdTZcqHc1im5LK2q3x07sJsdza7aW7ZGkHKuL2LS/bM93KUQTSB4DV1HXoEnWg1TE
 v9Oh39AxxgIZXmj3Y7tDqCTznhkaaD+5m1eg4VCNxvygZcwP7hWyIy9vman/xTjk04KTiw6+98d
 coQmTF8GOt3xVVPM9GKTVhQi09zJITq0oP+wj8wM4Z8tZRlOuEbET/ZuCeB5kuR8MmJUoYJ1a+D
 neW9rZ2AaImoqa8KoRCxr+k2zqc8GAQZh7P8AGs0W3bV97vOQ67pKzN0/eLQ4LQw/OBvMCkYfMs
 wmu7OkqotixK+7GR0MIRu2Tsyp2zkQPSNTiNrcJaj/1oBUJnZkHgtOQw5hi/344fE8Yw0QCTN+R
 iO+K2sKy0GqTXBCF5rMzYpy5w8hpqPIdemtSSq7SDiP0mnyFOTqESwgSTL9d2oi6gbK99Sf0x/h
 VDWCRl0P5T2vDrk8iQhwgZy4XeyvN+QovbIUnD7UCTP0BkCb2PQT5WrIR3m57pVqmOjzmZ088ce
 u8Sg0jBEzxyFVFApqeS0Xnd+HG51ygEAj9rqoo61AEFxfRxRUDoepq1Rep3SMyb2T25Veox00L4
 TA2zMPmPpHeDVuvOT2UEV6Ih6xO36GmS9G1vhuILsiQbwgteaQ==
X-Received: by 2002:a05:600c:4f10:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4bb88807909mr460084825e9.5.1795693382018; 
 Thu, 26 Nov 2026 03:43:02 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm488159345e9.0.2026.11.26.03.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 03:43:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 093E95F874;
 Thu, 26 Nov 2026 11:43:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Frank Mehnert <frank.mehnert@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org,
 Frank Mehnert <frank.mehnert@kernkonzept.com>
Subject: Re: [PATCH for-11.2] target/arm: set the event register on a failed
 store-exclusive
In-Reply-To: <20261125082126.49911-1-frank.mehnert@kernkonzept.com> (Frank
 Mehnert's message of "Wed, 25 Nov 2026 09:21:26 +0100")
References: <20261125082126.49911-1-frank.mehnert@kernkonzept.com>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Thu, 26 Nov 2026 11:42:59 +0000
Message-ID: <87wlpzu8cc.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Frank Mehnert <frank.mehnert@gmail.com> writes:

> Since WFE may sleep on A-profile, a WFE executed outside an exclusive
> region halts the vCPU until an event arrives. Lock code commonly
> branches back to WFE after a failed store-exclusive, for example:
>
>   1: wfe
>      ldaxr  w1, [x0]
>      cbnz   w1, 1b
>      stxr   w2, w3, [x0]
>      cbnz   w2, 1b
>
> The store-exclusive clears exclusive_addr, so the following WFE sleeps.
> On hardware, the store by another PE that made the store-exclusive fail
> cleared the global monitor of this PE, and clearing the global monitor
> sets the Event Register (Arm ARM D1.6.1, R_XRZRK). The WFE then
> completes immediately. QEMU does not model this, so with interrupts
> masked and no event stream the vCPU sleeps until another PE executes
> SEV, which such lock code never does.
>
> Set the Event Register when a store-exclusive fails, in both the
> AArch64 and the AArch32 translator. A failure for another reason causes
> a spurious wakeup, which the architecture permits.
>
> Fixes: 01b223f895a7 ("target/arm: enable WFE sleeping for A-profile")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4938
> Signed-off-by: Frank Mehnert <frank.mehnert@kernkonzept.com>

Looks good to me - is it possible to extend the wxft test case with a
test case to exercise this common lock pattern?

For the fix though:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  target/arm/tcg/translate-a64.c | 7 ++++++-
>  target/arm/tcg/translate.c     | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a6=
4.c
> index 49472f7d97..45f3b3df03 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -3531,10 +3531,15 @@ static void gen_store_exclusive(DisasContext *s, =
int rd, int rt, int rt2,
>          tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
>      }
>      tcg_gen_mov_i64(cpu_reg(s, rd), tmp);
> -    tcg_gen_br(done_label);
> +    tcg_gen_brcondi_i64(TCG_COND_EQ, tmp, 0, done_label);
>=20=20
>      gen_set_label(fail_label);
>      tcg_gen_movi_i64(cpu_reg(s, rd), 1);
> +    /*
> +     * A failing store-exclusive means the global monitor was cleared, w=
hich
> +     * generates a WFE wakeup event.
> +     */
> +    gen_event_reg();
>      gen_set_label(done_label);
>      tcg_gen_movi_i64(cpu_exclusive_addr, -1);
>  }
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 442c34ce84..2eef2ceef2 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -2137,10 +2137,15 @@ static void gen_store_exclusive(DisasContext *s, =
int rd, int rt, int rt2,
>          tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t2);
>      }
>      tcg_gen_mov_i32(cpu_R[rd], t0);
> -    tcg_gen_br(done_label);
> +    tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0, done_label);
>=20=20
>      gen_set_label(fail_label);
>      tcg_gen_movi_i32(cpu_R[rd], 1);
> +    /*
> +     * A failing store-exclusive means the global monitor was cleared, w=
hich
> +     * generates a WFE wakeup event.
> +     */
> +    gen_event_reg();
>      gen_set_label(done_label);
>      tcg_gen_movi_i64(cpu_exclusive_addr, -1);
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

