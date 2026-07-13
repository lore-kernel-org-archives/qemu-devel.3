Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DEDC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFVR-0000t8-P5; Mon, 13 Jul 2026 08:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjFVQ-0000qW-8H
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:11:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjFVO-0006eZ-T3
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:11:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9RAlr1123001
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GF1nzRiJdqWJEt6VpXrCC9Dp7BJLUS11lP9x00Lf9es=; b=JRrKhPpb9X4N9Ll9
 0cpLZfiCWIHZZhURaxWRVC4U/iNq96Q5O/Bvy91UNhqs5TH8WdEXA03kTQqlq7DA
 ogIGast/ACPhvEZe0SjhL05UewOziNks8j6J3HKCcylbxkUnVlMX7ucg4Wij9Fo1
 mRyofhnpJ5Awq0y9W7qQkmJUgQZxG7QnCWsfj4yLVTWo8zuFir39nqJSQ5rppa8i
 O8Qgy+0bTe/E4/iInTAlbD9BDsUkhfx+Eiy/E+01HeqYIf5Y9MrlaQdBhd5Ni4SW
 tuRB3Nzg8Crv28ufa+tog/PbTBPE1Ge2n7pzMgPjewTs7B2jMReoAXTl1TI7G/V9
 ticFQQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda0k79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:11:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-904ee4473a8so26268196d6.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783944685; x=1784549485; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GF1nzRiJdqWJEt6VpXrCC9Dp7BJLUS11lP9x00Lf9es=;
 b=krXoG/K1EBbIQ8KqlN+Mt4ysNJehJpD2ghSC9ma/EBftiRwqlQtNW3/OWPJ6Lo949f
 agEebloMm+AXrLxYuDVj9Bck7CiWw9F7GoyacknqWIfUGClU0JVYqUzIGI7wMimZDcw+
 m60YxwTRG3gJj/rsRoVCftYgAs+4ZbA2qJqDuZwkqNvmZxpc9vtJVYuktPCC2rw2VBQe
 YJ/SMelPmjebcjFHTc+OVhJhPnPWa6z7RqHhELecUPqftDQMVAS03ulhInZq1/Rk9wcO
 EqG1MR4gBDIb2ExWJYyeL3gmKHNqN+j/uJkWj1Q/TCh8mzl16Wo0Qzh96lLGuQ9klyTK
 mqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944685; x=1784549485;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GF1nzRiJdqWJEt6VpXrCC9Dp7BJLUS11lP9x00Lf9es=;
 b=dO505PMId9YadbErwoN6R2FD8EuuvOKdTX0lqY5GnNT3DVuSHjH4RCV07+yXdGJmwZ
 h0XJJ4GGDvya1o1KK3y0PYXOqUIUCfK+4TkBORCvhg8Jo/UvpQl3zWWmpRbIWbUOzC0l
 GzV/N/EnUhAyxnRUBodjH+fD8iK7AtnJCMeALTGvbBuleg06uOKrj/yv/R6L4XuoC9Oy
 5sjk4Zzker3+Syo0kbiwYiNVk2CfrjZT/U9n2MNaEw39PFUB8c5/yWefJ6dpj7wDGmax
 5u1rPanhr/yiVKmiHLItMc9BhmViCJBs2OJBlpdD35VTsiZLUIDnqqkQoZe/CrSdr8c5
 GfiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOazhxInb8JC8CR1zCHJTJ3dNmhGRwJaJqPnbnyLs76ZCePCbwl8LBn7IIBiTPI1WCt/9uBs1Ab7/3@nongnu.org
X-Gm-Message-State: AOJu0YxLo+4jhRL4jWLJX5EoaPbCMtybCpMVYaICogUxJpje8c1AFx/Z
 /teF97nSV34hjI8urPAO4Fh2NpjjAU7oxUprJw91CAL5yRhtmhOkUEj7OwtsX1GOcpMOkznwSbe
 0rQZMkqXYMV+6cD3iHoP2ExnrAhf2uaf7x/vVqNcY2ihNQrQW8f6vrmOXJw==
X-Gm-Gg: AfdE7cnjstQj9X1NPQaoNGFCDvRboYHagOt+QGIo6BToqXlH/wuVoaRApst21wrZcvS
 XutHFpvGGJk9yB9SFm4MokduNC+2Fs8Sp5b0Dmpl/KUeHPd0aFfyRlK8Zx7T+721HNYxfQdVrwo
 ptkpi8Hzr+PgvSaaUjfec75SnWs+lZrJXLGLfQcj3GKbqKgg+D4i0oivDNxyk8O6pApPF8zOyw0
 NDnPlkLj+eSjquGbbU8V5pheVDSyXbzA2TB425i03Q8MkBZjWuJZDgUB3BwTSYFTMsLUBporNmV
 JBwX5y8g6PDR77/s8xwRHq5FA77va/kEPbtddwkjrzZpDZdQFKP5riBnvonUUOJiDJyikafIZx1
 peogJuFjoDTbiBdpiUrUDCZurk3SDIwVPxKarWH/MVGhyAZcljFKAfkFMWmynMA==
X-Received: by 2002:a05:622a:5a05:b0:51c:e14:87a7 with SMTP id
 d75a77b69052e-51cbf1628d3mr88398781cf.28.1783944685356; 
 Mon, 13 Jul 2026 05:11:25 -0700 (PDT)
X-Received: by 2002:a05:622a:5a05:b0:51c:e14:87a7 with SMTP id
 d75a77b69052e-51cbf1628d3mr88398531cf.28.1783944684932; 
 Mon, 13 Jul 2026 05:11:24 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3b85sm581267955e9.2.2026.07.13.05.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 05:11:24 -0700 (PDT)
Message-ID: <cff0ca65-ced2-4304-83dd-c2786a2297e0@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/riscv64: sifive_u: Fix kernel command
 line
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org
References: <20260713120245.781959-1-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713120245.781959-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfXwPoz0DWeUOxi
 A8+Rrukhsi7+wv8++H1JJnmdVCpBrKvlKXYr4cqojfMxEzR2vCfGBU0HhGxSjbggPxO67bme693
 wRF+CnYGl/SRwRyue2CrhpgZxm349hA=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a54d5ee cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: ittcGUnOdHxVLwlRQ2XHHxjPk-kCPKbr
X-Proofpoint-ORIG-GUID: ittcGUnOdHxVLwlRQ2XHHxjPk-kCPKbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfX5OwHqKQjX7eM
 uq0S6NIifcaA6pOrrlstRJoTF3fqGhN/hepP3ptjQGgUvM4137f9YLRxlxFJZQOb50TBPYAxsPT
 7rlEY1Vi4Wek17Pt1/vf5jlA6UvC2/s9jB39CW8YUECENPCmcTO1hQreTogwyQ3tyko3KXaBmoV
 HLGbFLH1fOiTH+kfoY/npe+lPKjEmVsXggpD84c6GPYnEpYAcv3L9sHoX5NrqLqlY0WaBQY1ta6
 M/d6DyIt+BMu5KUyztSdfc80CXg8Z3Z1EWwZku6u0Gv2jiHDOSrjYzaniynAH38dZrFHoTugUIA
 w4oqATNTJeMt0xtih83sHiIXF1SJxNuMexDYubMl4MAlZGI7igIPDLj8uihaA6LAoxhtEHRRJ5F
 i4+mltMhqdbi4M60d/RY5TpzqSWgel8rrRsACsesA0uhlpdy/QeS/fZP+ZyqULza3yA0aD3yrGN
 FzT9pYFxNfLSuMqcweA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130127
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

On 13/7/26 14:02, Bin Meng wrote:
> Build the complete kernel command line before adding it to the QEMU
> arguments. This ensures the panic, noreboot and rootwait options are
> passed to the guest.
> 
> Fixes: 7db162fa0138 ("tests/functional: Test SPI-SD adapter without SD card connected")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
>   tests/functional/riscv64/test_sifive_u.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

