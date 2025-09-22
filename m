Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FC3CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 16:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0j2b-0001KU-TQ; Mon, 22 Sep 2025 12:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0j2Z-0001JX-1c
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:05:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0j2X-0006RW-3M
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:05:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e1bc8ffa1so2011665e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758557119; x=1759161919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdAmkQQXlSmoAV9DHZoJuPZh8+6srGbWXeUku/s047Q=;
 b=UhHipq2am0wcYQ1Q5gc+A0pA9Sp9lqVXfFKJt9EnL+cyb9OZZXaCjtT755065VETu4
 kZZ63XhoP0AL0sDcpsh142jaPwf72eWDyanVNA7+V9teTrBNu5X9UxH8o6THoSjYwnzE
 PbsMPSuz59+r7ito1CvkXxDxapTc+gF34i3F9whb09UTP15rjbJ8msIAiaIDvOljpRQK
 ax/SdpUTgPG5Rve84k5EVNcFHFTmnX+7vaqa7K5EPk5S/6vTuXHTMOwm/BSXCzbxCVAD
 8MH1RySrnSzQFPCrEr87v8vab0z4Bjquhbirjr/F20ijjtGP86WFhAcphIoCtHmTTgX1
 V2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758557119; x=1759161919;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YdAmkQQXlSmoAV9DHZoJuPZh8+6srGbWXeUku/s047Q=;
 b=Z8bCqsTkz/MTzkx0r6G5P8NzYiSa1MUSRP2I8UlUhVSig6PF7wIH7mOkVjoo2LLsXE
 bfZ3dIzrs/jcnKSYuT4YGk2lq6kjBobB30xnQAT3620VIv+LPe8YS3ZrpB583xV0fvfF
 /NCz7b6QBg/6A0zwPFcJBI0XP2GfQIhKdpXgTgsPhOBEcWzZ5TA5b1gqbY05fePSG0rl
 Djb07SfR/ucqLIsdtq6yJiafu2IqvBR4Z6nqU3umew5CLW6qJHGFp0ck53RETvxVlH0k
 kP8W8SQ8zmmx8EJHINnerVlGGgdG0W7CjgJXVj9aWvWOtCHXUDhKC9FxLptxKWPgWU5i
 Qo/g==
X-Gm-Message-State: AOJu0Yzx4omX70J+TokU6RVcdGuDvuCTpHcfokkx7PpO42O3bXwFut2m
 lgFnp9DZk/xayoPR672ETK81CT2491LySk/vaEINChsalihXJ29ZyOURHuvaCaMi1fI=
X-Gm-Gg: ASbGncuVzDJUqsmmZ6uRjcSkz+PrN8/Irb9EgXDCwZkzjWImW9t45Rf7phUG2RQQ3va
 aS2w4qYEVRZ4vV0p2Q1UDL5Pi6tEwaiT4JkmAgp1Z/KiXnw/jf9aEv+ajojsZsfMDIMDC6x278W
 L+mPA+OU8ahrxrgPWcHkX5KVyd9qRnT10m7kOlB6w/YouzvresDXEhaA1hwY3OrpGNXD3XaDiy+
 RytRZxrFI6YVkHmRf66eDlVe9HKpgsFPWKe2YccuuK0tyHHcCfOvyNpNcTZD3H2+/IlGgjp4dx3
 4dDMwVfMgWzW4FL3OPnEfA7Njrai62NHXugMm+facjdQB3ffV+407EPa2l+4jpZNCPGO3GeDuju
 UGka/Cbif2rIw+DklFcrttBs=
X-Google-Smtp-Source: AGHT+IEwM5fBJiqQn7JfN+e8tTY2dg+whTcECRGNZ2OczWmbGUt7ka4+Y0EOZKYZKNOOzig4vSDvuA==
X-Received: by 2002:a05:600c:3593:b0:45d:d5cb:8dee with SMTP id
 5b1f17b1804b1-467eb326138mr136002705e9.33.1758557119121; 
 Mon, 22 Sep 2025 09:05:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f4f9f4e4sm233002945e9.13.2025.09.22.09.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 09:05:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7448D5F7C4;
 Mon, 22 Sep 2025 17:05:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/3] docs/code-provenance: clarify scope very early
In-Reply-To: <20250922154843.60233-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 22 Sep 2025 17:48:40 +0200")
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-2-pbonzini@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 17:05:17 +0100
Message-ID: <87segemq0y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> The AI policy in QEMU is not about content generators, it is about genera=
ted
> content.  Other uses are explicitly not covered.  Rename the policy and c=
larify
> its scope in the TL;DR section, as a matter of convenience to the reader.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

