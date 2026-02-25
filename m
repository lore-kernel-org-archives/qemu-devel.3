Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAE6FD3764
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 15:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGSs-0004oC-3L; Wed, 25 Feb 2026 10:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvGSp-0004ny-QA
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 10:06:11 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvGSo-0000y7-3g
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 10:06:11 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48069a48629so69924325e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772031968; x=1772636768; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FnoSwAnK09CYO2HS+GYpggDUeS/dwcCHTqnSOozh1LI=;
 b=oOSzagzzxALM4g7KSI7D+jlurq+3zuQZTX29SU//zWRVIQLQY1bzvvg3T07UTwsC8/
 6B7tMcE6wZoDzcLxIXY434wUcBYVOHDVjMNxtS47Hl+bQqlAplcgiOEQzH8fbQfa7nMO
 lETO2d6KvptH+Obbm67bmhiFv07SKOl5xpqN/WJ67Ep1C2HLmC3idSrTeU/BjGRu/fVL
 nISBJL8EJzmbTG8VBNh0qKX6kPeZi2M9FAjTvsK69pfG6517iiDk15K0Do04uBoT2c3U
 AL/MgP6YQhD5FqYzPhK2K5PjQj/GUOByZlocIPdYD5WaVXmNtLbgh7DJKK6vDFs5NLZ9
 McGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772031968; x=1772636768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FnoSwAnK09CYO2HS+GYpggDUeS/dwcCHTqnSOozh1LI=;
 b=liKTYb0XzVS61x6eqUR4CvEFqhD9P/NPvtdE1yNEEwEadQ4WsXwyCgO2F9qDB7orrM
 HaC+beOyBrnDVF7go2BfJX8q3O2A8BwEnyyIdVzFK5S0Bg2FAQLqkR9IyTphDc8Jwyji
 11eZ6wcCP6MwE/dFasTcKtox6ZCC05JsDBcNkeIXIRC4wdyO4vOifbvpG9Fv5o85xgTW
 nyG9mLOITWkDJ4q93sy5E5lIbVf5an0fPMctof66Fm1O97Gc4R9YSsdytQV6T2GL07sh
 myaNMIJBU1ZXGZlYg1k4OfdU2t8I2tFpjdPWMK6PqnV6PbXgS8YvvIyFNQAIjV98j6Qj
 ivsQ==
X-Gm-Message-State: AOJu0Yw3ik3Bv7DPaV10Ge0tSdzm0UdgmqaFWoFs/3STehZgs7iAiyf9
 862+a5WQZ5vDcSnaBKdNQWCeW2pA6RKsTDToDOhSCnKqtTjQO8Eetrn1aHYghJ4ipJYAfOr3w4Q
 vl1wy
X-Gm-Gg: ATEYQzzMR220/72C05muh93uA2sB9NBQM3UHm3zaMuUdQHfn1/Rz/REvRBk/9tdQDNq
 hV56+bsyTCNFSszINj5jWzTGMOOjnJQFrdXUYkSSrRfszcdcvoZeEHKT/MvCsPlwGDgz6W6RUY1
 hSRI1Wug8ksxXkjgCcDrBZrhadkbwv0xCsji1ofuzDipeJEMV8OY6kRm+o9dC1pIpOwbkuzIlu6
 adowVw1tYtsAF307YDAFE/AdX+OmGfV7NL7UonorMxaANMuorUMhJS9CuDrphU7k97g6K7J3UWQ
 DNVe7OJg8IOYYmydBE2tGXclfJSZ4gYinw3uGtAEYO/uFJ7fEfBjsqF3a9UmzyxWmLsnwh9Am5w
 vsxB+N8dbqnc2PC2OUfmPYjyxp/V4H1uD4WL2dMVg7dU7hx+or97DZP2w6m4oUimrlGn524L//T
 klccLD2zzQn2ku4i7I1oTFz3H/CQ==
X-Received: by 2002:a05:600c:8b02:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-483a95a86eamr284934915e9.5.1772031968103; 
 Wed, 25 Feb 2026 07:06:08 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:506c:58b9:ee75:9229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f26d7sm84028745e9.3.2026.02.25.07.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 07:06:07 -0800 (PST)
Date: Wed, 25 Feb 2026 15:06:06 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/6] tcg: Add tcg_op_imm_match
Message-ID: <aZ8P3ghIYdSr69BW@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204052456.970605-5-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32b.google.com
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

On Wed, Feb 04, 2026 at 03:24:54PM +1000, Richard Henderson wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Create a function to test whether the second operand of a
> binary operation allows a given immediate.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [rth: Split out from a larger patch; keep the declaration internal.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


