Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D890C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm73c-0004zK-Gq; Tue, 21 Jul 2026 05:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm73a-0004yU-BJ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 05:46:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm73Y-0004Qm-AI
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 05:46:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L8nbnc535680
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O/VbOD5Do0gCOvwj8oon6ZnqAJI/nP3DOmO1X4JAqr4=; b=Jez42HCZ8Mq762vT
 vh9vb3vkAHa1ztl9UQx0NBsWI/gG3/2fEIk8k1OPs+LbLbmd8bIAuVhUe0BXsD+k
 g5o6QjeK4w+Jf6xlTrgQbOxE1/M75KqhS8neIl5hSLJIH2G4WC3aPSmD/8JxHpHV
 TkEhA7eW/3+q6vPGuzmnaXI91oTzdbUf8/f/J1NWDHuiq18YcDF9zgyjcF08WDys
 j6Mzy5nub01qKLwNcH5pBEPYPyM2GkD0wD5L2iFDsdtpsQcYK3NyENyjhCzZ9OD+
 U9UvJt/+PFxgbRJdaZfmNjxaDPGOuX/S9RXn2GT39G1scBuMZGQiSnANghaaCqVJ
 hPqV6w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1duhjec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:46:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so161967661cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784627190; x=1785231990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O/VbOD5Do0gCOvwj8oon6ZnqAJI/nP3DOmO1X4JAqr4=;
 b=D0mTC0SRfKQQAG+ElM3tkOOsvHIlK8+7BFB5BLRl1QjxsGczwIXcAy1YkDTHVxDhHW
 UtaChaaJDCaeBeEl24J16q6Xo6j+D9MORBDeTbg9KBRAnyzgobXvQsRl4bGOVeqakf6f
 oLZPk1mpPQADmSA9aZBOZ3n0J/aMvhOwg2McmDh0n+X/Igix2LWBYRvzbtAYKRsx5cit
 HjcXcGcHbqKJ9UqgRlC7EjawLG0CAxztawaZ1TzHpF/b3OaAQHOnChcQTd48YuZ4tuuF
 ltHgZ+wJkJhRbjgTQGDGGhYW6Ni8aThb0CTyobjzk7ZfrEELtSkLuxc1d2RodinsotRX
 Aj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784627190; x=1785231990;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O/VbOD5Do0gCOvwj8oon6ZnqAJI/nP3DOmO1X4JAqr4=;
 b=biNARmqlF86ssWpW8eMYjYs6KhK6iubYIgKoJ08nqAN65ayA99BwGk1BP+nxGZc0Kt
 FjGVB44LHAcXGu6lg7rEKrTZ0GJnaRq0g+TgOp7VQMYNjTTlECt5V1kQ/Q/VR0NDBJ+r
 doAa9aTj/qCZtSDH+VNsOdH7MQFvjcM7wZ8hwBJVvN1ouYvupMABTXMMqZDyMTh43eeE
 iy2tlnFYZRDBKVkFVodPeCIuyxaX3SDeEetUSAUQpXlGZtNhs3lnhTslIkSdGyn18n1Z
 dNL25DNSkcD2OszkOJxpfxUqXpY65fF7FZpb+RH3sAZ/mP6zhpLU0bYmFM5nd8rajlvU
 u79Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RocjkpnxGFnX+EcDUiX5wmtX/8mJQiNj0oqdJDPMuPAweD/A3+A52nKYojwJcNRMJn7fQSUO3HNHNHJ@nongnu.org
X-Gm-Message-State: AOJu0YzFhRR8+KQ1Br3cgDgnxTP7LZi3VCEBbJuWC98TG+1hvCL82n+q
 sNcOs5+qHsLDMNdwd5AfV+CofRl7bziY04/MSn0fQwhl6MshFL5SobT/fa9BN0QeAQSXKsCytN2
 7tSLMkNfc6DHzTcJontB7giypIZqhQWT+2RKkF4d4pinkmU8j4DkhPAOb0g==
X-Gm-Gg: AfdE7cnMk1Inr2BG/YQFVE7aj2LTY6ldNgh4FeSdmYkUIFSz10Ee85IpS6E5FuUFwoH
 v4hzrZlkRi9yrbg3Xfz8NVV+Xw/A0c3h5wtBJlKiKiJHoxKBtqRDVnEeXlCJDRADN/mAwg3U6HQ
 joQVMnAszuwC3OWnIfwYu22fXulasUUgberCaOeGd6rUM5jV877CwBuCK7ZdRu4TXIXN6Qw5Eef
 o37w7T7yzeQAR8yY90V5K7fXfb92l5l6ycM6lbtbmd2Nv18aHwGZc5DaXflv7f3q30MlhV1JISJ
 stS2U+7yKmnyolieSnlt7MOhByvIL/4B/RXjlg4p/uT3EjmoaLnbYJnkxpX8z4Kndrbm36tqCdA
 IXOV+BS92h4GKag31lQojOEsjaMSbXdYhWZjoy/Jm2uz56IWuG+U=
X-Received: by 2002:a05:622a:2589:b0:51c:b900:513d with SMTP id
 d75a77b69052e-5213e082536mr173707521cf.53.1784627190041; 
 Tue, 21 Jul 2026 02:46:30 -0700 (PDT)
X-Received: by 2002:a05:622a:2589:b0:51c:b900:513d with SMTP id
 d75a77b69052e-5213e082536mr173707191cf.53.1784627189340; 
 Tue, 21 Jul 2026 02:46:29 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edcd13sm37072607f8f.26.2026.07.21.02.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 02:46:28 -0700 (PDT)
Message-ID: <85a6581d-b5b0-4827-9897-cfa63e19ab5e@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 11:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/intel-hda: restrict all DMA engine paths to
 memories
Content-Language: en-US
To: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, philmd@redhat.com, thuth@redhat.com, alxndr@bu.edu,
 qemu-stable@nongnu.org
References: <20260721060941.2989396-1-jianghaotian.sunday@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721060941.2989396-1-jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u43sxwK9DFclwmar7KAFsAybI7S7trKX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwMiBTYWx0ZWRfX+ysf+YJAXAwG
 w6xgPZ7bizfC9DSgMZ775+kILORo4+V8tDcKuYuPANk1ODZTxi89FRa7xuh1tEaHEtlPd3RqAh5
 gHaNYOxd4a6BN3mkn6bTeV2WFGUjsv4DOWZD4+ARbTG/21lVnPKLqGwhPdLu2KdoqQfDo17PvqN
 IP1uCN9KaNtRQ5RCqBchB323HjznvbvBIoLiq8lg8TOxaHEn+kPKPVD13k9LYxNCqc/JbVmMmDb
 U88/bl/Jq7jp8DvxETvqc3aPOGQcyzUe+aREwyx+fCW7aRquFcnVbr/4maBke5DKxJEdTuV7k8p
 KssAjzOl5t3O7DofWlej1bgFpxujoztt6Mkhz/HdfDLfTXxCgOwYlFsCuDgiep1gIRkL0ccLzJX
 6kQg0VlK9Pco60vBRulKwe+4AFP58UoqC5R7LFjcfbUgQHW+h9WrQSlGuKS2zBPHUsJ/tDXaCcc
 0QyRjdkRlFBfELRYD5A==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5f3ff6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=MdMbO4X_2lyUEMNyGkoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: u43sxwK9DFclwmar7KAFsAybI7S7trKX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwMiBTYWx0ZWRfX4ZoTjIUG+8ii
 nAsti0d3Tk7tY+DdXFaVQG1+A8k+3tbr18a5uoKuAiV0M3bpWOU6jWh2a52t3cIT8w8F7T0Q29v
 aA2zUePwkWYtrvmQnqjuYipFVRdI5Uc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210102
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

On 21/7/26 08:09, jianghaotian.sunday@gmail.com wrote:
> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
> 
> CVE-2021-3611 (commit 79fa99831d) restricted the DMA engine to memories
> by setting attrs.memory=true, but only applied this to intel_hda_response.
> Three other DMA engine access points still use MEMTXATTRS_UNSPECIFIED,
> allowing a malicious guest to trigger DMA-to-self-MMIO reentry:
> 
>    - intel_hda_xfer (line 398): called from the audio timer callback
>      (hda_codec_xfer -> bus->xfer), so the MemReentrancyGuard does not
>      fire (engaged_in_io is false outside MMIO dispatch). A guest that
>      points a BDL entry at the HDA controller's own MMIO BAR can write
>      audio samples to device registers, triggering whandler side effects
>      such as starting/stopping streams or injecting codec commands via
>      CORBWP.
>    - intel_hda_parse_bdl (line 478): uses pci_dma_read which hardcodes
>      MEMTXATTRS_UNSPECIFIED. A guest-controlled BDL base address can
>      point at controller MMIO, allowing the DMA engine to read device
>      registers as BDL descriptors.
>    - intel_hda_corb_run (line 333): ldl_le_pci_dma reads the CORB ring
>      with MEMTXATTRS_UNSPECIFIED, allowing the DMA engine to read
>      controller MMIO as CORB entries.
> 
> Fix all three by passing {.memory = true} explicitly, matching the
> fix already applied to intel_hda_response. For intel_hda_parse_bdl,
> replace pci_dma_read with pci_dma_rw to pass the controlled attrs.
> 
> Fixes: 79fa99831d ("hw/audio/intel-hda: Restrict DMA engine to memories (not MMIO devices)")
> Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
>   hw/audio/intel-hda.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

