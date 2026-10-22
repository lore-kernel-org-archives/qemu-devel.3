Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D2606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DpDtft/t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJq2N-000114-6m; Thu, 22 Oct 2026 06:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJq2G-0000zc-Pw
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:28:37 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJq2D-0006sg-MR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:28:35 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8ab38a051aaso16666587b3.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 03:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792664909; cv=none;
 d=google.com; s=arc-20260327;
 b=aIIxyRs+Ujr7M2r1729cveQkdhUwh6XnC/qNMuWF+4NsFrvXUx97ZfSXvdOXu2ceBF
 PIVT4Le0jWQZ5f2xrwiKHT5q5oC8FxksnpVtOQrMODvhAUD+ZPJxFqbcKLAW6Geh5ZHx
 UO8tGsJRYewnMx26ih2w5MkjxiYwVabZjvHYiWexSbI6XBuwPifa7+v+xfFTyjQXd+G6
 QbD9FaNCcWcTWii7w4QvLuTNYFsGLe+QdvK6DcV4zfMmR3KCq+QsZce2SxY6ryb6n87i
 AxtlJ0c87rR5YiAHw9FT+iHD6FcDMOkTFGR9FMYMJIqvR141DwufhbBEhWSsFtBSJ3QZ
 mTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bi9/Yrj5aHhJwRPqGy69fpoodMHfZzxTRJdveUrp60k=;
 fh=YjtRO7LqpctNq5bCrbfG/D4QAPuYvwv8Aky8Y/TmIjE=;
 b=YuwgBZWWJhcDyFza3uHbxySUX5CSOgBZXgHbKjsbwIemLqKCVNxWX58B1Jn1J5E+q0
 MoWzCgt7xa19O+NmrYTt4lh72fSxjibqR7OhcA9u+FxRjPYZ1VEcxHF3inZrsvrCExoE
 tYal2xlQUwrs1XzhkQ8AobqlgQQKhjyLPHrn8M5NTQVauziZAzWR5TIC8j5eI0LKzGME
 VyJY9dxXsDbW96evy+Ls0UsmOuhF+60avP06tIg6+ymX9hO3awV87DUeoPP5PeNPiwIX
 5wdSWu0b6M8pj7HfqQP8uh0FDkIMfkKxwRmz51MnNjoab46aGisrDUYRcb7MOY1tgzCD
 AwLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792664909; x=1793269709; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bi9/Yrj5aHhJwRPqGy69fpoodMHfZzxTRJdveUrp60k=;
 b=DpDtft/tiTR1SE6VDlJP8EqIbQ3iab46SZjkrFRUsGtC9HaWjCXw+TELTeSWXKlTde
 eRWuVlla56vHxqV1WM+ZGZ3C8oaM01G6g6zZ+t5jV9F3plSO2jSA+3diYbLYO6qp9Fb7
 +i5cNkvezCOB3hQxjW+lmZoW8j94TWsd3z8ECB1pooJcTx8UjFAniY5RR+Hwbza9wkPb
 GAnwUgYjJh9+iLnat8BNeWmk5T6jPJQTpNHoRhMkYuy2q8EK4+YEQWnhj+dQmpJni8IO
 jwRFVH64lVAiZ8/MqUeB8euOU4GKAEbo/qbBl/Box48gM6Kr2t/dpYZUAli4QELLYQQi
 9muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664909; x=1793269709;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bi9/Yrj5aHhJwRPqGy69fpoodMHfZzxTRJdveUrp60k=;
 b=gomVN86c/wedgN1U18j/YvG68fG9UU+Jf9GqxWtSg8f17G2yZ+mOeFqpk1+Ii3Hb7P
 sCcindJifKbIsDGWWoE9AlZwDr9JxFKo1T8cxag/7h2NL8PH5ov1N2ei/6WdzmJm7o2g
 QobF1LZ+tSN7g4v77o+2bwSyM8EcaWQ56tIw24IUTzimWmDSizohPZKi4pUtrQhj1In4
 Q+b6GtfYDciA2xzWfePxbz7Vi8iRgsEtiwkStG6L7So1JdsEvDSs3B0HDckCdc9C6E0D
 eoRQ1UMRz+H+o/gBkyFXvjUc4OplvE1Z+zLOkxr3f46vwyoyrjIMKcJBLiczWI1QOh0F
 u3QA==
X-Forwarded-Encrypted: i=1;
 AKwUvByfe7HarwtSpBHN+JIrHvvByUI7/my3AyVVdnM51w4DXL7PzKJPRzjyYpqIFbECwW8NFcXD/C2eLQtv@nongnu.org
X-Gm-Message-State: AFq9FYLEWsChLySKddf9Sp+sx5UJWrmtWNaFyjrh+lQPD6y+Zq2nQO3v
 +aAfNy0lVws6YQMLIY+4LCeb5OuSDwziGDFzvzM3DpcP236ySSMK754PgIut1OmIHAgoj62oxQx
 QyjZDv19SNIIqQny8voYWbn/MBEHOQLYAF9bW1fsHXQ==
X-Gm-Gg: AYBFou0INpUdJeFb7m35b3CgleOiWqviboKkK8wqLtBY8Jj/a/V+bAl6qy4iUvLWhi3
 iD/eaoNK2s+RCNxYy0lWmgnS5TWj++NqXBZ5egOlkyJSKAwqLcqvZ1KxuDwBFeyI6u3DqkNkHsi
 X49HfBmRtMPDijwfmeKJX/Q3rpe1q6nf68ZOw1HKYU7/gXO56uwQqol1ZFBoFqiIg6BcJz9jhBa
 gHKP9GM3E8uXkyOmfjeqdx6UveEC/xASQHeUGCdFoocKm48gPuMsGpKkj1j+3qLP16UbpJDFtGI
 4KuRQzOZqGKGvIYy0++ROma7Hqf9lRuHQnPH0HBbXORXmpuSsuM3a23rUonZWQpK8cy9U9r8T1t
 1Ytnn1t1yxWAz9M2l57ynQWyOKyOpqmsk7po7Lse70ITv/ZSeNjSQgOIgyrmcTfW6xzjMGlMVR2
 0ZLS6Hp1X5u9GCSTlAoNPUnz7ReKgPWx0pGCgP5eNAoyI=
X-Received: by 2002:a05:690c:e20c:10b0:8b0:6866:c55f with SMTP id
 00721157ae682-8b133f40fb6mr18913637b3.46.1792664909250; Thu, 22 Oct 2026
 03:28:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261010133725.642498-1-eric.auger@redhat.com>
 <20261010133725.642498-2-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-2-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2026 11:28:17 +0100
X-Gm-Features: AclHuK_1uR0exODAeKMpAGKzedhGf6mf8KFDecCGvUHfOXUQRy65hEGCVhlibfM
Message-ID: <CAFEAcA-Ab8wkv0vedznXdzx2u2RopoRfr7SHnqt3Fr71yj=vBQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/26] target/arm: Move REVIDR into isar.idregs[]
 storage
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 
 maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Sat, 10 Oct 2026 at 14:37, Eric Auger <eric.auger@redhat.com> wrote:
>
> Move REVIDR into the isar.idregs[] array as other ID registers.
> This will allow to overwrite it as others.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

