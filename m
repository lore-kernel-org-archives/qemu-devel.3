Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17CCC55162
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqmo4-0000PC-5F; Mon, 03 Aug 2026 03:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqmo2-0000P3-ND
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 03:09:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqmnz-0002G6-PQ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 03:09:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6736ShTk3758947
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 07:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LS5zqlm8fLmgXtEkJeVpTkfeWhq5F9Q35waO/mC6kh0=; b=EdL0QCLf1DV6Qn9G
 w2YLzWXKFJ3LirSeSaT1wFP0PKRXQPHw9a+0+J1LP5nqYdpWDKxiQ2PMxpTVncya
 XOLGKRn+HluI7WE/060DxfAUv/dczImXAisQe9yK8+GUOCVaIij1wVbLpelQGEcz
 1+vg4l6Y3aBvPG4l1pM6VX5b1y6NTne8y5inWo0EuMFT6r8NnHnEd8rgbYPiYqig
 kmc3Y7AI4ZjInLwSWxOCfCUrWdxbPPBGc2NZoM5tJ7jIpEIY8bInSrofI1Ilpcus
 dtedHLcITcZAzdFZMM/HqKi2XioamX0XJP/tfDxVmwjQPwAIIFOncO9J/1ULprPV
 tO0Phw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrnr545-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 07:09:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-907c59bd73bso57316276d6.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 00:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785740984; x=1786345784; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LS5zqlm8fLmgXtEkJeVpTkfeWhq5F9Q35waO/mC6kh0=;
 b=PZtZXvHsoFGnrIUA7C8OfTp79k+If84e2g7WAmFJlgDS7aEMipdyTtRl6VuQfw3xGO
 4uptJjRpKal4RzvYRIk0DInpD6WbgiYhdpic2RNCxN81dHke7V0VK5eGDgl4mq0bSKcK
 oS8/fmN2QqG4n2Wqi9w/2MRGhNVAVgIYfEJoxkRpSmEzSl474fUAv1u8wLeKtULkw402
 PtlB0rTAbnRLns709vTjsjSeq9R/egCKrDBSHF6WgSqFd5t+QacWfYxAK0JLuxTy6HAJ
 48JJjt+DlJaIH+0OIOSu6bKxmMfGa0NPnNLP2fTjhR2s55LNqaTXBhrwXw4n0a8+hYkA
 ahMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785740984; x=1786345784;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LS5zqlm8fLmgXtEkJeVpTkfeWhq5F9Q35waO/mC6kh0=;
 b=oXSS5BINjSoEgaci1uN39tGp/HKC09Foy9n4TRXMOiQxT0q9CHoNCWePaZUDypWKZ+
 DQ+QbkVBps+Yc40moy7L3LdRltTo4y6xlCihxMs6pXATQRQWSrFL0Eg63siQu8tjOQh8
 3nk5CMX/vqWGonzN7/J28K009MHutjvmjz10yFk7whgqXI1K29Z5pkTJ9fKvktg5UF9Q
 KLLdpTlvIEBIN0SX+xDt209CfLhr7WZsc8XUa+0a+3bvPhIGQLZlN3qufsy6/cUwMrwe
 J3kJi54nAZK5ea7oL4R37FdOrx/BovsCsUjLEsGNzxOxxLBfxA2ya0xYe4fKXrwdrdE7
 wfmw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHKpbRt5FXD+Dn2yJNRaLZI6RtW7/UcuPHbjZk5ZyU1lLCCkvQeCh/4wtsOX6xE2+sSFmkqttNxjRx@nongnu.org
X-Gm-Message-State: AOJu0Ywd6aI2C6tTG6oTDcB3RWfY3ZeHtneEL3A/DJgyJWPum1YEo6vG
 brXzZ5b/XZB4tYGueq52Yq601T0iJguleXjmh0cZsvMEzXzfqAFsG2dOCTSlhhUzPrsxYm3GAh3
 2sgOs6GzzBRVnmjzsjq7wiPzXz0GVmxTyE3VIGj3aqZetePUv1nIebgBcGA==
X-Gm-Gg: AR+sD13JHNZVlrxbyA24zahjsH2tngQyASE/62x/74VqN2vRspMNm4lpisN7uCaEXJb
 CCV2lr/bjVb9S5SkK1sUevn80E20yc/+Bk/dKZ6+OgJWf9GPLd3bxuLQsqVnN1+vHSMV4smGysU
 alqN9j8bgNr3OIpY+WX8m3fybGVJ7fhKsw7ou5VqIp9DpSQN38AT+shsXgqb6Bia/lXHT4SWycG
 SX0UYY1YnpFKffeadeQi9wvf1dpN4qCtBvIciA1uZbGIMs8sm5AkSb7sSp596tn3qS8ugjI01kx
 jGMOEqQ1O61FaV1ETJJOwLznCIBW9wiK9AzQr9EQabFxDLsJu9s8OnsLdtxE6oGPP72y7XagpfA
 zr2QSZXCn2DE2Hm0Fq1Yjcbl1UL9b2FSXEWLnWpZMtd/Mzylwg5g=
X-Received: by 2002:a05:622a:1353:b0:526:d595:c7fa with SMTP id
 d75a77b69052e-52b56791b0emr179874571cf.31.1785740983649; 
 Mon, 03 Aug 2026 00:09:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1353:b0:526:d595:c7fa with SMTP id
 d75a77b69052e-52b56791b0emr179874431cf.31.1785740983165; 
 Mon, 03 Aug 2026 00:09:43 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b917efsm324378355e9.11.2026.08.03.00.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 00:09:42 -0700 (PDT)
Message-ID: <7349a187-146a-403c-9b78-f84cf829a23f@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 09:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/virtio: propagate vhost_virtqueue_mask() errors
 from start path
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com
References: <20260716033303.95963-1-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716033303.95963-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA2MSBTYWx0ZWRfX+cXBihnvuq/c
 6yWPPUHfIOPcCItWEW5IJmTPyVn6RaGvnQ8FaNF71AvIvHzW18OXUAUEzB4nh5yAsXQv6jaPqkq
 1qAUI65NDRmPOlMGZgICTQvzSr9evxw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA2MSBTYWx0ZWRfX+ItCcHYaNdiR
 3KwM15l0zb7eGUcwOydFbG92x1WVIvMieWpPdnKDKpgEVjXQf+SDCgS36+2EU4uL8XeTwO8uvbH
 7TWuRGqbNTXxJwHd+w1t3R4Oh8oZY5+n2Bhy1gZOB5sk/c/S7w/dgYW44gxF6aOKqWq7TRZYcvH
 3xX+tv8kZvqaDK4Nh0qNRZQ1vvMdIBbyyILrXSejffisEgU8lRgbDsgY0AWwZx2/s1mLI7yV4kZ
 UCT2JbopbKCcU3m3vLTRZuXbtSMgIlX63D+QudxPkvDJPF3kflnWQm4gyhNYi7XdDvMVberRrh+
 0tnh87WGhHDasQVTKA5Txl2g9d/NZeXV6WG2bmo7UIZ4vL2DEf+fTUaPPOlQoyCnVU8LlnUyDkr
 dutDFKSBrI3s939aGPtVML5eASihzfm8jUXP1aPdo8dqGVxnS2yqxNlC5h/OZNjPSKwJ16QSlbM
 u6g/TlzgpyEvGiJJUKw==
X-Authority-Analysis: v=2.4 cv=Zest8MVA c=1 sm=1 tr=0 ts=6a703eb8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=SRrdq9N9AAAA:8 a=r95gPbwZe4GtOplV9-0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: aKjErzRt99wNyEN7egsCdRQUM96LWuea
X-Proofpoint-ORIG-GUID: aKjErzRt99wNyEN7egsCdRQUM96LWuea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030061
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

Hi,

On 16/7/26 05:33, Bin Guo wrote:
> vhost_virtqueue_start() unmasks the call notifier by calling
> vhost_virtqueue_mask(), whose vhost_set_vring_call ioctl can fail
> (closed vhost-user socket, kernel ENOMEM, revoked guest_notifier fd)
> but whose void signature throws the error away. vhost_dev_start()
> then reports success while the backend has no valid call eventfd for
> that vq, leaving the guest with a working kick path but no virtqueue
> interrupts -- a half-up state harder to diagnose than a clean failure.
> 
> Make vhost_virtqueue_mask() return int and handle the error in the
> start path via the existing fail unwind. Other callers reach the
> function through VirtioDeviceClass.guest_notifier_mask, whose void
> signature offers no upward error channel; they invoke it as a
> statement and remain unchanged.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   hw/virtio/vhost.c         | 9 ++++++---
>   include/hw/virtio/vhost.h | 2 +-
>   2 files changed, 7 insertions(+), 4 deletions(-)


> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 684bafcaad..1f62332d60 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -312,7 +312,7 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
>   
>   /* Mask/unmask events from this vq.

Please document the new returned value, i.e.:

   " * Return 0 on success, negative errno on failure."

(Good opportunity to convert to a proper docstring describing arguments)

>    */
> -void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
> +int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>                             bool mask);
>   
>   /**


