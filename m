Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8091606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rqcem2AV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EihDYEqD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKYRj-0003UV-Bg; Sat, 24 Oct 2026 05:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKYRh-0003UM-Bi
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 05:53:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKYRf-0004U8-PB
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 05:53:49 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8oc96254648
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1VmF78INWlGLaDrxhFGUVfk3kqrvsTn9zYTjVPJzjXE=; b=Rqcem2AVnnUzZwXm
 SxixcqrMOpPnIzPDLgOMjIgaV2fFSeeWZgOPUyypNQO+LfNO5RN+dXnOEWR+pE+k
 RMEXYC8opm0ETSWAgjNa0265na2wuvkUYsheZ8Oc7hBdcOglrtyMJrYnHpynzw8w
 fcBFzmWpccleJjd6MxlSZAhNwx+fyu/t1Bm0xLZ/1jnozXvF1RClUhKU9n9XDpiW
 JOIChd/z5N8SDGz86ONTGzOd2lhNGLOfPq0hAY8U2s0AIMIvLo7VyOA0C/Q4Q8tY
 EJZje8ibE5OMWlpJ79s45U05gGW/K2HgcO66clZoCGNYLbXUEv+8l8eU5y4iWnXg
 8bteyw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9rgxb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:53:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ecdc701a2so217147985a.3
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792835625; x=1793440425; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1VmF78INWlGLaDrxhFGUVfk3kqrvsTn9zYTjVPJzjXE=;
 b=EihDYEqDwrT5dlSYlpgcWrtkKrl0pgHgRQDxKvn73gesX81CdLoUirucLDL5o5jt04
 RfXCRanP652r1GTjn6+3+NCoOLBc2l0acLeHKUKUcfrSIwcg6vBm5Q9KAbd11xgTJqnq
 1ZYTdVNvI5wGVym/RyVr7/sjjP6jMlv/tkjIqeHk6BNUi2OUg3gh3w9CAqj6NKMj/XrK
 9NaORFzfEJbdOROAawrkfghAKjVzBgkOu7ur01SGWYakWVTf+s1+2QlTKRlipwyi9pnT
 WXWd1zY5nasgTp2AcqldaNfviTQIUCgiF42yDpqE0ijuCzEYau2TNknqu9ejJnk0DUN/
 oLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792835625; x=1793440425;
 h=content-transfer-encoding:content-type:in-reply-to:references:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1VmF78INWlGLaDrxhFGUVfk3kqrvsTn9zYTjVPJzjXE=;
 b=BL0UhwVeN0cJBYFBLIrdIPtGAKSxceixKOKU0N1r4L+3IHs/uDvtSBnxYdMoaSkGBI
 Ipsmp1SoOQRO7yP61UvPqCtB+oP1N4dAHtgqKlkzYXgI8ORigtXbusmjIWO0Jhca6XxK
 +cC89200fhOUsQ3p1QkJmD3iN9Iala3hc+X7DTFqwrRMB8BlRoxsA56SiWeDVxxtlewt
 OvDINwwDLy0o5EuMESCnWN5xG/srlg8DyzgIvKa4cB0juEY2j9J1MVRUh8jHY6klHf6a
 y2gXCvAoCgKV9JqIACn312O+JzziIcjxQF8IMfdZiKAgVp9Fz34zi8Fs0kYWpXRGk12S
 HC6Q==
X-Gm-Message-State: AFq9FYIY2IOj2iSStCOJeGHX5LFn+pafV/QVgWTdkTHznnDdpBnOnfrb
 KmFv6h4lOv0WlhWd2GwNINha9xMq/uQ6xuJZpJMC8zMWhdxcwo/abGO5Z5SxT9PuVSAXPT6Te/L
 6RD9lgya0hxMNAfaix56elRQF10RJb6VWTLxEK870XSdQWOLqWTbk5A4yTH4CE55iR3Jh
X-Gm-Gg: AYBFou1N+iX2tAtvBxau+hPYKaXEQ3cMi56fFSTteq9cSztQk2YB+otwTVE5WDpR8j5
 Zt68r2PV+UA3JSvA7gVeUBKfsDBD3XkKwAS0j3c3qIp50Kapo7TV8o35c1YbKnjH82nCw+O9Kh8
 pC4/GdtcoiM/veAs1gDKWiwcLPMmX2VykndjuWDEMvcsnw4Owz4UCsUPx06eOaArgKomzF2IsNm
 oIzvev7iY61kIvyrABh0sDzSrtBemWY6Zn8yeMCtd369QQ6nQ3SU41E9xYpqEqCm/2zDgeHNLdU
 bC8Wo86QpdxLOnoRlk5G7RVlemWV9ig1dgS4hQ6SBHipL/HGeZN07nD4crni4t14lRy37XsfwW8
 xu/wY0GWUvaVg/zGksLrjODDMWSILWblmng==
X-Received: by 2002:a05:620a:4686:b0:93f:a63:15f8 with SMTP id
 af79cd13be357-940ef7d38b5mr197599385a.8.1792835624940; 
 Sat, 24 Oct 2026 02:53:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4686:b0:93f:a63:15f8 with SMTP id
 af79cd13be357-940ef7d38b5mr197597385a.8.1792835624338; 
 Sat, 24 Oct 2026 02:53:44 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2e8f25sm42899395e9.14.2026.10.24.02.53.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 02:53:42 -0700 (PDT)
Message-ID: <b7bda35a-bc2d-4a6b-903d-8d3103d21d16@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 11:53:42 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/83] Misc target/ patches for 2026-10-23
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VpE-vvv_vHk47-AsE8tdaOJ6dK_PW40c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAzOSBTYWx0ZWRfX6UXO4CjWE+Of
 1NnKPigom6exgerCjhDOBxdYozskImmQgHW7CWbIDzpgq+2ISCwAGdolQLaeb+HEpn/0zCkDK9L
 IP0W2JAHEr9laIbtILoDA9am19qvhCwLC8pTYfFbTHbefNkjZimmGeLH5Oa45wlHmvgfL+qpcbX
 iL1/Vg2bCPXKYIhJDEeGadhsE+Rz7TrmNafp7D6o6hMoifnxjO+dGGF8ZkzzNOUNcn75zqs3mgx
 EG6O6uvVZ9m9IaxgHN16MIL+qHFSTCTWG17deB1qgPbBfXO/ZpZiZidg4lvX0/RtjO6O/nKqSFW
 9G2n1BJ+tTteD7t+zsSe1kNx95MFqHBF4pY57DMQHXPv/N1yGkbGa1xZ4impYccmvzrOMxWiaeS
 slsuYDgQKOjf5R1S3OZKrl5M67L1MLieqG7A17lS+bkcO+TcsynwVV1zkZ0FskWqfoA93PYXHkP
 8sSMRxd/z7NQoRmZKUA==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adc802a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=YO6RMLowzSfZG7vYIfUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: VpE-vvv_vHk47-AsE8tdaOJ6dK_PW40c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAzOSBTYWx0ZWRfX3RNQLOJOfzUH
 3qeT6pOSbTAjdaaA+8slmoEyH760c4n331hwlC0l554AsHuN1XeF3F5SXJWqOiLO6OijEEE1CUB
 6G4KKIHmlDNfvE9Y86g5ttCT1dy/i0M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 18:12, Philippe Mathieu-DaudÃ© wrote:
> The following changes since commit b6c4b7e86dec12d07f5cac65265b986d38ee9002:
> 
>    Merge tag 'pbouvier/pr/tcg_tests-20261022' of https://gitlab.com/p-b-o/qemu into staging (2026-10-23 09:09:11 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/target-misc-20261023
> 
> for you to fetch changes up to a0deb11baf6e5818ccd641088d9465e0e0eac9b7:
> 
>    MAINTAINERS: cover riscv GDB XML files (2026-10-23 17:52:30 +0200)
> 
> ----------------------------------------------------------------
> Misc target patches queue
> 
> - Make TCG halt-to-exec transition explicit and remove cpu_exec_halt()
> - Various conversions to translate_for_debug()
> - Add common CPUClass::exception_name() handler
> - multi-target: prefix helpers with target prefix
> - Remove target_long_bits() from GDB register reads
> - MAINTAINERS updates
> ----------------------------------------------------------------


> Matt Turner (2):
>    target/alpha: Record masked exceptions in FPCR for /S insns
>    target/alpha: Determine tininess from the delivered result

I tested and dropped these 2 but posted from the incorrect
branch :/ Sent v2 rebased.

