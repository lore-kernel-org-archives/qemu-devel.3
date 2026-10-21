Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9041606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZehnbwsM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NK8xDJfQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJYg4-0000lK-GL; Wed, 21 Oct 2026 11:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJYg3-0000ky-6G
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 11:56:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJYg1-0002m1-N7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 11:56:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU93e1558077
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BZANZDKSOUFIkFLyEEyw5afAmEOjFtuNOyOM1ShjcL8=; b=ZehnbwsMNJvkj4qj
 tCS761+xHfNNc2ZzGVAKqvQEEm7DlSKRxrfwdAL1DfK51MiVOviT25DtKtIvnRNi
 /D/Hc8PJhGhDP53BHJapkFTsSNeMI8f64qkdnw8bgzI9loOowvhpJALYLOUGjDxK
 iox2uvA92jiwB1f1FY9BmVmWQzX7n9oq6BWYExz3Nzy2Mv+GDAmfU0P+/izeCkgl
 ULCSl0HHKSUDLovooEvj24fbt4qdsWRKwxaCUVlx9ZAbfy10GEiUa0nRw/Ntvf6d
 FpcUywaDkUmOQauHMhtw3hFwlvXANG3S1vCXP2dTDn2eKiRBedJYNhnDkgQjke9y
 g9lrJg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajmru4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:56:27 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4ea2c058e67so1171714b6e.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 08:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792598187; cv=none;
 d=google.com; s=arc-20260327;
 b=CFvxdosPI+KmRm6vZJ3taOVBFzOzgFey8u5kphxODqY8KI9diWtKbuMw9LghtGbs/5
 jdjpZJrBr733m5m+Ng4SZcRm/T/7MIky4ilQcmqM8jd82Iwp+WUd6HmrIPSW0o+G8kBt
 +en12j3w3Mf63RpW3rQ1K8MVASPj3UTQeU1AEr4B9KPE4uN8tiPQds4/d9JYxGev/uYM
 H1QOOBks6MQy9NKAcRFv4riY676OOZYAvKbJxuIuWgUr8tgABD9sqbfwKgVq+ciTD727
 i4HLUVFvw/Zs3ScN8kIiqMufb55m21ckU+PF8CxNNWiJMgS2/120pTgn8psCEWXhqyvn
 fKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BZANZDKSOUFIkFLyEEyw5afAmEOjFtuNOyOM1ShjcL8=;
 fh=DkbXE4ccMsTX7HmhBC7cW9zKYDAyLxQ+nKGU9uhWHTg=;
 b=aGxYg3WnP5GPb+MX9rmTi7cSmrM11MdupYX+MysLMoUiAdORNhVV/ph65CDEl7szul
 QhCTaVOC3thqQ86yYytIFm39LjzsI6W1AqZmWrRWCf5Ojuy4y8kF91oVcopmtpnM1m1g
 gLbrlE9/pZeR+xPaHwyNTckRgGRTqpgan9cZ+xu+6iGzi4H/DgHxtAlKM20tYSRjtD+X
 4ErfgCQnwXsdmh3KDb+ze6BeiBiarcb8HxOrU148xIC9y1xhsW1YGwjGMJlYnM8CXEOG
 PUWItFW5NUNcRg0Vd/53Ngj9Q3hCOD5ErfgTPQwtlNjVlvqpYXOeEN76jsxPux1tUb1F
 ZH2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598187; x=1793202987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BZANZDKSOUFIkFLyEEyw5afAmEOjFtuNOyOM1ShjcL8=;
 b=NK8xDJfQI3kKO9EPY6ATen4deT3WQFcCz5dGGT7RkGE4DHFuFmKrlyxptaJMVhaR6p
 3qbhDHvJb4+XrXvIayJDGMc4zNUnTwGY+a5UgOGl7xSGyRKYV0ifZ2qEwKRp3NwaY0T1
 UZLkoVAhdIDug0cyOrVPJR+IgSjbJgnChLcrCM1LELmNXYQ8PViaXVkwZYwVZjSxKJXe
 qKzA3L5eX09agAVC1ysIba1O9SMEVmJASEggmiYrHiJlkK91vc2hzsKMfY0OXOUiGq7j
 TAqEctRUwkdd/6b5MNBz7o9CJiqOdGAas4XS2kR+18a3AVqCKKGidX3LX0/e7oUQjAPT
 hwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598187; x=1793202987;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BZANZDKSOUFIkFLyEEyw5afAmEOjFtuNOyOM1ShjcL8=;
 b=KY6BJgVTkoUwWO7lGbLVxMD5tQmTrArCKv0upG1C/fsKLrJhaH0T4tWTqIUGU2lgNe
 iDi9IurDkZGtcYLvexwDbzuWXUGO4rHeo6uz23kbfmDnzVv04R6QCPLDZv+C31/2Wakf
 sndGN7Nf/xUsZ25e5HjCdm0C2V9BFvu3zfJukXeFoidVFkt5RMRZ4mkPxBAV1NKMRIVL
 qNDxkWBjSLkmnbuULMT4uIIAa+YuGmaW9jAMIGQOhEyclczyCL0KClx1PxVrhfylLKCJ
 tgHQTi1Ot9GeIGlxUk12cR0JMvVWtHKvHcy4Glh5alvOqssknhB9oBzNvB0wH7HokpsO
 CRsA==
X-Gm-Message-State: AFq9FYLuP6+qDSxyZsUINo/nTKJHVGfqsKOzUTD3j0g4+KohdQHQ5Msb
 4R99UTv+pr0BvAzJXFYfOXtGH8UmRVR66hmSxWKWkeyhyVupQmxTdNdJetthJTaQGtJueWtj0Bc
 KXwZdRf6WnLuHP8ZkdWzpLOPAbmbr7xZRK1nnsynI0K30wRSjbwwXNqQjqrtXrcl80bzeyMTl98
 vhpVUtfn6MB4rW5PgnIokFhttPWPx3ucE7
X-Gm-Gg: AYBFou1yOc65nwTp5JCQxNxBzO3qPoXwnjUqrnoF301H7HWutdIQFOWn4OKx1CycvlH
 ecdr5iqwxiF9vW6N8+6gWlHpE+GhmhQB2bBHIq6v3KjWpafb792LU7WGWvsgSdZy45OkyFi6eRD
 Z9UwAyujlwwkwW/gJetTnfiknRoaIa78Idz6cn+vo9R8/gGBMkpli0Iyak3A7mnsDcPj3C3j6IG
 KKptmrqqC9A/CjopV4=
X-Received: by 2002:a05:6808:1a02:b0:4f1:5068:b962 with SMTP id
 5614622812f47-5535d4d0ff4mr1478522b6e.38.1792598187114; 
 Wed, 21 Oct 2026 08:56:27 -0700 (PDT)
X-Received: by 2002:a05:6808:1a02:b0:4f1:5068:b962 with SMTP id
 5614622812f47-5535d4d0ff4mr1478495b6e.38.1792598186563; Wed, 21 Oct 2026
 08:56:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
 <20261019172603.2625677-11-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261019172603.2625677-11-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:56:15 -0500
X-Gm-Features: AclHuK_fdH3gQGFMyfOSbS9q2Fy8K5DBeEBWtYrJBSPT_txfmNtqJjgLNakyFMw
Message-ID: <CAJ+KCYNd_Dax8srL514GdS8aa6zXQ7dUEXZYGpkfUgnmEuHMRw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] target/hexagon: add vsf* instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX0NVjiDreYMRf
 gTXNcmf4595inK8VK7QM8MPz+WDCUw+EYY99FkAwcwVgyDmwMlbK8bJFlKXdgD7QqSS5GPK2RyS
 IJiXaZXPvQrWleUgMNXmiuTgxFL6ZiwxGbauqVEodw0Ay+qAxhce87SSOgfzwkopM9KCB86qMz/
 ESIj9RBp1YLpBCcWC2U2Q6mdtn/PiG/n5fsa4/OKLroUBFJF2QmLUJSF2B5crpbhptzZQiBWwD2
 LILq/RlxtFL5OUnivQON7PUyh35dHCd/mG5hqubkZ1xUZerYdegCIyVetr+jfVD1cMPbJsLUG6/
 83J5kayU4V4iWN4EK2uQ9VrBWKHAgZsopaXE3CwbeyArhBoOAS+KGbvSRxy6iw7F0sVasbEeF7m
 Aym5bngH4NrhnZlWVazpmV0c0liA+b1/G2KJrz+CErREH2iuZ+4I8y2vTTb1f1UzUM8CwVws3em
 vlfo/J36iKODh09ZXBQ==
X-Proofpoint-GUID: vL7ZDcNe97OEfYwWbaOmNDj0csHiT_mQ
X-Proofpoint-ORIG-GUID: vL7ZDcNe97OEfYwWbaOmNDj0csHiT_mQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX0Gl7rLfNpbnc
 oD22TOLpVYkvLrcGRK8WyDuK7eJLn8QW0ulIrTCzIyJlHdZtpeDT0paHuPmlZnoELOwoG4c6KDt
 m0jDoYHOuXe6rOx+7I/d4fI5qP+YjpM=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad8e0ab cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=Cs9RqxKJYwTjZSTcdtkA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 12:26=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> Implement the v83 two-lane scalar floating-point arithmetic instructions.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h              | 10 ++++
>  target/hexagon/helper.h               |  5 ++
>  target/hexagon/op_helper.c            | 73 +++++++++++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc     |  5 ++
>  target/hexagon/imported/encode_pp.def |  5 ++
>  target/hexagon/imported/float.idef    | 49 ++++++++++++++++++
>  6 files changed, 147 insertions(+)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

