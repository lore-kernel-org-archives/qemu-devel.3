Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1C606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Le75ECPK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FegwwCYD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvef-0004QE-Gb; Mon, 19 Oct 2026 18:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIved-0004MI-S3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:16:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvec-00024z-6P
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:16:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZg6n3914806
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T778L5M3u2QyIZMl8TYnGqvFVQ+6H7YUztHs4ELaQgI=; b=Le75ECPK6x0FLttW
 hm2gqfsJG0Xk2wh5eQnTOT8kND3rxZz7iSNtneQEX3fzRW8JnRWTAuujf/nRsx1u
 OQXTVibF5/FdTKWrkCI0dgZR4N3xT3yGTi6RkgDbs+mrbMcDt2ChrBpnymnWawig
 7C4QCpfCyYhyKB/EBJkHudGImChvZt3NaU6wcWrmP2T21C/QvD3AuomG+/gh5JQc
 S1/rjFfjReipGXQhkjUdHJ225I0ZnSOujGBJuOeK1wMS3qwehGkBMQbUMSa/SyVE
 4ms7c9DxzfoqIutYGq/SKjuYXGMcddJTiadpFIV3Iz3zCwF8FO9j76fLjp+HLxhn
 syMThA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42guth-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:16:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35a04491c56so149385eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792448184; x=1793052984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T778L5M3u2QyIZMl8TYnGqvFVQ+6H7YUztHs4ELaQgI=;
 b=FegwwCYDbP2ETIw14JAqlu5kUpyWkdwo39Cqp3xSz6x1WNrrJlSsJlgrm+gzpmOheH
 /QVv1nYjFKXHvykNhwenVBb5QQK4ueUUqH0sGcfB+/cLzJe4cur/6Oe/WA6W5bR4hVbz
 X/1Umn6ZiuXEsCaD0tx5/suzzqmz9stddqhRAXJbk41JeOB7FFrld4bnWlLUBIbzyBjX
 UlhJzHFroMXYdvg/FOXTS9rAl3IFlJ3J5uoAfRo9YhNrdspvfk/0dojJOoV5NzlFB4+v
 KrjsXlJiI2lx0pZXakpgzVyNXRH0Iy2Acw58TvMXpNnTPTDxGNByVUVwJLVDpVPV4Gex
 xVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792448184; x=1793052984;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T778L5M3u2QyIZMl8TYnGqvFVQ+6H7YUztHs4ELaQgI=;
 b=fuyymxb+gaetiWSX5NRtVGIgO425zCXo6YwFe1HlPUkK4g/f5FREDKAS/MuP27vW16
 B6vAVSk1MqU/wtFhRo9ww0Xl+0C2agOapPhZMtayLAW8VZ3K7bUDXRQKYmqmUBJqjXzt
 Nth9aoQ6b6FRqrfXm1ksfGDjcggsdrYn5b4IHiDB0ujOYNiKDLsAFoELQl3OhkhsWPUs
 RAqQ1p1iD6/JnEI7ABLJ3uVbD+lmBI2CI9GhWeSVUQs0Qn7d5LtQ3qAAEg+Fr8Q4BF+M
 enLolND73OfpQukM4i/NKfKY9LJYFSLxCiURhC7c0lSFY1CSCfmKdrV7zXBuLCV89j7g
 d4vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyPpcrNIBwTeSAP4hn+z7Pq5HSYIHCsQhEPK9TnE76+yKBRrHl7BRbtmp4Wm51mEj/lKhy6pQCg+Re@nongnu.org
X-Gm-Message-State: AFq9FYJ6zmNJCFXByxTFe8xK5BoWQsAk+HKQlKvUNFkDBwNEuWnSMuFi
 oHsQ1UusK/cb2ke8kwc4sO2TKyTwCqlr0/Sl2A5kb1C22CGkvvUiu9L9bWV2nm2oruSAfNcRb77
 coRG8RrKkmNRNt39a7kgo5C/d/HyScUERN4bcWMVucoKMMWKK/52vZCHmnQ==
X-Gm-Gg: AYBFou0PIM73HrgkBUYuxPShzwKezGzmZrg31dsFyQLPU3aXmgbyOOyx3+6WIvfNA0w
 /YprE8ou3uKtmsGXy3FbZzJQzZO4ZcYhYGbcf6oUOGWa/03MkAGh6vbGtqr+gzHlBTrGHQi5Wox
 ppiuDNtEQAIxSaTK/HJjnVt/WMXEVBvBvR23VuJ1hFTsRCRBQD2/los5sbMkSuO879ubsIJc4VE
 dbBiyPMAI0PzYuZWogfatkNXoihYTI/pgdry+6aLqkdOhX8lDW+DEDvRnXdrOXJ4TK+rcUmTt6g
 uJO0Eh3zm2QTXT9r8weIA9nsaQRwql64SVjurOfgVMd3ZFR4AmEJm+1kRKqdmPbMzXBxRn/1GKi
 PTN0Uf1vB8/ysuVpyslxB9w7C1jwm+u4F71wIRdl5vUmjr9yXJWcLScI22fp0mm77kKwu8g==
X-Received: by 2002:a05:7022:b0c4:b0:166:fc9a:11b3 with SMTP id
 a92af1059eb24-18dbed5047emr505915c88.12.1792448184027; 
 Mon, 19 Oct 2026 15:16:24 -0700 (PDT)
X-Received: by 2002:a05:7022:b0c4:b0:166:fc9a:11b3 with SMTP id
 a92af1059eb24-18dbed5047emr505880c88.12.1792448183302; 
 Mon, 19 Oct 2026 15:16:23 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082f7f6e0sm39364783eec.27.2026.10.19.15.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:16:21 -0700 (PDT)
Message-ID: <c5633077-a52b-47b5-97df-18932c96262d@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:16:19 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] hw/hexagon: add subsystem-base property
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-13-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-13-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfXzXhvht1ugsjW
 VuXrX0SHwTZAFPtqqAop0uCCOOJODD8jUSmcdFGfXXJfWuz+k5Anh25Paw9GWJ1hAKgKy+DQmpu
 /ULpR+chArv7ZsaM5EjItwETLhL1KN+by0+CaAe+KID+RU4sdDS9ZSa9NE2DvgBhMsRQ79ptsPi
 j+a2FnEKuCbvaUiFaI7vpm++xVnvjpA7HnRpTGEuo/tNtku+NU6gB3fm3ckB2GjnjnDwJRrBInl
 zg8MW6P/iHtfdSX3QeI5mVmPRNHjfgD2yo6Cl8P0c2Vo1zrDa0NPfPCdTVTrx29lXsOAwVsYZpf
 wZFOE3mfsNHIJQqPaHmXjNDwTLF+z1/5Ozf55whyE8LQiea5H5rMA4uhsU8RZAmjlf33bdEfgnK
 oSUvTWo07gQ9X/WKetgl05J7q/rI79hVt3siMOzhWmP30YPf2vGdtGfuxinwG82ys7DDzeoZ6ir
 VzfhKrWD339J6w08org==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad696b9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=MKYDpzXTd1gu0jEZYCIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX6Jkb2wPLhN0e
 kyMsmS9nrUk46DvpJ+x46q77dDcDnQ3H5fhIAJS9LlXKbpVGdOtjh4wR3bIdP9R7K5MxSn4Ekse
 Ll6WhMWISh/rynFVd0iMEq7Tor7NvlQ=
X-Proofpoint-ORIG-GUID: rFaJ6gGBD8e2G2oMdhiaY_rkUPKfyqY6
X-Proofpoint-GUID: rFaJ6gGBD8e2G2oMdhiaY_rkUPKfyqY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190088
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
> Let the hexagon-sim-style machines their QDSP6 subsystem, and with it the
> l2vic and QTimer.
> 
> The config table's subsystem base is updated to align with the chosen
> address.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/hw/hexagon/hexagon.h      |  4 ++
>  hw/hexagon/hexagon_dsp.c          | 62 +++++++++++++++++++++++-
>  tests/qtest/hexagon-config-test.c | 78 +++++++++++++++++++++++++++++++
>  tests/qtest/meson.build           |  3 +-
>  5 files changed, 146 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/hexagon-config-test.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

