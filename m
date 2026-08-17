Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A851C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoL5-0006dM-Ef; Sun, 16 Aug 2026 23:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoL4-0006dE-Lc
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:48:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoL3-0007Kd-8x
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:48:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GMeqfB3834548
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EsLBxE7C6yuhliAVoQd5K4lTOTwWVs9jvIfglrYIGMA=; b=o+X6ZC7uDJU5eoci
 SKIQVjxFklujwGmjdKBaWfO1wyHWaXJjiEk5w7+cAyYpAROjqSDN0ncVMR4jh8C4
 35Xb/F3xs0F8UCoUlncKQjWs8dVmNXnoio7RFSuy/5Qgo9BcQVQkO5o56mK0PUiA
 KgLURGkqDnCN4OTMhbon/TxK9rpbKEyIY1LyD7Trj9z8Eu0NgD6EZrFXS/Hxj7JM
 I3Pp0/d4sM+tpn9P7674VoN8GJYhfI5iZK12I+Jg7N005xDhPlu3hzt6s8zdKOXG
 B/B+WD39v5UtfL0URsncKi0WXIrMr/VOr2pmNv05+GVz/rpwBAQUZ2/Vjw9waXO6
 qPC5Sw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gmy63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:48:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9080b7b2f2bso29728986d6.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786938519; x=1787543319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EsLBxE7C6yuhliAVoQd5K4lTOTwWVs9jvIfglrYIGMA=;
 b=VJYLn+Pbaeu6DJSwbPVqgxIfBVBrG18APtNAww4CnZ56BbJqnWEsKjhyB+nunFFSOQ
 rvONXbUtBSPMzkmmuPNXiVFDlsiveEXsK2EaNY7Cm9tj0oiB3DYiVDYL+kNkoJHpMADV
 unXVl6ZUiQTmO9uogtmCxoaTEG8JZjKJTbpXi8zyd94l+eiGVk9B6grPXNJCvCoUmC4C
 qnBE3hJkYeG7tEoQff7iPXLUuGVJ3xZwBwtimExWbrOqlxfWXPzr5kRrL5YF19bbZU+5
 LSqKYSM5ryZpOfw4VFUpXsVOU6t4vT4dq8MOotkUI4TLjbeNpRHxHM0BULTspLxcf/w1
 3WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786938519; x=1787543319;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EsLBxE7C6yuhliAVoQd5K4lTOTwWVs9jvIfglrYIGMA=;
 b=auR+h8PnFreLFa4s3fexcWOYlgJ/8Kxq7fJFiAl45nm+iKtjlvmNg5P7vxtLhtjP5c
 72Lqg9hW7DLAGU4a2DR0r26heNgmC1vV/zzOlAxMhiN1Ms9CQVgc4SA6qr0Jo9s7y6I6
 PdgkneESU2eKw/gXYSt42k6lH2eWKzTowww2PsTIxXAxmahFY9tPQzPIK7MoQ+r2F8nE
 1AZu5VwzT2EsyyAn7mbN5r4nELcTYnEojCXh83FPmm+UI9UKgnEnHEkud58Iy6DOkQV7
 ffp+VNg95dwF7Mdd0dvkXN5nB9qNgqga43Q4C9VDhi+DPP793Os7HeGZGCk+u9vCo7x1
 MhYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqN/rcFTdmxL+zqez62E1OerBzqx/0vYRpHAE8LTI5uklHZWX+dQOaLXGjvWvb+w1oUFKoZ1ETT2TvB@nongnu.org
X-Gm-Message-State: AOJu0YzByaCuWtv8BkXkcwCODd/pWeor7apCKJJ91U/Xb6DQJu36buuH
 3XS3SXIi/9on1T3CiXDaa/VAthWmXQisVBevNG8Q/ILBt8F6Yml1SQMnZ2fyIssOVodM8vn48Pe
 sFHZESspc31XkFLwRq6cCTOWHd9bDux7+ubIeStzjlSOj2Qw4fwo7EXEARw==
X-Gm-Gg: AR+sD10MT2CcyHFOKiIOnWUOysasRRejy1AlLWP9yHJeRB0nfWQeZRttGQLpCu7dCWB
 tcYYBCOrxCVi/9BVKYNSpyOoa3kLY0UEXjnNTXYEbrLDMIXHbJru0z3D8N+xJE4iZbgNpqANKPt
 3OtX45d26/TMh4n3V3W01TbmgoakbGR8YVG56ijyA2pPPWWpqSbt4jOXYk4x9Mbno+YQgS0xzQ6
 iVwJwPoiPBFhneQvikTpFIb00+UVG30MloFfy7z5oA3iOIBwBdMKWESbgDU+IwtyVAahoSY0hee
 e0cZO/J0LP4L7ZAYrCQI3ADqRiB+iVvD/TT3dP7Azf/59Zs2jnzNIgDCf73dCQqJ2ul4BAWC+IK
 5Y5S1nsp3gYC8lyOESEkRGVV5PocPPG/huYI=
X-Received: by 2002:a05:620a:2683:b0:936:bcd8:8650 with SMTP id
 af79cd13be357-936d230591cmr2147907585a.38.1786938518832; 
 Sun, 16 Aug 2026 20:48:38 -0700 (PDT)
X-Received: by 2002:a05:620a:2683:b0:936:bcd8:8650 with SMTP id
 af79cd13be357-936d230591cmr2147905285a.38.1786938518479; 
 Sun, 16 Aug 2026 20:48:38 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d20fdsm211481035e9.1.2026.08.16.20.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 20:48:37 -0700 (PDT)
Message-ID: <a0efd5c6-6af4-482f-9646-b917efa0ae29@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 05:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 39/49] qdev-monitor: make print_dev() callback take
 MonitorHMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-39-e53fc35bc550@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-39-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RCCroz3RLylMOvMDMLs6DY7BUvcN5pkV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfX6hu8VUuh+fOI
 cBi9rQUV+PkzU68IYSmF+BZvymgPsIrkxVSYX0IYCgPfFZH2Yuwl4Ly8elPQvr2+uhVKT0XPcRN
 69r6f9pAguJUxk3UUAYQboh76yifiHU=
X-Proofpoint-GUID: RCCroz3RLylMOvMDMLs6DY7BUvcN5pkV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfX9TWrvvzzomOO
 zCYZe04bU2DlegGqHDanzLaGHvq75MV2VaifSsN+GAnqUh4zRFwW/SXw/qzXQQnbsyiTghAkHoD
 j5ymIGqxIj/6CqByw5g+zmYsgyMTUwI7zVUC5zHdunQBMmnjB0cxHNBUBT/MC2eLqSCulLDEGWz
 HpyRGCgvpe7r38iVGxiYYkAVUdDlgaWypQ+V4Z+1ouQAKaYSBFuFhPST0e/hxK4jH2mKJ4A8hcR
 8CrJqOk1tclRPYptwM+R1DQFbLT6pOdvJq+HPmHlIktm1mfR2LJ+pnBQakylpG58m1VyzXn5Lv6
 g2CtSBghLF5xBNtBLWltvh60F9dMbqQ2IDBpzgBczwKM8V3T3urANKuMIhngf2grHUP4419wfAx
 txXy1YgIwaxCY9LtDi+RQzhrd25yjN77hfzEqDU+Ojg1wiulYNFYyo7vqrPbnQeNF72tGLRwzO/
 I/JmYwbuLtPbgLqEKkg==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a828497 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170026
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

On 16/8/26 21:13, Marc-AndrÃ© Lureau wrote:
> The callback is specific to HMP context, avoid unsafe MONITOR_HMP()
> cast.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/virtio-serial-bus.c | 6 +++---
>   hw/core/sysbus.c            | 5 ++---
>   hw/misc/auxbus.c            | 7 +++----
>   hw/pci/pci-hmp-cmds.c       | 3 +--
>   hw/pci/pci-internal.h       | 2 +-
>   hw/usb/bus.c                | 5 ++---
>   hw/xen/xen-bus.c            | 3 +--
>   include/hw/core/qdev.h      | 3 ++-
>   system/qdev-monitor.c       | 7 +++----
>   9 files changed, 18 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

