Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0E9C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyuc-0003hd-K1; Mon, 17 Aug 2026 11:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvyub-0003h2-4t
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:06:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvyuZ-0006nO-EQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:06:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HD68SD2329989
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 15:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eyeJkY5A4EvLdYMZGIQHwHxAXGdP6HlXdZXMf5YCUzI=; b=ZXHc3Vie62+MbP6Q
 VVUxaBnz1PVfWNwUhmCc5tdwNMMwR2NA8oreL3xMSVJcCSwz7qbI48pYp0SWlreT
 VO/1dYlwRnFX7lu40qMbEqCHe4AiXiBZDTzuIkwkrIH0R47ENoKQTWXwpqzroXJe
 6MtVQ4lx/D5XAa3n6yMycR1HWmA8n5Jn7OPl0rus6ooiLfRbb4PHpNJ+dE4mjDcY
 Had2xC+vlxOXoi3G5RvBnO3xKZo1oymBPM06UtCRpyJTfbSRny9f4zQ4eCsAQ52D
 ko9y+w35o5G8MwHl7YOyPk1IZWIbKUmt8gKxAZryzluLfSBpgqm+5sRgz+tZNiOX
 6kKM1Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3vght8sy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 15:06:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93494cce712so397704885a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786979162; x=1787583962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eyeJkY5A4EvLdYMZGIQHwHxAXGdP6HlXdZXMf5YCUzI=;
 b=G4aqw6ow1G7p+vXDa9brw5nq8PRjT0iUS2jlFZRnYM7MCbabPlYEd7Wjk8Yzresa8A
 XPJ79xFF13xVjK2EYtGoqbf/u52aDB0knXUVje/MSRCi8Nwh9mNCoBNPt2bYPzHBvW/+
 PqgCzfxzAX1nTE4U9F4xtzZxhYSBbkLD5e9dX3IFWscVV6mxdmcqFAs2cioEVzgRdO1N
 Bdb60xctVnqe1LZcXXufyQysXbZyTuaY4SkFsKN8ijT8GZ9LFbXILkE+6yAGDcoT2aVb
 IIJEwzzvpCKhOiYUYQPf6SpyK+50jr5QSOvIyy4KYa7lOS2DByQQ9M44IRWZxkNjgtA9
 55gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979162; x=1787583962;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eyeJkY5A4EvLdYMZGIQHwHxAXGdP6HlXdZXMf5YCUzI=;
 b=Hpv0TJkxGD0caT2r+Q1ReTHw3/n1B378zB2R5DaFwp8F+V47Z+SV3q9iFE5jAUfOoU
 PJXfqYcTwcqLVemYQ96QWMsU2VEvH/aafFvZErX+U0XgBrMUelRABF8IVTcimeKjLHqE
 yRl1hy/kEyVFLTwCSYgI2ly5h1p0HPeWLKlyrzLvcfVI8HlC4gpOHz3XbduGOoFE8+0K
 fXvf1q5Xg33BaMh+gICEEo18wdxxBYaUKeSWCiMv4DGfl8R3O2BBTBXuS42xXyje2dqk
 9wnpXw3WmdKl8w0XlRtsESJwM7PjPebirLnynD368ovF/S/zfIAmzaCEfpMLThRaALRe
 XYpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWcr/2AOnxJeld3ZuDY24jzujvPTit38ZixjGgIC+NgucSMjudmiR2AqW1UukT4NTqZld61ZeZdB47@nongnu.org
X-Gm-Message-State: AOJu0Yz3Ug4pH3V45vSwKA1VLARNKfufaorMrS8p4sQLXT1i2WzWpL9m
 xVRBO+fq6iUZyT/DN4FruPrh9da5lpnx3eN3pqgBJ/tuxOU6/1pIUAuahD0aMS7H4OZCxC/x8+n
 ZT2Niv4zOYuFHew6AozKBz1FPoReqlAAHVG2PO/lMxCmoXT1hTKEoRouWvw==
X-Gm-Gg: AR+sD133l7XkAPp9zH80THIWYy7LgdLcfqzKRHmNpb+Hb7WsKOHvMn5t9xxqkPAmvqX
 Dh4bMWk5rC5Q2gq/V7/jUzdeYML/uLYA88csRasxJf9nV89avLnP8u2/soq1l3yqMy7xMoXcyjL
 swC2KNFQX1Y7diD2AtjwysVVlduyvQ7HSQJr6beVFBYoFp3fjxUzaIhcU2r5trtlqWyT5g3PIVe
 uKfdkdLjc3SJ+fReXlyDmxRFflCZ8m3WQlrehXL+M9vqIaIHY0EbvU8yG2bp4B80u+nrxd2I+9R
 GUCSZJIMnG3WVrqxKTbwGdAMQ3/A1VdDpo+HHWAOg+Ze0YIEbTl+U19ODmuti3lT6jjjZx7X9D4
 4kFw6KKmbH6GEoGoprJ1Qqd8lCk3iSH73QCs=
X-Received: by 2002:a05:620a:f06:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-93704b7d4dfmr132300285a.27.1786979161649; 
 Mon, 17 Aug 2026 08:06:01 -0700 (PDT)
X-Received: by 2002:a05:620a:f06:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-93704b7d4dfmr132288585a.27.1786979161147; 
 Mon, 17 Aug 2026 08:06:01 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b816f7sm4361897f8f.34.2026.08.17.08.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 08:06:00 -0700 (PDT)
Message-ID: <1d52ae57-a221-4dbb-a6b0-becb1c6c69c8@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 17:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-4-michael.roth@amd.com>
 <cc83a207-c89f-4ec7-864a-db0115c4f641@oss.qualcomm.com>
 <an8Nn5cb52ev4MF2@x1.local>
 <8e376be3-446c-4783-9081-a633ddbc7a74@oss.qualcomm.com>
 <aoMCIYgJcmIbcVeE@x1.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <aoMCIYgJcmIbcVeE@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=6a83235a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=ceHkzYvfykAgSQDLxeUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX9iXZ8gtDH2Fo
 Bjtz7mBKpJ6QUYVIeEgyk2XTNuu7zxKKGHLDsyayhFYrsgL2JwClgxRHHCxbDsS0EMO3/y0Dyd9
 Bl22bt78oMk9DQQb+Rmb3t/xtcIwzYY=
X-Proofpoint-ORIG-GUID: QZ21PA_I-2N3tKjKQKCed5EalvN-yAIZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX2P3d2bQJzob7
 fnrE2fSpQNVBR3thLTvQJ8OD3rFTU9f4HHSYhYXhV64HR0DeDAtbSxRhD7W1fMhceNoZ7AUbHJ6
 Ov7ewJ3KAfChXVhLpRLDubU5LPlR+1YIRidY2zvnxPgPNsgR+yyb7csQZ265Yb5EP1z98LKo3Yu
 WmWZIPXZ/jmhC8/QFypRCsP4Bgne/4IhsgCYFBqjqokaGXkXqV48AVvKvSN+k2hOBMHpAnNks8z
 sZLUazHj/RE2mHOGEh62o7Ldc3MpUclEA1+TXvaQEzFDwndSM9up2gFLrXS+wW97x5OTM030An2
 8GUIjYs1Qz9KpziKfJ/6RHKu8W4U81w3vsSw7dK80uZxvd5MV++uqOBAg9YVpkk+tR8Uwo2YUOE
 PDIc/yDNRJA2/eXFlbdPJdRaVAnJfzVjpGgEc7q5FGTK3jZp2JTFNyWNOVLoZvaFElVG3ajyImm
 MoUMO2SzVMOhovDvamw==
X-Proofpoint-GUID: QZ21PA_I-2N3tKjKQKCed5EalvN-yAIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170115
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

On 17/8/26 14:44, Peter Xu wrote:
> On Mon, Aug 17, 2026 at 06:05:45AM +0200, Philippe Mathieu-Daudé wrote:
>> I'd rather avoid kvm_enabled() checks in kvm-specific API (accel/kvm/).
>>
>> If ram_block_rebind() is KVM-specific, why expose it as RAMBlock API?
> 
> I only started to remember why this patch existed.. after this series
> applied, kvm_create_guest_memfd() can be invoked from hostmem code, so we
> need this patch to fail on old kernels that do not support init shared (old
> kernel case, user triggerable).
OK, then please add a comment in the code, otherwise after also 
forgetting the why I'd be tempted to remove it, the pattern is odd :o)


