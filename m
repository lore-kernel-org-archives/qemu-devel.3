Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF167CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvyG-0007gY-Lv; Fri, 15 May 2026 13:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvxz-0007Yo-59
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:04:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvxw-0007bR-Uj
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:04:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FGQhJ9481704
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HuWq2PXDWexUYykSjczxrh3RPBLCkILhiuEHKTPP/Jc=; b=N8xbUzS5XQHqVaX3
 pb13uE83fjZTqv+rgpf2bdgQKhrgpWVBued6wJLUm82EsxDrlfFVHLvLWdGZfrqm
 +ZITHFq6yFqm+k3S7h4Ol1BUcK/zcbvhme2L8saX8q1alXEoRgh4x4SugJv3mwZn
 KHOA2+kYei5eYTMQEJ8R1EkKsOc9Qgj/5EsRopPdNr7UUwYPpAzpbpmtPm/2nYo1
 3ZPu6Ywo1oL1br5+RPkJO5jpBBPLoKyzu4+wP5ClggXaEw9CVX6pCnzrzRGEhJJV
 vuIjZvalG9OXN+ZwWYd6kmWc37s7olvJDLLf+53AOqr0bwFcVfe5cpgSQyQGbwWY
 5jL+qw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e670u841v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:04:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2efc342ef15so42379eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778864687; x=1779469487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HuWq2PXDWexUYykSjczxrh3RPBLCkILhiuEHKTPP/Jc=;
 b=K2B3r9l1Q9xA6mDgccv+mWGdr+/1vV3PPFwqWHwgmSSKZAfOuB1cvfGhHyh4jEGsyq
 2HIE2m7m5qqmB4RpEpB3F5giVADQJahjhqNdSk6frrkZ9VdosoGjZSi44r5fsndjJu8i
 mkOSnzMaBcYT1icdUSClgjqrTUbYfDkVpzHmV7SQBXr7S/fedMrKnA+LSrrGXtl3qbAi
 RkmuIkJmcLWBr5NYoEpEodcVSrOAeY9lgxEoNJbkcUuoH9ltO2aNQ6j+uA/UT8KNja4Z
 +N4wxiqcbW/k+VWcqKdmjib2+R42pqZ7RW2NaBntCgH5ShexqPniwTgz9m0dupLe7PO/
 3lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864687; x=1779469487;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HuWq2PXDWexUYykSjczxrh3RPBLCkILhiuEHKTPP/Jc=;
 b=aAeob4VyFdP44soWvIrAOEuT0YrWs2sK4ifI0pRESOgYyQ80pbcgp4UCV/kLu48sfy
 zneLqegMV5SrdvfKKCKoDaCxoI9aMNOtl3OIXiVpmC68LB1Kx5oyJzO6szbtlECT35if
 qMb47CD6eZZbuwwjdaBe+v2/BEGJ0vFwEWFui0ARtLErHXDX25emKeAVvWLnHiSIyO5u
 K2Eu4znmdqULeMEqNov+pCJE1dfEzlja8zctkIUBAc4vuOJ3bjA8TepNxrZ6sGiyuF+3
 32l8sNN53FJCKYKyRuIrT0hcGzP3DSS9AnzS8YcCfVfxjqzq9ItTkA93dqxIMXOJkQpZ
 erWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+gTKLB7Mp1ectSmIt/31cEdLXSmiunUx1HsvOIH9tsHDb6ACz/K5foJzJBOIEx1dva9nepw1If+rQ@nongnu.org
X-Gm-Message-State: AOJu0YynUJt9Jxuzh3Kvy8a1Nnyj1/q4n7o6EfjviAk1phgSD9kRplv5
 8KNcgpho3c43cGYgGfX+XVSBYAIJ8vFnMHYaT9YER4hRI0VcymW56pRk/v82k8d+4G3uFD+dqVo
 CGaChrkpH2J0l/ByazcsGepl2SJM1weovbXPAjmHWsl+uR5jz/aVkNAkNVg==
X-Gm-Gg: Acq92OEEFuOBoZ3p8fsGfMLPRfcCj90ChEOPAc7VOnUYfZdSQ0k4JM4WwMhFdglBQQZ
 LBXUt/tjuLzhFYvpkY6vRD3f/GhLl6hvLGIX5+OKgJGiLz0WD1EZUJZUoAt2KMQkMnpSP2fmGTK
 IbnyacXTNTLHKm+yNfbWuswuO0oVs8YlUJVI4+gcSeBImNEP1GWd8QnXgW92k4T4L9uZP2jB7Sz
 DehE9Wnj6M9YHs7fRZR8fOvQrjcrDmlNAqAMgBfhcCj6CtBWPEKy05NZBjqULx0ASolP4R+EIds
 HPibaM02tLUy+kLJZBZluFZCYG4VtyP533JL7gmTGu39Pe/pII0497OTh9KPHOwYPpoVqZjvT4F
 zDSq0y75aE5YL9DzUZcu2G9ecD9rFjKHOEnmjqm76Wkgu1p3Y2sll+B8Zo0wOX8zL8forfZWG6F
 dlKKCiF8dSu9hACA==
X-Received: by 2002:a05:7301:1983:b0:2f3:a348:a2db with SMTP id
 5a478bee46e88-303982bffb9mr2322498eec.10.1778864686673; 
 Fri, 15 May 2026 10:04:46 -0700 (PDT)
X-Received: by 2002:a05:7301:1983:b0:2f3:a348:a2db with SMTP id
 5a478bee46e88-303982bffb9mr2322468eec.10.1778864686118; 
 Fri, 15 May 2026 10:04:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30297bbc9a3sm7635462eec.31.2026.05.15.10.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:04:45 -0700 (PDT)
Message-ID: <fa870950-73dc-452f-9b0a-5d450a9e86a6@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:04:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/20] target/arm: Build gdbstub64.o as common object
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3FZnWSpRivpw8sTG889zVW8nsL3I2SGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NCBTYWx0ZWRfX/gadEdjke/qe
 xZakusB3PUVifjbJICyGY3ed+D7KTmKGibfKZwUNHkaKbL7IRh9rMQe4bK/acqP7j9T4ZSBLr70
 Jb2bD+Z/avMUWIlvR6uP043KwA0dwl0ElyGCjT+c6h0s+fn/h4ZQLVSSca+So3Yq2l7dLCH642p
 5NxMhxbBtU78QKGck2irtVg6pvoLK1rABgJJsFBmUDtqx74QpK+jf8N7FaC65j0wLYNGuzTJXiu
 148D6WwboVUgJ2w7XqtTg/OYDNXFuLvBgmwnwUb/WZYE5wUyHes/LIwBGhxQHlIPi6xCQ1pnbeI
 au/gRfNK56m7yyj+otgP+Bq20wg926Eh9yrb8zGL2NfvQ1ljx7hXS9CW1ekKADhyroCwMFHgqnc
 /eeCFpNA+oI7LUQC1c9HP3kkNTod6Dja5wkl6a20+t6MAZ7woeF8dyvp/dPoWE1Stal63YViExO
 Txs3lqgK50IFvMu5MxQ==
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a07522f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=r4GAUBs5Yzx3MdfDzK4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3FZnWSpRivpw8sTG889zVW8nsL3I2SGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150174
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> While gdbstub64.o is already built once, build it as
> common object, reducing target-specific set in arm_ss[].
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

