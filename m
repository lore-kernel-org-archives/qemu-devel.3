Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD3CCA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDrx-00062L-1M; Mon, 28 Sep 2026 12:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDrY-00060O-G4
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:05:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDrU-0007Hl-Ud
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:05:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEdsD0378842
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MWm1ZpdATIyjdhQn7tI4HPksEZTcYbnZPW64CSdiMeQ=; b=KlTQYL0LD/vRfVp8
 91rXx/84jlDmdQbYpUbLqUwpINhtMrmgRYNYE4tHg1VTHk0VmVdD4iPO64km/vQt
 BDnWqocFkng3bBPoH2/1IUpIbVIJydAYrDfnjezn3rIgZxu1QTDFxYPJ7L5pMe2L
 IDf54RSs+SwuvRZB5X04QksVC5vir2DZhMXURr25ZC5zCtngHxTiceymPWbXkqBl
 ryUszpPvkmayp6W4XOa9qw4PpArQOSmm4WVc8EuFJS9FLbluX5zqTBTKyP4Qr9ak
 uUA2x54T8Bag7tWYmsCV66p/QaVyvL1p0YS7/49RbcVVJBe9xpW6afx7OUnITu1Q
 9rpl8Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyqx390jt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:05:51 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98304865f02so2797649241.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790611550; x=1791216350; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MWm1ZpdATIyjdhQn7tI4HPksEZTcYbnZPW64CSdiMeQ=;
 b=OPqGIWH8qEKZdH4ZtOZithofNnRlKWNr9L0asStNFcCJ9+4qkFILuVAsZ0feloUb8+
 BZuUDSy2EiEaYff7zR5bFGztROEgcJJTrk0423lOTruf7JHgperYn3Q/ZRboNtcdK8fS
 0aQLOxrIhO8GuXCFj8Ih4JpL1dcsuwzcGmzRMLqGPrrPswXzz07ClJnfJbtwPcKaM1TM
 5nmsbF3M+yJIKAnN3yKNBiBs8FCfENuJfy3+ElGOSzbRqqdwBco0AVCA89aDeJN6gWZn
 6k9JC4h6zFh1DsOftlGZOpqGQ0wusz5TZgGvxHnh9L6inzsGHThFde1NoRQPywwDJ1Jc
 iDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611550; x=1791216350;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MWm1ZpdATIyjdhQn7tI4HPksEZTcYbnZPW64CSdiMeQ=;
 b=ziGOZM3SEPP+iDYAdCr1HoRLNpqQn+gepOw3FdHYZsuSNx5GlBzRZ7LcMHE88c4Rq3
 mGvkyLViAQUphX7fV5yMRmQJO5R3e0RdREotWCyWBxYJYUYW17RL/EAbO5fJ9ueICB49
 ffdB/TnVg6top2mjJVcghBC2DD3QoKPOtd0JMqYeAXH9EAC0J89He5N/CSduvanWbZs7
 PY8MIOYtbveerZfIWDYgcGYc4KqY3KyrJwlpctjYxy6mowPsyzdwCLZmCIt1r4jo7nBk
 7bi4UX1xbCJEU86dbyOMr+w2om+NG3s7ab/Aq6JVGJ68An2u2ZQ9W4JaQNPWFBxPpwAM
 pU+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlQNY7im4pQpelQBfF9rq+K3RApVtPrTXRxqaugLstWujw6Quz8puYkXdd43mFpbpaGzqqpkWeHRIB@nongnu.org
X-Gm-Message-State: AFq9FYJunAA8hULWD2ugCXunmAHl8JlI1Zofg551cefgSaqGGwLhHqB+
 9cxdioYtlQEYQgK8SHU/mriqV6R1D0mdlVQzb+4VYDbtshh66iwVYITR6INRIim8T9XvcCbtU2G
 4pWk7fuSjnVcdCVTkAoGrsfyBp8VoTRV09O1G2nO9nxWDMVcfcddQduy3yg==
X-Gm-Gg: AYBFou1PRLqHoJWrBoPRYjEkUoa+FHf7QWkwi9yAVhfE4I0h1wUKCpi+GxPp1kbKshT
 osF8QoCBihUekE3pcntUmsgX6qRpFuytQ6C6/wLgF3S70y/EozTMtY3/sTxNIZZMpOsnafjH3Jg
 yPF7HzBO8gBdiDx6w22gT0Voy9xqkuwmp2UO3GZZ+pCwNu6kTkm2adpOgfx2BiuSjZ0C5Qc58zA
 J1vo4tyGb1GquqM2JzGMKChpG5qGbL9/Rbx5fy0bsHncRi69NnBCoj2D42tTQBXGd9vW/zGqNwr
 /nx0A6iMjm6QMlDab2O2ljNE1eugR2DZ338Ge3xia6oH13YJxfV6pyyNCfTQsTpSIYHvJH0v4U5
 l9I9/GfMT1VmenrurKgxszKRQww+M65uBvQ==
X-Received: by 2002:a05:6102:10c8:b0:7b2:f790:c020 with SMTP id
 ada2fe7eead31-7b2f790cd9emr2316343137.30.1790611550354; 
 Mon, 28 Sep 2026 09:05:50 -0700 (PDT)
X-Received: by 2002:a05:6102:10c8:b0:7b2:f790:c020 with SMTP id
 ada2fe7eead31-7b2f790cd9emr2316334137.30.1790611549860; 
 Mon, 28 Sep 2026 09:05:49 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a638sm27648275f8f.9.2026.09.28.09.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:05:49 -0700 (PDT)
Message-ID: <87cc37bf-3cb8-464d-aac1-f5f5394aa1e5@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 046/101] tcg: Generic expansion of tcg_gen_setcondi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-47-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX0K9daQe7U6YK
 dhAT14l/ccPlAAQOPUoGzJnYMA+Qg2bQCFQy3Ur6Bggi/Ek1t862l0hEAVYaMFHLtTZHYeDOfm9
 Tj253oxUsL2wYCuo8k3RCWLPpT0emX6UuEu/ysO+za3AV1HUuzYLmeV6SHJW+6web56NJcKYMD6
 SgSzqtIyNAix26xaBHndHwnQsoqxgcuWdz6WHex0bmJBuXyQa7V4cPLXhdgLZHN2m17FdW1RE3o
 yCTpq4g90nwvmAXJXVfddJIcx83YnGqV1iIjgypJJTzP38Ge45Ho5VIzsLVUxxtwsf7/l+G0NSj
 qPKmzdMvWo6mMBwF4+uN+RtKA9uQ89VV2YLzE5yi2TfCmgbYdoPYpuXudrRo/qme155SXa7X35g
 QGPxq1H36fatgoqYto9xkPUzFJqXZKmc3WKp7uPdDInjOs1gi/kWlcZkzCIYkmTDu0XHaPy9OHM
 EA6REHE8rHRMvpDTuYw==
X-Authority-Analysis: v=2.4 cv=f7jdl+yM c=1 sm=1 tr=0 ts=6aba905f cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: T2I44quVGjdgIUrMOhyNp4CsvhtC-VHx
X-Proofpoint-GUID: T2I44quVGjdgIUrMOhyNp4CsvhtC-VHx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX6t2IqsOx9F0Y
 zHCfdrstyHxIQf1VgvIPwQHZo3iWXcQkKLzt0UYTcGEZDJpf2VDOECVClmzxnzduM0MLLTT9dtH
 6z6MqkGjZPi3O3BnCg+zL9K+Ah2R7Qk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  4 ----
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 18 ++++++------------
>   3 files changed, 7 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

