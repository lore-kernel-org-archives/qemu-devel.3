Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7433ACCF2C0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmBK-0003QZ-Su; Fri, 16 Oct 2026 13:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHmBJ-0003QJ-5L
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:57:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHmBH-0006Lq-5L
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:57:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5xFq2914869
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gvK8qOs8Vpk8s++Tqqi7TcLosGD9yCMytMFofB63/6I=; b=ketWgwxikjdT/yMr
 rCwPDFooPR9YU1fN8ESVRKGq1wlI1avxwuycV5QjfPuaW6Y3FazCpMNZm1h0tbye
 PE5pLtFLEYcldUTmjPHm7p7c8IitrdtdMEgTgEe4vfnL/p9JXL9bQttRyxEj0yrZ
 EWhCFtfBxO5pCysD6LdOR9Rm/7JTu2k/L9mVNvh612CdZL12j6wRDde8fgatTN38
 5jIQbDoXrB0TKtsED9MkBjsg9NsnRdLm69CkB05sG/dR01vBknmyanFFCbbcqejF
 qdxnAdq6lNmsqUVA+aB7Gf9e2V+SnR3KgW4Gt9cViwDgy0dHBASy8iF+uZmOLXW8
 MLkbyw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbmmq138j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:57:20 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b28dbf4197so349872b6e.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 10:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792173440; cv=none;
 d=google.com; s=arc-20260327;
 b=IpE0KalqY5YguS/0isttDXuuNvB52ZFoyUz0j+bflVHMcT9jSLQMXTZpKhbvu0D9Vk
 Hje+4KrU4hK/wj07zXKiry0hHk0WGte9WGFwd+6qNYT/XUwpUi3l1IliwOk1YVPApAg4
 5yyxvlgSCiMmT1U9jALoCWR7DIQojV4YTI5UE7ejbWq+PdPxOV7ZV39P1dgByflbnTxs
 eAXkL19Jba+FXNa0JcxlojsR2jCUAA7twUioxhFmnyJ/v2ADcU3Jdd5bWMkxkAr4HIOb
 Yc5h6UhcGqNgUK/leBEY6SdOXFhjBKTDYbyJ4o/6IeK4mqvmu9hTaMS83NJlzhx/Uszz
 ibCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gvK8qOs8Vpk8s++Tqqi7TcLosGD9yCMytMFofB63/6I=;
 fh=BDwCUQnyOohCW2T3saAEoDn+gM7VDetp6cmJKplLvtM=;
 b=RqS5wNxgo8XRBwdZnbDC27ibDPCkbOpR43nE6r9MHLToNLOFbNgCp77+lXyp9pgGbk
 5xb0Q2G4KjXCWLtYrrbgB5O+oWKmivzHuzcb5+xuAKuuFSWm4JK49fXyqyFo9rLYsycw
 tetSwWKnsGwmgePdC62HPebQRc6KipUNZsVwJ6bPtjQToZGtnGbSOf9kP4IiWuNkucUg
 uRJnR1RuDpWUMxU99oNPpWgsp0UbmVsOyQJL2HG5gU8vYxwOMN8dcg2pxuzZ9aRLRiwW
 itMUQb7ROd0d1bie383YCk7IcK0sx5hdjpYiap4G1bddusRcirIlljpk+I/gsHJad/B8
 WfRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792173440; x=1792778240; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gvK8qOs8Vpk8s++Tqqi7TcLosGD9yCMytMFofB63/6I=;
 b=C2KVC/2ueTxvEeN8Q19Gd/T3DNzqlgv7n4iAa95/lvMT1Fx4xjDSPjaVLha8L8ZB8j
 BzomEeiqVDwwwToPsBpCbMBUACtUoUl/MMFqZeil0ea3miaejqsWKO7K6xVW7ZmYraV6
 ytlfafMuUNWL7sePUVupXS3/GpUiTkqfP5rHGgUJwOYtNSeRHqI5n5Vy4gimO7o2PGBi
 bMgVGDJN7qBd8P8KSowqpB31pMSzKxKmnGxeOh67RLurSAYOmeGQO7Au7/iuosSSBfjX
 NZyWxTd5GFBIKbiAhi+7SxU2BJuHxZaviUHIj+vyLYDk6rSKLcD4jTXLYemmWoBUpma2
 gL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792173440; x=1792778240;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gvK8qOs8Vpk8s++Tqqi7TcLosGD9yCMytMFofB63/6I=;
 b=U/Hgx+GXisljbvUwzxl31K7D9wT2EpcqOqKW9aEhPPH2Xd9maX/qXFQGSc+QHM2sOv
 6qwiJeXGdQIHhvQnDpjWtSVnpE84gvz3wIOYAEKMQQ/Ryj0xgChBU5QA/TeGoHkB4oDM
 9nesihRtTtk79qiZANFL7T1tC0D0DagOUY+lXsgHahVOocD2vyv+QqK5Ke6QnUAP0npa
 ixCzkUzN0DZGrCMxndfFgUZHzJ2ceDqdagYRPWmDh4kRPirRL7mEhIWAJtjbwBnWsw+S
 WP23ROOv2/j/sIrWFHbeThHPjidfacL7bFm0cywoKy3alRYIBqRqgqDbE4GwRe4admGR
 /y5g==
X-Gm-Message-State: AFq9FYKnjMSS8G+CdYUSkv7GXTcXp/mVMen1nU4iZ086m3mDP6aMGhUv
 jczxGjGinZ734UdeqpDGrFdGQwqZN9wftdeGpX8CveiPATYg/XKlFQkvx+ICqtke2ED28fSeaDl
 zWBtTU8RoEBdUtvElc7ASkpzytZ3p3D0UL1vx7tHwJGeSk2WVuJmr68FHcE1XhIQkOEKT109vFd
 WDYXSuGTZJFiWNb0ka6cIiY+haQdDEJVx0
X-Gm-Gg: AYBFou2/fd/T9UU3aKhxfd7ImgyLnWek8+5r21XqD5SIbMTwVMGaKi428o92QrGYCQO
 CB1Rwv9EwbBC+7w5Hvmxn9zwiw3E0yOpUkLJH9h4rSRVnoxFiY86zkWWpe0KRHHrN4HnEY078y2
 MGPy+9PKtKhRNRJFJMaQgTaUiCseqsz2UE//S3RgCnl5cOXau0TcYUUOF+ubiVByzT0HaZ6/Y/A
 n9tdxyqxhHnTEkGDIc=
X-Received: by 2002:a05:6808:138a:b0:4f4:b62c:a3d8 with SMTP id
 5614622812f47-53ccd5e0191mr455279b6e.33.1792173439854; 
 Fri, 16 Oct 2026 10:57:19 -0700 (PDT)
X-Received: by 2002:a05:6808:138a:b0:4f4:b62c:a3d8 with SMTP id
 5614622812f47-53ccd5e0191mr455248b6e.33.1792173439305; Fri, 16 Oct 2026
 10:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014195223.3233623-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 12:57:08 -0500
X-Gm-Features: AclHuK8OqpgNHg34o3hvET9jCoO-iMHyzcQyQf1fz8cEFoajMp_MoqWu9vFpoWE
Message-ID: <CAJ+KCYOkHyX9u7-zO+2bQCy2ARt87gAAiiLR1z_iai5-Gn+HuQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] target/hexagon: add v83 trap2 and vector stack
 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX07puy+anEQUI
 9Al1KFFMSvKGtpvKY/yUVRwYm7Q0NWFT89Z8PdIczMlV+pHavyEL91G7dnOXwkTyqrvRDxMqnxJ
 5qS5m4hbkmizUcTUdnMmjyzeG/soixM=
X-Authority-Analysis: v=2.4 cv=P9uvFSAu c=1 sm=1 tr=0 ts=6ad26580 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=Eqeiv1PQOeqZLkc9XpUA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX0uTiVKusDWyl
 HG4BGvwzzxdsO9W+JwcZ6jG+vYgtgdcX0FNAU3ulFQwUZb7jptm5kJuTJNxn+6JY6XKWG4NWqwr
 vmYShIrKH6QuBxDuZqRGVuy6MYEJEd5k5iRY2HcHXN5usLwVs3/mNs0ciRg7wnfNV6NeZWGhCC7
 zM0ZU/Rqdn/dueuMRh93DQSPCdrzWbZa0CjMo3IPl8nMqYdhEhwXfTSInI7ohdvIVyesUHP9dPi
 rJVxtgHnHlX9N9XQPfuoqsPg9b/5v7oq9J31QcH7vOzKeJHG7V7sCjhrLwmlNOlAuAWwCbQb6tb
 ZmyyKksyo0pxcAldSf6Y7yVXRIbJJ3gX9HX8Rv1Yt9gbjz4Dat0I48rXjboNLCGHylJEGqQ9QUr
 PvNEeYJc/8tViglOQjeGbPsYrfLYJYLclp1sr1tzqtyV/cej7LVDLXesdWt8+Ls29NU5t4U+IOJ
 oDQGlycoxFwA9iplpWg==
X-Proofpoint-GUID: fvqH_pHgF3z4muKrPaeN1h-BkoAnL0SW
X-Proofpoint-ORIG-GUID: fvqH_pHgF3z4muKrPaeN1h-BkoAnL0SW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Wed, Oct 14, 2026 at 2:52=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add decode and translation for trap2 and the vallocframe and
> vdeallocframe instruction forms introduced with v83.  Model vector stack
> overflow as a precise exception and report it to linux-user as SIGSEGV.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h               |  1 +
>  target/hexagon/gen_tcg.h                | 51 +++++++++++++++++++++++++
>  target/hexagon/hex_regs.h               |  2 +
>  target/hexagon/translate.h              |  1 +
>  linux-user/hexagon/cpu_loop.c           |  4 ++
>  target/hexagon/cpu.c                    |  2 +-
>  target/hexagon/hexswi.c                 |  5 +++
>  target/hexagon/translate.c              |  2 +-
>  target/hexagon/tag_rev_info.c.inc       | 10 +++++
>  target/hexagon/gen_idef_parser_funcs.py |  2 +-
>  target/hexagon/gen_tcg_funcs.py         |  4 +-
>  target/hexagon/imported/encode_pp.def   |  5 +++
>  target/hexagon/imported/system.idef     |  8 ++++
>  13 files changed, 93 insertions(+), 4 deletions(-)
>

I think patch 6 and 7 should be squashed, because 7 reverts some
changes introduced in 6. Or maybe split into one that deals with
trap2 and one that deals with vector frame instructions.

