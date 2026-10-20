Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A1606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEkhuitr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kc5e4wtE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFK6-0007DJ-Sb; Tue, 20 Oct 2026 15:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFK4-0007A0-8J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:16:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFK2-00077g-PZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:16:32 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtlSK2278770
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zE4aoHPAR2mtmAwUTU+DmzsDjaXpGJFo3QGXpVEFrys=; b=TEkhuitrCr8YAHIe
 C+zBM37A0ODCWHOxKeuQ5msZMD5HUd48q1qNPjA70sQRdhVkf3CbGYAVOzidmjQ2
 2sRcZJ8hj6xhxvfxDhCiccjCd4YjndXJsZHozv1vO5cVpIVzdzGnjA0GPDPSbk4v
 EZJi+SolSZxsVnY3d3BbCHW42tLQAFwz3L7QX3v3zzUPO6N4MabNk9XDTQMaNbzE
 RSvCw7pdzLm71AFf0XVfWg4/Zho8UfI0R7WghG5CStOgi9/HJUyssgilryB7IbAr
 hWjNswvDA2QIKnO5g3VBGekNK18TQHnEwvpzEAB6YC+B06s/oHZVL/ZTblasvVDK
 PPsIzw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h29tpb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:16:28 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-151ba226e1bso5695918c88.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523788; x=1793128588; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zE4aoHPAR2mtmAwUTU+DmzsDjaXpGJFo3QGXpVEFrys=;
 b=Kc5e4wtEhob7VVFCiI7lpetVddBMgzx60Qe6Se0PhEWOp1WGcPoMWv1fNTZCpJxsir
 Q3xUnNW3L6fOQ707Xagw9UnQu91yPCzmSSeUgRjWvgC22dcxyWEeNT8WAZ81SLxqXqvy
 1Wl/0uwH0DYZ7s3mzA23GqC6wYN3z3TutGQ8gO680wwvuzvpanrzUJvUmBk1iabFloUy
 1+uNCqqwz+7Fu7e/+B33qeVHHbegOVGkcqdF2TBvyH4mfcbUj1ZXVquHVmgY7u5eh+zw
 Xlabs09eeHK4XWfA1WEe3OYtPghhfW5Iw8fh3ZsNFrcytpPl9z5YM3xMILGpZoxAsrIn
 Gs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523788; x=1793128588;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zE4aoHPAR2mtmAwUTU+DmzsDjaXpGJFo3QGXpVEFrys=;
 b=2GmMnQmrMD6Fqmr9q68r1Io5LYSPBfV3Zq0I8Ar2fwSPEBWC2qXVN4XrI9u4P9Cd7J
 XoT7sLfoPrAB7gKhxOcgtk/vqwmbo2AXhIT34G0yAv0ecrZPkyhLGqAUJWNR+cG6P7qK
 vd/21PlL9pqtBmmOU122WNSXe7LYfIHAD/Fb82X6ykBBGtLHaSY4OSIIlPP6BNBlNti/
 ZBdtwJgtF7roYhpY0dDCq+sqSB1NwYLNeocBNrctYqcEtXgXRNf3vaO8co8Sh5Sn71Uj
 vME7LD6Sdr7BLjYMfMt/zY7MuH3NN5SgVJvaNSNneTowMYqRdBGfGCidQh9vZD8SX6I/
 2lgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDn3Cd/yjn+tDiouClfzW5/BzZIU77sBasQTLpDYXElCY+Y4KwzH5cV/FqQ0FIJSS8mpbErDEc58Jj@nongnu.org
X-Gm-Message-State: AFq9FYLDwMXzAXSeQwQW73cyiidjM9bm8dPGwQPXBflL0aHUEBmIS4XU
 SLkZa7Wnw3S4AjIBmYP8vqXOelYw8hLso45V/py0978zFR2cmcF273ISaY8ZeIsLH8GBIK+Wv31
 dTBRXFGvsNix+GG1a017tC4GoVaw9pa6Dyaq2XevCLLcjCnCqo9wyMZjBzw==
X-Gm-Gg: AYBFou10606XhFNuYnBwQSkSRJd9pCknKV6DucDzHl31GbOL7V2QdZ5phyJS4Nc/nJ3
 QdENbG35lNG+oT3ZzTRFmSI5TGXP2ehMi3DI1zSmPP0MwBkWxKRyVk6IaS935v7yYaoPX/f2zSc
 3iyQ+P8oMOM6L0SzN2egxnaqjATsDKWCtZirW9xUhpuUdXPZ8n9HwS9+XfT6wmfRp1xikbhvo2I
 1pJ3uYAoZkVNmZLcSFdh/QgXlrZAaYwpsBpsDkmzLjbRVLqzlSwE1pbY0FksgROwK2THgHN8k+3
 GmnQhfWNfspw/Hl190lKyVNYRna8Qd5UUHH02ycyCzPqjujJkMuE0Ez+8y57slWCGqk0zzEqsiZ
 VU3IKX6FgMc88v86OANEwCkSG0C3IeWFDXT3McVgJDtvf0cIXL7Lmwb8WrVq94A/V06iBvw==
X-Received: by 2002:a05:701b:260c:b0:159:125a:f863 with SMTP id
 a92af1059eb24-18512c38357mr14300222c88.10.1792523787611; 
 Tue, 20 Oct 2026 12:16:27 -0700 (PDT)
X-Received: by 2002:a05:701b:260c:b0:159:125a:f863 with SMTP id
 a92af1059eb24-18512c38357mr14300184c88.10.1792523787026; 
 Tue, 20 Oct 2026 12:16:27 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903bd6b7ccsm566278c88.13.2026.10.20.12.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:16:26 -0700 (PDT)
Message-ID: <d236051e-88ed-4512-ab26-46e9937c95b4@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:16:25 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/27] target/sh4: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-24-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-24-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IGKdHXd_ujnF5DD64sxtnutqmDSAGer1
X-Proofpoint-ORIG-GUID: IGKdHXd_ujnF5DD64sxtnutqmDSAGer1
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad7be0c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=YS7yVmqV7h5W1X86awwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX1fV1dysWy404
 36NsCD9v7S68NtCwoWHiIxeMYk6n5h5J6m6wNTG3sggZWrqNeCw7OIt4W5GDar1bwbSxxhcfuJk
 ZynoGzJg0sAQTigXoltPvKMhJKDlQJA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX7RnfZJxYmte3
 sOr1a6EULFzHJfKfqrt4bTgeCGIlk8kmXoNV0IrwcAU4kV0RMre+jt6JPxpbZxTHP/qgIRNwnVD
 edYYURtADZ7nP0CmciBcRZHKm1Q1T0uMrr9PjOoNgBBWEownjYxPuRtk0bx89jP8UdBib3au2EQ
 nOeAm+5XfNacU+S/SQGy5EGvm/pKUDRtKmTs6L2hSD6qa7B6+VxeGgmONyWcjG5Yks11htZdiYw
 mtACl9yBYb38WWDWLaR9YOVhzvpaHvMDksHcKfp7C4er5pKUN594RiJc5x54V74sbKbRjvt7FUH
 gBPxexVQUlLnUYnwU8m1FZ+zTiD52L1dm5SFtKKmlLJ20Gyzp762psRSSeghUYcLk54wvyGFJAo
 GdJ5kBXmwTffY5T/Jb05RU0bX7ZDtZ4qK5zV08F/3xdeyTr2zqrrNTHmJnOr9ckkJ+Wd3YTKjY9
 EfRs6nxTgD7SDYs5NvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200076
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

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> Factor sh4_exception_name() out of superh_cpu_do_interrupt()
> and register it as the CPUClass::exception_name() handler,
> so the common exception logging can resolve SH-4 exception
> codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/sh4/helper.c | 101 +++++++++++++++++++++++---------------------
>  1 file changed, 54 insertions(+), 47 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

