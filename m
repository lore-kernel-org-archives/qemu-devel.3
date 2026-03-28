Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B6110F3DE9
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 16:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6WW5-0005cd-Dq; Sat, 28 Mar 2026 12:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1w6WW3-0005c6-Pb
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 12:28:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1w6WW1-0000E0-Ta
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 12:28:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62S4CNSS2276226
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 16:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PLdjp/2MZi6ikQd4OUMm/x/N
 P1FzG3lV9fwIT8huJH4=; b=PMRIfP90XQ8akZCeJZ/Gyi2noyro99Bn2jjMqNYW
 UdY59LntSVWAPG4V+XI92wx+sz07MaTu+ffSg8Q67vL9mI6kvUsOOS+XywKlsMU+
 YWYQPAMvZV1aOypB8FZPawi+1dXP7oWh6pcQd8vYWsxSbGj35VXa1VccizQHsDwQ
 OF6JNQhm25OZsrpKmBhn/O6okukHC+PcK9ziW7oQTGMfQlYyD7fKysSQQ7bZZltG
 EXRTtGsBUF+dRGPnSBxvmzXziSI/luO0KJ8PNpoHPdS1RFx9nUfACDU9HE2tDvq1
 +YN06eN0czrrvGMxqN4CmjsI3CRf6nePihZgNUyKeR9e2Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67rc14d4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 16:27:58 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-127133794b6so2649079c88.1
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774715277; x=1775320077; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PLdjp/2MZi6ikQd4OUMm/x/NP1FzG3lV9fwIT8huJH4=;
 b=LSvzrS56ocaUo/D49FmhKThab2UPb6Lt6QMuyou+fX/vQZo0LnBGWuY7gmSYh5yQgm
 fz63hZUHQtwbQ7xVyU1Ihf/Q0fb6EEywK4CVJUqpuPYBtqLOfoy4SHE1Xt54cL9/yGJA
 gEIPLtRbUzCwlThRuCyye1XOWcBO2owf3AzJCdtuEfZaalF05Xapuw44lP+cxcu7hQx5
 GBiIWxmMuvuXOnLCPJGf3yF2AxdL+1niAZDuIa7SItdUrUjHosZopWLSPne8tP3QnQ+b
 Y6APG4atmB1UO8PrQV469+umz15NCQSb0Bs0r24OBR8WuxxrhI9RMxpV9LC6a/b3zLpH
 avqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774715277; x=1775320077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLdjp/2MZi6ikQd4OUMm/x/NP1FzG3lV9fwIT8huJH4=;
 b=Vprg5cOjtHsSf5ARe+N46G03i6NxcPlCtEE7DXO+RBGNSVJzJps1tMES7aff3Aefk9
 Dnf+svJBMk9VuUs+fmD/vk0IyOrwdGkqClpHuP4/h7mjXeEhMvIH0LXVUt+ckpZj3Qi2
 0yc++NQk9430RXM7KYRmdzdrCKiB37xQuX8YxsnCPO0qiFbz9NHa2ADfwGuyg8S+nR23
 Njv9dwwWhJkH08qfXdMFHDyqREV36M6NRF9XAGIoqDEhvVvHG1ysvGgHwdJ81iXtkh/k
 t9AEr2CNg0evaZmW1KOqoBOdC0hCcDrgNrNtB3GEHowI7IOjeWa7d7PWgOZQ1ZLFcpYm
 /abA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi9H/YDehzGdFFk1KBJKHQuWuUKYD6Q0/4+E/R3PBvV8fNvx5xVd/PvJs0zHVYeELi5p5JnDD2Z42f@nongnu.org
X-Gm-Message-State: AOJu0Yx/Qk5ITbO+Yot3sBTPtFf84Q6uDMcqC376oraalrPGQzD9B/9q
 t3kKQ1YFVpj6O3ku7FIfnRGWZF/HOh1u2RcTKdyB+EJYmY+WqquqD09TeMmRXqq5BbaZ3S1nzpP
 XoA0i6EZ8X2SR7cKAkWukmxIOPQ7AOncAvPWTQZ2s7Na6sO04jwR1CbJQng==
X-Gm-Gg: ATEYQzxgGV0szInAxdvMF8+YaNJBRdkiBiYEVbyDjvgzSjHGHVGXrIbMaFeni9rwS0F
 wKB8n/ocPQGrdGcp3xy97Ncw9BM7KP70SSsTwewuE4bAqbmisVtfDMjnVnJ1Slf+kecFUUoFAzy
 czJpQWAuXofuVhFhsCsjqvo7KBd9nuppd1CHS+5pCx+TPQPLoa1Ol0FAJQgIny56z5RlA7AdVGl
 0YhN6hCT4Sx8OGCYuR5zQZbCNcXCjSBRM3qNPiBauIbVqWDr7fFH5dAg9UrzHvhwEf7HlgjuKBZ
 5fGzYwcIGt23ci7r94XxH9kV0L5z/mxpS+qOTPfeHZ433dv9DpzA1nD/F/cXDth8eLzsdAcB4/E
 +KfI0w5ZJ7B/3jbVOx1p9Odq9rUz/OG0=
X-Received: by 2002:a05:7022:e12:b0:128:d24a:a5ba with SMTP id
 a92af1059eb24-12ab28de7cbmr3472092c88.20.1774715277496; 
 Sat, 28 Mar 2026 09:27:57 -0700 (PDT)
X-Received: by 2002:a05:7022:e12:b0:128:d24a:a5ba with SMTP id
 a92af1059eb24-12ab28de7cbmr3472087c88.20.1774715276943; 
 Sat, 28 Mar 2026 09:27:56 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12aba581027sm2721471c88.4.2026.03.28.09.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 09:27:56 -0700 (PDT)
Date: Sat, 28 Mar 2026 11:27:55 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: sunilvl@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, geshijian@picoheart.com,
 wangziang.ok@picoheart.com
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Use kvm timer frequency when
 kvm enabled
Message-ID: <wwbnbmyjleexj5oeky2zzcnyuiquv4tpkghgwhku6lbtdlbptw@ixri3vydbycq>
References: <20260325081314.57089-1-yang.yicong@picoheart.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325081314.57089-1-yang.yicong@picoheart.com>
X-Authority-Analysis: v=2.4 cv=atu/yCZV c=1 sm=1 tr=0 ts=69c8018e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=TxhyHGSeAAAA:8 a=EUspDBNiAAAA:8 a=qZ_sBrZlEmmpAHPd5tAA:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=VRTRSrWG77IPp_BSX07q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDEyMSBTYWx0ZWRfX+vyMSwu9X91a
 ua+DTuMW6bONPMMfyC3B9M/oBlkz3uMylrjbH264kNP4bN22/McvOHGlzdXi27uMlnBQz4CETn6
 wIT9vOGEYZAZbC2mSxDzPnoz+KEA/O7g5Nr0ok5HhpXEIUdvqGBJHD1QpdYxR/v8l4wi21j7S1P
 JA1UOC3Ua6vhqqInQUnK3vxbGY+9cNucDg3wn0KJQUFmgEJlW2ojdstHJA7cv2zzqLvu3ArY9Y7
 L1oq0pUXfkEq6P1fQoBLKIIqTidhG62tp1xTe+M0+wUEds6sSQ8HeJfZaC+wcgYv3G2Xf9u76hc
 y0wofSd71agBWe4QJktjM1vx1vgqZgJouBx77vsUO/y/XRmP3ck5/mxTHWptGcij3y0JsIUkh+q
 jXFtVf+ElU+NLcQgZG1hb1HiuQah2pk6O9W7O1JCnaxhE5EA3rW3ezVkjbCvvq3NG5Jd148hGKI
 A0FN+iw7g2/hRHPPOyg==
X-Proofpoint-ORIG-GUID: RT7mXDKa2iLj5a8wolODDj25xbTJsA8L
X-Proofpoint-GUID: RT7mXDKa2iLj5a8wolODDj25xbTJsA8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-28_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603280121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 25, 2026 at 04:13:14PM +0800, Yicong Yang wrote:
> The timer frequency is decided by the host(kvm) rather than a fixed
> RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ on kvm accelerated VM. So build
> RCHT with KVM provided timer frequency if KVM is enabled, just like
> how we build the timer node on DT based VM.
> 
> Fixes: ebfd39289370 ("hw/riscv/virt: virt-acpi-build.c: Add RHCT Table")
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
>  hw/riscv/virt-acpi-build.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index f1406cb68339..fd6ca5dbc4ff 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -35,9 +35,11 @@
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/numa.h"
>  #include "hw/virtio/virtio-acpi.h"
> +#include "kvm/kvm_riscv.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "system/kvm.h"
>  #include "system/reset.h"
>  
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
> @@ -296,7 +298,10 @@ static void build_rhct(GArray *table_data,
>  
>      /* Time Base Frequency */
>      build_append_int_noprefix(table_data,
> -                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, 8);
> +                              kvm_enabled() ?
> +                              kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
> +                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
> +                              8);
>  
>      /* ISA + N hart info */
>      num_rhct_nodes = 1 + ms->smp.cpus;
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

