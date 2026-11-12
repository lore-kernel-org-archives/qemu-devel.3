Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B9606A32D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AhSgIkJf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRLMm-00027a-04; Wed, 11 Nov 2026 22:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xRLMk-00027L-Id
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 22:20:46 -0500
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xRLMi-0000Yl-81
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 22:20:46 -0500
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-36fc0a3fe93so7525307eec.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 19:20:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794453642; cv=none;
 d=google.com; s=arc-20260327;
 b=ebDXR3GQq01UrBTURSr3Ao+xWaM1t8UFSJecLdmCHxzLOJaUAufoiAEHPmMZoBrolx
 VikzVFESdNpqk+ua6X3PydOpzoYklguKMYF2TP+9pCM+ykye+tsnJkGCBOWYzwZHfkyB
 KdiySFbVaQa8b3J3tPt9lk7HpRjoLCktH+cN3M5z9taDa+5QOhp0OHMeHn/hUok361aX
 tOZcMNSRlWrqVNSO5f7Wk1kmps7pABjIXInLdXunDKdJt3isryYjXpLk4Rjn+eGg5X6D
 M9MyXNU3VP5wzjOE8lTb95EKlKWs5Mhx0maAzo2xlZOINE4WM4ZzjukY3IFS6hvbQI2x
 6Uiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nssk/+ppNloFNbyozTVgDD7I7DQbIZwIk3O6zojHXu0=;
 fh=/Pt0b92rDoVpYvnnVsLqmz9TGe5X+esC+TfYy8MznQU=;
 b=FlleBqAV67xmLZOK2A1cj+R3sm+uLB1+WEsTZ9UGQpG3fNERkwwAVYkal8AYqex+L2
 Ux6YhbMdSpmx5HFzqPKVaWNuNcFwj6bMN/LXJftg4spixHAXmKWZgfL8PRGIAvbuGkhj
 7qO83WbaYAt7RFX2FBI5+nVzMJFTPURrJ/hWe73A3ItXKhOSgGi8kRH+xqpvi5YjqSNG
 0sG84V0Gb/kR/CthbRmJanvpWRYJfjtSmmzkChBESOK3E6Qhj5BBpls8B00yIZ/VKbFZ
 nlk6NDFFfrxunw5h8CmBzVSJ0+wID+wyn9/NLPzC/aF7kqcWRX78di7e0rv/JeczbbEU
 K4xA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794453642; x=1795058442; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nssk/+ppNloFNbyozTVgDD7I7DQbIZwIk3O6zojHXu0=;
 b=AhSgIkJfT2hqrcA8d/9kU9B5XP1k01GBJLsl0i8w5rEyglUjAAsMHG5h8YS3YU5zLC
 /VT+y8h2yaUFifk2AQAITfECaY+rpnQVPYvAuHt+iTENSSxmaovGN+AfndcEkwLpJBmm
 +rrGnH1zE6Nygy+LwpHldQk5GVOumX/lADX9ChsgaEBTy/xYlxAYH9Mgk7O6zoAFTDT7
 oxPyfHGFqRVHGcP+kujemyOk72xXB+ZKBN/UFhyILkkhF6Ar0PhPXDUxgzkoFvkCB3Bq
 JEJhgMMxkQDUNtfDwjGavE8NQ4F/+FfRmGHBXkdXnRusKGJ8I+cMYo7brniqWukCMeG/
 sxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794453642; x=1795058442;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nssk/+ppNloFNbyozTVgDD7I7DQbIZwIk3O6zojHXu0=;
 b=yuZXjf+d/EdNm0NR3px3dHGSLpmmyYvFYGOm1lZkkd0ZVty6XWpJa9THjQO2/9w1vp
 d5rIbH8Q8npzFNF9wicHezQh9TbBrgvpDBbzTC1R0qvTq10dDsxOWdzLTwFQ74ZlBCni
 yUIz+aIehcNUwdkddqe6COfviq+3syC2SxxbaSNgaiGgBZqgeNJDq/wCglSvO7SvK2WN
 KarRtBxQPHC0SwXf7UJZYat+IqKLItYRjO292op4BJ97+UHptOzFLi7TsIJa1R2b2LLG
 83GsHzO2w52kEhm1mBGOuKHpBzEB+Kjo0IbO2EJZgyRT92pVo1NiiwGKmsXEU4GC7SsV
 ncoQ==
X-Gm-Message-State: APuU4Z9O6VHqQGoQJnPRrN/k6x9Q2DiaQVf5g8KahXDPcNOj29CHsYf4
 4huG8atTsTnwWENimfuVHmy4Q4Gc35VI92JPGXhDKjOt035E84EIAO0yShHcg3e5TmUAthalPV5
 nSiTofhqfdEkmu+G/1fB9jFeNIf8K/zA=
X-Gm-Gg: AYBFou37RJM/+87N8YcupkoSJtV6ba7YxTjiAojUPitWK+YiRD7qKXeW7ZLxod6njKW
 p/Ieu8L2zA+pDcerqawIsTx56Y6pSFLgLdlALlvXbZov0s01wYYxJN/fNBPOu65A8XEJI1xMLLJ
 CAqQ3il2VtGfTevRxnjqqrVfdAeSOARb48t1jvQfb3k/PDrxk1tCclh1v9DlmQl7yyN5pf1gZ55
 hu5LZLunKnC2D0Fgvf8tUEmvmzX157uWCkkTNOcnJeSJ0cTqilXnx4NtWHlf13P0GmTnVFtYEsF
 l5qTMcCUz1sq5Poofwfe7ns30/LEndq8u+X7HH7ZDl1Y3Q1gPPPjmgOT7cs+wZRJXdz2k9ce2WV
 PnW+5vLbsK/SUhX7SzgdShdSdWQe+jrNvFL9ZKOimn2YmajYfqV4G2shzMKznFNhVtjM=
X-Received: by 2002:a05:693c:69d5:b0:36c:d1fe:84ce with SMTP id
 5a478bee46e88-37686d34204mr5428954eec.33.1794453641554; Wed, 11 Nov 2026
 19:20:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109181839.1042836-1-pbonzini@redhat.com>
In-Reply-To: <20261109181839.1042836-1-pbonzini@redhat.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Thu, 12 Nov 2026 13:20:28 +1000
X-Gm-Features: AclHuK-8xVdu07i7JGd8q0X1vblsFfr-uFlTHSzACiVkIPFJVHoJikr5VL0cMYQ
Message-ID: <CAGscdFsT3dUnZ53JrnwgNog8b48_8cS5kBoOjcRAP6x7dgsquw@mail.gmail.com>
Subject: Re: [PATCH] target/i386/tcg: all scalar instructions should be LIG
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000def13306600bcbe7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000def13306600bcbe7
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

Still testing this against real hardware, writing to let you know that I'm
aware of the patch.

Thanks for your patience,
Andrey

--000000000000def13306600bcbe7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Hi Paolo,</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Still testing this against real hardware, writing to =
let you know that I&#39;m aware of the patch.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Thanks for your patience,</div><div dir=3D"auto">Andr=
ey</div></div>

--000000000000def13306600bcbe7--

