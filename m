Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1C606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gAktDOan;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KLgyvbdm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpg4-0000cy-SJ; Fri, 30 Oct 2026 12:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMpfy-0000cH-EM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:42:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMpfw-0001LQ-CP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:41:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERkkl3207566
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hMFQ7EGS38VXly+iv91YrNj6vZj8zzLpBmNceCWJAZg=; b=gAktDOanERnInMfh
 cj21FTVWGjf4/C5bLV96OWdGc/5P4D5qEv37OccqS1USQL7feFnVGNQrZrqePN73
 hdblSgySSixLVMxscjIYM1y2ChmxwbytEb5lcJaQJ5X+AhxcXrShaB0hDqE1rIpH
 QDAgzi69byXOTVBYzmdLLyzLzqUUpuaqO3qlI/xtAYGAWP7fMwT9Ru1lcVFN0wOw
 SeS0ftl/LZkfYhxgs6O+ucbxf1TmrwyfAMMBhLrq2Kb6Vg0Ekro4ZeE8ukS+1BSi
 VqCnUNRxo+47hdtQH4XwdjEFeMD3uFXVv0Uy9SRz+5Owi0T0lI3J8q+ca3510KF2
 +gK2mg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm1ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:41:54 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4f4612a1a5cso2455380b6e.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793378514; cv=none;
 d=google.com; s=arc-20260327;
 b=I7N2MWf8+GNKX+ar9v2Snump5klsONRG1l04lduVkGw1loVS1fCQTViTa7rZqHb4DK
 iNRA8sID9apWWCLZ9V0gEks+MWHUMs0x7pYsVwN2U/IG38hMXXs+NbBTzvcKFPbQDxOV
 7Rrz2prSrnrzvvj8YVi9Z2AB4Hi1758LCw2rGZuMJR60n0JZflO15dWqKXyKtIcE7u+Z
 dvxl9pN5RbiaHhoIjW0KW1Sc6M0Pt34aJlwF+nhGpd/rdFfCeNl9gs/LNMGGK8Zaj8DL
 ibmALUrxNpJDAVUXaOJQFr+PX7MlF4rQKWAR3srhzfzXBoF9DiU0sOFpjoCkiVOx8fb1
 rvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hMFQ7EGS38VXly+iv91YrNj6vZj8zzLpBmNceCWJAZg=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=KW4D36TgclUzjKQEgEEZNZ/x72MlDDpzjZdlze56Ot7lfkCfz6+K5UHqz3XJIJI2rp
 Nzmqvn8vWCMkzfjravXPdadD1fni40MUAjui+GxocCCC7Ek912XAzgjaIyqIjNC7dM3f
 haiFzy0/Bk/mECEHEBfXldcuaLMTSMjk0GIYZUk8ApsZ+qatB5GOQ0PFY19QXpkEk8c9
 AUBhc9YAMUS6GaOwS8EBLOXyrnMKlN2X7bPIkCGW9um90c0/wrP5/BulHL1hw6qf9Uvr
 ho3FSBKPnQMc82Y/rj5nGDMtTmaa+vCsJxCMIDBVm33oOzayD0obB6WF62nJvOZSKJa2
 UJuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793378514; x=1793983314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hMFQ7EGS38VXly+iv91YrNj6vZj8zzLpBmNceCWJAZg=;
 b=KLgyvbdm199ZPRmV7FGL0LrDce0Y+TSNwzKydreTpKUgZZEP3L1W/z5vHnvB6Ru1TZ
 UExHcFz+Rf0PPEf5UFPLlwR2kpgvGGUyg0L563u7+9URUlhK0Z/TxMj4iPnbC0NasyT2
 kSyYbHmxbGaeFSq0DZCKa6I2UHHmDdh8eNX3VD19lnOY4//kRDQZ5vy80P7c40JLc1Kt
 uDg0ZUGsh2/P+ZsM7+RMo+ZF20RN8Plf4Qj95NL+PnwZGUFd2Xuu3sHARrQrZ02w+UHk
 wLK2l3fjQ5EmpFU21U3HyDXTuWW/VPyrFcNt5RPgldUPQhT9p2Gmh7vS+aNVF49Vr7mQ
 /QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378514; x=1793983314;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hMFQ7EGS38VXly+iv91YrNj6vZj8zzLpBmNceCWJAZg=;
 b=IK1vf+MQbzeDwl2t0wW1rD3VCW6tHYQt4T5Pgay1mXsCZUOCJL4tmNhbyT3uMnf+my
 1I3yNNiW17E9y0+yS5EqN5KKRLPim8ZBS+gTW5YFP/MvS4Safk79u6VmAeiar27TPrgF
 7BtN+hQSKI+R1MDMcplNNSys1mcpFDJLIuzH2wplXHMZNFQTmN/5f01aQcemzdUmQdWC
 OuqZXj9aJB8HQIqlY7L6hTIYNMSB3zC+S04As4vIMskrHTfEEKxsZylx0c5CoZLSNM46
 ueyuhU+rsOdnhAzUcgCuarNQ/MA/KHPbG7MErugL/Yr7M0MrH9B0BRuWfdOeb9CTH/Ez
 /e8Q==
X-Gm-Message-State: AFq9FYI+GcF0uJ+aoamcmt17w6Im9IDD7BqPSi1861hsG1c440MJEtwC
 5VK/oX5FfxDtS6aNiOr+DNByHoIPkQD8E5IZjjWt+r/KJr8DLIgMe/lgFH9kc3KdhW0jUmLOEH8
 jPYnF0GxOiMJl10OmP+YjUepa8UkvwPv4VyXOzl1m4Jd5Nmu0Cs7gSeiwD7/SiSxx6WidYwpjSx
 3zJiLVcj9FQRM3WDhTBUh/1XJD3i8cAPdU
X-Gm-Gg: AYBFou0wALNZL81eTkmq88ZZrxzWc0UgJDcuMRVu4PMSSmIvSPRWHMktVb56xsw09+F
 UkZ7aMUlZjW4M0tYC4+fcupgmksiso7BFe1HTPYtnjPyJsYttSkkN7vCpZExOOgp+cNufret/2f
 pCFUaEYv+vtiWt72JBGtct6X6rWvcNd11P+qMeorzj2+ZLY33M6cC2mzfUD6Dp3IGtT34Bby85x
 701V3X6rRMZOVtHO2E=
X-Received: by 2002:a05:6808:1903:b0:55c:928:6a0a with SMTP id
 5614622812f47-563ef93a3edmr3066481b6e.15.1793378513648; 
 Fri, 30 Oct 2026 09:41:53 -0700 (PDT)
X-Received: by 2002:a05:6808:1903:b0:55c:928:6a0a with SMTP id
 5614622812f47-563ef93a3edmr3066467b6e.15.1793378513197; Fri, 30 Oct 2026
 09:41:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030034928.2135408-1-brian.cain@oss.qualcomm.com>
 <20261030034928.2135408-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261030034928.2135408-4-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:41:42 -0500
X-Gm-Features: AclHuK-b1fylVEkvNdE1jwZzD860CLwOEG6_F_yRLZ4GOF2hLgnvJjuj5R5KMeg
Message-ID: <CAJ+KCYNOrZqSqQq9sD7v_9pPmzdhS0uwgwh7CDp3iQDAn-B0uQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/hexagon: add v81 HVX FP8 and qf16
 conversions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4c8d2 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=QOD6FzFQDzjD5Mkm1CwA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: 3HYKhhx0mSlKquVZUjdzX4jgY6cw140S
X-Proofpoint-GUID: 3HYKhhx0mSlKquVZUjdzX4jgY6cw140S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfXyWyExRK+dAED
 RLQNoFjNPdNixV7Dgs7lSlbCHlZXSd02ZRO1KUYm3lB3N4gwTwYY3zi0ZExeRC/bjaX/J+TcnkR
 QQCbIS1358NsKe0CvXDWoqyghF44NQBgBEJmZLmNJCfOaV0HAvMHejvUFzmHEs5tC9DZR7SdYxQ
 esywzjmK9xNt5yJFZrz6txf95nOMuHtUXhO51w3KnjO1wxUtvrgRRKPP19E7Do1a+6Gg0u+HRpb
 LXMBWMZd9YyUSSAFFmraUwYZz4jQkMit6yqV8TkkdjfddPoliwT9E3AnVuHVy+rqx0VpWwJ0yJM
 Fk+iPK7QoVHVmNdW8rpcXx69TFqyNd7prt+efEW6HGEC8aul9d/FKlh7Lf9C6AgxtM0b2M5PI47
 oBEGCt+K2VGxXO4+yJA/74i1clr9bhZgzcmdlBTsRMptMhZNiJ8JHNtrY5SvXN6z6BfssFp104L
 dfiwe9fRxgtibBRNwnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX0AOi/uRNEmwV
 bzT2wSy+LRV2lRKc0LVTl9mrUfiXj1xEHEy02hRs5x9gvOC6wMoHJILy3LLjx1Y8wpdjDEc3kPa
 ENcoCI+EkhzkikL8KK2ztfzYKIH+wQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300066
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

On Thu, Oct 29, 2026 at 10:49=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> Add V6_vconv_qf16_f8 and V6_vconv_f8_qf16, which use FP8 with exponent
> bias 7.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_ieee_fp.h           |   8 ++
>  target/hexagon/mmvec/macros.h                |  20 ++++
>  target/hexagon/mmvec/hvx_ieee_fp.c           |  21 ++++
>  tests/tcg/hexagon/check_rev_gating.c         |   6 +
>  tests/tcg/hexagon/qfloat_v81.c               | 111 +++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc            |   2 +
>  target/hexagon/imported/mmvec/encode_ext.def |   2 +
>  target/hexagon/imported/mmvec/ext.idef       |   6 +
>  8 files changed, 176 insertions(+)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com

