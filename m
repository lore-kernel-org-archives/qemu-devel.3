Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fh3mOe+/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JtwhusHI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtOC-0000cb-Ew; Fri, 30 Oct 2026 16:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtO7-0000Za-1C
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:39:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtO5-0004to-MN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:39:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIcdUV4118702
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MvMQYGcFCWyTAmLfV5n7otD9H7uOenGAGjfBMyFO9Qs=; b=Fh3mOe+/M90rLPKu
 RrGWaLC/rdhjqJHVV2/n3tXsVrGLgizBaK09OWc53PPMQ7puHZY/15WmSpLAMIgL
 PxlhXZWqVvzBjgGQ3xf1Gj+S/7kzH67sjs2tx2eYNxz19kb/lL0SsaZQ4thGH+dq
 0ttOlY84pTsKr30p37uQ+/qpQa28ty9+7L7pqONj4Ehcu2XZJoEfue7/5qom7Aul
 zve7sPjn0Kj+vMfPuhCyfloX0yCs1na3nFkm1+ntwXcl5BJ8vQca3U8Z1JKJ9e28
 FoKNIvLB6K9gtZTehKjMC8SyMgoLoHnF9bbgqz1AUv37byovo2k6wT8FVQmTLHGf
 yS5V/Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0pu8beg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:39:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso2421253eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793392784; x=1793997584; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MvMQYGcFCWyTAmLfV5n7otD9H7uOenGAGjfBMyFO9Qs=;
 b=JtwhusHIB7uZQBXz8W7GcdINaw9mEZclywBrryjVlVdakmV+OYuQRZxGNh74ANc7+T
 unyKkm1w5gzXri3qz3Jlb6m0lWWnUMLx4mTsAFMkA6EVV8/hRGBGerwzik7RTaM4MC/n
 /XfidDq3SUrBhpeMf+rihpjtGY7E1IG/m1a5UIF0ChZCQfTSAx0ttY4XaouVbdc+V4lV
 RAkMrQr9v5ZAblJWAjoPa44Z0WXqzGAb0IOfZGg538/WXNZ9Va/l30ClOw8NkuDrKEvG
 4jVf31wwfM6kTETapnbwkEOdWPEMnyiYkt/XMCVMMsoNTbqYQCQithe70wI0zMPgH375
 cmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793392784; x=1793997584;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MvMQYGcFCWyTAmLfV5n7otD9H7uOenGAGjfBMyFO9Qs=;
 b=CDwghp6YvyzEp4UR7CkxLDDrDTSrDK9dUnY7MrbV6AgO6jFhT/EZI9+fkajFdWRA4e
 wCLrgX80jpU63d1cet+jwKWgmCxhV1eHp3BzF28L+QfEtr8Vyq+oEu920F/yMuAdizay
 kdsIbX53vGe0ivNHffhM1VjNV4Lh85xcZHXhD6UcMmv2N7H2OlQ0EB+F/7oxU0t4kk+2
 Y+yAh6rZPL5upV2/J8QkO6M+F44RcyySO/n1hVEvITpZhqsdN6eH0c+LfOLjbh7h2pfp
 aL032ohYsAIINlP8FNO/SUWK09BKXbIDERVvtkfKHxdb2ngkP0PkahmsKtouQtAA+kTa
 8luA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxwuZeontw8d/i+gyZJpVgnq9cunhEtDylI4G3T9rBvzL9VCz16Pv8ZOaxs2p0M+jwKmTW81tH+8WE@nongnu.org
X-Gm-Message-State: AFq9FYJzipaBcO2ysg3968Ir+b3m/ctCRKsr9m3tROV4ro4gYbmg+PZ1
 OogUBN5TW6ArhEi49wb16YA6wPobtTx9sono427mhV6IMPDsvPu9FIDVygM2rB14nRBk86istCO
 kNLVclkX15JdSBczEzq905vPi+uDfX3l2OBucuO0eUFilErib+MCtppU0afuJ7spmCw==
X-Gm-Gg: AYBFou2AAhO2cgsWqpmWoAlxU44u5FvhjV2B2p84/LoVYT9RyE/rRSk8sKfF61fb5fq
 MQIM+FFkTGJPjG+1rkl9IH8N2e2MQ0HWkqa8OgRifh8tVZFTOXlcp9cvLl92E0liKirgdpkvIPF
 unUH6sSrKNKVYBuqaz056Gn4mwVJsctvcdIlPWxBKPSpA7lunvqvsn49JSK1CNp1ksPG9xmcSOm
 KPcneI9T/IwqdvFPo/VAEYpmEqz7OE+PKeKGGxHn5nHtqt+yA7ZiO5ZmG1M6GFfhD5p4ARwu/9M
 CSswo7yYzkG5XfjUikvy8BM63Zw4ijFJNcz8oKk0OrL+PidJ93IerUQ59P3PIu4gFAJqPFaoEJv
 W1gU9y7NdZ1WhjS45DRYpHGzrfXB4YMqvO4EfZObBFrjkhHOMC10IIl1PFdVYc2y9WxL3osM/Jh
 8zargH4RftdREH0zcqSBuX/cgrHu3cZ45V7iCgYeYTtw8=
X-Received: by 2002:a05:7301:4543:b0:353:5d0a:dba4 with SMTP id
 5a478bee46e88-36a4248a4bcmr4831150eec.36.1793392783580; 
 Fri, 30 Oct 2026 13:39:43 -0700 (PDT)
X-Received: by 2002:a05:7301:4543:b0:353:5d0a:dba4 with SMTP id
 5a478bee46e88-36a4248a4bcmr4831112eec.36.1793392782894; 
 Fri, 30 Oct 2026 13:39:42 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428aed76sm10210806eec.9.2026.10.30.13.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 13:39:42 -0700 (PDT)
Message-ID: <01237c2e-5ba6-4ac3-bdf0-1f31ebe08015@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:39:42 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/hexagon: implement the guest virt insns
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
 <20261029190208.1169519-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029190208.1169519-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ll6u_rhikuWHRKG15MixZipoYhAguB1x
X-Proofpoint-GUID: ll6u_rhikuWHRKG15MixZipoYhAguB1x
X-Authority-Analysis: v=2.4 cv=O92sLx9W c=1 sm=1 tr=0 ts=6ae50090 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=b-s42ORi-be4TjcVH2wA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfXwX5Hx0+RZeqM
 aNN8xM8ThusPtm4oFY8kfoE2MW9ZCDA3vj28JDFWxa1QqiVkclFuZha7Gf/LlD8+2RaN/2KqULf
 fY4bsTdpj6TU3qqqqzcWBqo0uf8rieEzYEZu4+46Av7rqQauCd61LXBd+xZwe0/+5whzg/okmHy
 1N99ttdsuy4JPVp6LjmEc6YvsPmsImvXjJxkamsKF4YkpApOiqG8vxc0nTQWiTf1WNrWnmt9d0v
 y2FUCP1w85D6nwxg2lZ+1342IIjM2wg0c1afLWf5pAVhWpn31/QSL/N4gJnY/eapaC+o2vqIfwi
 qLHT+M00kUXja3ALhLpRr0x4olJEroJTyBOEEfAMwAXJoOfIBPV8FxvU/ALUX+WNisDt80hitwm
 aQGroTSLJmt1+XxfifEtoR6UpK6uifpZc+3o/vrSRXrX7Obk2EhJrv5VIEQavlxglQF8uXi+ZvU
 m/fa6FrmvswCN2AzGAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfX8s1LjuKTpjPK
 9UHOrFC/7Aip3pzXISwNG3UJHH4NrjM6vF0VRjrm09pOMCRQYKLjFopT0mr75g9iFD/L9QAq2xg
 HMuGQ3j6HoKrMA2jPgFNwNYHS4N18mQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300082
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

On 10/29/2026 11:02 AM, Brian Cain wrote:
> Implement the guest virtual instructions SPSWAP, GETIE, SETIE and RTE.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hexswi.h      |  1 +
>  target/hexagon/sys_macros.h  | 33 +++++++++++++++++++++++++++------
>  target/hexagon/hexswi.c      | 28 ++++++++++++++++++++++++++++
>  target/hexagon/hex_common.py |  2 +-
>  4 files changed, 57 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

