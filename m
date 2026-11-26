Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3974606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E8faNWfF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DH99CQ8s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWiht-00086P-60; Thu, 26 Nov 2026 18:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWihm-00083Z-Tw
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:43 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWihl-000616-7l
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:42 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJvuO5360802
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BxSdQOuKti1TAPx9ykIQCZjHbbNaedzTWB7YNIIIW3I=; b=E8faNWfFM45bD0In
 ATW9qeJOSO4EZX4v71QkKYJcjkT2uX7ASKRQsXQnvTVChM8/4aByD1xmPpgH06uI
 Y4bq/47OsmlKTDWltIerPhKzImbk9BKLPBCWx8udwOi2sYlnfDHeTEJlqxqQOHUk
 1LRd2ZCq8T7JlSXg9FQDeG81AXaStEVTpwW3uvUPTSWRxAjppXr3kEXZs81hoLpH
 PoEejOSWinK5YLYSCPEM14weQzgHqcYlKt3RtkQRUby45xlSUhlxKIWeG196La9Q
 Z59qlEii38UqW3pyaN4YXI3PcDNBqpFHTdMfcewYRgQSGzvbF5Hq0EVj7lsL3qdL
 VMkLig==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rk4yb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:16:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3854627c1c8so10022926eec.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795734997; x=1796339797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BxSdQOuKti1TAPx9ykIQCZjHbbNaedzTWB7YNIIIW3I=;
 b=DH99CQ8svyhY8j2D+iAyrPdfWVi9pK5tUkOrSUSCKmrbcJ9kHUf1ejq6QfVZ+uGcaq
 cW4p8JUMn3LQ8J/7d4ztTyjRCmylGvz+OXqJrtmnc+ntU4dcQb46CAFmFgFgiWCwEB7L
 9GEuD4E3GJThuehjwLu2sdwdRc7buqodlLwCjMvvmZ3qm2LvjhKQSi/G9nsef6FPwFM/
 EQVRA+KPzzXpIVXfajeiPLBgB3u3zm4xzVWFo/8t3+FvT1FdGzXqYi2l5TQHhMHlbM+8
 HT7lJxlWDi2WzNzLoyVrrfxUfoqVJoxD0xeFkex99BRCmEFfWxhGYioG6BXHeiYd/YIV
 cqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795734997; x=1796339797;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BxSdQOuKti1TAPx9ykIQCZjHbbNaedzTWB7YNIIIW3I=;
 b=iR7a18kcw0K678bYgNJkb1dQI3zFdPADoIqsTmJwD+Wg93BOIWN+cqk/3LQhF+qFZg
 GzytpJfnUuTuVfn7ksQ8S9HhxWVmdsfu45IcmZj2UB45zRWNosnIbBIqrs5kSacxfJ5W
 JCmgwPI6yhlTPs7l5eTgaetClufJjnrG4YNskmiTg3w3ct5/fajcth3bM+50wiuKpswJ
 c20Alw1oC62mx1pJId/D25ZIVQC5/1JPq+mjxkxT70gio4t9qPpPZoSgsNrsHw+v39Ck
 t/qDSGFqDBSVa+ezduVs9md66dmdNrBhYvsgp6o3DospvvmUHMgdASWZ9sPJv9vQgWdt
 CWCw==
X-Forwarded-Encrypted: i=1;
 AL+hErHhegk5jVcthzR0nv5686fRFdQnNSPXBl5lbAlF6Set0k7dAHJ34rkJY2TT2AuPMYDceUocgkv6bccY@nongnu.org
X-Gm-Message-State: APuU4Z/Kf52LJfsI4svI+GmFqIBgDHkF/9y7Mo+wPEXjle1h6XCmd3II
 8Tvn5b6AZii+WL7c9wRNVaOBaMUdgDUAMPzDgWP7sYRct2MiAtu1ggqMtDSgm/zIFKwPLLHcZEx
 S+dzsxRkBkjLcjpox5cP4FCfAWEGHOfiNW4EiPE+eRdV384CaP5/2kkpQnw==
X-Gm-Gg: AZFdTZcOmflITlMZeNpcd2op6ZpFRp/9dZTvoG2Si9EiIgzdVwrxb9W5uhYPXQVlcZP
 X91Bmoy4KXWubHRCsx1WlpsbIr02qusALQi+SLa1cSB4fORNG3oDOWYZw2o0qmQb+W7jTOZ9wNV
 xDNjmOaukjNURjE2v7BaeYvHmBtIAjm4orP8zOq+jAJkgOn8MUPVk7RR6i1viNQAohBO7AMJY3J
 ecYn0wBjFGerYe9hVZdyMrlJELMsuPq0vk13Py/Irzwh1+R5jMkP7MYfKEpvy0EZoRPFkw846Hv
 LLyuG6dxt571wROcU2q6njqGSJaD1WQY4k/QJy1O7zbvt/PJ5KF8cpXqcJyd3GaY01g93VkQpRQ
 8r6K5CqDzE12xbtgqJA5Rv2LSc6j5jx8Nkh9vbhyQ/UIcCxNptWV992gyXt5HvcfGnhQgt3z5Va
 CSsa49etekm5fbaR3fI4DfvDWKtr/IfPZAHkpJbunpXoQ=
X-Received: by 2002:a05:7301:db86:b0:36e:2b8b:a098 with SMTP id
 5a478bee46e88-3857025c736mr21261624eec.31.1795734997317; 
 Thu, 26 Nov 2026 15:16:37 -0800 (PST)
X-Received: by 2002:a05:7301:db86:b0:36e:2b8b:a098 with SMTP id
 5a478bee46e88-3857025c736mr21261610eec.31.1795734996802; 
 Thu, 26 Nov 2026 15:16:36 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e96bdsm62203314eec.7.2026.11.26.15.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 15:16:36 -0800 (PST)
Message-ID: <e515101a-dc57-4f9a-b585-60dfbd69d67c@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:16:35 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/tcg-icount: Describe translator_io_start()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20261126211851.49019-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261126211851.49019-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MSBTYWx0ZWRfX+BJHvR7j/qLm
 0wnNQu1awXhTHZAHaLioIMPJCDIROGIX44mH26j0KnW4yjZRZSuRZZ2jX4YDFTaCzD1VnSz6z+B
 U6MWNKVlWE0NTFFxtax9ZsvnDB3yzlUpXM3z8i6sgdiAVAZlaiXhE0Em11umtRdVyN8bHrBjQZE
 rny3ELWx+vs4K+GZ/Ob7zpLsjGDA+GHS6q//0QwUYcR01De6ThIq5YDGzpw0e/OuHeBCFA4gpzH
 XhvBQMqWRdL/JL61BqzzOsGngrV5fd0KZKBvSwx78nLCb72+mnI6OLfJOOYplmpO3osV9/0efhJ
 HuqSV+RCc5xdMX1YZX7S9KgUzu/rtm+in1jxeFq6OhOCn7M90Ao+2b61gPJpgS07EIOViEcVtIl
 cRVs6YCJ5YNOTnMWExCm7QC3jRl1QgM0Z5EzaRHC99cR1/ErGK5TqOJ7C5p7xafdOL+oijikn8/
 0Jyggrh+jCoebIDg+ig==
X-Proofpoint-GUID: pewByOWimj4NKW0R5E5CiPtvKw85BQbZ
X-Proofpoint-ORIG-GUID: pewByOWimj4NKW0R5E5CiPtvKw85BQbZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MSBTYWx0ZWRfX5J3smX3QKNGQ
 i5LUsAfggfeS8wyBt6eHqHAsnRv9qv4nE4qNMNKEl2O06FPNbddE2G3XyZY4b+nVl0iAcrxOTQN
 EsBZN6XkT8IddwDHGvb2HrynV86gWIk=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b08bdd6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TEJpyHqa72AOjo67O1YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260091
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

On 11/26/2026 1:18 PM, Philippe Mathieu-Daudé wrote:
> gen_io_start() no longer exists, and since commit 18a536f1f8d6
> ("accel/tcg: Always require can_do_io") I/O instructions end the
> TB regardless of icount. Document translator_io_start() instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  docs/devel/tcg-icount.rst | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

