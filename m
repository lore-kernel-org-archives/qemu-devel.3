Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4659606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CrQ47kXd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TKMv6UqL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJHkc-0006lU-EB; Tue, 20 Oct 2026 17:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJHkW-0006ke-AL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 17:52:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJHkT-0006XH-WD
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 17:52:00 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtipA1890219
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 21:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s9agHqQDEXLgDrWLuhMBOSJfUAl420O/7dwvwkN1/iM=; b=CrQ47kXdOU2PgUiu
 xQknA3yKiBfQHX/wdc/teT9CMIo8HMLleWTkudjfwoSsxpdWk8d2ecFNGxVt+1jg
 r70T9F6Giw5HxTyp5Y2UHx0tWXZeK+zPA7HEfeRNXcy29fHLz5PJndKIhZj23ERT
 Mibczxoo8Ys+YED/10Bs1D/FRucDFoYDmzOVVa7WHTzTORkS5uAp+PZVhlhBE0P4
 SBAna3CF6haR6z7JxZaJMbn9ohOKDqHR5p9Y2sQsUYqxHx9XaRVs4WxMF5tAsVWt
 A5JiR66XrGO6s3uF4IUVu8KfT/Pkd836hkv9a8P1hppUSwB6wPZBAdfquEYjQq9K
 lk7VRQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hebyd14g1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 21:51:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so88119eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792533115; x=1793137915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s9agHqQDEXLgDrWLuhMBOSJfUAl420O/7dwvwkN1/iM=;
 b=TKMv6UqLAjrdAE9X2wK4SrNg8qXWPlk1mkOB5qpL+vJ+c441dR99RyxZNC5KQ9qqr9
 WxRrVV/CNzQJQ54llU73DFtBjOARJ613Yym/rditReZUQWeTkZwQH07H6kIKQ/Vp1nQX
 jospDJ3MiL0YpU8AOJFpP203jSteCqDvU0V9d4OeLAun70WPi+Ghu08V+urAl+9CUsdg
 yWlBUJTw4r8UqGNWmtRgx2yJhZ3i9S2RH63YJuMbQEa++NbxunpOJKp7wDt1RFw4MHl3
 QDnzg6orribEPibk9IVVXy6E89Ij58Ji+Fz3Ns+jatXkpVXlAj7wNoXcU9cWzyVxk0zv
 PrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792533115; x=1793137915;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s9agHqQDEXLgDrWLuhMBOSJfUAl420O/7dwvwkN1/iM=;
 b=BBnvmJS2jepRuu/wiQm8i1O7CBWsXn8Cx0u9wbwUggTNeDey2qP7uYZkexL8tcrnk2
 ue5OElPkOqTR+nDQ1tbjDXAzZFAAHga3+UnOoCAjLfqCM2sCJS4WzCpknq71XaVTbRL7
 k0qnmA6e3c4Xaspnm8QgmnH5xPVOallV5Mhf9j4Z0wGNxm+jhOLYCcMk9Tf8BIC85XD3
 K4Gns+0VM0k9xoyfNnSl4iHNCk05gNSJo9OtYpyg+7JRmvrbdRHTLw/5q3nRHkbi6hAk
 VqFLwzqLSTwa/ClbIDVlSO7dNNxI0VBBnXEwoq3fSCFzaQruG+lOhPhXEIrIwYwQRbZ+
 89rQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLt8eIrjJiFfEg6H0QnVNUGCz4FwpAPQ2II6ubkc6Sdz9xgiOFWnlKp3FQTGG6JmMWf92QzqRLM+lu@nongnu.org
X-Gm-Message-State: AFq9FYJ3LT9dCdoMD1KO6rqy1VKaMxhTKAbUJlXMS3FuQYpPIZZ/OO6f
 yWtfLdOSoIDr7jAeXxf82cOWuhsFFLzA86hf11jT8O70+BPoFygDN3DYXf8R0LQeibrz1h3yWlj
 idk2ulm3QHiLE9agveQ7dhaZ3syaGJxY+SkstC6YY2iM2YXmo1GM5eYxa1Q==
X-Gm-Gg: AYBFou1mBRxNfLKqT37lpvuUTQkXJwGyt3tGC8KsvtMfdydme42Mbv43g0RS4fwxBOM
 F1sxxyD0XuaD4X/pRS8Cs9ncac+DXL8uzfyCpirZdzh8lGTwST7x5YiYLyDNzezozOC4q1cDRRA
 7BPqgiXgkFZqraQjdI4DKimDYz4mBIWK0IcCX4oMHz9J/jJ82F/HiSWmHz8r+zIqddU4/DXG7uk
 MJa3m8arg6T9tYiHMWRqfruCm+AMQbrn/AIymV3Jm8cWOmgwsYx46jyRcAyTKCieJ3ywrlvuCcP
 14Le5PfOJMxXFGFfNOiS/p35ojSpeWJ9z3xrrw6CrOSIoGczsvbv5aExqJrw9Qq4xfdGfiloBEW
 8CJip35i2axrlukncNtFVBxig4JRBpr12xEAEuKPCNHipp8gF1a4BCnYAuYoHPMEqZK1mqg==
X-Received: by 2002:a05:7022:6ba1:b0:14a:5284:1bf5 with SMTP id
 a92af1059eb24-190a4a34c1amr243725c88.13.1792533114477; 
 Tue, 20 Oct 2026 14:51:54 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba1:b0:14a:5284:1bf5 with SMTP id
 a92af1059eb24-190a4a34c1amr243672c88.13.1792533113789; 
 Tue, 20 Oct 2026 14:51:53 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ed295sm1414634eec.9.2026.10.20.14.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 14:51:53 -0700 (PDT)
Message-ID: <8db67374-d46e-434f-b173-f5aaac94c3c5@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 14:51:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hexagon: flush the softtlb once per tlbinvasid
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261020022955.3662627-1-brian.cain@oss.qualcomm.com>
 <20261020022955.3662627-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261020022955.3662627-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4NyBTYWx0ZWRfX4e/r1BwY3/ys
 DBxVql2aIU/1WAeY7Wjul2uAhbqKXwOwl+BMiqqAl45wc+8Gly96MDGeQG451Rp/bZrrxUvnzSG
 Vm0Ktih1PdFiw5EnlI2pJ8TNWx5AVrTdBhseAyntFZapwRObWBGOVuvXdx/KRhgpUbjaJzEY4kz
 xooBg+zS32HbvbgYy8SyBjpy3Z7ba9AwO6DSjzgcphU8U20O52OtGkX1RZraQsRsqjW0Mm1M1md
 C0ExvjVQasLyKI/cXtu5j3fcvYoppz6fLKp1RTKh5kOuyGh88DcnJT5SNal46oUOtN76NcbpLX5
 NHhB5XYZWTc4iXBtqaVyqjJ2wXYZgOGXhJnl8svwr16kywhHvvEaIz4OIeyFusbVkW/s0btQqSu
 ZrtYfAFpg9KOzr5dw5uP/6hSKFtjEq+x4g47e37OwA0RTDiX7YDSYKfdsMy9IDsbyA13BIz4NoH
 oeG3B/CsX1eCIYMR1qw==
X-Authority-Analysis: v=2.4 cv=TdsDJhQh c=1 sm=1 tr=0 ts=6ad7e27b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=DKRJ-yO0IQHqAxJ4vOYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 2YEyujLrf9HrlwXEmH7WJAcSwLIFBsYX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4NyBTYWx0ZWRfX3cDQyg/TI3um
 7Zr5DEGsMeLY5jmppkIiz0pGMtMocpNpW6S/+MWuoo/tdPhonxb7yS5zCJc88EPWzF7Ox5K/gyy
 QOSZOqDdk+XFq28rsngpLaF0x8TE3gk=
X-Proofpoint-GUID: 2YEyujLrf9HrlwXEmH7WJAcSwLIFBsYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 7:29 PM, Brian Cain wrote:
> tlbinvasid cleared each matching JTLB entry via fTLBW(), and these would
> hit hex_tlbw()'s flush.  tlbinvasid could trigger several full flushes.
> 
> Since the softtlb isn't ASID-tagged, clear all matching valid bits first
> and flush once.
> 
> The hardware threads share one JTLB but have their own softtlb, so the
> flush has to be broadcast to every CPU rather than just the one running
> the invalidation.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon_tlb.h |  2 ++
>  target/hexagon/cpu.h             |  8 ++++++++
>  target/hexagon/gen_tcg_sys.h     |  3 +++
>  target/hexagon/helper.h          |  1 +
>  target/hexagon/hex_mmu.h         |  1 +
>  hw/hexagon/hexagon_tlb.c         | 18 ++++++++++++++++++
>  target/hexagon/hex_mmu.c         | 21 +++++++++++++++++++--
>  target/hexagon/op_helper.c       |  6 ++++++
>  8 files changed, 58 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

