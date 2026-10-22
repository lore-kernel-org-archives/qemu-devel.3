Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656F606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UpA8KNfj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bjmae6NU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0hg-0005Xt-Pk; Thu, 22 Oct 2026 17:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0hT-0005Vm-59
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0hQ-0007SV-Lg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHt0HO358613
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZJ0vAVBFE/gA/LBiAxfTUL7mFi2bGgjivHMnOSJrEJw=; b=UpA8KNfj339Yzy5i
 ygfcbfm2hutJ96BjW8dP7UTpQN05F729OSe6O+2hjPxKW/5nWuefSAk61+Z8t+Vz
 AgoHL/q38M+w3FVZFMojnXHTyNHPAVSm8s1walVDRb2estkI1ZsNtQfUiXrKT4HO
 6DK6EXoa/fb4K73Ow7yQtIk13+5gjX9uvtR+RjfeWQYOAvPl7AkEH6cp47p530rX
 nHUfAfOSy5J/6q7R6r0rdQSvmNoQJUeM64+n6gSPFZNl1NfLYW0KiHMmPHJXQI1H
 K3m2dzyA2d37TFOHVielSjprPmDkpPwTuNTzBJVxShUOxRUzR83H/9IWfO4EIlLP
 KJttcg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw17hm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so834732eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705906; x=1793310706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZJ0vAVBFE/gA/LBiAxfTUL7mFi2bGgjivHMnOSJrEJw=;
 b=bjmae6NU3XuSmQ10cpD2Kb81VOMt5PaAIGm8fHpU5kF9Vvionv+Qs3WhZtc/BX9DAa
 GSRE5PUmxjpiFBDRfZyXOOI2/XHjFOn0jA+XAfHqQzBXINSEREtUU94kEDmML+iRndTz
 Y6z5kYvL7TIQMB+uF+VDSp5lMsgp8zF3BzUntxfWMWy3dMHO+8nzij85Jr69HtQo/qS8
 iDKciZKnDOen7O27wenzyGocL20mW+ZyOEaSPMiAagDNhVC8RGi37dYCwRt/dMa06Prm
 ivDjn63jYwa4apok4ND7ygcJTLFi/zvW41yr9yfQj0EXh2qorobvpKj1FcF2fNTfivZQ
 rFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705906; x=1793310706;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZJ0vAVBFE/gA/LBiAxfTUL7mFi2bGgjivHMnOSJrEJw=;
 b=kyqR/hGKLnunYsiX8/Fd4rRogbDXUczp05SVrEP02VoqNgPTJGAWe9GxAbcgo2aoXe
 ON6sIq+etra+Cfa8/kQGJ9zoPZm9ZckZH/mElxCHUaQmh0iF6wACezFLKHY6xa1A3v/W
 PiuAGmQCCC2oXphpXg0UBatc34+lFQCSn/dTf9ISwkEWQpMOQAH9yIcsz2peB+kfSz2E
 ELD29EmwAYiw8b6Iczv01Jg/NP/iZ9AAO8xlh1TDPSY+u/+GvisAn0i3xIX4g693n2ce
 kpizQJt5ZXGec6jI6T47PO8hbXVtE3GBjI4bht+W7FV7hVGQNOoukhWXT4L7DaYj9y8C
 vgig==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqU/cxw2LMu6MLHQ6qf+pA+gLj5H+oPr9kMpTJFddXvvkCavgC3mRXtPW8LD3iYVkbKzhCozWX1FDE@nongnu.org
X-Gm-Message-State: AFq9FYKXd1NdWZd+If9Yd/BXqWwAcrWaOais8EPvI2ID8MK5oM7vB/aa
 2PSqIIkPaX10uLPMw68g8Vpx4hfDbIxokBVCjLxXRIz6x1A668R7hUAcsoljJ81WzCmOdJ2k6J1
 jrSAMR1TAWFw1XWb41ReKqtJnRJ+2oZ/XiGAu4DtN3HLLvbNf6w76KEIrGw==
X-Gm-Gg: AYBFou3gJ+Zcmbrcnw6bFqDj8/jhnlf6wTAeaZXBXHxCTR7kYplMCGMXBqIqOPKQlCT
 QZT6BSZ5WYUKelIROJtU3UMUdS7SSOSadkhqUELgjiQa5vpey+D5zJwUPAPfqmLAaI1DRWfNFrU
 u1WmL4YiyV6QPLgkHjyAJgQ/ofVZmsshX2jTKvAIBa1jV2LL2lPocIHhqk/YGMQoS3xws4GxiMg
 +DEuL3EtOpdeOdcslNmf13mDMnWofmBBCEMMRy1lqoPl1AOWamvCcTepCpUutC8K/7Ac2aBEwW8
 xkKq2fY4jdJF5EaNJGvUrxmeADIK1JfVKa70H42uGMYeZAUZ1bfzj42VBFeDKo2HXNmX6dtY7BN
 PP0Ijc7WbvDjvsjVViWG/PEtpdkRy4VwA3roXBab52gYAZkcQ0gWT8i0E1i0cDTL49id2uA==
X-Received: by 2002:a05:693c:20d4:10b0:366:2893:7421 with SMTP id
 5a478bee46e88-369d971fde2mr509583eec.10.1792705906399; 
 Thu, 22 Oct 2026 14:51:46 -0700 (PDT)
X-Received: by 2002:a05:693c:20d4:10b0:366:2893:7421 with SMTP id
 5a478bee46e88-369d971fde2mr509528eec.10.1792705905753; 
 Thu, 22 Oct 2026 14:51:45 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9dac9casm620905eec.15.2026.10.22.14.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 14:51:45 -0700 (PDT)
Message-ID: <26ad3377-c85f-4132-a129-7b41d6cad0e4@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:51:43 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/18] MAINTAINERS: cover riscv GDB XML files
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
 <20261022-query-reg-v3-16-7ad902b9a7cf@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022-query-reg-v3-16-7ad902b9a7cf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 50lEB2-PV_ugrqMCJqkfORZUgq_8iqak
X-Proofpoint-ORIG-GUID: 50lEB2-PV_ugrqMCJqkfORZUgq_8iqak
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada8573 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=pL10aHdrbxYHfr8ulbEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX0T2a/WzrN1Zr
 i4UQ383662ZOOEEeXILjlst7Jopd0dQ02A4aexBD43JVPZWqr3oDVD1MmV4inORXC4Mc6kHEInK
 PXon69r9/ZK+mQP7uvKWObrsh/t9I48=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX47NvRtdADRsv
 OXWsUnsOzDzNQdhsQPRaNYU80jUHqSaEltnmlD3IvCIXaJ8Sc3FANcBGBsknxy6BzL1apLcPjO5
 YdoqHmjfdHZEjDgWUyX8P38R9SuyGAi77wP+upmc9gbqK5pdoLZCGdiwDRJbmiC2kEUddIbQ/JI
 7lp1EHw/VOpw+3E61ToimRqI+ccY5bhZQoJHNOSyxE/avBkmBypVIT5xWnjLyckQPmyUnfDf22t
 XF8vFjtsciUPVlGNiGkMwIWwsRu2xvQjRKzJgGyHynxuPpYuuhInYXPxf5ntUwNWNmuqUxd0rH4
 pGqyI/ESEZqph5gZxCiBnh/HILdP4sKUSDw6uhWiPFKREZGjf+H5z8b2cWnkcArLwLZkKtsJ8vY
 mCLBu1ab0Xq19xS7tP0mnURPENk0WIvuwfzTfzDbPpD66xX9KWbkFy4/kskLgDm7+e5I0nPE8Br
 /XdSYxrJXmefY61iIzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/22/2026 3:56 AM, Marc-André Lureau wrote:
> Add an entry so changes to these files are routed to the RISC-V
> maintainers.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

