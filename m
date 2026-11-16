Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49121606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gG+1A7Ay;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X6KHLiNO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT45h-0002wm-8E; Mon, 16 Nov 2026 16:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT45b-0002qf-7l
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:18:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT45Z-0001Mw-LY
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:18:11 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfAkG1573240
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2eoHnRAeRtyHRrTwvN7i2VfgVcuR/GEZtrZZvgg7aao=; b=gG+1A7Ay6gHkRgud
 VhdBH5TxPGnK3CDsFAmae74G9r04j1RW7KP2fbebTmm8DTsmOUsW8Qb9MEhu8UuJ
 8GZhjZPVIVER0nei52XiPL6IO3pOEMw/4srNYhxM2EnPY3ghXBDsTzjFxQTkyXb7
 IoCGTDMF7KzMMVX4xQEUOuvTltEcXPuooitBgXH7E3JpTwm9jPGYJTXIts4cUo5S
 cu/0TECfQTXvWJ5MtXExLa3i56fearEKKJwLBL56Dircu0dwvderJ/vr6C15vljc
 NuC8YXIxzyZYR1PvUZGotyKCe98lMjdLnd6QpL8mxsDDe7JBvgYQlSSXsS0FUPEF
 2T9kig==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgjkv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:18:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-37549877380so5248442eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863887; x=1795468687; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2eoHnRAeRtyHRrTwvN7i2VfgVcuR/GEZtrZZvgg7aao=;
 b=X6KHLiNOR0N6KTpCHHoff6CihNNCeWqiZBFHK5SXjHQPygPcYd8XAEdt8qdaBIaFlO
 8+crBFyFBzBoj4pY4kErq2qAgKrSYu8ykNuF4/nK/845aB+5qwvODl8dInockHCN90SG
 BH3u/8Uzv6CxLo00l1MVboy8vk1s5sv3eETmuN/AiKU3cGoq8Fu8ewmJg9BD7GaPIUJr
 eVWRpGIauML8JX/alG9Rzej5i5VnEO/ZcdtkiA2lK0vXtWeMliQQ/U8QPLbcDul5IrKc
 xIohrcq1lCE2M21m/bvANHRWT8T9XApt99uLxL3HVQ+kOENWEnNKgm93yF56IaecHkbx
 g/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863887; x=1795468687;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2eoHnRAeRtyHRrTwvN7i2VfgVcuR/GEZtrZZvgg7aao=;
 b=TUyyJAIfAzKzFe3A491hYlomLfHGMKuoNh5gvtpFhbNfMLD8i0a9Jos2FtJpBSI8bZ
 1dQpH5dhyBobQUNPQzo3oIdF/fHIl28XktQxVhR4x/eRYhjl6chOGadsha+IXlCI5TTq
 licDJk+IDQdMj7Tt4Hojb8tIUbCh9j1V4zTk+/5KZmRszxoDMNnB+LkrgH/M9dGq8NvA
 oULV3dn5o4t3mzoBZvwpSslbSnntNt/X5UOayxZHfSmz2NMZ6JizTngBtc6TUaAKlbAy
 WKHREVQL6XVLVsU2vZqbmDcX2CmxTupu/PoregZfNjkoSdytkXLpEIYbmYr1iVLyiulf
 Lgqw==
X-Forwarded-Encrypted: i=1;
 AL+hErF99E9e2Mx90ItyXmunX2tRj0gLGD5qecVspBinQP9ggg9eDfxMHaC3jT5QRrhtteRjOGYS0u7/cxj1@nongnu.org
X-Gm-Message-State: APuU4Z/Vhn8znkDEW52AKcP2Fa+4wqoAtwMn2Y94djAVzzonHYH1NR8g
 nhROP2DLxe/1XqouzK9heZEmV9HjbZ2lTJ9qQJl3G36jAw6XKqQIJ907jAlkkcjO1VCUJ08P3vm
 Rns15wYsG1eWlLf/Qf7zA/dY97cFeF4YDhZGduqE3YdyqkXTi5+MUWLV4wA==
X-Gm-Gg: AYBFou2mSKkYO5JxSnEdcogQ55ZEmfOTfDOp2BJpG/TrwxNK7AMJMX4xemeBmcZCDr2
 Y/7PkoeoELldkVsl8HTmwSpWscfY4QpJhrxj1xf/xVhlwvt0a35luk0xbDZ3LzE/nVLNfvLu7Lo
 KAjjdKdSWMhUY5woUhKMlRtS/oWvbHoxx5P6B8Hix/tSZVh1lwdRS217LLb2rBgMlea3Lxh+myD
 4gvf25XvTdv+S1z4FI2rJrpmIqAZ4fgXk8R6x280jaQ5chgm41vZnpY8DFxC6i5tBLY1+JRCj2a
 gryiAlVpXa1D/ZK06Q6BoQc/thIxUHXmtkMHhgOBlMeFrKZEcDNeMQ2dfUQp8qEMG1wT7aMli56
 KbsqsWiBaNgdWUk74JxlJNBoRWlCLfQLIhQGGMcG8akwDXpWs461YabVw1Nz6ShhxRNL3cov4mc
 BxgfneAwctSF1ORFmRnRQ/qmXGuy5P12UGFW3dfMQ/g2c=
X-Received: by 2002:a05:7300:e9dc:10b0:380:f112:3cc9 with SMTP id
 5a478bee46e88-380f1123e66mr1059251eec.38.1794863887474; 
 Mon, 16 Nov 2026 13:18:07 -0800 (PST)
X-Received: by 2002:a05:7300:e9dc:10b0:380:f112:3cc9 with SMTP id
 5a478bee46e88-380f1123e66mr1059225eec.38.1794863886920; 
 Mon, 16 Nov 2026 13:18:06 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332a77sm32906769eec.4.2026.11.16.13.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:18:06 -0800 (PST)
Message-ID: <13182d01-ddf5-4988-a723-75a888ddc0e3@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:18:05 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/48] hw: drop 'alias' field from MachineClass
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-22-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-22-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX4rOno40sg+GP
 XdAwrgUyghJYvaLJ+q7qhOposxCm+knFrFVVt19MqFQ2mquUOWPvScDIW2A3utbPElJdLnklRCO
 dvLRmFL8vxnHLbjs1Fwd7TIlHzKvVuk=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afb7310 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=TX_W32ikwbp1kTdyQvQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: L0Zoe67zK7h34OrypHUqgjPqayfgM4IU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX579UngxY+8FI
 ITCUfyZpvbiK5j7tC6tHJwTIqkr3gaoKRamyUtP6vd2MdbjFnP792LcVTGuDlMmFF9IesM1qLeL
 5FGxxba23B5lUnW/94+T4jNam00RRAnfBmZm2QZsNHQkB7jVSaR3XuDKeY0ktBTyThWJu540FES
 7Oilo0pOq9Cnfc1QbqhD8fJxrGsT5O4IFWIzbuW2aQhP5ZWFXqW1TJ12ywTf7I/vsMeijsAevVr
 QDGyZL4jPkCSKWjXWZXscSW1Zg00ez6TM6RUjN7ZseBBVOCB1tCL/YTcsbmQv9sfh87dXYdy32Y
 o1yVvsKuel8KX7tTmggshmWBZHwO9IhRXdM3MMWi3/AzlgoCzp2+PXWFaopfrWagFA/PeIxHpJ+
 yaAfTkyUs3VvgE7ItoivzDuLn4C69oBlwbgFMFHQBQ4gUQsYK89w2UujrICaiqYXwMmhkixjzhF
 yWoyoEvf/ecH6vIXBEg==
X-Proofpoint-GUID: L0Zoe67zK7h34OrypHUqgjPqayfgM4IU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
> Everything is converted to use the AliasedClass 'aliases' field
> now.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/core/machine-qmp-cmds.c | 16 ++++------------
>  include/hw/core/boards.h   |  1 -
>  system/vl.c                |  4 +---
>  3 files changed, 5 insertions(+), 16 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

