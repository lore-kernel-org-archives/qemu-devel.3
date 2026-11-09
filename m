Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F4606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CUHhnF2l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLoQ-0003Gp-MA; Mon, 09 Nov 2026 04:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQLoG-0003GA-O3
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:37:05 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQLoF-0005r7-BR
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:37:04 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so744734d50.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 01:37:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794217019; cv=none;
 d=google.com; s=arc-20260327;
 b=kBTSOQgP+VZ0V/mR9ezQ7iA8dOmy+0kzb2fBfvcdGpUnm5zaCM9wyg3hdyUnLOEFF9
 zuwqyx48vYBbi3qVCwiIMeB4sC2PnJQ7FboS+kAT/iM1KKVIVBac0Hxa43l3zcjtCIWh
 oZ/htYssESUdlydahDWIsZdUYYY4aaZ8UnRGBKVpcNhXnL8jJXUSzMT7sOJ/V3fWvZxX
 OPzIoSnY57ZTdd7FKp41DgC9S/wpR29MvF2/lQNhcZkFJLp4YQH3mJI98Miwbb0CvEL5
 hZ1dToD3zBoxgy4l6/zpN044ivVBpjJTA3zk1vW/fMHszDZlhdKSNy2aSNeOuXMcAWKH
 B+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0Z2jINLMyr+CSsEONWTzuCKtsNKkTUm2WOuZHPTK97s=;
 fh=evYu65HJqNwMd16sFKkvgyTnNtakHsnIGR2/vsBd+ww=;
 b=h9PFliAXR+EyI/zKOBkKUdZWNY7y77qenliRvBiSeSZkNcjMPMh6vdTeGFcwogKLbM
 q+o73y3fw+Uk8tzKXlnrQZGZysyfbgAuNDt+4XDKkfoVtCEFFFqFl9t2lBlA/yqMGkfr
 NJpUEzjHK/a6RfI6MpFD4h+6T18awAtHMCBfmjP3Kl6uxHfEPsCg8zGQCoWbfuG/Ooek
 4MasbG55vq0/aOmSh7XYavzN7GnOYDVDnJJeOwee07Y1sKO+1pw/0DK8H/kY9XXKjCY4
 N4jjarA3HdXNN+BEn9upfMLgYD09nVzvmtltUK3Z2idEkOaz1//hBsaw2Yba6O2iJeeB
 eErg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794217019; x=1794821819; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0Z2jINLMyr+CSsEONWTzuCKtsNKkTUm2WOuZHPTK97s=;
 b=CUHhnF2lyyOVAj/2aneBEy620/2UBypRdvXUEXK8jNYZ80+34NbVWXphv1w3IITY4K
 aeX/U/wQ9NSokXS4PiUaAPaqooPLmdqsfKmv3/olCpa8O7FRla4UrlkYjx11lK6fmkkK
 aRrX6WsfDLbghvsWvFGHV9qWxa06fhTi3J6pvN9fSKvMEsbQbuXud5LDguS59EItCSNV
 bNIm1fXyPqZeCk6h4c4+RpaGM1sAj0qpFHspQZMLFQkq6DB/rDF8ZJdkQ8PRSsb37PeX
 Ta4HT1A63M4K4DDwPKL9EccLa4Ycd+BqgzJCj8S7rhNsqQkGIycBot9b/2/em3YGpNkh
 z86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794217019; x=1794821819;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0Z2jINLMyr+CSsEONWTzuCKtsNKkTUm2WOuZHPTK97s=;
 b=13+PgyAt2Dp0sBhddl+nvwCzdtcgo5aPBBqzvSQ7+3R277ExAyPMcyMq8n476r5LwG
 5Cm5KyPwsRVCYx2DUb+DZuggWi/2qcvFbWgfNH8Uga4L/sjVGbDB4LhvcbYBMFDN273n
 tIL3Grh+3nyyihmdYX6s6zzDV6eLmbdYdkJAN/4/9h679M1AvAwR9l0MsWMrE8HPm0w5
 Aivh2HLwrjruTKmV1iDB9jRDaG30SYTCBRdZ/53qnJEEg2nMGvJy+VpqE7SZwXUn7qwL
 JnlQZVArKg1Qr1DRq5qt9I2sPUKnrVwR6h4sJpZTRAp0sKEpMK5DXKT8leJ7jU4SRX97
 Nrww==
X-Gm-Message-State: APuU4Z+rJ1zzXvQPv+pZ/2ySTlBnEl/oZTJweJXcDtHgoEZX0boMhfo5
 wj5TZez3t/qM3WsJ2rNVvv2cz0DLjfQXIDE/io34v5ewwhBgBbuQrlg7LAw+ZrnCddaZLggJhwj
 ETYoQOVR26XSV2jo+DURfeOfkr0J7Z95WaYAVTPIHfQ==
X-Gm-Gg: AYBFou1pqjS+y1do5YLnm4VjzO8oXaxZpuvhwuW6yDU5fiUV6IJTCheZTTqCSA0neCk
 VtXaRMEY1tLrTNDG4qGIy8TPZUlLOiKNMpAhQaf/RBM3gRN8liF3oaMWOH7sbDRLhYMgPhCd32M
 5lJEWNtKcvyZv/h6LYu2a9u5IhytTOexEq5Qf6/NqdLEvmxJqeX+NsBk8yJibXMAZDWteFp5YQW
 gXyFWPuwsCfYQ+Myzf67IKynGZmbNSxwm5rd5V3E/5ZzIunSvQmQRSsHXlObBLk8Q8FCarIBolx
 alBbqzHXqOsBa7fMPDJ1Vk/sZCoYoblfUwP2H6QXQ/sxvP3Z+7CdkiXvcKTtAKcY/cqjJWUwBlT
 QX6w5mqhUaHDR0zw+ciX6IIkEIxbblJ2byWOnpGl1NlFJAyVHUMWqt9+GQ61SdtY/ygUXVkCPJ1
 PgZtNf4AMCk9kwERiN/3auNa3qrBi8P/4s9ok1s+lVnZY=
X-Received: by 2002:a05:690e:1241:b0:672:d32d:999 with SMTP id
 956f58d0204a3-67c3d7e0365mr1790910d50.14.1794217019301; Mon, 09 Nov 2026
 01:36:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106155858.3779237-1-peter.maydell@linaro.org>
 <20261106155858.3779237-2-peter.maydell@linaro.org>
 <a66e5489-7898-43b6-a7c3-8a7a3deedbb7@oss.qualcomm.com>
 <CAFEAcA8jLh_5B563-Y-JmhFoimssDB71Lncq8vy4cf9RdqVm6A@mail.gmail.com>
 <8b2c47e7-589a-4e5f-b46d-11cf336e9a1c@oss.qualcomm.com>
In-Reply-To: <8b2c47e7-589a-4e5f-b46d-11cf336e9a1c@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2026 09:36:47 +0000
X-Gm-Features: AclHuK8xujD4vkOH0uyrr1ZYZXSkybeK3GnRdlQVTEOUdv9tWgtYk92p3jW6HJ0
Message-ID: <CAFEAcA_iUDuBbN43BMKtH3V4n3Ab+rXukP1HfMZhtp=7rXVOAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "meson: rewrite scripts/qemu-version.sh
 directly in meson.build"
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 17:27, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
> I see, the missing bit I didn't use is '--with-pkgversion=pm215'.
> Without it, it works fine.
>
> Any reason you use it for dev builds?

It's something I picked up ages ago -- I don't want a change
in the git revision to trigger a rebuild on a local dev
tree, because that's pretty pointless extra churn. Setting
the pkgversion explicitly to something else means that it
doesn't default to the git revision.

thanks
-- PMM

