Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C11C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjP3l-0004av-2j; Mon, 13 Jul 2026 18:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP3k-0004aa-1A
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:23:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP3i-0000M1-FA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:23:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9NaP2256615
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e50L75fuBXsyc4MgFVmb10ermkDdI6zCvsf/pLpwteQ=; b=HbDNTf8UEIyJgCVo
 zjEsM5MzlLB1JiArTrROY2PwS0aG4BZ2YTgzED5eyv06nxl+z6xuc/WW3pQtxbdL
 ztZdDta1EPfrpB7VSkT13yaljT6XqsEACfXrGZKINNCU1u3zTsqvXWgC2OzqpG7m
 s7RaVrcTjU8DSN+LsEACoC0OF/h1hUHBaQ53AaTiMzmU5NG7tWit7tqaQSAELgXV
 +EdcUtqcpu5wv8TBL5RERgPca84XRAzpGszxRBKtCrViL+wilaBxoLQ6BsVwjhhT
 6pX7hjXNXzcanp7nZPvFOO/Kug3IhdmQatnpL/EG5GhD25MKzFrAK8y6YC6RGNHS
 aSW4qw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9trd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:23:29 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88ab059052so409395a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783981408; x=1784586208; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e50L75fuBXsyc4MgFVmb10ermkDdI6zCvsf/pLpwteQ=;
 b=jDnylA22wbuoMd17xu+5PgzUMhRaTI4MSimrHaOM4gq0dEZp7rTQHibsHDfFdY3eSb
 N03NyrGd/VfGHrpkxdgXaX/0lXCYb5Ta7gh90RM6NcNbgNbbvIloIOAFgjdzKp1pz0t8
 i/WaJPxXi7UZtBBhoFLB+QWa0rtGB/kXwMv32WZDGnTeqxNdM+rOd03sSspLDO39ANwG
 DKvcVzfN/yfUmFFYlxFxLiiqdZ+JaMpOT0Sy4CBOJ+/b5oYlEosA2YT0Et2JjLzbHr9m
 zH67Gh5lFGbR/3nQCNfWssrU7iod7JwB0X5m8E2k8grlxm1/XO+2TCcpjHe4XGOfOeBv
 w4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783981408; x=1784586208;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e50L75fuBXsyc4MgFVmb10ermkDdI6zCvsf/pLpwteQ=;
 b=DCp71U6h08uwheB+2oGDd3O0RfnYunh0HLO2IkVX58lKpybIdYJDXvHMsrk7Pa0E52
 nt8Mkl1+qhkBolmLQK3tvI0QhwBfC8h1LPAxMhCzrFqeCyviByT+87dzbuuuvAe2JAGv
 RLecApRhRe8SCDI5tO6nUkkr3FZ67f6us4p+atLUT9zpTw9rFIInolKXhMn3NRw6LIYk
 piS5foRqRvP9YV2Cc78Li+NplDppePJdbkzXra6xbuctNvTwtjMGKdf6yB4weug9h8BP
 mCHEVFvqtHjWIQ0phPZDThclSsWVpCaxpB36ohjuewRl5T61t0zqPTZNK5N/OEpopcsC
 0uPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLC3cIZwiL3tUC72oDhEZHWtK89P8VPJRu9lnVl0F2kTWV3AP4/4G/evBvJX1HG8ss5R1jTvEcJTU5@nongnu.org
X-Gm-Message-State: AOJu0YzqXOlRqUtL+q0wqyVGFUMHl9A8EDkNc/nUyJ3IBh7pKZ+i6D7b
 n5Y7Z3JWJC+DlDNcLMloGDQPp7p3a2D46s6AfCsSvsS8DV93uITSLQeVUP1nW0LQTJmKJyndg6S
 /g6sMs5l5FEcFVT8SwvtJxsoSjAAZClXJr095/Gzcs7ZpWGdmaNkB3j8C4Q==
X-Gm-Gg: AfdE7cljL44tS+2xyC1Z5PGXMl8/sCbOzmyxaI74B4ag0vAebeVt0ojRiAbIp+D4CeC
 yzOz//fgHQC2uBFnILzVAhHsd0zCKlqGRqY5kt0WuE9jkKQkpgaWEg5s6NwRe5O+U2lN3DhQRRa
 SC1fDFG19jyLcKuBkp5wXEffIHp9Razlnb/XCPp0iWxKEed98/lclHnKJzO5g8EMqJqhkY/CMbP
 Bc+VeCRhLSOCLtfJXlh9KQmoG4FqoNCcc+UIIdyiYMzpN00y5jVjHVA1hWTuDUN9zvBVeg3CvSg
 EaEz6xrY7xJywScKmdSK7omSDKll7cgGRWzz2Ykn/EyyAZW1cWKljPUjGW0oXsszHUGQCaxMbzU
 p8Cgt3dxoOROqAo4bRLXX5uYsMiywz2Z794gJFmnl6RHYePU/pC4cczefFJlcnL8W+W9v9OQTUn
 OjUY0=
X-Received: by 2002:a05:6a20:3ca5:b0:3bf:a517:cdcd with SMTP id
 adf61e73a8af0-3c0f091831emr20555497637.12.1783981408246; 
 Mon, 13 Jul 2026 15:23:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca5:b0:3bf:a517:cdcd with SMTP id
 adf61e73a8af0-3c0f091831emr20555463637.12.1783981407796; 
 Mon, 13 Jul 2026 15:23:27 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4cbafa1sm60777188eec.6.2026.07.13.15.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:23:27 -0700 (PDT)
Message-ID: <51f6378b-e777-4727-9cd8-ba3cbcfbeb13@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:23:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] target/hexagon: Add an errno mapping
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <60a8f2decf0af0581a82f95edc0f58c5420042f6.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <60a8f2decf0af0581a82f95edc0f58c5420042f6.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyOSBTYWx0ZWRfX5S+0ugsQ9lq/
 Al0eO919sO4scoF4t4S+GhCSaRP4pdHUJpL/5aGNsVjZR3mrrgKp58BqG+Wd59znBO8uHbB01Qg
 m2l5J7luce8KYdV+6siGGu5ltVtf9Ygw7ocHEswyB88AQb1JvOIOhyQdYqNmYaEKITJHu3wCFRQ
 cMYt1Y0gzjDFxknzCsJQp89UZGCcTOjavJZGCaJlkc1URg4v3YI0kBSAslsAbLRruhTACi6fIX9
 mFJgPqrjfNlYZb1vogsUlqdNzsA1/H5OacN8/d62pYyBRHXzfUPyjXeutjV3rgffDSN4DzqfibO
 jJ95/k4TtCtpjYwTSTz31itmI2KNiDWsOGhV9iM5Qsjbw7nAxtGEZRt8bxIpYoir5EoVYMaoS8x
 Q/oellD4tmIlkqArcwEeWPyCSsNyjQzLlsO1UEDe6kdbblpTmVeFltYcQQ7NBbvFxXgZUE3IOOW
 JYgCf861XtzxynvfL8Q==
X-Proofpoint-ORIG-GUID: V242Dndpy9crcGG23sPbeaVbr64I9eFw
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a556561 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=l6OUlFQfiADUKPOi7sUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: V242Dndpy9crcGG23sPbeaVbr64I9eFw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyOSBTYWx0ZWRfX8wgBfETUrQxh
 TLWLt7npwg4EtA65vJ2KND2jxE6TK4zKRUK2PhZ6gYCf6uJJgml7/5rDsMB6HDeY1/4PDYMz/ZJ
 TB5H2uUNQXIbDUlsgRWrQ/DkZlkZpuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130229
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> 
> The Hexagon semihosting ABI defines its own errno values
> which may differ from the host's.  Translate host errno to
> the Hexagon-specific values before returning results to the
> guest so that baremetal programs see the expected error codes.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/hexswi.c | 81 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 66 insertions(+), 15 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

