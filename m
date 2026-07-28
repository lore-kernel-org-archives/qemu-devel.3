Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91840C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokLD-00036A-8R; Tue, 28 Jul 2026 12:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokKy-00034p-Ao
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:07:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokKw-00005Y-9q
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:07:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEcqtN3239034
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /kBddwE9A/q+32PbVmaRc7Bba85gNUy44J3/Qjrt1QM=; b=YwVMG4/+obgk6wBn
 Zlr4VBAMJ+AxJDavKZxYHtJnYrgVHqPHWkexBPymujUoOpXrX99j6gGyX7f+1OqC
 MUsLjxfdLvbJtOZ7GsfKpx32X9GF1OnC+91GP+EOrCyXi1Qq9QFmPc9QtSaQQXPn
 Rkj87HWTkhfa17WI7p0pxKUBlACNlCN2MGUT6fc9k3hegPP5bP3rvoRgfdwqFuni
 JDi/OVB7q8OafUVZw760diJJ7/X3LpPfL1rfqWgtED2nyt6QaxRgmtMHIagqxX3k
 OP+3iLfGQtDJ9EP/TdJazoUMVHyMyqHzMDEx5Nt/I9A28GPIxhlvW38oxtMmP/pA
 01J9pw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7m5m1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:07:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso14061cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785254840; x=1785859640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/kBddwE9A/q+32PbVmaRc7Bba85gNUy44J3/Qjrt1QM=;
 b=HvdgMG+znJB+9OO3gcK1n2tR2LGJvWZU0EFVfXaie7+gYj8kYWTjXpMJeR4tKyXzL8
 P1ho+LkNfR17JDjMvNYTccDc8XD3sg2z1Uvylr5wSL1mLdMCAhRw/z574Y1Kqhu9OzIs
 38RnkDSX7GuluL6fbPP7CIBKODhr+DqPxKXmZ9dFg/WS9WHi1243CcVacW4YiVHfzHdy
 1YNw5DZKzC9rKvSZSpSswCkj5f8ByeEkHKRq3Yq32hu54G5PY52MdoPCi2vdJghe+BBS
 YClaK7RSjgf4YLEPkEPpRwE2N3chIZe7zgugjHCdcTYuFKb3zbDrXOeIJ9+97VyId0li
 4ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785254840; x=1785859640;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/kBddwE9A/q+32PbVmaRc7Bba85gNUy44J3/Qjrt1QM=;
 b=QQAWTfAHzf/iRHlaPIRHs7zZHpR2tyKBLesdmTetMN1MvUWUfl9GDsaW8jIBmWgHbc
 1oGxpozih0nHfk/b98LVGGhr2sqn17PUJWPLKoNxW8+PKDA7Ce4ZG0ySAyrLHErYf7GH
 Rx8LOOz4E5x1syaR3tn/6axUSo004FSCcEg1JCpIBaTge1AG6CCqrj3AF0w4GsGmKtwY
 6kG9pVnyaAFuoyUVNA/Gys5cegHGLRyn3MuWrI6LJtsU6Ka/PrQg8CbdZl1YanO+I5L4
 LWt7Zy6oML+RgF4BkMHgUaE9jid6gKLVGgZyV78c1jL9PPPXjAzU03ioa8OGY5zhqggM
 G8EA==
X-Gm-Message-State: AOJu0YyIB86mSW0EOOmZ0Xfhw5DKQG8ATU0/ny7jk6wJFU1Rd4/e6p+x
 cZZqzoWB7Pyf+ibm0gfmfbO12Dm1VMDTid01PiiWWSNutdp2WOBD8j4OkQ9eBiu+uEzxrZzRnL1
 3lCaZb/cHlcoBbNtXr16fvQGOkYPuKiGyVvSBLfWesadhDe3ufJ5AHIVnLw==
X-Gm-Gg: AR+sD10z4ms9xNIVp3CadIe492SUl7qRHtNzYlnrrgFJ1/oh8SIy8mKkDNIPxSRPRoF
 PY2UphfYQ7qeYsKzRfbfKIvyHm/SpV17qUnSvb+3pWm1pXbR7SJXGHJdv0kymdwiN3jLivLWuN9
 Vmv8NLdpTJZZqKrYzF73purVDwUmM9tqkRlRyePfrRiulfakSRbeHkxQwuLH7iG9CwiO3cpTUpG
 4K92XpSNu2m0HhGs9roTQG5HS9IBYyxP2zMro9JkNLlp9sFGqUGc5I9+axPHV+kRg0B9hDzM+3V
 Lz1kDLToS3pp1GWPmj+hMdw/3MyjB/wel25Mc+pgYJETZqd+XTb/XSUdqO38Kw2iq0J68t4ERCL
 uHs8L9731+rmAOlrLn6GJA+Vfpwu/nvusr78tRLF0FJOfPkDA3yI=
X-Received: by 2002:ac8:574f:0:b0:528:601:301e with SMTP id
 d75a77b69052e-529d6feab6bmr26293731cf.26.1785254840103; 
 Tue, 28 Jul 2026 09:07:20 -0700 (PDT)
X-Received: by 2002:ac8:574f:0:b0:528:601:301e with SMTP id
 d75a77b69052e-529d6feab6bmr26292581cf.26.1785254839257; 
 Tue, 28 Jul 2026 09:07:19 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45c297dsm85949285e9.7.2026.07.28.09.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 09:07:18 -0700 (PDT)
Message-ID: <fb08095d-b70b-4565-95dc-a328afc6b04f@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] system/memory: Use memmove() for directly
 accessible regions
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex@shazbot.org, berrange@redhat.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260728031731.286666-1-gshan@redhat.com>
 <20260728031731.286666-2-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728031731.286666-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0MyBTYWx0ZWRfXwHkUfv1iDBFD
 XHN5qjRoGwGJU6YVAY9j/7+prdHOPuN0/lD4im9eUVN1z2g2NCUYAQneSPn/9TTS3Hx9XhilPkv
 /TDjVQ5vfC1AUIithbz5czNm6DDFRuN0D8cQZqb0+2YhE+8UgHg2XQxzkttIOFxk2rMp1fnqShi
 jl2P61YT0kD0h4T1w8sTra4xl0nVJuE6LydDepYSL6F2xoDwRSSh6bw3DuBXdn4cUk+yMQkjILf
 /aRJNcljhwtkNzU7ol34dM/fIBxCWRZxgvKF2Xra/w7rwQOG0bQEVKM4fW/Ni7tiBtJygQ3pbHr
 4pxTY8MqfEFqdC6RerJU6x1DiM26I3nwqBuQvuBkTH/+pihzGWAN2JLc9ywTsOl6wMT7/XNi5JK
 Q/vsR1AkzekPyoPnkd56K7utrFlwJXtjdKvlFiNMj1pPfZIVVK0ooIML2CgAauAitiUS9cfVVbu
 SEm5gGwyaO7ozKiE3cQ==
X-Proofpoint-ORIG-GUID: fJN3c3RaqS0xOJxM3x8fq0OD18kw9tvO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0MyBTYWx0ZWRfXxjDg6Rj7sgHk
 wMGmRnT02BTizBMAV6w0+IE3iJ3crC2i5UdFYymCoYPVdQQduZaIku/ugX0hevYCkJSASYT0AyH
 4itU9eZkOsxhuljLyk2rQJcFMRcsUwA=
X-Proofpoint-GUID: fJN3c3RaqS0xOJxM3x8fq0OD18kw9tvO
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a68d3b8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/7/26 05:17, Gavin Shan wrote:
> Similar to what's done in commit 4a73aee88140 ("softmmu: Use memmove in
> flatview_write_continue"), there are more sites where the overlapping
> source and destination buffer are allowed for the directly accessible
> regions. Use memmove() in those sites, listed as below.
> 
>    hw/remote/vfio-user-obj.c::vfu_object_mr_rw
>    include/system/memory.h::address_space_read
>    system/physmem.c::flatview_read_continue_step
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/remote/vfio-user-obj.c | 4 ++--
>   include/system/memory.h   | 2 +-
>   system/physmem.c          | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

