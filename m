Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66E606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aNdKVf5d;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MUlPFUNk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVYSh-00074b-Bs; Mon, 23 Nov 2026 13:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYSg-00074T-FZ
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:08:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYSe-0003Hx-OX
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:08:17 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGH2Yh3475220
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 45nFNQxy6J4a8R2dI1p5Adv9QP26d2Qy/4hlNoEyctk=; b=aNdKVf5dUWbXSt1P
 TVSmvYeBhoDc+KUs8l+bEbJ0Pr4qitMfSom6OKcQLC7faJuty2QXohN+NB0BvK9V
 aE+9hkEEJG45gjQbkBzolOuWu3ZDtix7Isl3DX7NN5+xyuO8KrLBrBeRYcEjkqkI
 BW+voi7kDhpPWQ+hvDiCbo5L9fOcXE2Ngh5eNpXFjtNoR7byxOwv0cSzcq/cZrf8
 fLopBJaKr3XhrD4k1G75WoIBKZXm312bDr9+ZY3BL+Ze3XLp72p8oWuxkXx9bjNN
 +eYAmmzTd5jV6WBrvK7LBrCwrV5Sk99eqKiMLmqgbWnklqv0pB9xEh8nFmW6CXZM
 rgoQwA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7tcby-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:08:15 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-386a7af8b94so1619842eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795457294; x=1796062094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=45nFNQxy6J4a8R2dI1p5Adv9QP26d2Qy/4hlNoEyctk=;
 b=MUlPFUNkGzGz4W9LnlfwSg5dn9DJYTotz5rO+u/5HBvB7BwNU1SX47dvhO74xfc3J7
 8DeShAHzUHJWBjszAWrzJmS/FAagfG2TzB9fHDtvtGSHcoHSXLwTGHRTei9nV3zQ4Z2x
 iaZNJpW+BjN6TtWWJM3e5Q8+52WTULGujT197XUl8Kev3Q8DIxl5FVN9u1AQZ6w7qJbL
 lYNUU/jWMSH0AC8UOuYyykquZslqX68cyS3A0hA+qBw64tbt7TERm0cPC9UlGZ+MFb0J
 Jd0aE1uk7FoIGyg1WVIzY/TXHcSRPYzXFZTSPwQZ9TNNYdlQxPYpCDwa8NpFkcYPwy76
 cqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795457294; x=1796062094;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=45nFNQxy6J4a8R2dI1p5Adv9QP26d2Qy/4hlNoEyctk=;
 b=eIqaFaHDlZVoBiDme3HX2HdHK1SL5B8AYbOX3NrWLuaZtbNf5wLAWD7DZKcYPrktsY
 WJ5OVWY9SPH//6R36zRl8rUlK7RDSwK6v1XfXEzBuEM6DE0p6boGA3p0g2aKQvbnZGAP
 OtWuGhQTG0qQaZ18KPg2KODifP2DmRWbw7wOkvfumznZGAgBkvwIILkVW4ywsF+H+Gro
 OCNFdZUpj11mjNHbc84TeCKDtYAb7av3z7xSqyOYSs7f2MowvrUUAnJql9Y6g936/Est
 koOWVmbgPG95W7mStCp1sSnl8/sZ1hJYXkt8ld4l6/qO3YRJQIcyoBHJ1fEen7uEraok
 FWbw==
X-Forwarded-Encrypted: i=1;
 AL+hErF3u9Dq/AVJeJ66jOYcfybZ487VUuyvE4U7H3HiT/4IdyuM1l/a6gq10Wk/cSscRKYM/6iTgaYW/K6O@nongnu.org
X-Gm-Message-State: APuU4Z+rckkb2jsYril+WIrZQM5QVkKITzvtxDmGjlbOIPChDXSEk5X3
 lGExNe9e/Fh5YMjz5ycOqzMkXGzyJBcbuFLe7HSe0GCziA71WFKUMrHViWLVZw3NWxg+when15g
 bdDMlYqTa6GPch6+Myn+joynBO7kq79dQHWHKZXOgmXjXXe2T0q7T8qKwTMz6S8gNFg==
X-Gm-Gg: AZFdTZeGkfQI1zZiTH3hqiHJUWG6TTSfvBLpns9nZegXpNvh8PBJk6kOE1dSmov3bgR
 r/1l417UCsXKcm3jkmIqkbWdGX0LLZldFkUS77YDC9F60u0wZPmx7hS2aCeKdXI1kJw9yObSTdK
 8MZsZRFnpWlqow6vons5HsqW9BxYa+0X5cT9ZUWIgcvFDtMoefgCNRwJg52zbPqJ/iRTHiiIUb/
 mkYKK3tB3cG8i6TFZcrmkTWAgDB/GwaRes2SJO4yPMWMz8rVsXdTLUGmQr9NaPmhxeF0qPyrifS
 uQ5CA51+PO2QNTYQ4nSbgFFNCLRi+iRPfKM6TeV1l9xY/Agi4dnoNZNajGO4FGUA3KUhQNOPuEu
 dGYaBBL29WIjGwiKihg0lNOyfo6whFPYdEYIK/8352MIpWrMULGiJ3s+Cr+8G8ABvgK95d74l3O
 SlVo7evyD2fmENJYGXVrA2xfpPKqDBn2piLwb1g1Yf3MU=
X-Received: by 2002:a05:7300:88:b0:386:959c:11ac with SMTP id
 5a478bee46e88-386959c141bmr10979833eec.6.1795457293840; 
 Mon, 23 Nov 2026 10:08:13 -0800 (PST)
X-Received: by 2002:a05:7300:88:b0:386:959c:11ac with SMTP id
 5a478bee46e88-386959c141bmr10979804eec.6.1795457293299; 
 Mon, 23 Nov 2026 10:08:13 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm44428095eec.10.2026.11.23.10.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 10:08:12 -0800 (PST)
Message-ID: <99b3b144-6219-4676-a922-332c5023d83d@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:08:11 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 11/12] hw/hexagon: honor configured RAM
 backends
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-12-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120182031.560481-12-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b04810f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=bjMIgEwd9pQJBBK6TcUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MiBTYWx0ZWRfX6B3+GlH4T5vK
 Q4QRFORrx6BXHaOwIKTt5acDi4mPIFUuS5EYqx2odBbRAo0oKt+NTdamjaAoILZwywMCiXbNqK8
 3HSs8WMwVqCVS611OUUMzRGP7gxlRqH9KoiqYzNDpMydbApT8ZFQbSA/uJgpXlFmKPz9LUbRf5q
 ADNhQcYwcRj7stFG7CPQ5uPcdDK3mBOenbYSUMO4Le72iD5baM4PjgjvjCZqcIrQw8I6d2Lg91J
 D3T+rwQRw05HElrny45yQQ3XNgfUKK8qIJB7zTHag048g5K7c6n2JqDzcjHKGAWw4GIsBpTgy3s
 dBdnlCs41seRqoQTmVtcMTGKLFU6cEW+71mQ3pbQBepH4NE0o9hZVdhDsmN/pwfL8ceB/dNZF4f
 np6hrQIOG8+Fx8BJhHE+srtFiDEsZaqh4Ok9JdmP1X5HyR811+5DqhB7JJ3VtAn22Pr9V/aYH0v
 cU0G39zA048MinsCKeQ==
X-Proofpoint-GUID: MoAszwt7t9-Q-KJLwksUdUtC6hV1eRB-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MiBTYWx0ZWRfXwRE2N68cknrM
 GwAb4P7aaoTnSe5JcrOqLOuMpsDbsKHh9VXEedJervKuFaX020k5TWbRFRe+qHBpQZt4XCpyV4S
 ymVORJ5JynMooQIdAKiVAZ7kvySBoAw=
X-Proofpoint-ORIG-GUID: MoAszwt7t9-Q-KJLwksUdUtC6hV1eRB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230072
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

On 11/20/2026 10:20 AM, Brian Cain wrote:
> The Hexagon machines consumed the MachineState memory-backend
> configuration but always created and mapped a separate DDR region, so
> a memory backend given with -machine memory-backend= was never used as
> guest memory.  Map the machine's configured RAM when present, so that
> file-backed and shared memory (as used by the migration tests) is
> actually guest memory.  Keep the board-allocated RAM as the fallback.
> 
> Add a regression test that writes guest DDR and verifies the bytes
> through the backing file.  It fails without this change.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hex-subsys.c           | 10 +++++++---
>  tests/qtest/hexagon-config-test.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

