Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045C606E57C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KmRUTxLn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzvt-0004ui-Ko; Thu, 05 Nov 2026 11:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOzvs-0004u5-Pb
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:03:20 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOzvq-0004kk-0d
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:03:20 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4923176309dso235573f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793894596; x=1794499396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N5DmdGU+ZWv8SGaih6vanAq6ZBwv7XcwhCv2CEvK9Mg=;
 b=KmRUTxLnL9hSNmktzSnyxoh2yF7VT+GnsUqTdj0TKGnTurLF01S4Phim3AX5S+tlx9
 p0uPOYquGSsJbpvu/3zvM0EqxWra3yMoPJDY+J4ff4j2rK3wu8NHpGR2UabGxZ1ed+4t
 47KGJV+7snIn+GEvufgSyPEIU+9hgSberBCd5kLXbYKlm7nBxFsKEErJbjOop0tEA9P9
 shNj1DpRVx/BjLoUomdTbrVR+9zODCiQwMJ3PwE69YPcg5Fzl0RdYVPCCI2Z/Zpw5RZh
 3UilUYqcW3quhgjDleubZyYnNq3u26L2ABmop0iy8BXe4K63ktXpcvuZ02nhp1wrYIRd
 aGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894596; x=1794499396;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N5DmdGU+ZWv8SGaih6vanAq6ZBwv7XcwhCv2CEvK9Mg=;
 b=iZPjQbyJesM9dS9tZkP5J9MOLnG/kcxzO42rGY021p5PfVX7KTrRA7QCsw5it1TNKM
 KCQZlyNyIOh8/ulb7nZC3yBrDFDFx7N45J07FG1XGpVGv4o/8GBd/pZM39SmtH7FgnbD
 C2PHuU3MPLYWrQGIKzLvvaaLoVQF9Tinksm7d4wyvwEv6kPAa+7SL17wPYQHA27Fagt/
 67psSJZbovnHyLAHd96r/WV1qsgBiue7x+kAigBYVJjLiCQM6T/HAlb3uHm7uSNiQNIJ
 1Qv+99oW8wiViNy0dQd1KLuEB1JCvttqY7HEU58bIzts+TTEqeguvLKNC9av+N9CuPZv
 GGCg==
X-Gm-Message-State: APuU4Z/u9M13iG5311qpI49hRM5an0yYBf97MYUn9Bod0/oX9cY/dQ7p
 AydU9LL4fLe+eUHjOQrgwco3RmPZYRZe6mUjVM0CyLZtbYODdnob0D5m0Cm9ZNA0YuE=
X-Gm-Gg: AYBFou0bMp4TBJYzdMm5dbQRUxp0nuooXVxw3AhnZ3GXKMzYmctxu4iCZbM/eZw787H
 TayqcgGwyPwjVemx/1aNWwRfCrQUAueHZuIHgOTwj0DLpB5sTzg1B0YGH9i/uvmxyerAvyxdMTn
 nJEnSvxIdM33sZcbWrC0QPYSnsCVz0zKFeDECLXL8dki/nOGkeNQawGw2m2osPsqKouNz6pPhJf
 gNGw5hBRJCazw/PBzPY8ZqxRkL4j91xQWLg8pYUhxKMvI+P9+Iaua0tkUPnQ2Njf2jIVdFp7MDK
 OFaIRtxE3/suHUqwk2Pk/RX4JsOBocz5srmDJBEmTGfV9y1fAsoUjAgl5TKeuTgr25gYGz5RGsP
 4iBv3dGOqJzVaFP+hQqcPyDiEkJOTaSn9vwU9Yu8YKRWpTnAHkG727fwrluUnGnpKx0QSbACd2p
 UADcWYtGLJXA0EpsnLLfS/QEKVDcMkx8KxMWq04sYpbaEMljrzYKUeguMl+MzCYEXgHKUJbvt6A
 9pqrY+YJezlo6YCyMKBnj74GbhEXPSRKwKXteoidjTRTEaIEde2rxh5Xgl5rYQlHx/T5mm5A6+e
 w1ps4WdpkRTp291vXYC0BgZukDgp
X-Received: by 2002:a5d:5d13:0:b0:48e:6f84:2e8e with SMTP id
 ffacd0b85a97d-49275eeefc2mr61877f8f.39.1793894595150; 
 Thu, 05 Nov 2026 08:03:15 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecac2772sm10277010f8f.18.2026.11.05.08.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:03:14 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6BD985F8AF;
 Thu, 05 Nov 2026 16:03:13 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Michael
 Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 03/17] tests/unit/qobject: Replace deprecated
 sprintf() with g_strdup_printf()
In-Reply-To: <20261105125203.40320-4-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Nov 2026 13:51:48
 +0100")
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-4-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Thu, 05 Nov 2026 16:03:13 +0000
Message-ID: <87eccz6zb2.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Replace sprintf() by safer g_strdup_printf() to avoid
> when using Apple clang 17.0.0 on macOS ARM64:
>
>   ../tests/unit/test-qobject-output-visitor.c:598:9: warning: 'sprintf' i=
s deprecated [-Wdeprecated-declarations]
>   ../tests/unit/test-qobject-input-visitor.c:600:9: warning: 'sprintf' is=
 deprecated [-Wdeprecated-declarations]
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

