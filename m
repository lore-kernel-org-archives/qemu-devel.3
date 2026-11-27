Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80E606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o/9WcptO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q/41G67p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzMR-0007t0-3U; Fri, 27 Nov 2026 12:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzMJ-0007iH-BS
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:03:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzMH-0006hS-Ho
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:03:39 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFoxXR2617012
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lR9KUWcmNcTaFKUjabfIvmI+2evQdGRVINxlauJK4BI=; b=o/9WcptOIGdmjPBA
 l5e6hBNTvTW9k8QK2UV4KjL/zRGJE158eq6HmFsMMKgdNHqwHHrkFSn24HCQAjgk
 u0TfgDK/S5RLyqF9gUexnx+1rdxwMtpyWi2Bxo70CnDeleOaisT21evL99yHKCN/
 UW0/MLX8kwmAXoYshPoTX3vqC5PE/KJu/djYdYvbihG7EsqcpNOHX+agE/niIl8z
 pAbi9/FJ//0RAeEh+ZTNgsEGn/7aU6neR11iIRhCQlN+IMAKkfir1MbInkhI+7GP
 qjFNfl53lcajztXy1hO66N9xDEToN3ejNjcl1QKZQ1aiGn1FO3DVl9r17G/kJfTO
 C08g0g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4huygd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:03:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3854627c1c8so10857094eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795799012; x=1796403812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lR9KUWcmNcTaFKUjabfIvmI+2evQdGRVINxlauJK4BI=;
 b=Q/41G67p0WgWgNipTqbMnFq2MHHO36UD6/oMHM8kze8lrsA54ZHcDaTiOFYMH39jbp
 88FnV5Q0MYWK2pLGT87pwvldFjSxhYd835qOgHE/YwWGKEJHYuL5rTJVM6xPN1wY0oDZ
 m33FuOnuyUIeX3IuqpRdeFvMrFspMXA4+iKmZjRcXvVASEOlLGpNNDIn+Cy/QYSgyjdC
 yMt9I1BESQO8kdiKdSt5gLCDln6zrqWlv8p91/3iIixP9HE4jf45gnCwW5IT76vfIC43
 8JZbNfQEAaCZzDuPIv/DYfhZ2vJZmy+eGcd0Jbwfezgp/i8ajBXBSN3kpVw9c/RNs1Wk
 C9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795799012; x=1796403812;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lR9KUWcmNcTaFKUjabfIvmI+2evQdGRVINxlauJK4BI=;
 b=a2mSgplKoMvrFVBz0tIg7M0NldHi+SgC5kJIF96w81s5iiLvSkl/3+ud2ziUaF4tT7
 wQHbaYNctEOdD/uU5O3oVytJ+FFCgbNGSoIAh3kNnI1hAh0yTPifcWxS+ddkHdrD81Bd
 YyxIenI9B73fc8NrOwQ4W62hJvm8i0qPC+jFHIsIjsa3p2wkeq14J7VMyQmocI1wPV3H
 L2V+4u2Ji6zmPvRzE+y13UYCBB+W5R+s5kgMaWw/BFheXBQmBvrpZaSXyQIClwvYKHR2
 An+uNFyCJhxRDlP6FS1rM0sscENFvHzzJlv/Tsj4ZCxo8qrNLh6cFJpnHZhQX4Cab8KV
 oIhA==
X-Gm-Message-State: APuU4Z8oeBRQ7kflHDHQUInh6gVdaxkVfip1hW9aM/dUr8VkulNe0zJg
 T1NbsYUaD1NeGBiA4dXoO3VmkJz+LuYLtLY5emvTLQ7tZ2IxlzPnyD97WrZopVQAhGzU3XpNImC
 CFi6dASRp6wTDPgXmpHesU799o0XXdWaK029av9cGOD1GiDWhnNfZeKTW4kY6pvsZ9A==
X-Gm-Gg: AZFdTZeutKgcVktCU92EfpnayVBFjg4yv9OpfwPTnIEQ1Cdlc+wY6loINL6O1WKKmP5
 tgR+jixp2fgTcAnrAatqdKLDDTVAU8/z8eIMHN/rpP163yVcBbaLqDbBa1HE3H2al/nLj6doqXS
 nuCldBSFlQnlw0cQcpeEo83z0gqoqNFuxJjttoywbVw4USgyLsTv+C4s6PfKOLW+bpxchYeMKGr
 Oejh4l9ivigZsKDMQ7Y3Wz+fQ92fTIsPOuZ16drjnkVle6aPq6NGCTsZx4eKWs5YMkXuUzrrpoD
 NqldfyxMfSerx/k10sN09lPFhqX10Mub5iZk3ubz70uYLl+GS0gaRUGgTrCJOsZHd6sxis5TXpM
 k3A/OzxED8sUQgSyqrUjSRtn2Rw9KIfAfB5r4RCPViHSJof/7EkDo8W8tvWRAA9zcwSNMftJJmM
 AEXQy981DWAH6s7mjUmXzj6o2gw6VreCbmaZjLUUmObC4=
X-Received: by 2002:a05:7301:fc04:b0:386:ea31:7123 with SMTP id
 5a478bee46e88-386ea318008mr3598989eec.25.1795799012118; 
 Fri, 27 Nov 2026 09:03:32 -0800 (PST)
X-Received: by 2002:a05:7301:fc04:b0:386:ea31:7123 with SMTP id
 5a478bee46e88-386ea318008mr3598965eec.25.1795799011586; 
 Fri, 27 Nov 2026 09:03:31 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385c6830815sm66989481eec.20.2026.11.27.09.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:03:31 -0800 (PST)
Message-ID: <e4f08428-6955-4ba7-8289-af78646e1faa@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:03:30 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Fixes for 11.2: docker + plugins + gdbstub
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20261127165953.51257-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261127165953.51257-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX/ewy287x+IlT
 5YSYiBBi+fIrGM93EcYJtBKA/ROl8wf9+pk4JvmDp7h8NBTADbpfDT9kfE7DjhInuLkQm+QSB1w
 NbGJQNThLetos/5PHmwXkwva4V7x1q0=
X-Proofpoint-GUID: m4URaeQY2wcOyiKfvLRLcDYphrp7KVOb
X-Proofpoint-ORIG-GUID: m4URaeQY2wcOyiKfvLRLcDYphrp7KVOb
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b09b7e4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=GYMq4rxn_RfNioiAtL8A:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX9EW223NkGMu8
 nzudM2QgVOscJos0Dvkf1x2Gw4f/TVS67wibPUd0j5Bp/RgFk0VmyRQ0vszPsiDnqhB1Y0lyumN
 yGD3jy5oMTE0FtD+8USTjmE6MUp6+9xXNcbkth9zxkJkHPPQYLVvy5yxmKHQhsoaLto7TJp+zpL
 V3hOsy5xuleBfQf1Yy3kIvyr6qTe3HQilhwCjI8ryJcZ0iYi7VdDkOn2AwmkAh9tKyHDQHLZmaM
 TRHF2NTn3EKuomi1WBXstSR7XovDuYXedh50VvJfzRRuHO818YlYvFewmFfMtYepQzuuEpjseIh
 xTJcge76rkUY7DcU43WnPSpBAaIMk0D6aL9B74N8TyKQ5dmnda1U3ZnkmAlTePBhJd9BSQBNxMl
 bRVyMzkmssJx5u74Q++Fhvfjy7jSAuEf3oM7fDocJUR4NcYgY4zc04lXIN9bmeSLJben7L+2jJH
 mpDTYYYDCDkTLJu+fpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270067
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/2026 8:59 AM, Pierrick Bouvier wrote:
> The following changes since commit 9751c62358073580cbf330a4df22077a7c6a407c:
> 
>   Update version for v11.2.0-rc2 release (2026-11-25 21:39:27 -0800)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/fixes_11.2-20261127
> 
> for you to fetch changes up to ff4c3cf7ca6afd7f3da1a011be304f897d2d5fab:
> 
>   gdbstub: reset supported features on Supported request (2026-11-27 16:58:43 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH] tests/lcitool: Switch to a newer version of netmap and check (Thomas Huth <thuth@redhat.com>)
>   Link: https://lore.kernel.org/qemu-devel/20261106063103.21061-1-thuth@redhat.com
> - [PATCH] contrib/plugins/uftrace_symbols.py: ignore warning reported (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
>   Link: https://lore.kernel.org/qemu-devel/20261118021020.1253822-1-pierrick.bouvier@oss.qualcomm.com
> - [PATCH v2] gdbstub: reset supported features on Supported request (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
>   Link: https://lore.kernel.org/qemu-devel/20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com
> 
> ----------------------------------------------------------------
> Justin Sapp (1):
>       gdbstub: reset supported features on Supported request
> 
> Pierrick Bouvier (1):
>       contrib/plugins/uftrace_symbols.py: ignore warning reported by llvm-addr2line
> 
> Thomas Huth (1):
>       tests/lcitool: Switch to a newer version of netmap and check it out faster
> 
>  contrib/plugins/uftrace_symbols.py     |  3 ++-
>  gdbstub/gdbstub.c                      | 15 +++++++--------
>  gdbstub/user.c                         |  4 +---
>  tests/docker/dockerfiles/debian.docker |  4 ++--
>  tests/lcitool/refresh                  |  4 ++--
>  5 files changed, 14 insertions(+), 16 deletions(-)

Disclaimer: This PR contains one patch for gdbstub, for which I'm not an
official maintainer.

Despite multiple pings on v2, I could not get any answer from Alex, so
sending this now directly, as the fix was tested and reviewed.
He reviewed the v1, and v2 was a small fix on top.

Regards,
Pierrick

