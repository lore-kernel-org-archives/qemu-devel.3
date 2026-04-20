Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C89F5A8AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEt1e-0003lD-OA; Mon, 20 Apr 2026 14:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEt1P-0003k5-N6
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:07:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEt1L-0004zj-2s
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:06:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KCJZM51532103
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bWtzx0JaBPhJtURE95EL7CH7naC0rof6e9UCrlP6Gt0=; b=h4q3Z0bQhS7F+GHt
 bstB+gVcu2zdpyYz2NHCAXZ5HutuK9H8YULwzGkU17nWfNeZXNT+QFKU+/fCS2+P
 N3Mz39aV8G8dbAUtdob4SX2O/z5Z7cse4csac1YIAGXRXa3KXV87x9USUMPITvgD
 B+BjCPMTiSjwBeg18kUlGtAOZt4sF/YRBV8WDkpCr1MSnppGDu6ymwJ0x8ZJuDnp
 PwcOtvMCp7yWReflQBIyR9L8YXJlwzY6QxWIhZ4HF6BdEuhIL90k2cieRVVqJ52G
 Hz/L0Wa9A6m3n9ZhzyWspgYz6MiZqc/1wXGUTYu/XSJ/ODGkHfh45q+CSH5a+k94
 CFH+Jw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfus2ne8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:06:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12734af2ca4so1902085c88.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776708412; x=1777313212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bWtzx0JaBPhJtURE95EL7CH7naC0rof6e9UCrlP6Gt0=;
 b=eAi4ThqDidnqYIbuCqpMCHe9yFcmdmzxIHCSltCNBBJNZ9t3vxXoxk7EKfJzfnWB8o
 bVfjB3HUiZLAN7PTLYsbvZJNoCe+Qg3H8nNZJ2w7YZMtMbhv0QD+VQbBxGFo/8Hc3iE/
 41Fl8ioZMxU42bssVpphCJr2+I3Ce6bA84covGq2a/Nz7dsoi9qrdy0dhXupU/T7uZmy
 KQ+E+5A2SUcc1wY0VdeU/W2gIk0WHSrQ+LZCGUyn52TzirGisQGhSnqXVkP4wCD01I6+
 Dkm5DmpjRAfgo8jGtbKJ1j5fWGV9O3GHNWcCGuiVo9zVU1jERJ8UtzFxMKFwx2lIIH2V
 BY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776708412; x=1777313212;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bWtzx0JaBPhJtURE95EL7CH7naC0rof6e9UCrlP6Gt0=;
 b=MOyrdRrhr43ITi6BbxEsGVJNSFdRIXRtGSCqew5h5QZ4urrrzyoiXhlYbO/mT/IsQm
 LkDoimnZrdFurWyE2di2QwUMAVu0gES4Waf53qPwaLaO1jme2kIn9w67Ui+Aq7ifgxTY
 opVW/BW7APv+8bbYMlYN+cwQZnthoo0kceX1H8Kr9py0OX5lJjcBnVRBtQlehY8ehgvW
 F9ciJycutKWh05kn8tRewNTZkXmX6+6ZmUsHUPK55NK5Pgwkq87R5IxqFPlmSHsQ0z53
 meMnl1rkZe8ZnIAzp4InzCKpcDFBv3f1kOqAqUUW2Z2KcmZo7sR9NmcGKpBi5xQLi5Mg
 pLiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WR7yk0KGkCFmuo8WlWTL8mBVgt/ZkFRM65kY+IV3wA5d1qwEwcE62wEPhXDxgkLQUKKKxBeqTdgRw@nongnu.org
X-Gm-Message-State: AOJu0YzrbLDAPqoJs/eBpuI3b9+nAGGqke2gbNn5Cs1rEOT0XKl2gDGY
 lrnnLnEKoWvarBsMDJ0SUijMnCXMUf2ukuMHzhpMOrrGrZF9P3e5q+Jq0uFSN7I9qLr5GolUzTD
 TBpATHvnMYicjEGDU4Xy06s2ZABtkGoFEh7dXHeAm2ryPipm+D4GuTNETdeHRKiJ/tw==
X-Gm-Gg: AeBDietj6DeNSj3UASdBPmdoTkncgTCH3MyOc0t0lQW4rvv26L+8dwhX4LIKjZlvoAg
 +vDpkwrEixH1dT9hvMkHG7dKU/CtmKM2XgB9vjWtajl8OxTX/9pPbXyFaNiUXjwThNkAv15AhSR
 Vgey6F7J51aWK9np0iyJBPyDN+mnky3TtxQmoU9VSQO2PF8Vxxh/JOeWzHbKbACaeJM17M/Hkja
 10SQmQcPBwiKrBvgBa5bsnJrTZZIIWH4AdQV4yyad5LCNrqGiaaB3X6gikvCNbnSqJ4cEoMExNc
 4jZse/Lrblee0cEXCJ/7n1vBV+8tunsWLH+NAXeFyedK8Ur/i9LJ5NFIxNM2mAWx3XRTo85UMtC
 x1grD7gOpJLcQTR0hFOaJ1B1+OnF/m3FeWHzh5HLU7USqcSEg7z1vSn9qEef7mPCVEzr0owtlk/
 0k2pkgxQjknswUvme1Ga9B+zKB
X-Received: by 2002:a05:7022:eacf:b0:12a:6d05:3941 with SMTP id
 a92af1059eb24-12c73ae94cdmr6327459c88.2.1776708411660; 
 Mon, 20 Apr 2026 11:06:51 -0700 (PDT)
X-Received: by 2002:a05:7022:eacf:b0:12a:6d05:3941 with SMTP id
 a92af1059eb24-12c73ae94cdmr6327424c88.2.1776708410947; 
 Mon, 20 Apr 2026 11:06:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm15872867eec.3.2026.04.20.11.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 11:06:50 -0700 (PDT)
Message-ID: <0804f1af-62b2-4b5e-9c47-9e3eaec6eec5@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:06:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/28] target/hexagon: Implement setprio, resched
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
 <20260408041953.1899532-16-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260408041953.1899532-16-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3NSBTYWx0ZWRfX9/1RWR7d+R76
 CdLJtOvNDEFlz7GCpN9voiilI6GJczPRfUFluCadLjB/OX5NwFD+HWkG8YuE2EifFuymlhgBRS0
 ydBXSXZQPOcBE61BjwPgOVIjJEtVzCSHBIPrJzfSpLQT/bGQm1gF+Po+8Sa6E7L7K73hva/1xil
 1rJMrfo9GN7EatbCw1b1uDcGeTAjeh7Ha5LhW6da9UPUCb498HKZzbPyGHYGsMgnXVtvfXEDC+5
 BRdyFDCpRTP4iQbd2H3xvQl1iITfH8NDX4g2Td0Z3OiSaQ+RZoAaWnqikwYtXozmToE6cU772JA
 GNwu3ecD7r67ZuqaEZ5e2muS5CeyCx7h4oDODMy/zKP4qreuGZ0XpR5U2l3lz9QRS6txNSp5Mkp
 brT2eN63XVbHnEFmDTnvFCNT5auuSbvGA6/GVZSyvEAP447IDT66Ir1NE6WgSjSSWZSHTOsr3Hj
 UGg+RmUIn22Nn3cDpxw==
X-Proofpoint-GUID: TMgWW7iCjWuQ0KDIXnJCblHGQOIaWnto
X-Authority-Analysis: v=2.4 cv=PMQ/P/qC c=1 sm=1 tr=0 ts=69e66b3c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pBTV4Qk-EN3ZQopETT0A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: TMgWW7iCjWuQ0KDIXnJCblHGQOIaWnto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200175
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/7/2026 9:19 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> The hardware-assisted scheduler helps manage tasks on the run queue
> and interrupt steering.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/op_helper.c | 77 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

