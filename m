Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA742C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz2x-0007V0-Pg; Tue, 07 Jul 2026 02:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz2o-0007Rf-Nx
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:12:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz2i-0000LZ-EK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:12:31 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66748uvh2688424
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mNeyEihWWNPA08Vf6WEHc2HLh/eJavkzjOUbK1igzI8=; b=nZ2Mobo+iUOwzD9o
 RtTi/ZeYr4Ed0JWcLg6eChDaQBdOP5M8/wM3PU1uIpaaCHEKDi5GoQeI56u15tj1
 uRXMvc+ADiI54ntKOparOt0zDkabHJvH+peoHu9FbwBG2jien9uN3TRENtGDzf9F
 OlGc7rx5mvWePiV+xZ8N8okOHlQW+sF3ql/op5a2ZcZhkyQQ8UMnnAz/jLLGrSCM
 nTdDu9V4qClEhOvRSqDq6p38q88s6Rmy1lPFHIZuaTz5orWGO2+a+LiEm/2YKb9p
 BAeifn27CxPeLB/tJ13TtD+PTT5/+KpcXG7L2yPauppd6LwDa2vJaT3d3VjCFz2j
 Gc+/oQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gveu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:12:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8e97889ac8aso49716556d6.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783404737; x=1784009537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mNeyEihWWNPA08Vf6WEHc2HLh/eJavkzjOUbK1igzI8=;
 b=U/AofzrWRReuZ6Bi8aMQPi/t1b4xOpfiAYkpabaZzLjOOrVT8w8Mau54wVHsiV9ccw
 pKtA9k9RW7ZUH38CvwpP1Jr0mb/sUGgSVTcL1jqZ5lJGUieZTN60kNiMacqHwVJxbqwC
 ycNDLOCnkkLp0bukOEMbtX87mTS1ENR0Uyu4UHGyik+HIO+x7ykiLLOMnpiqLuuGMfHi
 2ZqVD0ZzbyRu938MI2zPqKkd8MrONy3ZRoYnii1sL5rlrAxCkaI0LwHPiJHT15dNf4GS
 kBEscyLlwbo1nVHfpUs6TZ2oWmb/bMMRCiscDs3Omm7ar8F1lRj1WXSlwDkhyw+Kd0q/
 YLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783404737; x=1784009537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNeyEihWWNPA08Vf6WEHc2HLh/eJavkzjOUbK1igzI8=;
 b=dorjt9GS+QwXjXRCQ+/n5IEVXPDakvZ+wUr9I9pXSiM7Wpr3SMyxHFbDRcmDYk8m/S
 GLhNSwGsI9e+GYh6aVfghUzWH8FdRYqPcgLtdgBxtHEB9Dnrl5daMrAD34V71P/0Lx8p
 NtpHMRobCcYAjJxwe14NzqSYFTJ5dlSff/TXISANhpV2qT5j7D+Uncdsy/p4BN6KeIcN
 b/F2E/lPveykkrsO/QIwCrG6WrZdsd4KCguVPf54NHpA19pq/1ClD7bSRehtSgRthhnh
 I46IA1AnlHX4xs/CwmGyTlwlWqjmoemvxqR6up7L4lLSTXX7eE9dxm76OK3h3pm6K5kE
 QkRA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rosr0nOJO7jC6JW9nrdkhanOinDuXKF/Ges3O53sU5pgWO4DgKdEOLOC4T54j/K225yygKS53MqiOLb@nongnu.org
X-Gm-Message-State: AOJu0YwEegJoi92zmMRzP2AVNnb1k7vvYM/49cGTxw4EMkn/9kCu9+bG
 +4Tvfz24o/KLjmee3qgwN7TzEziXwyqgJGK9zHuT7bI7+CNHCmOkWIQJJdtyMnLqpGd3KAt3Sto
 DzIekTgdGV/8kC4he3YThP2yjr9OGihbQxPM/TNHkDYmdR8SL51Xf8aWW4g==
X-Gm-Gg: AfdE7cnpHYkzBMNTmiVSb5EK0eDjtYSGz7w/xXQbI0moB3Ye03ZY7ijsIEzonaHi4F/
 qdIZiYRqAeXzOYS9tBWrRjW8tB/4zHbiIF+aZYHNMWXq2g/akHJO4Zr31S1bdJe3sJvUCFnEfOt
 mCum2mL8lOk+XqNbaoVpyevKkqjujvlywFNzGwtr9EPyw+XVgXkT7mcFMvI0IbT0bO6H6hQgHfd
 X148LS9X9iuaE7FTyqq7fIYStF38S2jqk+cDlIq0tBf2REDmCvsVTAKQM5VIe+WKe6UlhCjNf6n
 bPJuGrtmyFy03VddNcBzc5K00wDyYAKE1dL0MGhewTFbpnntUFwR9nd5lnzM4qJWSID8/nLSTn5
 nQc9Aj0kUXrThCc4oJRBtNGHqHya2/kxm7O6fCPDFLQGlKIGaejLVUn1XgpFjIQ==
X-Received: by 2002:ac8:5989:0:b0:51c:7bd:2c6f with SMTP id
 d75a77b69052e-51c7477d221mr49091571cf.8.1783404736924; 
 Mon, 06 Jul 2026 23:12:16 -0700 (PDT)
X-Received: by 2002:ac8:5989:0:b0:51c:7bd:2c6f with SMTP id
 d75a77b69052e-51c7477d221mr49091361cf.8.1783404736562; 
 Mon, 06 Jul 2026 23:12:16 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm28956777f8f.10.2026.07.06.23.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:12:15 -0700 (PDT)
Message-ID: <d888bc60-34cd-43ff-812c-59107dc5e50e@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 66/91] plugins/api.c: identify or1k pc register and
 mark it as read only
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-67-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-67-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Zf2nZrmUx0aQ-d8t1qMeQNH8iZRQQ7Uq
X-Proofpoint-ORIG-GUID: Zf2nZrmUx0aQ-d8t1qMeQNH8iZRQQ7Uq
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c98c1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX6Ucll9E6AixI
 pxMKn0vi2Uq5d3RGeEYpI47y4Poop8A3bEYjFcMJfLDatagF6Z2CYosgg7tv4p20uwpn0M1hWXJ
 GzQN+AnOFL95CeT2fzpu+Pu7pRblv9iCNWQfbV6Yf5hoohwAJNQ8rqtmZpCNjdUtTOZkwFgyAPc
 C/j5PdBYaqBDHJ7lo8A7HyAb0ciYWM6hTNVlKHDCsa8VAoRhC7C2JjUW8cgHPfuDaMnsx0A4y9a
 DrgCbsjkXSpXyhTBBOGlVbi+QDrthx0jqpQraPa/whHn3SJoimJq0dLGAUGQidMv0Vn1GPU6qvf
 5OiE0Pie1CJ0pd7AvVrkA+WnODsAgbuvl8VYqnnYBvDdypc7v3KLuKMq9jg7w1VTo2Gst7rgzxu
 TILGnKfP17MCeAWXuQS8GCQD0a/Qc1RogHI6bcFFTCwWfooj0GzTFlvqiwwUfyq8gkyJdpC0/26
 YZTUF0gs4C+40EdmA8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX/qoGbLuDe1xt
 bayfb53moQma8E2NRPxofejVNQeDu6aeLcB41h9sA0G0jRS2RHIn8jGI7jzVXqG8mNXl8NuRuJH
 gNUhp7Xf8YKe7eYaS1s/TUQIBqbpJ5E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070056
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

On 7/7/26 00:33, Pierrick Bouvier wrote:
> plugin registers.c check if at least one register is read-only, which

"checks"?

> was missing for target or1k.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   plugins/api.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

