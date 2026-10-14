Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F21C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5av-00012x-Rv; Wed, 14 Oct 2026 16:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5at-00012f-1D
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:28:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5ar-0005uS-HG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:28:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZiLK3468853
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w1u0Td1ILz86Am9UX9AuXsqA95AwlYs7Xw9AXwVdPhM=; b=MzKUz1nU4RDwZmUO
 KZga54j7ummZHqgvgWjEzjrv+fELGvPPiXgRgjVGsaRA9LMcSHgW+NJLOO3+DUEA
 yL+/cQqBsEhgCBCcbUPL3A3GaQQqu9KaOunkkKipofxUw/MVRbaGkydUFQwPmBoB
 EXnpuxn7cxvMHMTv7Igcm5Dt8MtdmJmMPaSCvYZV8291Nz5iv782XTWfsmFJILt0
 s8NnW6Qxilc9GJr3HOKIY8zyPH3bcnsyLWz3WH0xyRrNqpkjXTr7X8B1h1xODZtw
 cB+6/MbalJR+DccM7KD5xZA0Tu5M7dLDJ2km+JyDSU+JC1j6vRqfCKyuZom1q4/k
 19pnIQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd78v2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:28:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35d4538fd74so4207948eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009735; x=1792614535; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w1u0Td1ILz86Am9UX9AuXsqA95AwlYs7Xw9AXwVdPhM=;
 b=YIuEPsNT1S7w+jvXMpBmFJiennqFXxOpd6WfOBlAFxmzqJrw55qWDXLyFbYc0LjDVi
 BNPcaNaViOWOjvDlUu/rRntcK1SDTMqf0KA1N8XIeoQQFRr12JUqzGb1l8QpKh3/3qzQ
 YIcr3A6aQ+fQ/VDs8WYkv73IabCv+eevUnGtQ/8C5xMJMcZDkeUq5O88qsp3ctpAYoid
 eMullWiBOiJlCu2gAxTcPkLDbGgbeU5WcXlXvGQfD1VjNmTftlyocvzvNhEE/+wx2d6H
 VsnJbt6c0UaumGAyyFx5NoX9GUeoOqSTXlnaqu1J38WOFnQPUzshVrLFNOuW7b0A3oYP
 OMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009735; x=1792614535;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w1u0Td1ILz86Am9UX9AuXsqA95AwlYs7Xw9AXwVdPhM=;
 b=BDMUgS/ZfPQFjzPNrhq3RJLn83IsYmdwWtWaZLR0wJGEFhBrEC1suIh4Q+rmkh/Q5y
 MsXo1rQ2OGhe68i2tZ97ygdMFSCUqKpq3Ltv3cecemnbBvX04HbqYBW474dMUoJWs5tb
 /BMFIcoKkvYTO4kp+vu9H++EJB/2iaXp/IpAnGxz1Q7N6g/to933mliwwwbSvdG8Flum
 acHJEhNRW/wp9cREGAIAGh8uZ+HgVEtvnZ0um+eXnVF8Jb5L4OZ7Spy8lQkwqXZYhM3Q
 IPAns0GdTD3kt3+ncC8rfXVTJ97Po3w5I0hzLhM7I87bfOS8ArpwFfk4TsFDf4nZyMLM
 3aDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJH7/89CPpDRDS2CnaM+CvacdBR1k4igDxx5IDf18+TvJaf8a1UbMiX5cHE3dX/DR9nrZQyHCa+Vyx@nongnu.org
X-Gm-Message-State: AFq9FYL2ZZN84bNI9GoFu+tc4JxEUItocxZ3/GZctOFFrzIw6sje9B1J
 AJAdI4eMJrHhyVP0dTdiuQLq9zU6UF8jBCkMiGorNigUR1Vay9dlB9JHkPqCE5dK85k+7baS5LR
 XoEMEjJZWA8ZDEk1m0nYoz68aWflpBePKkr7KkwRtyUq9sQnBMouzGkvxmjDvv5t3+g==
X-Gm-Gg: AYBFou3H9q04zEUaBTY8CoCGHe3WVeRSpl2w5hI3kpYxbg2CHlhNnSvhavSxntgLNVP
 Ps9piHjRqoiJ1wrDI3pO/seqv8ojRZR4RWpB+B3lBYN2KyIdadfYvS6UvQTOQL2CgXHP7tGbz/z
 SlokMp2+XR98Rlg4he4TJTHAcoTFeWIHAk1yIvxbFOmiO7OfFHtYKlFhi8jFcYSs1GTc3VZCQWA
 8Hoe1BNhaG5NcnHkPaIs+ym6aZ2UazUB/FS75TAS7r+l8grGXR9hcrUKueeWKo9hAxqUjpxm2E3
 a9FMbk61WlP68By31/ELfEz4bcAatcQ2fvO4fayLXZZBMlxzTF0VOz2Yc/5beR7vn0Pi0915RMH
 eKzJJMK4koG4ZWxNsMXE+ywFQyTx0f4OTyyTKilnw0vZJb2eXVmhR+RSJ0flZ4oOrmUuDXg==
X-Received: by 2002:a05:7301:3a84:b0:351:985:e729 with SMTP id
 5a478bee46e88-3537e01e8b6mr24963372eec.12.1792009735375; 
 Wed, 14 Oct 2026 13:28:55 -0700 (PDT)
X-Received: by 2002:a05:7301:3a84:b0:351:985:e729 with SMTP id
 5a478bee46e88-3537e01e8b6mr24963341eec.12.1792009734711; 
 Wed, 14 Oct 2026 13:28:54 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm50952792eec.29.2026.10.14.13.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:28:54 -0700 (PDT)
Message-ID: <eed02687-0f8c-4a02-a6ae-f1da64003ff2@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:28:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] hw/hexagon: add v85 machines
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfe608 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XI7MBPpaTVa-333muigA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: XnnnEx2t0mkJmAiKVlTaJ0vAEtfLFSuX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfXwsTPyyFOvixg
 dafmHzv5mkY73FCrWkVL2a621jbjgqWHs06Y0U38H4kqOJVGnUl51CICC6gxNiwHvzcYJx9tsL9
 dt0RUUV+DMPnKOOaGUBZx8s9328c7K57Gt8grYq829+aHjbgpp7pVBdDhYjsyyZMWSLf/+9FCfO
 jYz/YBFdGrsrYn4fbe20AbE7ra2O1j6fqb/3MhSQj4luU78Tlhabqp6n60eDG+p0U4mu+x7fTFu
 k0pqGKGPaiyMjdLM7pJ4C3P4TGBUwtqzce8xJqb2VIoF77TgaN128thowTrIAUhkq3P0jCcO62R
 z22h6S36NHyiM1IdMrXePeAJaMkK6YgqEWRBjdc7VAInQ5CBuU358J+XimxGWFyLUYBV3GCTP7d
 VxtQcxzBNwbyzRNBa9JKan1a7DQIfTeuO0dAqRIcUx7TLJxXaAscowaT8kyVWaSSBlRHosp1V4s
 nc3zBe5Apz/bhZA3WUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX/QfMseH6Po18
 eIwtepgkw0linhWMNi1icm0D2BnYZNatffzlpGFHo0Nn/2Z5i9mPV5ZmGnnBRREfSwwv6ObjOIR
 H7B/VHB8u0ObJoJD1feXssbWtfzAj5U=
X-Proofpoint-ORIG-GUID: XnnnEx2t0mkJmAiKVlTaJ0vAEtfLFSuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/14/2026 12:52 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h         |  6 ++--
>  hw/hexagon/machine_cfg_v85na_1.h.inc | 50 +++++++++++++++++++++++++++
>  hw/hexagon/machine_cfg_v85qa_1.h.inc | 51 ++++++++++++++++++++++++++++
>  hw/hexagon/hexagon_dsp.c             | 48 +++++++++++++++++++++++++-
>  4 files changed, 152 insertions(+), 3 deletions(-)
>  create mode 100644 hw/hexagon/machine_cfg_v85na_1.h.inc
>  create mode 100644 hw/hexagon/machine_cfg_v85qa_1.h.inc
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

