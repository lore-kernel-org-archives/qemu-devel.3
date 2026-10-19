Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA42606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RB3oIE98;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HruJ6KCI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIveM-0003X6-E7; Mon, 19 Oct 2026 18:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIveD-0003ON-Vl
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:16:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIveC-00023m-CN
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:16:01 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZjGe3762658
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QDC+0Form327/Ed5qPCn7u0tggGMxzr9PgZ+jdp93rM=; b=RB3oIE984DEuzsTt
 CEMqJz+SdLMtFhwXkqtgFABsAPAmFnBaHqn6jikE62f9zR72z6i9tBVqNF1uX+OZ
 8OmIdhVbSfuKOb832ntENrmWE+4F1KkM9GE0GqMCnwYh0WsQL5PhQDoLN2K899De
 KkrK2SlE7t5W6Vt/w+cHXF/L1HszwaAYJAoKoYrQrbIXnkZK+revk65ARWiq4U8W
 /D3ap47P3YYoLYgaWPuu0yMvWm1RnfzvQ3CeQcXLEKVyvwnLPnlhrLkvDa+mq0Fu
 WvJmb8oI1QsM6UJ9OWlWbqkQ8mJfVSRKTx424wUw7koN9OG6iZDzVOiIvPzhLgvo
 nf2GSQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdqtf8y4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so6515448eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792448158; x=1793052958; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QDC+0Form327/Ed5qPCn7u0tggGMxzr9PgZ+jdp93rM=;
 b=HruJ6KCIXBOuyhpWxKXqpwjBYx8oTFDhJEcCibU+KgvxtJHyydv692JxOTRzPDYjXc
 jstaoYQ9IKsA67ANJXMVkFvXugGlvIU9skKwgy0p76NOEe2xFLbhAVqlTc7dcn2V0oYI
 WNncTZZYz8YgnNVUBijJpG546kB22kBaOb8IO8qv4kaSN1fCzHjeQI51F5EBdDRrHD0p
 C1AfHDS4DoN/22ybosfI1su3Rl6wkgRxTmGvK0rcVBeDF78w3Rkc5G26NRC01OeMbAof
 b7OqMQBU8k4VNOiP3oSTO6Y16QLJ8drDWzSOG+B6W5hX0BfR9qWFuRX1MSOlo7CJi/sW
 TZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792448158; x=1793052958;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QDC+0Form327/Ed5qPCn7u0tggGMxzr9PgZ+jdp93rM=;
 b=z13bRF92eM9nKwHcbIAvRaJ1cs12MKesbOcbM53/pS0PvmTCxDnEfsepeo+zjMCIHs
 GTVOwqdQwWyLQWqsOwEJc7THGBLYmj8nWJFEOk8Kzg6ZKBAbEYoayStDqj88RgBDvh06
 KNIxkKkFPxApF0fk8gPgR0K9l/RHVOUwODHtzi0FOnKMd7IfeeSmVi1kp2whmj+/YZ3D
 THlgw4dob2ivFyvSGVyG4bsxLj3jdOdwojnESoM2k3MI8g9jRw0ZKKcwxZaJoWwqCAgc
 0oMnZPNemWLbCZneMiKJ9xkEfxzHQWuQo74OCLEhfMBpa1MgDz2GB/34eqQ+i2xmD+0x
 m6hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByiH+L7YOm5PHeEPPTSoMeQxSXDHbhzf4476uUiafiIKqY7NxSppqZV5UuXZsjZeJh9UTaQjVzP2kB5@nongnu.org
X-Gm-Message-State: AFq9FYJHpGVku7qiMUWFDJbJ7HC2+8DH+HwHnlvdONjyDplElbU/rzTS
 AMUICunrQuBY3WOJr69On2mWX8wa8jcevgGQNWPn8UO0k6/+/GjjMqQmw6G8w+pEqmuh/ozoBHI
 +cwq0Sw9Ui6oiHNWSvK6e+lDMZacNr5gBq6zJRGRItwkTFbL/Hm6wKQXGKQ==
X-Gm-Gg: AYBFou2YEb9AjSrzGUSbnAGfXJd9dv30uNZ6k/M7Af/xN4GFxg2ohJoEiMEPqDI4cG6
 vTkKyYHBZmsD4V0Kia8cAgdoYtQkghf+5m8pKjTI41J51oNAE2cDbpmPSw3qFIsJTDZR0P0AjgZ
 zBHEjtjxft5kaUJ8YmqSWV2uVfX5xOEpBlTD1zTRZ47y61skakJ4sTH4iqLi8765LjoyPoeJTo0
 zNZ/3EGFrqQY3TAkYTgoY2TRQWt0/40XER1v1hdFEadxle+YLLuzKHINLYvLgcW4I7aLL6UCPcS
 vmnAEuV9mE1Ef3Dh8htbCtC72l9cdS0JG9IjfCXqr1TdcBbB+hA6atlPGGDRPawJeH8DCXMk0p3
 56erbhpUsJqDkyf/VZHXu1AyZ0Oc0NjXMJDwXIGlAQj7W40CNpyT9PFVXN2IRytW/oKpkPQ==
X-Received: by 2002:a05:7300:80c6:b0:328:7033:9b8c with SMTP id
 5a478bee46e88-361a12718d4mr17318421eec.6.1792448158362; 
 Mon, 19 Oct 2026 15:15:58 -0700 (PDT)
X-Received: by 2002:a05:7300:80c6:b0:328:7033:9b8c with SMTP id
 5a478bee46e88-361a12718d4mr17318376eec.6.1792448157708; 
 Mon, 19 Oct 2026 15:15:57 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm58453842eec.28.2026.10.19.15.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:15:56 -0700 (PDT)
Message-ID: <ce1c15b9-286e-4def-ad9c-fa24a573594d@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:15:55 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] hw/hexagon: add the SM8975 NSP machine
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-11-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-11-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SpEFe/O0 c=1 sm=1 tr=0 ts=6ad6969f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KUsH5QWk89dUWP6R3sYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfXzKWs3++xjubJ
 n9tBd6SAFO5nBTnA8FtkqgqQVPEyE/PAvNkbT76JhyrUKzbLCToiCm8eECki0GBr24FKJIu259t
 dM2zFlIx6As2uIp/Uzd/gHSZifiDOZUeaoUMbR7AVDhb8fnNCuAUea6dMU4ZF8lOJYBLmMuxzO1
 vboKecJ2aHDKKqt6FARHzkYdyIs5LrLPDak36djnRk9ngWW/3Gw38m9oB636HG5EwYOkymFrEtW
 q3G6IOdMJ6Hb7AUqLV+gJ3nQer7nPumz1HCKGIsvk2MjtGE28DpLQrJjQksuiNP/RqCx1vKE8f8
 btQZfReYcZ0S6HMvHtLh2jbzPzCYyaj6vWTTDnLnh/7BNAbr78iphRn877FUYR9t/VFIsntY9S4
 ZYrBdgekBEDECQ113UG9KtUh29VgJcDUL0avzCQcd9ollkxEiGLpE2MFhFwq2Yoj5GlmiGbjTIG
 M7MmmCtS4NO26K/vAPg==
X-Proofpoint-GUID: 8F2s1TBZGw_u_kbPfK3DZVJpMoIOThLA
X-Proofpoint-ORIG-GUID: 8F2s1TBZGw_u_kbPfK3DZVJpMoIOThLA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfXzKaGaT6QHbQ1
 8W4YMKsK+FHnOzvHRBK4kV0uZXuwnWPtkYli46vWz5Nsp0Gp/H73+rWUy6i6bLtHQgc+fmPG3dK
 kBTqnxqKbHVWFPYAac71nyhGds1g5wc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190088
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

On 10/18/2026 10:52 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h            |   1 +
>  hw/hexagon/machine_cfg_sm8975_nsp.h.inc |  55 +++++++++++++
>  hw/hexagon/sm8975_nsp.c                 | 102 ++++++++++++++++++++++++
>  tests/qtest/l2vic-test.c                |   2 +
>  tests/qtest/qcom-dsp-test.c             |  17 ++++
>  tests/qtest/qct-qtimer-test.c           |   2 +
>  hw/hexagon/Kconfig                      |   6 ++
>  hw/hexagon/meson.build                  |   1 +
>  8 files changed, 186 insertions(+)
>  create mode 100644 hw/hexagon/machine_cfg_sm8975_nsp.h.inc
>  create mode 100644 hw/hexagon/sm8975_nsp.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

