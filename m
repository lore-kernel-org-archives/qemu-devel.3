Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E25C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vha-0006Av-EX; Mon, 31 Aug 2026 02:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vhZ-0006Ai-6E
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:41:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vhX-0004jU-LG
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:41:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52Q3r3678798
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S4f2Sa18KIWMyzv4m8wRpgfg455Gdc/m5bQwshiH9aI=; b=oVc9uvZFJjQnG+Cz
 6QYRRLxxS6yDEw6m5opANs1WFnvBv9BmOVoIs+EW4KRCkk3LGkv5veIBgIFK1J/9
 pf9qwDK++Pmx/ZXDT2MAUb2GHedhSKVdCXAHVCRHwioECe/ghj2WGMKvEjEA2Hlk
 dlfTMqsw6W8rzBjRduCZy40/c8UAs6daIaiLB0vb5uwyaVyA6XYdZKx6qM/akdl7
 TPowKNJerMds9Ygx/DL29GdY9kototx6hFwjfXnmRNswdNrAfEcuOdXXzkqLrH5G
 iJbTTQsXJ2hAq+i4LDO7WghiQbGhuT0mS/WcLLB7vBw2rhxrscl74lRymayNGPUP
 /U7nNQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h1950-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:41:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93903982af1so744566985a.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788158461; x=1788763261; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S4f2Sa18KIWMyzv4m8wRpgfg455Gdc/m5bQwshiH9aI=;
 b=PSm0g0B9zuDAn9Z/5RGRtLPkcnMjOl/NemG/LW41Wp5KrRVKDzNMMT561qz9C7Xcha
 zpAAtc7qD4E6FT0Od5bdRCUKTwObOQr40JDF09qLEIPrcG8GOux1E1MfQS0+nJox1/SU
 b3YbMFw2MKS2yBo9nXuSENHtjtp+j83EiJE/IDYBRirGxlnVuz0hOStT/zfu3gzx65G0
 GZAgmRHmf7I0pDsdLEC5ANET2s28hQcubzL1l2Liqo9oV5i2bSh9hHsR1uX0Qp81jBbc
 R8Qbqx5diapQ+yNI36UdaJJP1a8sjTDUQBJI9vAA2AaYuidAR8G+HdqYAGxEl8sf6aGN
 ylBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788158461; x=1788763261;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S4f2Sa18KIWMyzv4m8wRpgfg455Gdc/m5bQwshiH9aI=;
 b=YERrluYBJ+V3iIL86i1I4pkcVUoNsdJcUvl9KPYWo9apXSRCMoHG90dz3DHYM82Fiu
 7fSKP0zHiVqCxvt/pqIK2lTqQ9es1tPqAtOl7fuYEphHL1Po3jePZYVpSryFfsYySLvN
 ieEA1r9TTeYLPpxQgNwjZEb25G0JpBZfMkuoG2lSBCzv+dvKnjPpYMrw8WC9L5+ifa5T
 GAb3nUmXVbjkFlvgbeaalpPb9fFvNY51laJSCXyxSNzIxs6XuM5F523HVLNyIgYkAxu/
 0igeYtDb37SMAsF/LoMWp2qa5nHMt9oawsEO8lL8kb7VhPlGJoG0nGDibRJQOMKj22GS
 LK9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAHYsbd5GeOFri+P42mRwvbkz4CMe2RIBgRG3+3PFtP0neWKJakA7j8VS7cO8Ahr2NZVuhYYyfxbgz@nongnu.org
X-Gm-Message-State: AFuF++kpsN8oIMrnChTHJaGViBWeCA1SPwqixxe6mrWHJQW20loOmlpU
 l8Po7lRvS13wNE9TigIo8TT+G04b+TKaL/mFdNXPshFoEnKcr24UNoffcVDSo5Ww51RPFldj8vk
 i0Y+ZCZPaOSbzchx+q7w+sA2ScGqHsg7fTfdlI5bYqkHe5qP/1sZetcRKOQ==
X-Gm-Gg: AR+sD10nQkgOkc2PDdAN+xSxGAKolbwYyqOiL73X9Vfg+sEhCGWnW0bC0io6lsfnrh3
 vwmZXlhbD+MiywJz/qi/FbVAyodUnDC91wqpgia0MqyJLs6zgvApFCZNjzmRtDWHlW/+Iai7s/m
 PcU8HQovEU9mNVBe2vMTNhujiCLYayRYMa1iuUTilYNaYuWyLKrzvia9s/tStEJJAFgHOx2YK9O
 Z7gvzwqr9IIntN+Y3LEQGwWnvtUnos67hLeF/xyDG+zfTu8EtFXA8lik0NI/MLQDt4GvM56+RdJ
 9nMh276JzcDwRiQ1wii/NkoyIU4nCC7W0TXdnGjVyfh2cK9EjVJXSrOq+uj5svmihvhpi34zaHT
 Z84QZLO/1FTtX7cEE1b6xS2bg0Wb4tTru4g==
X-Received: by 2002:a05:620a:26d0:b0:938:cd96:501d with SMTP id
 af79cd13be357-939137b468emr2022197185a.4.1788158461200; 
 Sun, 30 Aug 2026 23:41:01 -0700 (PDT)
X-Received: by 2002:a05:620a:26d0:b0:938:cd96:501d with SMTP id
 af79cd13be357-939137b468emr2022195685a.4.1788158460766; 
 Sun, 30 Aug 2026 23:41:00 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b955e7906sm220713145e9.1.2026.08.30.23.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:41:00 -0700 (PDT)
Message-ID: <83ab4fc3-0f47-441f-ba54-12baca1795c8@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/47] target-info: remove machine_typename
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-13-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-13-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a9521fe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=adVaQAAPJtczaq4qYdUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfX33fYBwWU2V8X
 qr/olkWpKg0I7FZq5xMlvzDnq0rRrzwVOAuk2l2002nxMVtNui+2B8nBxnyjdWy4MmFeuHaraUc
 KrroIEERWGPlvVi8jbNUQqBBNbjF9Py4SHdZAQVhRHYY1Wa4vHufx3pZtr2Zw4OeHjUanOqwn4N
 nDkPBX6w42+Lned99Zsbw46I6rzh2oGsjHGDBgFEr8vHMYiFnUHLp5UxRHS9+E1QTOIbToHDR1U
 QUAq7TN6RtcDE8CP93cuLdt+yM/TV4avWIgzx7NTa5GB81Mqr+u/s0pC9H3xbrOMRd6uEO4Kfqs
 fOtwXFt/launJ/Fih1cy0x4yHFx9X+04gu7nWBDtOZPdnnn9Wt945BKOgAOYwnYmA+8ksGZGOys
 /3blveGmohKr7qq2Ou6g2pLOZnj5GeDNoe904nRQnVDjJBK/6FtgpbMaZ387vBrvfTEPX4clZWc
 4hG0HSWOyX9gAWHYphQ==
X-Proofpoint-ORIG-GUID: KEeBlrYi8bwdOqJHLcBJmsESvo7jUqJu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfX/ixpjzdwfY4k
 vvwfxb1+7d9LNqoqn3+/bpxdOo1fhlx6cMdXjUaxMItd1h+447pb5CC91rzgyESyIhD8SG6jER3
 KY0plJ1D1XWOlcDCXFsapmj88SZdut8=
X-Proofpoint-GUID: KEeBlrYi8bwdOqJHLcBJmsESvo7jUqJu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310055
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 29/8/26 00:58, Pierrick Bouvier wrote:
> This field is now unused, so we can remove it.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   configs/targets/aarch64-softmmu.c | 1 -
>   configs/targets/arm-softmmu.c     | 1 -
>   configs/targets/riscv32-softmmu.c | 1 -
>   configs/targets/riscv64-softmmu.c | 1 -
>   include/qemu/target-info-impl.h   | 2 --
>   include/qemu/target-info.h        | 8 --------
>   target-info-stub.c                | 1 -
>   target-info.c                     | 5 -----
>   8 files changed, 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

