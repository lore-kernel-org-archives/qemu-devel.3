Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF4606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hiJvWIH2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iiGGwlBu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLi3n-0004Lh-EK; Tue, 27 Oct 2026 10:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLi3k-0004LG-Tn
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:21:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLi3j-0004HZ-1M
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:21:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDo4ev2881616
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GsPZyrO5OjZGcpHahOwB5xBhKLN+ZiVAg/NShsBS1TI=; b=hiJvWIH2sgKWRPZj
 fRq3aTo1ReuANZ5+UhGJMZhmSpEQpp9aiKl0BXOCSpQTo4K1yBJfpO9IuHkdfC6Q
 VX8+rsMSAHMW58emVWI8RLTWx7TwSJH8POxHdbPtHhned9rb9NCWwULn2XQifdMl
 Irm7ij3p1HwluWJ1Dff4BcPfzP1zNW2VvS2aFhwPcpv9jv5LgIz+I7Ffl09WqENX
 IbvF69L5x514Jv8DhzWQx8rwRkdABGLKpa+7sQ6tOmoHB6T6D6yVovOVfsm9lsWL
 x3hrzHtpUMGcgD9uOUQ35bP1UYxEExTcIKs6vjHD0fR03wdsu8mlIxRPmycPODHw
 xy4h6w==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtaqcv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:21:49 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5ead18311ebso1066311e0c.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793110908; x=1793715708; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GsPZyrO5OjZGcpHahOwB5xBhKLN+ZiVAg/NShsBS1TI=;
 b=iiGGwlBuIqlb79ECglEGGjhJGQMx5Ry3W5GSGPZ5zZSlyIpxxf901SxE6sZWYjKMX9
 UrY87Vgypri5Vh9bA7RdKwCxisRCbAfOy9IAof8JBFmMY9ELgH+xZHDcSFyK5T11DYXk
 ZE6qdmQYnqGLtSXaJgWHmDqcU9Q5ZJDvKFbmhvGhSOUEfljMI2OOg0LxSPJWGWi5n6Bl
 xGqCLKDfxOUtjyvhZCL54iacnr6BknWu/uVqB/f9XGXZS3hIyRadIJ+9SLg19x/ZVtHE
 +Z3yXamBdzMj5G9wAUVepWStvjhLC78+EdfcFIJzZDNya5AHPeEkO4Khgv7ie0kKF/nl
 frbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793110908; x=1793715708;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GsPZyrO5OjZGcpHahOwB5xBhKLN+ZiVAg/NShsBS1TI=;
 b=RnbJUjs/kx+3KWHVJ9N0qpmrPfdMKD7/eraOAW3r+7b8CZHTiRdp163EcR+BWRXoO8
 AftyOBQGno9vYWjR9TOIxViARWI9AjlAv1yX2ZQoLwqppMZw1CgNEAD+SNAgeFGvO8HN
 5YMX+dD6y80f6oKLPkv6Ee5mTAm5OScPfU8QWLJ/Rib8jf709KImdKfFNbgoJlt7hePF
 wERvFlOzDLsHdLlXmm61TivAjCEnygiLSuE1tqRf63nfCOQxcDl4+WwhZVTo9/f2dKe5
 gr1ff6VYnEl9WivGYQQXW/7YDVB4+5Qy5zEpod3lsvn4HbZD3Hrx1XmPW80opEuUWT2f
 ETXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNzlzXPlBzKDddyyNug8LVwsszp4+f70yzVUEXq4mjQOCVPbmX1GnPmXSr4p3HtE1Vm9kNv9ZYtvbC@nongnu.org
X-Gm-Message-State: AFq9FYLzNEqf7/G229x3mBsQVx1tNKnx9g2ubLEV6Hq6lMpvPyJ6EhP8
 Umv6DFF/iCDaE/hY3mVEjooa/gzqYj0NOu2LXoX657wM5Ly5t3Wi92wH+9Hcu9JV7gjYEsnWLN1
 lQrGiMJ5x55/k86jcggNCrDN8Vxb4IzDuwsQ+YsB+BtRPRmQM4rQWRFBHYw==
X-Gm-Gg: AYBFou3w9QTBPK4NnXXoaiBguUiTBdr2MstTt7G/vCgz5qZwa+yDa/5YA27ms9N6f4y
 f7w0k2Wlx5u1cCmvu30G3L1JZ49BBjKQwOePXXYJjzcP7YsB4BniCsoOOK6Q7vXsj0N0nUWz63N
 LvMs8VPfyhMUFZFOTH+3HNL4piCMNBuMjBygiHFIG2d2TSRqdcrlawN2I9kZAYdFBaVxs/VMjk5
 S+1vbORfAHUmS5939OYw0KcPNNV8uYGZi9S5zzPBdURBpzYcYJa/eTCzjhqCJRoWPIVNiJUUvxU
 UQhpQ722tyTt61sx7OcSqQRUFkBFJz6Ue6bSO4HMKpo5B3cNZtg7cPJ+DgCYIsDdbrtvj9pNCV2
 KksFK4U2gbyDBKo7g9KxkShvZNEZKTnrjoOPUIVJdADoZCsxYQg==
X-Received: by 2002:a05:6122:3a0b:b0:5ea:c382:af67 with SMTP id
 71dfb90a1353d-5ec232e5dc6mr3847946e0c.13.1793110908265; 
 Tue, 27 Oct 2026 07:21:48 -0700 (PDT)
X-Received: by 2002:a05:6122:3a0b:b0:5ea:c382:af67 with SMTP id
 71dfb90a1353d-5ec232e5dc6mr3847911e0c.13.1793110907744; 
 Tue, 27 Oct 2026 07:21:47 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8ddasm25327822f8f.48.2026.10.27.07.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 07:21:46 -0700 (PDT)
Message-ID: <735a348c-3eb4-4a9c-bc41-6d347d4330ec@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 15:21:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/31] i.MX fixes and cleanup
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <2FD6FED6-EBED-47A4-9096-D4FDF2F17406@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2FD6FED6-EBED-47A4-9096-D4FDF2F17406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NyBTYWx0ZWRfXyUb0Q5wIG6uz
 brywkno7mFB3BA2kKuLXwcw7Wp7zhLn+uLR8oLKE9QvL0VZh/qxl6hxpwVvDWqb5whsphQFHe0K
 KD3BBycZELxp2SFRb8gxtEWrhgMqFSE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NyBTYWx0ZWRfX9wvd+cn1oibB
 yyq7pa6Inhw8bdTc6Z4pN2KuzrcehEbgm/a2WVELOQ6dwTQrnnltpTbcBsEIIyW0x7Amo1x/+FO
 PHhBJ9goIzRdElEc0lABL1+QgGrQbe2kS//A2n8IU7ZnaykS1ZcF8FIhdq4qApCv7xo+y+JfJrA
 A0NZMEbn7X/xan6E2j0CuQd707qAHarFdkVg1JnqtXJlwLESL65prlYONdAJ3oVvcKkBDW/U8st
 WrDT5REHShVmIwV2u5alWsdbSi92V3vemIAL/+wh8VBft/fiqHth/yNVSaP7fluFmdNcLwZC2AY
 8qRFQXVz8MNojzrNY9DAJrc2xaN8QL+MTy8KpuqEbelMjRYb2hhNnAU8rIQ8tR2AgTdQ1Xi/ytW
 g3x6zflzlJ/fz4QLTlIcBnGFAtEsntlArQhXmy7Hx5/mSC2S0cAIl75AvNmIUaSS7reg6P2zwRO
 AUfy+/AsgDDL/fGMD3g==
X-Proofpoint-ORIG-GUID: B2CSWc1kNNPsg0FiuqvjMO5SnGbNPijG
X-Proofpoint-GUID: B2CSWc1kNNPsg0FiuqvjMO5SnGbNPijG
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0b37d cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=TcPvD2NeZe2R3Q-9zosA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/26 12:22, Bernhard Beschow wrote:
> 
> 
> Am 6. Oktober 2026 08:34:12 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>> This series fixes various issues in i.MX device emulation, cleans up i.MX
>>
>> Kconfig handling, and improves some code. Functional console tests for the
>>
>> remaining i.MX boards are added where images are publicly available, except for
>>
>> imx6ul which is taken care of in a different series [1]. Fixes which appear safe
>>
>> for backporting are cc'd to qemu-stable.


> Ping
> 
> All patches reviewed. One may need improved commit message. Am I supposed to resubmit the series or will this be done inline?

I'll take care of it, thanks for the ping ;)

Peter: I'm queuing this series (simpler for both of us I think).

