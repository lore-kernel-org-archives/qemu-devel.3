Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F8606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FkDtM+Sv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CPP0J/tO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNPK-0003er-7x; Mon, 09 Nov 2026 06:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQNPI-0003eP-50
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:19:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQNPG-0006Wd-Ba
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:19:23 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A99usB7550774
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 11:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6igUZ+Q1unvdwMj5KBkirrQ0afVpnZG1cgnkldL2uI4=; b=FkDtM+SvytaFNyth
 ff3olhUQ0QOMUh67ymoQiJn1lc05WflgPySSVYyi4sQchgPf04CEKHqFKhol6shf
 ZT7C2zC0ugYuDgEfdyCDZigm0UsNzHYG7WYKxXKJbnVo2626+I2bSxs+rB4BpJqJ
 jroZetggIgv+A2LnHU/9+QFQ6kFI/CoUHLrnT+SPR5S3cqkJK+ntjFri8bKwrino
 EZRHLCuu/kZmQv20P1/czLDRPggZmu7aaqBWvxa/eB2Yqt8ORBT7OQnzPQw/XgEC
 NUNKVGnz5CNMxhv8EFYpEU0kWBqzEKzOQN2nf0ELViya9Kt6BSJze4Fa615AWe0L
 px/ShA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm2vbu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:19:19 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99b715e4f44so357353241.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 03:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794223159; x=1794827959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6igUZ+Q1unvdwMj5KBkirrQ0afVpnZG1cgnkldL2uI4=;
 b=CPP0J/tOSdoc8A2PkEiyVj3Jwl3HU/PHqLYIf3vq664hbZY4MZiVSyFwZC+OJfdX6v
 yike5N/p7h0QnrOK4qb3Zy9/KkaJeats4gigE/AZ0vK9CnhboroI/geqi2kIL8KuOrxj
 yNzsjlLBa574XYviVSNvaEHupk8VyzLhs/aJ49se1sHn9wgELjOjP72MsB8xWA+wzvbm
 SStU91ZQC8lRqZLYmEqmiUUbxsIvGx2Tr0yOflzPRdygjx3UNzCxnHuqSYK4ORtYVtbG
 KjRM7TrKsGAYaMQqK0htNgRHJj9wHozBHb6iLC8h8yQmbDMm5OLGGUtAc79v/gxyE+rD
 SVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794223159; x=1794827959;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6igUZ+Q1unvdwMj5KBkirrQ0afVpnZG1cgnkldL2uI4=;
 b=OlYyUjjcwexkYFs/gEweZpCU/SX6yj/G9+zeSDlN/aVHgq+cn9CJ4SwJbCIG7ZJIQH
 2wLdTdNl7nNY5+tTf8HORUg3ReKA6nwijgXAVDpKiFBgkP01JviyZlUOKjvpnZZAXRYY
 UK2MnhYvRUIB4T6RilKESijGUGDwEB5rtJV9CJm/HIlYYrA9fpwAWlfTRO6i6oZZ7a8k
 ynnwv3qY2dTicn+v+tBL4cnC3av6fskjrYLQ40aW8IaLTJdlQO70Svre6dB8tLj5VtcA
 n1qCKg1c+pcSVpmUqUaHSbn30a0tRfg6HIX4E0sfkgHsY3wvMYeZywwDirax8WA4Hf5V
 CbiA==
X-Forwarded-Encrypted: i=1;
 AL+hErFYucXmXhW6XvppIyQ5vCaZx+ctmal5I8bEfmd2RTIo4oeK8SmGYDECAmE9YRMKoytPc9NumuAWjp7u@nongnu.org
X-Gm-Message-State: APuU4Z/5p1+EldiaDSaSO/6FZqajBDTWRt4faxl/zqLIG3YCJGKAeDUb
 h0LiOdf3n3sXxlJCJ2i4Dcu9eJFA9jBGGAs2PigvG+x+1DY+P2ug1WVTld6GiqrZRMFOHdFGroZ
 TjvG1dSnLLzi8YomNnut3kB4kIwD/5zdvStWCZVUSjulZUOgNqUkWzMFDMg==
X-Gm-Gg: AYBFou0gkyarhlKnJJu7qsX5J2deSyYOJBNRwI50UmnCUXVPuIh1J926npD4B68aCJu
 enbdXErTR/JOdVYWvv4NK0mVd1j7GgQjtxi11j8RrRAGI4GfZdXS4f1gg9uGV7eZ/uox+q6tKtH
 WbWKJ4E3wyB8g10MWnW+eZ2kXh2X+LL0kxAGZb1wRi+EG6sFOpD1Yb/ytxHqi1SpQYKSB15ttlh
 85arE85a2LFd3P6ABDqHG66TZMDW9AsqyKDesSYP2jyErbi+mhy27LCYLZ40jRr8ktEluTFCEHG
 y08z/j0gArtFCFez0K0Hh4af1ATEq/Yxx5FOcXUxPN2LRyCOSudwRdnQwmQoHtL4AKSbesgS2bq
 1kQr7Q9rinTj8rU2k1fG/5iVxANt8iO/ZLhvmHg2fgO9cZiVy91M2KpclnmeoPUjsQWyJE3bXIj
 TmwyaKWA==
X-Received: by 2002:a05:6102:6041:b0:7ce:78f9:adf2 with SMTP id
 ada2fe7eead31-7d2db07b85emr713588137.9.1794223159093; 
 Mon, 09 Nov 2026 03:19:19 -0800 (PST)
X-Received: by 2002:a05:6102:6041:b0:7ce:78f9:adf2 with SMTP id
 ada2fe7eead31-7d2db07b85emr713585137.9.1794223158564; 
 Mon, 09 Nov 2026 03:19:18 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b79502d5b1sm154144425e9.5.2026.11.09.03.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 03:19:17 -0800 (PST)
Message-ID: <7353a118-18bf-4ff5-a76f-6cf5f3567d75@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 12:19:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Free the NIC model list
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>
References: <20261109-nic-v1-1-4a26870ac3e9@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261109-nic-v1-1-4a26870ac3e9@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfX5rhex+6LgvxT
 JTkJa3U9rtL9o66FZS9flSrgtTI0gBYNZOL9qio4R1sZ4SjCxNMXFrESSJVJDqiQ0X42k41Qlh1
 v4qSjKUB9aD3CmDnRTVBylQ5LIDivHg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfXzKIqKJjGtYDH
 iSjzUFDjOLvGMukSTl6kFMrcxnS0+piuHZxqf15ZSVaPtPb/g/2modGSiPzc7cb9v4QMG2JEE78
 UahvM1HTIXfbAaop+b1TX7bsQMa6S/+fgBy2hhezgil28+oZacSqLrslrCtnn6TCsIZ/9Dtughi
 qn30DAKrhyApgvn8HIvImeU/l016iVW15u0S9XgH+vVF0zhXWEO2NnfLJDb88oYJ9naQv37CqRg
 mssb4IthKVHK1aMcpJ1psznsUDPiNmR9xxgxuELXBccE+ZYgqd2992o90X2a8UqpF7w5SAIv+Bx
 xjmkmR+xLZpQ8kO0pRKx0ipEzESH9gF9D9XYBiMMAFlWbp1SE4AO3pmwAL5xtMJwukuKHJJQfiS
 /NunGvxPM2X4Ws0sU7iXEEPcfjp+h58kPm6L/IpINuwwyhSBiWQ19HLa1kaIL2m3ztEXDmiKQqz
 tFHwHIIlBfqHEsJ3Cfg==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af1ac37 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=TO8KFCWSTU2MdDXI8E4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: WAYm4oY-Tu9x8o4j7fPiMF_36_lUxmkZ
X-Proofpoint-ORIG-GUID: WAYm4oY-Tu9x8o4j7fPiMF_36_lUxmkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090044
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

On 9/11/26 12:13, Akihiko Odaki wrote:
> LeakSanitizer found this leak.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   net/net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

