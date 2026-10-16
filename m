Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77854CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 19:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHnVb-00073g-Ct; Fri, 16 Oct 2026 15:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHnVQ-00072L-QR
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 15:22:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHnVP-0000tT-5G
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 15:22:16 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE60Rg2914882
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 19:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0//QCI3KeMvQxCulyj+iOfXXsv32oQn3jdZoGpTwYQA=; b=S0PSYFV5jsPokrBG
 uR/VWrKPahtlFELzwwZVHGqRu+VIAh1Fyrj83ycPouQEncI9vJ6KKgFC73wGap+b
 BasOBvCCRlk6KSgAANBpLi/wRPPtmVqgS8EYziYKZlpJrqDxjO6PDOkqsBu79ZDJ
 TQfuE0qFKYZJwuThzlQ11KZfZLDTcOR9pcCOkEi5PV9s+2ZGkl/C9m9oNwYgCJ/b
 TISrC8plGMutK1VkQK6Gq1iQi/ccC5rMpCVTPJPo8lBR5o9C8fWVP08Er7diX6V1
 lDgc6ef0sOmM9enu/4REDcYrSCIkIn/th+qVj+KZqJfKIb6XCO425FS8PE7HASnr
 u4qUhg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbmmq1d16-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 19:22:13 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-5384e381fbbso344595b6e.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 12:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792178532; cv=none;
 d=google.com; s=arc-20260327;
 b=OwcQQqViR6+Bj4XBsul97R6HuTx+9aKt/zT0TdSvAVRHlK+S45sZ/u7KuWZfc64LYC
 3r/Y63OkQi/y4OP+ylkrdpiKQtLtXVjzoHGC3I3Wr6XvRPn8mDh/LkyofW/KH4965hor
 gwYopI9TZYv6QJ9oYGSBvoNaxl99id0YWyThREvy0OHt83KGcrgrxDIqHtCp1we3Snrp
 FeXSYdnT7Qs1HCTEIG3+KAnCWr9F/k1SkQu+Ny+a3Dl9FBgrKbLqGWPBO4twyDnmqxA1
 mpCx6ju2L+oR27Py/jcx26B74YfIszhqyOjJIvPc+XSU5lEpnu27EAf2jn+s1ZJYv6UX
 LS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0//QCI3KeMvQxCulyj+iOfXXsv32oQn3jdZoGpTwYQA=;
 fh=BDwCUQnyOohCW2T3saAEoDn+gM7VDetp6cmJKplLvtM=;
 b=nGT7uIKDRnbqh5tIrLXlKWspEvmHL4dBGoxlWczuMhGr+pvCdIVv+8QKACO2hIr3F9
 disx+ME5vyaTG0imiJ4w+37ZYXx/x7BBHXhhb+jmh93PzRAL5iYXcdiAefKses/bcBkd
 nmZQPZZ6alnERF/OJoQ6DZAAGoncxOfuRkNgl5uDd65OkAWsZ5aOF60T1nK2ouLor/xt
 exE/kOCAX1j2kbjQzlN3N8ApH2Pueb16ZZcbpQwUHxq37BMqWiV1mp2H3T/nIlgvLFok
 ucBIH8jrcpzaLBcDm0fpprY6c5jvju9Jqno73VrF3MDS/KHKrotEratzHBh/Ilk376RE
 t3xA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792178532; x=1792783332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0//QCI3KeMvQxCulyj+iOfXXsv32oQn3jdZoGpTwYQA=;
 b=D3y6kUMYsXZ6C2PtA84HCuo4qfvXl/fsD61X/65QxM+LRrA1q163/G01nvzx/oKiFt
 AcUMThvsaUWDRuTVGMXOnMTIKq7L29fmf9Wb8cOQLix94FLcXQXkNl8IOEgS4z40OEps
 hSobCrwlq3PFViZSE6qpVd8u0Nw419iA6NNnDGZoLs24ZQGKx4C/wNx3KKgb+Nb1odb3
 Yjyn3Qf9PM82lgGgWd/ifGyXNj2fkRQRgjdnd1r7ztOEnKftOgk3DEJfoO0Pw1VohpL7
 OCWIQWur9zNySiOa27Z17InpnxBvCbYSaA9Xux0a2ZV+GuW/9fmOif1bPBTsWethmazQ
 PDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792178532; x=1792783332;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0//QCI3KeMvQxCulyj+iOfXXsv32oQn3jdZoGpTwYQA=;
 b=lOUsitQy6agvOsSiYPoJUsMAKF3qtIvWX3CBFvg+mLcs3jhKb8V/QpzxCLs9WyC1UI
 rEUsjoPyVy3X8NE4FiQV6rT+3YMWJ7ORchO46ebxp3H9YP7OQVR0kdbhCM0VdNSzrfKi
 SWniQZdHkAy04ksDikH8BNXA6rrXNI85gMn2N6OR2uHkvry4phu7TMCxE8Vo4mtLtNie
 4edeoWGO7mHpeVzFIIQfdLfsDH3tMqIsVNlm/9G1czlgx6z+Aq+UX1/r0iiHT++lISKM
 k8RPvunEJuME3OoKkXxIzZ473Ivjv6vESaLkf7jpByPAVnVpUpJCgJGchbIJ40vTm2RK
 kI7w==
X-Gm-Message-State: AFq9FYJa0Ax0hTEDOUNTClAyvPmOLeSDqDMaNaMo0XR/Iw/D6wnbcExP
 fltxYX5F2mzHJyrJOGcwTO5BfZf2aMdbGfEi3fygxL7rVVSAl8mamnIzJsxZ23TH5TMfMHuscB2
 B6D8ONvJqODPbZCEw01/Zr1icqrDQbBLv8/kO+PU+fCNvIMH4Mdsq1f2llpj9bi3ST5Z/DJAJ4T
 6vnYZfqM9BTyzvph3U+iAAaazTXFFrPJGC
X-Gm-Gg: AYBFou2NKi/Z60bZBhtAdWlUoXR8aMgLOdR87ratBYTSnLF7x2iUAVY+EEKuKoT1TCm
 v232F8nYrbw1PyY+t19/031NYwAGDy38wdNdoDBaVjSj9Lqd9ZfL3fe9cOXMQi/LxhgqLdB0aU3
 vuDbP2Dw5RoGvEIDLqD8VCym5qmSOUjS76kLyhjZMrkxOpvpGIJSn559iOftbQyHs9h0Ezq+hw+
 nDIUmi0r7iGZMBsiXY=
X-Received: by 2002:a05:6808:c410:b0:4d6:9273:251d with SMTP id
 5614622812f47-53cd209451bmr572549b6e.57.1792178532425; 
 Fri, 16 Oct 2026 12:22:12 -0700 (PDT)
X-Received: by 2002:a05:6808:c410:b0:4d6:9273:251d with SMTP id
 5614622812f47-53cd209451bmr572533b6e.57.1792178531973; Fri, 16 Oct 2026
 12:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014195223.3233623-10-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 14:22:00 -0500
X-Gm-Features: AclHuK_imszQAgCVz-Hr3LO2RUZWutJ7yHkRFHkCRU0oyuUw9j6aiHpjIVX3DQ4
Message-ID: <CAJ+KCYMJQmOqDJV7vDH3R_m+zaotgGZQXaMprQg=DKtC3ZuzQA@mail.gmail.com>
Subject: Re: [PATCH 09/12] target/hexagon: preserve callr target when Rs is LR
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3NiBTYWx0ZWRfX1qjuOSnf/SXd
 oI/vPdpGQRmzpdEj6ErOA9j6nscIZZKJLSk9t+vF8bI3FEdefjX/0MbkQvROW+l55x/TqoZp00v
 lh+NIAty9qev25KgyUFMTFYRbGGA6JI=
X-Authority-Analysis: v=2.4 cv=P9uvFSAu c=1 sm=1 tr=0 ts=6ad27965 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=tbzj8W-zVJ8aeGWG0hkA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3NiBTYWx0ZWRfX7WIylxIXCB33
 MQQWzS+ISXuvP6LJD+aS3n4sShYwi9NsSRCAmccPqTWVGq+c5zyG/plDkP/WVKdco0YHSOt611M
 UYBjiIowCnsWegKCgRrVHkz+xuJQjAvXBwJl1w4N2PKD42xJPYx7/Jhl8QRYVcGsIWWiJBdThLM
 tZIW+HseU+p+8J4lfG9PMzS5KBRKEV69g9siXL/WymFZhpaPYdIre5/eQYDhVnsBDdQrTWQHAh5
 kXS6HaW2Wtad4m0QeoAFffWiz8LufHzPv92utdgBg3aac933ACa83ZK3Gc2QBAjGoGQG0NqYGtG
 LgCKj8gPRDUJjA/6h+/ZIy94+0jfJitYLJy7n651dnDB6gsGHFn4pCDYjoxuz0xo6c7XBvrjqqs
 Mnv5tVZCt5WGEIgTGPZPjJpmlUlIEH35AK+/8JvR5Ye+H9eKpE/hUebdw4UYI3FKCI0M15jvyy1
 UJqWJLOfOSoKG1AeXQg==
X-Proofpoint-GUID: qgCL7IiBhqT0Z0oKfekR9_IJFSGBY_KD
X-Proofpoint-ORIG-GUID: qgCL7IiBhqT0Z0oKfekR9_IJFSGBY_KD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160076
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
> gen_callr wrote the link register before consuming the target, so
> "callr r31" jumped to the new return address instead of the old LR
> value.  Copy the target to a temporary first.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/genptr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index f264bb9d0a0..7ef60244de0 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -1028,9 +1028,13 @@ static void gen_call(DisasContext *ctx, int pc_off=
)
>
>  static void gen_callr(DisasContext *ctx, TCGv new_pc)
>  {
> +    TCGv target =3D tcg_temp_new();
>      TCGv lr =3D get_result_gpr(ctx, HEX_REG_LR);
> +
> +    /* Preserve the target when callr uses LR as its source register. */
> +    tcg_gen_mov_tl(target, new_pc);
>      tcg_gen_movi_tl(lr, ctx->next_PC);
> -    gen_write_new_pc_addr(ctx, new_pc, TCG_COND_ALWAYS, NULL);
> +    gen_write_new_pc_addr(ctx, target, TCG_COND_ALWAYS, NULL);
>  }

This could make use of `gen_unalias_gpr_src`.

