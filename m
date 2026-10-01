Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CAACA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCL6C-0002aN-NU; Thu, 01 Oct 2026 14:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCL6A-0002Zp-3N
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 14:01:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCL68-0002yv-MA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 14:01:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Ft0WK2687211
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 18:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j/jmxdlLPP+mXgVLZVqQYZOUwElLwPF5O9yW1RmxVh8=; b=c5BEB+rWAj2vUR+l
 z3jEbEgklE2IUIcn166Ho2mdCzKephSkhKy675L7iF+pqjMPXLOuRpbUBBfOLT4f
 z0uLLcSNF/whT0+OXYGDaHwjrAk4M4sdokyB1BO6FlM/DuZCWJbb1OpNTz/5LVTj
 FKoIZdPQfFHPQN6peeTSlDFMOxvZY7XJpee4viUBTb/gOekXhq1eoMNSGKZwj+Kr
 VkwDQNp3OmYcpWquiLD/SE2+hzHMycQ6HEfUUWRg6Bc7xcPR9IXIsfqWxYb7fS2m
 F9qSGOdqgs1UibWgwu0APOLhVJveAsDnO1hcSu4U1o+lUNV8TiXkdD5TCIQm749K
 CUiMMQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8q67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 18:01:35 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5cc382632b5so1988728e0c.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877695; x=1791482495; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j/jmxdlLPP+mXgVLZVqQYZOUwElLwPF5O9yW1RmxVh8=;
 b=VNK2MhxUgUTnseNK+44OB8sMHIjnBMbQSB2yPsdJwS1qoL96xneuzSIlzxq7XmLdpe
 QQM49sbWqUDyfsMeNBJppH4VlynqGZ8LdBg5l3SZRZ+vUcruXLsLA2Kk9FeAAdoAWSI4
 efs26G94Oj2hYScn9/6fq65RLfgnQjDA+LoJLKaDv8PPCAjiFMC3Q4A8+6duHtNbTAue
 FYaHcs15PM/YU/SUyCx5NlmPTMQb2UGS1Lv9UF8APWNdH233hgtj19ykuKVpWJXUB1vY
 KCUklVdJ0lEY8UZ1GnZcNv8bDhgvyywePf/v1dbRPtfsTMWA/3qUVYM8/4zsL62BOkjQ
 goCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877695; x=1791482495;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j/jmxdlLPP+mXgVLZVqQYZOUwElLwPF5O9yW1RmxVh8=;
 b=DHlcTPzohpPog/mRkDcl8k5r/tO1KZ2xb7ia5F+dzJeHjRmuLLRJDueZv8Cm0tppuA
 UZagUIbmbRO+llXyDsaN/seFSJIyu9zubd/zY8EziGYQjaN06Vldy6cCE7TeumVqOpI6
 sS5KT5Q4aAaKSHbPz4cvNrxjX0KULtj8ze7fZJyl8yOFGv+zJXNiT/xPlEi+B1vLr8pP
 +MAqqjCZJKzf5myPwPYhptGnCQ7mvK2Mgb6sOVisOdBrBhxxth7kIQhW14Jkvkbpor5g
 jFJa7jjCfA+/WhZbpVPzcZiVUaDs9dZnCL0CMBiO2Rjii2Rm33OvN+hK4QbtSYKf8y1N
 NkPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByBxuYiFYGcqdUFMNti3kgUmVACljFLnrxSEYdl5F8fKmxUiWoIEbDmV27F+adlGZOb2sTQ0MN5qThr@nongnu.org
X-Gm-Message-State: AFq9FYJT4XLod3VkXflFe52DHwOwBwrd1Lul0KNtvci/eSN3/VHpO8W6
 fgoH90nbxmFV3SACh2Qy2pUfgGRNUM8grKNEPSkqu00h9qayftMENfnBlQnTgQ/STePYFswdQJK
 0VX6mGrrkfWiBoMTiQp1wgN2q49F+aCtNnbvYzAb9J2rBXSRN7xtO+Kc8dQ==
X-Gm-Gg: AYBFou1C9RvI0pb6wenaxu8LB/u2qBvnbfApT1dJCRx25IMpfeBhl4DZZ1ukjS71N5s
 qATa9NJsmKNxWO4GuFErLRk+i+FHSJ52H0ff3a1EEpEg3EIdtfhsvEJvoBW6OgU57V1gvBZfrQn
 IEFo707BWJFFkTkHSBb5LgSKcQYRZVLrrksM/qtH/tQYDpo7A2thQocyRs7BcVJcaYuRLH72uwb
 zV7NlqKzsBzxdsIVpueqgb3oSTWxv1sEgGb5BOEbwRFbcvv3UlaACoAsDiHguTi4/IlpYyGTyCn
 Y7rcvcJCrsuoibjsLwbtbkzCyhbqxcQohEcFVsRrGPnJ0dWROLh4yg4xRY3/pDQhI9MMXH44QKC
 6b0L+vk3cnHoPSWRWzEMNdQ==
X-Received: by 2002:a05:6122:488d:b0:5c0:fb8d:9993 with SMTP id
 71dfb90a1353d-5daa50bc4eemr47872e0c.0.1790877694508; 
 Thu, 01 Oct 2026 11:01:34 -0700 (PDT)
X-Received: by 2002:a05:6122:488d:b0:5c0:fb8d:9993 with SMTP id
 71dfb90a1353d-5daa50bc4eemr47840e0c.0.1790877693751; 
 Thu, 01 Oct 2026 11:01:33 -0700 (PDT)
Received: from [10.111.137.66] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff6c1sm7866209f8f.13.2026.10.01.11.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 11:01:32 -0700 (PDT)
Message-ID: <9f6ac9b1-6e59-4a98-a1ec-360516c6eaf0@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 20:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] hw/ppc: remove mistaken use of
 trace_event_get_state()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-16-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001151228.3373747-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX1U6TZNFKgebM
 ZiyLXTU8l83s0V9aRxU7RheGOAs4rUK7KZYXUd0mvlZyi1LrqPJdNprC2EeHOq7KEALpaeDEzLg
 5CxvihxN5vYMQOsbpRDyFDgzP5YKye0=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe9fff cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=_6kI2y1DatARejP-zHAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: abNW7KQSaGbAl2L4R-rOZZgzUEbh61pJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXzk8SbwV3rp55
 tgdXIaDaqOzEWsI6B64yiYM4h0mlP8cRWFW7IT+omhRJv3sPgLLS0khqWYpcZtCj1d4JKWs6m6I
 QonROvUd2NaTbGkRYnAwWheRihaVLy9BcHZmyeEOqin9czjBHX6BB41EpDOhbJj8iDQBz+aT2jD
 bswijrTlqsIWXiVhB/VuuNzKk5r2p7zbMHa9cAufjI4axcvskmPJ2Izw2TVWyTnXvINzHUKZYbZ
 tT1P6BvHyB/TbtvTbmOFp+qor9d9KeH61QBjxkNGl6Bl0ZWWz6ZWDX7ce9rRc/VJT2vnctWo6Mu
 lgFcpQ4rJAsWPmBEzy0PlEel/ZLV2LIv+Z1xuWGAhQ4Fb2zGPbDR7xz/iENAE/7+7VtRzwQA78R
 hLX1sWlWAriHKufqjP4zHZctPD3O4kIVgzDjovXJgoQHQ/SgqyOFSMC/1I0uaxf0Ka7uMIVWmaN
 Q+jjDRP6xT08uYJFQ9A==
X-Proofpoint-GUID: abNW7KQSaGbAl2L4R-rOZZgzUEbh61pJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
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
> Conditional checks must call trace_event_get_state_dynamic()
> which checks the state of all backends, while trace_event_get_state()
> only validates state for backends using QEMU's internal state
> tracking.
> 
> Furthermore, checking qemu_loglevel_mask() is inappropriate since
> there are many trace backends, of which 'log' is only one.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/ppc/vof.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

