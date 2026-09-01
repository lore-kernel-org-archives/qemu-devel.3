Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D1DC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KYs-0007OY-51; Tue, 01 Sep 2026 05:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1KYq-0007Nl-Sn
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:13:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1KYp-0001BQ-7U
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:13:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179IPF2562024
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gBU2xBa8CPeIcSRnpH2NmC34mO6PF13HB6FxUGnnViw=; b=WkYjyYYyJBBzwhVu
 LO5LeQ0EnUSx2OV+zFo/6fkoLY19uzou/GwGN3rT6vRGMxWjY9HsJSR8Lpo2tEr+
 4/EyhxWNUHXJY6YZSorz0JDgYt9hZHPlCQbizq7zdVwJgS27U7+r8bnt0gCg1GPH
 CFgS5R4CjCLAxT/TqWpKXCW0TeyEJxmazbAmIaXK3C8rM4v4xp0iiwvbMxp37d3R
 2YFpE7Sc7euZk2i9j2mpagYXsC+p6plyEHhsm9YdMwv7KeffnBWw5P3Hwmv1ZECJ
 k1nvsLaEbknuQEZL0rmolY73h0pxZbnszpL+a8vvZLvJx0mDS83X3KpLKjs8Em4I
 q+O3yw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdeg3bjmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:13:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494cce712so812329185a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788254020; x=1788858820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gBU2xBa8CPeIcSRnpH2NmC34mO6PF13HB6FxUGnnViw=;
 b=LWbVSkDPaskq1V9zqpRH0vgSZLru7/Zyt4VfwPtzQVIcX6obtOpetrfk11ywnvxYlS
 q03sZm0MQPw+p8KX6+SNkvyLR/kp4x7e7YKjRzjXQQeVCU+g7cOgvqR14Y2VrpsHPHvA
 HBxzWuBqHKfZTLhs6fbdknaI5dUyrwyO++5OrB25WsDjGWf33wkMsgfKVDsVB5Uy1H60
 rCgkBhQ6Q3fso5NMX0sUCzAOHAt97wcJJkAYM/Xe1B3PJ4E+nV1OTt4JDys+9Urp8/w+
 cbzbADBJz5CyL3A3XxmhBMnnhkWp1yWniM0gHBIl33Vgo//QtCP+wK6+PjV0u1Jzr0er
 BJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788254020; x=1788858820;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gBU2xBa8CPeIcSRnpH2NmC34mO6PF13HB6FxUGnnViw=;
 b=oA6KxvsWTE0EemTGhV0pkRyfyTk1cjOTc0ilYLp7gi321beow6cfKjA4rvJxKCJjSj
 NkWv+dXx+7/XNQ/W42Qm7VCV7QQ3PHioNP5TrPH85ay8pXj1Ue8FsZg5IMWfCx/39yg0
 P1NbYjtc7Cpoo9UkDkEwhUAYPOzDz0q7A0cc/qBCB486rZWgootbYt85K8FAb7Mv1bvF
 qGn6uffYIZFwLbzqkOUsykudHr7ChEDThUkFZNtf9SB9erc20rTGfgynwhW1Mftcq9kg
 gLEeV/qaV2FZk1GWMPA2HLXa8BU6A1ky00+iGDYwAHRbaYtnuj26Xg/9A8k7aT1XdXeY
 VjQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzmNp8yohMCSQDYa9/jYMzQQ78sUofEDFC5M5xjuxXch801M5yOSQUFhE+rQ8xsmfb6mY7Z7dkB7gu@nongnu.org
X-Gm-Message-State: AFuF++m8CE99gFSBvacbzv5nqVKquDyxKUF72lzw+OnS4KeUhyKZ9f5H
 D51nl8wJAwbrKWLg/nbwTKbikbHNzw9SxuWDzXXzO3uBjjyUMIb7ArvaM9CwQuSaDPA9ureYyaI
 zSHmGW9EqfDOStyX4FC41SMVU6HbwXtkpdcvbjQ0HZqyjk8xyQL9fOoZlIw==
X-Gm-Gg: AR+sD12KhV6dt+Euh/hL1+kI6vdz0OeX0Dw2GzmL8vQZ5UGNgzRcsFaFq7StSjNOQeA
 mEmNhCzOz6y/nJgHaey1t5kdgGj0TvhdlDlGIUiDp0UvLh4xPnF8+Hb5EiUxcYFnVzA8IkP0CxN
 stE62FlTW1VIkJtSMG15WQtcztQwUlPQIdQI+ka4rDFvnCkipjA5fCVoZttvDqAfNVFqwD2DksO
 wC382Dls2SjexsycSCeyfaqJXpi+bYaqmRMjnwJclkPoZyV2XFbTFLzapJAnT1NPHjzkUayXA8V
 OZlMx6kVIEEMYX3yqkc864b3gsH+aJXNJcKeBUUEonobI/3436CHdP2DES0L+AZ+V9fYMbRBe/z
 yM0n3mRO5IeaPAARPrjbAJm8dXfl9Muaz3Q==
X-Received: by 2002:a05:620a:28c6:b0:936:a407:98bb with SMTP id
 af79cd13be357-93947f3f98bmr817667185a.9.1788254020023; 
 Tue, 01 Sep 2026 02:13:40 -0700 (PDT)
X-Received: by 2002:a05:620a:28c6:b0:936:a407:98bb with SMTP id
 af79cd13be357-93947f3f98bmr817662885a.9.1788254019572; 
 Tue, 01 Sep 2026 02:13:39 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdcdd5f5esm50947095e9.0.2026.09.01.02.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 02:13:38 -0700 (PDT)
Message-ID: <731127ed-da70-4ded-9600-3238300c2b39@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 11:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] hw/i386/pc_sysfw.c: convert pflash0 and pflash1
 object props to class props
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, mtosatti@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
 <20260828150313.1883999-8-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828150313.1883999-8-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfX8b6EteQEqvhN
 obtNwqCpXOSd74BwtVgpMB//yGA/7H552UG9wBavmMYKkoC9u0Lc7Y5EJYwtw5DW2mXyq/BiLHJ
 srOX7G0NEvQd3B+tCJGuV6nNrZdjy/1ad+zUPFcSUh2dr8Y2omm9AWWfRR7ePCiX/U9ICzxYK6p
 04SiortnB83Q+d1fcnTPrKeM9Hf9MsxctnW/6pik6hWHhuDiA9+MPx4JSHxAS4DXBkoma14yFhz
 T0zg0/y1zutbnrU6ctyjJrA5xiNkEbgHLrx5XZsEYOLfqKutXH9xPHz8v4jHSz4SfVEM4qp6ul4
 MkvbguvIeLh5pqMeQ+ImoPr3ZcrxhZlsl2T6eRZ9PRrjkKEW4vNFl3t+JTlSQQiMe4PEJHLzJAs
 2LDtSpbefNrU+kuovV+nN9s9u/6RThdyjHUhghPic9m8VYlKqgCnHkCNmvI75KNFGybqDPyZQt9
 z9dJB34wxcmmMHy8gbw==
X-Proofpoint-GUID: 1a8aGDobFFlgQ3TLgGO_n5uncqnAWyz3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfX9ZSXUf3T1yh9
 bkkHzB7bqVPjpt5EvHndd0+G0SkZSrRC4io42TR9FVI7WFNMRhzAojGiz2RB4/zjLpNi7XHUI4n
 r+eAA+NKHrW8mrlyc/bVxyRSsQNYh24=
X-Authority-Analysis: v=2.4 cv=NZnWEWD4 c=1 sm=1 tr=0 ts=6a969745 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 1a8aGDobFFlgQ3TLgGO_n5uncqnAWyz3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010081
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

On 28/8/26 17:02, Mark Cave-Ayland wrote:
> Now that the pflash0 and pflash1 machine properties are class properties, if
> they are unspecified then QOM returns an empty string as opposed to returning
> a property not found error.
> 
> Before this patch:
> 
> $ ./build/qemu-system-x86_64 -M q35 -monitor stdio
> QEMU 11.1.50 monitor - type 'help' for more information
> (qemu) qom-get /machine pflash0
> Error: Property 'pc-q35-11.1-machine.pflash0' not found
> 
> After this patch:
> 
> $ ./build/qemu-system-x86_64 -M q35 -monitor stdio
> QEMU 11.1.50 monitor - type 'help' for more information
> (qemu) qom-get /machine pflash0
> ""
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   include/hw/i386/pc.h | 2 ++
>   hw/i386/pc.c         | 8 ++++++++
>   hw/i386/pc_sysfw.c   | 7 +------
>   3 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

