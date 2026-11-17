Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UeEKtIp4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ff4E3PO4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOHN-0001hF-5D; Tue, 17 Nov 2026 13:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOHA-0001gC-Da
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:51:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOH8-0000wG-GJ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:51:27 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQMBI1141618
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SBt+kh+JtHZ0qpw5kOtHP6llWuCLlxFQTaqhJNluUBs=; b=UeEKtIp4nk6ZFdMp
 ErPwLddroF2HPeDHPwHo8Bfstb4G5SDksA5qktmspJIRH2oMkTM7A/aR51oahOGS
 2eE5hJl2t2IuWz4ijTR7xQq2uLEYYX+ctLFTl2PeUtXv0JAcU7VTblyT7GXV2vwD
 vTt50BjEquwmndG+9nzJyuEDmKl7sMYbfVZFk5vGQ0z8R+Wzm4xwDAmp9DJbTUqe
 4sMtu4beqC/J2fd5RU/hZ/VXsVTx1RBInaz1Y38KEELDjdL0794P7ov4maxhT30o
 sxHPQnOixtVmPiLDcFimhRm5e/vEs9ziANFlxih6RM94HfhriGgcxc0/0wwkECxt
 OwCrJg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0s9t10qd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:51:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-92111028a03so518056d6.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941484; x=1795546284; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SBt+kh+JtHZ0qpw5kOtHP6llWuCLlxFQTaqhJNluUBs=;
 b=Ff4E3PO4Db1RdRhNb4Q5gQYufcjM2Yxc1PImYAvrd7Y7a0r9yGoAYHK3TA5rqKOeu9
 ADdvgMsy73Ukev6Qc6jEJ88sw++trYQUInqPvzQ/7HV5P7cfKF4IA5ODDr2rhu1x74Hv
 3Ifrbp4aDc2yQ5Zy81RVomoSj4fQwaspdkJOA9p0onUJ5ALKKmkdPLHVP1k0mBVoCY6Q
 nO+4By7OqvnJwbftC9PwzsJQ094kxrwysr7X4bGrs65mcfjVptikgy9EYaujiqXk9x0k
 PWWdviWeB7j1yfRQxj9EtorGYP+IqDOrcX5ypKP40QRuKG0CuK88PzLBnpO7LX+gNwcA
 w1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941484; x=1795546284;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SBt+kh+JtHZ0qpw5kOtHP6llWuCLlxFQTaqhJNluUBs=;
 b=Qu89MciUjt1N4Nj1EtizoiuqgjU3aIKGHGCU1KRiJnyq6HNBIUvJkILP1yPY84kTK/
 4TG1HCN0MSfcxWQ6r/eTQJuKXEtd5yhLOwvX0RtO63Cgef3egFWhZMIEC3k0AIpk+BEP
 RwEYmBNGUz1J12j5JZHpvwdYM663NdOTH6JjKcnKRC6Q0DE1H7nisScw4s7IfnUCYPvM
 GzNxJqOQsRVCM8A+VymNzqZXrjfXYRN5TeYx9fOzAWmfFYSSgEfuGg3tjA7lqE7Kg3uH
 haLZmpySOqGB2tfJvdfie2KSSjgrQtLGD0tTzGLgibQXULJirIYk1NvrqYgIBzW3OpGw
 mIjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE0EzG4oCs/BegJYjMdjSm7GqijBzAqicuIz9VED6PDq1PTVW3KTOwHsKNPrabL5+vJ5Ez+nEBbA+5X@nongnu.org
X-Gm-Message-State: APuU4Z/ZoV/RGe94fyh0hxa3ujDn/BtocltO01eExmu/iojjU+OANI10
 PodnyxlmS8KExvq1UeiN7u7RfTVeFDzxsqR3XBtTolV6qoWjGY+nxFV9XbbLu2pgp699P7CpBw0
 N6eT1S8z8F/2LoB83aO/MSffRjw+Sw3Y+MFBEGmOZdY6zDmf8nVISV4lpKPiqbqPq/w==
X-Gm-Gg: AZFdTZdjOuruSWgszf0cTnzHn/lbGHcN+fB9gd9jqkYouNdH5JuHA5hWMupxhxSbVv/
 Z3N4ob9wV5xrMQ2JcimqYN7aSzjuVcQOvFOq1dS67PtmY2RFg9I3vgKMJWCJ+M0zA3xGkVvsOMZ
 cjZtP86+iCIXlDJ/C9/0RwpdNW4DZM4uIQDIRXkZfcphBzRpdbVNyS6hkFX4cPQTQu2Ruq8oPIy
 VwYbQXIruKGp5DByenL8+LL47BN8JkDvUf3LLU9UPwEGGmJ/Aoqce1nVl7xL6Y0tpYM/7OgMOi1
 J4FEuCPCaoH7tBInD3gaGEc78h+fWohltBPLoGU2v2FZHVRlPOUPXAY3yfuvdKgHJKRsdBzJjx6
 D32nFgEs/Nq6Iw4HYA32VOpXqzhgzqHYmhHzx/lxcN8rvT9uCfy09NZII9mSx/CN4Ia9qgVkii5
 pWkR0UKVZdwWN1QoVysXpQwP748g1ZWO3B8l+4mQ==
X-Received: by 2002:a05:6214:2245:b0:91b:87cc:6d3e with SMTP id
 6a1803df08f44-92114d3f193mr1525236d6.1.1794941483713; 
 Tue, 17 Nov 2026 10:51:23 -0800 (PST)
X-Received: by 2002:a05:6214:2245:b0:91b:87cc:6d3e with SMTP id
 6a1803df08f44-92114d3f193mr1524786d6.1.1794941483014; 
 Tue, 17 Nov 2026 10:51:23 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92114d70a8fsm645786d6.30.2026.11.17.10.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:51:22 -0800 (PST)
Message-ID: <2d9a291c-336e-4cdb-9dfb-0b0eb81d0c40@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 12:51:21 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/hexagon: read the old predicate value
 through C4
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-2-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261117183629.2002840-2-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mW7Z37wwe3C2HcGu2Sbs8bBtmSRDB2Ce
X-Proofpoint-GUID: mW7Z37wwe3C2HcGu2Sbs8bBtmSRDB2Ce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX4nWuN8WJut/7
 pq02n8Z/9FZlNzSX1ytRoP97sfGqG6XtkiFHS7M8Y2Fgg4fJ/exqyy5rNwGP9BxeyqBTjowxLd6
 3Riuc2osu2/uMLlY6WwSC1mWejtf/WCEqjcxKuZL4NkG2mHJh1v+xUcINgbKc0JuvP8D2c2NoI6
 yVMvgAtt4iGKPTVchEaT3kXYlLRWbTtgfHKAb1+nNuCmEj3kLJV/BVQERh/1fi824oeqLLNK12I
 2lARWvXmDYdVVbgBraRuCCcpeZ+aHTAytzT4pf0dT39lrEX2vMtuKjhmO3j/OjOW8ZO4m50+JNO
 mobA1JRa4yVciDY+lS5y+lPwwJlktNUVMvXJI8wtTsFI9v0/P6ksYWLWwXjfVQ32xk4sSijP4D9
 qEmNJ7OU7wwTDtYGs/9hMqckSXfVKLInEzCDAzx+MT7kN6JIVV1zR8p7TQJtNhnJHRoAfuUmFww
 8R1OFsTS1U6ue9G/FtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX2j0z+Q7vet9X
 V/MHFT5ie+MhT1WfftqJT/5HS1ez4EH3WRRUD/7fZhDtNSqpzckoqnYN8J8Pghb0dbCMszx47Ae
 h1x9RQiylkm9RA+8sg163kPBSgZX2Mk=
X-Authority-Analysis: v=2.4 cv=d5xgWhjE c=1 sm=1 tr=0 ts=6afca22c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1yJ8gBRUuYsls8p9yqoA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 11/17/2026 12:36 PM, Marco Liebel wrote:
> Track C4 reads as reads of all four predicates. This prevents the
> packet short circuit from exposing a predicate result to an old-value
> control register read.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/translate.h      |  6 +++++-
>   tests/tcg/hexagon/meson.build   |  1 +
>   tests/tcg/hexagon/packet_user.c | 38 +++++++++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/hexagon/packet_user.c


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


