Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AA9CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgLe-00065v-R2; Thu, 28 May 2026 15:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgLV-000649-EX
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:24:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgLS-0000d6-Ly
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:24:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SHNwni124489
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6QzpJOum/mpZK8fD6IhSO5naAdNpXpwo14kxf8nmySc=; b=J/UWhaf4H3AhoqxG
 NTYGISYpmE3l+T8QlOzmMmc+9DKa4gn2Xk+VXxy5CgxtB8r9itqbo7A6Svmz66fV
 Zz4YPwGW9rSZ28mYjB8Bni5xPtysSY+/q7MS9otg3CfVwSsFbztp7ba41DpozoX6
 z3x+pjUOcW3fLNITmdY7ceRRwhlXpVZ2LZzUr/aZ6AS48domQtdxm4tDvf8dsHa3
 QKuT6bai01PGX9TkrrkOltQqM2iqFLKCAYNXOlw5uiXtBr/YBh1pB9D7Tu+wPa7+
 WSudzH6yaKLUmp8fE9SzcCAFLkgmrR4mA/GJn/q2Rw25UR1+LAJOXJo+irj2fNig
 GiIVCw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ycccr9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:24:41 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1329791f18fso20687335c88.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779996280; x=1780601080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6QzpJOum/mpZK8fD6IhSO5naAdNpXpwo14kxf8nmySc=;
 b=fK1uBz+Kvs2+IOM+Fht8jsHeRpLw22eWlku5uDP3CuLCA9bq+WkvUzUXG9PX9g5Xsp
 whiTAYLQWDNux5DZihkyRNx0mabWP4xUzb/9s80YadTZL8tO3FkffMbbwh5ICvxsU+zk
 ZjYr+1JVEI7VBuFIlmsO9O1duOu1KaceVjoSCvNqxBqMRYI0JjFVVZnq+zgxPxzMqiRG
 5N4j/MGuiOyOtUzYjCRtYqyojsPCFPvecHDXgJ+t2LtYhconqBCQEAF/n8nLKOgXXw5D
 VTjlFb5nY22Ejpe0DdJpS1zmWeoerc9AZG6nBvsoR0tRvOU4j0TsUTHLlC1hzD5cqp+H
 YZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779996280; x=1780601080;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6QzpJOum/mpZK8fD6IhSO5naAdNpXpwo14kxf8nmySc=;
 b=eCYCvJm08FcSp5lp/lWq6yexLiLh4wlDxBjVIVc5DVdPYvoZu4luSiMKTRv/WI2GcI
 lghASoFHhl/Sk4uWS/vPj6/sepV+rQW7U8SLX5GJEPuFKg/+Gs6yxocRZMRJzpYJllTr
 4Dg0FF+WCZDKpfaVSblgK42kBEh9yNbRyYyQAsS2r7MovsGmNqosCoI6YDcO5NCNxx5F
 OkQNRsqEPEzaD1QYpa0AFT9IeWHDXgNLrSfpZFiZQyl6w5Bsxto03NMKxzqTbkF9aAvg
 8Sb3B3mvNVcOZyZ5NErRUoJiwziRv4nFfrNLr89iRCXN5crNGriXG68pVsTe4g171yfp
 OC8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xIcHpzH2/5UNq+VEOSH2zEXhXuq+hbun/U8QDK+nnIPcf2nG6dXCwUYU5ygBk0tRtl6/U/XpE7Yoq@nongnu.org
X-Gm-Message-State: AOJu0Yz1mYOsTlfy7SiT9TbKR1az9bO9nW2jOhLIzS1qezKB8xxjmtBP
 XIed/yevZnkws/drFUoDEAnpS1pGOKq2iNlWs3RJ2AwlBSJmmnCvMuSErmQmHa+8z0OJSadxvsH
 hcaUhxq58paNBQCSC/ViaInS1ct4vMk2jdkhS55MFEoGtN5UGYs8pFWterA==
X-Gm-Gg: Acq92OH7v5+bcfzGi1VF6POPDA/x0iJSHrb33qJLRffLgaOuWbbVEzsWcq77DslPzmw
 Y7RO7C1e2JmBbAf4OMebgrzDkKRwWV0XO0X2VAclT/j5bnXOVykUvKb6VbuUkeyKXx95Np9GZii
 aLFbDRQW5vClGDCdqUYGVjhU4gT4QuKTOUX57lXu34QqNgDVjDm1oVLj+X2z0eP1qfGBmnbNfmZ
 B1MbX4dNP36azNuaEiRnIHvcCm0d9gTlWMdjLHi+pSAUc12+rxQNEyAkk5faAoedmKFiCazRyKd
 uXMfq3w8HD4x+FT5YzS1hra6OOMI5GXLZRC0sGUXnjZPOTi1MchY64z4U4Z1xllQMStuf8WFhrV
 QQC9/iK/rCJH/1jxdkzlpSHgANEty7PYi8GjSPwGoFv8Umv9C4LTElFZQMGc/jALpSKr9KN/Fyo
 KTOtXuBiW6TOVcCt2Ptd9a0xkh
X-Received: by 2002:a05:7022:401:b0:137:6781:7dbf with SMTP id
 a92af1059eb24-137a85a69fbmr151311c88.26.1779996280254; 
 Thu, 28 May 2026 12:24:40 -0700 (PDT)
X-Received: by 2002:a05:7022:401:b0:137:6781:7dbf with SMTP id
 a92af1059eb24-137a85a69fbmr151289c88.26.1779996279674; 
 Thu, 28 May 2026 12:24:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137a948b649sm189537c88.2.2026.05.28.12.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:24:39 -0700 (PDT)
Message-ID: <10295a6c-dd6b-4667-a965-ac11330e5050@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:24:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] target/riscv: Remove target_ulong use in
 get_physical_address()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a189679 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=cHXQlWIOJ8E7GuOkS0AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: pBiEXLPFHURNnioBHjcB6M5Yi7ls16V4
X-Proofpoint-ORIG-GUID: pBiEXLPFHURNnioBHjcB6M5Yi7ls16V4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5NSBTYWx0ZWRfX1AG3xqSlw/A7
 UdLl/R/r6qc24eDRujUh3DRhcBbD1PPTsyY3AcP87yWJCyTLi9cIy0hbQBGQX6DcS69QujLfZ0f
 LYBP6LM3J89EQmTQ//omD8CgFovhWez12H0W96VugNq1Dw1yVjPceOwC54TCZLHPQC7yU3yvpQO
 vaWWg25NsAqCTPOoJURsTRHzz+AbbJoDkS3GJflFOfr8EC/b289BheC94bIxPtyOCOUZvDTQGOh
 F1iQuQxKdC1PHsetVTcIwocwhtuUutKNu39DYrssaCuv9MPAMV3XdppbmZFWL+p/BAD4syqfeGD
 0JY6l9sc8t4YZZ/d21zsUhXE93mOVTmDZwRMG2wvNfAQlTKEW2n+ZySDIXKKh5ggW9M35Ca8PIh
 sE02UxRPvZlW+IcYYi3kCJQfGT9PWijtOv1o851YZljFexyD2SXkHlwDIxb47uV6TIm60ZVYlmZ
 LTdL2lTxnizKWgDz+Vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280195
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> Use uint32_t for RV32, uint64_t otherwise.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/cpu_helper.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

