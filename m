Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D0606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O/dJdIDB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fGl79GCZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvGS-0007bW-At; Mon, 19 Oct 2026 17:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvGP-0007aN-FM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:51:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvGN-0008Pc-Ub
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:51:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLaC2v2892503
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GW1fpNUJLclkn+3BB9l2YKJthXO8Wv7M1L78Cl4ihjg=; b=O/dJdIDBnKAB1Rd0
 wyCZo1v34zbxiiOwQSLy/tC3qQxkOdEtgj3WEqUVVv6MN2BtSeRYWIjXehUfmRrE
 wvn71gKbPD/jAYRWYWR3g1IPlyQAi9SbtBewzvGzXyS7sW/yKvfnMRN57SP2CKN/
 zblisE5u48XJ6MWzqFLNgFn2CfGiFQUuXHHT7Mnu6AUxZmumrAhgGgXDydqZOdf7
 WojP/DXeejUVnLcbOCkgGAYu5H8iLVtCAQAOvzDEmGMCPWQe5C5DMF26h5Q+e/7r
 L9Y158mzcB4/8XT4pjUq6GpPzX8OhNl6GhDsEW+BsrXWI4zdfWzPU6STBW63rfN2
 lpK9oQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4a0set-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:51:22 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-155a75f91e1so110136c88.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792446682; x=1793051482; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GW1fpNUJLclkn+3BB9l2YKJthXO8Wv7M1L78Cl4ihjg=;
 b=fGl79GCZcJj9rOquLEo04A6lLRGnAs5OB9bQ6pVGrsaLpGWdMUZ3u1gZ47CV2ZemrO
 YTlQlbaKcjeoZwlUqAomJyklcBaLc54piU24vcRzEdkAb7VZDkeo7zKu3KjkBEkqx7G+
 XJ8NF7Q0rG1tY07Ku3IpM87CjiXXJ9mLdlA+xqbL8yyyEVUYsc07UOk7Cqk2yDuxQOMU
 0FqhCjvJUVRxU58GxGDTPLyds0UCaUEFJTtWnZoVRuePvz2iljkT4sSyi2N4qb5PboqA
 OzmjZ+ZfJGjqzfH5ypJ3Bw+7hlbT1TWVf2Siuc9+UntFAjNLpJzG3cPl+DhDKji30vls
 /rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792446682; x=1793051482;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GW1fpNUJLclkn+3BB9l2YKJthXO8Wv7M1L78Cl4ihjg=;
 b=MugIoOB62vc/NovFNZ1SxQTuePDAjomvSOWpxySa/419SbEoSWOkp6G9/IbxbZR/7Z
 J30b4jSAHQTBTtcw+GOBhfV1bX1oFQhj+MATdsDVNjXkcrV3JzArvIEh2c5BhpJZLsYm
 hwyujWFkORur4ZCw6jBE9dqyQ3taSquoVX2ZIAPsp+6ckeS/mbP9sgzl6WrWWvtKMB8J
 MakkaNQY/EDVRaVMgnXOChWYXbSOrkbScAnCTnTMflqiePb+REft4H83TJdEYcvse8rM
 eYEAtNPE9WatTFSsNYjVlzRVkRZwbQcdpfIVnW/MIBUjPA4A1Z2iHCxwZb27EZfcsYF/
 IhBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwS0uqLXfrSQm8RVDvWFa+FJdasuko/mxD1Rmgi4DRaDM1SCPLmVAjYD4QMXGrJWWGFd+kdqeMHPSNE@nongnu.org
X-Gm-Message-State: AFq9FYKUAVoJ3KeFzcGyWovL64ZWhddzd2aPkt793aXMbWlR0uNZsge/
 f8jyQLu9NgqVUFTQHO8SgHJ37pRdXvn08wEYjDSxxqehz0MXHWNXY72Stc/tE/Tp1vlXOlTA0/D
 gKmvkzImE2uGQ1w3rty3JyrQ1M902HAs1xMpUtLAjCPk84MGftXyleXjLxA==
X-Gm-Gg: AYBFou2xQ+YOFGOXR8ej4H1Z0WeNN/t9FU9ubHMFgeoNGYJUkkvlsomHIWMuioIbfBj
 0+w3JNXdLA3WOGt/s1R/8ri/zNG97mHZW+nuItT/6FV+QIdz9nEmR8lpLJQ6ontrHnbl9kWXqb2
 ltHy3upsZk1qyPwPzbjAiUf3SPIOLozKt36Cxqtt/ROidDBicYN7V7l5A6tSXxAI5lNa151C69m
 FdBLW2+dfbzKAblxhgyqUqYzLSKQbHQbXSfrpgQjAfGl8DiH9MmNyCbX/InBcDhOnKjDqj+hYzp
 mVH0ngiN0OsrwFglxrHqU9MV2eXJYe6PI1yQkOER1y+7jfuU/Nfil52eDeKWjE5cUUHfFBB9anF
 zduGkdT2rhpe5e/GY/kkD64iM/n1IA7yBEh0dUCgyG9uc2xNmjW+GXmFP7XEhkA0J+u99IQ==
X-Received: by 2002:a05:7022:258a:b0:15e:12b6:7365 with SMTP id
 a92af1059eb24-18db853ba1fmr641431c88.2.1792446681527; 
 Mon, 19 Oct 2026 14:51:21 -0700 (PDT)
X-Received: by 2002:a05:7022:258a:b0:15e:12b6:7365 with SMTP id
 a92af1059eb24-18db853ba1fmr641381c88.2.1792446680989; 
 Mon, 19 Oct 2026 14:51:20 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831996071csm31949429c88.9.2026.10.19.14.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:51:20 -0700 (PDT)
Message-ID: <b1d02631-9231-4a25-9d22-a5109475ece2@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:51:19 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] hw/misc: add the QDSP6SS PLL, RCG
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NyBTYWx0ZWRfX+Z7saD90MPxb
 F4CzL9713U3hHyn6hR7yVkrRvZ3aT8dL/s5uJiinM92o/PvXNr/tR74yyI9R1NVEaiD9aBxfCVH
 nrR1xvnAKXZOz07c4/B/gMyLkP4Bqxw=
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6ad690da cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=7emepWuvwpz6HSnhEhcA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: XH5OFsT51RftOOoEY6W9t8oQvSOuhSBI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NyBTYWx0ZWRfX83UqmOhNTpDx
 Qm2yQ+NxY17fGZiBwMIu90I54bly6/h6fPgaW9/GgVyl7dywSNOsVRg9YyMkw8x/DYMnRQy3yRg
 QOMAGXc3WcASWhJNe5jXwYN/6uFjb7gL5T0bpV0K5pF/I3vUCCpMAKNNpdi8yzkxckvklS0hrrG
 6rYmw6aVAH0MKEz2O0VWn5hnBD8VAXCbrRIx7wx7/BnnyNnUGPrgPO7y4MpiG0u5KDbGjDjHEXf
 3h7M3ok/S7oiI37xLfXEDer7IU5uhX6JkGxgRHyP4u3zNei+Fcqo4ZjeYwD2rEwa38sUNRcwoa0
 xTEEanDI/ol/Q4YfwO7UPMyRkjGVv0+y76pni2hPOESEtV9i/jnHRcEKucr4vfZD/T7X5q2S6R3
 Y23aQGLy5OZEu2lNvdaJTkgz6KgabnAM3Mcp9LCTfHZGgctD4ibs74pavU9wJuOiMIUJ20GP7XI
 7j/xjykUiAnCK42Z6VQ==
X-Proofpoint-GUID: XH5OFsT51RftOOoEY6W9t8oQvSOuhSBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190087
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
> Firmware brings a Hexagon DSP's clocks up by programming a PLL and polling
> its lock-detect.  Then it asks the RCG to switch to the new clock.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                        |   2 +
>  include/hw/misc/qcom-qdsp6ss-clk.h |  15 +++
>  hw/misc/qcom-qdsp6ss-clk.c         | 208 +++++++++++++++++++++++++++++
>  hw/misc/Kconfig                    |   3 +
>  hw/misc/meson.build                |   3 +
>  5 files changed, 231 insertions(+)
>  create mode 100644 include/hw/misc/qcom-qdsp6ss-clk.h
>  create mode 100644 hw/misc/qcom-qdsp6ss-clk.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

