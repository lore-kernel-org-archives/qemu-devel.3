Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0381C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8UG-0005EI-Vd; Tue, 21 Jul 2026 07:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm8Tw-000576-OO
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:17:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm8Tv-00011k-5F
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:17:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARPdH1482233
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MNnu0UB7nGtNikgJzDyfTYtQeI8XAfwWuLpzSI6/228=; b=Chc0Q2EwgMKO4nHv
 Onf5PfmO1B6JUx9UXCOPkov5x4KpmiKv8gZkc+UFWqlf8rqlyQ3ck4YL2J/HVy1J
 //HOyfd3l9vXzUnroG8i5zHSj+duy8o/0JdkjSi7mespX1nDuEhL5t+po8gjyUys
 opmcZtMuhwTv4QcaFXcROlQh/M48gQkwSqAxaSYizqkY07x98wuJR9cao+IaEIjw
 87Jtg75ltA1Zh76GwBIz7HbI6FA/eCt47c+HrDdIQjwmR/lg6Xts4/eS2cPOZrkn
 9fEiGqqGWkKGp6/t6qdPmtoFhAG4uocSOEWUGpcTe+H+HpmJ1bJ+w3a1fjPBPCVn
 l1/5WQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhvqnax68-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:17:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso229436081cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784632667; x=1785237467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MNnu0UB7nGtNikgJzDyfTYtQeI8XAfwWuLpzSI6/228=;
 b=XJP+2Gh6l5pSPv59tAdhNtNwqRtz6EUWeLADrlyrTKL7UciSL/QveUQN8/TKidUAaB
 gU0+HVd6ZmPECUMATMO+xWAkeWATVTna8hMw44VIzw7QXQ/J0KFTO8J2o9f4hZK3xbuW
 koo44QeevbJyOP+lwVhxp8uE7PwvrCBRGHPRaPyMThLif/bm9BYeh9Ptnv2irqgRgZH0
 akB5PGWozXJv/y+AjpezrLJBmg2KBBvZI/B/pIydqEU2UWOUhaRuZYJwoRP7JFkh0Gio
 de5x65+4RCriPR/zp24xvAwD0bp4Iw3TXezw0zD10I1mbcT1nEwEznTJRiRotLf5Ktv8
 IYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784632667; x=1785237467;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MNnu0UB7nGtNikgJzDyfTYtQeI8XAfwWuLpzSI6/228=;
 b=d8RwdsVgQvSfuXjCD+9D8wfZ2MdJt0GSvuKiJiO/WF6UkrIqkMgbUtHVL3St12sWG7
 yGctY+vj1VNbfi3oNtz7qmWY6m2q+VMbZJQiHtxS5zrB+RVUfGUzWkbl+Y32640qs7Of
 t5Txv5JwOqlgKgAp37glGYOaD/A6ZqyNy5LaqLKfkpgGzlrQfCIaj2YggESMfEnP0FEF
 Xd0ai78j6O9m+T94JagsPWg0aoeOCSII5chTciy6xxRvBzvIReRc5EF1laWkCIivGB5v
 GlMmOG1RTPq487vfgyuclPzxHA96ymZJqHD7vmUerTr4dKvXWcHOfUoMeSNT22fB4YNv
 S9nQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RofA0fFM5IqUOqXFsZ52JDRF820NQP/3W0q4+RHQagvGr5mdUxT/MVn3CUr+q1ians8zZ65wNNHX6TQ@nongnu.org
X-Gm-Message-State: AOJu0Yy94RXLXfuyhuH+UWRMVDD2/ACKRHP+A5xZfSKr0akU0h7BJZfN
 PDnusVnJbPu8N/btjomYL0og0LkaACdTfaydm3kpI79G5GtTDHsNwnYdw3Pfj0wa29bsFmptz/H
 JsAhb3gHm2kfJATq2SUR1vwJsGbqSkBaUzl44mQH/RNRMpsaFiNQA/OXeYA==
X-Gm-Gg: AfdE7cmPKGtCE24ayz21is15W3cVDzob8XmILOrfDfSjp3KylFdTvgUei0eR/1Gl2W4
 Ia0rP6HS0O6flm/LgvpvJfMWHPwPp+Ze1A0pUwiDgZVLqcGEAA/FZv5ZcpWGOv24dXtol5dyEUo
 3jo3Qzwk8KP5owrVAIHIVuyQtQbGJ7NO9xLHX74B1lF+U9jJObDb1hR/qUh0ajANULVZ3W6l96W
 cqjDswmmfaZZ8GelLfEhqYsysLbDWF/o3MhlvmE648raBom1c6tChBZTHgfPUCcjozvk7l6K8As
 mvp1amC0IRiNQFkqyVj4fxEXbn/vDavSK31q0ESwdmCHvEksJvwjts7/xIOtwg1+rhvANY2GIv3
 yCHjAbHmlxGOtrVXdEmOm9CtWNXBJjObLyySFJCTN0GAtw2QtUNE=
X-Received: by 2002:a05:622a:1a85:b0:51c:15c5:2be6 with SMTP id
 d75a77b69052e-5213c0135d8mr165236371cf.8.1784632667144; 
 Tue, 21 Jul 2026 04:17:47 -0700 (PDT)
X-Received: by 2002:a05:622a:1a85:b0:51c:15c5:2be6 with SMTP id
 d75a77b69052e-5213c0135d8mr165236071cf.8.1784632666744; 
 Tue, 21 Jul 2026 04:17:46 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e65644sm36693034f8f.16.2026.07.21.04.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 04:17:45 -0700 (PDT)
Message-ID: <5e1cbaf7-dd89-4bfe-8ab8-27b61c85c4e8@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 13:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/net: fix rx_desc_len on migration load
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260721111126.3278244-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721111126.3278244-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExOCBTYWx0ZWRfX5R1r7fKTV2J2
 ZEsScjh34QucwISRb+Uu3aJs2s2GxTG9QtJxuM5RmvN1jmAHx+KTfvZGca7qJj111/PU2UfMAFC
 vWyXbE/usrfsrdIZGkNDNfDdeJQfuVdh/BC9QoPDqDPwutoYCr9yDYxIcxg04iSFwFAgvdvys/D
 ttmu4Owg3B/AdD0se9NsPAeQrpo0k2DSWdUIZMXeifAkd9jPQ2U3Wfgsx2la3wpU/7zYmoZxPtx
 +l2HLZ+2SaaYWgTTDFKxPMvjyV2gBkhbQtsh6iIjkStRuvVYsnRK0F68Ltd6nanzd8tdSTttKb9
 ZJRKStgJr/viks4QywMjsulBnetoe1yyGN1fL50aVeOqZqe4ANhsDOJwtaLH7JYhJI6WN/B7lUg
 PYnmDRnt9bFipCSX6AjOyffeIaWPSA4DW/0AD7Ia3tb4wjhDdZx1vhHrbuu30pPqXc7muUrQt12
 Hfvn/l7GYdqjIyBbojg==
X-Proofpoint-ORIG-GUID: N9-RUZ_BiukryRuReX2nTXbcVCxu2qig
X-Proofpoint-GUID: N9-RUZ_BiukryRuReX2nTXbcVCxu2qig
X-Authority-Analysis: v=2.4 cv=M5F97Sws c=1 sm=1 tr=0 ts=6a5f555c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=Gb-HvRjteCOY3wdVK28A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExOCBTYWx0ZWRfX+Qxctrn57wvw
 anMI/otxGHPcQOj1pllRlLqj6o8NsruxIkswqqtVO63/VTskm89WhPnGXvRWdY76ao2ox7d0wPZ
 v0XdrCv4kfJeAoUvOTfHh5HsLx7ZoRY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210118
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

On 21/7/26 13:11, Laurent Vivier wrote:
> rx_desc_len is migrated as a raw uint8_t from the stream in both
> e1000e and igb, but it is a derived value that can be computed from
> the register state. A crafted migration stream can set rx_desc_len
> to an invalid value, causing a stack buffer overflow in
> e1000e_write_packet_to_guest() which copies rx_desc_len bytes into
> a 32-byte stack union.
> 
> Recalculate rx_desc_len from the register state in post_load,
> ignoring the untrusted value from the stream.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3869
> 
> Laurent Vivier (2):
>    hw/net/e1000e: recalculate rx_desc_len on migration load
>    hw/net/igb: recalculate rx_desc_len on migration load
> 
>   hw/net/e1000e_core.c | 2 ++
>   hw/net/igb_core.c    | 2 ++
>   2 files changed, 4 insertions(+)

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

