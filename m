Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B0BCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHbep-0001qZ-Ks; Fri, 16 Oct 2026 02:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHbei-0001q0-7M
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:43:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHbeg-0006xJ-LG
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:43:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G5rIF04126289
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5UrwwA4visgeAnlu1oveaR4GIF+10bVj+qkaf44z4C0=; b=kY290KWjB45/g8Tp
 kZER+i6/ENNteW6uj78pYV8cyDCSA3RYNHr8vPU12tl4POuZPynTx8ziyOBfGR75
 QCplfKpksb1KDBy9zYf+RnegY7iG7n7MIqArWXx9u4uZqRyEnHDw5vNCGgqSVSad
 4dHbjGSVu2XjTfs0wMleot6V63Lm7L1iBl1hUU9EuZBx471J71u8Nz0pffWCynKn
 fik5ifaMTjWouoYrXEHMZr1Naq7WALbxArgBZe2DthrgXwcNfK4fgq6WoaNamiuK
 Z/f2N04mPcGO1b886BYC5myjgg2+aZp8ZXCfR9WnH/rf+CqZ/zZ2DhukrOTQc+3T
 4it/lA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m34ep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:43:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-89d8630f246so2199754b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792132980; x=1792737780; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5UrwwA4visgeAnlu1oveaR4GIF+10bVj+qkaf44z4C0=;
 b=kpGmP4OxJ3XR8+tH6/OAJVupaSbbBDxK8p6UebIyNGTLiUyDxXKumICLKHvRdrpHGo
 2BBdKuI1uNFXpsdqOE15JCfdpUNSY+Sz/LPQDLD0lJ2sjynay/aYJDJUT+MId5e41YLu
 fjzbFbMeIQT037Lf6ZXQOc73BuKx+velpOcJL6+RVk6LGTLXL2yLYXlkAS086y++KHJY
 fHWJzta8OsNjYXCsh2RNtQJ/SM0UAsIDHprxuivd0WVSf2p0pUHujB5YXNgWW4gXZp6T
 g91wCqj/HxCtVJ0L/vwJsSKT6I/SYrzHrBTfVurnqHvkeENY9j6PFEis9y08jJA9Z2PG
 r1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132980; x=1792737780;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5UrwwA4visgeAnlu1oveaR4GIF+10bVj+qkaf44z4C0=;
 b=ud71M7nLvGWLVNG0X0dVfFgTwNAlYzQVFJzet/refRTIx48ANZ/AJszHtlKtUoqw5b
 pEQ2910FqGmb18KuNysXr3YZXBjsVNUdFy/wUj61c6qiyVOxXrnPXaOKeCh4Db342nmy
 91tOaClDS1nhvxDZhXF9WB/GMek7dY7QDLSSzwb8kKLD8HalX4giRTHBtXdOkLtBApsC
 4STD8OPO6FrxRcSV5MxOYhj+1FTlYRpk717Ouh3VufrwM5W5MqPNt9jW8kWB0yh5of5a
 Iq/9JZThsjfCGVRXzp3OqcKnHFAHsGZh9SWU4xdgtl1KAnFjuxVJQAQBK27sFdptXuzf
 U9Gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoU65aoRO0Yv7Y7x44Y5g0ZhP8YElUaE9TjI1qwpxpcO8zYhtY/OYM0ocxUCmRt+qaDubz4dw2BpoT@nongnu.org
X-Gm-Message-State: AFq9FYIUpqWjVvl/66w4GAfIW/HYyVCBM2TtwmOcmAvuwu2gUnGQbg1V
 QNIWlfzn3DzwMJ6yN3YcmWFfz4+jszHh8AYzO82KT11Ax2Bl0ceGRdbJCJDokGeyix25IVDu9gg
 xRiECDbF+InBydA1N2jrTTpkxFRCC4BgKRBHFh8KI3/vosx0GRxhUFXSzrg==
X-Gm-Gg: AYBFou0RnyXKUo0XD+8nB73vofyhp4s0+3gucbUe+qbCu4GJ3yLzDezjCJe5HENHtvc
 ALhxhJnZotAtoJCoy7hlm4NlYGz/QeBnLOG/JIj72BeFdlMM1TN0Ga2xmbvCSt/ejRh+bim1l7D
 5OaheQOpxTHy1s5yNIkbj5lRSAZ7PSk617nbG45sY4/2drE3Rz1T0raisau9lwoARBnwkJoMY3v
 BbCH8tkqTClgMVuYTJZAPBB+xWG+ky1xMkeoBs1gP+yFxsSYasKa4slBMTmNgCelOzrCX85cfzm
 kgGceuyG9FNFU1gCjBpjdVfscbMeIfUNS0Kg94foPrCqGKv2tT6JCHYXTECh2uV/LItAeZlESDt
 vSKaLe5hmz+WSOAqai6qbtyA/7AduPmTNfeNGta0CC3+tq7pMuhX80aYo
X-Received: by 2002:a05:6a00:7488:b0:899:cd4b:f2d5 with SMTP id
 d2e1a72fcca58-899cd4bf671mr9696792b3a.60.1792132979932; 
 Thu, 15 Oct 2026 23:42:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:7488:b0:899:cd4b:f2d5 with SMTP id
 d2e1a72fcca58-899cd4bf671mr9696777b3a.60.1792132979294; 
 Thu, 15 Oct 2026 23:42:59 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f579479f8sm619646b3a.38.2026.10.15.23.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 23:42:58 -0700 (PDT)
Message-ID: <faa22811-7a04-4077-8e26-b89be0a0c972@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 23:42:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] multi-target: remove dump functions duplication
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <5aa90efa-5bbd-47b2-86d8-8e1552161668@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <5aa90efa-5bbd-47b2-86d8-8e1552161668@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad1c774 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=4Bz2xjKXknpgI_i92Z4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: riFsNUmuRNmaE0I_xaF01nDi9lxvMq-P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfX4iAiEy5GAHQ8
 GSMfA15N8ynT3noQytBNcFFNLPXw50vbPW8GhjfgRiCiLsN864ryKRWP7UYsWlUVMnCzKvuQdH6
 LlzNzfWemtVjJ2V4Kwc6MqV+Ig2Rwns=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfXw1RGrcA/TDuR
 Y0FkvrYH78/OAXurMzd7BhcnIGpIN4WneyVJ0t1d3ajHqA1Kx+m58KsClGod6z47N0J5q7gGaJo
 dfrlsF58TfftgwqSikiwD1hWhhzVxXe/cGUrF+0hh9TZLwg10nzuCehAFTaWOI8eA2Sp5X1Go9o
 U5WuQVVAH0EbHuenJOgJ7eL58yzhPrulak1HHVoy0nuZIMmSxjVOqa6qhsIfztasThv1eXETN/s
 zmrws8ZamJCtSGIsn3x6zJoT9VpxJpPKa6BwW7Z0BTnvAlvXBkCWPRWn2EU7rEkyGNH3XYsiHe9
 QR6+/HuRcvUfV0OP+4u85ir9K4EYjRXZ+ddvc8nc/iiO2wRLjwoMYwBh4Tt6yWoo0V4VYw6pdVy
 CiYt25tyzUr9bH7kK1iPhQlKjXJwvjpy3HaTleL06kFgQXIn+XZvwa3GoK6VpcXKXDmTpuOboLM
 8x169TnNhcgmZfTDX5w==
X-Proofpoint-GUID: riFsNUmuRNmaE0I_xaF01nDi9lxvMq-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160026
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

On 10/15/26 10:59 PM, Philippe Mathieu-Daudé wrote:
> On 15/10/26 23:32, Pierrick Bouvier wrote:
>> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
>> target. For this, we define a new set of Dump operations for a given cpu, and
>> implement it per target.
>>
>> Existing implementations were using first_cpu, which is what we continue to do.
>> When we'll work on heterogeneous later, we can revisit this to either forbid a
>> dump, or perform a dump for each target active.
> 
> Make sense but this must be documented, in the code, and commits
> description.
> 
> Maybe we can self-document adding '#define qemu_heterogeneous() false'
> in a core header and asserting !qemu_heterogeneous() in the dump API?

I can add a new function target_heterogenenous in target_info, which 
returns false for now. And add this check in the if for those dump 
operations, saying it's not supported in this case.

What do you think?

Regards,
Pierrick

