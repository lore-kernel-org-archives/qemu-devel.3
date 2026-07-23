Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F06C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmohw-0000wB-Nk; Thu, 23 Jul 2026 04:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmohv-0000vv-75
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:23:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmohs-0005iR-Sp
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:23:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7BaF23372236
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0i6tN9nhJvI9cgoBR+78mBcENYERT2FGX+Xg9uan3yA=; b=EXnXtHAKz+0kwjr/
 h/aeYefaRb30iCaxTzunCnAAf0ipm8ORZT8Km8DqRN3rWDZYdEdfRr3TvnnOn4KP
 Ndt+emDcR39R465DnZEQ0lPDE94pNcNA/jCjl8LFZES9K/Ay/5bgfZgR3Q5idiFo
 pUTvMNxCpxnSxPkgL9VMLp2BMop4AYoDUYqR6eEx2PC805Ir9iwbWsk1xxDuHDsU
 JsaSbMqe26eybCKlqFti4cJVcIu63CxQcRtev5E5QHz2O+aYhfU2bKK57QfChOsN
 ieRDdDVEeOj0hUF50Kktql7M+BrE+XEWAVU/jomK55PWMrAHpdT9+HQUKnM8Gsen
 XorzeQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke7qg9xy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:23:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c083f1818so6351441cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784794983; x=1785399783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0i6tN9nhJvI9cgoBR+78mBcENYERT2FGX+Xg9uan3yA=;
 b=RY4uPCNWwniQ80vh9/x1cqjG5PXsiUBAYlRrd0mEWZcm2yaSRat4JlPj1vZNlHuEwp
 LImwh2lr2dG5LhHSMkONQ/rlUDYrbU3w5kcn9BJE5FsPq4+pV3g/SOx0wGreC1xGKJ8J
 zIabKp1k4vcvdUZZLJAm65NdFruMj+ZOa1NnbzODOJs3urYLu+lM27r8i2l/lYsSoD2e
 FlDvl+wGGR77V3UfjiOC8GqHwoLogwOZZzOZGSyLJ5fDlqInjqbwM9CN3DlYsu3IkUtv
 VdIigJ7HSesJC1GfyfY8GF1rk0urjMj5Nlkvvsny0J+vdcmLMs+uEMeWtbceasWjqQhP
 G5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784794983; x=1785399783;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0i6tN9nhJvI9cgoBR+78mBcENYERT2FGX+Xg9uan3yA=;
 b=HxpJSt8oHfgczRoekvR38P+rokC2XJTGqTIBaHMsWNa7zm4K2q8aBJjWFXlR9Dtb4Q
 OR2Hbyriiz1PNHf45L4wnmgPN6mmV9TQ78c3Mr1V0iATybBrWsI0s46949fQStQcI6x/
 jAA+x7NPdk+05OAReqk2UGbjVdegqKma+UJ6dkQvaXo1aiQYuJkeNRjvxM0pA105y28o
 l4WCNWPcLD3lDBCSz2A4ihj+BLp1mPfSwUmmQeWGa1I0NnLtBXbcUSBM8SSTICKIj+1L
 be6VXuVHfv+XS1MJWBs7aJ/WkFwOPdLJt0h1xF8oFWA7t6YZ7mhuN8QDP1Zhoq6/ywvZ
 forQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2POTBcNiTXscfSyNP/RYdXBSjFK8Uv37VOfY7+d0Htp2BrXRaL2Om/71WcXISUhJm9PKpNPKn5xdj@nongnu.org
X-Gm-Message-State: AOJu0Yxi9yQt0hPs0gzNb9jWmmeFx8Jv7aO3Je3rdFU70rs6HHwisqgC
 GseSeZWfJQkLX8xMNSjeN++K5osLcsFIE88Cd8tTM+AONblHVjRVm/iYx9NIZKAXkp+6/erG/Uy
 vNaCF9AnaxW8EgzzvZEnWExJt1nBLsHiB7lL+BG4S6YfnuMEoKWuDyWCHBQ==
X-Gm-Gg: AR+sD11DBTMmO5lJDPRri2Vk1Y3kk7BhbNeT0qi8AMdgnftHITQhANnneIWV8qW1JNs
 eGP10IyyONX4+tl/I+tdKRJ3AKJhJKjgBquUaFz9aNMnCH8ZDEQ0LokvM1VF4eFVEPOopF3hljs
 cuPoqeT9eqIYkq+FCF6soNhGJKvvgoN1c7dhZFccCPg7W+yJYL7bd21xLi9qMHlR3MppjLgPCxv
 kHb/3i667Ybq6je8wTFEXBbJzonc9k/aV4xDcbxSp9a8P/Zp4OQLK5G0RcLhHWaJxugtmPZjQTl
 avH1R9+Hclr1FW5pYOT8E4xrQa18OU1JOQMImUnVa2KOBpI2B33m7xlV0kFjgUBcHH9gb1ivYj8
 mU38BnKynK+EFjxbCBWL2Ma98ixS2CiQGyBG30tVpbUEKVlfcHKQ=
X-Received: by 2002:a05:622a:138e:b0:51a:8c9b:64a1 with SMTP id
 d75a77b69052e-5283df76796mr16895461cf.69.1784794982806; 
 Thu, 23 Jul 2026 01:23:02 -0700 (PDT)
X-Received: by 2002:a05:622a:138e:b0:51a:8c9b:64a1 with SMTP id
 d75a77b69052e-5283df76796mr16895321cf.69.1784794982304; 
 Thu, 23 Jul 2026 01:23:02 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm12748156f8f.17.2026.07.23.01.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:23:01 -0700 (PDT)
Message-ID: <0d41ea50-c7fa-4fad-b18b-16aaeac1d38a@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/net/can/flexcan: Use mbs[] array for FIFO pop
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723070059.6332-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4MyBTYWx0ZWRfX55btj+CzF3un
 fNZ/Wq+gYN7KJEqJ6zIF4omO/I+Kc6QRHemktQdNlWgwe57GMpJNc/U3bgZW5A2H3GQDnOXA1pM
 3MczvbCHTqeYLBYkMVIvABR9LSlMkqc=
X-Authority-Analysis: v=2.4 cv=aYxRWxot c=1 sm=1 tr=0 ts=6a61cf67 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: usmpSUly3i6qGltQnq08XMicgvljKN30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4MyBTYWx0ZWRfX7FHR1zGEsrAA
 WXovDlxFdAmMPKnNzAs0qJUEq33fae2vSv1FmBcvnH77ONDr/cRS1qPGABqupTl7J6A5enL2p0p
 v60w1ecFqrTk/Zs70B/72ITPK21/LBbHxWworboe7HHfTf8kd+Pp35PQsTYBapmT+i1fjoem0O7
 xSCOX/+pT6bDNJmuwzsNZjp2m5BFJt5TddIB2P2bR+C/KBTp7wsvcjIqstqmMR/inolw076tBuN
 wbGuQrnP8z0eTlghd5A+83+jnM7E1qzqiYoUkeDkPUheSlm4/dtGUoKuIQ7ScR1Z+rrWHmvRmLL
 Rf0QaWEE7hWFBd8zJ8kG8FtmZxIGkRhTFCV62AVkqTc5Ac0tWSesFsUdPMeh0AZX9H2XoQRYGSH
 VrGa5HrTwEM/Xw2PRepigbWLXxzHfAXawL1J/1Oh5qjAaNHGoMYaED36sNN0D63e8f8Z3dBIv3C
 lAlHiybhaxDCAtX1E8Q==
X-Proofpoint-ORIG-GUID: usmpSUly3i6qGltQnq08XMicgvljKN30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230083
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

On 23/7/26 09:00, Bernhard Beschow wrote:
> Implement FIFO entry shifting using the underlying `mbs[]` array instead
> of the overlapping `fifo` union view. This makes it explicit that the
> operation copies within a contiguous mailbox array and avoids Coverity
> CID 1662971.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/net/can/flexcan.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

