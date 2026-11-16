Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754A606A339
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PHcCNl4S;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tu0PYzvN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT45L-0002Ko-8o; Mon, 16 Nov 2026 16:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT45H-0002FG-OI
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:51 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT45G-0001Lb-27
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:51 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfG4c2247144
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EnSota2SDilnMmXNRM8+haqGEev6CrJOBxnzURyyy9s=; b=PHcCNl4StqJFAHDT
 NEVo3RYBJd6jN3G3PexBfoFcnTs6867IVN4cxEzMHl95yJOguU1I5F6tP6IXdtbv
 i8qJNhnQ5uvmzauW4Z6TbjTK2I6HqJJ3+ay5zRsVQ7KMUYgDMSwvGKVo+NTkMa49
 UWwOPBIK81oXpDz7lAjcxxqpwt3zhPmQ0Zi4kfiNnGqOETZAD8NHd3o7r3F9/TdL
 3aKHwRxJaYM6v2iOdeScIW3OmIsQjxZTKpdQnADJSMpsyGmHwc/FWuQtMr4l/D8Q
 K+RZVNfw2dqL7906CqtgPqj7aFusM6b9qjE1lGhBM7GIpdxLimv77fXo4o/jkIOw
 KxRUsQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqyamau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso3918378c88.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863868; x=1795468668; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EnSota2SDilnMmXNRM8+haqGEev6CrJOBxnzURyyy9s=;
 b=Tu0PYzvNhMm9zG9f1ah5Jm8ExpWBJ9rQ7YuiRRwZttpqDCGegeHcl6bprqQFc1PDEO
 O0+FoItjOeN0SimVT2/xiHwxCI4xdRsz2dHbtmH/3UTT5PRfSfL+18u9OZ6XP7TK7grx
 CPYbZYHLQVO+O4UuDPa01yWPaFELIQlBSJVGhhrT44Dk0qAOSjt3gRHMO2J+Q47mbveT
 6YAJJMAOZuznC6flTBdUs0LZT34pImLpW7ro0X+5JocUGcAOTFSAQ+m+AwKnPUTE5+mL
 Z0tm1YUwvn4oCPwVM2TO6lidguL2/jAdJomMZRbDKR3YGaQDR7sLiCOUCKM1F1sGvj16
 NJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863868; x=1795468668;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EnSota2SDilnMmXNRM8+haqGEev6CrJOBxnzURyyy9s=;
 b=eVEug6gvdX6eZ7pm4vVabo2fqlOli1xP8Ub7+eUqKjjqmZl3NzSe2YtaKLWdudabn5
 edRkQ7+jG1kqSrRj64cExrBscG0luc/sHr21xy17uhYsm8QUe7vSVuKPOSag3fTRZU25
 PjFkXbfPYrL8d2U0NFifVkt0EKBhTO8seCtyM5Fu4XlMUVab5Gx173krOJb2QCXPFICq
 KphRS3tZO2d+hagpfaHsnjGTLZFWFz35HzLEbrZcjHIzBfziNR6gBrxEFw2/5+9lP/fp
 jenv9L5cpRtCgAdg5IWuDJgyVdAjyrHiSf9fFfDeVBsKi6C+6A97qUQiSncq+X9/QQ2O
 6NDA==
X-Forwarded-Encrypted: i=1;
 AL+hErG69Iz+JovaFR6ppv1y0oV8J5YBU70ylsQ965mLcs4ryXZ3I18LenHWAOfWzNzR9KO8D5VlHrWC9fDm@nongnu.org
X-Gm-Message-State: APuU4Z9ElhJ4U0S06mDd8m/RRc56IU2bhqGFuQ4/GI10OKNK3oRCUUZ6
 noHYwHaQhTvJS2DDF5sN6PsgdUVD6gA4zVgZufjGO0fVNt7GN4Ye7xgmU8nnd0x5wKqT8Zik3Kk
 X+Z8VnexNAgY2ggkMb/foCJDo3Qh5pg5mitsnU2K9Rezi51haIwSB6YytTQ==
X-Gm-Gg: AYBFou2MxWCiYS/7rCur2mU5Qc+4RVHDyzD0YOBJkf7Hy/6dbpurR9Wo0SN/a0WcLl8
 pC72RQ/1GLDK6cCBBRQC+EBJJinemp+CbDLdHGd1MQh86yf52uYD/giSZUvYeDRljoszQh3Ds1Z
 7hMTqs8N9wwpseiZxOAbLJcOocxwLNwe1uFFxoXUHK+g9Wi5UftRLeLlEiXsvM3Y1L9Y4jUMT9R
 C0eRQih9OAKZYHgD/nR4vnZSJK2Mggj63Moj7k8iL1i8aW2VeR91YCzFfbJgPESzAmD88o/d6N5
 HT6TbjshLw6uXsvLZY/JGZzXRw8xUYfPtKqxD0tVTMPeDKsnW/rukhKD3ia7Pv054kh2NXsw5YF
 A8V4MLeXkuneFTRaA4odVKck4KhY3iCkAhfilMeJk9TjKCDo/0jPcTUYyaBILtK2Aik1VP2U3uS
 z+7Tq+FLs5U/jimvu68asipZ5JXGH0WgNRJvxLNYs5PMs=
X-Received: by 2002:a05:7022:b0c4:b0:176:2095:1ac4 with SMTP id
 a92af1059eb24-1b5030f291fmr9646227c88.18.1794863867862; 
 Mon, 16 Nov 2026 13:17:47 -0800 (PST)
X-Received: by 2002:a05:7022:b0c4:b0:176:2095:1ac4 with SMTP id
 a92af1059eb24-1b5030f291fmr9646209c88.18.1794863867331; 
 Mon, 16 Nov 2026 13:17:47 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50319d40asm35245061c88.11.2026.11.16.13.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:17:46 -0800 (PST)
Message-ID: <8416b1d2-5aa2-4ff6-a02f-68dd64e1e79c@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:17:45 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/48] include/hw: convert machine docs to use
 AliasedClass interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-21-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-21-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX3cmn+ItyWFlL
 2DbhHUiMzJFAFaoIYx5C2LWs+Y9dujsVBEIr4aWeX/o9pBrmWXnF+z1edxnY3UZOI0eFb54tyd5
 Ei6PEWnsWsReYDSLk64/XG9HyFddx8o=
X-Proofpoint-GUID: ijTaMhEn9oxF4V5T7C8dKoRDWjOQ0x7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXyMPrBcVmi8fn
 xdzFTLq/3MEf8BkEEHZyvsJuiwJQu1C6enh/VSM60Q+K2+o0ftIeceYoDWW+PxS4xzBMhY7lDOW
 B3AzDX+ev1wJ0QSkttiydCrPz7STD3LfU0eFELYufZ98ilph6KxVwE4Te4K1mpWEKCTW6/bQL/K
 cZWaBIDQhCtsY0HkONIh4YW3ecqb874m0qAt5SQQRto1w3iveGOQrjDqdxt6zvZhoqBfissdKxg
 qzOqRbUqSFXuAWsAjDRjdLDRAQn1+PcjIotRess9RsWF8lP7Q6wHCh4FE8b7/rXXY/IqUtzzahC
 0tSzi0wiyQq7pbs0wK769pBSIBY59LXwob3aEMjjsmyHsF5XMqD3KLPW2sc9ZOuRyIsTZzxBifF
 13nBve+jtczw2TTdviYT5KrLi/UhcdUdTeoKR+s1SmERAFFp6qwEUWRdZfubgEFOca2GUKjQqrK
 fNOP0hUozgeV9eVK2tA==
X-Proofpoint-ORIG-GUID: ijTaMhEn9oxF4V5T7C8dKoRDWjOQ0x7G
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afb72fc cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=wmUE26nv0E1riFeyJxUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> Stop illustrating setting 'alias' in the MachineClass and
> instead show setting 'aliases' in the AliasedClass.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/hw/core/boards.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

