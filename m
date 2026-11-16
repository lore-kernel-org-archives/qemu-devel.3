Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D47606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YXHBhd1O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PCw2C5Dm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4UP-00048c-FC; Mon, 16 Nov 2026 16:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4UN-00048J-ED
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:43:47 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4UM-0001rj-1H
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:43:47 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfVOW2135153
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +/N9CDnrtNT0kLupm35tTBteDOssZrN+woeiURObCTI=; b=YXHBhd1OxNslopgD
 gRKg37VXzoIgRZy33UfBnPiZtw6z/ijHfHkOXxmrsDOZGtq7LdcuXoSNZfA3pm78
 ch4MvpPc44zOA+DGX8RyBriXovGJHYb+h3vZvqTbo0fgclSUnshmxc30hBlHyJ07
 ecNxbXI4D+hZz1gQXVL/BWAzF+/w84+HdaoPZoOfhtxFcCent2A5g0Npr2tAlymY
 mLL5NpY7mvAn2J83yTt3NX3yKL1blYGEFvTbTvFrFIhxEellYbBeAv4norNRixsK
 tbqMGSMWZLTBGRaut1mY5+LoARlbseEpdVI7skTlSTOVicj9x8e+bXHmCoTVAB2K
 2H3Oqw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0003jmkh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:43:44 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b3b45597c7so2489513c88.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865424; x=1795470224; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+/N9CDnrtNT0kLupm35tTBteDOssZrN+woeiURObCTI=;
 b=PCw2C5Dmj12c0ov1HagRuLJE052Fuk2PkUVeqcUgiS1tYaX4Svpj7NaBAcGlr2hgh7
 TINFMqFyhrhLj1NmhYjkIFMyAUdmz7W3vgFbEkGwojNjqK9YsNT/ZPEjFCH/y8e59pKp
 DVtnQAlESk+DgGqK5y5bsHIqGk5Pz5EHwu3+nRQZJ/dMuNi1pjAvjtTk5ntnQw6ukOpm
 gu6X3aKb57Xfp0a747xijUJpr20c4BhDJHvoXRWKyB//InwrziQ77M95+etLAZplY08E
 xuDrBsDeSYBW91xJmoLuyVPRMD4vphiHolZlPHzf5QzX7CvfBXHCDLLGV7qSnMormn1n
 wp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865424; x=1795470224;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+/N9CDnrtNT0kLupm35tTBteDOssZrN+woeiURObCTI=;
 b=XKQioXXcbyJKx9DlLbNs5r88uLWMHWvyjUWbUQwvyUreobGMxZc8OMncPkAqrzdD0d
 2PwfB5N8BKYtO2R/ym5u3x/q3WeIiDGNGHbAJDmLkKnyn7SY5s72O2J2DuJYA3HDbxQ5
 B1I1lFDMRHNgoNNfgMzQnoSE3vwSLXwL707VDTbv4JPA62r3Kv59gfGyfFf4M+ZlBOPe
 uKqVXgEPUW4d8tx+nieHc25o8pOAJ/dHzYOOln59Y1bUuVgEgvP3V2cJCKrg/xDYONms
 27iXEkt0QnTJLourwyPrQYbeqsP3Vq+6YnFc2LKBXs64aJmP8QfBPbAO6AJZencTcI/W
 ZqeA==
X-Forwarded-Encrypted: i=1;
 AL+hErH4jz91DiZykNC4zXeJkcuABR1ztHcOYXRkr/catPK9le6Sb/DSfPY6LXg41ZqL0a9L7IcFYuRwd476@nongnu.org
X-Gm-Message-State: APuU4Z82tbh87WayyG2WyViP20ZHR2a0Q3jCOC5uHaSkTnwJ3tb7jZdG
 CCOnVDPwqMaXmJy+Y5pYB9o1tWI5H7tZ3dw4B4XfrFE66tGbe4tFDaU1RRY24W3PwnkAO+rYZWQ
 El0c+p2may2/+ROZ3mafq0lLuQs+Fahy4NDdbexQym3sY11/80Gg+9d9hOg==
X-Gm-Gg: AYBFou14vsxA8WlJ/KQWhOztp7bn6Pc9bg/xFFrdIqLA30pAI75WAgPEXHpEINAQBvW
 iHP3VoI3UG3XM0NXRPGF8pIZWVOKqca1wkPt6qxUYdWX4gcoK0pJ6aC0mTZkQ/OmJingV6Oxntb
 Qrmr9bUHuRb7Bd9BxUR2EG+6RjTEEXsPTzD4/KvofEh1mJm3cO+2HgkaT6iU2KnecnA9xLMWWSi
 vv661wqewPTpD4DSMhyOx+SJZGbfA6l7qCur3otS4j4qR8CGopFimGrnWL7W3Jl7I08nbuR3McD
 zviXgOdII6RsHXYIUMDwNEuX1L3SXaKr0L3iFE8NAjf9h+9GR8h7glf3xwbtZLyCDy5iQhSJ2O8
 0rDM3+Ep/Q/tYVIsiljMR9EqTl1lw9X+7uSM2WR1lcLvXPTEQ54DgPUFQ4YdKdtex45Zhmy3Tqm
 xPUyTaPyytDkhsEQfw+ZJQc+2chMyp18/XvdUZ1Y5es8Y=
X-Received: by 2002:a05:701b:230c:b0:1ab:fe29:5081 with SMTP id
 a92af1059eb24-1b5030fc6e2mr11373111c88.20.1794865423816; 
 Mon, 16 Nov 2026 13:43:43 -0800 (PST)
X-Received: by 2002:a05:701b:230c:b0:1ab:fe29:5081 with SMTP id
 a92af1059eb24-1b5030fc6e2mr11373084c88.20.1794865423214; 
 Mon, 16 Nov 2026 13:43:43 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50316e008sm34727416c88.6.2026.11.16.13.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:43:42 -0800 (PST)
Message-ID: <8d9d4799-a516-4078-ad1e-7340a976c118@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:43:41 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/48] hw/arm: declare arm machine targets
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-37-berrange@redhat.com>
 <ccd0d13c-fe75-4b78-8b40-af3f90d05204@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ccd0d13c-fe75-4b78-8b40-af3f90d05204@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JFn_hctgX6AJiJirDSBeL8nN6N9l0n7k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX2H7qOC0DNwHI
 SxsQdWo0iGQ5SB4dKmd2iNb0W4pJ7aklXdg1p1s7Kx50xB0Nq8sOFtajIhvgMnSJFX771W1da3h
 4M2g6C2Mh9Inyo2y0TJ9IXDuIaD/620=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfXw1bcu3jCfDuy
 UjIfOSi5pP4oV6z+mU5PKeEIFGVrRWNU5bCTbBPGr/o+I659SbC3vHvQpl/gO9RAr61vVeBL1ZD
 DqqXEBTZrwxDuYCRLB/PAiUooqdIOZmluHVHDLNuZ5aIdROAvCtb1Gq0SZpz/Gu9GZTJCEz5Nt2
 LpfqeFqe25+uZOxw3NV9E724MGmQNZQgF7Z07qLCs6WE6cabjYePAIFLgcyCvaiPAHLHJsFBLbX
 ErQ0b60o0q6EIv6gl2KVXUZUvX28eQZDwJL91osRLqgrtJcK7KgY5VM5f/NJBEdrgXxBCOVunpN
 2vQwJnho6F6UlcoEgHJPWtMhvTMJFeXy4kbsGR3irnRmmlYVnXuJkaxH6BUBQ+oJIXxpJzOrsBg
 ClRcrqqjeF9jG2zIaIpv87V9Cv8Sb0Cbc0ZSc4ArJE5bwF7f8xNPfQMWTSfChp2dSzMmbeDZKVb
 PVejvDPN9xyiIq1bldg==
X-Authority-Analysis: v=2.4 cv=Z4N5j3RA c=1 sm=1 tr=0 ts=6afb7910 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=hQcuiifgFyodJWxzPb8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: JFn_hctgX6AJiJirDSBeL8nN6N9l0n7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160086
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

On 11/16/2026 1:42 PM, Pierrick Bouvier wrote:
> On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
>> This prevents creation of arm machines unless the current selected
>> target is arm and enables removal of the 'is_available' callback.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>  hw/arm/aspeed_ast27x0-fc.c  | 5 ++++-
>>  hw/arm/aspeed_ast27x0_evb.c | 7 +++++--
>>  hw/arm/raspi.c              | 9 ++++++---
>>  hw/arm/raspi4b.c            | 6 ++++--
>>  hw/arm/virt.c               | 6 ++++--
>>  5 files changed, 23 insertions(+), 10 deletions(-)
>>
> 
> Could we have a variadic function to set target instead?
> 
> This way we would only see
> targets = qemu_arch(SYS_EMU_TARGET_A, SYS_EMU_TARGET_B), and not expose
> QEMU_ARCH_BIT at all.
>

Compared to alias, this one is pretty important since in the end *all*
machines will have a list of targets associated.

> Regards,
> Pierrick


