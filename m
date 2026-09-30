Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7047CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBouG-0000e3-Gs; Wed, 30 Sep 2026 03:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBouF-0000Wu-1u
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:39:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBouC-0003nC-9G
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:39:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6pVTQ3380910
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ytOltN1iiWDLaJJ6kei9tERsE6R7+TCfcCRaM/leo2E=; b=mzcrcqfAT+4c1J4W
 iD8TWvh2P1Tisl0PRjPvybqe5LHut/6WukFlecDvciaO0ALig3K5GvFmbJN14IY7
 BRIo2PBqcRSSAS9jXk/xcfUm59rB0VHl7saj6dLAYuli3yzmbKrsiBXLyPyw3Q7F
 Ialg1F5EI/tERWKbZlLr3G+cBCD7GsN1+Nl5w1jvruMh+AvVLe9nUCGTCVormLTI
 +n6gDAQTQoBoA1EPL4/glnb1pv8FdpO/p/YrkxcLHOd4r1xMUGvSNs2vfswBiTvX
 tiQCGGE1qoAd381DFYoyZkK0coQzlOIIJ7Ju62wxHfngQv9FBCdU0GysnGxB9WzU
 A6au0A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97u0u5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:39:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a1e564fd5so937390785a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790753947; x=1791358747; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ytOltN1iiWDLaJJ6kei9tERsE6R7+TCfcCRaM/leo2E=;
 b=JpuOx4VDOWtmZjW7K2QBKsjO6CVRt9HtoZADhcrIV2gFf1ra0cXc9Vob5aVdl7NcDn
 UySewuOpZDIs43+Z+wyN6CQsOc0FnndOpsXlnTcOd7r06mKSK3MtCkyHs/EkuBXPFRow
 RM/FiLFkdNQVIZDL11texdzLKdl/V7xVBT6R7SLQNIBhrXj6yOfMSFXCA1oCndEE7/BZ
 Mdkf+60LOh6FgMYfxzZHpcTblv+5JMJXxVedAgbuHiYvSY96lCLKh4t2bDdmG2mmIJth
 wZ7ifiyOp/Sdx8/n3d+gUF0nZ4M8djyM8BJDm9KLpYwj5TzFq1lgVKgwtOswv0ZZMely
 3w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790753947; x=1791358747;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ytOltN1iiWDLaJJ6kei9tERsE6R7+TCfcCRaM/leo2E=;
 b=nhxYdDLm7Hym0XLXitQ38t4bh7UbGcqSZV8rLXR/UTuIUFJMfivkQwwl9mGZBoI/cl
 92IALDq3weAVYhjGPZa+sbrnAm4wk7TdHYut/MENOOdfsYqUKVe44lkXxryv4LGT9g8P
 w/TEDBMgBYOz6+kOB3HN0/Sj3YoHAl7Gncn7nPUvnF6zt+lCJzOPYWvLy0uTeSLqj6ex
 ec3lDb2qYrkmIGahChyhG7zMIuapMNPRmymUdhLORxRfXWqMGeOd9Y0vhiuMya97BrRq
 bqfgIWv9JkrKkvkwJf4imwoE5MTJqyWxmOskuf3mI44M2KW6CFqsV5jG0+E8KBmG2sUe
 NZDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz81gxl3z+7kHPVIfdH6vAwUvRZSlYD/b7L0DxmsG8eeG83BWMNZm7xXUUVlPsjkvgxYjXnrsNv4j7b@nongnu.org
X-Gm-Message-State: AFuF++ksUh3KE/UlXFyccvkxXtJzVKhc2LtZB24pw+u/ig7zKFRZjQk4
 /PRb1FU5BZz1SsAgA6lg0cGxWyMKhr3noSk228AKrS4eGsWZ3+WxhhKTcYPbPV2TtbreAIi6QN+
 TbeGkwToCYj1Rc/S7GQvCyhln53h7vLSNSQByBvc7owAOHNRauOKeLf6ibA==
X-Gm-Gg: AYBFou3NdF6SdE05KC/3c8MQEZQOfWusp821sAsqR3Y3W2Mz4Y/i0efOqqLGD7ddoj2
 hUWGn6zvSezpVxXF49OQ88TtgKP+gnkuA7ivsgmCFQ/z6YqFiYiBTadyyA0uwBFaBzD5M1Jf3OO
 X3W85BAPW05LIveJuUla+SXYRrMx9FMofTM7JIwWrS8bsMau85Aq/pGK8l1GR4Lx5hQ05x2ZedK
 /CyLLMB8jVED1YQL1rXdbVIvtc+upPHp+pAetr92gvdmYhoRPvZNSepLWnrmj0wW33fl7pwsA0y
 X1qvMyqsK3JbJPHGwc2sQSZLdzP+ZNHe/42ffjYojOX0VsDqs8HYEfloq3UnbX410P9Pg0jce5n
 yQfx1Gft5Q+gICLCK05Q=
X-Received: by 2002:a05:620a:269f:b0:93c:6f06:8f7 with SMTP id
 af79cd13be357-93ca97c6111mr83149085a.36.1790753946518; 
 Wed, 30 Sep 2026 00:39:06 -0700 (PDT)
X-Received: by 2002:a05:620a:269f:b0:93c:6f06:8f7 with SMTP id
 af79cd13be357-93ca97c6111mr83146285a.36.1790753946061; 
 Wed, 30 Sep 2026 00:39:06 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015df7c36sm26108395e9.3.2026.09.30.00.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:39:05 -0700 (PDT)
Message-ID: <1c197d4f-1f4d-4637-8de3-f14d25043e50@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] hw/arm/aspeed_ast10x0: Use unimp array and table
 for unimplemented devices
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930072501.2612119-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ca5eKfibnJ3YvNnAc8uWQEoQ93dUWL-w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX8sl/Vh+V0Dkt
 VaS5jQPo3YWXCxV2l26r/wekPzCQhC4L2p0iq7CxFGzcUwNmuKOY6rMhjCZL64bZZcMsQBXeYOd
 w3ZaKNOz1+K0o8KkxKeSN+memq9TnWri25TlsHTgDRckP6c0Jbf3bqhPWRcF2qwR9CCoGwG6vmS
 TWCJFuYchhKOzWcl9P5Pvn3G1S/a8SdUQqnI65dVXmXapkdW/WymNoxJU1yyirHIqJFR7DGL+sY
 Ll71ZadMU6jgDmakjPa+tdamq+2ckHZFn69lrZEi+WE49ejSEENnXrrJ89XPrsAyd5hdlweH/Nh
 /QJKtSrmQh4a5SfLnjmsIX+MroMhvBzO/A9Gt/xqud+WVeNlvpxkZCrw95m5s7prcFBG4KJnLnX
 0ySugqqyiqYgsT0Ew/3/1GsQDRFUkpona/slHSQDjazmRxJsy8hwR4CyQmgkDJ+i8bAdIJQLLW3
 cFXOXwecVfAFSrHrXYQ==
X-Proofpoint-ORIG-GUID: ca5eKfibnJ3YvNnAc8uWQEoQ93dUWL-w
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abcbc9b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX9O6Nz1T/xVzS
 2yatze0JLK3114WTDDz8N9B8eGxdgPV9+STq9VEY4Njpfgz0GJ6ZXgX8DI1ua2bgh6+Zdt8GBH/
 IdO7HUrmhnBSKKYbWU+pd6YQne11G70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300030
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2026-09-30 9:25, Jamin Lin wrote:
> Before this change, each unimplemented device needed its own field in
> AspeedSoCState. This made the variable names confusing. For example,
> AspeedSoCState has "udc" as an unimplemented device, but
> Aspeed2600SoCState also has "udc" as the real UDC model.
> 
> Use the "unimp" array in AspeedSoCState for all unimplemented devices,
> and use the AspeedUnimpDevice table to describe them. This makes the
> code easier to maintain and read. Convert AST1030/AST1060 to use them.
> 
> This also fixes a type mismatch. AST10x0 used the "pwm" field
> (AspeedPWMState) and the "sgpiom" field (AspeedSGPIOState array) to
> create unimplemented devices. They now use the "unimp" array instead.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast10x0.c | 64 ++++++++++++++++-------------------------
>   1 file changed, 25 insertions(+), 39 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

