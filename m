Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFA9CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqZG-0000PR-JS; Wed, 30 Sep 2026 05:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBqZF-0000Oz-9U
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:25:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBqZC-0005qq-Ev
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:25:37 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dOO42213381
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2BOfTAd4q5e6H0a4+/4/iilDKw/22GXKuSgcWmPE7dw=; b=aJ2nLpRSsXtmAGxq
 MJNvVYjFHIBXvI3rr+XE5w83L4z4B2FGf/M2kxvDbp90agV98a8z6kJGE2K/HF2N
 gqhvtJ5kpLdLkSV0bNkPr4JUIUllgRma3EkAy+e7sY+IDtH1w++cTdRjPdq+Pg98
 sNBggPMh80oue6fNKGr4rykqNFVig0BGOl6Y8ahuObEmZt970dOLpPnZVVcCVZQo
 TelU7KidI7aXEM21fRxNVKLcKKqJsDUuwiBEXkIwzWH7wa0Bywvkoqo50udN8+5T
 JUvqKN4/54x4EoYmeMwrf2gdeMKkgOr3QlGUrZopVWILfxk93dIqwSBrT1+pAgZQ
 gie1Tw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjhpur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:25:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939c30aa9a0so538549985a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790760332; x=1791365132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2BOfTAd4q5e6H0a4+/4/iilDKw/22GXKuSgcWmPE7dw=;
 b=Vy1Uc4RpBIz8I13dwDULVRUYHOytPfKTjuXNoMoeV6EnMFu1dLzPAi6WRglvQag8Tp
 mvoM7i63Hzb6liau17yQfSMkJm4AJipuCVxu7bIlpCdRpJucCsTJ5eQMEbDL91vxGv8c
 EC6I4vy2tkdd7MuSY0/AJ/uu3uMnD57d5gGECxsFIHP86LMq2Jzhy184pHrpjsczVxbR
 k8ZO3QrnOjiuK8MewpiPJQiijDWyxro6+Fo7WtEYRedfXXp+SRy8iRKtrfO4MsNPcjjJ
 MG79GzWAH3Qbk0JqQVXxi7ez4RIIDfAo5oREdSZj03SYlNjwkdnh+tCePbY6RJrgAhU2
 fkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790760332; x=1791365132;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2BOfTAd4q5e6H0a4+/4/iilDKw/22GXKuSgcWmPE7dw=;
 b=15aBWC00aK4q1muYY14ruEwqUJ/s9xLhyo5rIOk0eHX+YKOK0ADTp80LYNVhOMV5+7
 aNMFS+afGYgDYF1c1HkuEUoXOfhxthvUddNJoE+PQlKUVi/W58GqSysIo3r8/8ImUj5S
 VCW5YbFxk2FKjvn+V8K1vMfipktNXLm78Mp7lVEcJ8rcO3bLAydLzSsQqQjm5iGJXUey
 fjclJ2vQGYa1pp2h1AWpM5fa40pKGC0euOUmlx0c1PMAcyfGBq3H+Oc85s/JFMg0asoh
 LjVrh8KAZGp9MWb4RS7LYSR9UXYA9WTUbRafecVEuiU1ZjbrH4KEQNb/FGLGAQONsU7h
 cl8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxXtAPVWypVsvSzJ6pnkaBa2K+3JKuMXLYSgdWPNfLrYD7gQN7/kmA2/B/VWeeWX/MplZ9UbGOfFix@nongnu.org
X-Gm-Message-State: AFuF++kNseaIqq4uE7fBz2MiwfC3U4xa4TfI0/fFxfxn3STkc/otVryO
 dI4b1P3OSE+jPHKM2MxypAmOr5xEyPbplzt494Zk7bxe4PcJimi7NwE3jSMJez/UvPXIY9lDZEv
 FB8KBDvhUhOaZKlkqvZ3q+mZbewWxqrtZJBU7MKKvK9GeMKN+wBDo2A32hQ==
X-Gm-Gg: AYBFou34CC6uLlIEAEPIsuFQ0uwfdh+F1JtpMFNYx1WtPA/t0P1Xp2yYR60/w9IVd+D
 FDIZKNr/Xgt16rhEpRMXJCKQjGCedkSzGsCNFO1zVLVHFoBOx7xwK9zJ9U4ZtfiX9mpn9vrifrS
 JxOOI8sq/nJvuq7PJ1wkvcE81o079y/OhA09hMvXjLxcf9gxZMS37BlW6GdjZWPWvcl5h35s0y3
 i41/AoWk1XaRY5WgPU9RXsXNhB0ZpXZQ6QgJreSQd3ZBHPTK44/6Pf75YKTUqoN/DPIfy2X8Xir
 d/FBZPXpxR5q4CA+byCjp+Lea+jT5IMI2VQslCwTUn3vCr+m75CefE7OyqKJmG30ohoWsSHcwhV
 ne8vjXh0pUF/Y1xghtYkpbggmR2WpyX0YtA==
X-Received: by 2002:a05:620a:838b:b0:93c:812a:4c93 with SMTP id
 af79cd13be357-93ca96932f5mr120315785a.16.1790760331419; 
 Wed, 30 Sep 2026 02:25:31 -0700 (PDT)
X-Received: by 2002:a05:620a:838b:b0:93c:812a:4c93 with SMTP id
 af79cd13be357-93ca96932f5mr120311485a.16.1790760330737; 
 Wed, 30 Sep 2026 02:25:30 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017bad33fsm29323705e9.4.2026.09.30.02.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 02:25:29 -0700 (PDT)
Message-ID: <c7d79a6d-d9a9-4be1-8626-fc6bf23b8a87@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/24] hw/sd: sd: Keep high-capacity memory blocks at
 512 bytes
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-10-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260904155758.3833179-10-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzNyBTYWx0ZWRfXwQRMJSZFPlc0
 +GYh495P8GekcibqNEYqmBOluGWj/U3osZyzEwqTJVORXgaptBTRtjoCYt0dXQ3Q9P4fQKNHbjM
 JAyjvCtUtqcvnrJwLuJ/rrzme0hQS6Y=
X-Proofpoint-GUID: 7tuJg54u2EQ5-O0rauUr8S47LOiqBYC9
X-Proofpoint-ORIG-GUID: 7tuJg54u2EQ5-O0rauUr8S47LOiqBYC9
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abcd58c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=69wJf7TsAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=SJiaYZIQ9BwG5GmUfnYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzNyBTYWx0ZWRfXws4wU3uJKN8R
 AsYZTUh6E7ylRNECUd2gaKsY7ZLu+Axzn/VEqOKTXvS/aeYAr6yRK26CjfMg3VCWjBfZgVOOJLN
 da36bOzMtc2ARhjyn1E5XQehvtehsQimDMI8grp0cjbcBeHoKuIRLpPjrs+wFGFds5QwD6k0ut/
 kH/GwSuTWjSDnLaMcZtFa2MDZHAoxUna5i4GUD40CQQvf/ZjC/cEItJ9Jg0ZyzR14RUWoxmsXix
 MVlQN1zs9MGWk+joRIDj3NbbZizs7fXCEr6PXVXG3SC3xaKgQfOx4kgBNg3Cycnl0NlCAWtplw1
 ki1h57JGLvl/PVi0p3LiiZ97+hrHmPdg+lduCw730yveSSsQdts77yqND5qfc8+3WMyR9FwX2sN
 DLdkYgrWevx9dUhdwgagzlFfuNu99tfyHecwm48HxNHM8dVUyxqIYkqWAz5Vp7R8bKAYFWP8Th/
 EikPFemGtZyt/FBt5LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/9/26 17:57, Bin Meng wrote:
> SDHC and SDXC memory commands always transfer 512-byte blocks regardless
> of the length selected by CMD16. QEMU stores that selected length for
> LOCK_UNLOCK but also used it directly for several memory command paths.
> 
> Route single- and multi-block memory sizing through the existing helper
> that distinguishes high-capacity cards from SDSC.
> 
> This lets PolarFire SoC HSS validate the complete GPT header and locate
> its boot partition instead of receiving only the eight-byte signature.
> 
> Fixes: 2d7adea4fe57 ("hw/sd: Support SDHC size cards")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
> (no changes since v1)
> 
>   hw/sd/sd.c | 43 +++++++++++++++++++++++++------------------
>   1 file changed, 25 insertions(+), 18 deletions(-)

Wow, old one.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

