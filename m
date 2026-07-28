Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94BAC54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeB9-00078J-9T; Tue, 28 Jul 2026 05:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeB8-00077V-5I
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:32:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeB5-00064p-Bh
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:32:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82u6s2276192
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DngHQuWsod9CIfKFAAjVLKWGU9Q/IqK2o0WUBbI7FBs=; b=VcMHUhrda+deddnI
 bMMOYiscFsl2IwalTxsuTA7YDbQ2FiMyCyDvYhyVe3dQ0eCMs84p3nYAZqVxDkPl
 W+AZfcznA6KBfj/ptmaBZ41/iLlYCcaOvMi8LNn+Z7q8+YzS3SEIMesSGiLwxdWX
 Fqk0IMsuIVZCbZet2oYNoaOZ5Tn1KLoZc3yjB4lsFJbX+wu4aPvvtqihgU8LvR/J
 4abb/EwzYNr6qOiA1uedRqPos4fpK8E8KIW3sVgIkg/R1K1v0brgj6QNS5imUjeT
 xcWniymfPu9krZZeEI8Hd/3XLVJ7I2Vats1qbx0yxagwpnITC7zld6uxa7ntLUyl
 sMtxVw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrsug0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:32:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso40351361cf.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231165; x=1785835965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DngHQuWsod9CIfKFAAjVLKWGU9Q/IqK2o0WUBbI7FBs=;
 b=A6TvTyXwQdgKBLQvchyqB12ZDCglhFo6ZjfXugfdTV170V3uz+d5Xqtb4Bc9ZVSWqc
 WbU1Fp3h94W+rs0AOKlllx/a3EThS6mYIKk2fW6W1qK9tIl9x16WJQuWmoFbqz8gWG0V
 PV6DVxBWnEtR8GRJH9oULmEXv+KuYJE2IobqXwkdD6i7JaZHJjCNwqpGMBbRTfOqz+Sw
 mMalE3XOn4Y5rGZtyEle9Z732G/B2emDVqLdI6TQtq0EsXDJhFpUIVbmbpDSDmiPhJ7Q
 elgc6/T1/z4Jyy6cLB08mtdfBqpxBfE69GL4hDQ8Vidlwlkv0m1J/9cX3s7XFHwteZJB
 OXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231165; x=1785835965;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DngHQuWsod9CIfKFAAjVLKWGU9Q/IqK2o0WUBbI7FBs=;
 b=NcOZCQYDnzk7Wbs8lB/7uzGVsK+M+11qOd3J2XpIAKdOl0CWp8KKT9GdNXcYiEM/8O
 7o1oQ5+yEcoXI43Bd7KCbDJlDPPJvdUxVj1M0zfso6q6r99bP+cIURw0Yjkfk8/Wnwaj
 XEdT3CNLJIerVlEwiE76Hm2QUBP1hoTkiXH7FBIkyXdqc/BioBD5TG1x0+p/O5Hef0Jh
 ir+zvIqD7dKaTr8eja9wj9m3DzygpxHKHzc706KvaA7Ngu0037krmW26KxAQxsqCbSQZ
 EuRQ4UvXr0cVts1jutLG7uGRW8c8t0GxzyBieKCSzAugC8Vd3mzElwyE7IY/TCpBu20f
 VFaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7p+4tcCX3TtD4vyDpXxBEKeNjVZ9Qd6WW69g0ORwQ69hJtVBSYZvMLTjstd/lXznFOUkG0t02Cl+S@nongnu.org
X-Gm-Message-State: AOJu0YzbmahuYOC0TgvNP0XvAC67ietBHhXsSkEujtnPZTrUGmiynB8F
 uh2HGV8W/sk8on6hhW+/qGsEhTFbJoaSQJZBKp0GEqcB+8RK0voNYm71/4hECgaJIyijPwkgpRF
 WgOYIDVXnd1/kP8pacj+CxarAWsQOexiv7ybnOh0kKgX+Unfl5eIlZ+qw7g==
X-Gm-Gg: AR+sD13TZ8uOMEHfJBOAjKDiGSzdwyudT3wBtRmdpNfjYHQlgIEECPCGSSp86dBy+FA
 wkG4MQn47oD9pcudlTfCjy0+iCdpKFBCYWSPJlgd19ERo5Sn/ZRGi+bcxmmEgcSqXeOTv0vi6bs
 DonCl7khz2pOxU+EBmHMOcI6BM3/W/AVKzSpxT4JPPAGNQy0RETdthoRBxKEcbv4EjtnzOa7Aps
 CqiyW4qHjayQFn8/dshnwmZ3G7cuO3/CqDCynhMfDowrDEMNgusUW6MTtczSuAWlQJFv253cW5w
 tP8/sQ/HwQIgaC0axyT6i5b3M2lyWFS874BaogCzv7BY6w4xo1TwPJ955KyAbPRR8TILRde0kus
 JuBGgZ0Hmq3vb9DXkt1/XvkAX1LX5J2CeIYx2pNHa4GvTZZxq+e0=
X-Received: by 2002:a05:622a:1443:b0:528:3123:6142 with SMTP id
 d75a77b69052e-529d713645fmr12347201cf.70.1785231164960; 
 Tue, 28 Jul 2026 02:32:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1443:b0:528:3123:6142 with SMTP id
 d75a77b69052e-529d713645fmr12346911cf.70.1785231164170; 
 Tue, 28 Jul 2026 02:32:44 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9b8b67sm343093325e9.4.2026.07.28.02.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 02:32:43 -0700 (PDT)
Message-ID: <f9c5f329-bee8-4454-bf53-8a94b24f0e5f@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 11:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix cross-namespace copy dif buffer overflow
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jihe Wang <wangjihe.mail@gmail.com>,
 boy juju <agx1657748706@gmail.com>, contact <contact@xchglabs.com>,
 david korczynski <david@adalogics.com>
References: <20260728-fix-cross-ns-pract-v1-1-20f66766337f@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728-fix-cross-ns-pract-v1-1-20f66766337f@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MiBTYWx0ZWRfX9oSgPQNfq1sL
 W3yER1yBDpFzrW4WHGqfgVPYZxy+tsi1o0ClZMlxkkgZOnCfsRpgSOC3V0hlEdqxgKct/DOg3nC
 VtsaOUyhGcrr49y+aOT/7XD1gcCJIoB1oQk99ahEVynj+q2KyJZ81145NmKSwxVn9Nsh0xPdJwA
 lrLeg3gYc9X+0Xg6m14sbECP4p6dKdqOjRqfQmE0E5oRR+0AAwRbj6o2P6BhHpOPutL9spxMqLc
 9EKPWpktLU96FSe3KhyIkwWXyzJ7W+7brLiEPkvga8lRhbnnXNV3SrSeC8c976hez9yx1PQlpNO
 QhYbQbGRsESde7zXaX8sWtfK9BWM5uvqcEU+6fet2ccvn41cVLzSiktrDF3gHh6wxk2rfq6lg2p
 bdLn8wIBikVtLa0FhHbf2U25D/Hh9kKJuiibFl7izLpg8pKyskJG4LWCbowpD0M/1I9oz9hmO4F
 YPdkC0MG63IlvmmPDXg==
X-Proofpoint-ORIG-GUID: MM45i3kjc0RFUOuHL59FxCx5ZRW5psOE
X-Proofpoint-GUID: MM45i3kjc0RFUOuHL59FxCx5ZRW5psOE
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a68773d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=hD80L64hAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8
 a=VBowi81kAAAA:8 a=J0GrWIi9AAAA:8 a=KvdCMxy2aeLEsuszlG0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=uoxt2CKr5i4t67rzx1zf:22
 a=3seXTzszHmjzhzopxh8P:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MiBTYWx0ZWRfX1py/RboT43Jc
 5ZSe0uxAvL269cfaPz2ZJgtQuS+ATPHv0Y6rerA72KXcX4ypjSh8mnDFsKigqynaE8KeSnw/kgJ
 Ut8JaUGcZHpX2DLY/rLvKpF+SXJnhHY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Klaus,

On 28/7/26 11:18, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The NVMe specification allows a controller with multiple namespaces to
> use different LBA formats per namespace. On implication of this is that

Typo "One".

> the destination namespace may have a metadata area for PI, but the
> source does not. In that case, the controller shall generate the
> protection information, but the bounce buffer is errornously allocated

Typo "erroneously".

> without space for that, causing a buffer overflow.
> 
> Fix the allocation.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3387
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3692
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3841
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3853
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4031
> Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
> Reported-by: boy juju <agx1657748706@gmail.com>
> Reported-by: contact <contact@xchglabs.com>
> Reported-by: david korczynski <david@adalogics.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a67e1598891c..409aeb9921c2 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -3332,7 +3332,8 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
>   
>       g_free(iocb->bounce);
>       iocb->bounce = g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
> -                              sns->lbasz + sns->lbaf.ms);
> +                              sns->lbasz + (sns->lbaf.ms == 0 ? dns->lbaf.ms :
> +                                            sns->lbaf.ms));

   sns->lbasz + (sns->lbaf.ms ? : dns->lbaf.ms)

Could MAX() be simpler?

>   
>       qemu_iovec_reset(&iocb->iov);
>       qemu_iovec_add(&iocb->iov, iocb->bounce, len);

Should we assert @len <= what we just allocated?

> 
> ---
> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> change-id: 20260728-fix-cross-ns-pract-6934cc8205f2
> 
> Best regards,


