Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BE0C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuRxz-0004cG-Nc; Thu, 13 Aug 2026 05:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuRxy-0004bv-19
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:43:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuRxw-0002ZT-Gd
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:43:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D92F5C1926687
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 09:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DrK/ai3OsEPf03252eu0Jpwsr5QmfChylm8olBjG6+Y=; b=IWrl8/Q1joe4kvko
 yN3qhKTwfW55n7H0lHWOsY44eTPuNqJM0RjabXghU0yq/cDuWPhko9xNL8I/0P1U
 HsnA76bGZDN3EcD13vMGhdS+ypJl0yHuR5LP/OIZXuyHuuVqOBdEVrVeNmZKFuER
 8DvixnYKjOf/nXCPfDUOYWdCheztN6/UD++7tzswB1Ikw4z5Up6mZuW1MsLm7sjM
 1p+NGbVo3xiQyW2utR/0tq7oCW3QRA8MZSeDGvsEZ5QYC/oirvtXnRhRpWbeGVBS
 yYmsJbOQDKABv0nW4oznwKDekUzzRvtnQLpJomQMZLn9ofSMIII8lkVX2CJ1yon8
 sviUCA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts40d3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 09:43:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bf321d786so28984391cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786614189; x=1787218989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DrK/ai3OsEPf03252eu0Jpwsr5QmfChylm8olBjG6+Y=;
 b=P4MS+UMzsQMwHRLkZFQ824qhl8R5kCJjmRC4Ujo7ZGEoXzB0wGFJ89iVq5RM6gYIMZ
 1CSlxFuTHiJM5obu2KoI+GVpCZc7nhUZrMt9ovphFgVXbrs7a2VQA2FfJ7zcrmFf8Hpk
 NGlIjDUlPF1lxvtjgGUuACVFJwMN+Ii0EAj1w6W+ZrkCjl6rVWu8fbznsTWOF077C4eP
 P+Hb8TWu78v+skFATFA4cr5b2VwuJFa+mEaWuoul7RHZgI0fIdRmnf3j5JXPzdOMXaEN
 DRA2I0XLlf1jHSYc3Fsxi4h3suij/mewASp9dLhRKd40I4GkaazhTD8wCequqDZp1i1E
 bzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786614189; x=1787218989;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DrK/ai3OsEPf03252eu0Jpwsr5QmfChylm8olBjG6+Y=;
 b=CvSM+f1q90PFrxAZE+29NZE5h466OI6VtOGuVsjGztd43xS2Jp/ocFfvsNcZRMr6qz
 hD3q8T/TRb1NxPyyoHXtWi/eMIee/F1vVuKgds40yhoUHan5Tuj6UhiHljtHAigUBWsy
 pzZuzoOJzvS6EUTQNQvP0Jkl2SSXm8aPTxo4GifRSisWUNFx9sObX5hue/HIw2Jr690k
 zlz+JMF9WPXcKD3/0g/Ped5Y3OolIO/7KxTfCYdcircfFQmby369R4ujV00yXNNpWpVK
 pFCAHMlYzT9VmQoi/4i3FDQ/XwKtmazQaJQX8YbZ6Nl73iy8sdFCcTH1RntKoUBB4WEO
 qE7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rre1DybFP6DsnX5b3L+zxSG/arLEbSC5tHw7IKTPGZX9/31WxB+pALegZLdIeGg4aafjhfHUNFHDT5K@nongnu.org
X-Gm-Message-State: AOJu0YykEjK814dg7/7er4Oa6NGyZRkdLlxuKJvESTn/XJE/D1alhajm
 TvzC32QyywWj5PdElqAdynFBQWrREQ/2mK0ZDRdwZUOIkMORfdf+i7zvKs/DM4iB13E20csoElP
 wRVv/+PJVRALAOVMeUdHEIz8AMi64pKcN+bVGSRBTCHik02a5HrGRYgtooQ==
X-Gm-Gg: AR+sD118xx4BfIXtdkxBi14IPm5xFDpngCPqTb9bS+ZPc4p26M2y5j/TE1512oDprJO
 Ldc4DQOkAu1KNSxCl6QGDIhv/ZNJfQyAFPeJhN+1ytsEFL8YutxQZblso6RKWKQUdn0g/co+uMB
 nko/bBn0CIihWeVUauz41lFHlqoXTiFOZAzEg4qeD0l2va/BifheJnoyGIUXd2bms/3E71+X4Sf
 zF76cjJmMITQzZyoZvveWWZc7kOWWSJfn3BBq7+3QJP8IL+EeCep1T0My3LShbU6oh4ptfWdOc4
 CIMofdSvJNOqfWYM1pIviWO+pH+TyK9+wzsR/Xp9PM/ZL3TbpINv4dab+8VJpmIHq1/dUwW2wgz
 NCK0TN3+wWpfT/+QiM3Nm3tjdS26rbmTrJXQ=
X-Received: by 2002:a05:622a:295:b0:521:934c:bcf with SMTP id
 d75a77b69052e-52d73e36693mr44794931cf.41.1786614189378; 
 Thu, 13 Aug 2026 02:43:09 -0700 (PDT)
X-Received: by 2002:a05:622a:295:b0:521:934c:bcf with SMTP id
 d75a77b69052e-52d73e36693mr44794521cf.41.1786614188940; 
 Thu, 13 Aug 2026 02:43:08 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5b6c21sm5373335f8f.27.2026.08.13.02.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 02:43:07 -0700 (PDT)
Message-ID: <0ab8c434-cb0f-48d8-ae00-b329c7c742b9@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 11:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/usb/hcd-ehci: Handle get_dwords() failures in async
 writeback
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@redhat.com" <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260813072340.637657-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260813072340.637657-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2oLRrcPOcEFDIfE81kg4vxtowEnrYijQ
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7d91ae cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: 2oLRrcPOcEFDIfE81kg4vxtowEnrYijQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2NyBTYWx0ZWRfXymdUtWmQq1K1
 kFdoJ7kSWkElTKL8xwvL8sZ2SOLKg0jH7lSNH4sRvF0fx9WD7mpYyAjRy/273lMvDv+7cqkfpWh
 AF24skUPUbixmbaoDbtrLxDDkja8mok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2NyBTYWx0ZWRfX59S5FdECLLnL
 jxVF556mLGLtjloVoFPy+YzLXbSMRA1J+G0NF+gOoADz+X2Rm03Mw74p02edHS9izhSxD45ynZ/
 rduWLuz5hOelnfOFV2EsStREuPhh42XUO4g9zZBkv3gSA9RfZ+H6cbnPrYL6ymrWvaUUum6WVUv
 QeF0EFv9E5gQbodjuRiTe2QBU26E+Y5HPEe7vBXpE3GvAVI7gXPHK7/d53KgzJMHcVTO0uTU+Id
 eEg1xrm9cwQaiItysKxSd6b4JZkx/ZmXLv1WvXAew2qa7kWiuqkUTFYvJCpjbYCma6LYxP6SsSV
 0CCqYqjGylfOB6Osso4TJ9VXDP0NP3d5XEZACa/jJXcWlSqpBk4c3vwnDQb1s+8RE1GsRZJpuYB
 dcrssdblDobfKoRkCuKv/XO6xLSqEOaJK32ohe4/1xDBd4AQNU+Pq9+JaqThsfoeGrvNL1gRd4q
 SX7Zoe6B3xo5mPXBskw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130067
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

On 13/8/26 09:23, Jamin Lin wrote:
> Coverity reports that ehci_writeback_async_complete_packet() ignores
> the return value of get_dwords() when reading the QH and qTD.
> 
> Handle read failures in the same way as QH and qTD verification
> failures by freeing the packet and returning early.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Fixes: 2b3de6ada5d ("ehci: writeback_async_complete_packet: verify qh 
and qtd")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


