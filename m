Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61880606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QAaoUFu6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUo3-0002rz-CW; Thu, 12 Nov 2026 08:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUo1-0002nd-Bp
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:25:33 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUny-0007pI-Os
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:25:33 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67c00f291e1so3282064d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794489929; cv=none;
 d=google.com; s=arc-20260327;
 b=IUTzpCqlU3j22JvcIyKiqZm/r68iq0Y6+PC0Ac0viLOPkE7SzSjMSoN9sqiOMX0IMA
 Arr7TGVMYrH2ivw0NrPILdMShiCYS0aWfK7gLqkeJ6KOJuKokAwK9tM9GbEI0GSi7NEB
 Zp9CBPkff+/6KdFoK1+9RY839JPsZy6yfN7cgM73aoVFp0HIh43oY+Caj9RSBg/nYBwB
 UZ0TzxhuGaJw4/iA2wiC4rNPMuDGgD8V29kd8SfYv3DZ8PNrdtN0H1E3g3RZAzNd8zfW
 ATZaoF+CzVXafhwS4ndOfXO5TLcXOB3WkAUzVWIepoQSaBgC9dxhe/TXFY0f1yy2vx6l
 GuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=owGl/RB8+MhjCv0gdguTj+3UJocSFxqUClURhRfmHak=;
 fh=LaJaxYShi/0aYa5OYrzg1Kb/HemJaaEQJ0py6LN6jcg=;
 b=UiXwAzbdHLpq4GqWG2chv1xYrhoqL6RiC6B9z+5u3C1o9uaVoWfNmGl/F2kca/t99/
 wsDgiMxVy9tCRUkgkCIFaw4LDVPdDvt4AkTVq7bZx0dYVj7TfeThnjBLBqqRlwgTEzSG
 gu6n2smUUzhlqvZC+K/3yS38dtl7ASlYwZhHv//6d3HsK/NFof8DV+DHVT74gPS6MRwt
 CBBeRERCx2OtHuNNXXAA0W3weSq8kT7fI1iDy2MvbeGNtJ75fqUfal6vCIEjgC3tUoOs
 TWG0oJMd9jW7EJqxLmS6zmTnkvAlxZ60uIQ45OkZdkOkw/xnayla9bCtv5irDCUqq1Gw
 J2jQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794489929; x=1795094729; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=owGl/RB8+MhjCv0gdguTj+3UJocSFxqUClURhRfmHak=;
 b=QAaoUFu678tA+iL3HU6DkVkcGPt1QR7wb6YhiZWNhfrFfTCXJyWIvC2dKAQ14lZdlR
 ad0feHblF1x2S8UtuTq7upPg8U4txsOsnFPrCXkjo6HUVsPnwRbt7YLRTtcqTb3FeB7w
 3kCMsw2xMjxovHpJlli0+iuZvjf4ihdDwlKDdVIfotSlwO5lbRcvidv8Rq84MsKZxkBd
 BV+U8kqm04bX6eSaGJM0NEpH8HdplZpKAeBOVzZvrsrMdSTQ4REQnKw0bw94Ymnl69n5
 9atZaYvWWaIEzhHxS046xpQfl71OvZirwW6OiWUTUdyUliInt9cHDAJhOf/jPDmdYBSv
 yAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489929; x=1795094729;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=owGl/RB8+MhjCv0gdguTj+3UJocSFxqUClURhRfmHak=;
 b=Hh0hAObWFO/YHicwAnsWsAUX+ai0o3sK6265yOMVOJqAA9rTLz4BxVe5iaxTVO2wfg
 SeKn1Okbt9tUVIIyMRgrwZbQPg5KphgTeShQSvVqGfmOJh5w70lIXs1tavcVnNELctgj
 VYY+55qz3C/kb+oH9m7U4M0HfWIB3y2F8dV4v8EWhdeJxDepvFTO7SOui1vM6wSGuQWM
 GOvKdF5f71r6evUEmdcnElFblApqVbyevWnd8P3cID5rYAIvhquA6T79vG25uN+zXXpT
 vWRcYAYBtVaR0LpzNuCvGC57N2Ep1OMBvisYqS1Gx6WY9pRdBiGH/aiRuvC35oHWyd3E
 Dk1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFz4BEJTI7+Oaneuhya76ZC5FMq5nW3gnoqmqgfScNwXwiZ9pkeqj7KyM0K1UzNgUOOsLvJ7qAyc8Jl@nongnu.org
X-Gm-Message-State: APuU4Z9oESZ10FR/BgF1Tv5JQuRHvSninqCgP69C7tREWhwFES+QQxx6
 ItWe0E9MxCsa/zonu3o/0Y1E1WiPP1R+nzPygHrpXksz+QGNHDcvjjUZicveClP8oDjzAfTrUq8
 SCQNA2MiJALeIS6oEMw2c0fMTu3ztY02F3NQC1a5YMw==
X-Gm-Gg: AYBFou1tB9Arr++deAu6nC4NX9WbESmRlKKs8mbmS3ktxR0Ne0LG/H7obPSIqzfy+3S
 E5FT3cVO5Q94WmylmNGyFC0Bmf+Gbz1qzZE+l34D7V5E8Bi+xycFPbACJgWufSeHIkHMKsRrl7G
 BtMOX/ZflqWz0DjudCElQddlLRNpFF4TICgBI4sQr5vjTzuB4HLDgI/HSxMABmBJcEJ0y9zc6lP
 NKAC13fvJqbsI4oM7pG16M+hvMw4xtUSLBv+4f6Bd4tu24/hN06M/i720KQh/tZ9oVodlzpwjZ/
 qhkjSwjm/eiI3yGuZaDFGuL5kx4+xH3ejLIK8GqfxXgZrSnkuQNsTEpTfX4lZrGIuqFtt1qlJ+I
 WE/Nko4TJJiLrLRn4xeI21VXBjVhqNVLWm2+gnnPJbeF43gbikbEMSqqcHYhPyaJaOuIhN/KHAl
 JtTQQpqNUlKA7RwH7z/dNp
X-Received: by 2002:a05:690e:4853:b0:679:a8f4:afb8 with SMTP id
 956f58d0204a3-67c68078b4emr2319843d50.114.1794489928798; Thu, 12 Nov 2026
 05:25:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106163657.3825938-1-peter.maydell@linaro.org>
In-Reply-To: <20261106163657.3825938-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 13:25:15 +0000
X-Gm-Features: AclHuK-BFHVld8JC-5-Tc6LJsYHos9GkH8dgMgcUSvXf3jdQU_3gkzlRu5RfZ4U
Message-ID: <CAFEAcA9_pEwO9dotcMmKRJBjqHNqu1OzZWxVzEHHVBddvzBOxw@mail.gmail.com>
Subject: Re: [PATCH v2 for-11.2 0/2] Fix 'version' arg of VMSTATE_PTIMER
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 16:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The VMSTATE_PTIMER macro is defined to pass a 'version' argument of 1
> to VMSTATE_STRUCT_POINTER_TEST_V.  This means that the field will
> only be used in migration when the vmstate struct that uses
> VMSTATE_PTIMER has a version_id of at least 1.  This doesn't match
> how we define other VMSTATE_FOO which don't take an explicit
> version_id, which is to use a version argument of 0 (e.g. all the
> common macros like VMSTATE_UINT32 are written to pass 0 to their
> VMSTATE_UINT32_V counterparts, and so on). It also doesn't match
> how we define VMSTATE_PTIMER_ARRAY.
>
> The practical effect of this is that users of VMSTATE_PTIMER in
> vmstate structs which explicitly or implicitly have a version_id of 0
> were actually not getting their ptimers migrated.

As these are both reviewed I'm going to take the series via
target-arm.next.

-- PMM

