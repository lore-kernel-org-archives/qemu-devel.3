Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358A1C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvbxZ-000597-FJ; Sun, 16 Aug 2026 10:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvbxS-00058d-1Q
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:35:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvbxQ-0007nT-JL
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:35:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl00v3631495
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m3zwR/TJEOs3dEbVHgfyAQVCRx1mcXDBj5TSh6kfhsM=; b=o2ov+7BnIaNAPya+
 O++DLdtdif3lI2vK29e7cn0m8SaB5R4G5E2UsklUCDdn5Pid4gLPi6cMHvmG5clW
 ZFvG0+ECIpOFRgc4ZU+OlZjUwmpmMuCQaQ5NRtHPBOG8hOCOUOJGXZtTD28LNO0B
 1O6rViAVppEXnvw84jDutn7zRQsPZmge1JZLSJmQCMr27X0HLLjQzrt+1CI+oJn0
 avdtFzW+446FOoy03k2UheZwTUbT62nCjfU+0pkT5veZ3XJ+4T/QnqWFZQXKEysi
 A8F6DZeGlrx5VcL49ad1AsjqJOrGxkv4F4z4v2zlyoJquuIPgypcPa9MDpmnxd1z
 53Rcgw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghekpe8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:35:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934979ee9f1so321496285a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786890926; x=1787495726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m3zwR/TJEOs3dEbVHgfyAQVCRx1mcXDBj5TSh6kfhsM=;
 b=knweulEVDE+cI3t/J4H+YU3IeIBQtcmZQLIQFH+Dx2mb2VypGSnc5xE3c4XmnpHXCr
 TVmxyp13ZT4xNshUHoZvw7oLWfJ/C8dgqXsF6mOtzTuvYvdi8EOVslsl0jvzurNqw7W6
 mLrZMLAe5iF10wHHOGmjI2rehjWBI9IXLOVC2wh0I99LTZqWmnrQrqR0wmmwW5ZpxvlN
 5pUZ+qnwiS3g5B6HH0Xrn8sO7G789rTkgqHfK8zOM3r4bqbSV0v5LMIpuL8gpMr9KTMF
 o10byqWJhxx46j/xugAiDb3dp/cMdZrNzXYEF6MYVMIZTAnEqRXkf1/c7mWUjy0lElrV
 S6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786890926; x=1787495726;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m3zwR/TJEOs3dEbVHgfyAQVCRx1mcXDBj5TSh6kfhsM=;
 b=ivI6+C5AeHszEp4226TJObgpaHyWm+fvxBLfIQMRunmltlzy7xA1bWAdskC2jJS+ke
 t4HYH8JKuMagr3ElLGKZSh/hI2FbCvwSVSHIUkjRndiGb+REwqDAIUd9uqakhesrtx4O
 qq0krK9awPVm/BQsDpnq/vpkAcV8uJycV5B4vIhDriQXvM+mzC3zIUmJ8EAFTuwDkcHM
 GUu1Fl11B62hVqG7bfX223586An22cm9A1otTf3gGcH5Cc7aX1cDHrrj22BTzB8XlX6u
 qtlzhoHk4SkguEcpL6ynLFd2yJtPj2yV2qeJL3uv/iZ7wLiro/CIJ/TktWeXkj/Vjmn1
 jLMw==
X-Gm-Message-State: AOJu0Yz+RnCSiq9NEK5mvuZDjMqAFIHaHNEJkvsK+7zgfYcmdjq3eRmN
 1Xe72rEkPtXSr79Eb+pD8IInuQXbAAlJdzezrPcMz0cdKksFMU72ZCLncH1SMfQyB2pxZgOnux/
 GgjD770EgD+OAJMsA+lQ5GfHyEyYH5Ehfi93Xqkenav/kJ5h5A1cYMuUtgA==
X-Gm-Gg: AR+sD13k9k07gg+B9vPkxOHYjr1q7ewQV54kF+tze48ybJxTSgvB9I/B34Bse5k3y7x
 Fl8qD80FUScPprChDDgkmARBNv4Kw7i6gEMbl8snRqJWrif0oDmeQX9CpzM0uXi2cZHBrqf4Uyo
 sSxusEFIj4jg9jF28bAmN4RErU1zej1dZ0he/mkJt+ELtl30VdBedD0ZSzqh1hHI7ExzLqdI2v0
 y36n/88TJyGDSLbYnMgv+V7ouE3LXEzx2hIb35UnarI7EEXePDTYAnEiGtKrLpslIR1ecf12Bva
 FO2UkpUHQRlMdwQg5i/P7VoXS04j+AgbzTq1MGL+T1APeF3v/P5H25P5j5pJS40R2IZbjkGHgOL
 fWcKsOKou7QFVcfFcnrpXuLZhu2lhkCbqnRA=
X-Received: by 2002:a05:620a:2725:b0:932:dbf6:6f9 with SMTP id
 af79cd13be357-936d1fd98d1mr2086646185a.9.1786890926488; 
 Sun, 16 Aug 2026 07:35:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2725:b0:932:dbf6:6f9 with SMTP id
 af79cd13be357-936d1fd98d1mr2086640585a.9.1786890926046; 
 Sun, 16 Aug 2026 07:35:26 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499960988c6sm60144095e9.0.2026.08.16.07.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 07:35:25 -0700 (PDT)
Message-ID: <859c52d6-99b0-41d4-8281-9a974bbcc001@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 16:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/23] monitor: Rename MonitorQMP @mon -> @qmon
Content-Language: en-US
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-18-philmd@oss.qualcomm.com>
 <178660214825.3552881.16834360265143429528.b4-review@b4>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <178660214825.3552881.16834360265143429528.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a81caaf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=zL5O8L741Eh8bfZG1AQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExNiBTYWx0ZWRfX02pt/RtI8b/R
 DP9cHa5PLIBOkjaOVaphu0HEjESsDt0vzvMh4pj9tg7CflEF88WIAsVYkCbGGnnseszFtW4Hcgo
 Yla5TtfzTQUdPA5g5dLX+fDpBFob6W0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExNiBTYWx0ZWRfX25XGLma/ac80
 lIGfY1ZMYSztBlXHS02su9yNi0IXTxfjuh1VOQ61U7su4q37Ite/fI6q+/dyMibyrBhUBMftxu1
 2/f/a4qUXB7tyI5mKCUFdOAGkpmHN8/Jy03RgvT9/vSfSNglTz1vaIYgbCt+Jg1fbDX2iLW0Jgg
 KcuP1TiMVMuzCzhQ58WRhczJVT8Weq//SBQYmql+dIS2OHaytpS+OGh9u6guFI2r2XELKQAxGAB
 psoC8CZ0lZG9DIUCJcYCer407mD7mWT1S61R58qlLsNLl2fQMH+x4G0xlkwr+rpHBjfuSvTD6XE
 kRjQ0RXIbleOpzEqHNLOLm5Eo1ibk9555hIggsjm8kTpi5vTLq7jrOakQ2m/e/uhzpj2iyhR1nL
 e0NKRpvIVCmQBH9liOrUtu5Id7MLxxoinXDf+3a2uMV+oL6WkqjwaTpGerqxelClAbQNq+8Yu7K
 +k3l8fRgRkw3Rtg1Esg==
X-Proofpoint-GUID: kPuCT-O8wqSzxqk9Pd11iWnJLHgeQOFS
X-Proofpoint-ORIG-GUID: kPuCT-O8wqSzxqk9Pd11iWnJLHgeQOFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160116
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

On 13/8/26 08:22, marcandre.lureau@redhat.com wrote:
>> Mechanical change to sanitize using the following patterns:
>>
>>    MonitorQMP *qmon  (this patch)
>>    MonitorHMP *hmon  (following one)
>>    Monitor *mon
>>
>> Rename @mon (and @qmp_mon) as @qmon when the type is MonitorQMP.
> 
> This patch and the following are conflicting quite directly with
> the work I have for --disable-hmp.
> (https://gitlab.com/marcandre.lureau/qemu/-/tree/no-hmp)
> 
> Can we delay them?
> 
> fwiw, I picked Monitor *mon, MonitorHMP *hmp. I didn't touch MonitorQMP*.

I'm interpreting that as a Acked-by tag for the patch
20260812211708.92824-19-philmd@oss.qualcomm.com so I'm including
it (after renaming hmon -> hmp as recommended by Daniel).


