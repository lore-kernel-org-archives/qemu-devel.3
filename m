Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88B606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MiFeSzxP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FyYgW/hA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAOo-0005dk-OQ; Wed, 28 Oct 2026 16:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAOm-0005dF-MW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:37:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAOk-0004Kd-Ov
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:37:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPLHW1942060
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8roVpYQvIdFA6Q393dZd6a36RRERtw1464h1+UIZ6DM=; b=MiFeSzxPVFKztrVV
 dXo0ZCcSX6lizijuLtgyInG/20ya8WyDO0gSgIVL6cB9tsSDbeCaQgsTIuQ0SRCB
 RfAHG0LjzbhP9JY8eeFiFsp/AnPOJ+JJVyG8hJJQ5zqJq47Mdzn3ltqwPX0WPhk1
 84DhMk08N5Bj+VMPrrnm0CpDDQuCwspHV4taLV8Ipa84bHE5nX4QOW5Ij4ubtTZV
 n7RuMB/Q8W7TcWl5RrQorB+9vWDSxZMZv/m+wZAzL6+Jjm3MytOASLG3Na8/RhRg
 MNG3e12cOmu1lQSOFq94sG2sXYArU5SvW5tHyykTAFnvlDxDpNNdAkX93+I6AP5A
 lmNwbw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhwbdd5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:37:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36998507c13so2061345eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793219844; x=1793824644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8roVpYQvIdFA6Q393dZd6a36RRERtw1464h1+UIZ6DM=;
 b=FyYgW/hAlvihHqcTJgRngrf0HHzFdUVIvq2ra5n76dbkxGRJaRptgm9eNUnRcm/jkj
 flYySxktO3t02ezZQySaTr/r3M5uNTDxs/Uj29xAH7DQLAE0gmPf1per/jDbnUdEXV3P
 I+P//ONXF+MNewuT25z5f2H7e6RTb3cVH/wsxJNAZ8ggXK0LG0zHQmeFfZ6cOtuxvO32
 T49f4ZEWkSH0z4jDlrYX3YubHniX5PZsVdYv3Kq1CIs2wLvcoEFxRVKmRgFJTvn+1k4H
 QqG0LutTJN/xMbzxXVSIfZVi3IjOOW5NqG/xBWa9Xqu0wwMK1Sl3mFwr0LUtJOyWMEjW
 Rlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793219844; x=1793824644;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8roVpYQvIdFA6Q393dZd6a36RRERtw1464h1+UIZ6DM=;
 b=OYUptE9z3OwVLmPIP8VS8mUN8akQ0JL0RuoeG8rPLWVTosqP4Oqhx+g2Wuy0HY4ee0
 312NOoWY9gMKY4KeL8ObI7CnvUOqR9MNeagKdlqYDm+yFEnTKkObMHLEvtT0RkzMgVbn
 doLrnv/cbHwmjPO0FaO4q8CU9ZjFMQ6Nea8rG5trN7Zl7BQV3gJe43McTzX7sx5+gGNA
 JavdBsOT9ICm2YKqiUe7HS1q/cnmi4qxd3ci3HDbM3b4WU+DSQ0FbU/hcdpqUxD/Red+
 VJs9J1/PhtAdun23lg01iYoeTtxyMMduBZ+rF/z/7zzaqshOcEZMSBGC6mWgPYTiRZBg
 OATg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTWns4sKcio/4+w2LghWVikrwV9BeTJ+r58MEEBdIzGOHBCYNh3xsjC1ZUw3mSRQQd7Tn6ZS73xUuj@nongnu.org
X-Gm-Message-State: AFq9FYI93vcJfUwPMaVpGTph3/MDObh2LBI5CAQEFPvE15l+ohcyHbRI
 G8VHicaJw+OEYqqzIQsE6HUu1P66ZUXaP6fi6ky716L2msnBFfUSsSHCYGOZ92gaffZieRU/H8Y
 F+rLWuTHlV9ztbaLAG+2RT3QZIWNuUr/Wr1bzrsn+ReDjk0YCypFww2jp92qQA+CweA==
X-Gm-Gg: AYBFou2gHscxESTuj8AjfxKZ/k1kpC8Qrr8/xhzhmNxuFJthp2oInJBN9h8xKVendeB
 F3fdajtG+WTBH+zoiVv22BFieQiCyW6h+F1jEZTZboLRSR9Uu4QoFRufxZRXblqUIRldgyQjCM6
 h+CT13SmP2Mg2xsQdpfiA8cNYTWq6WEcQ57X/NqCZ/YwNvkbfCJzCKJqqJehQcGW38lfq2yvdAh
 6zk/qbU2mi3B/lL9+IXnCus6JcuSsAdrx0q7/4kp1vH/5/lfqNtwze9pjp5FDezstSo84Dmhtx4
 se6803100+tYWIuGOlKufVuJ9CTJDtJdHPsQLFY6SeyZrZmWK8iMS7Te0A4yW0Ls0E0YrNZCXBJ
 dMa5oHXH5lgEGufgsTN3h7fd63P40y4Oby5r0Wc8JnKO5TMeXkhcPhXdQbrQ+Gvp1vLINvhUuKZ
 Ley5rCDhLTqo9etCjzxnOOMkuup4AjAoBGOiRFp7KzLFE=
X-Received: by 2002:a05:7300:50c4:b0:36a:1a62:763d with SMTP id
 5a478bee46e88-36a20440e51mr5333642eec.40.1793219844146; 
 Wed, 28 Oct 2026 13:37:24 -0700 (PDT)
X-Received: by 2002:a05:7300:50c4:b0:36a:1a62:763d with SMTP id
 5a478bee46e88-36a20440e51mr5333595eec.40.1793219843354; 
 Wed, 28 Oct 2026 13:37:23 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23641e78sm10111839eec.0.2026.10.28.13.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:37:22 -0700 (PDT)
Message-ID: <55e39663-f070-4d51-974f-7507f02176ff@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:37:22 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] tests/tcg/mips64el: Add bare-metal harness for
 R5900 system tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-5-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2ykCDMpBtdSVvtbF9Jj36ZarQsuYnjkC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfXxhupxopBR38H
 MMiwAq+wJxkPcqXu1Su19mKLX7c4MWY+32ESPGq2uzJG9vKzqLD9VNlwW5DcUfUzoBE0U9kxCvr
 eTEeftKAEXcg6lWcZiqbnLQDpnrtZa0=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae25d05 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8 a=YdGAswuZE7qjsjBbJVIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-ORIG-GUID: 2ykCDMpBtdSVvtbF9Jj36ZarQsuYnjkC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX+xZrkpf0iKqo
 QN+rX00F4b04b6wU/mc7IIWYdf51w3e+brjyfH4kaxEbj1HG8WITWQCdCuLoZGJh/lD/g+/pOF9
 9zOOhChKB9rIAclr0d2187XPJREIBlkqAJsQrLJ1e81f9W0pneQGvQJ3JmpNxZeQrZu1FesHoHW
 ytyqsxhl2/w5QwkDrMZdbvsUQC7C1/PvILktHd7858PWyVJRRuAl7LFufYCHoE8hFuUZ9FPltrY
 p1ui5wUQPus3yE+YCg23LYy+UFKjvB8OXQzIYJbX3pM84iH5w6zfsAZYlf6Eee15IxARpwTq3gl
 zi+q2QWiw2rjgVIDl1yfy3+atfKhDPMi/t3wSU2Qv139cjbTnaeVLWecxl2XnMQl3QhVMNydDfV
 wejlDXh2nZdY0CEmxywRPh4i46aIJ9n2A35hNazi/eHt60vPMLgIQETtySivnWiyQrbH/feRtbR
 IuOuS63Fhm0uiWY2lww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
> There is no libc for the R5900, so its tests can not run in user
> mode [*]. Provide what is needed to run them bare-metal on the
> 'none' machine: start-up code, linker script, minimal assert.h,
> inttypes.h, stdio.h and string.h, and a gdb script.
> 
> A first generic loader loads the ELF at its physical addresses, a
> second one sets the PC to the KSEG0 entry point, sign-extended as the
> CPU is 64-bit. Tests end in test_done(), where the gdb script checks
> the status and kills QEMU. Tests use 32-bit pointers, so gdb must
> send 64-bit addresses to the remote stub.
> 
> No test is registered yet.
> 
> [*] https://lore.kernel.org/qemu-devel/alpine.DEB.2.21.2103172243160.21463@angie.orcam.me.uk/
> 
> Inspired-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/tcg/mips64el/system/include/assert.h   | 15 +++++
>  tests/tcg/mips64el/system/include/inttypes.h |  7 +++
>  tests/tcg/mips64el/system/include/stdio.h    | 17 +++++
>  tests/tcg/mips64el/system/include/string.h   | 16 +++++
>  tests/tcg/mips64el/system/harness.c          | 66 ++++++++++++++++++++
>  tests/tcg/mips64el/meson.build               |  2 +
>  tests/tcg/mips64el/system/boot.S             | 23 +++++++
>  tests/tcg/mips64el/system/kernel.ld          | 43 +++++++++++++
>  tests/tcg/mips64el/system/meson.build        | 33 ++++++++++
>  tests/tcg/mips64el/system/test-r5900.py      | 30 +++++++++
>  10 files changed, 252 insertions(+)
>  create mode 100644 tests/tcg/mips64el/system/include/assert.h
>  create mode 100644 tests/tcg/mips64el/system/include/inttypes.h
>  create mode 100644 tests/tcg/mips64el/system/include/stdio.h
>  create mode 100644 tests/tcg/mips64el/system/include/string.h
>  create mode 100644 tests/tcg/mips64el/system/harness.c
>  create mode 100644 tests/tcg/mips64el/system/boot.S
>  create mode 100644 tests/tcg/mips64el/system/kernel.ld
>  create mode 100644 tests/tcg/mips64el/system/meson.build
>  create mode 100644 tests/tcg/mips64el/system/test-r5900.py
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

