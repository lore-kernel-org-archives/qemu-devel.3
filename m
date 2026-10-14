Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A0AC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2cZ-0006Y5-5G; Wed, 14 Oct 2026 13:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2cY-0006Xv-9j
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:18:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2cW-00047k-Ol
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:18:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbNXQ152725
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vpX0ylOfDgKSF4xV1JVT0au+RbBYV1a3KlF6AcjLrcU=; b=nUnc0q+6XiOv5H+n
 92chQEdRxDRyywD3qxPmTgMGeo029JerqZ7XiWIAnMsSEwNmWoNSdBb82Pd8RPxT
 P2XomtWDz2OGRE9s2vYuaB71JXWoefduiY+n29YOvLMmDlG86eooj0k6eRZw5IXM
 AWDCI4v4W2I/zgnze8EWcazp50T4LLtCtB9AdaFpmIaB6o6CZNeXvybNol3JtpHm
 pLcguWNK0f9hV+ukb9dc7q9dsT2HfdbPvvTkLQiFIZ1UCFvCHXKuRUiJg4mZ9pyd
 4FO1vp8p3sQUJsqnYiXSeKCkJesTyAgK7GYPECjS5RvyeqGmWkpGeOhcuHe49xKk
 GLbXiA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aehu8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:18:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so12129651eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791998305; x=1792603105; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vpX0ylOfDgKSF4xV1JVT0au+RbBYV1a3KlF6AcjLrcU=;
 b=GyG8sRxc+KDprzEa0EYCh5fFAE7kKNcgJDjAcJFnC7Kmw8zgfSjQqbWTCkqHCzXvPn
 AkQKRJeeA/8n2J4oej9wwmF356Kn9ZfdtWQr3aPWi8pPvCaH862/XoC0x+QBLgTjhqXX
 DaLzA3t01uugy555rfao2Ec0B5Bux+DpxnlFgP1EvfgP8UUwpyxm/kl9cq5ny6PW17X+
 /1xJRoWo3H8iq2g1WpNnIW62hTftqqCtyKh0Ep9nssdmOUD8XURw8o62xJDVaI0Dls9Z
 Ocb/UhxBmxBinCvcgclO0ihNx6svQzq/8uPNGNEkwGt5iK70bQqJ1Xpy1Q42httzAL/L
 kf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791998305; x=1792603105;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vpX0ylOfDgKSF4xV1JVT0au+RbBYV1a3KlF6AcjLrcU=;
 b=CXFKrMCboJ4q4RpGup9YJxRRVo7JsLwQrarZels/WtIHHowbqYK0XzGbG7rzWykvSy
 cUy74RtMlK3Wpqn98AEMbJ4vd/E77C/m0j0FVW97N+MyalnhLyqHkaX1o2is1ZFttago
 lOHmjmselH9MjK5qYVNS4gMTfglbKgBBOJ+3w/4T/FaDFHeZFIWFa1g2rZFKYGlgB79e
 5Z2nNSk6iNvGFZag0PB3qrjTNtd8k7zkeOaIWFqrSZIJjrMRot4VV0gYiv/GubSXbMeh
 XhDOGyB9HbPULsHqWm0fIrCcuG9MFnq/0p1URVKOJorbLGfzJyD3xy+6nsjobOKZQ+MO
 UqWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2UsxAoke9MEP6ul38HpEhlHT8O9TJlm7a9tTqA9nvBtqY8gnJYMBHHjdHk9+YA6mn6Ug9NZ7bHbYj@nongnu.org
X-Gm-Message-State: AFq9FYJaebS0U0WBQ9fhV5Y/6/VYpj39ZEtM3yF8RTSnVkBj/Z/Wb3l+
 HzRvpgKXKgSaKvjqfhxfKR+tuAUTgBtKgNUfQ9W9WzfYk9YH6O+XKJP32eXGDw/Nrtk9R6+IrS/
 8VFd0W+t8InRi0Hq97/DMRcEP2uNUuKT2lDBDJhR1+cxv0tZlqlhXiTHCfw==
X-Gm-Gg: AYBFou0yT6WKqxW/q9TXYRYD1eyvnCvqoxMN1IMRh/8oWNotcLRz5Cjje/6LppFWisv
 4P8VRrTSXUf/dJnJgDCJ2a6VQ3lXuVxnSLOGNJyTQO0X+av+C8mRjjYGqMsa99dzzhStqVyYUlX
 6dr3sM+p94jwmfoTb/IFMxf1al6mSwH+GgrVgyRA6uIIyzGibECgYWsdcYevxgqutISXNTElfbz
 uPo08mLjkjoouObd0Vct92gWcmRPFFiQULag71drkLKaZKgETL3cwze1re74ZsdmmYPPJQMep7B
 V/8f9aaJ1qDT4cOWfmuVI+jDRWoOLi8CvrNyvQ0yEDniIFf5xteR8Nbmn6uSBhQMXMirPmcoXA5
 8GEerxAJHliBuFqqPPbfMjMdKeKfysB2aooxN49Of5i0AsHHwIwFBR5vgqYzs1AMs4GMV1w==
X-Received: by 2002:a05:701b:2089:20b0:14a:d8fe:33a4 with SMTP id
 a92af1059eb24-16a60de40ffmr24882479c88.38.1791998304751; 
 Wed, 14 Oct 2026 10:18:24 -0700 (PDT)
X-Received: by 2002:a05:701b:2089:20b0:14a:d8fe:33a4 with SMTP id
 a92af1059eb24-16a60de40ffmr24882422c88.38.1791998303956; 
 Wed, 14 Oct 2026 10:18:23 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-17dc865cbffsm11301766c88.6.2026.10.14.10.18.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 10:18:23 -0700 (PDT)
Message-ID: <6d139637-ad42-4429-a405-eea8f384c684@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 10:18:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: mark clock-backed register reads as
 I/O
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009003521.2227155-1-brian.cain@oss.qualcomm.com>
 <20261009003521.2227155-3-brian.cain@oss.qualcomm.com>
 <c7c38763-5cb7-4e4a-b841-5e52b1800b70@oss.qualcomm.com>
 <5a222b51-4475-4301-8e80-a74320329a3f@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5a222b51-4475-4301-8e80-a74320329a3f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9HTd4n8xiyoF8jHffAgqDUtQ29MoABmk
X-Proofpoint-GUID: 9HTd4n8xiyoF8jHffAgqDUtQ29MoABmk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2OCBTYWx0ZWRfXxd8y51mlTp5i
 0AICjhfB95TDB6Yt62LBcvAzbr1mOUcoUE7qELXj0e8aUtbw0J/WShw5ahd8Any+RDNAK/qoLMF
 ccwd+Pg6G+/FWMhvlKm6V5sXHfHGFQ0=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acfb961 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Woy4fUu9eEB1c42lHToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2OCBTYWx0ZWRfX2Az0kKVYMhHu
 Fz2GXCWXTwS9yOy+FgQ+Zctsdxx2Qxam0IFxKQsh0aGj8NzfnBH+wcjfcCZyloVdeYjop1Wyebe
 1ufgtX00+liER7y9Mpk1j4LeTCyY2D+h80Kgzcd2APkzU+t07KZWmISKPYR5Dami6T6Q3o8Fo2g
 CrtwoA564fRxWR3zRCl7gUqSdzX/bDuv61VqNq9MnG49y070TmmvmoBWUkH++ja2lsuL4JdHBZs
 1sTVvhAWVCjz1yOY7rpyRoBDeFYq/3dTGoa/w8rFDptdx/jCn2u/xmoSjmkLgRdLKAeXUideyg8
 12T6PhXIYyqYVF2iqbFU9t8I22ZrTwavQVkLe16SkqwIjgRjVB9AdVthAkkqeJbY9GPg6UoeGrv
 t3Nv2uPnMr2J2W/9H5BbEDZSdxIbZVr1of0H045lqijMwcFRFy/VDVpf3IKSQd9aZhQUrIiX88b
 7R6ZKK9ILpXdo53lFXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140068
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

On 10/13/2026 9:16 PM, Brian Cain wrote:
> 
> On 10/13/2026 5:10 PM, Pierrick Bouvier wrote:
>> On 10/8/2026 5:35 PM, Brian Cain wrote:
>>> Mark scalar and pair reads of *PCYCLE* regs as I/O so icount
>>> synchronizes
>>> before reading.
>>>
>>> Cover the read paths of {U,G}{PCYCLE,TIMER}{LO,HI,} registers.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/gen_tcg_sys.h | 12 ++++++++++--
>>>   target/hexagon/genptr.c      | 30 ++++++++++++++++++++++++++----
>>>   target/hexagon/hex_common.py |  8 ++++----
>>>   3 files changed, 40 insertions(+), 10 deletions(-)
>>>
>> The comment on translator_io_start seems to be out of date.
>> cpu->can_do_io will always be set transitively, and not only for icount.
>> If I understand correctly, calling translator_io_start will simply for
>> effect to end current TB, and start a new one.
>>
>> All that to say that I'm not sure it's needed.
>> Did you find an issue without this?
> 
> IIRC without this change we get a "Bad icount read" when performing the
> I/O side effects of instructions like reading from the cycle/timer
> registers.
>

Fair enough.
Indeed, other arch use the same mechanism for such kind of registers.
I'm not sure about all the details, but makes sense to do the same.

Regards,
Pierrick

