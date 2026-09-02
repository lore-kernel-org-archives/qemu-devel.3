Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E033DC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1s9N-00087c-FA; Wed, 02 Sep 2026 17:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1s9L-00087S-Br
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:05:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1s9J-0008RC-II
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:05:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHiRP2686622
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 21:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3aO5VNxcMfHXFHHBBx2EbRrPGMRqhCT8GtSGJrSfEE8=; b=fzAXamH/IN1AdzjJ
 DXcx6VLbjhbZ8VBAY61j4QnQb+DhPeUJClDCBYYkovut+McEJAgrvSh43XeKVsOf
 7Kntg6gqyzfWa49JvzjOkZbtUpQe3pu4XqsoukfwhNbpLQ357+vO0LPaxzYQKZ0A
 6oPMAg0RsrbhsYLf3uUdcsoJF9EzA2yHea6j3iQUh5XHrQRNU5xbLylG7hP8AlAF
 /j1ndwryMttiiB9UvybWqYgYFgIEqU4Lc31t/YCF9Emge3XGju91Bfg9Ipay96Ho
 yLTjk7L4O1sQ/vh9zrXhItqWRZjbg8ey/XayIFVihiQ+cX6TPoSyL+ehMqn1mUKz
 In66ow==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8aen9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:05:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so302153685a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788383134; x=1788987934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3aO5VNxcMfHXFHHBBx2EbRrPGMRqhCT8GtSGJrSfEE8=;
 b=c8O3VjNJ1xiop9nSxUSXy5WrQlbQrAcUaADKHK5pHmpfWdeDaYOLwuHHEbO7eYC2lj
 2zOZoXfcT3Ic5LHWyBF/FbffGUnyl1sI7is61AYhnGIWw2YhkkpgWd8Jeu8A1tVgGsCl
 DvO+FProwNiozhG+44P4FJTH4jdjmZazGlJX/BAed2HuoixG3nC+MDAt7B3mgVo6Fgbh
 P5r3wZBNXxdi9cXc58nel/j2WW6gZ/A6oBHVGcmnTkuFjTk+AJPJND2f0tpZqBC10jVK
 rJ/8c5fRKxheTpqjqyu1NlNKvR5OEz8k9+8asc8FCIkXh4CTiNdE80NQj1zBRzri2kx9
 5XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788383134; x=1788987934;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3aO5VNxcMfHXFHHBBx2EbRrPGMRqhCT8GtSGJrSfEE8=;
 b=YlpgihEpywrf5gPK5vTwjVO43kD/ilN2veMU1eeGiUpWuFmftZh2bakM7FlaS5zD+I
 yeruF8cmKobVjJzmfix7nV4PB2LVD15bMn3sRRCbRRgJzkVBq0C4hJBQeklhejqL2nax
 ygOyui3qA4OuO8j4smS3Mk4JJYhHmK7Dc0TyFDWzlxIiIAfoLhHw2hLMwqvTvo79x1gd
 kE0JGKFDX0lDbLyfOdksBFxsKNxMvDoSlHMyuohw2+vrQPTBnbu/HRmzDYLHDFI6FVg/
 iDu6m9Di4d/QnuLcllIwK1ojbRPI4WMVHlnvzz44PSuBA/hQyEe2NWnGtwAFX9xrP/vM
 D/FQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZzF/7esWvtGB64+wytKqSNeU3/a0Py3zA9wk49/ep13c+2+DauTGN5qiCBfN9L3dGsGlbXCiRQzdN@nongnu.org
X-Gm-Message-State: AFuF++mqhueqMkfc+veC98I7QelFADzaMqpSHS0fI+XbRxROZaPhEvgB
 MQ9335BGv+1NeNS82XIRvtFkeX3SGfdOiFxty9keLHWFBF/U6FezsYfgzBZnHGp7oZUeAmrb2+T
 Nj+UKLQsPMOq7pVI497sLuLkEJRaIa9+DVBnaex43SAp9Ufl3AYPq5Dr0tw==
X-Gm-Gg: AYBFou3YR+m26wqDAK5PB7uRx8cH3RocN5HKcP/oNlnxW0NnzylYmyFQokm65fD31si
 d+Kjl2aw09L2ZMjAuf5YLrnVWrSO29oIFe0gO8abZA1leavkFlM9z7hywlB9DOw+kaE72IwFWOG
 AgNcXm+RXZ1Urwm9BpR9nObE/4/eJGTG/kevT+L3ZQxWTZ+yRbSP9Mq5/McCkJ0Afis8DwB5bPU
 17mPNR3NBh5+ZQ4ol3w+iiJJXZ5qfM9pOEPVCmmpVGk2AfDbO3QsnsfHgAntsCQmQmLU4VQEWt2
 F2w6OI3RZpKl2irRfHhf4sTIgYlGcjl3Phpz5KYth0+JANqQrQQZfKm7LiFPliLCwN1KfOHMD9+
 tgCnMj6TVDtZHAnAKyK/5y/f/P1BAtht4pw==
X-Received: by 2002:a05:620a:c45:b0:92e:cf8e:67b9 with SMTP id
 af79cd13be357-9396e1bb23cmr243474985a.21.1788383134282; 
 Wed, 02 Sep 2026 14:05:34 -0700 (PDT)
X-Received: by 2002:a05:620a:c45:b0:92e:cf8e:67b9 with SMTP id
 af79cd13be357-9396e1bb23cmr243465985a.21.1788383133757; 
 Wed, 02 Sep 2026 14:05:33 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5563c6csm61515365e9.4.2026.09.02.14.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 14:05:32 -0700 (PDT)
Message-ID: <85ec4cfb-74f2-4b11-bd67-9f61bf064e88@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/hexagon: add OPEN/READ/CLOSE DIR semihosting
 operations
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
References: <810448a08da00bd2e1debaad949cdea5b1cd0059.1788368635.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <810448a08da00bd2e1debaad949cdea5b1cd0059.1788368635.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: c_gR6ay9c1fLw1u1fFA2c2_6fNQBZyXX
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a988f9f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jPjdAFR6Yok1bY0pQpkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfX7FkwfbVIJrBZ
 0UF1FgYypQnGI0pC2gzpkjioZPklN+vNIvlNDLBuolvnjaapjd+2oFqMVjvRyrHX0iR+pXgyznk
 l21dRaqHL3Vnt2pSxCk0U4W4MDR1kAmn5IL1cv3NrvIAi4FqWXnv8VdnonEB5nhRYFGKW+vfQ3g
 7kgIhUXiZCgFK3xbcw/MYn+Ht3inVRUhh5bgYZpF1zvdsjVL+3sLGm2Iof1DYFXQw6c8Ug2+Sp6
 XAA7MCbgRRP0y9Xh2tpubtubPTflrPMbyDFBb7BUZgMeSG+f5/eOJEXQdWnryeaBzjbZyzCDXyY
 VHkVkZ0v/8apqFVb2XhVPX2v77CEcvF3pjMoruEpLKbM07YWiZZNVcJ4gXEqh+t+kkVAfMmef3V
 50XCuD5IixQHg+g7zCtbA+LqwY7XlkvRrzMLUQHrlR9lp29nIhc7HDrJb2/Ke68QQspWFuCL44V
 fijCjFcTBi6chVnjk9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfXxSUY6bmI10Xx
 y8pmf2/QrIYDTmZZb+BHOY+KEbZwTxKDaloq7ni1cyKNy5TKfRSFpMX4k48kU+PIMJRaXzv2PPx
 JluUXap5fFkbnUbBHzBc3gnFLPjmGiA=
X-Proofpoint-ORIG-GUID: c_gR6ay9c1fLw1u1fFA2c2_6fNQBZyXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020186
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

On 2/9/26 19:04, Matheus Tavares Bernardino wrote:
> Baremetal Hexagon programs use semihosting to enumerate host
> directories via OPENDIR, READDIR, and CLOSEDIR calls. The list of
> open directory handles are global to all CPUs, so that guest
> index values map back to host DIR pointers across calls.
> 
> Also add functional tests for the new semihosting ops.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
> v1: https://lore.kernel.org/qemu-devel/9823f67f-bfc6-40e2-ba3e-cb02e53a4004@oss.qualcomm.com/
> 
> Diff from v1: defined the dir_list inside the new HexagonClusterState,
> as suggested by Phil.

Thank you Matheus! QOM/QDev:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
>   hw/hexagon/hex-subsys.c                   | 32 +++++---
>   include/hw/hexagon/hexagon.h              | 14 +++-
>   target/hexagon/hexswi.c                   | 94 +++++++++++++++++++++++
>   tests/functional/hexagon/test_systests.py |  9 +++
>   4 files changed, 137 insertions(+), 12 deletions(-)

