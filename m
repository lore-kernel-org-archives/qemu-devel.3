Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EA0CA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEv0p-0006um-9e; Thu, 08 Oct 2026 16:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEv0o-0006ue-49
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:46:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEv0l-00086Z-Eq
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:46:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HVgX03197404
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 20:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ztEycfdFFiacalywce2pUIxtQcddQejhJtcBfifpTjk=; b=gzFiRXRb3TkIWPV4
 SVtF04RkSm8P/QPpTe19RIL1JrqiWZfQbdJxLUe15kh4RenEegy0hLrZND39Amfr
 /CEXJ6NyJRcPEFfSnfFjWsPCNL6+XmXV5aSjSvJ1vUwcwvR9C10OYPyEj1fXreRs
 MHI5H7NfEs5zwxQ9OV+JOJMaUvctz3KFpfctsCPb/mMTNobN0CfSf9ine/GXRMhf
 GUOOy+NOqDEJdvma4KU+VGKeX3iYZhx1Bj4t4u1mV24eOM7fAIXCpdokc0zgiIMf
 NAtWn6IseZR8GfLzY8oQUtMvzami69xjh0B8pAEI4gVeWk0GXGvb5Mlziqx7i3Zy
 bXvuVg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqrng8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 20:46:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf7856ffso1065766685a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791492401; x=1792097201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ztEycfdFFiacalywce2pUIxtQcddQejhJtcBfifpTjk=;
 b=BPvLp+MjPKr93UnyaP4M/ejcnV+QI6/eNkiu6S0TslRqLQzLfIDRpvkREo/Oh6ua5n
 xomYg2gBJm9Eigxr8CrBCL+qLIejdsQ2xx1aFGzEOjJ3ib+q+cUFz1S2JGzBTBGW21k1
 akGyy+hOCNfdQPfVgoHuWgy+DYZvXE+oMGOmMadAM6xkcIQorrwM7qKpwpnVBm9ctftg
 mxE21GgxdQoCbHky8mFilG/b2wnnqkM+DyZkbCNl24PKCPcfLxzFsCqB95JAVPZe0Slk
 WQzvckww2rPlGAp7MUgNFuA4MupefMG3N5tEv8mFfbxYLlz5V1El/4Eo03elkF7bJLm2
 w0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791492401; x=1792097201;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ztEycfdFFiacalywce2pUIxtQcddQejhJtcBfifpTjk=;
 b=qUQcs5Bum2gB9Jrn9C7X/QLN4yraW7eDNJMWSEElJHqmcQgH75nCoWVCNoS8vZCkVy
 Ck5Se4vHp8nkU9GVSJTUDzTY6RPznMcoVZ7Gu/jgSUn8mOI8MnZ95Hx9Da5KiVgNuYSn
 kzGvk8OmSRGSan1AXPgmDLxqmsNEi02r0RL6zcfQRn5IEO5pwzvFD0WGlbRIFInNWedY
 RwXepODup27E3MIcV1JpIFl7AgW9wlrxRK23h+fjFrZoAimFi4/5KMqrkEReOEl+Ds0y
 fqNGJt1RuOjTUFjtzk3M5bSv34pHZqx2gu1G+ZY94jOhpMgh8jfX25BT3Thpyfm/ogJv
 QMDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXgCSV4Hk0p5+ItmLJES6Pkf1LYXhtNHLiODLn2zilJJzYTzsSllD098NFO8gMIA5+xbo9BcQMo4Ho@nongnu.org
X-Gm-Message-State: AFuF++mRv+zWM8TQU4/RS/JHwqxOHuRDYFwRbSevXnO5Vt8kHFyL4iZ0
 At7MDJba3NjytnjUs7FeOLaBgjz2HdXXcJnLH08tG4MF0NuPcdoctHhRp8t6dEv7wXBeFseOn8e
 AlLEIKVoTDu3xb465TAJMIDDbzwZQuNMXcpG/H4dZHuhEzFtF/4hlVGA2VdrNPDqn6eB+
X-Gm-Gg: AYBFou2MBQm4hzs5WT0WzCT3ZDOs6mpNr3HjLvxQ9CYzThByHUEGPThkaIryfDdwCm1
 44+Xr1et+V4bFr8Vgg3yCYs0sy1YENGBPTkrIxmBByA8VIQ5RURdqa1shv7xETVFpIJUME3LiVB
 xhgU+WqnW+FnBNk+nNhpQYeT3b0XyEgZS3IUDfFbHBQgajSlP8mzvoFu2SdDBTBs+hmLN6QL79F
 Iry0SwAJ12u2wDw5mQUy1ywun1jUwNYSO6NAd8ixiKv02GUUIcxWw45kF9EUY+9odVFJukyphfZ
 4yEbqGmyJ6raI3Tcuptjv6o0LUjRAJ+OzACXuAhx99JXIGF7g/qtQn4TNy5bXDnRj+bZz9jJUdZ
 tFNbxMlizBrsbCfrII8Eu85x12tKufSz8wg==
X-Received: by 2002:a05:620a:2952:b0:93c:771e:b672 with SMTP id
 af79cd13be357-93e9b847f06mr1269007085a.54.1791492400851; 
 Thu, 08 Oct 2026 13:46:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2952:b0:93c:771e:b672 with SMTP id
 af79cd13be357-93e9b847f06mr1269004085a.54.1791492400361; 
 Thu, 08 Oct 2026 13:46:40 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aac57fsm139154f8f.23.2026.10.08.13.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 13:46:39 -0700 (PDT)
Message-ID: <5553cb14-3d32-4c5b-bffe-dacf2ed6149b@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 22:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fail iso packets sent to non-iso
 endpoints and vice-versa
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20261001194756.3003085-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261001194756.3003085-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4MiBTYWx0ZWRfX09yLp7yH+1VX
 uaUf6PzAKmN4Z2GsMcF2BMhFbhxkzXKGQ4+lgMPSye7EKTSf8wh6YrqDC8uzhjn+A68g51JkFH2
 UMHmEoh/IFnzX5W1lBqZWG+YHBkcsWY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4MiBTYWx0ZWRfX+as32YHEQZR/
 EAuRBhaIajTRZ4plCjWzPYAEB92d7+83eXFSyZe1Hp4NzyL4wiEK472mjug9oHFGoyAQXDQZp0f
 SsDOOdqCF/g4pEC0F8PYrm/CDa2yAdTuTIZZUx6c/khOTCxPL+Q6ju8Vj+qU30aAMUpiXpeyKpn
 0dTfrsnCCZ4hAoQka35Tbka2EC+F5J4gJOlRxzJhjU/7mfxnE42eGOh9qSckMQpkxJcE4vDmaA+
 HqCrAOZzB94ac8oTG3+TuUKedkwa65Yn3qDQTDI3eAObSv32pYouEFgxKGZr5trfBut/C1+MtM0
 yGNmTfzuQsFb1LLYzWfnvujOleP+Sy7sxnyaJAx7E5ydcv/JwVXOq2D3jHvoCyGC6sMbP519A6N
 zWAAO0LoWxVQHlXSqMF4JdrwftwaOw18Iemgh9rIzl5yCnj7XmNyV8kO3fXAIfURAsKSJ8AcUMG
 DtPUAZUdvyfrJVskZqA==
X-Proofpoint-GUID: hf8AiGY-0hLTfOb7G7PMTja1mpcex36k
X-Proofpoint-ORIG-GUID: hf8AiGY-0hLTfOb7G7PMTja1mpcex36k
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac80131 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=mVuZ1GJhL4F-jNGdb7sA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080082
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

On 1/10/26 21:47, Peter Maydell wrote:
> The OHCI USB controller requires software to set up an Endpoint
> Descriptor data structure.  This specifies (among other things) both
> an EndpointNumber telling the controller which USB endpoint to talk
> to, and a Format (F) bit which is 1 for Isochronous transfers and 0
> for General transfers.
> 
> The specification requires that software matches the F bit with the
> endpoint it's setting up the descriptor for, so that Control, Bulk
> and Interrupt endpoints use F=0, and Isochronous endpoints use F=1.
> It doesn't require the controller to check whether software gets this
> right.
> 
> The spec isn't totally clear about what happens if software creates
> an ED with a mismatch, but I believe that the controller just trusts
> the F bit, and tries to talk to the endpoint with the wrong sequence
> of USB tokens (notably, isochronous transactions have no handshaking
> and the others do). This probably results in the transfer failing.
> 
> In hcd-ehci.c we check for the "iso transfer to non-iso endpoint" and
> make it fail, but we don't do this in hcd-ohci.c.  The result is that
> a guest that deliberately sets up this situation can cause us to hit
> the assertion added in commit 7b1eba96aeca, where the endpoint is not
> isochronous and returns USB_RET_ASYNC to an iso TD handling function
> that isn't prepared to deal with that.
> 
> Add checks for both "iso transfer to non-iso endpoint" and "non-iso
> transfer to iso endpoint" and make those TDs fail rather than blindly
> sending them to the endpoint.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3729
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The diff looks a little complex because of the re-indenting;
> looking at an "ignore whitespace changes" diff might be clearer
> 
> Only testing here has been running the repro in the bug tracker
> plus "make check-functional", which probably doesn't exercise
> USB very much.
> 
> ---
>   hw/usb/hcd-ohci.c   | 61 +++++++++++++++++++++++++++------------------
>   hw/usb/trace-events |  2 ++
>   2 files changed, 39 insertions(+), 24 deletions(-)

Queued via hw-misc, thanks.

