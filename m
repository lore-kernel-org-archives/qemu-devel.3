Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C8FC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfGE-00028F-D1; Mon, 06 Jul 2026 05:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgfG6-00027V-0V
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:04:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgfG4-0001ob-7R
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:04:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66694IVE4180021
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 09:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8hM5NDsWI62UiMADgHE4LtrKZ59WA72p4p+zomlO8LA=; b=lIvPym1bw55XE32f
 kauu4TfkCFIVOSKgLqaIVxuskngIKh6s3/GPlMEPEtnv0rvoSSEaMbZd451upKG/
 iuCMl5It7LC6GqkA1YRERfjgGx5mUVOJu0K+NK2Y7vadUrOuxr5PwDG/5E83NFRe
 8W0l+wJY8ROd1RJGec7WZF/KXE0rPcMPjYUR4DW8YYuRhQCYFKOOqQPxV5K2QLoc
 vuaHGGnepWiL+MAQhf6dCZ2QSa/00a7UvxqJ99aGzwb2aTAEdwgjWdFAk0o8x9Y8
 476AFu13RmIv91gT+2QJ7afjMS3sFsGEci56S6h4WHiWGJXPDylQYPX7Phjx9tYx
 vcg+vA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txena27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:04:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e538afe65so263344385a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783328693; x=1783933493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8hM5NDsWI62UiMADgHE4LtrKZ59WA72p4p+zomlO8LA=;
 b=hdGzi4VrRtmUe0SRxhclOWKyPRFBKdEk/tRb+O/WOMh67JCSAvX/L2KcDu+CB81Kn+
 X2tPzXUdKWz7MWjbPSA3eC8QV9oAnTcESq7X9UOzkNpaWgCTlA4GPLQXSG+PeJLQ+ktJ
 pbWsnWKsK1j9oy8zGvLy5BVArJiL/9E/znqBkZfs9vwXvoBEgz1+1jVBG87FEi4aIRKT
 /aW+2TKvKAvYlFLCopnYGVcmWaRC2pKiAzLdOEaryP7P/vqsXgoGqKWIShFRrbiGAZuc
 cYK9fdoww4XXXmPyRHPgQF/wQeD67NdL3lgrqXiPbLzSaM7lnSB3Qnxv7VoPPMziyyk8
 5ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783328693; x=1783933493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8hM5NDsWI62UiMADgHE4LtrKZ59WA72p4p+zomlO8LA=;
 b=ONEqyRy3pInuXgUI2vlJzmOlfwaLRUNcVKT6a1oxShfbA+xBkQIZvoG7P0IC4YBfkS
 DDUohE4iGhiBxzpt14GIOFEqOKhF6vadziN7Jv7CRFeM0OJVodLSJqqfMf922LVSq7uM
 YO0/jxssh1Huoa5bszvczcKWuePN/2SreN0OX9EL7hEivK+2qlj953SUXho7hbPznrLw
 WxFIdbxHshArwA+qNPl9sRv6iKFbZ5JG02+fp5Gdtld41shWbZkUxA4QMHmQ2Tz0YVtv
 zvwlV4dxSMaMehJrRjNmtBFAZkVl92YGUIAFKQs5qR63jpR0J3UzsLMWgP1s0wOm1XWw
 //eQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfjnMJbWDm2btWpuFcl5PB70RekIVGpViDAy9VXSadtoK/YvqOcyDaKN0nH3B134P1Efcg4oheBSrC@nongnu.org
X-Gm-Message-State: AOJu0YzzgPxnUfRM0W/Sw1f0jNGxiXC6jK0632QDlAiT2jWdKEzXXgmJ
 lUnCRQBhEnekd7eiPS3D/+U+WBZ1IAE3CQyFlHfWS9PJpmc9DN/RS5tJizNJ3lBZ4Yodi0xT7+I
 GwYGQYTzf7xM8s67OORPd/NzAwKojaipYMGT+tfDpqsv2Fv4M9mhIv3K9ZA==
X-Gm-Gg: AfdE7clfu8WOgJGrqz4NCqOfDCmQDEXKdzM5GC9H840Bk1clEnIUHJEEM/HKYrt+PrT
 fbID/uHApXb/0l4aA0UGdx1uAeciZ2iswpyfHRGHgFpYIrifQ5A2kkgiMIjr4C27ZtPzG4+pfnA
 19SwODtjjGpK0GfUn295rywIMaQmLP2IxPqZCD5XocmGAriRhIgRfnGuS2OCzza9y40lasA7WQj
 qSgM7dhj2LcgbFcNHYslJ/cISLsJH6UW/LZkNAdsS4i2hTI5Md+GMtQu6vn/YQzuzmgYkJre0DY
 kB1uOaxi2EnWaCGkAyUwHPeh4svisHuCOLlinNRnGzbPCoXXYkep7Vv2Kc89PeHjcmu/F71hdBD
 MQ5eNpsmYt2Cwc1R4Y6GIHelFD6+8dhnq9+mv94N3lLHTx6l42gjgEjBkQcHToA==
X-Received: by 2002:a05:620a:4550:b0:92e:7427:ef59 with SMTP id
 af79cd13be357-92e9a344d65mr1267784885a.11.1783328692621; 
 Mon, 06 Jul 2026 02:04:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4550:b0:92e:7427:ef59 with SMTP id
 af79cd13be357-92e9a344d65mr1267781785a.11.1783328692085; 
 Mon, 06 Jul 2026 02:04:52 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b628efefsm706014566b.32.2026.07.06.02.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 02:04:50 -0700 (PDT)
Message-ID: <3764063e-f832-4d4e-bc0e-1758ce1a04f5@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hw/net: fix e1000e/igb ip_len inflation by Ethernet
 minimum-frame padding
Content-Language: en-US
To: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
References: <20260629-net-tx-pkt-ip-length-padding-v5-1-16760e30252e@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629-net-tx-pkt-ip-length-padding-v5-1-16760e30252e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5MSBTYWx0ZWRfX46qPm3OKbkV+
 czE1QRlzvWFk7Ng6wvuQF9hwr4UgFT00jz4FP5/q9CGl91UmbktUeNg4dQAq9eLYNLYxaQT5Htr
 ixebXSlOESjEaihP3iqqkMIfuqAHEpU=
X-Proofpoint-GUID: JzBq5P9_R4NzfQFN4zmkyo9HhwKR-Ss7
X-Proofpoint-ORIG-GUID: JzBq5P9_R4NzfQFN4zmkyo9HhwKR-Ss7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5MSBTYWx0ZWRfX8TOInpp5wJTI
 dtvmOAdKKNjrGsAheRoKTaid46vZc0JIUnYaJDzn6xbJohFH7/nPvoZFT1Z96h74Zp39yfkEeLb
 avUuKInSfkhsayybjXX6zdlpk1KO/zGFRseS4enge4iNOYAOMeYvnEwIXpNdRSakzdj7QcZFDoi
 6XZz8CiK45YlTv1ZVSSYFIPPX7g41ULpM8UaUX4Hfp3nW5W0YORjVJqhkawqZji8SxXvstQrTWx
 JM/RguSx0pE3+q3DT8kZIzEI9FmL7ysSZZF6z+a6iabGUFOqnnq0v0iHQptKm7oiUgM6s8mDMab
 7if9DthiMMYV6cL+UOBDWnttpRqm7UaOPFgMN0Fg6BRf2288E8T4/uh8h9VJz+MQp5ArvCYk5hH
 6e9Qur3hM/e49ryU8uwjNzWqWM6YA1uh/nYm5vQ4U3bgzynVdG6rwqr2bFkNhzw8D6S+gnStci+
 zxrIRUbUQ9nxZPpqlCQ==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4b6fb5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=erkUBNL0EEqovBnOwPgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060091
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

On 29/6/26 17:21, Sanjeeva Yerrapureddy wrote:
> When a guest transmits a short Ethernet frame, iov_size() returns the
> padded wire length including any bytes added to reach the Ethernet
> minimum frame size of 60 bytes.  net_tx_pkt_rebuild_payload() uses
> this inflated size as payload_len.  net_tx_pkt_update_ip_hdr_checksum()
> then overwrites the IPv4 Total Length field with payload_len +
> l3_hdr_len, inflating it by the padding.  The receiver interprets
> Ethernet padding as IP payload, producing a malformed packet.
> 
> Fix by removing the ip_len write from net_tx_pkt_update_ip_hdr_checksum()
> so it only recomputes the checksum, and moving the ip_len assignment
> into net_tx_pkt_update_ip_checksums() where it is only performed for
> TSO (where ip_len must be derived from payload_len since the guest sets
> ip_len=0 per Intel 82574 datasheet §7.3.4 for super-packets the host
> will segment).
> 
> Both e1000e and igb already call net_tx_pkt_update_ip_hdr_checksum()
> from their IXSM paths, so both are corrected by this single common-
> layer change.
> 
> Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
> ---
> Thank you Akihiko for the review of v4. I agree that avoiding two
> similar functions is cleaner. v5 moves the ip_len write into
> net_tx_pkt_update_ip_checksums() (the TSO path that already owns it)
> and strips it from net_tx_pkt_update_ip_hdr_checksum(), which becomes a
> pure checksum recomputation. The net effect is that both e1000e and igb
> IXSM paths are corrected automatically without any device-layer change.
> 
> Changes in v5:
> - Remove the ip_len write from net_tx_pkt_update_ip_hdr_checksum() so
>    it only recomputes the checksum.
> - Move the ip_len assignment into net_tx_pkt_update_ip_checksums() (the
>    TSO path), which already called net_tx_pkt_update_ip_hdr_checksum()
>    immediately after. The comment and the ip_len line are restored to
>    their upstream positions.
> - Remove net_tx_pkt_update_ip_hdr_checksum_only() entirely — no longer
>    needed.
> - Revert the e1000e IXSM path to its original call of
>    net_tx_pkt_update_ip_hdr_checksum(). Because that function no longer
>    inflates ip_len, igb (which already calls the same function) is also
>    corrected with no additional change.
> - Link to v4: https://lore.kernel.org/qemu-devel/20260628-net-tx-pkt-ip-length-padding-v4-1-829b36db5adb@gmail.com
> 
> Changes in v4:
> - Add net_tx_pkt_update_ip_hdr_checksum_only(); call it from the e1000e
>    IXSM path to avoid inflating ip_len.
> - Link to v3: https://lore.kernel.org/qemu-devel/20260627-net-tx-pkt-ip-length-padding-v3-1-e860dabadd3f@gmail.com
> 
> Changes in v3:
> - Architectural redesign: three-case fallback logic in
>    net_tx_pkt_rebuild_payload() plus net_tx_pkt_set_payload_len() API;
>    e1000e pre-sets payload_len from PAYLEN descriptor field.
> - Link to v2: https://lore.kernel.org/qemu-devel/20260625-net-tx-pkt-ip-length-padding-v2-1-287d0ba59ec1@gmail.com
> 
> Changes in v2:
> - Fix iov_copy() to use raw_payload_len and net_tx_pkt_get_total_len()
>    to use iov_size() to preserve correct wire frame size.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com
> 
> On the relationship to the short-packet receive-path discussion
> (Peter Maydell):
> https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/
> 
> The linked thread concerns the receive path. This patch addresses only
> the transmit path: the IXSM offload path was overwriting a correctly
> set guest ip_len with an inflated value that included Ethernet padding.
> No changes to padding behaviour or the receive path are made.
> 
> To: qemu-devel@nongnu.org
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Jason Wang <jasowang@redhat.com>
> ---
>   hw/net/net_tx_pkt.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

