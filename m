Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E0606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=msW50Ss6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSvg1-0006Yf-1q; Mon, 16 Nov 2026 07:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xSvfu-0006Y1-EG
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 07:19:07 -0500
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xSvfs-0004VW-SS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 07:19:06 -0500
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-372bdb942dbso2943786eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 04:19:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794831543; cv=none;
 d=google.com; s=arc-20260327;
 b=QoAeehPuURia62SBJVi5NOL2rGHr/0qSMehPKkemSSuMJHKsKILEwgvftMURGnzI3e
 q3+VCGZ76aNpPP0VDW/J3fOuunEaCwNVmPAL3QkX8E4G34ZyrCAhGjm7RM8Og8a8pwOn
 OngBXf0JOFS5xzwHRKUVRlNpTWxatcRsQyfbUQp/2GWe4aUEDLJ9Tg+nD/vL1l6PQA8x
 dqJ5cbszqobk3It8pGUqYQUCBcsGFzeqTuePdQF9aT3u121wX7EqfqC/KWE24D4K6+Mr
 YXZGhpHtHTqasrjXQ40ua/g0MPuKhEFHFmOvq/8Pbqm5bq5DOoSusIuZqOs3LgHEyAHj
 DQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cJxjkLBmnB25B2jIeyKQmCdUpS26xJfZ4d2dFpNgelw=;
 fh=8XoHuS5rSky6Q5QTihzH+NHauPFkqo5PY2FLZlkkmvo=;
 b=oDRvYcwXDCoWDw0bDvHPcJIY7r7TIU6wY+goMB6ZZbpzB3iCl9gxL6BWZWCWQZY/m0
 MwegcvKPchEc6EzNOZxPyeugBoOnhVVmKXr0y7m++qf/hhnX+vKxukZRslsnxsDL5/nL
 nwWbpmiSCVvn4L35GbUJOuscbUxBzKW2nNYmjAMUbuafon3w7IhNP2ANpZ9TToWIqNPP
 rlb/0aUSd7bB4PwWVJeYlhDHi+28bLNB7/JfgQJxaOb3CmEzW4VIQ+Yz7X6Mc5zlXz/o
 b0GLzG3fOWv3NHFUa3cq46HmxzrLDb1B2FjCXzKbENOki6HDJJs1UpAAUTJ/LHXUcDx4
 8A6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794831543; x=1795436343; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cJxjkLBmnB25B2jIeyKQmCdUpS26xJfZ4d2dFpNgelw=;
 b=msW50Ss6lxi37LqsVLp6tbAl+g3AczsCmqESGkcxhuB6r8KatkdaffAIOdVnSPqogY
 qp+2pGVa9Iz1yQShmwYDX8surBhUjKCAxpQRvdzS3Ci/3gCOFWSAdpkbcAIEduUKIUdT
 KN3RO1Q5A/j3dQnaq20JDmd0O/xUvN0a5Z5fwIAsI81HYuQNX2bZyeIgKXODypqFIgSb
 GkvK+Op92OMLI1n+G2p6HYLEHCmTUvEThfCqPhHXYHVmSRJEipVXIfjk2d+TJ6OqZGGa
 Pr61Npf5Y87FXBoq7vDLpGUkaXaNFOpKsgcw9sxON2DLiAdenZ0C9JQuGZZBxhzEFSp/
 VHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794831543; x=1795436343;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cJxjkLBmnB25B2jIeyKQmCdUpS26xJfZ4d2dFpNgelw=;
 b=jd3omfRwvr4bvxwNbse9VqX2yAbUm5vM0qpYVSOR2gewsM8fC43RTdOXsXh2EEVTaB
 CnZCbmbtKsAp32+GZr4YE1aN1mDVFibPFK9xmm3xCt5ZIdqfFqwyWm92DVTF6EqEge2J
 X7eI3AZywy+NSoQ8yIjGZzHYImIwR3xrHQKfUhhF+aEdVDB8YVD3GP0dUqSpzxTiiwzj
 MElKVl4ewegV3Ncb1SEEbPsmr57xqGTDK36smNS7GW4L/YF4BMNzb0WvNg4k3Dca4Dew
 giYB0Vd/HmaVsvteWC42B0UJmmyMb1L5HerlfYAM6/dC84mL+ItD1/Az07JBBwKyTraP
 rbCQ==
X-Gm-Message-State: APuU4Z8kU/A9orAKpoT4FUNY4KvwQQQTWeTwwtFwbwehmkVlOdusmwvT
 HLfdzK8518hdChI7juSooZIduNUw9UBHa1tHy6KdxnsvZImFyeBLupBw2SAwqPb3i6i9dstaN/I
 Ib7MZN1EnCINYme8DBb8K2lyteJpz66ILsY3/PVs=
X-Gm-Gg: AZFdTZeCajStrR5Dy5Ew7k92lrcdUOVBgEhLAp85AetZ0EvRHoZp0J3kbTpCKy0fnCE
 jf52MXPIHdhixwmw6oZ0oA3oZKmiUV5mtmJtwrWu0nseVwcAvsQVzQzxbspljvKEjDFWncPRhB5
 lnf8coTEy/XbnHSy3q4g/TGv8wLjttOL+Ki8usu0CPtK8yXhjvHoEuKYdawGYO0DcSKguUrlbsm
 NCDIps2byX3BXUrlLSax/9I68K5tJwB3T6xZScqRYe5CZ76zZ2W1OIYeOiOa+REdelzcCDo1Ert
 Twv6r5D/W6XGDBQKF8h5IzOjJ0L8MPDfTSud0KsxZZcXswXcPKKYjOaFxbhekwRaD1EaWK2moKh
 vIU7frvyBDpAk+Y1qcBD3JNwejuy191otOur145UcByJuz8Y3GU9wS0MI3iZkTyhX+aFY
X-Received: by 2002:a05:7300:d40d:b0:360:d4c5:7243 with SMTP id
 5a478bee46e88-37966e3a7cfmr11442978eec.11.1794831542764; Mon, 16 Nov 2026
 04:19:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108105957.62338-1-apolivodaa433@gmail.com>
In-Reply-To: <20261108105957.62338-1-apolivodaa433@gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Mon, 16 Nov 2026 22:18:51 +1000
X-Gm-Features: Aa3M54oc43bPfYxxY9-33pCKNTuFlJi5B0yfah7pdfhmB-09ryShSoFqThD4LFU
Message-ID: <CAGscdFvSGgpQy-WR9W7T3tF6FN9qSmMQ5y2AOCUoqM1ormO93w@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Allow execution of INVD and WBINVD only when
 CPL==0
To: qemu-devel@nongnu.org
Cc: QEMU Stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

ping
https://lore.kernel.org/qemu-devel/20261108105957.62338-1-apolivodaa433@gmail.com/T/#u
https://patchew.org/QEMU/20261108105957.62338-1-apolivodaa433@gmail.com/

