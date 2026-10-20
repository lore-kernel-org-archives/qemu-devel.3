Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8AA606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P34wyzbn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1veerkg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFZT-0003uW-Uk; Tue, 20 Oct 2026 15:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFZN-0003rx-Hy
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:32:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFZL-0008Mr-QO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:32:21 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI6BtE2079813
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pMvv2TPO2erIWfiQnOuMaRnN2DU8yK4ESSfnOpSyecM=; b=P34wyzbnd7C/6Pop
 b3RTuOsW/nJvFUjFYZy+fnJux8UDz0dP8QHc9wTILUrWfiY4PO4OHIQ0Q2ssQfJW
 fyJQ0/4Sfd31yD7lNcYioFrWtJRxRQuCjofS1aL2pUqrb0bPARPvGjy/EWHnRml+
 GAsjDl3ptdCXP+7lG6XSZykrMfxHf7oBggDf770c/WanCCYaoMTUANS6ep5/cuNQ
 sOS7mTg4viXRbUpCJsA/H/vYOicJMbnKVCMlMR+KVEQQZxnj3sSJ1+GvX4+TSUW0
 QZOTDPVGLcZkKbxcYSz4MwLaKTRC39qBZX2smoUfVxMBWgUowSxg9u2VXPgW61uj
 m9oYrA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hr9yf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:32:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso693368085a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792524737; x=1793129537; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pMvv2TPO2erIWfiQnOuMaRnN2DU8yK4ESSfnOpSyecM=;
 b=S1veerkg/m6Qpo1Xqe2msSrFQ8FsmKNKnCM2X3q67HuTsfT80DMzhZWA4ETgnDHdLq
 9M7sbgzBE9ArvCvnD4sLUiEoMin3xtHKUr3f0kzVDFlkofFXxa4HeVsT0XgxMY6P7l4+
 YCRhNoEGEKVIDgGcHWrfAjRw40O14+r8l7XuFN47YTETfoE35/Qwa8Xh4NdNB3mSTUZx
 JMhr1pkpMsT5FIz0NPbXs9eDRO5V9DD2We5yXA89T0m0phonl1tmydVdyEZvv0vkSDEP
 NVS/3+RGLcbyw9m+zYm3+QpG7yU+mI2wfMRvrUkPV1Q/qXrN4VaX9h8vQAemAllZBgVf
 7BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792524737; x=1793129537;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pMvv2TPO2erIWfiQnOuMaRnN2DU8yK4ESSfnOpSyecM=;
 b=Pl/k0E+ZxC7AC96QjdnRpVEKP6XlVKmN4VriUHU3KcPCR1rnntc03gigvbk1kq6Xzn
 HrpGc/cos2KWcSiFjuWY+FzsPLZThfyqiTDlhVOQQ3kVY+0BVdZcNoAe91FbuwyNDRcs
 rcKIXVgdl0Dtnry3Y4/ydrVDE7Zl9Bii4rQoYu8aSnot4k5oHaC9ZMwS+LBhjs4hiThh
 lC2zbuOlUr0LPzw3qhjUQExMTBy7sjUkgoytsyq3/4tUoetLjoSF0nBedZG18jHA/Mf6
 cIkOUP7E2S4vQhbAkEZO3qW60rhAIcWXV1ztJXlAg0nsg+K8OlFRq7Yb4+XV2ENSIqdf
 Velw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0DgqtJIfLbGn+vQCTtpABpoixsbV7ASOZz3lc9dFweK7R+9THUrQujzQIvHFCy0gVKDdgzZhNhWSu@nongnu.org
X-Gm-Message-State: AFq9FYJkirWJ8vtpg+gSr6dIMjrnivi485fYTNnfmeyxz0xDDfhms8Y0
 uqxuQYxLX/c79JlfmKDOKIgoIS5S1K3I9BY7kF1RbnEForSH87MVb5hDjw9ha1WH6ZsdGjXe5oo
 qJacbH/5uMQk5L42VKx+xoqfeDZlzT3Jlb42Lp0rO3AjPfAWnonlBPSgFgA==
X-Gm-Gg: AYBFou2aLkQ8x4ucKGue8ElLayR8gfkBhC0Pq/IIQh3+7W8p/Dz1LnBbKdNhLFbmVt3
 EU0q+WsSocp7uoRQl9FF6tQpjCBeXS9GEKphc7TpCQT/Wq/xfivJKZ72pbUHycx/N71l05zs0Yg
 dnj3CdU748JBzvPHR0SBFsFA9rAy9rSSjEQAN4caPf6YeuPHHTWjD+vfHuK8633dfCrAYyLAurf
 EChPFN0Bueh7I2bOW5GVsjGMB/Ou1z3UvJvrhbtPl/FQNLkd7xzwiONGOx3He6+k84VJECbZbWd
 M4dtBzkJDM3hpyV4DHpqoH0Axa7BZRb8In4mVJoZZOdU9Pg4mwThLEFCiG6W1It0UOCYhZpP2W4
 pX4LrHXwM1jQ9Z4Ch2YWiy4lmq1J5ZDSMlw==
X-Received: by 2002:a05:620a:6008:b0:93a:83d:1d0e with SMTP id
 af79cd13be357-93f57f53f23mr45203785a.38.1792524736635; 
 Tue, 20 Oct 2026 12:32:16 -0700 (PDT)
X-Received: by 2002:a05:620a:6008:b0:93a:83d:1d0e with SMTP id
 af79cd13be357-93f57f53f23mr45198185a.38.1792524736037; 
 Tue, 20 Oct 2026 12:32:16 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254eeef6sm446889f8f.8.2026.10.20.12.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:32:15 -0700 (PDT)
Message-ID: <8ae7c600-68a1-435f-a44c-73e2547615fd@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 21:32:13 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/sparc: Return CFR when crypto feature is
 enabled
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-3-stian@itx.no>
 <77e977bb-f559-4023-b996-b1ae81cb74cc@oss.qualcomm.com>
 <ccf9cdff5f8775d92501d33373aedc7ba353bd2c.camel@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <ccf9cdff5f8775d92501d33373aedc7ba353bd2c.camel@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad7c1c1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=00RuQkWmShD9ESSqOKcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NyBTYWx0ZWRfXzTHet8CoAfqY
 x4Ex6yTVcNUKJ0AH7Wz+YCKGriBq+elZpdARk4KxQZh0lYFUPwa7hP1AqPfkXYDTnsof6jviX+l
 JryE15KQ5qitw8DdsP935LQzh2U58dY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NyBTYWx0ZWRfX2DBlTeIcn7BL
 5YLuwn7YwCn09Cq48PIrxlScXKrIn+hUpPZ0EBypGfnZ+YfY1IeGnqRyPnHnJFSD0SP3/mJQoyn
 a5plJ3k6Et9BGdNCSKQ2csom5j0QvXAurlGTjxcciN19SEKjHPO8bvhPfKvfdPdjyVGF9LNAbmY
 3zzR1h8YvkCnHpyTn7r567tfI+9ioQPinYytLAviSM3WBTnyc6UcVOuVFWphszBOLgROJgRWdGl
 ElkGlzGNBrWJH/VC+b21wao8OPDZS+Pb1mgVa6mJHfS2gfjpnEnUdElf7IcGirSoZlDzxhbyzo5
 RMeXvf+9ZYr25W1/2uSskWlWuyevo1ZVYSl9n/IuDJOxIxswnqoRcwEfjRgTP0heHtRtFAasqP+
 WoTUQQqkm+vMtKyLn7Ik4w8htH+ANeTpfuF08FZIALviSa21M2c9uxHVry4gm0Uk8Dy1Ll8qLHr
 4RpOgMRFfNTvIOqEdug==
X-Proofpoint-GUID: CsgqC-vl0t4nWivnyGR29aWxJVv09zVR
X-Proofpoint-ORIG-GUID: CsgqC-vl0t4nWivnyGR29aWxJVv09zVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200077
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/26 21:22, Stian Halseth wrote:
> Hi Philippe,
> 
> On Tue, 2026-10-20 at 20:58 +0200, Philippe Mathieu-Daudé wrote:
>> On 20/10/26 16:55, Stian Halseth wrote:
>>> ASR 26 returns a Compatibility Feature Register (CFR) when the
>>> crypto feature is on.  Without the crypto feature, a read keeps
>>> strand status as before.
>>>
>>> Reports AES, SHA1, SHA256, SHA512, CRC32C.
>>
>> IIUC to keep the series bisectable, this patch should be
>> re-ordered *after* the "Add FOO instruction" ones, otherwise:
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>
> 
> Thanks for the review!
> 
> You're right, and I'll move this patch after the instructions patches
> in v2, with your Reviewed-By.

Actually cleaner could be to add an empty CFR here, then enable
the appropriate bit in each patch adding the instruction class
(along with a test).
> 
> I'll hold off v2 for a couple of days to allow more reviewers to
> respond.
> 
> /Stian


