Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9A5CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByy5-0004Lq-VB; Wed, 30 Sep 2026 14:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xByxy-0004LP-J0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:23:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xByxv-00053O-2o
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:23:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHed6x1198557
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uVV4OT9T8r6eFlF9IhWa8U2HQeZn0/yx5hL8hnOZ/ZA=; b=io67c3qEQP+N4wcF
 Yn5EmKb1uaMm6k3ehaZ6br/EHYdbh+EWGBNUhDfwYYyj1JHTtJgCXJGkBPUPtO2D
 3F2WR93/eTq3zzLglqJK4VryYuqk8xsqfu8fFPi6S5mhyMw+aS1SNy2EdFxxzlae
 dxqLEu+RymX65wCU65RJMUjGS+3Hud+/lTSXPmzxb3YbMaHkBWNNKju85+Wd/Pym
 HnpsPlP8NhhiZZkgcCHSF9uYesuxQv9OOPQXGuPn/6PSD+pmzNpUZqQEf+jS6daD
 kOK3lzrVg7JJvLMyH2HOwARqwoWq6wuiy2HVFOUa3EiGujBU0F4IC47QV9oKPtgr
 EkG6fg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136thd5q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:23:36 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4e937c5bd4fso3467461b6e.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790792616; cv=none;
 d=google.com; s=arc-20260327;
 b=WLha2Tlz11FGJnaG9BAiLJwplE76anwYPq/yFG0/j9OZuFgdJbjx11jt/5q9ua6Xm0
 B2D3+LaYSLGCS3LpEwPPDTPDoybZ6Gm+iIU/1rMvQ2hRDUu8jCZCEAOsILC7WLTDSn7S
 TrrBz3M/Y/nNvQMa0Xz1yGu6DoHkC6fP9wh3qVyilpJZbBucKhtTjyKm9jNfmwlB7T3a
 ZA7jXfWhvrdNqT230gt+q9SyAcZx4UOVn6A4dXoCIldSJ+0DMbBrDym+DtN6Wu9WHswD
 mpKtDQVdkwa0a8dgQGUTzsgIuzz7QauKW4wdjiNY8N7T6V1tkd1OB+qjLRMiQ2/HJYim
 pXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uVV4OT9T8r6eFlF9IhWa8U2HQeZn0/yx5hL8hnOZ/ZA=;
 fh=11nfX6Do8EaL1FMi+r6eKWxDDoA7QEpVbFRn3KjheFE=;
 b=LTZmZp0lOG4FsTweo5y+4oX6h95BGNvOCvIFs8xEh8uzYe0kKI2CH0STqc8/luJlJT
 WuFmWF0cOw6loLukhIntxwCSKt31Fkuz924aOyR5L7GGn/jNc0WQZcaSewtd571S+FUA
 og+pH16VqDA2KSy6VUKoo1wzQ00k3zmOrNv0cbaW0Ptuv990ee8WIsomcERIqKkSuNZz
 fAIXOulhipvCTyich0HfueD9k4hIYVjMp6Q7ZZPNNujQXgQSNVeJ5IHfR1H3NqvoqF/g
 JwijfpwTgUe+v1KjYJ3EFvLxtzu/idQ4x+Wq7czMonYzyj6//SOFUwL8c4K2hrIPSTDR
 d2uw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790792616; x=1791397416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uVV4OT9T8r6eFlF9IhWa8U2HQeZn0/yx5hL8hnOZ/ZA=;
 b=PI8kZPfSwweLdwPWq6UBsLt8BCRVyYyfsTS13oqD+wxlGtwCpdFcgmobnjoPhCsdIe
 1stlAiWLHtPYtv/101U+VJHp3m7EnxQBZvijs48pI1G5eOIw+gLvuR0U10K0QirZ2hzz
 W5gtsshKt6aHiMl7wghSdI8dYHRp/lHmq/90JaTK/C00lpsmIKaeQ7wiAtty86D/EFiH
 XwX3XM95rnDtrSZkccqpcFFQ4tOVa8gwrJ7swdFPRFd7R7d5PzHBpP/tyHNU1OnHfeKU
 NTNxTC4SRcgth7Z5j0302e9PAw2F/Box392xcVOF00iqVexTQLBWjiMeT2YxS+D9f7kO
 /4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790792616; x=1791397416;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uVV4OT9T8r6eFlF9IhWa8U2HQeZn0/yx5hL8hnOZ/ZA=;
 b=HXmDh3RBxJXSOfAf5Dl+w3g0cqylGlk4j5y9HFeVj7LBEYX3lcsXfe3HDXXarf8Mwp
 ctTYnVBteSmnJkSedHWAL67HfDiDFI0URYDWQ0Tn9ypiQbytMz9isFBSts7W8W/c2KG0
 nLyKYSkdrTLh8HqwDWTbz3EhQab6MxVeeIHxJGY2/a5Idkh2IBHQWMFWt2E5NcZtzU4R
 pV/v64U4flM3IJnsKxG4pdM+VCP4uA/9N0ErdkjQTDv+hboAMDqHWl85CezTNVm7aKTG
 jGI8XWXD/nPNA0ZClvIJlFVNmxpM/3prJmKuGLBIdjtoVeEkSh4R0slLomWOz3+dKChA
 aopg==
X-Gm-Message-State: AFuF++kpUcpfJpARKTPm62N7OY0PyQbWSShqDfErJJzTNQJ10+mUyvtC
 UzUzRiv1BGcbyVnPla2sjPMxaYlNqHyVzkiJr3K8ft073XqLF4OxzUR1JKrN86Y+/gxo/a0gHBd
 KieDmVgzkB0cMTzG6gJIqET521u845NwHHbb7GAgiLdlB3GtwWCEmzJ9bCjIk8GjdZuhu5bUq7d
 Qk9NqnJ/aM3PN+SV5mXqLS2mqfD4P5zvid
X-Gm-Gg: AYBFou07F+5Sa47Aj+nnq2uuDZLoEYrlHYsUMLpt3/QZkR8D2sW3YU7jvPMtAIIRAc8
 KDkML2hVHDX+h2Ag6cHMzN+M4O8/iTya3T1217kMQ2bIZMw1WU5RNwCx+1ORs0mqKC4879TFg//
 c0v6oi7Hz0Dd4oLr8XS66FaDldRdtrdWpjPHumU/j9Rx5/JDvVFnY0Rl5oZCVCua72H8WbMwNE5
 zIvjQ2sAnE5/krpBQ==
X-Received: by 2002:a05:6808:3a11:b0:4e9:73ce:e2a1 with SMTP id
 5614622812f47-4f1b75313bamr2396589b6e.44.1790792615983; 
 Wed, 30 Sep 2026 11:23:35 -0700 (PDT)
X-Received: by 2002:a05:6808:3a11:b0:4e9:73ce:e2a1 with SMTP id
 5614622812f47-4f1b75313bamr2396567b6e.44.1790792615437; Wed, 30 Sep 2026
 11:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 13:23:24 -0500
X-Gm-Features: AclHuK9QvXBEVgvCSGqmrOtJ-RkAQovGnARIsqgSTWjiki26i0M0tmychCQwQjI
Message-ID: <CAJ+KCYPENyZkgspL-a1C=8gAtpqfNTe5k91h835vqCHt_x0brQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] target/hexagon: reserve internal HVX vector state
 for QFloat
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3NSBTYWx0ZWRfX17Y5zzW0jtmM
 e+65V9T2YKmZbpKwiEZSA5GaCn+99D33A94B3HJqwSMrVH6Hn984ERq2MMKSIpWlcP3BrJEpQVr
 do68edhQc/wP09eDQmtHBiNZeB3PgY8=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd53a8 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=HNj8U96WlYJQXntw1dkA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: LQqcHRcY2DXhRztRqsSkYHI9webb_eTD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3NSBTYWx0ZWRfXx5qa+RKuShCY
 Ae2Ehw1sdV3in1KrbhN9YgTr18iawa5zKIBMKuGrLlET1i6yx7u4RXIObfyzKMnbbVW6p6kB+by
 J+YlDmK09cWFgie6dl+2Zm0r/wOP8XFkpDHyYTvGeQTpyTteCqOsfiA1osCivqgD5KJWHIyClu7
 xTRXaQsi3SJmyxLvyJnLbp0iLcK51SDCP1yqtCheGcX8B4UemNu8cy/KH2IFG2OL1azdKxhLnHp
 0NRmiJ+pweSV4trckrKR6x3a9Q7647oGsvymzs5Z2LtgVhbKHT48/CKlIgXPPhIklV1IQF1MN9l
 j7qjgutxholg3ceECDrLrOyLJI7TkdQlUTFRBKvZ79uZ4hE+eeAmCrVHUQ65eLN6fiECG5BcO7b
 dXvb4ESGcFfNdQ0NIirmsk/bGzjh2IwSRHyq+53o2iU4qmR/++OkgRTuxS+JBf0q72D72RHbh2G
 A6ZBwKUbJx8hTgrTSxg==
X-Proofpoint-GUID: LQqcHRcY2DXhRztRqsSkYHI9webb_eTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Sat, Sep 26, 2026 at 2:23=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/mmvec.h     | 55 ++++++++++++++++++++------------
>  hw/hexagon/hexagon_hvx_context.c |  5 +++
>  target/hexagon/hex_common.py     | 29 +++++++++++++++++
>  3 files changed, 68 insertions(+), 21 deletions(-)
>
>  /* gvec needs VRegs/QRegs 16-aligned within the struct. */
> @@ -26,6 +30,7 @@ static const VMStateDescription vmstate_mmvector =3D {
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]){
>          VMSTATE_UINT64_ARRAY(ud, MMVector, MAX_VEC_SIZE_BYTES / 8),
> +        VMSTATE_UINT8_ARRAY(ext, MMVector, MAX_VEC_SIZE_BYTES / 4),
>          VMSTATE_END_OF_LIST()
>      }
>  };

Does the version id need to be updated?

