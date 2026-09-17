Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC93C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KBn-000612-0j; Thu, 17 Sep 2026 18:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KAo-0004h8-9V
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:01:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KAf-0004ss-Gg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:01:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLG1kk1544093
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tWmzpp2zEJxnSeVgLpcbQYlgia5NuIPweGhpAKKUhlc=; b=UJaJf14Qk5uUKEBI
 Pk1kYJeELrGPcz6KmXAOpTl5LdQ/XVFDVpPd31viGwY+GuhSW2tumUTbST1bgRBO
 3DhUWN9wRIkXgcMZA3CHOe7JZ+Dta2HoEGq/d56yHxJ89FFKIzIZI4S1inK/XF9o
 k7kmmL90N2RT1aWDhLAzQYBguOtrfoMEs2AxNKjffLrEldB18n1A4dHpAHS0AmlT
 WLqT+OGuV6QskMW9OEK2fLm6SQHwFl4re7f6fUSkCQ39Fj0N1KeY/8NDopTqotsV
 wVp6d0jVhytDuH8VJBCAYx+rdAp6xFU5ecPDy+i9VJ0fzc8ofpWOJuCEveTJVII4
 UYa3uw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjttspfk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:01:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc4b524ce78so12431a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789682491; x=1790287291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tWmzpp2zEJxnSeVgLpcbQYlgia5NuIPweGhpAKKUhlc=;
 b=AbO9ZY60g2aDlaLpFL9vZi+dj8jony3VeeQBy3tl8J9ILxSr/3tUqNtJdNT64hZbsh
 rLp9Aij6B8dAISAbJVxs9WqwrdwXUDSNUUo2ecGmtkcsbHbCJrLIm0qe0UI7DC4ANGv9
 mvgzOYBav9u+UTvJQ+VyqlAKIw5uzXoBLjLcZkLKgT/vSBca5/xuYztu72adQea+SLuG
 uctJwLbUP+Pjimjq5bPKvDRgQYiPS++oA9EaCKf/6l+qUVecqKUhxFnH3SmJbJ8NVF+J
 /y/XmZyjq1+kv/WAb2mbJrsu20smYRYq6myGC/uIagmY8vtwbvQxp8mO5rIuIiHseqrz
 pi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789682491; x=1790287291;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tWmzpp2zEJxnSeVgLpcbQYlgia5NuIPweGhpAKKUhlc=;
 b=CYdYMwajyFpZdcf3DWRpiO/VVwsrIuQD1eLwIQAmg3YEqEwe/TbSINxbK9EJ76ACOQ
 LlUQqXkZsDkW5aHPIyUJ27+4Xu2UJNkxh1uOTd7lxx5rTJv3xNYZ26m7DtmNfNQlFoOe
 L970s3nOGDeM0gHxY8FcVHcOCigzMdWqp87dlg76cvAgiGMgTZRgDtblQaKDuxPJ02IG
 w774pAMeb38OvbgWWerpf8hI326wfSC2OPxGope+wCQFEpvI/EmkojgqWBRR+ZrfIdIY
 G3XEg5p903++zI6NgzbW8P1B7moDDgOug6pjTmbIsZLccd6afxz5dygln0QYMWWjBFz1
 Rntg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0pYjeZ4vphbl6FOBGEHCn53zqCfDpbzYxP76Y9Enz+V7q0rGaVFSxDJg0RdkgPz+gtyoTM0YBwYJo@nongnu.org
X-Gm-Message-State: AFuF++k5FugkIvcbioij9DUuSXubo8UsOH0DxZAm/B4NU39UIFy9Q6bk
 zrGq5aDbh9L0s1tmyQ/3lcXmvdxR+CZFIZzxfYaIJsHgsZ5iypZPY/5Vn0A0/MuKdWYAKRX4zab
 8SzGvNU9t+qw/QtHSGgh7uT6PCqHCf5un6IPX2NjS9qXOPIVZSJVhkwS+9w==
X-Gm-Gg: AYBFou0mNiMjTG5sP/f0SXSihT2ewSmGwZD6i2d8GrAapzxXFwQWKa2Nw8JkZZ/taWP
 o9pbSEdDEKsMuXJXccDH/KIAz3yKjnJN6U+CUCJmP9emA9wVBq1vfkMIa3NEFDyJkb+wBW2Jdo/
 R0rwZq+S+nhLkSfGAyXNIZxkFSTssQwf3XWJ5HtgQIeJ+2vcH1EGWW+4c5YXHepIZRPl3ts5rzn
 E4EpTsj1cCGJnSF4yVF2IYLm5DnqMX5Naxt7MtCC9OJqXz7oyZBE+k8RWtV4lS+plKjXRmA35HY
 xOMPGoVhbl2nfgFd4Ed4sKgYCSgKB5ccEgq4IUlUOEl8tgNwFztJkDHJeT1d97h/z2Vvv154GbX
 34Xm/Z1z58O98gyQoD6K+WEDdEn6ERs9ySIT6milsu/fkh8lZwO/ENCHrXrDXoxs1ofla
X-Received: by 2002:a05:6a21:1690:b0:3da:7140:da35 with SMTP id
 adf61e73a8af0-3dd8c39ad61mr717378637.15.1789682490717; 
 Thu, 17 Sep 2026 15:01:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:1690:b0:3da:7140:da35 with SMTP id
 adf61e73a8af0-3dd8c39ad61mr717329637.15.1789682490269; 
 Thu, 17 Sep 2026 15:01:30 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aee8b0sm35831938eec.23.2026.09.17.15.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 15:01:29 -0700 (PDT)
Message-ID: <7048c675-0a02-41b7-bfc0-ac700a53d7ac@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 15:01:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] hw/riscv: Filter for 32- or 64-bit machine types
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-10-f98c5a244636@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260918-hw-riscv-cpu-int-v5-10-f98c5a244636@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMxNiBTYWx0ZWRfX9kaJFGVPlFr1
 eqibpts1jbZOmow5/NVrGht/MUE8L3fus8lLztz/0gOvTn51Ym81CMtUlkVN8vVvCgLbNhsyVgc
 aVMiTbtTycCKCBe72zukabIbFmKbL11OIQhbxqJalhbxBH9SVekvDWmOUTcfYBttf4HBjRuqD76
 yLvsJPBOcaE5jDgSIGf1+T8K3yfumDrKX4hHNXvjqm1wdiDn05M/Ahhhcii83GD2g80gUVib+e6
 Gs75RgC062w1U0dhB+m8s0gnXGv3lzhI5PyOGcjMF1mOHyNILdwymh/EaHE2kCHrucxdmcOX7w1
 hAiJUUL+8ZDZYCksKC2St8N+Zw8xJWtROMD7pFRLtayEQEaQiODSdgOH5bbbEZML7YthV1jXb3X
 M7CAGyJb5wFGNOESB2xf3PQltq6gpCpYPwy6nqCN+INoBC8Mpg3E9A6dD6Czg/pdg2h32jGXfYc
 K1qcy2tl4BAn7mklBeg==
X-Proofpoint-ORIG-GUID: mQyFLKhbnYVqU0U-w_3JsvCbqwxMHtPF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMxNiBTYWx0ZWRfX26XuoHl1L9pu
 UyZujeYxkQP7CyPOktCBVS7thlOFNiB5KZDOSUP4Md8+hOCoyn9HMmAbAV0wor0qUcK7OY6GxvL
 GfMkiX/W7EKBXUv94KFDuI4DQZcT/j8=
X-Authority-Analysis: v=2.4 cv=IP2XmQvG c=1 sm=1 tr=0 ts=6aac633b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rINQn6dFpA74SCEH0q0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: mQyFLKhbnYVqU0U-w_3JsvCbqwxMHtPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170316
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

On 9/17/2026 3:05 PM, Anton Johansson wrote:
> Filters for 32- or 64-bit machine types using TypeInfo::is_available,
> machines available for both 32-bit and 64-bit (amd-microblaze-v-generic,
> sifive-[e|u], spike, virt) leave the field unset.  For boston-aia,
> DEFINE_MACHINE() has been inlined to set is_available.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  hw/riscv/boston-aia.c      | 34 ++++++++++++++++++++--------------
>  hw/riscv/k230.c            |  3 +++
>  hw/riscv/microchip_pfsoc.c |  3 +++
>  hw/riscv/opentitan.c       |  3 +++
>  hw/riscv/shakti_c.c        |  3 +++
>  hw/riscv/tt_atlantis.c     |  3 +++
>  hw/riscv/xiangshan_kmh.c   |  3 +++
>  7 files changed, 38 insertions(+), 14 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

