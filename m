Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81068606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YSIanGsH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OmdWN5Vm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1jB-000702-UA; Thu, 05 Nov 2026 12:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xP1j8-0006zn-Lb
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:58:18 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xP1j6-000341-W2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:58:18 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeQqk4075336
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 17:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2OvnAsOMfkVMdbq7/5uMW5Q0voy92GlJlP5+Tb7S5g8=; b=YSIanGsHCc7QpQ/y
 dAzzmNzvGGiN4XNHhszaXFeBloIcwN1fyOvxFHW4/b6Dz1uzisThGeXtua4jNbg5
 GsxYCZG5hqXTNV+9AGI9PQChFzP+o6T3CofDS0ei2VJWYmKYCISonLJ6UZpz2nzd
 AD4Sj2kOHDhKBbAkro/jP+HJlFUjfHO1pfh/CJvyEd1qwKNBSwrZ3Y6h16qw9Z8b
 /c49zticHRnC5J0Hop6qTgvnPUKgZkgCYda/tOx7P/AStJhaPCZ/QszCkn0bfFVG
 LQN/xC3CXc39GhztWIJwfLuSR2m4Svlc72JrmnbmUxUTr7YwJ/JhCfvfAwg1mrOA
 GONTDA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkdsuce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 17:58:14 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b597558c4cso2840992b6e.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793901494; cv=none;
 d=google.com; s=arc-20260327;
 b=NQ8cf4sXhc8XOg13VDW8t1maQCrm/lCbxEk9zicnnCoWowbIhnTWeQGWwDhdJsubFR
 zWNOUfKRA65QthdCZnnBOR4hX1rL9+zTaMJ9XhrZIPw3CejHAtxpM99Za4TCgkh9mxRZ
 scfIdY3L8Bga/wridB59f4q93Gc3C+qSSuJvgTaEER3FeMSsNvekjdSZa7hebKOqQZmu
 rMX9pquyrnYkw1+wjcPJceUCysnkGj2eQW0wFR5qZttIBD5RS4Q30AqtVCh9TPirXmsk
 Md9QSwgpYDIGGInbr/3G0WOew1tyus343dPP6N1F8ca7quYZGudjhimBGannr/7uL9Jq
 b5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2OvnAsOMfkVMdbq7/5uMW5Q0voy92GlJlP5+Tb7S5g8=;
 fh=/1lq0lfR1GnA6ZK1FUVPbYmtvfdWCEexdPZ27kjzpc8=;
 b=cDYvlGS2EOd6CVraUGKNZ28XAhBUPFUmZK+/s3GWLdoX76nG/6UWfAnvCScV9wg+Fo
 kV3GIfEEdVrkBQukgXJziv3InmOjCYBRlHVTB8PcGY3NWDKWcM+1788S0sjlR5/vOU2o
 I4xEpqIfKRg+cAqtbBDPQLK0CDWqEtPtsWv3L3x+trSKYkPdlgFbKVBx+pBAsB1V2eih
 543B5L7IY2nYFV0gyabFqqCiWzKg/z/QynJ6h9vT/HW9mb0QKBn2sJS7SJO5bpsGxRkh
 5G67wjXpnnibfwKWyTAyRA8flgR1qqq2uQIXeDutOAuT87hk7Bt/S/eT3+mZh2dt8rxt
 s00w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793901494; x=1794506294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2OvnAsOMfkVMdbq7/5uMW5Q0voy92GlJlP5+Tb7S5g8=;
 b=OmdWN5VmvaWVQNJMf2jRSkEFe2pcU4OErjgcgrp0KYjMHOU/pYhnpu0liVqi9+mBEj
 ywNj8nULGpOrdcS4lW/gAgcBo1c1yBuILYAzkUhi8ECXU6hcvj6NyAcPxhq80oHuJQqX
 0SonxoQrS9a3sqm0vKSkUcCRqZ09DPc5WT6ehfF3nMhEIWQL30bEAnuCxVZE4ispkoaJ
 BxoZOlHsjXL47o/8q+KuaghmCldvBNVaG2zLRkT5mEs9bYWMI3b7X8iSbYGzh7Dl6WHF
 N1YiHU7G7xWAY7MLah546jlAfOt46d/KtorARlc9sTlDfT/CxJWVrTqrqRGq76Fafsye
 qmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793901494; x=1794506294;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2OvnAsOMfkVMdbq7/5uMW5Q0voy92GlJlP5+Tb7S5g8=;
 b=WNaVbqMHgNi6vuHR/dL8kfZbabAjRxJQ/e/arjiZUZjib+9mISavJ+owEJIcXj0oFT
 iHi64O1ZfCvJhs71yWjw/n2CpQGbkHQzBauUN7puk1JsoO6/7Im5yWRCz8cpYoSCcvdV
 7hwagwjtpgvoebk4nG86N6nqRcB2izp8hEueVh+f3EywOv+WqKGe5qlT61Zv0hjjAP2j
 9BP3seknmsz0m5qUAhvBtQiT1MuC/0Nn1zTvJfzb68VnSt5fgk39t2JWtoyoutgIvJ91
 4k5BVjhW8eIdTijJyoevbwYLn5OOL13MYPV33drZz+a5m+W5SoefHB4+YgUE04csZ+VU
 Vixw==
X-Gm-Message-State: APuU4Z/ziNBNnOYJkInCpRSdL/V4H+UqmMufgQ1bU/IRDdpZNbCZHJmt
 IGyDseEpdjNHLSmPDmT0lJC1ayVIoleQAUQueRZX6NFYtl6zT2JsGOu7XnLkkFdZh6ScwBPXmF5
 uKzzBR+el/T+HHFgi8aRkbzpx5Y3lEkfuRR3Cdghi4p3Gd0e3lyw6/dDjEgNO5fbI1Qc8ODNvxj
 jah6eCPnc96XcsMdLGqQlo6Hwz6awidM6D
X-Gm-Gg: AYBFou2Olni5deyN1JlgHRsdb+7vbUonpXYRGcoDoRr0pE96fBArHtCYVoQlGAu2JHg
 CM1/w0KAhXPfTps7u9xhO+20AtczhzQTXsJ2YiOHXKhaoCO/NLtPAJ7DPIP21lDfwf2vDcVcEBh
 Oemh3ykiRogXn5AkmhMMPrGHEINwIAQtoZV0LChrXGQzBaPSPNQN9w0drqzvppWPGEbyWt1tJa9
 TGFZfPBMW8RqOM6KoU=
X-Received: by 2002:a05:6808:1997:b0:4f5:d3bf:edf3 with SMTP id
 5614622812f47-5640e035525mr15867992b6e.59.1793901493607; 
 Thu, 05 Nov 2026 09:58:13 -0800 (PST)
X-Received: by 2002:a05:6808:1997:b0:4f5:d3bf:edf3 with SMTP id
 5614622812f47-5640e035525mr15867972b6e.59.1793901493019; Thu, 05 Nov 2026
 09:58:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105114633.597-1-anjo@rev.ng>
 <20261105114633.597-3-anjo@rev.ng>
In-Reply-To: <20261105114633.597-3-anjo@rev.ng>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:58:02 -0600
X-Gm-Features: AclHuK_eJb_faYvPaPiR7PpU5yl2THbdVHDzpbxyF-sCUS_xJ2hJtEcfzMDx1tk
Message-ID: <CAJ+KCYOjkoNu4aKf+py8GsdAB3aib7uB4kWXRV_L+CN+e=YZUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] target/hexagon: HLX, search for .new values in
 pair high register
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aecc3b6 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=g8Cq0Yl6fa02px4T-FQA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: lhYvCw9p4PjD_kfWIobsylqnvvfKZ0Ui
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MSBTYWx0ZWRfX0j1K61piuZhC
 d14FWjHMwTkj7CTbiER7zT5h1SACl1NO8BHt7CdsI2lDt7PLiGwbMF9RIdcYV6SGTDa5kI2sK8/
 tJU09TQFa4T+VE5oUKRgG9D0pLzNfXc=
X-Proofpoint-GUID: lhYvCw9p4PjD_kfWIobsylqnvvfKZ0Ui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MSBTYWx0ZWRfX+HKe79cb01J1
 iYsjHMUTIdy4QL6YZoQh1BehKWuDDaXGGzESUclnPBT4EjxQqeTqZdhs6mThh9BcBp8uRyh4u1B
 hMzS7iqPYPjVwEZt3eNtBa3eybUayMV78lQw610eV+oxwzn1zUZZ+r5//osV8Ho4xOGpi3o1E/B
 yyHpd62f8UTbxoIvCE6L14qT7ktj2YkHrbIbe9ajQtwMNxRson9ZEzSP4buBJS3fFV4VycXpLMo
 Pg9TiANdFLY9YeRy6tzioOHYW1S9N8SnwwYY/BSk20pPDoSNz22/POT3Fv7uywwly8TNU1K4uL5
 p7d+WsCwX4RyNpZ7wM4tzWV/PS9mlZRnyFnEL5koJR0Ccz/iE1BeWRLvL8SeLHpKSr1hRMG/FUJ
 GSQ+JGLyOFmbw0bRm/j7QVZfrunW29qOCU5en03lfzfDFr4FAsaHQQgFRK9ct5n9s0ZngGUIGQJ
 JbTE4l6DjJUbLgna1Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050071
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 5:41=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote:
>
> Otherwise, the following packet
>
>   {
>       L7:6 =3D combine(L0, L1)
>       memw(R7) =3D L7.new
>   }
>
> results in memw(R7) being zero-intialized, compared to L6.new which
> would correctly write the lower bytes of the pair.

The packet in the test is combine(L0, L2), and the store is
mem(R7) =3D L7.new.

Also s/intialized/initialized/.

[...]

> +        if (regno =3D=3D lreg ||
> +            (GET_ATTRIB(insn->opcode, A_HLX_PAIRED_ALU) && regno + 1 =3D=
=3D lreg)) {
>              return i;
>          }

This finds the producer now, but decode_fill_newvalue_regno() then
overwrites the consumer's register with the producer's dest register:

`packet->insn[i].regno[use_regidx] =3D packet->insn[def_idx].regno[dst_idx]=
;`

For a pair, that is the base register, so L7.new becomes L6.new and
the store writes the low half of the pair instead of the high half.

Also, not all instructions that write a pair have A_HLX_PAIRED_ALU,
e.g. LX_assign_rw (Ldd16.w=3DRt32.w). A high .new store from those
still writes zeros.

[...]

> +    hlx_put_v(0, l_lo);
> +    hlx_put_v(2, l_hi);

[...]

> +    for (int j =3D 0; j < HLX_HALF_ELEMS; j++) {
> +        expected[j] =3D VAL_A;
> +    }
> +    check_h("LX_assign_w (hi only)", buf_a, expected, HLX_HALF_ELEMS);
> +}

L0 holds the low halves of VAL_W (0x5678), and combine(L0, L2) puts
L0 into L7. So L7.new must store 0x5678, but the test expects VAL_A
(0x1234), which is the L6 value.

The test passes because L6.new is used instead of L7.new.

IMHO: Maybe we should have a mechanism that creates an error
if a .new value is used, but that .new value isn't even in the packet. Like=
 it
is happening here. L6.new is computed, but it isn't even used in the packet=
.
Maybe poisoning it somehow. But that's just me thinking out loud, doesn't
need to go into this patch series.

