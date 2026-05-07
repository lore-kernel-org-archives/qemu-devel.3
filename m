Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF24CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1qM-0003M7-1q; Thu, 07 May 2026 12:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wL1qJ-0003Ka-VX
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:44:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wL1qH-0000UU-Om
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:44:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so747971f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778172291; x=1778777091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuiGuKD6lwcnZRJZhLkYNJ8PANSTQizjBrUnUtpF7LY=;
 b=DJdizwoopDqkKWVoqGFAXI1IIZDAhzZbdT4kLNd4gLriwkxzZIrCiqZUqawsKD7YBI
 cFpmh4A8pfX5ZtpNG8DI60OYn2s0VPy2X+5Y2RN/j0tkMeIEDPbfvzluWyistWm8YFJH
 gkVRwPpkRjTzlaq/OlxN50hARukZ0nb9r1cviqwsVSsosB/Rtq+o97Xzw4iCvHqJFnCV
 /4KEuXyLZp8uLbmxhgK2gytmZl8PdC1yx6j5qzjGlkhJdDSBdc5LUM/eHboHoSTvEEbl
 yISGrc42VCNn65YJCb16uOjYoIgGgtduYdQF3VPbP+BDZWXASRoNU88hFipLmANW+HaD
 AqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778172291; x=1778777091;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CuiGuKD6lwcnZRJZhLkYNJ8PANSTQizjBrUnUtpF7LY=;
 b=KfOs+4et6vUih5S2E90v5a0uotaRn83OUxA1x9oXfbZzZa32D/O+i0CtrXaTXb5ZlT
 X1GOjS/beQmL/q5RA/uYBHi2Qys2imzWjCEzaMXyFP34FqLHwB0RgYNJxQBFdawzMGJJ
 iSB2Cw4PVa9/j/g12cBHZ6GA7pTIpAAkHFa0TruVGs7nzlINprj/sGLyQNF0JwJZkR7o
 IY2vN5mtO3VEmAJnvMrTjgSEjnDVrsAwL2xxDDN8cuVoGoGAS/JaBIwOklElAGSI7+an
 5mF4S5aFk4sYMTcNkq5IAt7gwKpXXvYk0lU7qmTc4RRkfcGQVSUE4hoTjUccwEOiDdCU
 1V+A==
X-Gm-Message-State: AOJu0Yy04vNUC857FXpnlaCNkPjavf4ryFmTQw4hUXm1US22KcoziJKF
 p6BZS5Lt/SqaFo382yLo2N6X3ct9GLIF6yFM0ud4+GQWE594PYkdV9nQqYoNaEpyyiA=
X-Gm-Gg: AeBDievtbLHh3aoSGoskqsRSepcXcvsf5vWjYyJGj8s+Ucc7kfVbZUVRRN3jTo1hZQl
 c1caZImTwNDenb5akPBbHXSTGNtxlM/N8ZfINYAEyj+KS1dt4zPNwDBkJ9h4Dn2zuA4Nho6qHZL
 oud4ic3OPxrOB+3bfWSphYp6d7A24Tnlre4NuU5o6X+6SmmRymYga3yD6XqBhskeDTbz7n5baKT
 pEyIQymm7TA6YObLoKny1EBqUe4Dd/FXfATYT0dc6AEwN/QW7yPwNpg9C2OaAxMuAMpy28UQLrY
 zD8pWPOjncGksdC+90rBcqo7jPcHPq27/DBGUFh/ZzfKO5z4gZakuNttbntD8xF9ucYSOKbpdsx
 CKneh0suezI0iXmXd0w/qzCkDOs3OfByU4FRGq2GUPtlx74YPzk0bYE8pA4X16RBYj9DIc82Sbo
 3MmEay6sch8OPkCsEFb6olSAE=
X-Received: by 2002:a05:6000:26c9:b0:44b:cb31:b767 with SMTP id
 ffacd0b85a97d-4515d2e6d77mr14460626f8f.36.1778172291300; 
 Thu, 07 May 2026 09:44:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454177df883sm183623f8f.34.2026.05.07.09.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:44:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 557195F83E;
 Thu, 07 May 2026 17:44:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,  qemu-s390x@nongnu.org,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?=
 <philmd@linaro.org>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Peter Xu <peterx@redhat.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Nicholas Piggin <npiggin@gmail.com>,  Chinmay
 Rath <rathc@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,  Daniel
 Henrique Barboza <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu.zevorn@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  David Hildenbrand
 <david@kernel.org>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,  Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 01/25] hw/i386/vapic: Cope with non-page-aligned
 return from cpu_get_phys_page_debug()
In-Reply-To: <20260430093810.2762539-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 30 Apr 2026 10:37:46 +0100")
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 07 May 2026 17:44:49 +0100
Message-ID: <87a4ubkw3i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> Currently the i386 implementation of get_phys_page_debug() always
> returns an address aligned to a page boundary, and the vapic.c code
> assumes this: it adds back in the page offset after the call.  Change
> this to OR in the page offset, so that it works whether
> cpu_get_phys_page_debug() returns the page address or the exact
> physical address. This will mean the code continues to work when
> we change the semantics to standardize on "return exact
> physical address".
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

