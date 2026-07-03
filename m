Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B02C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 01:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTBD-0005sI-Km; Thu, 02 Jul 2026 21:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTBA-0005rp-Jd
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 21:58:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTB8-0003wA-UE
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 21:58:56 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66319CbW2335885
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 01:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 slcSG0jn3aVJP0MKOXhWWRlhGWUlyVzCR1JYsC/oHHY=; b=GlLuX/GgYPiyXAn0
 KVzJnebgSm8P4yVjEXmwE8QEg+ok8DAL+8OKNxlydiNYksauaZnoBCueaylqiQVf
 D5LttQti9N2SoHexJ0M+LMByYte1e81MxGmg5qvGMQdSbo5uiHJe4QNnnEv/vB+/
 87G+0dWXdZpBwkddu6PQh29PTW4gUc/2cF8BpKjjCVBCaH1E5LLqFizeQ7YpwsUW
 UPg5K+29LAFBTU58SOC4/G+sCvRD1IpGfwPQnUaq9zLAkWmWlHGuKB0FKRl4CuLn
 6etZVW/JZcsgN9BrH/mh+AGoKa0EscRv1aNxmDco1QoB+ssJHZdoefsPi6K+DF8G
 TL4E+Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60ey8jk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 01:58:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e68cb7a3eso14636585a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783043932; x=1783648732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=slcSG0jn3aVJP0MKOXhWWRlhGWUlyVzCR1JYsC/oHHY=;
 b=HfUUJ2WUeVAz0iUDABWxLqKzrIDJj0b3bN5RPrQOWA0NwFm7Z+EGuKNHyUZqd/li+S
 Guvu+m14UAPq4DnFkfHb7n1q9rGewsbyxphyyDmg552Jwm/VchOLYQpGHx2Jm5drbdRd
 EXt8IVYxif9ts2SkYXOrowUtTl5j8Br2sFsVBV/r5nZjA1CAxq6qAvjW6QxnlIAb+d3B
 CCP/xSidzTcOEgh05UNwrGLDaeXyWDl6WHbJvbHHNQ/6m1p2oZSkd8PCL33p2Ftk1nPs
 qoUuuPqrbyUf1biMbvsovHGfKIfhWHd3vFUQsyl8dStDAEXjNvpaMap57gkHpRDsB+rO
 vxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043932; x=1783648732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=slcSG0jn3aVJP0MKOXhWWRlhGWUlyVzCR1JYsC/oHHY=;
 b=rqT8IHxdSN7ON9OZV8yRZr2ltEcHy03sK+6cwCGqk6oPLx0hfsQqkFPkgMcbJecTSR
 1eH+6y1iP8CMKs9phfYUZb2cK3iF39l5WXi5tQTg6KInENY4dvMYuxjRcm4u0FU0WOK8
 rBajHpSRZWxdXjPXPwBhlgK1H8rUTNCPFf9klKySa/K3D7lpDSig6t7WfdrVF4+IR1wR
 r48QieAZxijXIujY6bdIXNBbv2nLsI4ijWxGOd1E2fl0xlO8PO+2uvmwuhuWHgbYQ2TR
 mDaxomYPrBkVMWdmhGMhUb3A29/TLII0kztrVG9YQq2SCt9LdNVlnzbtPxhG+wOjSBGl
 oFvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3STVuj9DQBlMi+QBl62acEYZ8ZlSQ/GFLTCkywTj7c9Y2d9NsMhzEKxRknSSI2js7fnFSHFEoZtCs@nongnu.org
X-Gm-Message-State: AOJu0YzP5lsiwMqNzAtoaEsBi0d3iA15vZIjwiCzkokcCS1iNuA/ZRnc
 ZcJwlYHiDoAPoCYMINwCcw2ZyAQong58Id4trAjA2yOyDPNjrYBlfExEIux86ET8MBwfbHqGtqc
 ls35kd55DLFngg5dXEf6BsbPp8+zIK6pc9BnUtJ1OIiKmn83kv07kRPlOpQ==
X-Gm-Gg: AfdE7cnmaWmtDGVvKw9g6/OD4dlsjunK6H+HM10ZHKqXxkM1rdpQLNnMnc6N++qkp3l
 D6zx0MJ092BJw2c/64v8is6IJF5mJiH8bCG/FeLtqtP5e/b9CpiCtKDefeYjuugpyI4ui5Dp3ND
 hhZUDUAlbJUtc4A6w/xfLMVTZooJNZhCj98chSDa8cwHu6Xh6ZRCcucy1wsT53iDsiCwg8GppDh
 3tqgUaxZb6qEm8UJ4E+Jfqwt7/ihh7/TlzK0tsvSCR/IBSmxKqxwEzxpWx8t3EDV7NIuSK7xAKN
 6S0WEoUeZmIKzh6qUnB9300VF23gmAWRfGYic8ObgOkZizkQ/WmseSMNOiomXfbRc8dZgJxALoe
 LQqBq87AtHb+pSVOyoRkqliApxmImT0Y7T4P+ROOY06EvrF9V1vpSuk4u7ghnwg==
X-Received: by 2002:a05:620a:460d:b0:92e:59e3:855b with SMTP id
 af79cd13be357-92e781d2147mr1139082685a.12.1783043932384; 
 Thu, 02 Jul 2026 18:58:52 -0700 (PDT)
X-Received: by 2002:a05:620a:460d:b0:92e:59e3:855b with SMTP id
 af79cd13be357-92e781d2147mr1139081285a.12.1783043931968; 
 Thu, 02 Jul 2026 18:58:51 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbb79sm13399377f8f.2.2026.07.02.18.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 18:58:50 -0700 (PDT)
Message-ID: <6db9c705-004d-4ce4-bc8f-3c264127578a@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 03:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Work around Fast TLB insert instruction for
 HP-UX 9
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20260702224241.29866-1-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702224241.29866-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAxNyBTYWx0ZWRfXynyNQBMTFhej
 0SwCYg9bt2MPbWpW4vQJXWbOIDZaWTTWhre7W3sJlgq8seOXRjud955RqdDwcO/Pt8anJJCklat
 I4/6LQaPZMvINLbx6daItIXInk/CpZupTHjAOyjJHYUcbRfXLzUZcbiCegxSy/GU57qD0zbQLaS
 8CZ9bToctr3SJreGTKXCm7pljI8Hy6CxZ2OXjk09qa3fppH5weTDbeJwe12wguBjsiFWrxxPPgg
 cPM14HgVOxkTafi6dE+r92UcTVV8qvM0dICzjTI+gdIQRrzcF64cVrX/6HIO/WOOY8rlpfQO28U
 Moygb+opLky+AcfCP1f51Y26a0/jCl1wHwP/WzHnzg9cq7a9EyUvXXFdWwTDc8miwHE5NP8/ufb
 n9/yvf9eGH/RxTpPiajRfIYu5Wld6tzIIZ4WFh5y2k2lBuwtDrIny16v3E28+CXpPVebZyp6K1n
 L9F+p/H4lfQMtF6CF/A==
X-Proofpoint-GUID: leLinhg0YcX7SkqcKX-YEMVZpk4FHO85
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAxNyBTYWx0ZWRfX1b+sBodHWoBC
 MJ8rUUJra+Fm7GvHDONk6KODbSzFmchawYLkbuEDmf+3nsAhAB5aZS9aBaLeve8SUXLa5qhqquu
 jQ69bt7PzuMfPijDEAmgImQRYSN8om0=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47175d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=_4O7u6jvMZz_MiRxEEsA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: leLinhg0YcX7SkqcKX-YEMVZpk4FHO85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030017
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 3/7/26 00:42, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The HP-UX 9 kernel uses two TLB insert instructions (0x05315440 and
> 0x05385400), which seem to be wrongly encoded fast TLB instructions, but
> similiar to the non-fast instructions idtlba r17,(r9) and
> idtlbp r24,(r9).
> 
> It's not clear, if those undocumented instructions were used by mistake,
> or intentionally. Either way, this patch allows qemu to handle those
> instructions, so that a HP-UX 9 boot-CD can now boot somewhat further (but
> still crashes due to other reasons afterwards).
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/insns.decode |  4 ++--
>   target/hppa/translate.c  | 11 +++++++++++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index 13c6a55bf2..837a0b73e6 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -162,8 +162,8 @@ ixtlbx          000001 b:5 r:5 sp:2 0100000 addr:1 0 00000      data=1
>   ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
>                   sp=%assemble_sr3x data=0
>   
> -# pcxl and pcxl2 Fast TLB Insert instructions
> -ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
> +# pcxl and pcxl2 Fast TLB Insert instructions (with HP-UX 9 workaround)
> +ixtlbxf           000001 b:5 r:5 0- 0 data:1 01000 addr:1 0 00000
>   
>   # pa2.0 tlb insert idtlbt and iitlbt instructions
>   ixtlbt          000001 r2:5 r1:5 000 data:1 100000 0 00000    # idtlbt
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 4e34822565..72bc881784 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2666,6 +2666,17 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
>        *    return gen_illegal(ctx);
>        */
>   
> +    /*
> +     * The HP-UX 9 kernel uses two undocumented instructions 0x05315440 and
> +     * 0x05385400, which seem to be wrongly encoded fast TLB instructions,
> +     * similiar to idtlba r17,(r9) and idtlbp r24,(r9).
> +     * To support HP-UX 9, check b against 0 (documented) and 9 (to allow the
> +     * r9 case), and genenerate an illegal instruction trap otherwise.

Typo "generate".

> +     */
> +    if (a->b != 0 && a->b != 9) {

s/&&/||/?

But since @b is not consumed otherwise, what about dropping it from
the decoder instead?

   ixtlbxf           000001 00000 r:5 0- 0 data:1 01000 addr:1 0 00000
   ixtlbxf           000001 01001 r:5 0- 0 data:1 01000 addr:1 0 00000

> +        return gen_illegal(ctx);
> +    }
> +
>       atl = tcg_temp_new_i64();
>       stl = tcg_temp_new_i64();
>       addr = tcg_temp_new_i64();


