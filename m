Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC33CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkdd-00060q-U0; Fri, 16 Oct 2026 12:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkdL-0005xH-BH
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:18:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkdJ-0001t3-GY
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:18:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG3ZcD3260325
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xZUCpfXZo09mTnn5zLXMgj+2RxJu+fhP9zLWRsAdO8s=; b=UxKzNoBg9HgzVGM1
 tHWUUPuZb7aIPvWDKvtnvdokrheNffsB4wQQWAsO4n0GQgnb6W4+SLLMHZOHiAKb
 JJBYdj0mU8Sqv+CPNePeP+FIQ7qWbkejP6W/viiDHlZQh3m4IZFfWbunm9ukVQgi
 AGzC1ePw6l5F2hSGFJ5GrA/1Ve/IFO3IsWeoejIVWh5fJFgUHF19IIY/gwAJHGa5
 lqcQJ4BtXQ5asCTZ6iITCE/ypcHZoEfCHnUR8aQv63OuqxD26Rq+Er/J99gdLPgk
 iU4Fg5cIlRRCOLkm8mi9LogbN6xzm0/rA8j1UdZ2fkXVGnX3T6PNv8KNFPVxtN6+
 RA7yyw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq4501sk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:18:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so69761eec.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792167491; x=1792772291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xZUCpfXZo09mTnn5zLXMgj+2RxJu+fhP9zLWRsAdO8s=;
 b=UA0zQGS/8+wy4U5q4MArqHbD/8r7eJPlSBgse7pYBjghE/lk7O+V9JiLPrAOLeMgpX
 LLnYj4595i1VwA1qSUMM8pdgA/ni+KOwEmVy7HFgtSVmGI9Q69Aow5LkMovDbfKWNS5A
 Rc8K2+TfkuW3QAVyfkR9JQpIrWaBagNz7DhaFYfJoH8W8fwZ5tumdQQdgFPN6wuP8UFI
 qT+0GlAjlIF1XVaSjy/gjrM2st1i6QlyPCfHeJMIE0+jxD8XCYVu+gNJ1K0Pm7eXtfjy
 QqaHYRRPuT0JI0G9VJOw4v9C94heT0iyy2/R94daJA9YtZEzqhKFzGt0T7DJVlpxzUqt
 +XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167491; x=1792772291;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xZUCpfXZo09mTnn5zLXMgj+2RxJu+fhP9zLWRsAdO8s=;
 b=lprefPnPyXCE6jh+si3kQxqWWBjjRFjFMz2ztg773UP/+st3w8p51NvDBv4zCUwlwz
 jP/li/tR5uwGDGXjZRn4+tMzEF8dXO9f2cFOsv6RqKqvC29fLoTbqyb950BSD2O60s1S
 NdGBI7VI1q5yoXQJohVcC23JPopUNkIAJUKSA6Bc+sqpeVyIGm/oJZRvXGJ8a/B8sas4
 74p6j9OdatY6xHXmbjqP0u3gA+0iaITGf7XFT3c/3elSCfESjRdZukdw5alUQ8mM4yi9
 XT7dAdfThDw3whgMBS9cyEN2kpLrm02Zpuj2eXzarnIp81DiErnZp60r3cfcKKZeyjLm
 tUTw==
X-Gm-Message-State: AFq9FYIz4Vixt67vBVTldBqkgYpk7SebJetuw9XXjj59gFIF3z/vOyYs
 08nr9loN+N4l/LCP87mfiJ3hxbnp4dn7K0LtxT1hCCsRR1bwQTZbxuLnNTPDcVpZyV5WHb9VilY
 XwCAUtS8qXEZelySPSLwWMyTSH+42PiVdGCNeJxPQm1upiLa2yyh5/34nyqzES/hguw==
X-Gm-Gg: AYBFou0wSw9/CxbHIMvuzRlqkrOWTRiRIL2j/6/iTUBvT7g4RQAcnrfJPESs2Hh/oUU
 TA4LuMknQenDhAoSOChIPQZbpnUkNm6qHQKSih6ipcJbsJnai/XfD0nthbY+/gQkBLusuWNJsD9
 7K6FCEOV0rJBOLFl6SC8LdJB866/ljnqNEmNgVceoGKU9NlHfbHXrHxEISHHFNw0cuEiKLm0sz0
 5a3+qVANAl53Cu72NWXVpegvihWFs/fSMtXNMXiJysTCtxlrSO/7K2/ZANb6qo66GvLKY0M07+g
 VX5gpU0WESSR+q7bstuiOQFn6zErRKFYI0zlVOvJhua3jDl1iZpp+1acupd62bhdpBs5mBUNJqG
 58u+a+q9pZuPD+xpL/2VgSkdEdDRAascARpHaA4G5J1jj1gYp1yXjPKmCfsuDSoDq1ZTzSw==
X-Received: by 2002:a05:7300:a209:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-361a19608b8mr293909eec.18.1792167490881; 
 Fri, 16 Oct 2026 09:18:10 -0700 (PDT)
X-Received: by 2002:a05:7300:a209:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-361a19608b8mr293845eec.18.1792167489906; 
 Fri, 16 Oct 2026 09:18:09 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360820a79c7sm7776309eec.18.2026.10.16.09.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 09:18:08 -0700 (PDT)
Message-ID: <2c8624cd-93ce-41f0-a897-6528e2927808@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 09:18:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions
 duplication
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: USzOB7Oxe75W023OKnmdScoU8tWXbMUh
X-Proofpoint-GUID: USzOB7Oxe75W023OKnmdScoU8tWXbMUh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2MyBTYWx0ZWRfX7Hntxv1lv5Gg
 w7O9hPrioLvSMy6GeehM0oWRZw4A9h09QmUH7gTKJJtDkDYWOo9A1fN+gF4Uyg7VZ9FlH3EScxK
 gR73mNVgr+YSJgOfuswZOKUUSG27kN2OVeiWWL/i75r1wR8+cL/Bcr0J/APofZfwA60XnHuMdeF
 JwZIHV+MIvIiY4wfJvtxEaDsSVx6S6drAAZQXnCncybuA+9EaJGUobIl0VZaXYyqi6kivuxdYEk
 65Y0vG3UJ3wB/BWNVlJr+3/ba9HqD4hnLh4pUOnB4hdO3RWhj9kR9O0NO1kCKc9tURQUDWTvPz9
 67vrfruhUP3oGMZ46JNx5siRuEL3V6SFPysq99FfNN9JoPNvSIoLb3Zi7yxcIqLgrSJH1yjPsOZ
 3NphoQHlJbmhuEkl+oiEOwxHNAuU7EpibY9OSUCG2oXaEFSfYuTU413pL6mJSkMWsGXWYE4BPEr
 xP4VcLV+weBWs1bDqCA==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad24e43 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=BlMTy-l3T-2bcndAHQ4A:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2MyBTYWx0ZWRfX+GfWIEwupnRg
 SnCAYLGnEVIuUw9F5e9nuTH8q0+dLzYGYP1j+fSV+4f75FyoRI9yzjKZ0Y5BIa0wF9YiWS3MwY9
 mlLjP03PsxH1Xdg7YoA2qcZOJn6TjuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160063
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/14/2026 5:53 PM, Pierrick Bouvier wrote:
> This series allows to link multiple targets that define
> qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
> target-specific ones and a single dispatcher. We didn't use yet the dispatcher
> pattern, and it's the first situation where it appears to be a good fit.
> 
> A possible alternative would be to introduce this callback directly at
> target-info level, which I think is a less desirable solution, since it would
> ties this API to monitor.
> 
> If the approach here is accepted, I'll extend this series with
> qmp_query_cpu_model_expansion which follows the same pattern.
> With this, we'll be free to link together almost all the base architectures.
> 
> Pierrick Bouvier (8):
>   target/arm: rename qmp_query_cpu_definitions to
>     qmp_query_arm_cpu_definitions
>   target/i386: rename qmp_query_cpu_definitions to
>     qmp_query_i386_cpu_definitions
>   target/loongarch: rename to qmp_query_loongarch_cpu_definitions
>   target/mips: rename qmp_query_cpu_definitions to
>     qmp_query_mips_cpu_definitions
>   target/ppc: rename qmp_query_cpu_definitions to
>     qmp_query_ppc_cpu_definitions
>   target/riscv: rename to qmp_query_cpu_definitions to
>     qmp_query_riscv_cpu_definitions
>   target/s390x: rename qmp_query_cpu_definitions to
>     qmp_query_s390x_cpu_definitions
>   qmp: reimplement qmp_query_cpu_definitions as a dispatcher function
> 
>  hw/core/machine-qmp-cmds.c            | 32 +++++++++++++++++++++++++++
>  include/system/qmp-cpu.h              | 20 +++++++++++++++++
>  stubs/meson.build                     |  6 +++++
>  stubs/qmp-cpu-arm.c                   |  9 ++++++++
>  stubs/qmp-cpu-i386.c                  |  9 ++++++++
>  stubs/qmp-cpu-loongarch.c             |  9 ++++++++
>  stubs/qmp-cpu-mips.c                  |  9 ++++++++
>  stubs/qmp-cpu-ppc.c                   |  9 ++++++++
>  stubs/qmp-cpu-riscv.c                 |  9 ++++++++
>  stubs/qmp-cpu-s390x.c                 |  6 +++++
>  stubs/qmp-cpu.c                       |  7 ------
>  target/arm/arm-qmp-cmds.c             |  3 ++-
>  target/i386/cpu.c                     |  3 ++-
>  target/loongarch/loongarch-qmp-cmds.c |  3 ++-
>  target/mips/system/mips-qmp-cmds.c    |  3 ++-
>  target/ppc/ppc-qmp-cmds.c             |  3 ++-
>  target/riscv/riscv-qmp-cmds.c         |  3 ++-
>  target/s390x/cpu_models_system.c      |  3 ++-
>  18 files changed, 132 insertions(+), 14 deletions(-)
>  create mode 100644 include/system/qmp-cpu.h
>  create mode 100644 stubs/qmp-cpu-arm.c
>  create mode 100644 stubs/qmp-cpu-i386.c
>  create mode 100644 stubs/qmp-cpu-loongarch.c
>  create mode 100644 stubs/qmp-cpu-mips.c
>  create mode 100644 stubs/qmp-cpu-ppc.c
>  create mode 100644 stubs/qmp-cpu-riscv.c
>

This was merged into master (2cab0c10632960c01972727608196984d52c93bf).

Regards,
Pierrick

