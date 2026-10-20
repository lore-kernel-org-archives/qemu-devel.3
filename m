Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B16606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y3B7u7EI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCeU-00086O-EC; Tue, 20 Oct 2026 12:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJCeR-00085z-DY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:25:23 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJCeP-0004Bl-JA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:25:23 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8ab38a051aaso29644677b3.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 09:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513520; cv=none;
 d=google.com; s=arc-20260327;
 b=XVpb1mDqt0fEEkvpgVC5rBUCb+9jQ5vep4yb344ZBr60cUt6mLSdX5LBZwFqyDgTr6
 efZQRXS2TSeetrZTpLsRQLmVTenaib7JdEEKRVJzg317f1dHiI4JczGnaWsVT1D5YYXm
 lw7arE31nywVn8Yy5stCWXHS4XY7nd+Yw83gaJFTPrkAwfVDAx9CWUPu1mMwQ8As1vf9
 UFd1SskGF9PaeUmBBFltCHnimVgcpv9RhqCqFTXcv5Pn1at+L3mesDujb6BDn6Lkrcci
 S3HT+Emmns35Kd0aJKQ6pASc1t9iVla7u6wQzNbuW0ASIXlZzzDB4nBvuPAiKqMW5wp7
 veVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZFyRHRWDimKsIXLTtocAbmFsZAPHL360YzlKcMjZ5HQ=;
 fh=fIPIohQIc15h+TDlZgeSwUZMR20otmSRLBYqWU8rFhg=;
 b=nTR4w+uQIJc3gwLCEgkprNxDGO0nzBJO0WWDdNeOxc8L3+aqYakW/aPLgCOMYfNBDu
 YKbZnaPIqvFrzKhfdmos7WdRUjr2VxI6anI8hkWiEBmFXLl7sKbtLVrZLOzEd0Lgd9QH
 GkP+Pl1B3fxGwpYPSF4+7pWyGpsPWM2/C72GT7nmSyXNNpCu4wCfGViID51eeq3S0Qyv
 N7ZHM0DfMN2dhZ819vMb97O7ubPpK3Mp8J1tSA8XMMJ00n/xW1fKd1kW4NYDDvnsmA5U
 cN/7lqoze5OcVmuOg442TXZ6007Iube80GjMDIkC4I1rmktpF67hvzvne7QB82YWfEtw
 sOzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792513520; x=1793118320; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZFyRHRWDimKsIXLTtocAbmFsZAPHL360YzlKcMjZ5HQ=;
 b=y3B7u7EIAPCYW37xohcxzihy3RLq7SjG+03Dimfr5/DQ17lbNIxfG6czpF4QlUesk0
 Rs0lgNlAlik6oRcaVuLz4BsgO667cBDFs81bz2fFjqoFCG0cvXrNOhoVSkqwxhx25i/X
 VCMbWn+RIBPj546jYfKKo2Vu4bQYfxeQh+KP91P7XJNm+NQ8pV2pBXJWi/B6NwwgSgdo
 OWzrc37Tob3QpWJLgdMzakqmWA2X+4C1jOwFapVKuXAg56LOnDTDxaubxK4hiSiRs/f7
 g94Xn6/xWLGM4QKdCo9mLbd/o99kLBUotxQbITY3pVQ8Lwqh90U9gO+vx0Vw2eyivI65
 XWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792513520; x=1793118320;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZFyRHRWDimKsIXLTtocAbmFsZAPHL360YzlKcMjZ5HQ=;
 b=e/2ONrbnAxgJAKtNBxs4vPpj2wqokhzLu6XUPKtXLQe5ikfLHwE1MGNBSQCcspxqv7
 p67jh4uwcm2QW5jhiXU7BrhyVFNwlMroPBNRcNwh6ookJBah3JV7jCdfj62UVJpUEJLH
 J2TmyOYxst/UmfGKa/JSYBuP5l6Ehuju+dLfFn2wtQ4aADX6VzTDdijmZAEtT5hsN1/H
 uGwejJPwBIFxdtUzi/rtZAnXgYda2/N+wN7Ga9c2ZZ1PjXS/4SV/KsYcd+V7Ke7AKckQ
 Apd2DvMe6J//EcYSFOLNu7zmJuWGGt4MXVkVrOr8WRO5gfB45gqhHnja8j8J5FGCtMz6
 l0+w==
X-Forwarded-Encrypted: i=1;
 AKwUvByza9OZbNybhxHpLpDfa4Y3Loyg2Txtt9WCgLqGrPtNdNrFi65+a9eW9ZcovYIG81UYmbFbOEDhu72H@nongnu.org
X-Gm-Message-State: AFq9FYLAGPX1jqxRv2KQc3WC7sYIJ0V8SMOYmRRrioYnEv8x5qK1yrX+
 H54Fdo/7tPHBgFBVDi1wLuKt7A3ZntVDb6qsJwaXjtRnZF6AcV61uV6kTJCM01W4//i+dTvCOK1
 jd+HhQm/PakJ81YAGU+9Y20i4t6KRrts4LXrH6Ovk7g==
X-Gm-Gg: AYBFou2YEjthe+WLxU28TLMVg/Zc1ZlINWu4qFPculIE/aBL24z8kuEgNbjh6MBZxfQ
 Q5Ge+TEeDQB7B31fGOA3Q6jTCYmwgwm6X9Yon5ypkmw3aTqV6dv+F4W+5STu2vvtmBMN9yKfgJ7
 msk03aElEfUuvPqI5VpfBnMmbAvyXFY3SzzniSKJF3OkljVVPiK5/mtFjdVfPH5kMwz9rpn+LF4
 hRcCO5cMYgJMb19H4TSBR2xtofxXgaJL5X5ZMrCC67O02WjqwTJdSiXGZa+T3nGHayCC1wpy2qh
 RS2Uifz6Iy4ASA0CBn8sZGG3kRBvyjBd/WLlS3rpdPLSwRy+J8CiJbozT6zjByYWH8kWwhoMM/b
 WKt44kLYT0CvMAv292BnKk0kdcSsAyC3sd5K+CQtog7LwRidG9g==
X-Received: by 2002:a05:690c:f04:b0:8b0:89ea:6aca with SMTP id
 00721157ae682-8b0f205b7c7mr41948537b3.6.1792513520046; Tue, 20 Oct 2026
 09:25:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
 <20261019120517.1448687-20-mark.caveayland@nutanix.com>
In-Reply-To: <20261019120517.1448687-20-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 17:25:08 +0100
X-Gm-Features: AclHuK81FSUXc_eOw_N_QDMC3HNYDg2Uzn43k6DU9fOUomcs44mfgMQdEdvyF6E
Message-ID: <CAFEAcA-wt-N1OJvEKLVOBRUX3grzSLHAN_SuntdPkTcSUXChwg@mail.gmail.com>
Subject: Re: [PATCH v3 19/28] i8259.c: introduce TYPE_I8259_PIC device
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 13:07, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This device represents a PIC for an x86 machine consisting of 2 cascaded i8259
> devices wired accordingly.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

