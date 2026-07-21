Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E663C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8H4-0003g6-3C; Tue, 21 Jul 2026 07:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm8H2-0003fZ-Md
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:04:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm8Gz-0006BY-56
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:04:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARPBB1516533
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bA3CTovFfbKCZaNugf7TFXsp5DK9wWbPY0V53bNdwzM=; b=Tfz7aRlf5BN1TQfS
 N0EIQ3rPq4x78utsnGc85zf22g8ylLEmwE6nMtGvclPVJx+gPXb+pMpga/xkZxIa
 JU9wEdyFt1MKYbIqmQdZneddKAxpmF10bpdrB9feMtKPBSpBSfhCIjNvQufUokfF
 qMzUTmRjHlUDsYHyM5U185tXUtnLiplgaOIu0rDPriWSSZGAuf9dT6eSYTJC6hHx
 SMz0NC7MVS8On1veVIDHJ3cXmKHC92zuUeEe46HyPWZqgbdVy3+nUG0Wg4vsbev9
 W+udVhPtXppOxqlYGj3QAeAyM2YWCFUjwjtIEOWmxBTDfpaWOQH34Ruy/wFq+Cu2
 OcJpMA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6860b3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:04:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c075c1e25so159703061cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784631865; x=1785236665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bA3CTovFfbKCZaNugf7TFXsp5DK9wWbPY0V53bNdwzM=;
 b=YXG2xQu11MhviGHnWw8aAVAy3A90cqTdTUDvZYL6+aMhN0DntSQBiqPzGX4rKhwPzR
 Z8wtGOdceST9kSgmsk4tDgUxte13tbNV6CjeIjgV9bNUIPpBrq9Dy1yhCO4AWYeUNSnt
 vB08wJgX9aJLCJLigEy/vEGoURl5srtRZkGe9FkEDAhSaS6HAofTIPJdJFFJU4tU3qPY
 WpwMblJ5XSlqldvCb9EZbj7wUgb7RYCAuDcEB4mVvnG9jEMNm99XcAXic4Stk9fc6TRb
 QY56y5+LzHp5GGPIEc2isQ2sZ/1T8NXXGA9r4/0NkFpWr2xTwQ6K7Pi5xhy7Z5stNQEN
 NUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784631865; x=1785236665;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bA3CTovFfbKCZaNugf7TFXsp5DK9wWbPY0V53bNdwzM=;
 b=Xrjq/MSlsXi970ICq2t4QISLPFvKXOVNf7J1LPJ7Gr4hezTuMIohGKq9Z+aomv6/0F
 eDhWs01T6fDInbkUcSzA9BRC9Kozi1nrAR7TsM9bQfstupAhGNEHxWtAxIW9wczSTP9R
 yIJD2NvUNjJ3qrnfOVkuJSLSKqD6THeaRLuCM33ngj/lFhlFQatoICmcShGmWRE9T+NP
 5hn5DoIz3o4EgGmlQZcBK+39Dg9jncrBrVx+B4misfBR5wfT1W67YozgFpixC5sUouag
 Wf1zT7/urFztu5sCAMmkv5cgXkrz/DwxAxWbNHV9F4nsKmy1RkCbBtgCpwo5y6VAwnVp
 sskw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUqTYWkpr8qRx6/1kCkSIlnQDIT51R65qlVtF1/9qTXxeNYmkjYROkWHOVFDuTmT9JgkfQOEgqYPn3@nongnu.org
X-Gm-Message-State: AOJu0YzjB030xs+CmzVXay53fBq6on7PwvPyzEyQteGaQdz3wh00bXpK
 dQPPSLarmJjT8CD4BPzky2u2XXUWSDzH1mbwIvZiXm2RQDl+gNwc9Zx5x1UOSsqg1a1G14mJbrI
 AWj27pmG0m/8p35yqk7C4UIN/y01VR/R2Z2FS0yaMTqyExhudNZZVkwVFqA==
X-Gm-Gg: AfdE7cnXQjV6mjQYbPyO+gWQPjywDdl5/F6Gu3pElGE1HwJs/ruahc8g0/w1Mgm6Y/+
 ookTL5AaGWb77nsB4xjS/BvtezKzXa1UnNok4bGcwxhxqCfUZHGSGth/hOFgSqLO+nyPfkxD14I
 l0BPZ8o6Z4KzJEXfTjvhuRHv1LSjgRtGWCGELlUL8oUI/Zg8oJdjua+ZC1gUCMOtm6lK3NIy98A
 H288H5bxaxO2CR5xMhQMDazrZJN+j1O2JmTxvOmJQtoPfbr+HuQ5dcsZF+HKXnc/3523L9NbAO1
 5bhB4PCZW97au+pJ7eIjPO2AGWlzcDW5Fc0oddSMQwcO3S7lTuGhhNPPLo7IKtjc6v1RzIqZlBf
 xslv+FwLhjsQAVbDpDamqJh29h1S5tcmT+Mn3j7+LIclGUEUF3oM=
X-Received: by 2002:a05:622a:514a:b0:51c:7f8:2a9e with SMTP id
 d75a77b69052e-5213e884da1mr171328521cf.61.1784631865328; 
 Tue, 21 Jul 2026 04:04:25 -0700 (PDT)
X-Received: by 2002:a05:622a:514a:b0:51c:7f8:2a9e with SMTP id
 d75a77b69052e-5213e884da1mr171328061cf.61.1784631864718; 
 Tue, 21 Jul 2026 04:04:24 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565482c5asm90080485e9.10.2026.07.21.04.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 04:04:23 -0700 (PDT)
Message-ID: <ade146fa-58cf-4ebc-90a8-259d8bf1c137@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 13:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Guard accel_irqchip_begin_route_changes() calls
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20260721105026.3932297-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721105026.3932297-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExNyBTYWx0ZWRfXwvUgHN6hyBsn
 kq69MGX27eDF2pATFRZHavk+6+MVM5iTnuASWxhuiaHgC03s/qDUNY7hMDyaaOK52x82n8tmaDJ
 nvUKv8MMFtyrBPid6NMJTqT6WhmAH3A=
X-Proofpoint-ORIG-GUID: _vDFWMqfa5H0AWIy798mEkCW6WljUeJR
X-Proofpoint-GUID: _vDFWMqfa5H0AWIy798mEkCW6WljUeJR
X-Authority-Analysis: v=2.4 cv=X75i7mTe c=1 sm=1 tr=0 ts=6a5f523a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=yMhMjlubAAAA:8 a=20KFwNOVAAAA:8 a=6QTLQDG6CYw0oAbucncA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExNyBTYWx0ZWRfX/W7Ext6N0JWG
 T0scqJ3BoNHAuMfiiWxPq+UEGZjrrUDeH9c96UTAX13nIlgQCO7sAoyTUtRifG6Cv0pZB1FAaxK
 JhsbZS446E78K2S+iBY0A/j+XUDW2bCuNPKfCguxdXirri1oxbtK7VcEMgIQTKOK8ADCPeCJvGs
 J1VDHB3RUu0WGp2VytNSe6k9zXaAjSiULF0TlH2DnofNfKgfn5gnGzmo1d1fh7BA4yoaS961wDA
 SP6+8p+yJw8qNR2SM2PTBQrm7mAT/BOKGN+aKFnXAkVKi7LcoYSAuZeK6fZreZAabOwVzDWQAjN
 EZekYpLWgS/gt+TP+APcyPGVsMP18YZcXeUZb2hmsc5Fca/V3+tCC05kSI/1khzJz1shWWWwPYF
 J6UCifdO7SzQ/CZyfUG5qRXwFiF3viSwwizROSOcxllY0hmyir02UXeiaAaLqH0rEOlwsn7XYbh
 r+Epf3wUpmAVeBCbY8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210117
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 21/7/26 12:50, CÃ©dric Le Goater wrote:
> Since commit 49b2dcbd2422 ("accel/accel-irq: add generic
> begin_route_changes"), accel_irqchip_begin_route_changes() aborts when
> no accelerator irqchip is available. This causes a fatal error when
> running VFIO passthrough devices under TCG emulation:
> 
>    qemu-system-aarch64: can't initiate route change, no accel irqchip available
> 
> The previous kvm_irqchip_begin_route_changes() was a simple inline
> that did not have a fatal path. The VFIO code already handles the
> absence of KVM MSI routing gracefully by falling back to userspace
> handling, but the new generic function aborts before that fallback
> can take effect.
> 
> Guard the call sites in hw/vfio/pci.c with
> accel_msi_via_irqfd_enabled() so that route changes are only
> initiated when an accelerator irqchip is actually present.
> 
> Fixes: 49b2dcbd2422 ("accel/accel-irq: add generic begin_route_changes")
> Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 380dd8c15f8d5bb98b725075978eef2e4e1e6c2d..a3147d28665abd29fd804bd08bdffc3c7440033c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -699,7 +699,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>           if (msg) {
>               if (vdev->defer_kvm_irq_routing) {
>                   vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
> -            } else {
> +            } else if (accel_msi_via_irqfd_enabled()) {
>                   vfio_route_change = accel_irqchip_begin_route_changes();

Pre-existing, either we use the accel_*() API which is agnostic to the
host hw accelerator implementation (KVM, MSHV), or we directly use the
hw API.

>                   vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);

Here there is an implicit KVM dependency, so I'm not sure why we have
these accel_* calls. Maybe "system/accel-irq.h" is incomplete in that
regard.

>                   accel_irqchip_commit_route_changes(&vfio_route_change);
> @@ -801,7 +801,9 @@ void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   {
>       assert(!vdev->defer_kvm_irq_routing);
>       vdev->defer_kvm_irq_routing = true;
> -    vfio_route_change = accel_irqchip_begin_route_changes();
> +    if (accel_msi_via_irqfd_enabled()) {

(IOW here I'd rather a kvm_msi_via_irqfd_enabled() call)

> +        vfio_route_change = accel_irqchip_begin_route_changes();
> +    }
>   }
>   
>   void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)


