Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8F606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bshKkwww;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h5S8ellY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFJn-00072B-Jh; Tue, 20 Oct 2026 15:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFJf-00070J-04
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:16:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFJW-00075o-4J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:16:06 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI6gou2223941
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0lp7fjwlDw1znmVHRswMrWxDPhkzBJkpKVxzNr7pegE=; b=bshKkwwwPMfCYVnp
 XYqB0p7hE5I3t56HXoSFNXtGkXPuVM7gZ6+Yq26gJL4mW2+HA5Y6bWXHqtqwN55O
 NRdBVYEMtPK0jOHNLay6apCzqP+Y8KHFcZ/DZCg2JnGnWy21DU8Iy32lzImM/bEN
 WHJXmb6aVAh1RzLGJfpBUIFFdPExwRtEo9f+hOJUx0TDn5Jhpr19Bkbp3SEmXiUd
 vVSpwwLhfvTEMD2CAOnpkLSU96R0yumzU7qBhHP+R0Uto5mR4Eh/HTiqcSqgg2+f
 DfsvyZEyyu9B7z5YgRg8yZbG/MgAu39ONXV08sowNUgkXuY33ZT9RD4+g8wdUJYE
 lgOZUw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v08gk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:15:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-366c279b454so1270026eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523756; x=1793128556; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0lp7fjwlDw1znmVHRswMrWxDPhkzBJkpKVxzNr7pegE=;
 b=h5S8ellYjW2LZe9/hiOyqHyFJUmBjTh7c9ByqC5Gn/DtznxTfQitPr90JSKrda0dMQ
 f7tcPbHfMOeuGjaozl+RNPdZX8NYb0nSkGPfXqB3mTpdWkyV5IBuwLFj0T/kGJ6yRIoM
 oD/U2nHGsdWej7ACxHcUX4XMtW3e1Iyu2JNPx601usgBvrGqD3nRUit1zehf/EUyd4Tf
 2oM7YRkiKp4AZA69dhkN5KyQrpc4ph68TT5LGzduoFiZYiikNdAeZNTvE4sFJQH4ZAlu
 Xt9zvKQMeE+9bomhO4qUqxH3qpNXXrAtPONvJJcu4RAECWJjKeGBiM96RB9WMwFmAQh7
 kJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523756; x=1793128556;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0lp7fjwlDw1znmVHRswMrWxDPhkzBJkpKVxzNr7pegE=;
 b=ewMRQ5sOjL7W/tgfWXJhUbO9tJWAZBYzY6ebtyTygRdYu2zRbS1yqqcCpyT/nCLCG5
 M1lpJZzIbyg+Iw+UCD6MVFq10yuBlIrYIusCUdxp/J9zMN7qTjedBvivmsrUTZtEggfT
 Rstw6/Cuq2xu8NZ2h6B+BIWTgYthQlOEQ+mZnO0T/Mc+Or448GcfqNljYNLBGVxCiim9
 76zFTv3jIlEyhnmg0T3G4Si5btCIGGICwaQEfcxZ5h3pCwl4vIMiPiKElSEaIucHXJk6
 Wkl6t/9CFGSyTQSUyDGqlQ9h4n2MOW+rjTnPVyH3o5q29wbSaQWGKis0mEUsydzZhpcK
 gasA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsGFIoysbqKUUBMVqwDQX7PEfPnIn+Nh5PgCdzF64pRM01Bxv3XBkquNUIwqYXKki2qlWZqQhwDzaw@nongnu.org
X-Gm-Message-State: AFq9FYJDGp9kfa5h9vkXYITQJqoSHYEjHScLT5Dn/rW3Uv0sE31A9ZYW
 Bi5bEV/FayF0RIskTRdSapaj7r3isem1Zh7rqYUZrZ8H7h6q1M8nBZPOFeyE9vwFL9ufYv8qk5+
 WFEkF0DPmBxO+IM0DvvPnDx/s2yOyMwSlgLTnqmt+JZ0eCf27Gy/LGFLghg==
X-Gm-Gg: AYBFou1hxnjW1e2Q/4Pz55d26/mE0Fk7nawkvqSCgNJaN6zVJIzMHhqx7fHWlvG730k
 ivEqpoOODo6afcbWiAqa7rl2d/LjGiKjgFDcAJdUJSS2CInPQbM1kSRG8TQ0gpidviKG0sHhjrV
 hjmGh9srYhLFfyJoulRN13xEl9Ld2G03wxXvsYHRqdKXSJfuvRkKcQ+mgHuUHJr/EHkUM+N9rY0
 0xW2RT/fqlgtRKcYe6AnTwZGsnIhh20neGeQXvJ+n96oNxuka3Qvp+JgOvhSfITuuLBGDpiGeON
 YqpsTClY6/mhRTWJakwcFTqwAFPPKSeLJFEGHyfZrGoGH6TY2l+o5gjxLefaslguON2R6Gyvf2c
 /YprllJ+3Avef0d2wvSLhTFYWUiqZF1eXMRNxV3k1IdEuo8kNIe5zY7f+aRqJfs68naMvVQ==
X-Received: by 2002:a05:693c:4199:10b0:35e:1807:cedf with SMTP id
 5a478bee46e88-3674a405bbamr320233eec.1.1792523755967; 
 Tue, 20 Oct 2026 12:15:55 -0700 (PDT)
X-Received: by 2002:a05:693c:4199:10b0:35e:1807:cedf with SMTP id
 5a478bee46e88-3674a405bbamr320183eec.1.1792523755281; 
 Tue, 20 Oct 2026 12:15:55 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367411bd27dsm581604eec.17.2026.10.20.12.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:15:54 -0700 (PDT)
Message-ID: <a1b4f96f-c7d6-4cf1-ac54-04e7dd8d3b25@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:15:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/27] target/s390x: Implement and register
 CPUClass::exception_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-22-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-22-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX8uSe6+VbkjmD
 YWTtvI0kherYBd8TCsoriSSJzl2FbgsXOG1NKNHLwQbZM9PhrNPZQBGvyIH72izWOD900hryEeg
 GKJ4t7/gGLirZB0FUmiW+8mxqaqZ3DY=
X-Proofpoint-ORIG-GUID: vSZVOOBHoMpGriubHxwt05IluNwNpgnk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX6VUtwxxUBfGi
 07toqiV1Rc6EkdkxYqEzpa1wILD8t4axuGB3dSzAZFWjacm6vNrYPgpgI+WKCHafBX6616zlS5V
 JQ5u9emMwUW5dZ6t5RysQKor7G8BBG55mXtoaPYyN3IcuIdi4pM/K3LiVNvXYGHE5/ccBcF2MHV
 GKGuPsQVGAsza9zoWpAIe74C+vJhtHamPysDGIcXzTyPDQ5yNBFUQwHEEXDi9r6O/71BJNsiwpJ
 77ZVzkyCF5owfMDor4TkMcfLTYhQuWOn3QtJoNgijfBvRZ/c5ekDXRWVLBRkdXimX7+glQoKZ+3
 uwgpUS+8Y+N/yVq6l1ZBQEmyh5LxksMm6iciaQSAyijtmxr4DsoTpXGCcmjJdfOrDyoD43196oX
 DCwbGOLI9EE03KoDLNFjMtFgrBmsl53tUkqPCXp1cIKHw9BUk1pDUz0CvfnY8xDODQPkErcK1tt
 Pblf5UM0c6I+vBJw52w==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad7bded cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=wiZgI05vafPFf2zVcEYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: vSZVOOBHoMpGriubHxwt05IluNwNpgnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200076
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

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> Implement s390x_exception_name() and register it as the
> CPUClass::exception_name() handler, so the common exception
> logging can resolve s390x exception codes to names.
> 
> Use the new helper in s390_cpu_do_interrupt() and helper_exception().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/s390x/cpu.h             |  2 ++
>  target/s390x/cpu.c             |  1 +
>  target/s390x/interrupt.c       | 18 ++++++++++++++++++
>  target/s390x/tcg/excp_helper.c |  6 ++++--
>  target/s390x/tcg/misc_helper.c |  3 ++-
>  5 files changed, 27 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

