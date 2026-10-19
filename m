Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25C0606A324
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nIRIqJoV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TcuRSpTY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvdt-0003Bs-DK; Mon, 19 Oct 2026 18:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvdr-00039u-4I
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:15:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvdp-00022P-8y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:15:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZQcO836433
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sNqRhQu4nBDAfioXob6JGwEvoFVBeIYdjO04fUal9AY=; b=nIRIqJoVnPiYGIvN
 UL7fttOXZeL4H8Pu7Kq849SyDA2NEoOc6r4M4Ap1xbH7AZ94+jr4pLl62ETLqGsy
 7d5eHVrn/Js10zQtmOY61DnKGiF/IMh7V/N+/gRyGw1WeLNx/6E6JmdOWq75UI0v
 ug5C0VoRpNkHVB1CpvmLrMmr2t4Ub14xII5Av+oTngkHydz709BzvK3nkFfGOY0H
 O+7RruLMvcKmhfgjh0WGBAALhIfm0ove7tXhr4IdN7xelIK7EmCyROdnPiZpY7NE
 lkIZaH6tz7jTc41QR03opbEYE7V/6g6kVYqt6EdPsz8cZCTR1ZaryztJyaKO8OzE
 1Ib3wA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47kh74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so5588647eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792448135; x=1793052935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sNqRhQu4nBDAfioXob6JGwEvoFVBeIYdjO04fUal9AY=;
 b=TcuRSpTYL9M6z3uyBVZzN87muKHVe/Sy3OKgN+Oggl41711U9GZgmJzqReZnG+kXkQ
 /enDt6mGLP9ldEcLRiRsz2QP7T751vOaJy67TYXp6NsNhMmKQdjBpUVE01MM0iM5o4Ca
 8ueXcRrbgFO3AG5LJjl0saYmELzHYgHpuLDatt9bNlICuF9maQuLRZmfGHMm5LIMCNZC
 93PeWPlR7hyKIUfIelVUSiFlk40C5H1byDAVwJ9RS8Ntm7cty66I5i2WyoiVNfavzgj+
 laWGT9F3pNGuln2m7BN1meWVZGH/RLbMm8r3z3zA9cmPMPuMDD0gDTSOx5X93FiujW9m
 RhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792448135; x=1793052935;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sNqRhQu4nBDAfioXob6JGwEvoFVBeIYdjO04fUal9AY=;
 b=LLnWSq9Liu15ZEWCQ/lhSXOTX9lIYdYpR2U+8Sl147QFGvTpK4YRWkQ+r/R7yVob7L
 4BUhemR9svAxjp2pXzdi/iM14Pmskwu8m6bwhAN8HsF+uFOuDJugpCh0o+V2lXKpmAAU
 yWxXjj/3meXNB8aw7Po6Bkz3y9lAeRJjy8t3zM3PoGCoSi5EVCMeS00JrplYOyKnNdtI
 Il7yFwHVo3LfgRS1XvXOqeHcMcuIDJDOpajDKwTQlzamejF8ZhVwh7M+dFc6MmmdpXNQ
 L2IU0eeYtO0olqBx0cwBqU+ZY7dHLeUDyRk1+ZEahKi+8rXt5uJx3rUdbayHFyPYy/jB
 7qSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKsxem6J3bSQHbejxAleLhjYW1Qt1cTP59dX+nxc/2MSC1lvmIAAi02d2U6M9M8zgg8sf93dm1e2HF@nongnu.org
X-Gm-Message-State: AFq9FYLb199GS11tMCT0oSxNn1pAdtpBBQ3WoFz8UQi8fSCue4EJz7ee
 P/e7RXmX3edhMbjJJbHYxzEqcOf763L/8pfnD9ZVS2C+WnCyos136MHhV0GicMJ8glipvR//Ex9
 tqvHrA8afHTK4BHMyDuoWOT5R80DGnTBlcKXJvg/Isx0fYmplI/Gj70GJ7A==
X-Gm-Gg: AYBFou24saMGniW238HEHvg1mJIhTZVK+wD76N4jIaSL39OCJ3PDIoSf1Fdy0tQmIOp
 IHHs2RMlGFiaG5f2b+5Q0GLsnhbR9ZEZFWIQcDkOAM6AjZSIstlAbRNrRjyAyY11Dhm1NuuntEV
 +DMhrpfMuxsTgZecSdgzXgF0pcu33uAG05BVzWsBycXSfYYQPP3e+X8eCT09+pXwK8K6NtCec5m
 3sW2RaIdF6gj/iIWl9vtpnEeIgg9jceLA+nULeF0eZ2EHDphE563YcXWTjxD23lU/DX9DnhLUgV
 wpaoNcs36e5tsvxQ7GXSaOHjHPjlg3FNKeKtd2ygtBy4fSC2ljgoi+59MH1NS11mv0QYYF//dAf
 WktHUmUsax5XglBjQ+Wy4GDo2BA7G+YH3OFpkqFL/Q+CcNJCj6BMSvBGziUNqhpPibnIOMQ==
X-Received: by 2002:a05:7023:a56:20b0:166:3e26:c4b5 with SMTP id
 a92af1059eb24-18512296a15mr12062732c88.18.1792448134820; 
 Mon, 19 Oct 2026 15:15:34 -0700 (PDT)
X-Received: by 2002:a05:7023:a56:20b0:166:3e26:c4b5 with SMTP id
 a92af1059eb24-18512296a15mr12062513c88.18.1792448132250; 
 Mon, 19 Oct 2026 15:15:32 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831ca95700sm30681135c88.23.2026.10.19.15.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:15:29 -0700 (PDT)
Message-ID: <372e9eb7-4ccf-460e-af49-7e18affd2168@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:15:26 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] hw/hexagon: add the SA8775P CDSP machine
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: X7OzmUUtoeIAjkhaQDBn31EKMyf2C_GM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfXy1jjC0+GG67X
 G1sJmcJGcjtt+A+OtpHbqwCdTP2FP1tbswvZdFAkcnlIjdoC1T4KYCo9+c8y4bzlRkgCyqQJ/3/
 yumY1XFSPDWu3E7Hhej0dKGfREpI5uq56UALcAsoyk2bCIQSLF0BmMXImEuq40Jily/MyV/3263
 Srdpa71SrR0dcxlzy1EHdC1AR3vPAJCqAQrTVNb1Wg6fIpOSjLdRpn26+//TDBVJYaEdk+V/W2X
 k9jF3MZc+VmCQiwpP4njRgjH1DvfkkKxwIuSmWzr97BrmQnlmagtAoj592/VSMZzXK1vdGytIx6
 84v4EFnUhvZvCamnf0Vi4OspDFTvaUWo1nsyJOF6BojDsTqbjrVXKLK02Ae+6sL7SaxhoTs65E5
 F2+Ire8abuZcNsUFnBWbr1pXGamWxIww9gPdDI8qACEjXTc4ZplXMp2h0sUkt57o49q4CzAGUD7
 Uy8ZtBul3MUZmA6nUhQ==
X-Proofpoint-GUID: X7OzmUUtoeIAjkhaQDBn31EKMyf2C_GM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX9YZ3edoiKDHb
 8Tm3Nxgo7nJlUhSlIWyt7E/ZL7v4eaju+VnMzzSeGPW23csHg/P2d0H4DvRPVAATjJykNQzRhGD
 HO1CADbS7TXDD10zy87uL/d9Lj6Gc84=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad69687 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=aRA2NF8V9sjL0fxTIJoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190088
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

On 10/18/2026 10:52 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc |  6 ++-
>  hw/hexagon/sa8775p_cdsp.c                 | 59 +++++++++++++++++++++++
>  tests/qtest/l2vic-test.c                  |  2 +
>  tests/qtest/qcom-dsp-test.c               |  1 +
>  tests/qtest/qct-qtimer-test.c             |  2 +
>  hw/hexagon/Kconfig                        |  6 +++
>  hw/hexagon/meson.build                    |  1 +
>  7 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100644 hw/hexagon/sa8775p_cdsp.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

