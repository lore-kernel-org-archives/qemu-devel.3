Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCA4F5A8A1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 17:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEsX2-0004Rn-HL; Mon, 20 Apr 2026 13:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEsWx-0004N7-5q
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:35:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEsWu-0005Vi-Ku
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:35:30 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KFdq0H1600322
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 17:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n1I41/kZM9HSFsataV7HgYN0LEiJ1CW3xwbfczNl6uA=; b=EwZPKuTp/IttNiub
 +AKs0QUd34jdSIoyGEgULbcX/wMpyYHfp9eSOChobZIU9ECLpfLvfi6jA5bsuF9V
 HPl7ZLQ0sP6yPMQTos7h7K0WkS7dAW1VJi0QFPPd4RzLAfxdGCYyTFHMIs/vOXd0
 cGIQxs89lYVEKAMOK1Wx1/xF/T+4PeEK79o1Tb26NbXPcj+Dx19Qz09FoaC21Wkw
 XE2sw8fhvwL2Ovl6qmrfOXjWUyqqGECOvt8tpamKy8HLAFKuWlRB53HCFCxgHjAT
 rwIwzv8WyvKMIXp9qEMFMpthJ6Fb/F7Sw4ZrsNUzfLPJqYPIC54zVkuKbiEpADF5
 6VskuQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh899vqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 17:35:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2dd6fb4c867so4176369eec.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776706525; x=1777311325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1I41/kZM9HSFsataV7HgYN0LEiJ1CW3xwbfczNl6uA=;
 b=fLKEQvDOiqDjuZ04OLN6z9eZ/uIpxKsRTItnnsHErZSPcRvc3VE46Zr8XrkidGXfuI
 gfAyGC4OSS6bvGDgWWoDqbt2VLglolrfPm6Jl4fxbOWu/GrFvF934TVltaz+r+3bX8B9
 VX/uYpVB3DwUo6zNZvXRqzeUO5bCQ4HJk9LliDsgXVac9W5tFVYLMoatVUKReWjLBdmT
 B/FD6zMlu+YU7QTERxcTSK8jvcgqpRRFntXUXxR0+FWn1y1r7tHicaUwIpvjY6LHmV+F
 TwRExdB8q3J5aOCgszwSxTL3FKdPFbEitikZMBxywkFD7ndcKL6xh2aM29Fibp6UN3DG
 JIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776706525; x=1777311325;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n1I41/kZM9HSFsataV7HgYN0LEiJ1CW3xwbfczNl6uA=;
 b=TSAJeTzpyz3k0ELcS6UscVqF3y3CImJp0pD+DCtbLhtEVdL1vI1U7DPz/Z3xjul0gp
 ltwsH+8I7/aNFGpAWRCcWdxnBFJHSwMMgLM1trccpchY2NMJ16W2euOfMp0ljvzQnQsr
 W9YtKVaOAhDevuaTYqVgKQJ9V55R2sqnM6NnCMhbC8laA/g0IYtzDAOv7c0guNiZyU2y
 cll4DDi82meUr0jlSdD2dQG9nISuUAe5QslzvpRoP1Y5FEjGwrJ6Vf6t3YfXYkExzIJu
 up2ZIl+z8RmUDCGWC5I1927ISlal6BT8s1ZjGnXm0GXoSuTT38PRHhI0ZAs3dGssR2Pc
 L7pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wvfmNhc3sm8fl9OfS72mQOA3QA8Xi2YJGcXdFkwVXA/7wx79/LPnZYLy/iSvhFthJBqWTGDa+thmZ@nongnu.org
X-Gm-Message-State: AOJu0YxO2F0iXDY9zZyhYPbXy2LvfdR1BSqiob+LMfp/hgcmyr0MO2E8
 QcYkfarFFXA8T9yK86eXfZFHgl9/m1fymYMxq6Lq9/yJ1vt77CAm3ookscr90k1210nWcN+eD0x
 0UORSZYQOCYk4tNbQ6z7/pIuriXCOHWX/Be3Ew1R19a9iAOfBz5ByCAdRdQ==
X-Gm-Gg: AeBDietA7o70DxW1CDwumNtvPTBD2G+wq2feF4RK5lDRSMe0Ni5VECkYDf8C4Dys/Ad
 W/6wbELSMcU5kw6J3pwrVNpabd7R7iGa5OSljVDKxFU0O/dw5XOOFn4uKxUqpotw6T9oJNiLDUY
 Q1hrv1d2IgEyabp4LaWEcyefoMi0XZizNWuZBh/tIG73K+9Ks4TIEsrr9PJg4Ag1HkvtiWfdjKg
 hZxm5JkLcgalzD2NQJTpCH+RnHKajLx/QlT+dV9uJPfJlQzHvjS9g3qQrCcRxeG5Ws3mCXwT6ge
 eOLPTWdM6JiZ3JoHGoA2kPKWhynmjqIQP5EO2Z7MobzQyd/W+ve6syr8HPRwt5zdbY29PRQSQDF
 mPLLR9T0GXIhmwPtudEc8K5HDJdS7qmBHeNazVnHLXjw/58hkrV4yKmnYtFAsxEhFxTAOrdH+jD
 etlVOOp5wsh/telbrVU09HAjii
X-Received: by 2002:a05:7300:d706:b0:2c7:2c0b:f33b with SMTP id
 5a478bee46e88-2e479d07dcamr9109019eec.20.1776706524664; 
 Mon, 20 Apr 2026 10:35:24 -0700 (PDT)
X-Received: by 2002:a05:7300:d706:b0:2c7:2c0b:f33b with SMTP id
 5a478bee46e88-2e479d07dcamr9108995eec.20.1776706524123; 
 Mon, 20 Apr 2026 10:35:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d2cfc1dsm14863291eec.22.2026.04.20.10.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 10:35:23 -0700 (PDT)
Message-ID: <22207f88-e4d9-48d0-a02a-81ecf425dd2c@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 10:35:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 34/37] hw/hexagon: Introduce hexagon TLB device
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-35-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260401152657.314902-35-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3MCBTYWx0ZWRfX6YPD55j9s6HA
 SBnXnazhCLLU1t2DDCoRPITbgRd/+3HGpB0SPuVgNJN1ppwhoXzF48ADx+yGc2eCeHA0hL4vtF8
 7/qozg7zN7FI4dRRrWs5g1/JN/WNUz1XbvtEVxCmutijNanN0IVHbTVzI4qvdiyWN5coYgFqBkN
 wUdbIHY+f59RF7THnwnQv3laOa4p83GX4hfYNdtq96FNGubRhPbnQ3O4ObHuHCf2OzdbB2COTcZ
 2SzrnyBvcHMRyXyo7xz+668qUqco9j5Tdy8GYX16VFgjTRwgyfb0e4cf/jk4KrTGWXFEF0KnulA
 jwCHOnxqIWuFLjQtk9skEhJmJC4A6J1rQmU1RdSGrnmRypNXcYW/nLhRLk4Hmmjgjzehn7NdrHs
 c/ONPePsbRrpG11/61UomWzfu+lgy4J9AT0As6mrfHmHVAmqnwz8PmO2u7IK7dxkw4JvWK/i67k
 uGvBIls/JBAHX2+OF/A==
X-Authority-Analysis: v=2.4 cv=D6B37PRj c=1 sm=1 tr=0 ts=69e663dd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=9hHRCeLwIHA3a0gnJ3kA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: mnRMtSWy6Ue15F6Of00Td6akMxVD0OoI
X-Proofpoint-GUID: mnRMtSWy6Ue15F6Of00Td6akMxVD0OoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200170
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

On 4/1/2026 8:26 AM, Brian Cain wrote:
> Add the hexagon TLB QOM device model.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/hw/hexagon/hexagon_tlb.h |  46 +++
>   target/hexagon/cpu.h             |   7 +
>   hw/hexagon/hexagon_tlb.c         | 466 +++++++++++++++++++++++++++++++
>   target/hexagon/cpu.c             |   3 +
>   4 files changed, 522 insertions(+)
>   create mode 100644 include/hw/hexagon/hexagon_tlb.h
>   create mode 100644 hw/hexagon/hexagon_tlb.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

