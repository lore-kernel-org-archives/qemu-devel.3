Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2907DC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz94Y-0002nR-Uq; Wed, 26 Aug 2026 04:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz94X-0002nI-Cf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:33:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz94U-0008VY-Rz
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:33:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RuLe451448
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X9q8bLp4enaVJKp8/zSLLE157xlDi8QDBuyiPxNL7ik=; b=EBYik6yBgUJSyE2W
 j6uKTOMJei9JtzIalRtLg3tiVNRiLhBrYJffSUoJ5RyktS9bVkoQQoso4Sn/TsSv
 BlJiJI4ibF7rlHWGPYp6m2aZ+dogw8V20D0O9A00eSKTqaikjsqlC7tn+qluiEhg
 7QGzTUyqLgwHTHUwx0PQ3NuboGDBnjzcmfwEO3H7stGJLjxIilY/iPyti2dRcvYH
 vOjoM2SyRDMCf2S4+7Rtn/toq0ig0H/jmVw9aRKWDKxSdaI45H7vhtmhoqLFrg8r
 Q9mkiwMVGv4prTABfhl4TAWXKECStf8l1xSdnIACp/wmvIfG0hnS/afxDwOr9JGx
 Aq1hpQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1gh64b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:33:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52dd69b00cfso7949181cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 01:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787733200; x=1788338000; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X9q8bLp4enaVJKp8/zSLLE157xlDi8QDBuyiPxNL7ik=;
 b=TEEru2CccAGmAAIbxmRvh/qKWK7FJaRvxZWlJcA3xig2Qk/WFENKmQHo4qro5gUdg9
 TBOjdt5zkXrP02FgelNvbFvmZ0z7/eaOF+wvLYU4U5Iq1odj6+29VgGoVO4uM7thc052
 NGiSzgT5NQ4Y73AuN06pG8bcKlxbgG1jYKPVcDXanIndN7jBzlUN94RXaBn7uCl/bt8i
 fL8RmKUpbwS9jWd/D02Cx1D0gA8qxNnPDLjrOqZnEhfdm8BeVYNtjKWIePuyLAwaMUpM
 ib89WtgWEdfUFB9qCilGHgP3r2v2uSuzj+cpgryPrbcZ1rCdnyDXOnq+DRTnHXyllZUy
 RRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787733200; x=1788338000;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X9q8bLp4enaVJKp8/zSLLE157xlDi8QDBuyiPxNL7ik=;
 b=huFcxvNnfkZYHc5CNWndag1vO8cJ+y2Movuz6Yge9boDK1DZP0QppmdJz9eBWxtsC0
 9RlN6LtiaIyV68WhnoQ3zjEX/8HKPLEkWYF5+alZK33AtDHhDZ/833jznyUQJrW50PEm
 hP3RoeVAkRmKJHjq2evpTcjQz+P/DYKpiDHxKTf1x5/zoB4NroKYfexeKhE5jgOQkxkj
 iAOfOmQ6yI17rZCpxAjauWysMImJXRpMEiR9lsZyKAFZrCfmjbMcYTCOZDwQGN2TveO9
 2taIcl2Ioq89593/qG6w0zh3No0qOvjg4I7c3AmkGFUpREAKoHgJcD28BlJ2zq2aL+3R
 g69w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXAk5+9f3p0Zo1y/Puz1paILCgXMA1TjBeiYHI9JDgx4jiQpLrSUmOd3gZ5khFwj+iruPemvZYzFTN@nongnu.org
X-Gm-Message-State: AFuF++kIuki6e2YYkTdPs2ejJlK7A9IJGfujJrA4MchPRi7Fg24TaQgU
 ksmoa6PduEGV52HHx5ve37wX6VoXn8YWKbOwL1BZJUBxtoAcnCT2zbfRd7oq5UNigy259Kga1Lj
 GbTliCiV5MWOB8E1qsK4AapJzw9/q96lovMv9t1fqQ1pMT7E55wvWQZsLxg==
X-Gm-Gg: AR+sD13HLK3qFiubTMrKvFrGJfHmQRxPT5xxJFMdLNhO+PFWq1dC7MMWdmtWjbUq8Zh
 k8UH2shVbtjzoHwCCEZooTjByMMgT8GGWXJ83SMhYPMS/Mbc/qJovAmGg/QWb0/83+kURPKJptT
 wTA214kr8cyE5478vrB13xSgf0aZMpL8lV8oxWfryZU8wbETMMhSnFEFlG/7cfS8YPFuU97S+n2
 3JpNKCRCVCMFNIoQPKntlcHIbD1IR2Sw7mAscMkD6L4rSwurVYLrTnuHRxQJWX5/c4DLJPhGQ65
 Cks7VJOog08Iy/KvH+CtVARuMB7aIH8bbKumWgB/NcYK3NgtDounAsVY7esXP2Cf1tUtJ15v6he
 57sXrWk298+my9sPZp2PysX6+XDH21eh3RWcjteM=
X-Received: by 2002:a05:622a:4a8b:b0:52e:39ca:5049 with SMTP id
 d75a77b69052e-52e4239c52emr51748631cf.36.1787733200514; 
 Wed, 26 Aug 2026 01:33:20 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8b:b0:52e:39ca:5049 with SMTP id
 d75a77b69052e-52e4239c52emr51748391cf.36.1787733200032; 
 Wed, 26 Aug 2026 01:33:20 -0700 (PDT)
Received: from [10.254.188.74] (14.89.66.37.rev.sfr.net. [37.66.89.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e2756112sm2123358f8f.0.2026.08.26.01.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 01:33:19 -0700 (PDT)
Message-ID: <82678d11-421a-456c-b112-51eaee6fcc48@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 10:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-scsi: set dataplane_started to false upon failure
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260825154854.263819-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825154854.263819-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EWNQOpNI1VezBS1rBSZuCNOEI5shXVai
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8ea4d1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=JQZmDyB7+sUo+n2VpL1TLQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=fVsn8OAKAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=EeUdSM6Qa79rdBn2kBcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=pUU1e103_AmlsynDt2X6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3MCBTYWx0ZWRfX5YRvVL/iyZC2
 pFebdxXYy6hEfxSTnv7S7e3BER1MeuG97G5MFuurjgk8h3uSsoa49TujsSMDcZx0cNZI+A5QYno
 t5oU4513Jfcw0zGj+0epSUiiy1lbgX0=
X-Proofpoint-ORIG-GUID: EWNQOpNI1VezBS1rBSZuCNOEI5shXVai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3MCBTYWx0ZWRfXyldGYJRKtxrC
 34B1dw12mcxuOIRt92Vk7MVixJVUi1gVFxyIh1XuYpDhnrdkz2N91CE1QfB6Xxc8vSrykM2YhKQ
 WX00p5b7hJYzn0h4Kqae4x9y7flAf1b7CQifmxCdqU+Iofwzbjekyq6JSgmoD28HSMKQrbHTb+1
 skpzIsm68I7KEObbQZS/IkDzgmHr9kb+CKlZdIGLiQ3XM+UmSZWzLQm7uF86tbtzau7MqFBSKFe
 3kHM/5iHLvCxvHKbZv6J07N4y2Fv8I1FYUoDRKB+PwsamKtHeYCUJLi9slAOig+VihYZuXIh4B8
 NIHbfKnERBhnrkkF3hsffv1UuZlSD5nzv8QrpOBAgV6GgeOnfaa2TO9GWI2dUjI8K/cJC8imYY5
 NPJAsqvMkWxnoVLa5Mz/G291Qb4ieJXi9xf3O7/OywBXFvVvGyfUfXJ6xW1tjZaV7J/QqZMdM3u
 DewDoZ48nWsUDWn7Urg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260070
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

On 25/8/26 17:48, Stefan Hajnoczi wrote:
> Commit e24a47c5b73e ("virtio-scsi: do not use vring in dataplane") set
> dataplane_started to true when virtio_scsi_dataplane_start() fails. This
> is likely a typo since dataplane is not functional after failure.
> 
> The non-ioeventfd fallback is broken because dataplane_started is true
> after virtio_scsi_dataplane_start() failure. As a result, the following
> assertion failure occurs when a virtio-scsi device exceeds the open file
> descriptor ulimit when setting up notifiers (eventfds):
> 
>    $ ulimit -n 104 # exact number can vary based on QEMU version
>    $ qemu-system-x86_64 -M q35,accel=kvm -m 1G -cpu host -smp 14 \
>           --blockdev file,node-name=drive0,filename=test.img,cache.direct=on,aio=native \
>           --blockdev file,node-name=drive1,filename=data01.img,cache.direct=on,aio=native \
>           --device virtio-scsi-pci,id=virtio-scsi-pci0 \
>           --device scsi-hd,drive=drive0,bus=virtio-scsi-pci0.0 \
>           --device virtio-scsi-pci,id=virtio-scsi-pci1 \
>           --device scsi-hd,drive=drive1,bus=virtio-scsi-pci1.0
>    qemu: virtio-scsi: Failed to set guest notifiers (-24), ensure -accel kvm is set.
>    qemu: virtio_bus_start_ioeventfd: failed. Fallback to userspace (slower).
>    qemu-system-x86_64: ../hw/scsi/virtio-scsi.c:1017: virtio_scsi_reset: Assertion `!s->dataplane_started' failed.
>    Aborted                    (core dumped)
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: e24a47c5b73e ("virtio-scsi: do not use vring in dataplane")
> Buglink: https://redhat.atlassian.net/browse/RHEL-193328
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/scsi/virtio-scsi-dataplane.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

