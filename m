Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71E606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W0/xX2KV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQOn-0004PO-Ja; Mon, 23 Nov 2026 04:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1xVQOl-0004P9-77
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:31:43 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1xVQOj-0006pe-TI
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:31:42 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3adac5c10e3so1545502a91.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795426300; x=1796031100; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SbxmSQkGBm4U61TC45oD3nwg3ZJdvjquamkqwL71vp4=;
 b=W0/xX2KV82tEU4jBez/lScVP0Mv0GoJWGtVokbPdymy23qY0UJrikzh3Q3IQ+RG5wS
 ApPS8YWzVtG0i3Cks1bnoVMzQVBaXJMRIfUwt63dc5cu632S6t1p80iPDhiFO/aZ/dTV
 c1ae2cx1ibZO3Rkjl3YZ4rj/eG8KwZGXkc3kqkg31+GDphDiSiSHaAnSQmuhtkCc3s4V
 NXDpto9IzFr8esAes6Hgg4PaRUt/S2oY4Z5aZKNdQFGaFVx708vZieQ242cat4Y0vvlM
 qsZdt5E1tgBWffz65sv4fC51HSiamDWM2Yk4kpSuHeuxykdhufbVXdfLzmsPEHmfjjom
 mGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795426300; x=1796031100;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SbxmSQkGBm4U61TC45oD3nwg3ZJdvjquamkqwL71vp4=;
 b=GzB+49wrmDxTDi4wwyN4BiYJN+XTc8KxcQ9F6KveZGshYCc6a+WCA9tQZFke5AKiKY
 CP6bhqkh+yM6iVy4SrJKwoADtQpSrxSkjF+nGALgHzy1rjQ35rvE+B2MG8BNo8JjOJyx
 QzBO7BdP1soRqnqc8M8SQEbv4PC0EeNib6dhTKrUMfTj6vL+q0Ua6u4MqZvqIlOCh368
 WHR/fJ/h6AzHdBWD+dftpB/ejVi/qELqyRpMFi1gdh56hzEsrMo5zPUh/cFMrhraR14Z
 MR2FAmZObvzHprYPUa+tMoy873KeScpdmSnaVIVS2DVgCbEYsWqH1M+Eoq4faWTmEMrz
 5Qxw==
X-Gm-Message-State: APuU4Z/2RHb/PlJSAYmEsz0qIsmYw8yBmsaRx2WVVYp3MY16BBbrxVUu
 wLBZWo8CSEGt6r1MElCt64bAZjDdsVbrKsj0UTyY0oALA8a3JtbxnK6A
X-Gm-Gg: AZFdTZdRNA9xk2walLZRc8Jr4gp2+MtVpPYzAf/JPEoxlK2EVxBfgewqLvfCvurM7ri
 L/czP1UBbXKLmyBjiByKf5pPk1UUCSzINu80iGAy86cY1PQ+OPEWw8WxjShGHOakstuKdRRiflP
 EBzMCDVG9BxoZzfjSRtlRJzvHtDbLazltTfURLWWGavZ9MQzJvkLY8XgtsmvihFNYPqeI1HB9Aq
 Bc7zyzC7ho6nwC+aKESPpoKTe8dJfFMUuFq9dVBuLkLbAJfh2JFNdqjhsBi+croP3gWE9AKsekh
 Oy2XYiiAr35NmfLG3Oy24cULytI5iQ2gOrnRJtAaT6Ojon9jUKMSZeCRYLJyqFhC6NVw/qDENim
 0ZlwPtPQCQWiEgSwNfPh8cQK9RHN5CReKCzaDu7jrzDz0x86LkSSg67qa5uf3EkXh7P6KasE8vs
 hwLQOHsUXkvhEF9HoYe2i+57N71x3jWZ+bRajS/KKGDYYHASEaWs/Fk+1KR/PfAXx9sU4qOwB4y
 nU1C9BgYS2nxs0FmiG4daeMCGJJ42TfBfYugvi7Hk1H8sgKPRyaVGcHpUtVz8mMXVdof7B45AZy
 atcWSjuP/TOx5xg1Nf9V4HwwXnMJYoJbZ72tjEeh7wvw4bpbxDOd1jlTwnmGr/7hCIahb0UWIX1
 C+IEiMC5Zqco+Sb9A+naoUbOWgd+a/iRWqyugphSNMVAz/B1hWIcpcg+m/g==
X-Received: by 2002:a17:90b:5543:b0:3b1:6cab:f68b with SMTP id
 98e67ed59e1d1-3b41c8d49a0mr9597658a91.11.1795426300428; 
 Mon, 23 Nov 2026 01:31:40 -0800 (PST)
Received: from octofox.metropolis (c-67-164-4-253.hsd1.ca.comcast.net.
 [67.164.4.253]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde7f91c6f5sm2873595a12.27.2026.11.23.01.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:31:40 -0800 (PST)
Date: Mon, 23 Nov 2026 01:31:06 -0800
From: Max Filippov <jcmvbkbc@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] target/xtensa: Constify ISA tables
Message-ID: <awQH2kndr_kuXSPl@octofox.metropolis>
References: <20261120174757.65815-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120174757.65815-1-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.993, HK_RANDOM_FROM=1,
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
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philippe,

On Fri, Nov 20, 2026 at 06:47:54PM +0100, Philippe Mathieu-Daudé wrote:
> The generated xtensa-modules.c.inc tables are static ISA
> metadata. xtensa-isa.c only reads them; runtime writes go
> to the malloc'ed lookup tables and xtensa_isa_internal fields.
> Make them const so they are placed in .rodata instead of .data.
> Make import_core.sh emit const tables for newly imported cores.
> 
> Inspired-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/xtensa/import_core.sh                  |    2 +
>  .../xtensa/core-dc232b/xtensa-modules.c.inc   | 2034 ++++----
>  .../xtensa/core-dc233c/xtensa-modules.c.inc   | 2066 ++++----
>  target/xtensa/core-de212/xtensa-modules.c.inc | 1942 +++----
>  .../core-de233_fpu/xtensa-modules.c.inc       | 2892 +++++-----
>  .../xtensa/core-dsp3400/xtensa-modules.c.inc  | 4638 ++++++++---------
>  target/xtensa/core-fsf/xtensa-modules.c.inc   | 1422 ++---
>  target/xtensa/core-lx106/xtensa-modules.c.inc |  932 ++--
>  .../xtensa-modules.c.inc                      | 1536 +++---
>  .../core-test_kc705_be/xtensa-modules.c.inc   | 4616 ++++++++--------
>  .../core-test_mmuhifi_c3/xtensa-modules.c.inc | 3578 ++++++-------
>  11 files changed, 12830 insertions(+), 12828 deletions(-)

this doesn't build for me without additional changes that I just
posted (target/xtensa: constify internal pointers in xtensa-isa).

Together with that patch:
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
-- 
Thanks.
-- Max

