Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85765C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIqw-00033b-DR; Wed, 26 Aug 2026 15:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzIqt-000327-KU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:59:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzIqr-0005nD-Qw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:59:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QHImUX1572039
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +1uT54gO7bKESMas1ejXjS40+ii6n2HlqK+VEwIqdxM=; b=KmDV1NnER38zpDAO
 g+0bvNnumHd/dR4dV7ntUqTg9AaNGNYyOehnMNFzEVByqzYEIrK+M5wUdSrXjOXq
 XdawOh9z8LT7bDI1A6nsUcBzT3DG3ob4olO88DSXy1FTz2xwIthouH6aN/gXhWFK
 CH2V2h323G0bmA2X/FSoEn2eH4NeTNHx0ihohuYIiwdIdrA0efTVFhLPneGY0wd/
 gSxzJiT50fNHOrwCUKdROpKRRsqvVgQHjmyeIGpifYB2PnKLrqnSdJHYLaaX3aqL
 QR17QxUsWA67WZAHNkpsqDu2Qcrczrl7Hx2h6YzxGqM3jPh1hzYAooBOBi5MD9dI
 Wm/C/A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ec8chw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:59:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a236220so16160951cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787770794; x=1788375594; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+1uT54gO7bKESMas1ejXjS40+ii6n2HlqK+VEwIqdxM=;
 b=GEB6Qd+th8tMmCHl4z1FI7ao8aFrL8nsMlIkVlROVxOLhtCe6wQ8XI8dVeSJVEGPPh
 tgXDaP5Lo29Nq9aBUZUrc4RDWmWk6cIjSbb8RSomdd21u6+EVKAuKeoRJ/Lc+Q//aCle
 1HTEeAW5fY7M8VpgNfEwZz/W+rtAH8wHmiTjTuA9eF3QuJmEWqTeLed7ZKSkAwcXQw5a
 4K9vdkxvB8W3hFsXk+CrX6qqeu/jl6tX7Wmje0BJz/jbb2YkrL1g7mU7WT5MGbqHy4lS
 GF2iTuAevI/KEUeoIpUwBKtZqojDqYll2kTmv9UKvG0SvtJ28ylrhuRKhF5MMN/kjmYK
 EXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787770794; x=1788375594;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1uT54gO7bKESMas1ejXjS40+ii6n2HlqK+VEwIqdxM=;
 b=rIVS7Jm6mo+F6X3NBFYHhXiVYN5/CJycU34EFMSiFYxOd8tbSeBffkomLBXB/nSPZY
 TATj9Bxr7h02rFaZINlnj7gbj8UXjhw1EGgrFHuwA8S3UAqzS15LPHBJS5JPb9CeX7PN
 Z8s6KlPrU/k8nq5lYRW6kFOOrVVzSvPTR3zZUle1JLO3d6d9VSq1vlmoMqqPxU5H2JRr
 qX+a7R304iHaPw05ZxMmLZMK9z7VRk0vFh2FqC4SgoLIUK2Bq1ks/0/fielkClLRshc3
 K7rzMTa/ztSsF5ASRkYBNU9IK4FBFlb09p1mxR0ftZkckhlqhCECEyPs7QR01uNxQcqo
 UdTw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0zRyyaSD7K0Z5ZWhwgP0JitDnpMLRAVN+8nhwFG8Cc/Summ/etTe/bN8CTZPHVxxdS0NeSrOT/egt@nongnu.org
X-Gm-Message-State: AFuF++lgp6qr1J/NsWqdjWvg/bPfICkt9d+QUykbjrNcsZBdejYNp4/X
 ez/TMnsL9cCYNkvdQdsDCkuphTTsKgh2z3CbH0Dm/IX+rNUlwwDmhkwTpMhBjaGjm1j/QZh5D1f
 mzqIX/vhbUhwBt1QPRA+scthmOVVKfJ3qv+LhUpLYwEXK8F6eTJCznGsyNQ==
X-Gm-Gg: AR+sD10FJnLt28TtsZnKHFu5KWox2u9RbEbV4Klel3yTYxs+SLbK3XuNbNrsAH/UWc2
 hBWzIIYJ5LQLyl0+XM2GTdhDmOP8JtqNfxYpT8JqTghFiD2qqKp7S8ahxhE0S9FbUjhwUROehx1
 Vlagfwm5L3sOA8YQ0wGxkJWIVu9wpvZZCPqZ2RmZA/MQ/eqWkD8CKJVPFfA+PM3OAa2IWbimbcC
 I6bcxi5J5sT4bK/P6pq4S1l9fgUj9k04Rb0GwXcLsNx3Q0io+JmZxCStIRonNGU6mAVDAJiqWZO
 nxpsS+d6ojfjRzYtI+c8CwlVdHEeXpQ6maDLmI88G1kwi44lrWvIZymJrH6mGsoJAax0j+FBsPG
 SlqJW5vjOsx7km2bXxd/8acQs3hUvHcRUkhvbUkXv1Ell
X-Received: by 2002:a05:622a:1914:b0:51c:22c5:daee with SMTP id
 d75a77b69052e-52e4234e4c1mr98314451cf.29.1787770794536; 
 Wed, 26 Aug 2026 11:59:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1914:b0:51c:22c5:daee with SMTP id
 d75a77b69052e-52e4234e4c1mr98313751cf.29.1787770793972; 
 Wed, 26 Aug 2026 11:59:53 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a6fd676sm648493366b.17.2026.08.26.11.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 11:59:53 -0700 (PDT)
Message-ID: <edd6a530-2437-4301-9515-4e96b77ceba7@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 20:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi-disk: fix out-of-bound read in WRITE SAME
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20260826181725.849718-1-pbonzini@redhat.com>
 <20260826181725.849718-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826181725.849718-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8f37ab cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=QwLhjXjHzO7ep9z6PgIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Gj_z1WVzizvWg14UaziUEEcOhy7XuZhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfXzcY1sw74HkyD
 gqmEhXMWEvxAyyw9QL3pXJyVOMJA1TmxnWireNHti86YMP3GQP7iAN5iFFqjKWqx1hhZe1loTf6
 0nq0H1v1UYOgsfk3iReJqbL0aYQXlnRo6BAd4TdM02RBClsh1+3YkpJoERHR0OiqLurksoNi04m
 oxXeoDKw3XVZU/DvLoZDIDFlwBytAk3T3Mq9fEyp32dp5VNdo3fblp0MuMrWJM+aTfYsvqS1BCn
 ke8cjpaTbVTiy9tFh0UOtDIQWuzXdDD4G+qOK00W/2jT0ou01DlzP8iltWvJQo0KsPiw+iS8Zo1
 hHkNVkXrCeREr/XWbeZEFmrZKX0T+iB5JMVvrNst9odG9WgDnp1Yp7XNG5yLbrBuWPlDzlVGaut
 2DsOUZQLsYC67UMaS8irjOlYxvV0ISsTAaN7zwwCVf+M5rinMwHW0rxMSw3QWUc73iFCLWiDNx/
 O2aFzo47Xf6dOZ5nrqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfXz5LUvWimJtcx
 LTZb1PlKfjMw48fS6JusoGCvvPgcCpcf8vgikywHo3DamZzHXYYi/6/M23z7F2zWmFsLauNKKvs
 d9TeEU6bqqp7VO8dWU3SVoHiwbTKTJ0=
X-Proofpoint-GUID: Gj_z1WVzizvWg14UaziUEEcOhy7XuZhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260159
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

On 26/8/26 20:17, Paolo Bonzini wrote:
> A guest with an attached scsi-hd can force QEMU's SCSI disk emulation
> to read roughly 60 KiB past the end of a heap buffer, copying that out
> of bounds host memory into the guest's own disk image.
> 
> WRITE SAME computes the request transfer length at dev->blocksize
> when the request is prepared and sets cmd->xfer from dev->blocksize.
> scsi_disk_emulate_command() then uses cmd->xfer as the size of the
> request buffer.
> 
> However, MODE SELECT can race with the WRITE SAME command and guest raise
> the logical block size to any value whose low bits fit 0xfe00, up to 65024.
> In the presence of this race, scsi_disk_emulate_write_same() will read
> from memory as many bytes as indicated by the *new* dev->blocksize,
> and write it to disk.
> 
> The read length in WRITE SAME must be bounded by the buffer that was
> actually allocated, not by the mutable s->qdev.blocksize, so clamp the
> length used against inbuf to r->buflen.  Re-validating req->cmd.xfer
> against the current block size would not work because the race is
> intrinsic in the SCSI protocol.
> 
> I am not sure if this is exploitable with virtio-scsi and other SG-capable
> HBAs, because it should process the WRITE SAME input immediately,
> without letting the MODE SELECT command race with it; but probably
> it is because s->qdev.blocksize is accessed without a lock.
> 
> Fixes: 356c4c441ec ("scsi-disk: allow MODE SELECT block descriptor to set the block size", 2022-07-13)
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4365
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/scsi-disk.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

