Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C2DC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9F8D-0002Kf-Kh; Wed, 23 Sep 2026 01:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9F8C-0002KX-Ky
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:02:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9F8A-0002hc-RZ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:02:56 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N3qvCA2389867
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kMMlcsjznAZnnNv83ZLOTX7pLOpxJtppfAcl/QXHTio=; b=KTqmHiiLWPNNDRxs
 1kvOknkexTGsoMBKPg5wDZG7a/OVc8BQ41/Uqcjyp6QJQ47nxBDxwderyA2pQxR1
 OD5YYzmj2iJrOBhfpUjA+CBQZrVj6NzIB61l35UDf4Y3aLv59owvfO5CfLbtdty+
 Gx3Iv2aFSaps7O5xSbvFbZ5VP7+n02FqyYEVtJhq4kadKqusNwL8fwWtumfbufXa
 OE3D5SZH/9fYuJ5Wpfx72u8+UWS2bRD0SzjouW4cOg4n4LTMzWZeZ/Wk5Bsw1jQE
 hV/Cw0IpkZk98uszxlBXYm3bdiLwTyX9k+SH5/Vvl8wLMOFx7pxDiJlIt1pd05RD
 irr0Eg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv78n0735-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:02:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93918756165so116199585a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 22:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790139773; x=1790744573; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kMMlcsjznAZnnNv83ZLOTX7pLOpxJtppfAcl/QXHTio=;
 b=gQmXhyehD0MeenZ0QNSnsLUgceUkAtNABQzbDG8S2QF3dwopVxRG2Yedcy5NEU0+ml
 LIRyXQ1PyaQTM1KV7QQhIdLwD1qw6Rmcnnk125OCj9grBAwrNek31fGuRNyrcRWtbbZJ
 76JaQKjKoQr015Hbaikj60hBPXNcd5QsAqxTA4bd/By+LIN6uHqW5GIDedsZmDW//Gw9
 IFpFnc414R1k+PTiln0/aHutJ0rcKe7Q/+AoogQEsi6jV2mV2ZlfSGEP6W5q97rXDHco
 YIwtO9azXo+UUOFHvx7zM8t5XWAHtyGpGmjC1TZj9K/nv7WcT7DCpR/72RRhOYxVKg9f
 9mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790139773; x=1790744573;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kMMlcsjznAZnnNv83ZLOTX7pLOpxJtppfAcl/QXHTio=;
 b=DgFhT1ETVIcipLdTi0NCnh9f0I4LSI0ufD85i9bn3WTD39F4afOhG2jAsFf1K4id8A
 PfIAcsz2Xr7Uwv5Fv88n77Eb7qwB6nzyomvrnTr/fPicC68jppOXTnpdEfkb5YrgkGwX
 91pk95+5b456Jpp6OV9ObCdXYzZ5KMQGDISX0FF860IlsQlQMn6QfJIOldxrQlEwaSF5
 DUJG01fbUoxuRG7NHNK2SigeyM7ylvZZvlsGKY5Kva4n/tsRmSkI74x1j6QhRhUZdu1D
 4tCYpg/kU3lZVhlJSXzTWW7PWY/+MKkvHN0IhehJRhx8Os+noTS5jAkcvzJJ8x3WPXYU
 SFnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzY6Uwj1541SEcv3ESLqp2QSt6k+tNEkBAHfgd1Cj6shKXLbOfIW2o4sHzRwWlUNAo/basqplNom3yW@nongnu.org
X-Gm-Message-State: AFuF++kBMkaTJmB5HY4/D+NMr5vSgFtCu2enhuP/ubUelj4zwdnNbDrm
 Bb0f+JTV5CjJpaWtiJl0Iw0Bwm8tSxZmCLYO3xIux8y0lCzSnUltbkV6Utk/zyuEg5jsFX5+R2F
 fluhijqboonBqyrQz08el0ZZm2lozJeSTniTEBwGUUWamRH53rF8T0SCFUg==
X-Gm-Gg: AYBFou3Zirs4beh9ea8PnisLfz4hufnYsw13KlU0NUOV8cvvDa+YIhrmK3HyJD0qd6e
 7n92wJqQdM38y/+CsxbkjbS2lvQRy0hXWnhG7872Kwy98d9Xc5wSdDLEdGOes/TBDL4ux96cG5j
 yDVkKz01jVYQ79HOa9WFQCgK4l6o8FlNu2KzUJ6NCFGfT0dQ1zwlWLgLJcKMAdpjqkT6ZTe7sdS
 Eppprh/q0+HrF63h3P7T24J8joVcKim+dZux56tQWiI8l9qoK5/KHZyn2MTa5KJO7lvkEvmj39y
 +QE1iDFGzJsiC1xHn7KO1SVFiTGrXewogZG7MG+HEs+yzZuK08WjRV28NsEACujpLI8dVX1ls2j
 LqsfFrxsbTjNbox7MXIjL16W5aABcQ/LFDg==
X-Received: by 2002:a05:620a:4006:b0:93c:23c0:c2b8 with SMTP id
 af79cd13be357-93c250a8f1amr265734385a.7.1790139773198; 
 Tue, 22 Sep 2026 22:02:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4006:b0:93c:23c0:c2b8 with SMTP id
 af79cd13be357-93c250a8f1amr265732085a.7.1790139772815; 
 Tue, 22 Sep 2026 22:02:52 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1ccb90sm46737955e9.6.2026.09.22.22.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 22:02:52 -0700 (PDT)
Message-ID: <8df74407-389e-4222-9e2a-70f0b3a5990a@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 07:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] linux-user/sh4: align the vdso sigreturn trampolines
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260923013700.1505113-1-mattst88@gmail.com>
 <20260923013700.1505113-4-mattst88@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923013700.1505113-4-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxOSBTYWx0ZWRfX4Kny+/le+xxn
 fuobel3ABQH3QOE2oRJPbgI1aVN+V6zHEDdue6KlhnUmX6OM+fRilJIk7nYPJLpdaVzmeK5okK9
 66rvVDKfOKIRAUHp5kJJMRAbBsK95uQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxOSBTYWx0ZWRfX7SeVaJQpToD4
 /sZ+PNkY+SgtHCyGgyLqXgCpPH9Bf4h+YiyZc0sUab4ZU+cAkI63HuNkL3Gy9H184fhttHY8WN5
 esds9bsIm5t9QTHhpQ9d76ReQDrqwH/QcylU6PAWJFEok34kA1nrSUxyShrmEHNiEqyVMTpMJi4
 ddTddO7uhlSria/KBvygRqyhYMqL+GhtHLFMeTNeOars79dCmK9+npihfSYo1fj3+plekoMmWAZ
 Vx4hO4O0asu8k2lndNHQIM89hh500ofG5SiGplMZ8U32hJ5YuPBR147XOvxcTvB7Hhhiit/ZftV
 iLC1v7ZXjKrqIMxKcyTooMWCLw/HjhyUU8Dq7fQNwxcbRAFjfVTJVQD8ph6YxkLu64YPpXXUC4A
 p6/+NwR7RNIRVl8FklJVCdizlskw5pG/JiOaXtSORs3QO30x/UK0mkhlgMBT/XyQDy14V6AOL8X
 fsXeMMz1pR70Jo1omSw==
X-Proofpoint-ORIG-GUID: da4kD8LwCH3H6v_tuG7CmdhPuY0uE-i6
X-Authority-Analysis: v=2.4 cv=aNFlOr9m c=1 sm=1 tr=0 ts=6ab35d7d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: da4kD8LwCH3H6v_tuG7CmdhPuY0uE-i6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230019
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

On 23/9/26 03:37, Matt Turner wrote:
> libunwind's unw_is_signal_frame() reads the trampoline as 32-bit words,
> but __kernel_sigreturn is only 2-byte aligned. Align both trampolines
> to 4 bytes, as the kernel's vsyscall-sigreturn.S does (with .balign 32).
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/sh4/vdso-be.so | Bin 2720 -> 2724 bytes
>   linux-user/sh4/vdso-le.so | Bin 2720 -> 2724 bytes
>   linux-user/sh4/vdso.S     |   2 ++
>   3 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

