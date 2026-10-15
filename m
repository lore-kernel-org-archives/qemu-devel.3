Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3E4CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT7Q-00019f-6s; Thu, 15 Oct 2026 17:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT6w-0000oj-NP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:35:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT6u-0002rg-RY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:35:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FGCA8g1596370
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5GqWkY/UCoPsB6o153SFAmhAMSyGqNp1FGTUPfpFILE=; b=UbIpsb0f231BuWEg
 wK1LDdCNEd8HPN/HPb3Mf2qcpCUxiX+M1KA1ch5KygAxN+J4+7BqRVFzbRzruJZz
 MseZsxl5GwJksw5HtGBlX+Lk86K9t1SP7ZTxhk3rLKAxfPH8KCqLaQXJ8bRrdB7Q
 dv3y2hNN4lElJ5v6U+r6PGBUj98fLkgkRnI8nqD5PfLvIpTHKfQwd2WtJZ1LBfje
 4r8MNQZQidYYew+IY34Fnoi2cLZu8QdkjTLM8mywpLQr32U7/nbqV0PJZ+Gy8wUK
 Sv58z32GjzbOQMdxwm+79a8G+omOjgERKX86NIAb5jtWbGG8ZncvP/8FIa15jCCg
 QkTyvw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2vahhs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:35:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so16010357eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792100134; x=1792704934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5GqWkY/UCoPsB6o153SFAmhAMSyGqNp1FGTUPfpFILE=;
 b=MT2PbDIfFW2xyHIRH//Ji/MDCLDxW8RKQk0CsxXTILPcpZ75OdJEZvcs7iGkPzeO1P
 sLp72S0pMmdwvluzUmGGSoe1BrLDtQSPXRK+vulRgJds4pffpBu0MUQrU2ooScGAyKIt
 4grKaHD96f8Bz0N/aFS/xhREORdKGVW2diedMiHIzd4yBUUxTZwvG8ozFdsVCwmLeXsj
 ssHxQuEZN/0HunPTygMBmtI0rjkvO8yebogB27++k7O1cOR1GthDojnVnwJHzZvv5lb+
 8oI/KRIB5jJ+wDCH/b51gui8SFJRE3UwkhijklKhy7/IHEx3K3VmNGP4L6XF9yjyQ477
 q5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792100134; x=1792704934;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5GqWkY/UCoPsB6o153SFAmhAMSyGqNp1FGTUPfpFILE=;
 b=NsWohkmBRwsjVBiE+ZLhar27cOXYHeXWJEJ/NfE8+MYS0Ws3/Ok8yCAEWTVGozKmJM
 rOQoI8kwkNOdDDyRfyQu2sKPpEODaWDC1r/ze3Bri92yjZRmWvU9SR3ppO1oIt0GsZZi
 +oNKw4oCFtICYoynhth0EkkhtrCg/SYh0YfRfsWP83gU1gqubZMv9dEyefYd4ikqeVQd
 yavaVNMg/wCoMiTPXAX3aIpmb5H93R8Oy/Y4K/9NJeJrv3kgr6tJrWfyygIJGZjcgbOs
 VAj+S72wD5UUg38SU/rFu6mM+t39up5vf0T0NyZxquP6toIlTb64u6YuGFwJJUnbCxpX
 vuXQ==
X-Gm-Message-State: AFq9FYK9E90qBOXwBDN5r//XdePW1xifHzzgBo8yqIgGb6tGg89AM2Sc
 wKhjvvAFsS3v6p5E2RepuOkPHl3d0UAT1VIGukxTqmDA3VM/krYJiRDE3hYs19pKuB/owkIbHUn
 U4XThYlQqWPS6kDNyibvTOlNXXiWssqiM13bUZsjP5VwCKktl6f+8Gv6bdA==
X-Gm-Gg: AYBFou3qFEo8dfMlJRLDdfE2DfBzCcBKGzMe21F88Oz+o7pOWrZBWvsRknReSCnITYw
 XHDlEZOKvglFoCffy/WBYoTTpx3JSk1KCa6Iu0HAn3X1CpWkYmzvRI5qEgm8chT0DLZTn1mlI6w
 KcZnbEy351cycT+1HVXPSnKKPWjzTbqd703vZ18Su81y1nBbMOt6GMDrk+0OjXw4SpPx1aA/3md
 Ps1LspZErp2PMXOSbosU1srBKGnacn9bSevTk718qv00JZmx6ngR3Cpp3xhttihl8SwRPeqCN9w
 yvejNQXrmShn6mux+Ay5z9QaImeTgDc83nOLaKeR45odGDFnwdwug4+wa36kibCOrfkhebx+gJ8
 Krxk5Dd86T+jfTPHeJ6S4DlzWrSoOgoG7pUPbOHXjbarejj6N4xv/r6j5o4EAqrEXqGKeJg==
X-Received: by 2002:a05:7022:297:20b0:14a:8df8:56b1 with SMTP id
 a92af1059eb24-16a5ef28a5bmr25001213c88.22.1792100134217; 
 Thu, 15 Oct 2026 14:35:34 -0700 (PDT)
X-Received: by 2002:a05:7022:297:20b0:14a:8df8:56b1 with SMTP id
 a92af1059eb24-16a5ef28a5bmr25001161c88.22.1792100133352; 
 Thu, 15 Oct 2026 14:35:33 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm883073eec.28.2026.10.15.14.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 14:35:32 -0700 (PDT)
Message-ID: <0da30178-9095-454f-a67c-9db3608dbef5@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 14:35:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] multi-target: remove dump functions duplication
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
 <atCWOW9cDfUFky13@hive.localdomain>
 <f6484b36-7ef5-480c-8a96-a3b38e60f977@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f6484b36-7ef5-480c-8a96-a3b38e60f977@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NiBTYWx0ZWRfX5fzqVa026lZI
 0aBeK4arUo51J7ZdjhT3B8+RZsCd0qvVYRC7eY7gYcRhBmDrhwXc8JX0Jc43EmV6YiBbIc0eLFR
 hs+hrRmHsvVbTTR6ZArBOn3ogXKzN8gJX7dgmlzwSn/hOLREsXLRQgjIFjYXfIpBEj+CJzAyArU
 3NICO3GHWsDgQJtjJphYgF5ztIwoqwV9xhZn8geG91RXIZUAriSFcHq1M32VXq+6LOPA0r7QN0n
 s+zQbBOdCq21wxQoaM7Bs15hn6mvuc3/yf8ZH67KDG2Lj2HuY2nYlwT+e2PwOFDZencfDANs088
 WqKumMFy9E0UpkiDEFNZtj9XnNrYXLreb2VxRPpCXhuZB4lhrAMgR0fMbTjwDDT+MnKxUpWyXQ2
 /TFSZV4eyS/PoiQAOk5b6pqyj30efhSuJQP2pmECSJXOLyYkx4TcES+PvL0NinmAR37xI75iAWY
 CWrMezYBbNzQ2R4UKeQ==
X-Proofpoint-ORIG-GUID: gDevKrWLBqWHTbjUIIXM_ZWrSyJhiweE
X-Proofpoint-GUID: gDevKrWLBqWHTbjUIIXM_ZWrSyJhiweE
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad14727 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9jyebKX2tan04QQGZXwA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NiBTYWx0ZWRfX9xoAZ11ulwLz
 9GP1bi04OJZvK+HgoptCyotunyilfIXzB3bbcU7oDRmIuJYCEZMHsNktekmP25+5PKxkAguBq10
 6lKndTJLFbeksTOwywST9DbNk6Z719w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150086
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

On 10/15/2026 10:51 AM, Pierrick Bouvier wrote:
> On 10/15/2026 2:08 AM, Anton Johansson wrote:
>> On 15/10/26, Pierrick Bouvier wrote:
>>> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
>>> target. For this, we define a new set of Dump operations for a given cpu, and
>>> implement it per target.
>>>
>>> Existing implementations were using first_cpu, which is what we continue to do.
>>> When we'll work on heterogeneous later, we can revisit this to either forbid a
>>> dump, or perform a dump for each target active.
>>>
>>> Based-on: 20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com
>>> "[PATCH v3 00/12] multi-target: add hexagon"
>>> This base is only needed due to conflicts with current wip, it's not important
>>> for this series implementation.
>>
>> I have a very similar series going locally here
>>
>>   https://gitlab.com/AntonJohansson/qemu/-/commits/b4/arch-dump
>>
>> where I added get_dump_info()/get_note_size() to SysemuCPUOps given
>> that we already have write_elf[32|64]_note() there.  Any reason it would
>> be preferable to have a new struct of function pointers?
>>
>> Also I saw some uses of first_cpu in the write_elf[32|64]_note()
>> functions on i386 at least that we should eliminate.
>>
> 
> It didn't cross my mind to be honest, but taking a look, yes it seems
> like a good place to hold this. It even has monitor related content
> already. I'll respin current series with this.
>

Sent v2:
https://lore.kernel.org/qemu-devel/20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

