Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A067C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 10:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx1MY-0004PU-JJ; Tue, 25 Mar 2025 06:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tx1MV-0004PE-O9
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 06:18:23 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tx1MK-00040j-0K
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 06:18:17 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so8220947a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742897889; x=1743502689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyxU75tpST2T5/X4xZptX1z3SIVRXpjMPoFsplP+R74=;
 b=e9xW6s2IZ/uTKWTZ0LbaRCUqRpn+ZjqePKZi5FYlUFcpYDuHLoKi5Sv0nDsfZAnje3
 Zxf+AJBWt/tA+PuvOwcxSHg+hksHMBDQN+M9okecCypf9BpTKdGj8oCxiHtfpjE53l2u
 k+BQZaGnXdk0aQKf+TPLp+zUS0VW6DOgIPcK+/lBxVTQpINwchLRsldFwD2miA62N4ZI
 UjSKZWDigKSEymgeUrQHtiIlroDDFquJG2YVfIWZTko6uRepG2rQTed2oIxFK9nHfhhu
 QANB4B1OcQaRnKRDJyDbbVygCtCxwVfBr+pu300NpVJ7RWxOXpG5bmWF+colCarx0ECD
 csYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742897889; x=1743502689;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QyxU75tpST2T5/X4xZptX1z3SIVRXpjMPoFsplP+R74=;
 b=eb7rVP2gyMsOf/Yb7iUc52kVUO+DNxmaCDnU1hh3Aah0jtQEq8V4pliaudq3WQZPAZ
 JeFx2q0IyZ+MA31MKrZligEOEsD3w90g2RgqaKQTuvPdUC/v9Dvta/2/Y6BsHMOkgFH0
 q+/5Ay4Q8Uh+3/YMdwaWpgtlc0rScRKya5KM+/1gG5eDc4k0Rwp5YwGp9ozwSs7iyiNQ
 0azJ6gjlITZjspEVw4KiQbQSqoTHfOpDuzajDtRJByA0/0oiu2476mmJAGvh3LIAfGXf
 BcBu0srohSMibytYHc46WM3qIbQN5jqXO7Oc48UT75XoR4Xpua6cSO6gwcVeKlCABSip
 bXig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB03qiGK0YUGXFlALUE2+kTXeOpqIW8i9sdUFCJnUFOUzA+rhdaIXy1RH7S6sPzVmx2HJIlRiRfzh+@nongnu.org
X-Gm-Message-State: AOJu0YylO1FJGuGaMUIdDIBoF4JjTBYHtvykT3DRftXGTW9Zk3qg5wDJ
 AVHjxC9VojKEIRJ48OLrfa4xDl7T1VOYZpc1mbnkqJ54QoUTScsajCcl8eW2XGM=
X-Gm-Gg: ASbGncssDWDfP3wHhIzUozUucU8e5F8jvWdkk0MYXphS9KsXB57XvhXunGd1Pj3N1V9
 d6y1XzcRloSUyiLe7l8Ga+YQdDguQgTWPzhj6LP2YXP3/KoFOIxnzSg4a4DLbcBReR8eeS1sBil
 slU4XQHOpOtMKQOHmp+YB/FHHbCU/r+ROlOCltSWm29v0gRs43X5skxo/V68Msoz/6eeTKNGUV4
 qXUVFiKM9Cyq9NimpuY6rsH9Rhzv8HrjEW8a/6OkTkgZZmkYCeFQl57fzicybdwk/ieDTvztsVd
 gj2OclBP1XpCojRnIHUtSaTzIdSG3Euj6/bNkT6qtxc6h1I=
X-Google-Smtp-Source: AGHT+IHmLTviOGnUV668TC40wiUH7g8WDknnBehCPRgwsTNUEfQ2eJJMlcCx8SIftkIFCpFfPHVssA==
X-Received: by 2002:a17:907:3f94:b0:ac3:45ea:480a with SMTP id
 a640c23a62f3a-ac3f246d196mr1595532766b.46.1742897889040; 
 Tue, 25 Mar 2025 03:18:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef8e509dsm837428566b.68.2025.03.25.03.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 03:18:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6FA3E5F76B;
 Tue, 25 Mar 2025 10:18:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH] tests/functional/test_aarch64_virt_gpu: Skip if "dbus"
 display isn't available
In-Reply-To: <20250325061609.272847-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 25 Mar 2025 07:16:09 +0100")
References: <20250325061609.272847-1-thuth@redhat.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 25 Mar 2025 10:18:07 +0000
Message-ID: <87pli52z34.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> This test currently fails if the "dbus" display has not been compiled
> into the binary (which can happen when CFI has been enabled, for example).
> Check for the error message to skip the test in that case.
>
> While we're at it, also make sure that this test is covered in the
> right section in the MAINTAINERS file.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

