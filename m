Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435D606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMdnp8y/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=asO6zWha
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0hy-0005gb-T0; Thu, 22 Oct 2026 17:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0hk-0005Zk-Ui
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0hj-0007Uo-Bl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHKWD3741926
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5OpFreQ7B2ouYTSNvR3u+QcTMtI9AUDrqhXN3lPkFMM=; b=EMdnp8y/tJcf8SqY
 dCZ+cyTfIrkXU42AkVLelqt0gsAhuxRqIHioM1ypYttZuUg8Fkjb/owDgcODT7ZS
 d72uQDHpvF8vv8CQ/2jC5+UKX+6fb9i7fGEx/+w1y462huHSb6AzX+Q1IXddmRwr
 gesWEMZvmRWSghBis0gVjz4CnK1QMfaqdVNPE1z4bkLEGeKEI0BOzaLixcPar9eO
 9338d6LHfbqsIxcvirZ5p8/RIkDw/zVVJrE9z7iqPJqbTdxTHd2SKJr9lP8ialZb
 LxJo5E6uAzqLnNxU2UU5iUrhgkE0cSUDagB5tofvuG7heF434roVQHm2Tye7iL4d
 gB21dQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0pt0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36637676140so426529eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705925; x=1793310725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5OpFreQ7B2ouYTSNvR3u+QcTMtI9AUDrqhXN3lPkFMM=;
 b=asO6zWha5I10hy5Z4QDtZsthbKa5h3jL9MVFwsCSdTj2eQMOcNpAn9gXvhNZYW9XXx
 SdKIfEjiINqCheHlW6EtKkli8WcOoowtiFNK4vAJuu5iaPlVVg4VUgWgSlj3ndNoqhBi
 zWNYSb2721TOQToM3xH/Y1HRmyOan5A6WpuVwbznwPNJQz3AOx26aphWKCpxxz8Og0Wb
 nRxHgqEWDnfcZYRU+rdDcozkKTV8vXP57Npwj6e9+pTHGpFb1bqAqDsqllsbPlmvP7Dx
 /Zagv2zGlMyiervxAoEXCpe4Dtczo9xjpr+fj2nbmz6CnRzpuBnHhlchWDDezyVXo8Gh
 ecqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705925; x=1793310725;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5OpFreQ7B2ouYTSNvR3u+QcTMtI9AUDrqhXN3lPkFMM=;
 b=re1MdK4mYD3RskAxzzlIgN5lR4skryY7ZZ8NgdFS0Q+U/nrSPZU87IuZjET1ezVKPc
 pWE3fAMJzl9mOa/ryXzoKTqY2ZhKy6RFTdK23LvWezYjLynxlorxRyw6zLAEGj7zIRie
 eUdkzFNWWh/Gm+kUiokFYMTfb5rhjQA4aoeJvx0x2yNG86c0ZV3bH52bmzJCQdex6Ihb
 disaFxmifjgVLXP8DaS2kiF4Zbj7uz6roDVXqH29RH3fZ28A7cDjALVlwu2YgfwAxAPE
 /GVU7QkzVT5kzkiWmQvbu1JGq8sbwdGbz9HjCMhNUjYnn46k7DpW2JKuXHSvl6opNiq0
 5r/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNfF4lQo6Is32sl6K1R/5OnkTdKFeDFnoKWStUjOPxoKoXgZaV0rVSTYrXMIKTsj0apdmGu5kHdIwb@nongnu.org
X-Gm-Message-State: AFq9FYJ7/wm8940lS3SL6M0+kyxmHAiR/Bktkw0/nIxti78S+jPmf0IH
 SvkyP9xg9OboZSUzJjbqzzixC/bT/SdBY/u8TTcEY2hUBM8+sTrQLIBJizSPJcSbVPCvnwNheYV
 lnwsWhh+c5cBdTZtY8k+LoGP+scYDKu0/vM3o+7V2ewi4RjUkJVpBkoFMkQ==
X-Gm-Gg: AYBFou0ZJmz9lU9lj6X9ADxodrrte3Yxc08Hs2q44Smn3/Es1Ft2bCpCn3/Th7JDLtU
 9vjXq+3dTJdRWZOcELxXxTFCw+BdpZHpFjGxqFXRdN1gtP21SL0BWfKimiiuOoo2UWfD0v0tk/i
 8aWe4NkywehFnyrIQ2Oc4DNm9PNeU5GRNLSz/5Tu/d/x9RiE5sY+Ye/AksfiCi0IxLib9MTEXSl
 18cq7dthZ69bC6l5QLIBHU+HzcQEOcDj1frkQEcqPMDzQECOBuoqGN0nvsR8dE6K1SqQ42P6KOz
 Ppsf55IgNQpmDX4u7buqG9L2amXq/p64CWQ/cqzMIaOX2FyN+xTJt5q3W1tGBuiQbYpDh0abTth
 /HtXl3ehiZBMHuwZH5Br7LaEdfLr6Q0gnOW7/+bTP25QDBSBRCUHvdW/VLRgU/DaIdVLAhw==
X-Received: by 2002:a05:693c:8641:10b0:368:2548:c076 with SMTP id
 5a478bee46e88-369d980e176mr567555eec.34.1792705925281; 
 Thu, 22 Oct 2026 14:52:05 -0700 (PDT)
X-Received: by 2002:a05:693c:8641:10b0:368:2548:c076 with SMTP id
 5a478bee46e88-369d980e176mr567486eec.34.1792705924717; 
 Thu, 22 Oct 2026 14:52:04 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5ea64sm1006091eec.5.2026.10.22.14.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 14:52:04 -0700 (PDT)
Message-ID: <07a0cd52-6fcd-43eb-a639-32b56bb6a043@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:52:02 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/18] monitor/hmp: remove legacy MonitorDef
 infrastructure
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
 <20261022-query-reg-v3-18-7ad902b9a7cf@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022-query-reg-v3-18-7ad902b9a7cf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXxL3hicyMFVOP
 ZPlAbfdlkGg7qVLkYf8pDZlFbFPjbwie9qti2Z4KmWrxttp/L/1TK8PnvkfAL+ZKAaI7afTGjz/
 jBL42BkHMV7Bof8+t1gkW0bJPEXglswrNzuRqFPAH6DIZu6SawKXFW2Ywi4uvaW4d5E33EMerw0
 xahfOe1UhSsgb4MCB+0HDz1SLQGMfugePixIaYaXlo4fnnV17rXaRM47TxVdjq6J3qKd1fu9ezd
 n4K9auRFLXofrmptE5YsfR6LUeBWhf8gsDk+KyTTG2HaMI2B5u1xObtEnNS+iKqjrR29aV4535G
 wiNMl644C2q0OU0Wo5U9sIJqn9hdqQ+CuyrJqUuctdnLIqZrTwdHbRP9HDngc8BMls69ruYYvHK
 gYQQAfiODzx9HN1tAUQR0igplQT5HRGdEr8lIuw8S69j5Q+Fe22H9MdF7K9GbJWEXZRxyHTvcep
 vYvkDvlWudGMi/Zo/Xg==
X-Proofpoint-GUID: 30bstZ1_ojF6KLOHuvNLKMEz-xYDkMCg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX78dJuc9zrY0F
 fBjcjI61LiM9at6HrYWVcOZgOpo1ArFmFPEnR5VSq+AkupwAWy6Lem6hHmv+l9WvzCH8jNdzhn4
 PgOMS0ygWDFRb1nOV9GQ2axrzT3oio4=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada8585 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ddFTbBm2uw4GCDNeYIEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 30bstZ1_ojF6KLOHuvNLKMEz-xYDkMCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
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

On 10/22/2026 3:56 AM, Marc-André Lureau wrote:
> Now that all targets expose their system registers via internal GDB
> register descriptions (i386 segment limits, m68k, sparc64, RISC-V
> aliases), the legacy MonitorDef table and
> SysemuCPUOps::monitor_get_register callback are no longer needed.
> 
> HMP $register expressions now use gdb_get_register_list() exclusively.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/core/sysemu-cpu-ops.h | 16 ---------------
>  include/monitor/hmp.h            |  6 ------
>  include/qemu/typedefs.h          |  1 -
>  monitor/hmp.c                    | 43 +---------------------------------------
>  4 files changed, 1 insertion(+), 65 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

