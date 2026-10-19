Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B734606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jxxsvMLF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqFW-0004vg-7j; Mon, 19 Oct 2026 12:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIqFQ-0004v4-QK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:30:04 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIqFO-0001hx-Tp
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:30:04 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b118bea471so3105447b3.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792427401; cv=none;
 d=google.com; s=arc-20260327;
 b=Ff2QZeJVcg2wU05YUItzBMSyZ6YgChsjhPWa+yrY83N0PNWXcsP119L31AArpzR882
 FszJrr1dAmp0ZnrTNk/pX65FBS0xsE4xmQYrf75dG3Hh/ThjE1uX58+5AkYnd0RX8ZjJ
 C66rp+fFS+/NboLxaYRKa2kgI2QhY1+2rJgiQjeIaKXqADJAtOQ15WDzsc21+JkjDHSJ
 TKMi8CInq5LLHixrg890il9iyQSYxfVg1bz98t7I4tcry+rs7UjGgUNBLz8GaIWve/Yq
 s/y3uJ6NPTNQcalykH5unrmElK1/zcMRR0HJIlaLeauxDvhx25d6GWLF66Dl7gdb+u5a
 rjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z0n5kzwllhycJNwzz7O7iDXpRQDJOs+Vdz1EpH/TaT4=;
 fh=2pP+O1em66D2PRn9aGMPVObofMcBhXtCuMqUbD3jSgI=;
 b=CKp5XPbW5+bsv2xoxkPsnOPc/bXekftsE7JVID6nBdQqd/uwZAPC3VFnObNpQUBs8u
 VFNbVjDTyf0oG7JtQbQdEdYh1zU2/zSu8T/VUnUtDzBN7x12E0PvzktMh9ptuGHb5C5k
 iDZ3I6tey0cKbstWPTqYfpjr9LWw4F5be4YO1RMFpid7cgjRJOYNn+apJJNNO/+JvhG5
 HkeChtFc/ju4ViQwP+NVIXbZcjWS1dgRoHn9rnjNSTzNCwm9+yHMJnlDvrlnUGACK1pc
 oh/nEVO+0m06qKJPj/jNjbWP9FKFKPE2vMtUpJB33aAj5Tg3aQvRfvYArbzYkpKvNLo0
 eGAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792427401; x=1793032201; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z0n5kzwllhycJNwzz7O7iDXpRQDJOs+Vdz1EpH/TaT4=;
 b=jxxsvMLFmUGx2rwft+iKBVShEZgz2/DlgSl4e2VekMiJxIVVCMvvFA4/ePr8uBA5N1
 F+h0tOz09tGqYx8QxX87Z3Kp12yzUwIFobn2np0QRfDorVnTMbmc8o6j7eqS9XzCwgBx
 XYRZt6kYo4X41bYePYRGqzdD689CsCsBg79oQ3iacplTOntaQJbCZhvsBGZcsHE+cwH6
 jwmpESYIc1dJ3IOMs/qoBI1NNIgKcrqTeXoDLUGqHrjEq+UmT+YAbO/+h4AlJiduCXh1
 YVt5nvH+nNybVw81/utsPRZsS4aKToNKp6YtterbePZBtpKNQ5BPP+gYx4niX1ySf200
 rtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792427401; x=1793032201;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z0n5kzwllhycJNwzz7O7iDXpRQDJOs+Vdz1EpH/TaT4=;
 b=nsSkKPZX1PxQT3xvGYC2pVlxeHtOjrtvoT5f+/4qToeTS3t1myD8WHPU08AeeAb31o
 fyUFF9ps8Vgv1QL8JeNWyuDX50QI2RjEQ3aSzmNuaQCqKlRpwN7PlFNHZzzLSUXypiMM
 hxHg77IBu6rDFt9UgBzpZr94KL72L9D1lFQfvv/acXog7dVGEr/jyS0CUyvFSpbMlKSP
 omvyPsnkRQJlTo8PdM1NFroKsTWNeOCGjnwi4KmRO6NVWYlSa3nq0ntrO0HgNuBofR/K
 tsfScXpvz+n8Y0yrcZ+rIXjnRnh6Tke9F+q1Tdfb+InPVe7zCeT0D4b5l2oJ5LavwqlM
 D4MQ==
X-Gm-Message-State: AFq9FYJS+aYhAoTpIB9xD+OtNKBKQHpwTc2lb+9SUoZnW1IkzMj8oEAH
 FOWT64Em+wNMoUdNSmgf9jKt/JL6TgZIJMiSn4Q3uzbub3AVEaJx1SSBRg+9cfpfjQnBt9R6HeT
 1GRmhWyZGd/H481vWg06/Mvavg8c3FhUoMw1XFpDfqg==
X-Gm-Gg: AYBFou2H+MAclCu3gbXbZvp4cplhEoa3dXHo35fOdywyvNa43ItCy78JBj72TgjLZ43
 kFp2bk5XmSPlef86fNiYPRbdlhEtXmlo/Z6zzHZK1ZBVaMFd5dOjT4uV0vFFvp+xpptkCU3NNOK
 tU0GjFTXpbic4owny2KRiTxRplTVtBFvgp2ux7Q0W4z/O7p3PF6ujOiqwRnRljz7OLLyH2Xk4eF
 tClovjvoG4kNxI9yw+q7MIDiOd5WR748HtZ8RINKb1vuZeRxNoSrdO/WFSrQqc8bkPSYZUYok/K
 Gj/YX6wF6h/vtXfZgHGjdhE/pIojH87cSxveM5TQLazYWMYNXYk830RX0Gb0wPgrganIJmLRSN4
 9k7MRrfxsg92Ru6AWVEc8s478OVLamwTnZzQLDNw=
X-Received: by 2002:a05:690c:c512:b0:8b1:9c2:87d6 with SMTP id
 00721157ae682-8b109c29015mr13609837b3.17.1792427401295; Mon, 19 Oct 2026
 09:30:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019155519.1302964-1-samanyu.goel16@gmail.com>
 <CAFEAcA_QYXpjXdC8oiTfn2Z3E99hW0j-mcDSqGLhKfKKex8VsA@mail.gmail.com>
 <CAL3-oQiGT2OSxq7casnW7JuwrCM5wa2L4SDpDe_As7+1hyEuww@mail.gmail.com>
In-Reply-To: <CAL3-oQiGT2OSxq7casnW7JuwrCM5wa2L4SDpDe_As7+1hyEuww@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 17:29:48 +0100
X-Gm-Features: AclHuK_sCX-JTw-AdXEUU7Ddhih0pcFE2Vvyyw9uD0z3UURYvBh7lWGLNVxrmxE
Message-ID: <CAFEAcA82xogQU1vW=NLSxvZHOcz4KvaL3NutgXLZ17eNAvt7nw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/exynos4210_combiner: Fix out of bounds access
To: Samanyu Goel <samanyu.goel16@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 17:25, Samanyu Goel <samanyu.goel16@gmail.com> wrote:
>
> Thanks Peter! Good catch on the read function, I totally missed that part of it while focusing just on the main issue.
>
> It makes complete sense to clean up both functions together in your fix. This was a great learning experience for me, so thank you for taking the time to review and share feedback.

No worries, and sorry that we ended up duplicating effort.
I've got a bit lazy about not assigning issues in gitlab to myself
before starting work on them, I should be more careful about that.

I've just posted my series, if you're interested:
https://patchew.org/QEMU/20261019162217.3272337-1-peter.maydell@linaro.org/

-- PMM

