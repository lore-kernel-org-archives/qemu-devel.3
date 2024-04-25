Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC1FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 19:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s04ch-00063B-SQ; Thu, 25 Apr 2024 15:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04ca-00062h-OZ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:19:05 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04cV-0001UG-Qi
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:19:03 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-571c2055cb1so328372a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714072738; x=1714677538; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJTg+XTa+h0Nbw76lWN1ypHx9u/+puTVNQRdByzGI+E=;
 b=iiW5FTbvQF0scX9s1lObl4P+Fary3iIkvSV1F9r54ctGsh0H+ruotsn3YFkf8+MWIq
 L4cghnAeM+rmNzDLYUfZFBFYOfWmIkjKGU7dPSEaXxsghXhl9d7SbROI30ekOzmvZrFZ
 kzvHVaJgzqoBHltKkwaEy4Cry+beIplMQ6nxuHXLywJYnv9br6Q7oCklhPIEuJvqlTzM
 cJmWznGkmeb4WiyPMXtwpAw++kbB364UT3UqS/fYFPajoF9qnI6GPsXlUVV+lTZwQZMx
 iTTzB4xwoCoG0odYqwV6YQgAcwQ1EHRYAvcHEl+m8oa3PDicMWt3FxzPXpPcjsQfiesy
 TNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714072738; x=1714677538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJTg+XTa+h0Nbw76lWN1ypHx9u/+puTVNQRdByzGI+E=;
 b=phd3mRiRBU+N93kg8uPiuBaMVOWuTtJWSsgwFHSLltitCnhw/FTF1+PGISm4LzIIdm
 ShB09SxxyfLNomjkIblgGCanCMCJeBhCfkOJoSbVlhPIuEU+HLlDOauXOp65zDwjrO1W
 bpDzvuob3PRk6IMoEK8l+P2gXVSpuHj43LKgh4pyzV2OCfwQ2DFgry+xtqNQJsXJ2qaq
 w7CwLZQblAFJh3pVvIMefr1XrFzd9ybBuaSeDOxJNgEZx9n3azBzXa+xyb5LwpqW655d
 5qFETrI/cBsDA6nnE0cyBGssX2vr89z0nClWQJ+CEgX+1wxJmF5JQUNHrTRr3rxQ784b
 YH2Q==
X-Gm-Message-State: AOJu0Yw8ZsrM8I9teYJkCTYK1hmjySWo3sypZMIIkFovIPAegvv+53eT
 0PVraqwVCJWQg/ewt7c8asnlTvcL8JyKnwsxAIQUS87GeRsjJPNERf+iIjqVri73Cc2GglE3wg9
 NDQ3K6ZLNdSBwhE9FMbA6SHZGLVftuCyts9w9wYgG+BYe1msF
X-Google-Smtp-Source: AGHT+IGc58jL2O+BfZo6cpcbd9CKwN9r1CCcGfg2+nyKDsgjEDLI58RoJfZzuSPGDFmmwZqPpZo0CA+2KBrxUG4Hox8=
X-Received: by 2002:a50:d7ca:0:b0:56e:2cb6:480e with SMTP id
 m10-20020a50d7ca000000b0056e2cb6480emr414230edj.38.1714072738115; Thu, 25 Apr
 2024 12:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240422170722.117409-1-richard.henderson@linaro.org>
In-Reply-To: <20240422170722.117409-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2024 20:18:47 +0100
Message-ID: <CAFEAcA98UrBLsAXKzLSkUnC2G_RZd56veqUkSGSttoADfkEKGA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Restrict translation disabled alignment check
 to VMSA
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 22 Apr 2024 at 18:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For cpus using PMSA, when the MPU is disabled, the default memory
> type is Normal, Non-cachable.
>
> Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when tran=
slation disabled")
> Reported-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Since v9 will likely be tagged tomorrow without this fixed,
> Cc: qemu-stable@nongnu.org

Applied to target-arm.next (with the cc:stable added in and a couple of
trivial tweaks to the comment/commit message), thanks.

-- PMM

