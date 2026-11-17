Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A6606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i0L14gfj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GKO9thc2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTRt9-0003Yq-Vk; Tue, 17 Nov 2026 17:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTRt8-0003YO-B1
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:42:54 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTRt6-0005ha-Hw
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:42:53 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMeoL1935265
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NOhXZxBwFktSiSfyZdzT9K8tmixMbFxJD0fR5zvdlcU=; b=i0L14gfjDn5DOzO4
 56TuWZtlZTM5jWkZ50HrvnYHW5nJc52/uf92gUMcKeAFUHgfOE8uB78NParlpuJk
 yXJPBSPmkN+ca+l4K6Ub7A/u/8UGB1apPhAHhPPzY0yk3L98FprJ1ivsoHrEfUUS
 TxQBhnlCwZSKb360HbS1up4OnbdNL/4EIb+t4ry+LLHEA7kv4OABi7v7n7k4LAN2
 MH8b6Z1Oaj2YLQ6z3HnzIvDdMrLJRdWrd6K+syKrpC+pMCJ57fQzsTaqiOL3A5Co
 HrOaR6i2+/hpVweFaBNqHvpn54+icykNSilWtowPZ3AEJHoKTLkMC2jpC4akoWzS
 9+A1bQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv900vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:42:49 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-574f8578e48so282411b6e.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 14:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794955369; x=1795560169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NOhXZxBwFktSiSfyZdzT9K8tmixMbFxJD0fR5zvdlcU=;
 b=GKO9thc2SDXdYQXACUnav446gAcUwrT/na0k9pBj5DUQqOn02HfG+QERbDfvQIGVw2
 QVuxAmTp+t2FbNrJvaUUfEdngks8zxrwjnY1tkHHCaYwTx5i73qjziGkNtCMk1J9u56R
 Och6JsoQDNWx3g/jqK6EuECaRgZZDFpg3g3xtem2C8DP+qZ4+Wt+D95rGC6QIQffXxk7
 6OxuD26XLxoX6bBEvBDs9txznpWo6aEDLdPF/oJbDjI6vmrz3BWOYiTWpZvSioOu691M
 yPk/UOGEWldtJUi5NlaZ+HMWb+dFAxWACaUMN1JNefAbr+oIzeuQ95dOjCgmRHxdv41p
 r2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794955369; x=1795560169;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NOhXZxBwFktSiSfyZdzT9K8tmixMbFxJD0fR5zvdlcU=;
 b=AuwPw7/w1DUu5X2orA6NvYlZuRSduu3MWDJm23ZeppVm1AgQAvAvh4WP9uUQraNjBQ
 pGz7D1fpoUU4b6rmQk+K5qeCGaZVZwxQlB68E0rHYOpyi4E9lSsvf8rGUKGbgxspXMhp
 UMSURdnFVgnzjajxnUMUu6tbrpdgTYWDoU888BUtlhTXL+IQ2P5QU4gOnjqTNIqHZu28
 1SbEHWr+qv657eJKyJtFu+2R83ECKSLmdWKsxUIrfi6YliQ6AD24N+t65pxs22AvbWhF
 71V22Y1Xj5N8by5lKH5PFqhW/F2iPCaElHZgE3OVZaj/XmJUAnhJxHXcfdiMra8Eg9T6
 cMoA==
X-Forwarded-Encrypted: i=1;
 AL+hErH1GYZmcPjJzY9/vPM7+JSLhpqNnh4gm5q6XZBki9CVEjMll0bHWeTOcj7HvyoJTNMIcTEenpEsiuWP@nongnu.org
X-Gm-Message-State: APuU4Z+utQTvkER+9ejbC73t0zdGGcUlXRT5+H4o1/anyRrNvNv5vpLc
 W/QYcKBw7LoMlguYOkc3faZ+ZYAZB56+ahW1kpeTb7x3MEJFdl1mbrS7OJISWy9iOsUSNkcw3mL
 43O7eR3rJwB9xAhjO/XmmkVxPuIrajQW07jdP+kRpZ4ronGIvIAAAuxaoXA==
X-Gm-Gg: AYBFou2360YNxHUcKg0OW+23zdqko8WYRRH/E2ZBNcUHmGP7cQAea3QkEyLoWRh9j2V
 AGNI6uBKKCEUR/P4wX1/4aaqnaOzcdZnNuUTQb9Z7s3shS6yB8/LBUq2mjWN0jBWvVe+JBTKUQj
 fIYJWsaquSDOHODK0/ZhTrmPep4Ik6Em6Nca48ueqArZI9LyHAigQGg+6gmTImLTwjbucVg6Kvt
 R3fNt3pjlCjIX0W6KauBFXHT7rSAx66cjm9GV4miim56bp+CWaM5IKb1QuEX8B4Adb65U5aGSu1
 uh6pktTC3GnzDq3L5Vc6hhLhClzf4/PENDlW2YsdQaAPmxzxFcfT1eOpKvHCOnSUaunk9yrNCh2
 XEOLgSkNZ0gDow1FpqqwYksmOK48lJf4OT6CyvrKOlZKIoHNika9mu2FQ5n2Mi/M2lacB6zUS/a
 A9CygTO44=
X-Received: by 2002:a05:620a:489a:b0:949:472f:2273 with SMTP id
 af79cd13be357-949996dc44cmr200719685a.58.1794954957870; 
 Tue, 17 Nov 2026 14:35:57 -0800 (PST)
X-Received: by 2002:a05:620a:489a:b0:949:472f:2273 with SMTP id
 af79cd13be357-949996dc44cmr200715985a.58.1794954957411; 
 Tue, 17 Nov 2026 14:35:57 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d4e670dsm16837515e9.1.2026.11.17.14.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 14:35:56 -0800 (PST)
Message-ID: <72caf091-61e8-40a7-bb07-abd19478f0c9@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 23:35:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] target/mips: Require the MT module for MFTR/MTTR
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-4-philmd@oss.qualcomm.com>
 <ec413b6f-23ff-42f6-8e21-52c565afb426@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <ec413b6f-23ff-42f6-8e21-52c565afb426@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MCBTYWx0ZWRfXxt8rirpOjkPE
 9HOqZDCDArBKdnyZUVOjqKqkFUdFrrnZKLoINhsdUZA1XCrKx+xRgb8Cg4zZezNUURc+34bjgMb
 PJzN94t3adrYJuOqlpfIN+dZgkxOWT7fYdPQM8ooo8cSI8xS1Rv6QeV3YPJgXnNbh7c5CF1+/Z+
 Bj+M4zl4/+R3E8p0A3a9syPdnAf/Cz/rcI+OuIpIMGl69zfZIt6IDoL8/OzWEKuIlM3fgfpqDsv
 WuS0zlI375BOHTWt/4LKFlz+xXybgVR1Ddqoip8NxaH3dJhABVZmG72CdjOuMH3MqruWpSUHngX
 cqLL2j4AXJVFcpPuNz6tKf6KUEsLdPOo8CXU11yW9Qc9bhxEM3KbCDheN2FFViyXQOx2lir21dE
 ghazMvexftP3xxMptQ4ZsV8sR75A7zMCNH8Orq85dzuL4c+045VMoToZpC9fys6J7lCimacXWSG
 xgVPHj7mR20SoX5QcTw==
X-Proofpoint-GUID: HhScBOnpoKy-yS_tqRuH4_eb_KDttauT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MCBTYWx0ZWRfX2eluSztTol9T
 Tcq1vfFdUjRpDITaGZ8x5rBEYYI6xby+shd0eeJ/FwCZ8SYKTcM0Z3+2w5mCRZ+8q+Ix5Cj5GQu
 bb0EcQaPd7eCyCpTC3+QhQa4NZzigN0=
X-Authority-Analysis: v=2.4 cv=LuQHWXdc c=1 sm=1 tr=0 ts=6afcd869 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=B7m0s3G2t2Xzy_wG1f8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: HhScBOnpoKy-yS_tqRuH4_eb_KDttauT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 17/11/26 20:00, Richard Henderson wrote:
> On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>> MFTR/MTTR must raise Reserved Instruction on processors not
>> implementing the MT module (MD00378 pp.46/50, Config3.MT:
>> table 6.21). Use check_cp0_mt(), as done for the other MT
>> instructions, instead of only check_cp0_enabled().
>>
>> Fixes: ead9360e2fbc ("Partial support for 34K multithreading")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/mips/tcg/translate.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Surely check_cp0_mt must be enabled for user-only,
> not sit behind an ifdef.

I suppose I got lucky, MIPS_HFLAG_CP0 is never set in user-mode so
the OPC_CP0 dispatch already raises CpU before any MT check could apply.

I'll remove the #ifdef (and fix the Config5/Config3 typo in comment),
thanks!

> 
> 
> r~

