Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93DEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiGuE-0008Nj-DJ; Fri, 10 Jul 2026 15:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiGuC-0008NU-Vn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:29:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiGuB-0006ZA-6O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:29:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH4CJo1262117
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X1mQBirBYGqID9nBEZOotwHvxvefzWg2Jxf4M5K6NgM=; b=jHXhhwkO8Qimezri
 H9sTTrv72jb2rH3hDOFjaz84o7x2dYWusUPR7+PWcV+6PpjerjpRxQMWm5chKVnv
 l0bE1/SsVavuC95I8VHnPBhwg5TNrGPHL9co9P5mW8DHY4OE/LIe+eNflIFfxAm9
 X4IjyubwW3+08gGH4iAB+QGRvAMerO6aBFQ7BxIskd2Zm2KxAIMeWfZTPhEJNx7E
 6Nq9jQWjZCaWO8+0ZK1IqOfSu9ax73yBp0vnV+YbChnSfBo6Ht+M6f5pdyI1dTlc
 r/XC5GkTj0MP0wro+phn00clc0BtgYwFbC3SC5PgprQjxA5LV7ebYyuU37zI3JUR
 aFbKUA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txh1bh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:28:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso13305641cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783711736; x=1784316536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X1mQBirBYGqID9nBEZOotwHvxvefzWg2Jxf4M5K6NgM=;
 b=flrGdT6CRZZ+YsTSBrEkKqDUsssWL29NMtay4rMLmsnbSQ8itd9Gbmloj6AFb4iWl1
 9LotO4gzFHhLk221UsR6nSp2EMAru7YtUo/j8ksEn3xFku25j4vdkLAGKBGH2xFIgO9K
 7fPQzbIQvUGDLYh8hXJXpXb7h8SJXY8OjFNKXQ9Z8zAkqldZcpzfGiaFXJe9Z1dY3YsW
 tgpTE9cFTGTppM/RUG59S6RD4pEwk2ps1bJGClWiGfoNFeHk78qpCqTnCEjkhlwBpSoP
 xyz4KmuMglLTJGgJ4yS1hY035DMS0YN1jqjFBd6IdesExNzsXLyjvH+lW7GRZ33UQ0PP
 hRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783711736; x=1784316536;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X1mQBirBYGqID9nBEZOotwHvxvefzWg2Jxf4M5K6NgM=;
 b=LgjdbhYi3ztwKAqtyhxLn7EOgYUntM1gSIeKdivqCMqokvYAInv7YIPkRbuNDN2vUQ
 LZWOeyCFdw5X01/x8twp3eTcxawfPB6S1s3mcLxPOY2Ts1DBYd6rA3LNVgKjim01Kqe0
 flQlNNT/ZnpVIXyajLgJs2G1Wd2C0nEaXZ8aMERReHDHucGxjNIQ3sAJQOtdcy96iAcx
 Iq/7SFmS08XdJXRq+l29p2Af8Qb95t/v27LwvDxyi5LI/c5jTw+5uk6VSNkHLLYWspmN
 v7ytld61kPL1XgtxRRXaOM1WLCGiIpa/qofTi8EnDjiwCrRR1S9Hw9F69z4K+OwpmcmP
 VRqw==
X-Forwarded-Encrypted: i=1;
 AHgh+RroYDwahelqtAs5rVFl8VofzjET4Kp29IKr07nT1jfjkjCcBCYsH2gJ6z63aQffaXovMqRar9cbLA+I@nongnu.org
X-Gm-Message-State: AOJu0YzmjtJHfi8JRis+jRt4//D+FMmA0RZdF/yDGrzdnYXp8I6RBybc
 g4XdRDu0y8zh10YCgXepD8urDorWVsEQHglOB9xNXOl0w5cCqmJeaITcF4o8Gzte54Z5diNSgx+
 52vCXOXOixZrexlXweh8VeVOkuaCeV7fSlub+Hr/d/WvAdRHry8Tq6Cr9Yw==
X-Gm-Gg: AfdE7clfab/5P8qyn/aqjQQjJWPS15OYu5MP87jInz3sNfdNerEh2XorshY7e926But
 VVFE2Nzk4ZgirteqVvdjdyxDvInKxrrJWzqBdXcurlNbsO2UJspNjEFNnOhQZaIU4XE75Y5qhM3
 IVlr7JqCqtrDitlA89ivtUw2Vmh907FHuaFUB/w9bfJU8g9iNZqND6jkMXC9e1EGSCUBLqM1I+H
 CTrblkY2i+KvInBbedi/1JwF6XvwIoZXaMTq3LCnatZoDWyWkkdYlSYHZMqSFV3tk1npdUpNqbp
 oSQN7jFs/SbuNt4rSPMyFF7a3yUDgy/NMHTebPfOTKoFk8IgMtC5u+5UAU+j8Z9ndzFI/ieU5hj
 4ERkAinwlvE/eklDHMH3ycYwd66P47DkHMLeRLOLZfy0l/OnEiLrjjqeIGUEkbg==
X-Received: by 2002:a05:622a:1f06:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-51caa02c13bmr54091541cf.2.1783711736564; 
 Fri, 10 Jul 2026 12:28:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1f06:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-51caa02c13bmr54088531cf.2.1783711731267; 
 Fri, 10 Jul 2026 12:28:51 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm64718295f8f.2.2026.07.10.12.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 12:28:50 -0700 (PDT)
Message-ID: <296c87a6-55a0-4440-ae42-22fb318dae80@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 21:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/vm: update to FreeBSD 14.4 image
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
References: <20260710105833.84195-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710105833.84195-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a5147f9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6I5d2MoRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: zH2vfk3Jlf_vhZwPuE01yIUSI8tYonf-
X-Proofpoint-GUID: zH2vfk3Jlf_vhZwPuE01yIUSI8tYonf-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5NSBTYWx0ZWRfX5GlpzAkQLLYx
 YObaXCdwmyxIonzpFNyO0DURyz0JJO1S3Tne5w/FZftOftgCyEEbxQH7fNFUssySQsxqxVaZxdr
 Gut27ZC0N5qhLYZgakcK5ujX89pkwVJlMe6Ay/p/7hvzXYIzmIbVnD0lZm8c5iN/gPQlZb5Er/0
 1LAw8CWxyLP07QgmkHzWuflKfI6zBiKHDyV5KVcet/x8eRAv1dHLJP8LNo4Er09EDSAbOtPPPfq
 joROGyvuFrq8rOlbT3EehWXpWOY36tV4tOMFHXFbPaQWHCSqjWvW/sXq5b70oYJyx9IfNUeISqo
 +u3CDK/FqsjGdOnWKIXW5jn4Aq5cwGTlXNKIAe3qZm3mfcIbdUwnpXrWwL63FmHc1tKkNFN4Fm/
 PSy1DpmiI5FQ+xvY0QhzVOCL3uVYYbUuLoxYBOSp7sXpoKLeJgmHWX6azrxFMlN9DvWhi39SCxW
 mgC3TnKyCTZe/YxCJIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5NSBTYWx0ZWRfX6n1/7IumVJo4
 KWCH9Lgo+yI6I5i9zZkuDz0gDA6hMYI0M2i0SC73OWpzwRZ2U0LhGxmh6C2t05HEduDHrmupgt1
 claJZM1vmc6inGa0VQAl1W2tfJsKeSM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100195
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

On 10/7/26 12:58, Daniel P. BerrangÃ© wrote:
> This avoids an interactive prompt that halts execution when
> attempting to run the FreeBSD tests due to outdated 14.3
> base image:
> 
>    `Bootstrapping pkg from pkg+https://pkg.FreeBSD.org/FreeBSD:14:amd64/quarterly, please wait...
>    Verifying signature with trusted certificate pkg.freebsd.org.2013102301... done
>    Installing pkg-2.6.2_1...
>    Newer FreeBSD version for package pkg:
>    To ignore this error set IGNORE_OSVERSION=yes
>    - package: 1404000
>    - running userland: 1403000
>    Ignore the mismatch and continue? [y/N]:
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/vm/freebsd | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

