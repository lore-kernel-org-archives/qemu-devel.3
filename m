Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A6606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VH+7DXJX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kZYFxcm/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1eE-00026m-UJ; Wed, 28 Oct 2026 07:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM1e0-000252-4y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:16:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM1du-000289-WB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:16:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S8KTca3265161
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2lKMvhrx8peyinu9boNXc0uqxvs8fwHIfVTWAHDwRKI=; b=VH+7DXJX16LZ1U2T
 53va/fkn/NOH6Kh8PlFBMwuz3dij2mubJzt0O/wQqHCk2imyNZRfBGIQnyKfXg3U
 zWmlB6QSU/YGjttTe+TbND4zPRf6WhTSqRM32hT5hY7DVZckKa0bX+1U6pBaakpy
 YAwoyYohf5iZv3lIQB330Dx6un2htrGoTO8tWywVXCb6qPwOobunnnwyAqr7LvhJ
 c+w6sCVfP9S1UA8JXmDUIt38nwc24QysWTz8vt00uar3SyTaI4uWLx+9Im4g5/jW
 5OqUlPWhYWUu6qnls0E4u3RdBWUcgk67+hhI/doaX69flzbn9UCuCluvScx6A6+d
 +c8epg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy713w5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:16:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so146768385a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793186187; x=1793790987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2lKMvhrx8peyinu9boNXc0uqxvs8fwHIfVTWAHDwRKI=;
 b=kZYFxcm/DZdfbjHfHjQVUagRzpEZR4ylbk8OKz0dqYULXAVLaWoO1/bBoKHtlnEEj+
 5gXXyiAVPNDjELf1bTnPi9vTUj+i6TUw+oeU11YjaqWO/aJey+HCS+K/84i/TrgNTXfD
 4+b8D2KAJKKiuCikA6eqDLOLvx/VNZtl5KUoq8bZ5wfNwSppV+Y2fWnvzMRITYfjTRBD
 14EqTW+QSK++h2Ac3hPwyy3irL0H638yOim4Rk5d14+6vI8F0BpnsTMt3Z/aEDvRt38T
 lFqhhOwHkZiKmnzgKQ2EYxQFd+859X7wXiQPRvSXfSWxVCFMYqALr2Q9eAW1RIejU+zO
 Wa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793186187; x=1793790987;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2lKMvhrx8peyinu9boNXc0uqxvs8fwHIfVTWAHDwRKI=;
 b=BE3kYc7DtR6hreAlS6XR8g1sTfDFPwD9q9lILC96gNyvMSPeglT4Fiqs0G6qyZit5n
 ENSuXEofPQGMq6FAaKbw9vkvF+YW3GnvfaXLQjfR+Rv6dwydDLAci6nkadJJYhj3ZfNc
 jbSragksLwLApje60/VKAkM3HojHog1MRAA4rHDMQ5qoi9k80jadNrlwEbFiHm5GJw7d
 VnxAIdPbyJ+56l7JV4thvHy7mbVKzcqW6RmdGZEggqNXfgUIac3eqQtMU5RFWxbTWXRn
 7WB4tq/gLdwpXUq9tPiBbBBT9nwhr4dQMLB9JtPtyNLzeJDCSINWJ3jqIKX59PWr1os2
 y/GA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC4cAjDKlflHXekH1VLz8W42sjQX/kHRzZxlaPlOO1IUXQ3Jq3PN0/vjIwbwODohmsFyvS/MVT96Nl@nongnu.org
X-Gm-Message-State: AFq9FYKF2wu8UndkORScyuQzC8IFy8aERCcfzWKNeT7DktxEvml3dZY5
 XEHKZBosgzbGm/J0ZLhMkCtdZo/daAiDkaD38/w3gg8b7ADjMPyYgwW2Wu2mzhiTDxpcHs3wHxu
 fcGreNmXpI5Yfcbxg5b3lvGrksYNzb8rq567SQ1u1sbZFv6S1t6PX5yi/Qg==
X-Gm-Gg: AYBFou1m0L1D08YvOLKRdO391tSXuXPhOlw6xxC70InAPRDEyiDKEvcwWoqz7amcn2G
 Ts0BTD4ueP4OVsy0tkfaAAP6IQm2JOXqOsxHQlBjJ5ng5STZPb3zEhPh7/DZFg6fPHFOdoLX03N
 1C2AReHKanJoB6dbJRMdzKoMVhfvtwHmOjHgB7eMuOLykEyzlOAqdjsuy5Sj4xuhYTL9ta9a9nF
 a7R3llZD6g3K9JPIq9LH2U8T/vliMroo03eAMz4O48qrYzoG5Fi2I6/jiMs5Q+5B5vcmxAaUhny
 I1bOOTAyUxKzmvZopDppBT6RuIA2Vlw+J73ZNrE48opePE56IvWPTSTIQ+rTeyVN548vy4PmrNZ
 lQs/202LPZOvcde6g/apq8Eo9bKnNjWGnP/RX8SMFsy5PmmJrw/PqcFgkbGHd7xTawm3pGT0mhp
 EthY/lKKch3Nt2Iid3B9Kb1gI=
X-Received: by 2002:a05:620a:31a2:b0:93b:c537:fdb8 with SMTP id
 af79cd13be357-9440892bd1emr279769485a.6.1793186187512; 
 Wed, 28 Oct 2026 04:16:27 -0700 (PDT)
X-Received: by 2002:a05:620a:31a2:b0:93b:c537:fdb8 with SMTP id
 af79cd13be357-9440892bd1emr279765885a.6.1793186187061; 
 Wed, 28 Oct 2026 04:16:27 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece5e4asm27433353f8f.59.2026.10.28.04.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 04:16:26 -0700 (PDT)
Message-ID: <d7731f7b-52a2-4690-b4ba-a6d60f2f6626@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:16:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Reorganize pci.h declarations into sections
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20261028105543.1287795-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261028105543.1287795-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfXzBMC9NPe5qOv
 fDk4PG6Iq1gy4hWAX4y/p9JhlGP17b3hLdl04JXDX3mfmY8/5E7RK20ZXggZ9hbuSsN3h4mY/xx
 20fm8zfSqA2QprvUUjqeRV5RR+Ygfg6/iqTNanOardw/oHeN3OzHWgmQA28Zz3VAf6nd/XFsyQw
 1LZqTGmx4QfpkH+9zoCsxoRpeJc7Xnboj79dj/6jorn8z8yPs9Jsbz/L5lfpvc3FTLq0ODd/Wei
 de/Q64CBvWLhjR16UeUCNn8QqAS9Y+n1MchCVCIHCzO5Ks2TwmisobymKxXemtH5JyNz/uSkObx
 o6xB7En2aS6kAOn1N7/zPXNFJYsDnjPCJ2eY/F3Ecn62xtkefyR+tgcKiugpHafd0YVvKmQ9lri
 2Af8R9kw60Fj3nJREJRty6DbqXaERfdDT2rDHRL3HFzrDyN2CU2Et7VMY+qvvNVvBrshdFdTZ+c
 9ZsX8d+5aaOG8OoTROg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfXxY9RrgNxn2qK
 c7cQwNlehyPseCy5s974PT5Shz8WTdRpXohoqdT6GkZyG9/KXH59R4zeN6ODbXRX8YR/DXGybDD
 yfm/Ct3l2ybuDx56IjflrhPBL2xUXqI=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae1d98c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: qM3iJZBTTzpvzXUhh_xWTQa3Ep4vGXaZ
X-Proofpoint-ORIG-GUID: qM3iJZBTTzpvzXUhh_xWTQa3Ep4vGXaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280044
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/26 11:55, CÃ©dric Le Goater wrote:
> Group function declarations in pci.h by topic for better readability.
> 
> No functional change.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.h | 62 ++++++++++++++++++++++++++++++---------------------
>   1 file changed, 37 insertions(+), 25 deletions(-)

Good idea.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

