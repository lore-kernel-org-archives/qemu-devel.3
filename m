Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0218CCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXeN6-0004co-HJ; Thu, 11 Jun 2026 08:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXeN5-0004cZ-LF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:18:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXeN3-0004Vi-Ou
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:18:55 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xLAg284247
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nG4RhqVXR235qoZp0sPWB2W+eCUDUcUi5suoW/ior0Q=; b=OP5MW1tuB9Lblq05
 WhCJ9Nmtai2VQHeTXr1jLcDKX+POlEywbgN6J0NAml2wUlB3saXwDqsLYQqzEtqN
 lk7wrHgNBCmJcBVLSa+V2jy0psbjnuq+TfIZgpFDNnFS4ikrF6b4iVqIf/+3+Q16
 XXOcGqaVRBqhdWTCgILWAG4DYRUZPtDmX/w1fJyqUEW1hgR1q4kY5zrKG2EribH4
 ZfJPOzKCdq5oK8DHFus5wKkP4I8kZTbYTQs269u4l91aZM7H9t3oIxfr3twRX7Ni
 hcY7MucDDsNSxdYhV6Qp81NUKy4O5hclLw1/msJjPKjoWkTbMF2J+77t1xXf2Gml
 aLEThQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tkbre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:18:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a23afcbso97911301cf.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781180330; x=1781785130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nG4RhqVXR235qoZp0sPWB2W+eCUDUcUi5suoW/ior0Q=;
 b=gMa/8/TG0T9m+xf2W+WtFOKgyTWEfhBHu09AkpZij1Szt+pnW4xc3XzKGM7eblap2l
 7UaspAPNZTzi2f+yvmQSaUtbKx9pT4oEIcqj5B/ZaDgoqbWZBfiSgrZjmaSLezM9lIbx
 qeZK5ch3jF3+XEZhwyRffQCDbAthakuTSVMPOPuqfIbditZ/i6rkHLrLnEvv1BZuC3J+
 G7YL5FWg+F6X4t7F/7hNaWyc0ra8Iq5VKRTz9QEX8Qbni1tpPTfNOCfhuUhJ5mPmAbKt
 +sB137XO4x4kjbmeT/zHt8LTptkaVmecVF8Vh+PSzSgmk6Yk+VUMnW0qIeHTB7R0OLqa
 0prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781180330; x=1781785130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nG4RhqVXR235qoZp0sPWB2W+eCUDUcUi5suoW/ior0Q=;
 b=YuhYvDrJ26hKGoEVS0BxyrHbR6DuwBRUOI8AAzXqbFM3yBPraYzXswIM/5cAxe97Pw
 hdINRs0X5+jE00JcodBtfCnTgXiZXxBkaW9HnDvvxRO1jh3UGLYW+UKLq9JMmMok7w34
 TSkvIEwPbHtCOFs8F9drGr54Q7bgYXc6qdw4hKLXu+CFGe6GW6hgn62adBJtBCXL/iiu
 +8pFvK5EWLBDux8y3x+EMKDhJmTNb3glNhrW7ll9ZXWPqCfSB+3MrFB1VUdIujJv5JdS
 4rL5YeDWIGk1Sj3z6v9Dm/ocJBZq04pjN9iP+e2qam9c7ik799r0HWMWciwe42hOEPFG
 LvwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mAPHarpG5QFxxGz2O76Gz31Ndp3gkLmI4wCMk4y9ttLq2ahO4f8La3OpkfBrA+5HgMhzb5Njr5r+M@nongnu.org
X-Gm-Message-State: AOJu0YwlZRTc07xBlBOXNwlfkT4EAHEtCAbui5PeWhgJFZqCgy/XHuCo
 Q9ocfQdXoyewIy295TFiIvIfXjAFwabEo9QOH8kTVQFPu5Xm30xvtjpawOvSE3d/fUw18HdS+ky
 AQkbrJwZfbEfjgipTnMZSFoll/BycLgmcFOxVAojOTo7gY5EQBAXzTSkh2Q==
X-Gm-Gg: Acq92OE699THRByeDJxwhoG0FTm2F3ZLOhT8pqLDN36UatHAg8dg0YdZ+AbTQ2FrbYz
 0efnZ8Zp9QXCgAvgAOSR+Z6UnDjVrXctGS8IjRPhboyLqrHU1Z2odSIdsV8rqMQxkoK9ViTpsfm
 cNPMQ1wWvbHmnpcoT9cMc2nWaM6VNP1htxpIJ9z2RZWtkwxjk2RQ8954EsOuSsEGkkmtPGg1ecd
 1ah49GzlIbo7YBWLrxRsB6my6EkJD60oKVrl9P+B5jckqVEtXN3nDuLLVR7oH0psxJ4npUsVdxI
 XLTEmRntMLU+0lNYlFY3avjIvuUpq5m2AHgkX0DSgTuKxNrP2AUfZKRwGbefPgQrF5P+v0D2ejk
 myCkiGNa4P2m2jdOlqjxyOTdwJlbqLBcwvYOm3mgQ2kQj5CFtUBKwDETW33JcPYajrQJjqJFsPt
 KfSB1yGHs=
X-Received: by 2002:ac8:7f95:0:b0:517:8f52:2724 with SMTP id
 d75a77b69052e-517ee21847cmr39883621cf.43.1781180330081; 
 Thu, 11 Jun 2026 05:18:50 -0700 (PDT)
X-Received: by 2002:ac8:7f95:0:b0:517:8f52:2724 with SMTP id
 d75a77b69052e-517ee21847cmr39883021cf.43.1781180329588; 
 Thu, 11 Jun 2026 05:18:49 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e52a553csm49355205e9.2.2026.06.11.05.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 05:18:48 -0700 (PDT)
Message-ID: <300c48cd-7523-4cbd-86b0-90cbb36b92da@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/qtest/migration: Add migration test on loongarch
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
References: <20260611084312.70042-1-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260611084312.70042-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNCBTYWx0ZWRfX91htFxdO8s6c
 BNHOWsSebMjYcvhZgq+H/V9vAYece1oK5LYm/VcJH933iqEo+FnibG+XMwvUoaN4l9KdhHMoT7/
 Tlhru/+cUdDWWxwRqD3/70Q5Q7FgWsel5cC/IDtGi9dkmGrb02zXYUl4/PPx3QGj9VCXQ8o254/
 0S2WKl2TH7MAHD6bdFHrx9/xywP8SiXNINbEyhG+DLZ0UJenOEU3R/2jV/kSVS3rNhHuzNXOsmN
 Z5NNqZKuGleAAc1ZDnMoroxgCxbZUaLZHv11IV5AXg6ifYZiLu2g6eXi0B75SGRmwcC6KAAR02K
 1eOqDVIKKYw6DJChxtPNZUEw2kMucKBx64lWdMEYhdfkH15cxVoYW1fWiofJYADA479YlykvkiL
 Rz2w2l0d33Uj2SjQfs2+87kcLQ81JtvzKUaLBcfBX0tUB7d5ZCAMfDzwCWN6DvbPnA1ZEchyX2K
 glbXzvqCokG/qXuKyVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNCBTYWx0ZWRfX0IA49NuyxTIl
 CnrSqImv/Vd1MWqZFf7t/fYBvsbi2wubWA3+Gq5KAz97rt9iQ/e6kPzHj/0Dk2xX8PzRWPst9dN
 hRLA5suttcAxYGGD8S/gOupNIOho6uA=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2aa7ab cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=wjZwgo66gYYFnpJaAzMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ZVDcmYT0SecTkMAF7Lnv_u1DwXidpXRt
X-Proofpoint-GUID: ZVDcmYT0SecTkMAF7Lnv_u1DwXidpXRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110124
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 11/6/26 10:43, Bibo Mao wrote:
> Add migration qtest on loongarch64 system, the test passes to run with
> the following result:
>    qemu:qtest+qtest-loongarch64/qtest-loongarch64/migration-test OK 15.94s 9 subtests passed
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>    1. Add SPDX-License in __note in file tests/qtest/migration/Makefile
>    2. Regerate file tests/qtest/migration/loongarch64/a-b-kernel.h with
>       __note information
> ---
>   MAINTAINERS                                   |  1 +
>   tests/qtest/meson.build                       |  3 +-
>   tests/qtest/migration/Makefile                |  4 +-
>   tests/qtest/migration/bootfile.c              |  4 ++
>   tests/qtest/migration/bootfile.h              |  4 ++
>   tests/qtest/migration/framework.c             |  6 +++
>   tests/qtest/migration/loongarch64/Makefile    | 20 ++++++++
>   .../qtest/migration/loongarch64/a-b-kernel.S  | 46 +++++++++++++++++++
>   .../qtest/migration/loongarch64/a-b-kernel.h  | 20 ++++++++
>   9 files changed, 106 insertions(+), 2 deletions(-)
>   create mode 100644 tests/qtest/migration/loongarch64/Makefile
>   create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.S
>   create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.h


> diff --git a/tests/qtest/migration/loongarch64/Makefile b/tests/qtest/migration/loongarch64/Makefile
> new file mode 100644
> index 0000000000..3c8cfeee86
> --- /dev/null
> +++ b/tests/qtest/migration/loongarch64/Makefile
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# To specify cross compiler prefix, use CROSS_PREFIX=
> +#   $ make CROSS_PREFIX=loongarch64-linux-gnu-
> +
> +.PHONY: all clean
> +all: a-b-kernel.h
> +
> +a-b-kernel.h: loongarch64.kernel
> +	echo "$$__note" > $@
> +	xxd -i $< | sed -e 's/.*int.*//' >> $@

  xxd -g4 -e -i ...

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


