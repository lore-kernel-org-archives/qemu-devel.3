Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FB7C61DE8
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uy7-00009k-LN; Mon, 31 Aug 2026 01:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uy2-00008o-Gg
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:54:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uy1-0002fx-1X
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:54:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52Jo41933560
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SrnuZPEgbqsNZX+EDFhpL5l9ORFgkxif3h2CBXkGLIw=; b=OAzlXkJO5a85in72
 kH6PsPpyFUa4jbLa84a/34gAqFribiDcXTGrRLZnKJUUjniSDCOkgTPKLiMIA0nN
 ncBxN0qvDpfOXTj+KdQsoAl+cEwlXrpSF8vS5gmCQm0ANcuHr67YU8ePgyIKW3hY
 UPuEJk+kmUUljskqFfk8PygnDRtaCI34L7aNY+hqhtC6NcQuUVyqbSGSQAdrQkQO
 BdYxuBIeML6bWkuXp0Hcm3oFvFegQVnwKDd64CR4baT0xZGwW9IQcxO3Mp0euDHA
 g0AYlwESMVoNT8W2NPm/0M8MA5vLtuJRYYbfs9hTPkQhQIqnxPVstuRxGaTL342j
 jvwt0A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrq84ktd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:53:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e53b8a302so416766785a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788155636; x=1788760436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SrnuZPEgbqsNZX+EDFhpL5l9ORFgkxif3h2CBXkGLIw=;
 b=VdPIRxC3Bbx+AHn/sjZhu25rACW2pCTS4P+WmF5NgWSURbKmKGR9cJmKGtq2ZPrh9b
 NN+65hF8woPS6hJbrcUykt3wWZ87Wd0z6SheXVE74+/BeTsg6z6aIsE1bOSnfZAjWBPj
 wp9MW+HLkSXYJ15V7XhckrkKCYVeI36ZrJqtTrJmcA0BAgnND0dguMSYPRDZysnonzt1
 PnjqnFufbHBR3fKnXMUSXmsI18wqre1AOQwOsrGeUL2rdMQj7bneBOez8K67y45GCVQN
 bzd8UfmUFN63TiF0I0GL6eHxMnMxUgLYWmKJQk8XzxEtqG7hPMOlOPn3xC5UmsP4wb/c
 yv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788155636; x=1788760436;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SrnuZPEgbqsNZX+EDFhpL5l9ORFgkxif3h2CBXkGLIw=;
 b=TyuaWXlUODGe5HDeTq2xYLr/CCmvszipC2BSVqS4WYr6XwaWq0t3jivZu9wZ2ti/WQ
 vGn7lg/9eVEqvyB/RnBLovzLdYXt4OezBGZeAP4WPgtSZePXmvk0qTiUxAXbc90Dm4iW
 sPs5ctKd2Ftqw/rcpgitL4W/13N8CaxIn3or/GI/+8ealSpPFOmwFxqA5DQ652Knk7Sv
 fetPc/OOSOVA7dNwdaFDSnnuArADhyRZ0+pLH/duCY/5DFo+5/XGdWe8qmup/uMxU5mm
 gjaFUyN5vsbC0vutD7k3HV8Xbf3FDFNGqNqmC48UyeSaTfPVQXBGqu7Z+7I2OZOhKj+V
 B0NQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbQ2SYJZ9zbt4nkeVEdv/uXHIlMPvh+0J2mguJyoZAUwu02WfRruUSur0NOxZlMwuI/wcGKd/dI2U5@nongnu.org
X-Gm-Message-State: AFuF++nkrGA7CHmQqY6PQRN6WyTDzu4o1cpFHHuvkD//i4UKPvnueKyu
 FxoNnZfdF2PYTjFBXnO3e/DBXG2YgrD/IwIOmhl7W/xv+0eyyJv22THov7SSUf57zYSQUCFenWr
 Ts/1JCRebkL2Mf88jk+2Q/LVu0a/YHwzjmQQabML37FUv0TOB2+EKVpi1qA==
X-Gm-Gg: AR+sD13X4h8P/8EWtutdLAj0/JdbQyawv4O3ziLwh0NGjXjjCAlbpjUpkciwFan4RDX
 afkOXVKwC+0Nbs9RI903GcTcuKBvA9GsJUVSxPF1QKdeHl8cbmN6gKn70aBd3TpNMDWmlrf14rQ
 3YKOyy5RfAqpJUn0v3Aq5ao9RWU8rM1q5RW2WvI2P39wEmx09+ACPt3XV6gD6q6I1vL6bAL12DI
 ErBaRi6DkMYjawyi6ooNo7mLnmZpHYeFbzHpEGT6wd1Gx3OSv16uU3y184MDJj4EOzqf7iUAIG5
 ny+LZQ6/Z1He5yqCYYjcjsDrJyhUPon1Y7fBzooIRJp/cfoyoUhRY6W+XJVmNA96/826MM8ApsX
 rmBz6YJZxYddbaqv+N8yQQlAvGEt3cLiGVg==
X-Received: by 2002:a05:620a:294e:b0:931:18e:8642 with SMTP id
 af79cd13be357-9391374c511mr2579109285a.2.1788155636262; 
 Sun, 30 Aug 2026 22:53:56 -0700 (PDT)
X-Received: by 2002:a05:620a:294e:b0:931:18e:8642 with SMTP id
 af79cd13be357-9391374c511mr2579105785a.2.1788155635771; 
 Sun, 30 Aug 2026 22:53:55 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b468009f8sm353514685e9.0.2026.08.30.22.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:53:55 -0700 (PDT)
Message-ID: <aba45d1c-c96d-4b6e-acc8-5bdb7123c940@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 07:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] hw/arm/aspeed_ast2600: Wire up the ACRY model
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831024450.27178-1-jamin_lin@aspeedtech.com>
 <20260831024450.27178-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831024450.27178-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VuhwtAIbAaJ5mZzdQr58ZyXXFgn71_Ys
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0OCBTYWx0ZWRfX7PysN35skyBo
 wDHLd90kYxk4EUk9k9LoG4uc4XYArBN4JSSvFCMvZXp+EuZhSJzwADOF50urw80EbNAXtZY9GCD
 LVYUdNTdKp1aE9Yaq9P0HzVyS5iYYdo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0OCBTYWx0ZWRfXzUDHwIh/0lxE
 c09PMAoKAPy9EMMTUSwFTU+BvIbwoQUkegKn2PpAyLVk2bjmhz6EtM424005o4nQt9z3U8foQ1r
 448XgDaNCnr3psl5O57lGuzBSS3ez9eOCH/e2oZGaAnEOAufjgJDVdP5ZIfluypJ1ZKb6tMWuWy
 8kODnr0b0o188/kW3H143z9r4Lq8MvPaMQ3vOS+eCQ/OiJc2b4VEb5Qt5M19f8eirqBmZhq25t6
 rFy4rbkeYUGks/F95QQ7wlNjJrJdoZdjbOTvnu5OZGy+IqZdRCk9vWGMlVXSepr4xK8pOoC6egu
 6v9Pjrh3w5r+/7IOP/ENzFSUtrWW8QuZ3WWFqumdw/Nfhf2W8R2VkPsyh7/BNz2zPALCs6QqSlw
 zjWyZCkmidmc03OtTLBkB4DaKytrDKB55QlGES49TiM+50LtEwjeJL3s1xi10jAdxupywPKhfH/
 m1sk/jxwzSUbx/gk7nw==
X-Authority-Analysis: v=2.4 cv=ZOPnX37b c=1 sm=1 tr=0 ts=6a9516f5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=V2NxCb60AAAA:8 a=aow-egSQAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=3L6qF29SlnrayQqPM2jZ:22 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: VuhwtAIbAaJ5mZzdQr58ZyXXFgn71_Ys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310048
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

On 31/8/26 04:44, Jamin Lin wrote:
> Introduce the ASPEED_DEV_ACRY enum slot and add the ACRY model state
> to AspeedSoCState.
> 
> Instantiate the new ACRY model on the AST2600 SoC using its
> real-silicon register address and IRQ:
> 
> - ACRY register region 0x1e6fa000-0x1e6fafff
> - IRQ 160
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/arm/aspeed_soc.h |  3 +++
>   hw/arm/aspeed_ast2600.c     | 17 +++++++++++++++++
>   2 files changed, 20 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

