Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB29C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGCE-000127-S5; Mon, 27 Jul 2026 03:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGCC-00011t-O5
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:56:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGCB-0001Hp-23
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:56:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7UD333151052
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2vy9bAbx1Wyvg7TRevMpr3CbcY6HP7pFgNLxjj/iJ84=; b=PAC+sjv4CkGNVXLI
 1q5p9MhkeU62bLrWJ5334fF6zp8VDPPCRL1/ZnGs6Z6j3lkx3t3xQnfly2jsj96F
 PuOp0cSAl2Tl/dB8qSYIICR8K1bM7Ka4COUWI51Wo1gm+errEMTvnrW9cM67tDkn
 Clalhx/CL0hCLr+r4u5vzOLUErLVoq6WMSQzAbLdbN/kFmogPQ4UZN0BwU2CN8mn
 yvpJMlDwSBTOxDVnwkExiZTIyGU02pX07WMl6OVpN2Qed0tGAczMCYI19ZCNFvnk
 +wDue8yAmjJB1CjqGoH3tIabjbgnsKU0vroKCEPZL+ILJYPq4gQXUf3UcB8rJClK
 ti8xXw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp30g034g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:56:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso24754551cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785138977; x=1785743777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2vy9bAbx1Wyvg7TRevMpr3CbcY6HP7pFgNLxjj/iJ84=;
 b=Qj7LGuqddm7xf/nFbj8FuiCGpdNnTXqcLHxcidaxBIP/ku7Egyd3kHGzmyKngQLaev
 aMNCdKRVc21853Prwsh6n2ow1IqcQP6rQcOOvFwiM7z4EXY/pAeEs1e28WV73Uma7lVS
 G+OgrAwnZjT6E5v0YN/ZU3iBCcBQ2P3dgAHB8VJISG5YomU0d6jGRxFRP29rNbLbvnVM
 WlmUGiJRLDpOllrs9qd7pjGzwCabQ07WbWW9Lh6vOEiLMZ/CWj2uizxL1RZVHb5ZeyDm
 OQQpNobkG+RNpnoL6aAAC6RTyW4aZvNS8XesIKyDu6Ic5zZPuZIMnzabZWLvt4D7gZWU
 L7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785138977; x=1785743777;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2vy9bAbx1Wyvg7TRevMpr3CbcY6HP7pFgNLxjj/iJ84=;
 b=C8gLusLDXYGfQUkRtweqdr+njPVwUA/82nk60QNgHE3T+Xw78hQ+cmbjnSrQaje4dX
 nJMicoW5cvgt3W5UbJvcu47ZW+1A3wftC7zI550iQcxgNHWCxZqRtTI6HUhs71c1bImw
 LB1E4ahqk3msI7gwpmcYqjlrn9g1jd+6XmoD/LaGHuhQ8gA3QEdhbFkXR/a/L8aCKCv/
 sRXJltczPtd9HWmag59F/W1W/E6cElSfDXwYImcobIOdX+NL50VUrRGsmzAklgGr2KIH
 Ab/2qewoKKXWSsOWzI2WnVIJF2DZPi9oOIzdCKbP14ykxQlsowr1syo5eaHzgO3BgC0d
 yrOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYkMgtfnI+bbDqSrC6jYO1BTmXE/wBolk9TqDizqe8nR933zeZ9roH/6TvvE3zIKzuMyvDEcfQwZ4l@nongnu.org
X-Gm-Message-State: AOJu0Yz3xGEke/DpfuTEGNVRHUxsYWOYoHTlT64nLkA5xPqG1mzYPrYB
 Do5ds5P+9pDDV7Ac77SO9ETkSXUayIvSixJJDmVrc7ZKLKA/48HbGxU4KCogjhmhb4hsVobgMV3
 Xj6m6GvyfjTD65jvJFhDCPDy215zhxvIrI6JtZTRCESF+WStuW2GG8y8avw==
X-Gm-Gg: AR+sD12M3ObgfAuVRjYCl56xbwFFLk58OnRKOwV4/eJEnkBqULFXF62+1g6OALK3DVS
 1VzslScag+6uPV2g6GDGxMrL5+O/SLJjgDmGd/aWlEeaPTWRSrKoj77XzorcY6leTdxrplt0sOf
 pUfOoHIa3H+44uZ8RH5LbOmhCTbDSODcJiEZomBfn2Zi4VykTE8EzANekbevJtdbmiB2O4HsD+Q
 e2hAqU4m8Y+tiFy7td8VSQI4gQPAB6axSice5xnvJHfEmhSYf1Jh10TaGClK4VzN41dATK5rMn4
 v4o42naiZvBLcPpPGb7Lhkyx/W5GugFNRC2/ccrLwR0dLgkSeqxQ6ZO3Co8hU6NdaQYKejyYT10
 KVbLPu8Twp4V2YAyhfBdg6AMKyScAd7uU6O8Ice7qUnCjSHroeaY=
X-Received: by 2002:a05:622a:394:b0:517:91e5:1086 with SMTP id
 d75a77b69052e-52967309310mr101594111cf.38.1785138977168; 
 Mon, 27 Jul 2026 00:56:17 -0700 (PDT)
X-Received: by 2002:a05:622a:394:b0:517:91e5:1086 with SMTP id
 d75a77b69052e-52967309310mr101593981cf.38.1785138976758; 
 Mon, 27 Jul 2026 00:56:16 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm32299632f8f.26.2026.07.27.00.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 00:56:16 -0700 (PDT)
Message-ID: <13ca12a6-2f78-4ad9-8d8d-747bf8579f28@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] hw/hexagon: extract get_reg_value/set_reg_value
 stubs in globalreg
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
 <20260724183648.190531-5-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724183648.190531-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a670f21 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NiBTYWx0ZWRfX1nUUbRZ3pMfG
 Efy4qCPB9NwXdUUEy+DkrXzLyapIGnngA3UC6nnJXGrNSCHrWQoQ1eJOi7nPDHiLNBA4reFC8V5
 CQEBmNa3aMLCFlibBCshAFo+mRNVE9A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NiBTYWx0ZWRfX3T255wfTlVd4
 QglEjmGsFuyO/1C78hNkQknGhad/VqWnNLvu8l6qnfE5Qp/JN5kEEqQ1V4q5bHhyIp8Y5DnOWtJ
 ccZW4imGA1rYZMKIWArdKqhSTNesmakamrgLGhAj2lxlUH18Dx48PySLuk5h/XSwckFkmoQAUm1
 o13N7h3NPMdBGcrX15mO2o3bZLzTjk6gXuIw4OF2m9CV/kVZAnIMt3uuUaAiPTCfzPdJyMDuv1L
 0QevtgXRXFH1ECJtqi/fmMfxBO1CcJmzU4WmWN65PZoM6Iu1h7keTCbIGa6dqBzux8NWGRatkh5
 98IjkS0gg4vWsreUgGlFYzYd9ouFPW6LqXAn8NiZzv7tGhi218s7Fe9CnMA0MQGqn7MczWKpo7q
 5O29LnHZAUu9zFLSlsjzMYCfoD7Hm4BT7EaSOvsBj0mShhJ0fLOz6kpzRXHOzat7IoT5vQ/Zv8Q
 pt573W5KRp8jcTocvjw==
X-Proofpoint-GUID: 8ci0pobPP5yYAXSynSkQxiMVITRE8q6J
X-Proofpoint-ORIG-GUID: 8ci0pobPP5yYAXSynSkQxiMVITRE8q6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270076
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

On 24/7/26 20:36, Brian Cain wrote:
> Route the globalreg read/write accessors through new
> get_reg_value()/set_reg_value() helpers instead of touching
> s->regs[reg] directly.
> 
> This will be exploited by a subsequent patch that redirects VID/VID1
> accesses to the L2VIC.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/hexagon/hexagon_globalreg.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

