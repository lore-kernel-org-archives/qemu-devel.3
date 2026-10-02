Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5D7CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 21:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCklK-0007C0-Dm; Fri, 02 Oct 2026 17:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCklJ-0007Bs-FK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:25:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCklH-0003ry-Pa
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:25:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692KA4dc1874125
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 21:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MstPqNE0KcbCujLLe2XM655EuE+fYmmC5h/zOQfXOkI=; b=anjn6NYZyTplAdTQ
 ZWHdnTFQtwlIDpwXb/KOhgjV5MjoC0tuU71yThk3VEt2R23oCd6Z9sNQGCaaVqs1
 HpAtmDKPxo0CWhZFEf6tDhFvHSrw9A6E++97K/WjPgpLngPVvVXlBVyyLMab49j5
 XsBdFzCtp+TfneHbqKkNb/0tzbZSOHxaKkcoqFYTiernASI4ZhnFrQecf+HC8QFb
 Et+zPcA5q76l97E7uBKHIz8BAUcvsl1J6qEubBbfK7GsXRoVyVIKwiSAFsKWSpAm
 mMWUrR50p3+n3kLGowd+s6oQlaJfSb42k6VidLaPjLhPzCH0AWPoXZKWGzvOO5Xi
 ZhpZLw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3d9jgm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 21:25:45 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4cc89e86e9eso11675479b6e.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 14:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790976344; cv=none;
 d=google.com; s=arc-20260327;
 b=J7MuJr3BGM5iNYFuIInaibijFA1hNvYXiuIFR7zs4QHm9GlWHC5I/+Y9WDYSUy4oda
 ECLoVVEBSGJ4nvy9GqYhKZ124pPUKlYJhuqrJ23yx2dhIaEg4cbrA5CkIsLmQpkQMLz/
 KTi6FbXVmt+zolKGxf6Xeqaau3wcEZaBvMgIvt3VYL9/JymF/VtRhKwLFP77PboaHm8M
 i7LENI/v5/y6mw2BblHigefMC5OU1xsT5lcER0Z0reT3g5PB27cjICdKgDPLpERsifWe
 uuskEyG/O60Ie7BVF8d16C6MVBHyWAPXNzBhX0k4ruJSOESR0w064LVqftnJHLdT27Vu
 fK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MstPqNE0KcbCujLLe2XM655EuE+fYmmC5h/zOQfXOkI=;
 fh=TFjMkRNqP21Fcsv+AAyRbG5AJWNBCgqZWGulVX2uu78=;
 b=JqgOR4m96u6d2gVVc7XxZMPrQ2Zt8OTVYfU04pF5guZeI8ofWQmi39b8GV88AstxLv
 YQkbZDi27vwNGx4Na4FUuvCTorX5QXgeu5R4HqeqhHA1wIPB6TZgNXs5QIxqJBxqfgzX
 BO466751b/iP6CxJI2QHPNXr2EYcjn9RtZtBbPJ+KN13eNustj5ObgC4ctoJgkHhd/g9
 TCGern2fU4rS82UP6XEEiV83M+w3f2swM7YyL+DglXb7Y5VECGPaOgwf1MLcdE/NNLHZ
 1jYmuRjIDeQSBrhjy8Q1o+uH4rqDPn3coyx3K/ROvE0sdjnMA6vPQxJpZDakDiZnce/w
 6vFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790976344; x=1791581144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MstPqNE0KcbCujLLe2XM655EuE+fYmmC5h/zOQfXOkI=;
 b=OfRFfIQgtYQsE3lrPN/vdy6CQ7erxFxf5LFhNYBnzehHK9bojaGKs5JLp0Itl/H1KZ
 bhmXnzlmg5NQ3/8OX3Gel21bfAL6BvkXqu11lceJLWZQHET6s15M6vJ8W4tSu/CQsiV6
 t1gzWB0uO+57EH32recQAVEs5NaqBPZYGOwUS14nHABhSYhe/CsACaXwEk2OaBEqb4MF
 kijDQn8ZG9uLEEL7tmvPMEuQWnET3DknkEnBMmsB/BJO3LAi1bZ2veP5NZto5FAa6OOY
 npg5IiDxgP7Qs9Gxlv9LOUsg4XpL1NzH9S41erHugURjHzPNy8JNcV1DKB3B3hjPqnY7
 hHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790976344; x=1791581144;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MstPqNE0KcbCujLLe2XM655EuE+fYmmC5h/zOQfXOkI=;
 b=YImtgC4uYpjm/IC9MeVn6PVqpZJpdlgh5hrIw3BCeDYubdnl0Z4Mj77c/vdhKhRGBN
 /EF3g4qQIW4nAfKYK+fothCwcUFWSG7iCIOCk8ZkRoRF1BP3XYiSskJFjATR4XV6PW2w
 wd07mJg8mMMnfsUnMcraw0P5CmrvvMzuwxMP8LQs9V4xQIymv26FShdhcXaOKVtJ6nlD
 Wb6Fdv1S40MbTIvcLA8B20Qf5kPZYYL6Jle6Q3lVvpl601eR3mCCbrghgZBgWL9kwzEr
 foh1hizFXaK4N6QeXRrEv5CSGo4Fi02U0YqZX+6q3yP3pNkfJmpsr4+0Ve5idjdPaKsT
 FFYg==
X-Gm-Message-State: AFuF++m/3Tk9B+DsZe+NgAs8INndT9unrrAp2wyQ2s8dct5JZL9Sfb1Z
 CFCglS3aDgWugCWJayCgKQfBCrtg+fk//EDCsJi5WRsyU3iY2wgSG97HZzwgzD7JEeyXKFfiQ+R
 4+xHSLrQ1basUm4Y2tthc4Y9OT8pDIr78SFNhdu4RMcS6PI1JfnaTxBYAlzM2JNHnZeu1lM/FKI
 Xr7TeWocQVsmTmChhDn/fEfgo/iVeHprN2
X-Gm-Gg: AYBFou2LjjgCNFC1iXUC8bz3Aa5cxgvmywrDblyEcO023mjg22G99rx8saGZhGvaOuk
 nP8ipuylPrdCjsVXvvX0zi0rmryqxdh4oJNx8eI8UlnrekjqUXH89sMo1aaqVQVbn2bZLmgBStx
 A/bjOEUSvovdFJ5s2oY/jLNouJCSiqiayTNRz8T9ZFBLmA0gmTzV/DbMKxwjFigcrywvTTeofvk
 g7FTm68Kn/uHT6Phg==
X-Received: by 2002:a05:6808:c40f:b0:4b9:e5fa:8905 with SMTP id
 5614622812f47-4f67a50f3fcmr675445b6e.24.1790976344349; 
 Fri, 02 Oct 2026 14:25:44 -0700 (PDT)
X-Received: by 2002:a05:6808:c40f:b0:4b9:e5fa:8905 with SMTP id
 5614622812f47-4f67a50f3fcmr675430b6e.24.1790976343891; Fri, 02 Oct 2026
 14:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 16:25:32 -0500
X-Gm-Features: AclHuK8015C3IIShjCZ9eGwIk17vOVpmydCvQzsu0jWeyrjuYSS5f10pwV9ss-s
Message-ID: <CAJ+KCYMQ-Hbfq04OF32kvjZV1WZUd4fzThyTGOdOxdYSrhTL7w@mail.gmail.com>
Subject: Re: [PATCH 0/5] Hexagon: ll/sc fixes, emit TCG barriers, TLB locks
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7GagiKA_xUnvT3qiZ9chLPzsJ5rsgvG6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA4NSBTYWx0ZWRfX7Hf1ix1cdVj9
 Kse+M8l7WkjmB8BNCO1BQICnquWJt8DIzRgKWZzLFOvXKcfAklreO89xTpw6hIhLwj1I3jQMu4w
 mftZOFfxhEvPAxiGNRW0sDBNcUiWag8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA4NSBTYWx0ZWRfXwT5D+N09L7Ye
 rKlGawUZLdmgF7YmbaCoEFTvR0yXPw/bT0HS2YcI5Ose1Ex9VkOfFlQkfKok4+f1deyx248p3Ea
 O9/ZQ8KJsrQ7+p8lFo7W0aSeKWYkd82Klk1aKXu7IGSWR70Rd+mXVZXPwMXxRA3udNjCtiY2luy
 DwphfZO9WugyFXYvToRBD6vp1VmYAFofZJJHRsYNejp+0h4Lb1QMjsBWfKrniPyALbUJcZkbMc/
 PO/STYbnt/qO2nJ88LTyHz4Oua8jSdJv4/6hw4on29vEjwZ2U7AKWtQEmOqDeoEv6pBs4Q/zc59
 oVAnrnecY4FdOsvxukRvvq0g3eu47NaWTdmV30i5bFlVJNdzDwYcbRrdEsKI3KITsSXt7PIxyUm
 ghlzk7wO8yflOrruMS8pOnPUH4IudDWcm79Io6PI4nYldp4EmuWeFceL93ht9mgTcdO2hplrySX
 a00LzIDT8FkEeOFRmdw==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6ac02159 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=eJl8aHegDT1Tqy_SZ3MA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: 7GagiKA_xUnvT3qiZ9chLPzsJ5rsgvG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_06,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Sep 26, 2026 at 9:43=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> While preparing to enable MTTCG, audits and testing revealed gaps and
> bugs in our implementation.
>
> LL/SC reservations should have been cleared at traps/exceptions.
>
> TLB accesses should hold a lock to make the operations atomic.
>
> Hexagon instructions with barrier or acquire/release semantics should emi=
t
> corresponding TCG semantics.
>
> Brian Cain (5):
>   target/hexagon: emit explicit TCG memory barriers
>   target/hexagon: clear LL/SC reservations at context boundaries
>   hw/hexagon: protect the shared architectural TLB
>   target/hexagon: publish TLB updates before flushing
>   tests/tcg/hexagon: cover LL/SC reservation clearing
>
>  include/hw/hexagon/hexagon_tlb.h |  5 +++-
>  hw/hexagon/hexagon_tlb.c         | 27 ++++++++++++++++++++-
>  linux-user/hexagon/cpu_loop.c    |  4 ++++
>  target/hexagon/cpu.c             |  3 +++
>  target/hexagon/hex_mmu.c         |  6 ++---
>  target/hexagon/translate.c       | 15 ++++++++++++
>  tests/tcg/hexagon/atomics.c      | 40 ++++++++++++++++++++++++++++++++
>  7 files changed, 94 insertions(+), 6 deletions(-)
>
> --
> 2.34.1

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

