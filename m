Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ACE606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pmpvx59l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DJgugGIQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAIy-00043k-3J; Wed, 28 Oct 2026 16:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAIo-00042J-Vg
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:31:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAIm-0003mP-S1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:31:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIkQXB2546997
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0vw5k6NjsXpGUaoLPveBLgh4RmER4oAIao57RKaGRqU=; b=pmpvx59lzqOwhMIh
 80T3iaU9cvnMOKz4ZhNohu+z9vHZstkoUbdrUv3WM9Cl0I0FLuqUqZH71LS8c78A
 5Knnoggk6DAHTjU48bN+L5rwcTNaCLrLDycvBWdrjecSHApJ4Po92z8/iOWlWYB2
 97Ryonmc/okSWi5o5Id6lYsDqzf9nv7hW/XuuITThE9MltTzDjnx3GbI/5CRsjkg
 +Q/URo7vqK6yiyfO9nea+NbO9fGD30EWzCcUe2THhx6rPi1uqnGqvNC07JjKPgeZ
 n70HacK9aug5X9HwUwltgu44JCZI2hRmPYeWJK1MP7Y1H71bCB8TIxodUhK+PIYB
 hT05kQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc0cjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:30:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1a2f2ea3c3cso2138871c88.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793219447; x=1793824247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0vw5k6NjsXpGUaoLPveBLgh4RmER4oAIao57RKaGRqU=;
 b=DJgugGIQdIIH5GBRRcDAE1FxhULeLl8YifjgHWI95AqBMdA7pEonUpm/TPTY/VPXB2
 IfaTWa+selKAK0ipaC0mA6udDUqjYSc0tmLvHSkSOH9UhTdcMcbLnQKVx7BOM6HKVAHd
 hC8HaH2h/oj/9OqFIhhNsoJjjWk82Qj8zaOmCoEDqNNqDKVoyb7Mp9JzdFa9am+PdSa9
 X2Xal1fqdjZzZzKUM+OtDaQMlGzfw1PCAdisX8BXHklyZ64VELnsC24/iyPvZmsWRuNV
 fFQ8sd/tlNsvp+Cm3q0rzbE1IXc+UsAnsjoSxXoNAYPfvgYJL9GUZ33nZgVgQqKIvLr/
 iphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793219447; x=1793824247;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0vw5k6NjsXpGUaoLPveBLgh4RmER4oAIao57RKaGRqU=;
 b=P80nF/Dvup+Q7psYfRmkoXF8n9gAQRxR+G9DfSQft7/4GjwwkQVBUUo6umHLvATr5g
 GBOFS3XLxGsKSZzeWawXQeSqmmdfHJ6t7eWIox9Gq2pJzvLardvtdfHBz+BEHRbj8vZb
 nS+8MPhDlnJUAY3ZDM2LNIARTmHRHjNYbAcPr393uXXjvi1Aiy0mERoewbwxbc31d/9q
 0HayPlyqfS2X2dg6pxzXZXxPf4dErQqh1uFReypERVKGjbdZsKx6/oWZeMJus6wT6s1u
 X2iKzGjxbLtd0uxs/pqYtLWnbEaewoV/zVZttNxFUq/u4xueiWxD0w8MeqjIGRa0CQrf
 gC9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhsujfMk/CeKnt24ES5rpif/CWaTL/P+wO+m7m+//ejr+MvsU/KhFRaq+oJqgf/lVzoVrD/W4a5Gdn@nongnu.org
X-Gm-Message-State: AFq9FYLwclLO32p48GIaPXPiDOTLqexorUU5N88uZEPwV7hXjTQzDvBd
 50+fpsXfV/+dU7AupAk5r37nmv+5oN0VkFkjBOV+AvFQ7eEtR2qEEnBv/huz8z1FDJlhXFgqPvm
 ADEo/qZ4OGLUaBgiLYF4puOUnHOyOATOoVPphvRIZmGlCdIA8zwjXq8ek4g==
X-Gm-Gg: AYBFou0fT9QAnA3eBRR4NJZmwO/4D3IwzfN00QgqT2P0dp6GSML6swD2ChIWohEcVmF
 +aenS4qw7GOcG+UmVmc50dv/HMo+x/whnjPnTAMY3Y/0u6L6LN9Ovap/JgRg0A7mNwhQoqjDV57
 X5UCuPEUZxQENC2uK5MwG9SDW4OQgCySkIGWXiF1xCPr/uCd333jK3w0Fps/oC2Cm/I1wYwDkfR
 WtJPTSQX6kzVUvOliGyKKTp/Q7UR16PsEMVU7pjCEd+M5zBZFDo0bQ65BTBvK7Gti8hBNI27DXs
 twSiAYZzMYgbnp4e+Ng7ZU+rMPq8+P8i3GXK9gd3xKRGvGDb4OGof03cjURg14xRvk+J1/TfHzf
 nRVeTTikfoVCrJejZP+M1TsuUZpowhNJZGk4bAEd7vZVrIAi7J/L3+CLmPUiFNczpkkOQ5jInRt
 zyV6kaSctvmNHT2coF1XpDs7E+QyKml5jAeTaVJKWbbm0=
X-Received: by 2002:a05:7022:3b8c:b0:168:e942:4e62 with SMTP id
 a92af1059eb24-1a6cfa0c3f6mr4560716c88.40.1793219446777; 
 Wed, 28 Oct 2026 13:30:46 -0700 (PDT)
X-Received: by 2002:a05:7022:3b8c:b0:168:e942:4e62 with SMTP id
 a92af1059eb24-1a6cfa0c3f6mr4560659c88.40.1793219446014; 
 Wed, 28 Oct 2026 13:30:46 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75c9fd2b4sm8244278c88.6.2026.10.28.13.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:30:45 -0700 (PDT)
Message-ID: <e6810e9b-aed4-4d0e-9156-159024012ae5@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:30:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] target/mips: Re-introduce the R5900 CPU in system
 mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae25b78 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kd3FClALVX0DP5VrHIEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5EdmItp2EVRAIAYZkALIZbRNPY6W1Ffz
X-Proofpoint-ORIG-GUID: 5EdmItp2EVRAIAYZkALIZbRNPY6W1Ffz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MSBTYWx0ZWRfX18ugIwDgH0cZ
 3HLYK2vYLb0J650tZoVBGHOCC5HLx9FwfXZV6RQ5MdZLZT/880z0wqHgVCG581PzjMaR2z25+ab
 0sWM9p2BV35QSttOEhOFsT7Xhu7TYVDb1IZNdt0/CQtpbwMwZqHNOqWePZyUmfRwMqoTBLxPQIh
 qwldY2z/gA4SsnP2+iTfXjf3RuRkx3Y+5Iy1cKigE8CPjrEOMPQnrBvFfflFfDLGhNkuuK9ycNe
 gwC8NrQjRibHA3dMkzBRrE0O8GkC9urV5uONkaWSf8xMxfXoRJ3L0f1ScZfQULCVHRmMoOl5INo
 wgy2g+no432GmmEn5K+RdDZcNwA4/vfN4/pS7w8CzmA6u7DScP4u6gFUcX80xpn2zhtXOpv0WUc
 EEmbtY3WEoQP0dlUxLHuIQXLhBx3nxAV/N0iT69ECm0YXI+f8oS3kMgQgCeiYTjwNYSdiulWCEc
 G8XpjuB018bQ7zXxH3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MSBTYWx0ZWRfXynStZu8oszIV
 9kx37P9rrShycs0U/1Avo5LwIB7HegdEpSr+060XFFzgpUEguyuMEa2sAzoVy5RRQsS1JwHuc5y
 p/ee9/zi17imfNd7djT14jyA3SEPVVs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Partly revert commit 823f2897bdd7 ("target/mips: Disable R5900
> support"), which disabled it over ABI and emulation accuracy
> concerns. Those ABI concerns only affect user mode, so keep the
> CPU unavailable there. In system mode we now have enough of the
> CPU (MMI instructions and bare-metal tests) to use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/mips/cpu-defs.c.inc | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

