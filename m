Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F66606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=khykolsf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdBO-0005Ny-IR; Wed, 21 Oct 2026 16:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdBM-0005Nn-Vs
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:45:09 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdBL-0006yr-1B
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:45:08 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5be3d5927ceso1023601e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615505; cv=none;
 d=google.com; s=arc-20260327;
 b=dLArSK/cCGXGULu8KWY8GzoF3ShCa+7Oe66f/zQluRSEHbwM1TQo1rqMGzo80WXbE/
 vqMXUeEmjpwLY59bQ9kEKswWIzPS9pL0GcEM58ycQHNBU9sTwkh25AKKmXGpbgaLYfS9
 t7yX+8Px01SZc04s6C34yvi5qZGIrnA1WiP1ggOpgfGVpk7N3eC9D2bUKNrISW0zj9yP
 1+gRtIGwLKEmm2bWhpSandoPK/idvsQPqvWfhUql4n0Oki1G3nIOShz9rA534rQ0MFzm
 0N/JCPy4+3L9+D+2WRAPNXnDJHkXaghDfUKj3/Jqy9WMh6IOSuui4eZjPEuI93mXr5Q8
 HV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u9aNv+MNV1gWIs6o/Dj9P0dAdWNL06j7VM1JUOj1kOc=;
 fh=fMfr6U9vqZWyCHK3rqr7ZLaoP9Sdvf4Q6WFrB1e877c=;
 b=VpNKW7CXwOaqxKBPLKwVvOF3+wRKpGlMv59y9h9ojQlLse+31Y3TqjBRgMlmkngghU
 jhnvpF2fn1t4vFzvztUGMPSvnbddby6G6rtTSVQ8vNg08LFaWIIEXTBKDOrxdA+Xi4kS
 saVviEaFa3VoPQcGEwB4Ni9zhXEtYzPZEf8lmYKJuhCaxvP9+tPhWeEFbob8zAvDB2GQ
 /BzmW9rUS2sNmdFJUStekC6xTzgOvLQmUB2YVVoIK2SIrNtFAgTZHvPIrkUrpL0ahr6w
 Qs6r7JisEX7b3gdx3pC5+59aAgRM/o/C54zmsQLHxty1cjxKB2wUff7qYCSOiNwic/18
 PhzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792615505; x=1793220305; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u9aNv+MNV1gWIs6o/Dj9P0dAdWNL06j7VM1JUOj1kOc=;
 b=khykolsf2/l8g4zaRweDbiMhtTkeNDfNBai17g9alpsoTl/PyDR3b4br7JeYfCwX3M
 SDN/39qa+0HSaVGlAQ2lGJaZXBJT/F6gxqJC4iWkE2XQ2LmJMpuJbvRhG+BrgR3cLhMX
 0blzMC2YLvuJUSocs2KODy+0CetD/cvk2qh6vY/EgojGWM9IiHUYiY3R6N3PglbsE6BH
 NPRiWreNuvyLH9TR+AC17uYwhvbHRbYHLyIS++gulGRgc6QTlGRjs9wg977BGPR+w9A1
 k3Cxx3mXp/1DQS7yb6dB0xskkbcsHK4WWdTgj/YNby8/uFhNpB/7/h07PpPUfxljFYOI
 BzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615505; x=1793220305;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u9aNv+MNV1gWIs6o/Dj9P0dAdWNL06j7VM1JUOj1kOc=;
 b=KAapGhaGQdpMwJCH4Jzf7Db5oRvSVO61RuJ7PPvB4U+KX4Is+VwZP/OyMyvvnoJPPl
 4menwIWy/gFAq6fZmrtHcvcnaH2ZXhFH1woTevWtPeYkMrf9RvO58e5GGPKoasyrwQ+3
 mr3JfXrfZ+qoq/azvlTOX9CkugGosPwr36MQnxiJEDZpo7rtys35U0ftEdr2XPX6Hbhk
 uJR/+kjXxta45P0Qa2JZtSZTtBeQ18s4em7OjYredcRCcBqBd854rDSxvqOA2nEGhmuL
 ECFkabTRLIEye8cVAAmALnS7pwA2rtErdL0b0haWHu6XZBYJADisW/2sB+jQ2uIvKMZB
 SJHQ==
X-Gm-Message-State: AFq9FYIh9zgyLAS+pziLt3x6+flVnqQLsogEHmibwJVGJK9QRWQxUy+Q
 OARfnLB1bmVB/5K4trcBgi0NjXqkyV0RHuNojsKmBABj+l2hQTnDgqxLCnfn3ia20b9XzQtxGSI
 L4QLDXFPJuqoNi4tVqcO4FjadAsUGHAo=
X-Gm-Gg: AYBFou2GNZh3ddmRVsbeW+jrYeKv9C7VctWMaj5v3V9DDEfH1/hpUqvAV7CqxTS6JE0
 kbR8QURpBsWZw7sxsC9Sl3chuMZKF3+RtZoiSHy6Lhpy6f9Wx/gc+fMvVQ5T4aSbrabjdFJ0rf9
 XQpErdPnvQJpNgxYT2+p2UnB0K9TjxiZufLKJB0+jEcWJTL1jn3pPmVODm2xolQqqZlAevU3keg
 yHrogmNelVErJ86W+LEHIDnMhQno8tyVhmpWg9zTsEYY1BfHFkXf46YxQ6Pd5cs+mqSIa0hR4iF
 cc+HK1xIHSjS4yZRGS5RmvKwsNq4eAqIHhAmNMMWTSxNLaKozcY2gHEBxfiSwf4oBMzFuP3zRP+
 /QE5xk4FbR+gNH/LvlNC3jqH5Ns23MRjyGY6hX5mSDZsQP0Kigqh7SPPCFTXBgzO2fPev0HzRoO
 Uys9CwjPQonJMqF6hQh9gI72J5wnCcvVf01+Sc4iYgy1+ktIDMz+kRpOBbWK3yIca129pykp5tE
 w==
X-Received: by 2002:a05:6512:3050:b0:5bc:db4b:931a with SMTP id
 2adb3069b0e04-5bfa1bfbe02mr1199076e87.24.1792615504910; Wed, 21 Oct 2026
 13:45:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
 <20261021141652.363109-3-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-3-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 16:44:52 -0400
X-Gm-Features: AclHuK9O8P6nhcVGh-0ukdpygBDomtgJzvMHs1EEFQRrhd2lnaJVtjwOwzOxvbg
Message-ID: <CAEdQ38G57QaMmFRqtvo=Dp=dHKodKhE1iGyxKacXfgHfqMpGMg@mail.gmail.com>
Subject: Re: [PATCH v6 002/100] tcg: Annontate functions in tcg.h with
 QEMU_*_NONNULL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

s/Annontate/Annotate/ in the subject.

