Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690F7CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5jY-0003uj-34; Wed, 14 Oct 2026 16:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5jW-0003u1-JU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:37:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5jU-0006ia-WF
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:37:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb0YZ905379
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jl94b0wjndotVBKKHlRvqZcJjWV9wUfmh82SwvQ1+Yk=; b=aOUt8DoNpS2cRKnI
 Eb0uN88JYiTADfI8ZOCM0IVCFWLtUhhl1YTFlxULc7Ak4iOXV1it7K51/cya1+FT
 9sx+DvIDcjv/bzsNQwee9g/vw4DG+yHXwb7XmcBRPEBJLBQ8BsgPTDGpvES0qpbR
 GYO7DdREihroi7w4FRtNb9f9InMg6aoVICtOXCWqXbIj2txi1HYmI2gt59ZQe0gW
 xKu8UmwM1B0we7xOd+fORxH1DMRx096DUwIT0M8VNIJs/5GxYND2AICerbrdrBsv
 YfxpJjnrpQkSs+UwMc8iGq4Ajrr0qG/JDQLuCqt6O9tabrK1f4JEo0qh6UrzlDzf
 yMNgkg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p3fb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:37:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-351788121cfso8662023eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792010271; x=1792615071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jl94b0wjndotVBKKHlRvqZcJjWV9wUfmh82SwvQ1+Yk=;
 b=RMuE3puI8xnuc9jeUVkMHUTaZ/bNjdqQXinvh+Y71iIkmSvSVVelcmkz+Pw/MZUKTi
 MXa/DUDwY0x4v0gnpE/+eH2ybRhSSdxKHRxHd3Ut94OoZQUpnRdyOse3dIMS9ZjHH3U1
 +q8m4M28UmCGB3IBGxcvDqwEzLVOGM1XGWmWiplHCd2g7Cxzps3uu9HPvibwz8vr/aPs
 1zgHvz8T71NZx6XzhtsRkxbAPCLJvbI/noX04nhv8qc0YCfIfYiVu7Y/ViYApW9ue9Bj
 kZMMhfdouOLtLk5XJslY+awH2qWMhEXSCUGV6d/d33AOzC08tJXgBMSWazwdWigXVsdT
 EM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792010271; x=1792615071;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jl94b0wjndotVBKKHlRvqZcJjWV9wUfmh82SwvQ1+Yk=;
 b=JyFKcDZU645KbUpox49buJ9+Qpe6IKRSSZW9qv0pl6/6J/UQtLDufgT89h01mblj5y
 w5AhmAnNNHz0R632OIWE4Rf3bbF/jw8175DGurBOTJHgGCKmaUToOGsujBDRrMWFI9A1
 DtKot62c5op5uVZuAJrwTCuL+/IFfYBowe7HHfI5dCg5WgDESRYN5oz0jcgnD96S11yB
 +08UpIenL5aaafd6EqW+kzIP4RqV2m3Vh9xqbWOO+APDmaAn67dM1iNKJuEeMEPGvQ/J
 0or/CGPoTVUQ0y8nS0E/gCP9fS7Hw+LQVrcJgy8x0+8x2o4x9sxDUxVJ8RZJfOjrbvc7
 Vauw==
X-Forwarded-Encrypted: i=1;
 AKwUvByr8KJLzrv8vnAkNrZMw24fp6y02IEVXSJNN0CyaHAEaH/jtjcvtCYJmJMhB1/yTSLwkC1gGsvxmXaf@nongnu.org
X-Gm-Message-State: AFq9FYJgTi0ASwBDsYv/6mjWHs4eROeczRICNx8Tkl7b5K1mfKvtHLHH
 I/Mk2t4qTqJd/+BTKXYxqjPpefIUo5g+F3HuNSEf0bc10YPhLQDfqpDkU2wnuA3WMMWSNs3NluV
 wR0m/VasVm1T8DFK4WCsWfK/z70eNzlMVk0R/QnIwRcCJApO1c6Wwpq8IPQ==
X-Gm-Gg: AYBFou1GdM8BgOl95TEHuqX+eAU65UR2pw7DVzYW1Z6PC3orFKzaO2twsnyQUfaMk9B
 bClp6V66cIBgxGehyploF5bVCIWeoiZO8sTj16vR4cEOx+WdEuXUhIGqyml4QSYvBDAkgCiKSCf
 /YUE/64qfxP7UPp4vd324TEEzN1pCINY3Qvl6TgDQmulmjjOBp0nKdeLy/rgE5SWSD3Q31S6+L8
 ABI3evbjBCOoOhT4AXx8ZsUGYX3sKybecJiHuXuIMfpl0M+TujriSRCrcTyQx1rC8ssb7Gt04CP
 nWIFhzp/FZyKcE7hvOo0nEj3qJA+qq32h7Q0gN1CDxM7y/gdJ3oxaeC8GaLRBYHYw9uunXqjFsP
 ccFQVIlbXNZtk8D+VBCwIdvdiRuAQEa9NBx9LFq2Bnl/VFsGDMfRhDOLx5lPPGz9CaHtTDg==
X-Received: by 2002:a05:7300:e9d4:20b0:35b:20d6:8eae with SMTP id
 5a478bee46e88-35b20e5d33bmr13783438eec.3.1792010270438; 
 Wed, 14 Oct 2026 13:37:50 -0700 (PDT)
X-Received: by 2002:a05:7300:e9d4:20b0:35b:20d6:8eae with SMTP id
 5a478bee46e88-35b20e5d33bmr13783312eec.3.1792010267987; 
 Wed, 14 Oct 2026 13:37:47 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm29849357eec.24.2026.10.14.13.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:37:47 -0700 (PDT)
Message-ID: <ab94e24b-69f0-4e72-8dd4-5b73383a4d64@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:37:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MiBTYWx0ZWRfXwWN8975+xLCi
 Ru61hd6wBqCb74uDHkTdgxtcCXSWyLfZRvZtjicIm8tyDF19mGSzC2nIxteQV7uNiahqj+I8ev3
 s6dSwdIS+ZOk3ppFYEPKAaYf6hLJAd0=
X-Proofpoint-ORIG-GUID: rSzfR-3StERK3_Iyw88TJ95tgIcZzEI1
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acfe81f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=IfGaT4wxoJR8PBfNJjEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MiBTYWx0ZWRfX/N/TegmaBvJ8
 jpOrNOT2gy/SYufACn0qZVXJSuypJ9gKDftmjfu5dIxblIAyz/JFDl/WrbIiUevOFDlOd/O34Vf
 mcaZjRX9iICHyeZMKpINBhWr4SJA+Cp/372QJGnCDCwgJ98804GRzAymDcT9HiGVh1Z5saEzqtg
 cmNLdqr+Fz7s4bC6fa6BpFEQQt/1q+ZfJrCXox9BNfb95pNBIhxGmk6wSs1BCG9MDdelD8bh7ef
 DOKKF3BoPAgdKSWgbL49/WE+5wAKAkcTHdbpZVKo+97ZJZc6PfpfNeZCuREAl8SeXbMN/TM5sr6
 Y8t+uSx88qnEtUqx3JhV57UmFYiR79u+tgeWaNQoiV8C1xH/tdQfHTaMG9hikTEjJ+0/KkSkje3
 PdKTLuNqRdbCqta3Q4XpxQT2+Qx/udzUxNeFBV75m/eh6SofdJteUEaJwjs+wve6GS7W7JlIXIn
 I1vQ/jsxmo7GIver8Tg==
X-Proofpoint-GUID: rSzfR-3StERK3_Iyw88TJ95tgIcZzEI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140082
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/14/2026 12:52 PM, Brian Cain wrote:
> Bit 7 of L4_loadw_phys is valid through v81 but reserved starting
> with v83. Decode it as a legacy don't-care bit, then reject it for v83
> and later.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/decode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

