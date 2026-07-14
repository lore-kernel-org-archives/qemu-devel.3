Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4949C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZyN-0005c2-BP; Tue, 14 Jul 2026 06:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZy9-0005WS-M2
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:02:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZy7-0004ea-Hs
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:02:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SVgr3740561
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vAD+wPm03dk9qADYT515yE3RiI77RRt/quTgSPIVi+I=; b=KR0Zc45GXerrj/6A
 57mdROiccR5VxAtVKeW4NHHFGjIWUwF9AvcaVPs8nmS4Gai8XWdjFndNKR84XpgU
 HvRej3qY/pCQmglDwvqBnlAYDER9x0s8CxlHYQj1A4G1AIV/TBoyRFMO5/TvFN/r
 W5TAtDC4glZoM90yRdBV2IUUeA2/UqZpcA0/9BGl9g2ndDbBX3/x+qa+UGCE3PNV
 J3YOXqpdaHOdgwgRSuuJUwhfFArd5KfMNIxfFFrSX3P9yuLX9OWQLVKobzK45Ujr
 H5Q+9m1uK8Dt7B7wSltnLEPfhL87mc1pUSj4c+zIEoCUCle58afYXRzCJbxo0hST
 Xrd1sg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdde09drj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:02:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so18381851cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784023345; x=1784628145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vAD+wPm03dk9qADYT515yE3RiI77RRt/quTgSPIVi+I=;
 b=NMdou6qvIO3RY/l1roJSOfsYRPRxWzys4saEkQxiBNbItlw2D3/rfzjy1KlFJbUvgs
 ukQbpna2xqMaP6fcT/VVGT38hr4oGGZEyurDRc35+yh8V1EEbuJZPYJlfJ2EVm/2uTs1
 kwziyfZi+KFq3KLf9SNpON8WkalRZ5DNqPKa3PbEAhxgNSzKP8CC1qTib4qxh2mcadvV
 TsjicFmTeajcWdZjRfsNQa4YHSr3pXz+bwE8Wsq5v/wG4DSQEZvqkmOv1EVeaxbhIXwP
 xz8iuP4efaXa1A5SDhRelSvthIf4xQhRwRHqUDni0mYFUPB5mpLk85lSR4IesDjPAgtW
 1Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784023345; x=1784628145;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vAD+wPm03dk9qADYT515yE3RiI77RRt/quTgSPIVi+I=;
 b=OURBg+iB/k09bk4yyCaEHzkpBhu2duMz7U8tzgZPQWEa3TtuWNWTZ6Rb0PtxTZLUlz
 USoVHJPVRDCxT1Sw7QQMnB9deem3R4CGlg+y8tZZPfUc+cgEzyyfTs1gSj080fB1pCS+
 v53IMB/+7tWrS2xBiSNOugeHx9uU07vxbaXJ69R96LtCdbQlflm0gqluqaW3MzJkp1Yf
 ru3VFFyjy0i+a588f7s1iIhtRP0dJSoPEdmzoVvS8F/De8HcBun7V/4u7CtMdqhycr7x
 i52Wwt3y0/PGcDgtDNc4ncgcZ0/lNJZnqBDURcvQ11OIv6VzkQaRnFlX63TXYGKWYn0d
 2rzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCBfYmM7mEzJP+TgLXH1Q267sfWL/VsWtPu+q8G0KGjxI9vV3Uod46eMz7EIF3J6rpcJPcVTNfD/qx@nongnu.org
X-Gm-Message-State: AOJu0YzQ+FuklI29nGU9E++ZM8KyI5A29d3Sj1kKUCoX14NVnDiFmlfJ
 o6SqfvaVzqbKtl66U0wQFvT4XyugoKBtVNggGCdjD0P7RmJK3ONfO6ozdShaqb7fDESufa+Ax8K
 b2AbcY4pTw3PXT4z+3VO6dppJs0s5XyMvrCL2G8DNQdRv8k8ZQz4JWE08iw==
X-Gm-Gg: AfdE7cmk5I9jxRg4xreKQpcty8uGXMVVS8v5GNX+TBXGyvp9QsWh5PwDU61c+RxGrq7
 WP39YwWZTJeOob8ImwKqmtJkZxHCWQNzKkbFf0uJMI4vI3yV47cj3GAACjVBP+RxnJ1DuzqlHoC
 u9x4OAh0ElXlijaFNh1sHf6VdvqrpJCpzmYL3hcWP24xWfS5nnNEtuHmEnm+vxtB+XannDVwNrL
 iy6AQK0ri0OxZxTuT9F+X1/bDOgK2qXi4qolsRlva1Cczg68LrjXb5eA+LZrV3zU5LmYfUuC3RG
 jyI1tq/RM4tu22vIwBINJoebXq9tx7mp5j1b3poNhIPMBTtZb//Pskt2/HUk2Qhl43ynTHKPxqf
 KPnepddH1nPsNL4QdcqH3MYM1rX/eEPbafAPB/WdcGGDKdSmO3z/ISywaFWnacQ==
X-Received: by 2002:ac8:5d8b:0:b0:51c:7b12:5ff2 with SMTP id
 d75a77b69052e-51cbf3e23f3mr109729761cf.78.1784023345333; 
 Tue, 14 Jul 2026 03:02:25 -0700 (PDT)
X-Received: by 2002:ac8:5d8b:0:b0:51c:7b12:5ff2 with SMTP id
 d75a77b69052e-51cbf3e23f3mr109729371cf.78.1784023344757; 
 Tue, 14 Jul 2026 03:02:24 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1665727517sm74558666b.30.2026.07.14.03.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 03:02:23 -0700 (PDT)
Message-ID: <7e427bff-7fb5-41bf-ba10-0f2cfd61520a@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 12:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] docs/devel: Document SSI dummy-cycle ownership
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260708150038.46113-1-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260708150038.46113-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNCBTYWx0ZWRfX7IxFlhiY/qc7
 UjDL9PdJEwsRdPjvpu7qM+GEyTxvJz0Eyf6Mqk+zY0yFogBqEcNuuDv6+XDhOs0y3lTzaqLId0E
 PW2jIS55T02l+fj9buD3D0Aegu1S7uo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNCBTYWx0ZWRfX3eRitCLphP78
 jNGxqxYJ26LW+l41o2HkTC8tQSEmGF5V+R5/5KDsbwsOV/xFqXOF6LVjJe99ocBq3nbF2P2dFgI
 MMLbjyJt1jqnr3JuK/8c+/w8sbolXJ76z3lFmDlA5bR4IinqiFWeBt1XeglsRJCzrH5n1ZhwwUf
 YrHOJEutNNrNLKiXIMm5SQyGI9V+1Vs1LIs3DLAa0d/fdAd1xYiXQI93PtakDIlcJpM4lxL2uAm
 q2ChGIqUOaTUUbn4C56GWbAcwAp724akalV9MapERCma10MbFKiDcQCnlqC2M66L7fHG9wSNL2z
 L0T825u4/cGkrN+61it6ceoUeRBB9s2DefBscJLFa7k5RK5TnxDT+HqAYR/3DB2i/g0ip1s42L8
 crw/LhdlKGJh8vC4/j35jduOWQBgJA6yUboZ6uhLOOB/egAjovZt6yUmWKtYZ1jrJeeRLqs+v68
 llrDfW1n+XaNB2h4k1A==
X-Proofpoint-ORIG-GUID: JlfoTWgcVnqMGKj-ey1d7JIfhhMiMS41
X-Proofpoint-GUID: JlfoTWgcVnqMGKj-ey1d7JIfhhMiMS41
X-Authority-Analysis: v=2.4 cv=F/FnsKhN c=1 sm=1 tr=0 ts=6a560932 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=A4Rrh0e6378w-Xg4wBkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140104
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

On 8/7/26 17:00, Bin Meng wrote:
> Document the boundary between SPI/SSI controller models and SPI flash
> models when representing fast-read dummy cycles. It explains that
> flash models own command semantics, while controllers own
> hardware-generated dummy transfers and cycle-to-byte conversion.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> ---
> 
> Changes in v4:
> - fix checkpatch ssi.rst warning
> 
> Changes in v3:
> - fix checkpatch MAINTAINERS warning
> 
>   MAINTAINERS                    |   1 +
>   docs/devel/index-internals.rst |   1 +
>   docs/devel/ssi.rst             | 134 +++++++++++++++++++++++++++++++++
>   3 files changed, 136 insertions(+)
>   create mode 100644 docs/devel/ssi.rst

Queued, thanks!

