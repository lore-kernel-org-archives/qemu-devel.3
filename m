Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB451C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljK3-0006cM-8g; Mon, 20 Jul 2026 04:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljJe-0006Zk-VK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:25:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljJc-0001dq-BS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:25:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RoDH1263202
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UQTmmlk3Ftp56dW3WFZ8bcsagWfeiqwA7V2wJpSIxpU=; b=RZ7afEKWl5wCeByS
 G16daZdK1FAAMw2q64I/IcE4dU5G4voWbrqNf1NTVAI2UGPcrfwYHgqv26yVTvcG
 GcJ3Rl90J2IpFbqRKPhzaUtqvhFhF4/gpHHhTEyGDrVyzT7z9DIAKOOLL5Q5CUtp
 Uoc1E71OzHGFiQV6OH5r/CyQDpwYt2yt6wjgdSt1KF/I2DG7MtYcRg0nwtaGiG6d
 8WMTmfXceCSdXP4W3u9VkyLWK56CukFGbIL4MJ1mSeRlOwhIckOd6zJC22H8Ur32
 aXFS53p7NL21QAqvKHRAEhUte9UVyyCnUz4ihZYeAKeJykO8A/uxlD35srWaxdgc
 13KQHg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhn5jw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:25:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-904ee4473a8so159543106d6.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784535925; x=1785140725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UQTmmlk3Ftp56dW3WFZ8bcsagWfeiqwA7V2wJpSIxpU=;
 b=Kd3AqQpT7+RZaiqSUhc1wZT66gdLZhOPngyUnNFOfHSLBIxEuRjiLrwPmapaj2H54P
 FSP9kl0A4G79dmOF34UxE3OC2P0+6C9RBgBi8RTAJTVad91tRm3UwFCTkHMnhjPlGrrW
 rzxD7dPTN4+O6MDsxTGkG1s71l1elVj+MH33Ad6LkzS/bfQ/xynt65NF3LiXjXuIvyGA
 jfOhvuZmMdLUIKFBcapXwKyg4JPTRf4GMgY1GEpGgFr7zcMwbfLLPGn27b4iB6PRQu8i
 d5TMGet8lf79IIDLiR90EcE/p4iHHtkM2b8ijQMsvZx27fNCB9fzsShiewJtOxJSsi5x
 ywUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535925; x=1785140725;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UQTmmlk3Ftp56dW3WFZ8bcsagWfeiqwA7V2wJpSIxpU=;
 b=jFNOM5E4iC8LFs6ipGLgv0qbttxcRSEp+gMPc8Mn/UU88lr/BKFr9Ehoi0Qg3vpB0A
 /eVz8ZQiH3o24pnCbi64U3Z6MYCzU6S6sJvBZu5YupxMCERcpIYnnIOcTrDt7NGpC5hZ
 8LiFIoXWDIj035WaTOQfqtwXjQpbN436O0tCWuZYVD0/zOHJUm7dKJ+LJtQkpEi6T1M2
 hI+DVGsoJkujc8bRBapJxEQpR2xom+dNnfv84X6/p6gnScrdRsDeAuPSu+Xkks8xgx51
 PAzfdOB5MH8qHZrRRl+fwOlg57Bg2KRn3GPXK6YMEvvmCAy7oQf+Maoyl7WCRuTHmz7E
 hdMg==
X-Gm-Message-State: AOJu0Yw0HsfgHRwAhwpitdabdoKtnEUvxgMNFTsEKMQ6mTToJPkQF4nx
 mGAz41SG8eNO4AdvDt6AF5QJiRtJ8IbZNBerLNZCWehXtGzaxRU87W4Gdc4Xoq422BqS/YdZvsn
 zJT+cM24y03vl+yAmxIqEd65mH7vmOctQiCobIz9abG77EoDkSwXrL2K3mA==
X-Gm-Gg: AfdE7cmlM4OvQafbZCoHnjZ5yX1zRrhl9PGzjap/u76Ybq5xlfdhDHEtvZQIHu2dsDd
 WquwcNIw3Q+uFe7iRVNLecHnM6BnvZMm1xsIBb0VHcQHlrnyc75AsoF3hj/pU4Hh7uWhg+PM/RS
 DQXQN/wN2XhBetC0Hwl3bOo4LX7c3xOL9bQXDDN+ENtxpgampoyq8LCNAHSnGqKUmCyIc6bVZgH
 yvN2dBqTTMTEGZmCBDYp9IDEodk4fM9ulG+2B3DLX63Xr2z6tOE0ZIl7EhAEjaOzIsHdojGTW+w
 rUi7D447Cg/aaFBxTEck+JQVD6OeMmArw9BlTRmzwxyBSkVYhs09wXnC9BmPE2pBkY77t0+YFDU
 FYPfcxebg3x0NOcOKqNfy5szMbqftWbKl/I9VMNKkQEBuaewCL1I=
X-Received: by 2002:ac8:5ac1:0:b0:51b:fc54:c23c with SMTP id
 d75a77b69052e-5213e67a3c3mr119006681cf.61.1784535925483; 
 Mon, 20 Jul 2026 01:25:25 -0700 (PDT)
X-Received: by 2002:ac8:5ac1:0:b0:51b:fc54:c23c with SMTP id
 d75a77b69052e-5213e67a3c3mr119006431cf.61.1784535925104; 
 Mon, 20 Jul 2026 01:25:25 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52aa4sm28555684f8f.10.2026.07.20.01.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:25:24 -0700 (PDT)
Message-ID: <45c9ab4c-3f47-44a0-8f48-bad329c9c1cd@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv/virt: Add optional UART1
Content-Language: en-US
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 pierrick.bouvier@oss.qualcomm.com, sunilvl@ventanamicro.com,
 palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5ddb76 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=dZbOZ2KzAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: nKhG0DVK-YX4g0_xBcfxQyCPcOZrYiB4
X-Proofpoint-ORIG-GUID: nKhG0DVK-YX4g0_xBcfxQyCPcOZrYiB4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfX+/SsLvjLedSk
 riE5QiJ4nBoTDoNBeNyDgOLkTKeorLXy2vgJnY/EXTiExwGHiJQ8WPhbobud/qjStrVyAqY0i/V
 b4RApxOPpcw4tl/z4nM+Vf6qCAuhAmqNfQBskqCn7+ijjHak53U4s1b9eA81oVm0sRwTav7VHp3
 8Kkvx6eyU7MNl4JUQuVYx+YVjZTP9JbDqZ9lSFrOex3znDDxyZPTauIstyC21tugHJdMpjUyNCz
 po6g5vtjs2CqG0wBiUpiJmnnGScIloSUVR3niOk4jPwLyXLLqFlddPabIMN3KzzU06riR80KdcO
 p3RJoVhI9q6VSegDStDMRDJfvL2HpBVPSoAX9hXhIlkaT8tt3RM7nIVeGLo7IKQ5frpNtOsvANu
 M2IaFEoA14+ovY5sMdPMI0KkqPmZjA/LLiz2EfYxLISWaNpYhU/5f+01eDxJAQGl0cOSqeJeNL3
 UIUCqNQvD9UGp5Q20fQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MiBTYWx0ZWRfX1CqWEUtuxuhJ
 AMu0IKK5MsxkBeD3HIPjdZJLxHpdTppqjC6YgaQibr3FxKKvsHuVkRcCKhgXDzFm7qX4GZdkbWT
 szG83BBybGj16ElVKO7L7PGqmWRvrMw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200092
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

On 18/7/26 04:16, Yanfeng Liu wrote:
> This adds optional UART1 to RiscV virt board if required at
> runtime to simplify multicore development.
> 
> Note that UART0 remains default serial_hd(0) and it is:
> 
> - the lowest address UART
> - first serial in DTB
> - behind /aliases/serial0 in DTB
> - the /chosen/stdout-path in DTB
> 
> Note that UART1 is placed at different page from UART0 to
> support page level isolation.
> 
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---
>   docs/system/riscv/virt.rst |  5 ++++-
>   hw/riscv/virt-acpi-build.c | 12 ++++++++----
>   hw/riscv/virt.c            | 40 ++++++++++++++++++++++++++++----------
>   include/hw/riscv/virt.h    |  3 +++
>   4 files changed, 45 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

