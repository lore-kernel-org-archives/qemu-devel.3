Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2542EC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wli0L-00018i-3y; Mon, 20 Jul 2026 03:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wli0E-000188-Iv
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:01:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wli0C-0000CL-Vo
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:01:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RUHe1665557
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FALdyOvXzP70GeuDjWxy2vT/
 fhKw4YxzpYENnZXo9t0=; b=gBCGihWvHFd1hcmeMfOB2adBMh2dzFNQEACfQB12
 Iby0lkeAYKlVYsOHyn/ab45/GLdcVWsFqb++d5y/A0WhFqYWGlhyHoRl0XnUMzid
 agQ8iDg0K4jM66u2NfYRIqXfjPSJv01CrwXNxYykQfm5+UxhSAODuWK7TwxXQRcf
 /4vdYpFIqbpt0IEltdmidDPFN6fslDdMQhU3pqrZXshcdKO4FtccZUEDUoGNPxp0
 u+BGYVJq+q6oB/ooH/y4vyG0YKvyfEtJfmrUoskaNG7SxxZ4Vex18E+I28XRFi/q
 +KCD1+3rNcLYK+FQN2v76OH7bI6y21yw05z3mGMMOAWCQg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04uuar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:01:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a23afcbso80687201cf.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784530881; x=1785135681; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FALdyOvXzP70GeuDjWxy2vT/fhKw4YxzpYENnZXo9t0=;
 b=PERjIdFh+5myDahuqrR9iQyX3VH3+3m4PD7mgKLnIkyygX843zQcnRcdtBbT8S5usM
 Hn1LBGkz+JFX7IHqtX3PIXoqkpfP6xOZF1yCQM6e2cX3fd2w8F8HiRJJkb/9fWgHU4K+
 7NL0EOa9hA286KjU8/gc31ua+Cdk1xd27C+k/UjEcRYbxUoFINw3G+BOpTS/RHNNvCys
 k/t2iIctFfopLLgtSsvXu78Im0/SaDt7zoiGNUX7nwyS22vQgO6ly/NaeVtJAWQv2eqS
 CYu8GF8VcT3l0TgmUb/z1SAQhbOh8y7Y4QboEQ1s5iHt4syy3FS0u+5LFtWotRpxH/4q
 gXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784530881; x=1785135681;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FALdyOvXzP70GeuDjWxy2vT/fhKw4YxzpYENnZXo9t0=;
 b=RH+I2ealWikUGoMeY/gWwzRl4qaxKfDkb7QzicM/MbS6t9vZA31q4VA3VOkAJgm3zM
 U5KIp5HV2axdjFVCR982ayTI22cWKIi8T7nv/BFLyB0gGvOVEiRYSKgBPOwinKPQzNVv
 lgfNBWoE81ri4opn0V3h0FVX2ngcsy2DPPmiNpkc/eNV13xhu+FqqJpKj+xVbRXogTrB
 kxW54W0sA2PspKx0efgPMwdWpebhG8Uv8q/L6hy7+UP+7rhEZuGGmLegChrg7Mzyd3MZ
 jdjCmBbSdh667YO1Ll0e74hIIralT6Dek8/aQ4Su9pWQMdwVfSwEyziF6A37zePrKXBK
 MHvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFgZRjIp1Tu5LOgZdR/bJM3xHZkO+v2Ov/5j3bXemkoQBnHbg9dBPxpAoySWPNN/b1QwHlQcnGOdqx@nongnu.org
X-Gm-Message-State: AOJu0Ywm+extTaqrK1mV6nj6+ObMPmlsd+3TLRnc7K4WgtwdJRoBWqLT
 Lb/JS/XHzi124dOFEG8RgzJW63jeS6buPgDF4Wxg2QjO4YdcJ4TdouvYQ29MnMFvX02uVwRj6kT
 fSPiaz5d0JAT4Q0PMCln5PpVqV1fcZ/71iJ9GoRVB3U971xGW8qhyntLMwQ==
X-Gm-Gg: AfdE7ckHuZyyQdZY1aDGcIOwNI6+nIh+tCSCmKEKLDEIoIyT10dv1pgw5lrRRjYs3xM
 eqOD4/ycaUrltKlh3SAguOaMT7q+rmQE466o0v3K26lHlWMN7uhExSfKyng8mfEDFRnqaYOGR4y
 UuyW5exWd2xpoZV7Q6j44GJqrJ6XutCV9VBKVVyEF3kmvG71bFei6P1bfNqa6+KgwAarvj2rPoq
 jHKvkeLZaEOgK6w7j/K9Z8uh38gg9bYZJ6infSk43z9tH499FXq43oRaDn86OJyOWBsQ/T0hyBs
 mV5bbvIdZervOgO699xuiZXM7fAsrUaStHrDWmuYyNxhGFYuCkKCwmuHT1462Oag30zf1rI9k0Q
 /EsjxWj4ftIjKkVWQW5JSf4VBlZ1dk14D1Ter
X-Received: by 2002:ac8:5fd5:0:b0:517:76b7:7b3e with SMTP id
 d75a77b69052e-5213cdcce1bmr113574111cf.38.1784530880288; 
 Mon, 20 Jul 2026 00:01:20 -0700 (PDT)
X-Received: by 2002:ac8:5fd5:0:b0:517:76b7:7b3e with SMTP id
 d75a77b69052e-5213cdcce1bmr113573831cf.38.1784530879826; 
 Mon, 20 Jul 2026 00:01:19 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1712a63d99sm417208266b.41.2026.07.20.00.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 00:01:16 -0700 (PDT)
Date: Mon, 20 Jul 2026 09:01:12 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com
Subject: Re: [PATCH] hw/riscv/riscv-iommu: preserve requested perm in
 spa_fetch()
Message-ID: <blo4r5n35wddu3lf3eifkbuk5n7s4kfqd75vzea65j274hxj2u@j6vt7whhvhza>
References: <20260717144525.1154204-1-andrew.jones@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717144525.1154204-1-andrew.jones@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5dc7c1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pBlKQAIQ7nZEyNdry6oA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA3NiBTYWx0ZWRfXw6I0otE6wJvb
 bOV8uf82Rm94jHqDdaHPJXBaXU7rMOm3CBYhcZn2iamA07FLW0ruDpkaGtYNsuk7Hg+XNrsBmPV
 9dKGj0jF/BAhQ1gsSh2UYU812cR20ZIf7QdcCSOmSyWT/hhO8kr1GbAAvGZPkZLFfaXpE5FaQ9U
 bxwTIU3f2wbb+bXoCdlUMj6dqYd/wStzmO7XzAQQzAkiLE9phaLrl/7m7PN2KYWvssSZvE0vsSk
 155iOA2duQQ2bp0dfmK/BUn7GvX9a4fnT6grRT/nZ/SfYiI1ExCWMQ0Urmp+zTpX1t0cwcyvxi8
 a6eAtuJ+BDfldbQcQNLCT8GphM1zuIAJqLw8mLXni1HcIGgjgH0RPmZLyJjR1WmYi4q8/g2b4bM
 4W+e6QlDuw/2sABFIzjtEVeiOQ9ciQAdb08rebYaoQbMHjht/VJtpweLdP7+aPwWX4O+E9dsMTI
 So27WsoDPEgET05iPJw==
X-Proofpoint-ORIG-GUID: ojoFvLwz5g59kIpBA62GHSc3689caC6c
X-Proofpoint-GUID: ojoFvLwz5g59kIpBA62GHSc3689caC6c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA3NiBTYWx0ZWRfX+M7U4naquhIb
 44SH3SSFXxDR5wUvEWyMal1Gjl9fvV7E6DlrBjDS1kwDkW9RI6bEGS25lnmVUxTBxYfa0Vqhtpx
 +RaFNHc6P86bfFq2JWpqF6JHdZ3jPmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200076
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Fri, Jul 17, 2026 at 04:45:25PM +0200, Andrew Jones wrote:
> b18e3f0e2d0f fixed spa_fetch() faults whose TTYP used the leaf PTE
> permission instead of the original request permission.  However, it kept
> that request-narrowed value in iotlb->perm after a successful walk, and
> riscv_iommu_translate() caches iotlb->perm for later accesses to the same
> IOVA.
> 
> That means a write to an RW mapping can cache the entry as write-only.
> A later read then hits the cache and faults even though the mapping allows
> it, which showed up in NVMe testing as bogus completions and controller
> timeouts.
> 
> Keep the requested permission in a separate req_perm and use it for all
> permission checks and fault-type decisions.  Accumulate the leaf
> permissions separately and copy them to iotlb->perm only after the full
> walk succeeds, so cached entries describe the mapping rather than the
> current request.  Since faults leave iotlb->perm as the original request,
> the S-stage and G-stage TTYP fixes remain intact.
> 
> Fixes: b18e3f0e2d0f ("hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  hw/riscv/riscv-iommu.c | 50 ++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
>

Based-on: 20260717112340.1071148-1-andrew.jones@oss.qualcomm.com

Thanks,
drew

