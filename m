Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D4606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pJraP5my;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f+Kt5Vyb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT449-0000OY-D0; Mon, 16 Nov 2026 16:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT447-0000OC-6O
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:16:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT445-00018G-Mk
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:16:38 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJf9JL2589347
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8uXKxrH5Hy4+a2D8Ht5FMUi+q6niR0LOPxY1LU50rNo=; b=pJraP5my73+BmiWs
 23RCJ6xVSyqRzPDQMxg8hufah0CQpFowKF5QzAIMGbIa7BEZFbRhZeWJzI9SSce9
 RroHmCkiiIGLZD31408G8NwpIN9IW+j5obWYfJzkZHdvjNJ+npSCzGO+ls740rC6
 TFncdSbCAMSSyqFPOXk22ggl65W8J22OMJ3MH0NjoYxOs7dpuvDanBvu7GYdk1XM
 +t7Z+p5uPtFTXiO2+C9R1E4GqMRH1ztyDVRMiSmyJ9KeDFnPGFXXL8UCOzgkhzuu
 O2U9FTvGHoFyrxjopD3xJshlcUKw3xKaxDpCrYSNTD4jQeibqDmsKEPc9IZ98cxQ
 w1LvGQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2juv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:16:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36f479b9819so2192953eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863795; x=1795468595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8uXKxrH5Hy4+a2D8Ht5FMUi+q6niR0LOPxY1LU50rNo=;
 b=f+Kt5VybX+fmw9tptFphMdZNdAFRQvFHydq714amOCs9pDzjhCHwBECZ/jm7B4m2WT
 TFjtyFDudcya9VIPYNSSdmmwG4omk+YmOUnO7lh2jmwU8OR7WBq6kAjjg8iPErvxrkoE
 /reRd0cfFWFw/SS01zUwbrv31UeoKYyT1Hr88K+ZB8TZ3/YXCfe+W3mFeFLwR31mO7UV
 9CBwyXN6J54GGpzwnlNbGegYCkI038jefL9Qh+TgpCz8sCDujM1nK81RocBlYOxHP8gy
 EGC7i2cYPq2hZuPKABOVLRdk1hPFdiEKxnWfd7Nss+KmpqRJzqV5PaBPB2jzKix31yn/
 lISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863795; x=1795468595;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8uXKxrH5Hy4+a2D8Ht5FMUi+q6niR0LOPxY1LU50rNo=;
 b=bWKvUuxOefTzO+NCEOVjXVimjACA4c5TTm0iLbPWvIMxiS4VDIdeT1HTvSAMT18Mpj
 0LPGEhSBl7sk2Y1omjJmAQp/u2zcl0t0EHbdGv1jugwO5tRyqomJpftYYFyEv+WTx8CE
 W5z5BDOtTb0cH530bRlASD1svOF2z/QJ06F9tIyH1uH5Yvhs5rKkePqyVnihtnYawK2t
 bjRgvJzEnRlNkNX2iJIUoHoDk+UzZwMjl+eV0MZntEhYguFIgSo3y4YriIufxDxGj60F
 PxapFfpEJXCgKFexVgyP1jYmbf1tyIV+qZQL0w//cXwDczQDMaM32Exn6tuYOSTvKHYC
 1Bzw==
X-Forwarded-Encrypted: i=1;
 AL+hErF5yWpOH1bKJvjeNEGiECdlJw3ZQn7zAvgaYF1xl/D1edZW3qlodyOaBIGSOPVJVUGF/DBG00a13PQ3@nongnu.org
X-Gm-Message-State: APuU4Z8i3eCqzGFJHKV6qvXsq/p2AjbFFDoOICxhtnl3H0m/dtjLQ5uw
 5V3a66rjJxblho2AltxxYpOl6KstUAPr+aI3P6TzDUpUVM7bIRSH604u6aWuCns/c8F/K106ucT
 8ICC5nOoLQAh/bnzqJML2LFenyIVCpgLZDFb2M/M837NpQZr2og1e0HM9zA==
X-Gm-Gg: AZFdTZdgzngDwihbu6AhPFfbaWPkJmm2pYZVfN1Cu24rObL4erTTOI+T2F6p+p8cDHh
 qJ6KPAOah5fDpq5rng+FvsDikXalUexFBcnKWXoeKNfAmn/+CDfhZN5Yx+TJxdkLXr4OnJSby/0
 JM0krjEraTDSLXT9Md/YrAQYl5u56+rABNVsxcJsObKfFHCxuFSoIYrdgrfEJmsSdY6urW0sYeV
 VHvogQr3l4S5JVLm8EazU4DOOx4RimlfQzoFFXPqSKOfZyIA1td+SrXcLOl0GItLPhUh7apfP+A
 qTJguZvDQPOZ2ApwBGx5MfqCqe4u/XOuZ2C9f7j5MjRyAIP2Et/vEDLixcRt9wQ5rDnWw2TXJdJ
 ly20YLQqG5ru9boGPkh5uO2o8aSJxHMPlUlm1yz1wFf05raWEhVJc7MdbgFJngvnc8VEem/9KJp
 Uu9XLVnP/U8IaIRl9bqe1qTfnGoru/gaNVpvMoFqHcs9o=
X-Received: by 2002:a05:693c:4153:10b0:36c:9af3:22eb with SMTP id
 5a478bee46e88-379681c99b3mr13616881eec.34.1794863795471; 
 Mon, 16 Nov 2026 13:16:35 -0800 (PST)
X-Received: by 2002:a05:693c:4153:10b0:36c:9af3:22eb with SMTP id
 5a478bee46e88-379681c99b3mr13616863eec.34.1794863794990; 
 Mon, 16 Nov 2026 13:16:34 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378d7e5sm36937145eec.3.2026.11.16.13.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:16:34 -0800 (PST)
Message-ID: <a911e470-5c7a-4046-aa2c-dd7641526406@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:16:33 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/48] hw/hexagon: convert machines to use AliasedClass
 interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-15-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb72b4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Kqo8LxV5-QPNKTeuZg4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXy72QlWSO+UgM
 cJhcSa6XyeqLYPNn7iQ4/95c/K0aGJBov02BrMdvel0ZX5k/BqMb6iF13JETLCB+O8spBEzVHK5
 6NRYsTTLecxM/cEn6BB9/VvHakmcAL0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXwmTSI4yQ/sWj
 guW91c0fU2bdlwq3E0+Osu8AfUg0WkrJd+TKvOhrO9UvPXNUfuzE36kuVYX5c5qA3IhznZpzh8C
 I6pW9l+T6vEDHpm/vzpgIzeLXraa8cJpSz316vuzpk4F296MxDmrr85SDjwtF6dEhlCC72orrcy
 IaXeNUdArGpQZ5UeLEsa3uH34kw0iwrE5qaFsYKcXfFOeAx5KfjO4J2bqmileo1a2QiVR/H/c9i
 c05gzpHQxuf9oTpUsFC7si4ftSHAT2R9Nbzr2m3mpKez6gAAHUWKMDu8kue2Xs5oYiJ0L7KPfZA
 1SnYtfw/YfrCtQHt3Eo0RslLjrJudN9SUEEkQR0TcA7ra0tWfRfHi7y3bfAyJFY2DdRh1ju5a76
 ++GGS0Fbu+9BSMhF+WJ9aBpI45C9Q9pkU3/ws6P2oLnqiwh6Wf19mtmCSEUd6OgMCTjaHl1pd09
 DHgPpzcIzrEFv6qv/BA==
X-Proofpoint-GUID: J_Jq1HdHAuJKdens2bA_BMwFwyvk3qJU
X-Proofpoint-ORIG-GUID: J_Jq1HdHAuJKdens2bA_BMwFwyvk3qJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> Stop setting 'alias' in the MachineClass and instead set
> 'aliases' in the AliasedClass.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/hexagon/hexagon_dsp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

