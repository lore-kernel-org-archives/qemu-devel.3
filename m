Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C03606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r2XONrw+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN05l-0006k2-2n; Fri, 30 Oct 2026 23:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN05j-0006ju-9Z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:49:15 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN05h-0004Yp-T5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:49:15 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3ab07d956f2so10745811fa.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793418552; cv=none;
 d=google.com; s=arc-20260327;
 b=LQBZ5awOqkPc8MRXldR3ZqSysKVEXlPUfOk5/EsV5PNCGSTmuJv2reZ9sN3p9I6CkY
 idt+ZwBzKmyoZaHGvIyfitW4slkWuc0jScF++LtfR6Pi0XIPMlpNNpdq7nfcptK8wXGL
 94NIwYVxaYQAzBQzkGWa93jBfKAw8qHK5pmb54OWEKO/Bz3ccxK+rlj9J43L5NFAyLRq
 0g7ImxCbIxV2NPIm+KCyXUCfKkWKZ9nb/RFBs4RrK7JSNjxyf2QJTRBDi73nPAReOkCi
 o6M1mLZSVvli4PFNYYqzEe5/sgD2pIK7LkCibE/v7+PI8OcPI2DvcgcH8Li2xqIINWKz
 byuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MZX5hbM8MLZTJK5axEQT0gXM1MXnhc36nhCJCZFTKSo=;
 fh=4SkwuoYsohTajnS9ThUOqh8nRYX1V8duGt1952VKGEc=;
 b=JgQEkv58GwCy9w6cS4ddL0GO/vkoNME5N+lp21RQZ4FlAC+plt1nsgFTY/yu5uSsKM
 /9cYaPL3rAWivEWEkPAFjcm9mLZq2QEjAuDxYohFM0MOoeLGZgcyPyh9r6QiJRB2YWtp
 53F8tORTHiI1dgl43YnoiHqu3PHtohknGjd/XVEBigaqJCvd0blluLS1UDtDuQ2mvagU
 xhQRduayIP1QmWNBmKv/lxY1YcOBBD3DgFubNlfllcl6sAmjUp5zPDPiLTRXQ1oEldBf
 R+y9g4V2eJ3+UAl0MSOBBU1aklJkMsG1m1/VCK+GU1W/Zz3RW4+zguOSzGlVOJQnUuMi
 0uBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793418552; x=1794023352; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MZX5hbM8MLZTJK5axEQT0gXM1MXnhc36nhCJCZFTKSo=;
 b=r2XONrw+J400VqK6omm9gEId2nfVvlLOwmgGdGpuKcg+yha175V8nQ6PPCFo8fg8jG
 qnk8i25HBGWqLs7GU/6t/Kxyrz11FV9gSXF5WRfXfOrrGAIrBPVsW6y8bQDTw+F0szE2
 GkkxEicvzQgGRCs/AXeCGQSIfowkiaDjc6x95sPBIJfYsmqeGAWMrbqyeq7qjpKh08Uu
 rtOGwgOx+eXPQ9qcPNUztu18fB3CSvDxILKMTawpYJHyKA70ORqRimDf2YFeEidYa3Rw
 4Lmg2y7/Rh48KQe76f7TWqWaJVYl7zuJHiSyFVsbMhBvx94wtUdBRMzoCY7R46sQUSl4
 ogow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793418552; x=1794023352;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MZX5hbM8MLZTJK5axEQT0gXM1MXnhc36nhCJCZFTKSo=;
 b=T6toYu+L4JgdvwQBIh1jyS6wjJ5SHpub8Dc8G5zUV+fotd5tucLX7YBn/6+jhnxoiJ
 GxZDZEH4vBNto9+e1WECNGqZmY8lt9lxqy9npNNX2WdjHhsCvRLYhuEhnVjoBJrll+IE
 hVqh0z27gQzreByGZS32ZtZwgQGrHTMgc0C0F3easKAjXLTuJq7KvCdoPQUyl6sFDA1V
 /aB8HVH2Kg8kCO1a2KQsMZoTb8gEj4dI2D1wcGzxJK6SvL57OvhyMjGZO9tPxx11zFvY
 0aCt5U1kYNMtRQmsacmCgp1y5GdhgZfer4lMMqTohFSxMCauf+y2g+pLXzEeZCcTUj/w
 pfsw==
X-Gm-Message-State: AFq9FYLkzVmpmgYpVgm1z3FnQIqdmqooR/MG72dxC71PNDqJDMvk0VKc
 qI7dGTcGoMracYX0aodmniFy60B2OX3XXi2dPnfgeJ7Meo0YRK85a08xskdEiA85CNm1RsZNifH
 iTEij6OPYiPbIOj9mSnnQdgCG8VjizHIrbstkzeo=
X-Gm-Gg: AYBFou3jgSOgANJB2fbYbTSVXVZD2VWWwADCHEvC5MloSWoC0m44Gkwz9nu0Gboi+D9
 7vpZgbeqi27rYFZYC32gobrTfMtXaqycK6yfYUEZ90tGsm++oeHfVHerC+wCogm8X+4YpEgsD+/
 Y9RSHHGTYoEo5UGn26ptJ/wWdxHP2Ic0HvPV+8CqNx2e1vi5inOeuf76fFfnRDIaE2OCUmQ+r7f
 4FTBugPPtrYoKfqJotr8U+jsecVXYBWWWRtHJUsmrGOB4UAHEyN3l2BBJw+eQOZb+hZ/DQS+6rK
 +hsHiqLF0sLmaF5NGNKvmGe82eW7iPjLYWClwDbtp76m7Atojk/XsCSBiOTtIdUWE+Z1RuD2Oq7
 8fC3/XPOequw9mUSQlTrGj1WHFvEv5NszwCtcqTAas/YB8Y9xEm0zDfforv7VV0WZPoJdqJez5D
 g+KMOXCmlNRAWv+xibjOuLKNefV+LnsY/wMChsb4n4j7Dh8+2TqUSd
X-Received: by 2002:a2e:bd07:0:b0:3ab:fecf:51f5 with SMTP id
 38308e7fff4ca-3acb7ac1064mr8817711fa.14.1793418551821; Fri, 30 Oct 2026
 20:49:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030185551.193092-1-richard.henderson@linaro.org>
 <20261030185551.193092-13-richard.henderson@linaro.org>
In-Reply-To: <20261030185551.193092-13-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 23:48:57 -0400
X-Gm-Features: AclHuK_Mhzw9D0fJc0UWuNAYl7PmrEJyXW8gLNKV_2ydfSXegdDQgxSpi6YgN8E
Message-ID: <CAEdQ38F24sfE8=rdtnHokqw3MT8+G78vcjQQwEMnvp9c0DR_jQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/14] tcg/aarch64: Implement INDEX_op_goto_jc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:56=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use ldp to load multiple values at once.
> Use ccmp to reduce the number of branhes.

s/branhes/branches/

