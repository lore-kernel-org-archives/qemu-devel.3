Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555B1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZKm-000802-Uu; Tue, 14 Jul 2026 05:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZKl-0007zm-TP
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:21:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZKk-0007Eg-DA
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:21:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SUwY3740548
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OVVbXI8EDXHVHSw+n9cnY8AuMrSuvEBTXoydkLmLhok=; b=cqiIuoIyRrhJRua8
 OcSr4ybpyFHbIrnc3SX2aeIpJpGpsQLcHEC1Tx/KISSuiLwB3PS0/d0oU8oK+KBJ
 WU6+nS64PgBsvUlPNDHZi5T9ggwQFVPrMnaFekAeF2Glc6Gq5W5W3lsmHWkIGI6E
 FU/FlYciJ/Hjr3IGTgh4SZQOgMh6WZYA3C0tmF3JG+oW7nf9P80trGncToJzN9x5
 Cbi9xBu6chc04TQOWN0eDbcRPGHMZR+R2MnSYaok5iBxMIj+Q0bYKgbt9eRz20x8
 w+RLI3/1a5CKZ/hZ5QOlmtfR+0Q58vk51nmdixaJKHbXrVsJV5KpFZ+B1c6uwRfd
 aeDL5g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdde098ws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:21:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d30035dso41668221cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784020904; x=1784625704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OVVbXI8EDXHVHSw+n9cnY8AuMrSuvEBTXoydkLmLhok=;
 b=jig7Po9enkpRZSv2jxI4wsoVy4+JUVSZWsSN2T8w8eOu55PP4+gp/0teWHfEZ7k5JM
 6SUGxwnwmkPLeWcotmfNkmmzE5qtiMOiLNB/Lj883Qr00pr7MXgLMZ0HUa6py8KauxVa
 7pwvGU8vIsm6dDOtPE+oh6+OU7TU96VYUXDXHpVrA1/S10Tc42+i1gtohXCSokilAoQ6
 PEqZ54XCGfAV1vxHCz5ISUZg62sKwHwA/v67o+KW74yf67pDEl4xP3S84GAEjDgKlMr9
 uqaOaZmwC2FJpMD7bBO5/TB/37jlyel1MLUqn8xHgL5lAPs+l9IqW2mgeP0EtEVM1Gs6
 EzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784020904; x=1784625704;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OVVbXI8EDXHVHSw+n9cnY8AuMrSuvEBTXoydkLmLhok=;
 b=TMIfKEtXUbwuzkeTfdQ6sbgDmKV7Er85BA1Xgr5oEXs0STGxPTVh9P00dBbVJbMTdo
 i06cAUDk4UOdGClYvUY63sEGl/+PwFEloE931Gz8H8fCbS0fdfNiCJe6R3gX66GmP90C
 rgh/XyftYA2atI56k3NAXAg+VI34L8gkpwrIaWGxvvdCZhaflrbuJhKgi2LgyTPjrq1c
 cQ3iu8/EjfqEUmGglfemFRCAa7dOYa4avElXLCCF/LfVE0w9oa1haU9fZ3hXq9awg2fQ
 FZnsfgUvWicSypEjI0rruoLd1R037g/dP0/VsXAH/BkLdI22Ra5AV60LInk4H/LWfLjs
 aZig==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHyY36Rd3gwEt8BLdXLAFJYloBrdMfa6/OjE1n7tqjxVxUcGEypq7uq4GvBIR1UX7bTjx1XI0hdU/m@nongnu.org
X-Gm-Message-State: AOJu0Yzvx1d/26F3H9c17u+HT3E+AAIlk/WafcQWBokMzdNMZWjfmfnS
 mpR6TgoNR250ejUTrYP6m9waVr+9L7u5eCHndZyxqTf+geZY/ul/QNBYagYc9OyGdNXzhvHTbN5
 7rluIa4lYJxXexOmjj3DHeWiRPEdgVn2/xWjZyjcKVC2j0nuPiQj+tkXrIeE1TL9Ffg==
X-Gm-Gg: AfdE7cn0v8VfL4FyMcdLgFS5qm9qPfxDNrItrx1+F9SIGTHH4rHQYLgtuMg13qdUfjh
 FLWHGm6kt6winzY3tt1f49pGrWqxNnUt2b4W/MHPH1QOcfiIl+AY+kaTf009XxAwyFYQqCEUUKl
 pMV37kSouP1rRtLY8qGxD+BqlHqsynVeWhEyQDZ4Ngzj4oTJsMn/iKTHJLZaBoSlrYXfYYg9LYc
 emI60ARjcSTeO25TSmYzKyP2vCOpuF9bsZME2V5o7l5vJ3kZJw0WLCt5ylqZaT4ZWi4SBDRm8R8
 hTX0P53FjfI5wWy31ZYHCLGaNAfL8rAza6j8GISNk4caYu5vpsSdR6NkyZ79uaidmrUbojRK5rP
 Idr60sZngGBzaWdPJA1tCbU5CmzgD8zb9Mw9j0YxnjkBqiz3lOsFPsb/WEu2RmA==
X-Received: by 2002:a05:622a:1387:b0:51c:8432:1753 with SMTP id
 d75a77b69052e-51cbf0f6430mr122606851cf.30.1784020904515; 
 Tue, 14 Jul 2026 02:21:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1387:b0:51c:8432:1753 with SMTP id
 d75a77b69052e-51cbf0f6430mr122606711cf.30.1784020904117; 
 Tue, 14 Jul 2026 02:21:44 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508739c99sm56543985e9.9.2026.07.14.02.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:21:43 -0700 (PDT)
Message-ID: <894a9544-8836-4b09-832b-de933a5bad04@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: GICv5 cpuif: Writes to ICC_APR_EL1 can
 change IRQ/FIQ
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260714091806.3568281-1-peter.maydell@linaro.org>
 <20260714091806.3568281-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260714091806.3568281-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5NyBTYWx0ZWRfX2bBxUeVoeUMa
 6tJkaU9Z9GB7+FPweFoEJbfGlLCU2/o3H9n3MkuZaQD8eYJRpxqxKcqqiioaOD75ZmwdX//04Tq
 luUpi4Sw/y7Wrv1adpSEXPSQa1rkKzE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5NyBTYWx0ZWRfX5BCypeOxHHhH
 sujX/pfTY/ECdMFwEK50kzY1udHffyKh4y/7m+tru7/s7ClgoTnJJZxkTcn79fTcXaPBWyhhW3n
 RZ7+CACXB9NEQ/9ejuTDwNKsIXjNmomdQ4NPKFIGMHaje46l9iiz1TIP5l2wkKPk0Ehkn+LxzUv
 +papRv9hbi/L1B2FIISyX1xUhxifhdNSn6dKmfmSuNC82k5lw+YOO4ebVW4FRCKRCPipcdB1ww4
 Vl7IGkOsh2mRD1X3WJV3iRIT9Hzm6mCuYJp/6ME9fPsts8Zn5eFnIgOz9cLDb6Bpe0JEwf+FIsl
 bZTBx6KL3jt2WnItcsBL9IHblOtgIhg5ZSmFYijs9MYWAr5FHf0777pD5D1AJwwPGfKQ8Mkw/QS
 lUWnBgeHBoIRiLRyxvzO9hDGhYWjjc2Hkqcv2n+NWHDNAxLGIzE4CLA4ixXUztZG4MA+ETQCRi9
 rRPyDtxC0hAezviAvrA==
X-Proofpoint-ORIG-GUID: pA7O5BwsYZzSNHNGdM0DY1edbdVcxltW
X-Proofpoint-GUID: pA7O5BwsYZzSNHNGdM0DY1edbdVcxltW
X-Authority-Analysis: v=2.4 cv=F/FnsKhN c=1 sm=1 tr=0 ts=6a55ffa9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9dWPDvEdnF6fiLz_tfUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140097
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

On 14/7/26 11:18, Peter Maydell wrote:
> The ICC_APR_EL1 register values change the current running priority,
> which we use in our calculations in gic_hppi().  Changing them can
> affect whether we have a HPPI, and so the value of the IRQ/FIQ
> outputs.  We need to trigger an update in the register writefn.
> 
> Fixes: 9bd90bddb79 ("target/arm: GICv5 cpuif: Signal IRQ or FIQ")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

