Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C1606A88A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F0fo5xz9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JZcHtxOO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT44h-0000ec-0O; Mon, 16 Nov 2026 16:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT44e-0000dL-Sf
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT44d-0001J5-8Q
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:12 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfGvk2247125
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5qx9ReNrAoxxsC3psJtihDc7cCPbBm8M1KxK4qsTLrw=; b=F0fo5xz9cLAfO2RE
 iEgD1H4NqJFJJydwY5YUjDVRuXvPe7lsBE8eNl7YLH8oHE96VTjxS7kdbL0ikHwI
 INHKGh9N0DSmbJa9w1P6JFsJAeAM30Q6sn5+G3ONhlf6TYvShuQjFF9HaZsML+OU
 2FaaTCyNZBXEeqjViWmLotglXSeFc0F0s+b9GsZBWOg5M+y6e6C1OBKu+gQ267i6
 F/00r9gRMF761VVwqlgCfqKzIWyMY1uC/wFovOuXUVSaoEG9mK31Y9MHc4Dk7RCE
 ijLW+jP7DvIu3o/U+R9djHg60s545W+wc7b6TFH8y0dEFSSMhJjRpSyosZud/bBv
 Cgc3cg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqyam8n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:10 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b3b63b9665so1541896c88.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863829; x=1795468629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5qx9ReNrAoxxsC3psJtihDc7cCPbBm8M1KxK4qsTLrw=;
 b=JZcHtxOOd7RKz3YdYzng6cgQrbK7XImrR89qvNqK/yyohxcV5rW0SXNLSuN8cafhXD
 BZah5CLuNmvD6slcjsHH6Jqy1GOWJaI7PWcbU6qCnCobOqtGdoIQhEhEaPnuEtdaxlmn
 Mu2qF7KvFdgqwvE7+BbyZjP6KIXsrnnwfJHG/n5v5UAYe8k5jZtaojXznYXL3jJDn3Jx
 44FCnmmvdZAy5PVYQl1KmG2Va5sFsJX+yT0VnYr4kDsOsnn0xJyKhNEB4TJ1OsaIg/Ej
 kI4z/WQ8y6/4YxNyJIe5+DiEK/uJVUnwFB6tFTaiYydgWpAiP72sNO/UY/8wEZ1koue8
 dgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863829; x=1795468629;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5qx9ReNrAoxxsC3psJtihDc7cCPbBm8M1KxK4qsTLrw=;
 b=SOg/yL20aFyBvGByV8VdXL4AernnbCTP9KLuUbRucGu5ASOjMW8GUaKDYxVNMq5/kE
 sjI2woAhf5Mgy4SnBJM9Y5DsHRxPAFjdUE3v3cYFZEV1RmCaZSfnAOQvVdBHNz6v0/0g
 EpvDgNpriW6YXgNv/EwSUBdsYNPdW4P1RFxVq55a5aI8+F4fRADxZQFWlFgRo6aKEWu0
 SCSTdK4SlujV2dp4KKhtluTfcu8ajvUZht9MyzXdF1q6uBUC62VLHKFUeeAV3Ex/S5K7
 IgRvlzfUq4Vkvb+yaDdRHaKi3CaboDL9zTdGPUsFBlgE0pKcVn3WpTmNebMqKLnq9Mvg
 S7rQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHtlWQeEoeKqdewvJHArTDxBB0l2grZOj+mFjL6mWQ6TuQrNj7aSuVniRwbsOQTQRxHiBjSA4kWgUES@nongnu.org
X-Gm-Message-State: APuU4Z9iKp7fYfjbZhhinH0f3mDNat21DAE+0qi+BS7TMdi5Fm6+Za+e
 JMlVECKasFI58DItIlf3lGBB0b5Sqho7AX020OPDu7qOFBHNRh6yxzFb8S0oyo1ggWL014BlAoE
 IH4Yk6WYCPvSXZVvG+Jhb49Gq2yFy/93JlcGmK7UohHoEMX4kMQFNuHVLjA==
X-Gm-Gg: AYBFou3G1fpkeRXiqyue0Q9dlM8c/2zd/aEXwZ4ALjrEU+u2HaFech5NvAYdNifcJUv
 2GWWelcNoUHHdFOfGlQ6UfJ/EEmY481MI1AvA6wsbeJCqiwrYOStahYxxOQSWSu5aGb7gDk3hU6
 1MehOdsPo+dLDDdAHi7TAQ9SrgLOlNhKlDI2/LySfksCQP4aB38Bv31wMbmaBozIpY/tZTyMkhS
 BnkiS99zBXIbDdc3BunZ0WURMoHdaOHAqpVIH8wIeNEmnw2a+5yFoZ60VkD77TSBmD4k4z31v3+
 4vrSCO+Us+rRaxV37/0WKbDLUsT2o4Lt+3BVDRtDCs5hoD7BkI/FtpTjMt1/F2C5Qg1TF/HKMJi
 IIe3QLQJpskEdcctWiRk9yM4n5qGdTMRLju/Mv2tEXxqQgOyXryDJ+31B+GGUyjkGHVa1fpzGYE
 iMt+UYxlj9iFovQXOE2gize5efd+Bt3d7ll/Z8UTIhbbQ=
X-Received: by 2002:a05:701b:2706:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b50312144fmr10667979c88.29.1794863829257; 
 Mon, 16 Nov 2026 13:17:09 -0800 (PST)
X-Received: by 2002:a05:701b:2706:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b50312144fmr10667967c88.29.1794863828752; 
 Mon, 16 Nov 2026 13:17:08 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031bc518sm32799036c88.15.2026.11.16.13.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:17:08 -0800 (PST)
Message-ID: <8624fe52-95da-4541-aafb-c727e95dc6d0@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:17:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/48] hw/m68k: convert machines to use AliasedClass
 interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-18-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-18-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX+Z8K91kooPgD
 WITkSXkPWvvglNCkioayGd+7IywjWJmGch53qzUKGij1AicEaWAJuFsNft0q3YYanQGeIdDoEL0
 +RRh2LgbLP7v6aKPH4Wmsn87Nd+Kb4I=
X-Proofpoint-GUID: RTy7mwMIVWo90f-cFlY0w2ZTuUC3g7yB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX4rfVfAz1dvR7
 AA+hFWc2K852tOF9pcWDL3zoIkfIAJzurYj1t4YTpinDx14tJFr4HUD3sIOdKdMoNTn4M8dm7Qf
 K/xfv/oIWIwJhq7F52ZVbxDGK2z4bqm4/bgqq7v5e3cn5i42ZCKPyhEw3cJpGNKEG7SoYhWZ7gV
 e8iq47jKfFrKRQ+qAOH6upiXfDoEsfSV8xdw8+OnroUZJwWRGQQR9hYso0pDADDegQ6R5q36Yyd
 hnWzf29TUv1wcOabCwhsOBtXxf3IcoJCGAYChEThHR+K1vJpd7zTfrd5TlDj0cdPfng3kjq0zqe
 Lb6JDiLxOfNLjGksw5k7XPuqqaW+Ztqz8OJKSNRudibIBtY7s12pX0ZNXD0uJaBC3BV2rrR93Oz
 t6HDuLlTTAjvHGjb/gBcmxX2RiaXL9IQq85zwiOnwDV8KmoDaQGbGLz8gQJf63d0zgYGXMm42OG
 94JzN28ZNDUskcEVukA==
X-Proofpoint-ORIG-GUID: RTy7mwMIVWo90f-cFlY0w2ZTuUC3g7yB
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afb72d6 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Kqo8LxV5-QPNKTeuZg4A:9 a=3ZKOabzyN94A:10
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
> Stop setting 'alias' in the MachineClass and instead set
> 'aliases' in the AliasedClass.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/m68k/virt.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

