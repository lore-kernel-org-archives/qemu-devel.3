Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F40CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWw5-0007Qt-QR; Tue, 29 Sep 2026 08:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWvs-0007Ot-Ia
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:27:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWvq-0004LJ-SN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:27:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCEVUh525699
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J+1tWNwKEUBh+hsPODxLkob7SYTYWkKv+8Iw8LfCRmc=; b=eGpv3xdlanN0hXIg
 abNolpKE4ppil3MSDkcUM+iRce/IS5FP/xa4ha4+/w+qvoMmbzM/jyj9w2QhrrHM
 ioKu/iu/bwfA1ePH3wj7EclPSpY1yqfDO49bKeuB8cy/WB/k8/r2J9lZnDCbF4on
 wS4GOi0SIaICxG/E4e7RcqOzlkCmpWIaifLJ9KIxQOwMGmPSjb11z1XF4viDjjRD
 trvz9WFr3vw/sDvG37dY2GACnOHL8oVPrqjGjNH3exnnxKkequss5pKHyaccGqkb
 7D4Sj+WqMOfrkZKPXwjW/gnN/j/W+k+Q58RJzg9O/ceM5oRm4igi2PxC8nLMBH0w
 mv1TRQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4u066-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:27:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936708f129aso841380885a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684856; x=1791289656; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J+1tWNwKEUBh+hsPODxLkob7SYTYWkKv+8Iw8LfCRmc=;
 b=R4LEPBtE2zq46crjEbQL2MjzD3GxwlqNcb/Jp44UPzKVqmw69H6SA2vzLp4OGJoJ+m
 0aycN8itaWily3YaKeR1PegzXxDT81nf4bXm043f81oHXg2bGo4GSCLd1UIEgqt1SoBk
 5G1LiEZHkak80rEbXR7M7gzfUKzaB44yKejy/rmCL0fZmTP0PfH+Hm8dCUUGx6Ggrkvv
 0Fm3zhIgTFHCeADZIRp630ncKOtAkNIow9U19W2JZu7CmgWKAtKbMnSF/1+nQ4CaW6UE
 Btc6C8JZ1FmFjduwlOWMvbb3lALIdOdlFQcEp7HZEV8EZVbuC+ZxbPUrepYlMhQH65gT
 fDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684856; x=1791289656;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J+1tWNwKEUBh+hsPODxLkob7SYTYWkKv+8Iw8LfCRmc=;
 b=kLRirIZwhTFiZ5NnK++mKxCebb942MFr7kFXWskwgGFkxoF1XUHYFk615KePRS2q4I
 uneSQEXOxLlRWpMCatfX5i/AE1x4hL/9y2foWDluXhydVYWsU7SIc9gKpb7gTdo3INXW
 sFwCXP2PnYOvf7HOQ6pOsWBLUdJxtVFXOYvGwY3y5EdeH5souRqDhLSZHBqF0eHUaNS6
 cN3s+TxX/B9/7b7XVYOMWDTLUINKf5GaQxKMCZLfFWr781IUjFc6lE73CTMKXoCmGiCL
 V6GxdpwDWNj680m4Hvf1qBYY6Q2OuWD7z2w7SEXCkj7QfBkY2v/GydOf474Pcr4BoJHY
 zeeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVqmQqK9UQXtMerk963IH81WvjaW2zlZePQhlsCBh5mOdPSA/S2IMqXKAo57yse+1A9EytuYnKSTzO@nongnu.org
X-Gm-Message-State: AFuF++l0bFPyz+wocouba51chZIbA+VYdGudn+2NQuZk/Hw59hx+EqWZ
 a3/ceqDg3lu2sC+hxVsZewZO2iMj4KjzB09rDg0DWJaubAgQQu8aEvEot269OFTHOTgUQ6MrUQM
 bZ/EdZlXK2LZe1kBZ934e6iQmwdcrZIwIIJ0/UoRVwMJvo2f+BTcbkkmu1A==
X-Gm-Gg: AYBFou2tdr2hMw3VLj4v4P6uKrF0nVKHVf8W90YbNVTZKyL1OVVENTqQ4jfXoRLehaq
 ycauALN7V5V2fDUGZyit2QuiE2pquA9/bNGo6mlImgrlDcR3P4+0BULp7knCybkwVfqw7K5ecer
 LzfSF3XupgJQ5RJGtx3rrjXxXG4+oD2c5502/QRDpDl8N5oEBUiUONU9rHH+GEFfcIW9Pchzd6W
 draiq3q7APqQxSzr12TXJTF2OMuj47GOv1Xw9BRDHJyo9EVTSGfkFK22fi/6VL5Oe5QyXxAzxJM
 lWBKC2nojli2D55Tdnwu/tY1nB0jYEISD/J3Qq+dRlhMpAM7wzupuUoYMCyL6Y+sTIkI5ppdqa/
 +2/NHWRBSP3YDSJNcNCrp5IlwZRGvQX5+EA==
X-Received: by 2002:a05:620a:26a5:b0:939:ff85:8067 with SMTP id
 af79cd13be357-93c43d7bbf9mr2748579985a.30.1790684855980; 
 Tue, 29 Sep 2026 05:27:35 -0700 (PDT)
X-Received: by 2002:a05:620a:26a5:b0:939:ff85:8067 with SMTP id
 af79cd13be357-93c43d7bbf9mr2748575585a.30.1790684855524; 
 Tue, 29 Sep 2026 05:27:35 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf9b72fsm102641445e9.9.2026.09.29.05.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:27:34 -0700 (PDT)
Message-ID: <1f1dc65f-df09-455c-996e-017859db39c2@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/42] hw/net/imx_fec: Trace with QOM path where easily
 possible
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-41-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-41-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX5bgmZajjmgvS
 pcQOia+bH3IbIUeBN1rsrdxtgRgS5kdLBrvnm9VO9JNRYMBcI6PvsSGhAhn9ujQpg/hmG4qZcYj
 FAmu/P1vEca6Og16//IEbJZNWOyWeHQ=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abbaeb9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8pFOxt1SePsmpDuzWZwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX1JPu/ptIz30s
 Wq6BbVOMyS08IP6LRP2RJgnvAZnfce8rRfu7Sx+tmUxlHB3wsuCaKjQcUtu0O1Xp1+dnc60DAmx
 Ltc6YQdGWfOdUI3yI4G40+IXIGYqcttd5onAxY3ooiGAHmdaNULeV9L7viDjf6RP4GBiaTasQY/
 Jb64Enb5zXj29p3gIyenSGiN0C51fbG54I9x0GVog4laINFIUr2q6C4sZ1f6eF8pQH/JBbiNWUa
 OqspD8VvNEXKw2k9JQRjL0kJrVbIgtvplV/cZ7lma2y/DSzuuwm/48k12pTEH3Oa6EqmmlAfF7Z
 k+B9nmSywgkg3fPjrvMppmmS5zSLkWkCA8H+WN2/f8S55nwVeNOyKW5D75n3j68AiDHj4wu14Tg
 3m/nwNZ8hszSzENEASwVve5ID/HAzQr32D+IpNELDfJh80K74kNtsCV0d+Z4A2mMoKuog1q/js5
 CJkWYxhT9UhJqGSbeDA==
X-Proofpoint-GUID: Zu2RY2_eBqQTQUo96fPPZJFLObKHbmcW
X-Proofpoint-ORIG-GUID: Zu2RY2_eBqQTQUo96fPPZJFLObKHbmcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290049
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

On 21/9/26 23:47, Bernhard Beschow wrote:
> Some i.MX SoCs have multiple i.MX network IP blocks. Allow to
> distinguish them via their QOM path when tracing.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/net/imx_fec.c    | 28 +++++++++++++++-------------
>   hw/net/trace-events | 24 ++++++++++++------------
>   2 files changed, 27 insertions(+), 25 deletions(-)

40-42:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

