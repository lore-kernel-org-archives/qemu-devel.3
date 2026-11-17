Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90E606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Uu5nqL8i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTP4P-00014S-IB; Tue, 17 Nov 2026 14:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTP4O-00014J-9w
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:42:20 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTP4M-00062f-MY
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:42:20 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67dabd38cdfso61932d50.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:42:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794944537; cv=none;
 d=google.com; s=arc-20260327;
 b=MNfOBTFgxWxshkpT6o/ZmSKuPrmIxsOgNl7gJi4U4qvymCC5LIOMywTclL0OvQ6Yvc
 euebdFTUagtzsH0kUG+95MRuk5zNjMgAnCaE1br2o+yJHRIS1s9IeRSBmtnQHE5h0YgZ
 ztPJHzsA2On5Nc7qCTEl7OCLEDCNbbMae9EVZBtPMpAPM+ETwwH1ygkbfHriBiG5qZTQ
 h7IJlrob7N5uhpUFem52LZsBbqlYc21QH6+/v4pXARXcZBaluByxDrQ5qJPRYQ2BQr13
 cSSkOwWOIasboVXLOXzDDWwEKLyD4SjwwKLq+kriohL7L60cKoa0CEqyhAKhQHSoHKBd
 UUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qC2M4MlAHstotd1o5Wbg8L/125GeGHd2LR+NlImlzY0=;
 fh=qwbYKeLUuCPHWzfL1kmHdeMNIUqUomyFmcswDM9SYeE=;
 b=Evgm2vbE+yQkmYuZI4yLpbd4pOum3u+AKaXyaFKvv8Q3l2CzMbbk++0qijMXoVv2HG
 2J1JgC5zybSWidRQkFJInjuv4QpwDT84i4YeBitlzwnrXUUHqZl8DrU6A7dz0bsXlQ2z
 rOg9woDedX3Ile/nWQm9e7Hf5Ikikv/Wb9gTS58BPaLNYKXCJC/6vMEzAe3eIvECnEpW
 HJKVQnBIMSYvX2DpwvvrKn9+iGZNPl1CzNNVpWApydmmGE9yuCRIR0tp2VC+BeA9bNUZ
 Y1+HT4WO0m3Csf1R2Ni6Ec9L2owEVe7rEtD3X8QDVtntH1N/sSc1ChZ59NkmtOganX6K
 Q0pA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794944537; x=1795549337; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qC2M4MlAHstotd1o5Wbg8L/125GeGHd2LR+NlImlzY0=;
 b=Uu5nqL8ixScoZihAjp5xS5wzSMuGaMBUsLIWdrDq5cXzAXPukQMqOrGrYiJNvicCKS
 RpW8dGUGbP4ptTvCDASbL5VG+Nh8fz7qQjiBCTZaPLhLraKZDHJWkLz0zjldnYcjek/Z
 y+yznf98ULcozChdIwqKv7yBnK91Hb+3ygbRTRRTU3YsO9nXY0LQ+/oRrkknUhP0tW5i
 S6n+dtLYspRuprmujCdZ8f8b2GTLH8PPneJhKt9xrZrdBZqm1QX9JvMerjcOReqPu63k
 QrhVyFlzG+ltrHXP1aNtmycuKanBNuwsEGiEM+zJpjt9JSHTTpJdYY892pEPP5zGM2TY
 kNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794944537; x=1795549337;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qC2M4MlAHstotd1o5Wbg8L/125GeGHd2LR+NlImlzY0=;
 b=BwpFcqKLAjhevQCZNI30byexiiJQp8Y8prLRjpNVHvgCMie+xd0Y9/GSr0/SO35OC+
 05YBRCcU+MBnTtrlC3R1+4iNo98mXeyV2au9I7pxn/ozOOGD1JmW0Ky2TTD4GXpBOOlv
 8/C3s6bJULjfNrnCqXHpAXf79Vhn1jPaCB0fHmTIDxs+ui9wJpFvT/CK8NETM5fpFrgN
 ZRSTHWViH4cfdI10dnKjEYDfqAeoWROVMPIW+IwtxWQurjJFHd5i0tOkKa/Y0RB73erf
 fgNlqD+MDZi4/V5eHUS0S7NOG0eWRDtlCN+Flwpbis3ESF9zlaPzGLlxRK/c2YOUcflW
 g8qw==
X-Gm-Message-State: APuU4Z/w8q1iKU6bAemMzv4OIF0q8si1MZhJVbgOC4toJrIqnUOKYFm1
 JxRFrCB95+0uPv+TYRzW8jwdIr3Vdd7VUvLaCdJ2oUMWoPCIX2BwaVlTO5MHNGLRKy3ZsUWfpmV
 2ju5dO4S28tEzCnV04bnqXIGM2NeHZ8WVWDujjOPbPBpSkrltpCgsYE8=
X-Gm-Gg: AZFdTZc+lI0Q5XJvbrNQILo4YXvGdQsk27vZz5+QO6ral9F4wBdh3MbwMgOdHz6RyAq
 3S2rIg4XdqkN+auDbP3RT4331/wa2mL6ZTr8S8txQGDALreISRhPMzBMSExMrokQgP5gG1TjgfW
 UQPlTs404shgDlXEnKCIn4Y9NwTR46yVEeQq3z0XrMiNmlIVoVqqjzdLocMXopr/4NAeLaQcLTG
 adLtrlOebj3TRZYOXVjiYQoeJj1EhKELqDgQ1es/deyuNEpL7kE1fQq5IcDZa5KHhJvB3MYVMD9
 PUIPhLMlt03tqWwE0NadBX9VEaRPtpVbwUGp3AS6XAL1twVj//zjTz83YqSIlw2ovX9nJA7lYvV
 9DkvQCQvqCDWITp3Y29FktBbEX74Sf0NMAI9oal2SGGqHquJIRxGQFpwoh6JYGWzXi9SEukI1TW
 QVc4RHwP9jjpuMoYO8yq7W
X-Received: by 2002:a05:690e:4503:10b0:67d:c5bc:c29f with SMTP id
 956f58d0204a3-67dd3d5a54amr227985d50.14.1794944537169; Tue, 17 Nov 2026
 11:42:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260918095718.33745-1-guobin@linux.alibaba.com>
In-Reply-To: <20260918095718.33745-1-guobin@linux.alibaba.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 19:42:04 +0000
X-Gm-Features: AclHuK8NFHLOU3tmW06ERBZtNNXj4CXbsRnKvNrC0HBiPVOkWm1sALCBbCKX3I0
Message-ID: <CAFEAcA_wtZP7BvxMfamQG8XV5U0Q96Y1=Q5PL_mCEatfdrywPA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/canokey: validate endpoint number in
 canokey_handle_data
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Hongren Zheng <i@zenithal.me>, 
 "Canokeys . org" <contact@canokeys.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(added the canokey maintainers)

On Fri, 18 Sept 2026 at 10:58, Bin Guo <guobin@linux.alibaba.com> wrote:
>
> canokey_handle_data() takes the endpoint number from the USB packet
> (p->ep->nr, guest-selectable 1..15) and uses it to index the fixed-size
> ep_out[] / ep_out_size[] arrays of CanoKeyState, which hold only
> CANOKEY_EP_NUM = 3 entries.  A forged bulk-OUT transfer on any endpoint
> number >= 3 therefore reads a bogus length from past ep_out_size[] and
> writes guest data through a wild pointer read from past ep_out[].
>
> Validate p->ep->nr against CANOKEY_EP_NUM and return USB_RET_STALL for
> invalid endpoints, before any array access.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4481
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Probably worth Cc: qemu-stable@nongnu.org

> --

Did you have trouble getting the canokey code to build? I've
been playing around with it, and the canokey-qemu library
appears to have a busted pkgconfig file, such that meson
can't find the include path for it and the #include in QEMU fails.
I guess if you installed it to the system include it would work.

NB: given that the canokey-qemu library is Apache licensed
and QEMU is GPL-2, the whole canokey support in QEMU seems
of very niche utility, because you can't actually distribute
a QEMU binary that you build with it AIUI. And distros
generally don't ship the canokey-qemu library anyway I think.

So is it actually useful to anybody, or should we just deprecate it?

thanks
-- PMM

