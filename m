Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA3606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OEfm/7M8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OddqSBPX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvTb-00072K-2o; Tue, 24 Nov 2026 13:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVvTX-00071p-Ri
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:42:44 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVvTW-0003NL-Ag
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:42:43 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXJpa119520
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cxpoWgHQqt2hbfkPA+aU8hUPX3t2PqgAkidOp3MiNIo=; b=OEfm/7M8WI41wtXy
 MCqZG9xQu8/MYjqMLP4bS5NqManxWlu9mHBdiFZk3P45i3kHNnm2W0J6vgwKxmhB
 RPydZqGltTBhL6W4IsYv8pn53XNN0Bhon5Nx/BpYxI0wAO0y9i2ZxII9XjBN3n2n
 L1+VkNjcyoFu8dmoEIEXvE6p1BXF9Ua4lNfw0xRD3LRH9fVaahui1L1BZr5AqMAt
 xX/O5cZsAvlZkv1FHXuojec/rQHyvEH1rJttzFTrLDoc/NTffcqheayOTgOa0U3R
 pM3aIV0FTFvGQrYQUQOGnTbtYwqEPPXhb8pSe7yW+ufg7UViaM+D+g6Kg3pQax+B
 idYBog==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5effrjst-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:42:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495a1f5e47so775896285a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795545760; x=1796150560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cxpoWgHQqt2hbfkPA+aU8hUPX3t2PqgAkidOp3MiNIo=;
 b=OddqSBPXJAH1YNXoWxWOvDtVd7pQY2ypt19waz/3mYUYp+bt2qrUCvxyvz/u0us0MZ
 4U2pmAGdTVpVVKd1CBAJr+AjkbvErU+Ut1wYkuO9L9bjYNVAiOvu5oaeJwfnNMRavhVz
 c57J8+HAt1iNCqm/XGFE+JkicI3d8k0i3dF9G3hO3eRNyyGPhKFfhFVT5z6lGftvva5Z
 CI5BwrMX1vqDHfLGEwrAnD2CXBOYIUI14NDSviaGNqwAgmN+Z/a/a7tZQ8ZxHAQjVtSc
 OIiqVz5i17maLISBpJqwfrYB9mvbNFwSjSzLcvDoZ0vetLjLtn42QQFrRIetAAZ97bWl
 zZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545760; x=1796150560;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cxpoWgHQqt2hbfkPA+aU8hUPX3t2PqgAkidOp3MiNIo=;
 b=tDAMkrt8ZlSPyts5XtWKU98zlckoWwBmWWP/JfuTuF8Tg/tdp/rC7da83TIhemPQAu
 zV0ByS7FpTUyrpkxhG/rV3SxL58gnE6c6kL7YbrGTPVWGSkXRHNEhmLiTTgR2SQXXm4n
 m6VHMds9y3lVbfs4QtYgskCypIcKSY17n4crR8akuLyctfXA2peQKk0gfs/aLeOvlVEA
 DpiUd700JVwX0300qmakkzIxuyXNdmWuBcLZ1ytJl1l/qQGbsTdxHFqVljRVf1TpNyRK
 WV90LCrlwzMigSGzgy/ZjCkulSe00coRxEgVGxbbklnvOWH1TJpw+VHJSXSQZ9qHlKLQ
 SVJg==
X-Forwarded-Encrypted: i=1;
 AL+hErEsY/RsmxSniPe2MC/Yzp5maV3Slja0MSIde+po5g/HBxEvg0FT1r9cYmtf1DfG0zCZDTcxlhcZM2pK@nongnu.org
X-Gm-Message-State: APuU4Z9ncxFy9bGjUCXbWCGXewchV9qXPzeFVn282KOeObGDpn0z1B7C
 rOIFm1E+pp5Nn4eVATeW1pYbsQA/QfT705b/UuhvR4ajESe4NyMEY90BN29HaH94CFpFvx10o5X
 XKQuQ+Hck04wq1zE3nGdb7E9UilOmlkDH/j5Rxhn33b2ne4TQeHnwLvt6eQ==
X-Gm-Gg: AZFdTZed2TiFIjiJyYIVmghGc5h25ajzX9ihW6WXzzdIamxnBjxv65gBqRYBzy2Zg4D
 oZSiuHJ9DaJpmgsQpyRfH/xdZ3fjPb1u27Z67Wr8Nm277rc/mjfoFaLiAWiKidL+RXO0x5Le4Jj
 QKfQexax2GOrky1Zt8C/jvesJJ0t+86r02kNCp4nGfCq/i861mbp2JuUocswp1P8OCuW3LWJXK4
 JMxAhv7APOncOz9gnw7eKlr17rHPqD/Ps2V3MZRCUHgzKHa+ecBehCwGfce5tRd3T+Lwds5UIF1
 DP0Q3+eHKEMsj5+JPwzzna1rVKt4RkuVtoCWHQGRcWeX6O1ix/vuUcHRvGNmXLHwpZlISAfzfs6
 scXXkcKo2/IqERFkqv0Rohq6SRES39J29MHudMCyq8qQ0FYcd4Fht9+t6Qi9/v/DEEhLwBvof/h
 6/3dDrgNLd
X-Received: by 2002:a05:620a:2996:b0:949:74d8:4719 with SMTP id
 af79cd13be357-949ba9b802cmr2630279585a.44.1795545760159; 
 Tue, 24 Nov 2026 10:42:40 -0800 (PST)
X-Received: by 2002:a05:620a:2996:b0:949:74d8:4719 with SMTP id
 af79cd13be357-949ba9b802cmr2630274585a.44.1795545759628; 
 Tue, 24 Nov 2026 10:42:39 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb0315f4sm1100251285a.3.2026.11.24.10.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 10:42:39 -0800 (PST)
Message-ID: <098d1da6-b17d-40f3-9917-eace9774c216@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 15:42:36 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Provide weaker memory ordering for RISC-V guest FENCE
 instructions.
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <20261120-fix-riscv-fence-20261119-v1-1-aeb9ba142598@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120-fix-riscv-fence-20261119-v1-1-aeb9ba142598@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eo5KXYpX c=1 sm=1 tr=0 ts=6b05daa0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=QxFdwG9AeuzbvbumJb4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3MiBTYWx0ZWRfX5sXoNl7h/SsW
 mnEkB16TWtiu4xvDSVi+tGAs59uwusowhcylSZ2AnOT7Ebo+HdXxfdXkcGpSkVs5glJW03Np9/y
 w4AlYxM7QpLbZ9cRGjq2bVXinRBNkOTg7org0pmoQvInqg9HP+NVQPrrVE4WRai5yGLaC6qJwQW
 BYitxQGvJ7zU3+VxzTwO6RG0LinDdgGXGU1jWAGhC5UUKfG2wucL9PI7eUJCzfQbs8OnISeKaLo
 3C6CYTI71UwXeofduAFgVuWe4Z0qTkmv1OBSqBYRnf5J8Ebiw4fe7zokMmFSX4EBJEbNkBcU4T0
 tElf07aesKhDWQzUg6QfAztry8v15tfdV9oKgApr2YusuXiM66Q2iXtVUfivOGNKAPd31GhQESo
 QfBIpN5oLvsAGl8oULgpkJ9tVtY2cciIx/VX7doKei0wCdY2f8aN9H7swPKI/a/r2P3GQ9CFwZQ
 yWvg+G4NR/lJQiGDmhg==
X-Proofpoint-GUID: WxE7pARmZN-2ynvXGn0qoYpjHlY9FuBF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3MiBTYWx0ZWRfXyQDtAlm5O22Q
 TQyHZZy2nO0iWQj1agExg9WAKxSGyVZ8LCyxFigQkUe0Jg1DYQJqpfNIYMliue3ixDGCb8z5RfD
 0sozwVVlOBv0/JLctiEVDbI3FwE36MA=
X-Proofpoint-ORIG-GUID: WxE7pARmZN-2ynvXGn0qoYpjHlY9FuBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Looks good overall.  A few comments: the commit title

"Provide weaker memory ordering for RISC-V guest FENCE instructions."

We add the submodule we're changing in it.  For this patch it could be:

"target/riscv: weaker memory ordering for guest FENCE instructions"

One more thing:

On 11/20/2026 6:34 AM, WX Chen wrote:
> Currently, they are implemented as full memory barriers, which may introduce stronger host barriers than the guest actually requires.
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---
>   target/riscv/tcg/insn_trans/trans_rvi.c.inc | 36 +++++++++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> index 4784ea1607e74eb5b0076425a732b5d3817b3482..6e094e5886360c2f9f7c187e82e6f60da36b84e4 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> @@ -968,8 +968,40 @@ static bool trans_pause(DisasContext *ctx, arg_pause *a)
>   
>   static bool trans_fence(DisasContext *ctx, arg_fence *a)
>   {
> -    /* FENCE is a full memory barrier. */
> -    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +    /*
> +     * FENCE.TSO orders all R/W pairs except W -> R.
> +     * For TSO, the pred and succ should all be RW,
> +     * otherwise it should be treated as normal FENCE.
> +     */
> +    if ((ctx->opcode & 0xf0000000) == 0x80000000 &&
> +        a->pred == 3 && a->succ == 3) {
> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_SC);
> +        return true;
> +    }
> +
> +    /* Reserved case, choose the strongest ordering.  */
> +    if (ctx->opcode & 0xf0000000) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +        return true;
> +    }
> +
> +    /* Normal FENCE. I/R for BIT 3/BIT 1, O/W for BIT 2/BIT 0 */
> +    TCGBar ordering = 0;

For our current code style, unless we're in a ifcond branch or switch, var declarations
are always in the beginning of functions.


Thanks,
Daniel

> +    if ((a->pred & 0xa) && (a->succ & 0xa)) {
> +        ordering |= TCG_MO_LD_LD;
> +    }
> +    if ((a->pred & 0xa) && (a->succ & 0x5)) {
> +        ordering |= TCG_MO_LD_ST;
> +    }
> +    if ((a->pred & 0x5) && (a->succ & 0xa)) {
> +        ordering |= TCG_MO_ST_LD;
> +    }
> +    if ((a->pred & 0x5) && (a->succ & 0x5)) {
> +        ordering |= TCG_MO_ST_ST;
> +    }
> +    if (ordering) {
> +        tcg_gen_mb(ordering | TCG_BAR_SC);
> +    }
>       return true;
>   }
>   
> 
> ---
> base-commit: 08ed97c33c3818ef51a7c852347a28e9f66807b5
> change-id: 20261120-fix-riscv-fence-20261119-10a425b78673
> 
> Best regards,


