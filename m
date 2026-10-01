Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCBECA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCL0x-0000FA-8V; Thu, 01 Oct 2026 13:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCL0u-0008VK-W8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:56:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCL0t-0002K0-Cl
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:56:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsuaL3512989
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dfIAg0lxc2j00o+cL+yNutPataquqTBgxEtYI97/fM4=; b=adOJt8HKM9BVE361
 C904HPi3iQNBYTVJGKwD8ZSZDIIQUbb0LfGy0FU2ADKJNvRW/zl8hFxSI50lNNlE
 JpOm22QTW+zJE4LqRB+SugKFfvU430wnXLKFEPXr49fCSOIkv57AUOtnm5f0UpNl
 +IHB6YFaEoiJC1eyxeKaY1eLvpa43PZ7PdybNdDxrrxOd1utTP6Rh8FzWYoEy3Rv
 fzKUjQAb6CuGyH+42eyHr/sLe0P/Qt00i0kkhmRbnmgPBjI61WWt0/g+D+tLAqyO
 MAF7OFZyKCB5u+dsQBmcRdJ57LypYUvjwIGTyXgrYX0EfHBXBS37WICIYE4GfnSk
 Gpg0qg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1quk9ejk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:56:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb93c874bso134808285a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877370; x=1791482170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dfIAg0lxc2j00o+cL+yNutPataquqTBgxEtYI97/fM4=;
 b=jBvja7k7DpqP/dDenSvHpTeD/A7Ap79IcDvy4m8mtxviwKRcQaGjkk5236ABX3xCq0
 vEhb0OxwaFjBrjSacWP3wfI6AK9jaZ+ZSNUawjQVpiSYpzXfD/ghrdLV4nJNg1E9nkU/
 s7G1S+XynU5HivYdmSLo+Hyi4UGkfYzT2WZbE7iSlH+nCfy3H/V71eK0q1iyNkfk+N1h
 JYTc4nNU0kZiIjnqj74/LdGgZOlxze5bKlHS92H5/mzpdUieUn9o4Sx+bqOCXjsX33Sw
 0AOdhZWaP8e6fRu4F0icmOfmj5yejWoAWrPkYQ/IJ+2F4wvoZ4XCwnb+OtKYiT0WYBoI
 PRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877370; x=1791482170;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dfIAg0lxc2j00o+cL+yNutPataquqTBgxEtYI97/fM4=;
 b=lS0SLDLeGSyCXwJW8OUAyd0dfjB1WMO181ELCUunTF5YLMXIxgTBmaMoVgSKCbZ+l3
 UhIG2JgQhDoCjA9iC8257t1LejIcpq+QEZ4eHONX5WcjAcS/N+IyHbUAe9YaKqjoKi1H
 AzypKFVjmgoVvEqz+j+KDCjatHp+PvXhJN7sAvc7R4m/BRVDncXUpKwn14yVYugwhZ5E
 Dsw2sZNJ/2kZe73gNrRsYKFE6VR4xU5wbrsqRSIpveWy7aKYMnFYroVwkqy+G3k2zYYs
 ki7ZcvGYtEJq+ZMyFkTYQYRRPK8KL9Q72hGIHz9IgR5ThQGXF3Tz/ji+Tw+W6avSuewb
 hC7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyfXBJbId6MBqPdHG3PshknvTzaV9RjTIXzrD7C1M9pgEWsAG0EqFoEP/Acd21qi8YmUKGT9i1xEMd@nongnu.org
X-Gm-Message-State: AFuF++kYyxuJTpLdVhkjObLpSaEwsddkr7w0F8c7gGz0T0hY0M01MI9/
 cXB9Q/WSLUtkgCKuM58Phqh45p/LwhB9daZMLtncO60HNqbZHcDnR1qdvEGmr9buDr8ERGx972H
 4v2VDtK08/r0D5MRbUf3zzUawRORxhjZzPFq1NoZejQQ1fo70DJ2KtfiXEA==
X-Gm-Gg: AYBFou0AMrEf+QeIfJqn/LRfeaMEYr2u2VpmfppCvE9QIjNbTwBiAEAtl8r+joOxGNa
 brEmzXeV5jERWRRMJNaUwRaR5++tAcnzNrOmA4ZMriL+15pcFFm95A2Ozst8sHh9iRcRnVST7ux
 LaZ/H7ctx7W4OrTlzIFX+J0qXfDjpFH1Pz7BbOtdLdsray8GN9vNn37UUgTKE3mmL651tuIc6dX
 KhtnV5thQ9QbjWI6dnweOfSzCc7VokXtAmySPmE7mTwhJoC+ACJX9nnJWEFN+2I6nG4qe5cLNPp
 ny2PezDdTroOqKQMLgcBs6kIw5kH8OTT+hX3QdHUxgBykjyg4YPO9ZUPeZLWLek3GzssapxazfC
 j+8v2xRUunILJpu3OWsGnQw==
X-Received: by 2002:a05:620a:458f:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93cb5c2654bmr731111685a.33.1790877369463; 
 Thu, 01 Oct 2026 10:56:09 -0700 (PDT)
X-Received: by 2002:a05:620a:458f:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93cb5c2654bmr731106685a.33.1790877368835; 
 Thu, 01 Oct 2026 10:56:08 -0700 (PDT)
Received: from [10.111.137.66] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027734b49sm6326045e9.10.2026.10.01.10.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 10:56:07 -0700 (PDT)
Message-ID: <e90419ae-ac65-4c67-8c85-c64bf4225372@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 19:56:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] hw/xen: replace "long unsigned int" with "unsigned
 long " for dtrace
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-5-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001151228.3373747-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXxic8C6nnddmY
 2KNULjY2Z95rQZdC6z4hckAmDiJR9Yv95cr3YkluXRdisBfe3NZmZYZ3Ow5mTQEox6UH17LpT2L
 /pvSp3tvetNrt8AEIkqwDaTLSrDMrfQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX1IfLTMPCAbRU
 6GHT/1ApW2wr+T+6XVkTHvRjK+p24qm8BcBTmFyhxtwOYNp9AFRyXq0ylI2BiuUXH26kaZsQskV
 eMVqMrOOeIq239wjRhjnkoQhsmy1jLZIB5qO589AW1Ves7BIrKGtVQTIgKv+VP0b47PpPdaG/lV
 L3dvQo5ON5d9kZhs0PBs1pZknC275g2/BiZdi16WzRqf4DMC0QnxiXR5xzAEy4ZZRLSpuem/GHc
 byDH19wb3miQtKzZy5BIZDufJwumLLBWRtEqCIKnwSZhbSlKVUzPjOTAYHFRpTE9SRN9wgF49fP
 HNkZkdEwMj3NpjG4+7wCWlexkfRSi7V4576G1fyZIz6cAP6/Thtcj8QO2OGz0ncahLRA117lqZJ
 kUCyUGeYl+Or1aeaK/8JFtIRLjsB+EEQnBsxeKrF/gNIN8Hubn6JeEo2j4rE+erfb3YLUc/lAv4
 acJaLteYHYnuGDx/tnA==
X-Proofpoint-GUID: rhsWWrGa7KY_aWTxEVgNa82o8TzWyYGq
X-Authority-Analysis: v=2.4 cv=TdADJhQh c=1 sm=1 tr=0 ts=6abe9eba cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=isquDYVHBMYyHi5Qtq0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: rhsWWrGa7KY_aWTxEVgNa82o8TzWyYGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2026-10-01 17:12, Daniel P. BerrangÃ© wrote:
> dtrace (or at least systemtap's fake "dtrace" binary) doesn't like to
> see "int" and "long" together in the typename, it just wants the
> bare "long".
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/xen/trace-events | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

