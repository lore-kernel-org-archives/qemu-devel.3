Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F6606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Aks1jkzc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IoC+AtiL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzhV-0005By-Sz; Fri, 27 Nov 2026 12:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzhU-0005B0-B1
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:25:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzhS-0007CI-T9
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:25:32 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFp0Ls706211
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WrXtyBTjnIz5yRUJjm2NSu2x+SFjua2Q41f/Qv/73YY=; b=Aks1jkzcFSyYoDIq
 h8km2miOeld7a7vVszciBueHQns6dZZt5yDN7AAtKD2n/wnyhz2Ym67BcrfxQuN7
 h7aVaJ/nfcbs9FfTW+tHD9T/bbs3fEyhmkAOkDb5tM7ONf/1UPIUQqKI5kIMB/8v
 hJtnDk3F5IwkcRGnD1cS2AUbZ50BNtcUYAKD15aGI/OwWSk8Nmr/cYhQtlSgfc7m
 xexwZqIZPK+EoMwrbx6o/zRlLGskcVASwnuDN9SoUIql6UH7XYCX9VpPO7p5Mw9I
 qhdCMQgpgoPpkvX1kRWz8sWxM5cC+1uNUavNSOH17IbmZhHWrBaB9vzaZlTGQR54
 CqW5hg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6te09-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:25:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so11928279eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795800329; x=1796405129; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WrXtyBTjnIz5yRUJjm2NSu2x+SFjua2Q41f/Qv/73YY=;
 b=IoC+AtiLfeyHqYKCopge84Olh33qPV3bu3vA58d47gIAcBtAPSh49pMh5F6hL+WC9P
 4H4wJ9QqbU6Xufyr+sgo5D/9ka2OpddkGEyyHppbCEloqUtIhBDga6euMKzF7q3st0G6
 JNFnl5Xa7SyobSmgK21n4x41kMkbCIko9gSy1krD1kGS2UJXWL9m/O8PSph2NwX8Y/6v
 AlnVjvwCUhw1Erq7X99aDugszDqyLz6a/d3j5zoJTBi40R0g8aQ5XLswPheqU3c5lsXk
 gZxldUnVEbBX7Ia95SA7n5CoTSoEGuWnALa/UWGWpD+dXO/ixSSArUi7l7h8LOHNxmc8
 h4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795800329; x=1796405129;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WrXtyBTjnIz5yRUJjm2NSu2x+SFjua2Q41f/Qv/73YY=;
 b=mH50odYast83w+XlTztaXNW3VYnjCqCpxwSSBGjQSCrYZKKVc0mKi8YNdN79XbQ78K
 WQLY4taUey6H6PKE1aiepmDnjFrxbr9aNpNfYsvRWsg/jAzriCDQsRgFAlvvABOdZ2vn
 6nZtDR1vY5BE3zdmuOpuao7EpcXH+SioXAlj7JH8rOwoz3HglH6Ihovb+jWfm5slqB0a
 lvrHySlZ24xht322YHxKjdk+k1gLyElNTNtd9ha34VVs7wxCEArom3zrpf50Rpdz07Ib
 I4MXpnFtG7nzWMqqrkNoDU19ODdwyowZ5IO8NKd9KM43zEthjWrcrFR9HZrmtd5MTn87
 SLFQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH5wHqmBVun69DTylRSKYnQG0lvROFQlwwns+Zhxjy1UNMvSZa/CmoOvauASgxN6/dO0vjw+RiobiBm@nongnu.org
X-Gm-Message-State: APuU4Z9U/b1uFrWvaXTHbgx+ozHpPxLq4DmTmS+3usQ1SvrOo93C48pr
 RAEEJmD5VNhgJY1Ef8nmZHcNQd5U0x9lS7zzSDiBQVG7amKYyD5tRvfZAxBBIA+FEZG/spnt5pO
 HkF6CM3/qqIoX+dgMPSZshVLGuWbrKixx36v58e2Z2BCdSYvJ8IFDd24p4w==
X-Gm-Gg: AZFdTZfvZ/j07J7NKGEvEJU1ZnakFEj0FZYrpBZnzaKSmZjPrk2SXkx7uUw+55bG4on
 1Lp099BDPy0hePCilAayHHT+HnjAGxXie8jBXfh9ccWIfdV4aHyIJaIMWEiKPkx7kpPZ1ZoBTal
 eZ+VwVC1qd2eVQ96dPamsZiOcgwE7a74BEvzWSjw4UNvPh4et6hp+XU91Lg9UbqLAIfoTEEAPOY
 f+srEZZASELWDoGMFBqurGB+pvxsdG0hYm/OowTzPVRjVfV1uo4vSGCwkp2jkNTxLLyvqB+YvYK
 U4qy0PeQQhKuoIi4dOUa5QHoQPjWc9zpUJpZ+UQcwg5w9YEKmWH0sE9IxpwOmEg8+3BM0rq1Neo
 f5xHiAfRaeLCS4/wH89E3nKBhQ16YmLj1gxWl4HnWmHJDfFhTP9S5VvgKTQ2oR2/GEZA7Miimtr
 eFdeApqBZ6KWnh/63EtirHEObT/ozyDnEmNs3DATGM3mU=
X-Received: by 2002:a05:7301:6405:b0:36e:aa5c:7851 with SMTP id
 5a478bee46e88-38570355b25mr27143037eec.27.1795800328581; 
 Fri, 27 Nov 2026 09:25:28 -0800 (PST)
X-Received: by 2002:a05:7301:6405:b0:36e:aa5c:7851 with SMTP id
 5a478bee46e88-38570355b25mr27143014eec.27.1795800328051; 
 Fri, 27 Nov 2026 09:25:28 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567abb870sm62229716eec.25.2026.11.27.09.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:25:27 -0800 (PST)
Message-ID: <26415246-2c9e-443e-8d43-2db9a34f54d4@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:25:26 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 3/5] linux-user: let targets add notes to core
 dumps
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
 <20261125194855.3154845-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261125194855.3154845-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _JlkS1ovH-WB_bbM18PVtNePrNlm991M
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09bd09 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=p5mIUC4lgDk1DxJc2ogA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX3ucIm2gquc0Z
 TR6qzSiw5vV4QUePLWTI9bNOiP427srCape2oYN4waJ7Xf9/IZJKwauCcPe3YAHH7I6B72uj4lx
 tDhypSXSBWKhLMOdKyMKHYUBo4V2bBY=
X-Proofpoint-GUID: _JlkS1ovH-WB_bbM18PVtNePrNlm991M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX9/XE6bohjoOv
 Q7+Mk1fs+D/VDpC/vF2iVYtdSukyKVNkNucofJcfAxya2yZnNxxezveVCafLgZj/EeqiL3aUVvZ
 g2vjyWORxciJnlr0eQZINKY05ggL8GrZKmFLYUcFuuj4/gzNyP7iwEXIhlBTPd4zuzxrANipISG
 YXpGuBPuPT0MKJruOgON5Q/rRy9Gc6kGsG5Y3kk7Z9ypdqY6eczDG+e5cROuWFmZSvaYssuGi7A
 IWCPSnuY3vGJjUZUI5cxlRuSXDtIY1rb7KADJpQEOHydyP3ySt8Gkbw/yU+a3OTOYERtt61Sm4k
 y+y4+gmaRMJyxBn4U+54ErFygsGbqQcwWaMCC9z+GhJIOkkVk4NMZDDIyzK7mZtV+RDLbofX4xN
 15GVu+CqgOQuoN4XnmaZEOhvk6xvsY+hMscAKA5k8g/M55zC4F1l2atNPG8FQobVuZthPqopjGS
 dP9ddpbEhigJdtgp0Ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 11/25/2026 11:48 AM, Brian Cain wrote:
> The linux-user core writer only emits NT_PRSTATUS and, for some targets,
> NT_FPREGSET for each thread.  Targets with additional architectural
> state, such as vector coprocessor registers, have no way to include it.
> 
> Add an optional HAVE_ELF_CORE_EXTRA_NOTES hook.  This will be leveraged by
> hexagon in following commits.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/loader.h  |  9 +++++++++
>  linux-user/elfload.c | 14 ++++++++++++++
>  2 files changed, 23 insertions(+)
> 

Looks good.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

