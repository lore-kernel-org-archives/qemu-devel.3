Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C067C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQgi-0008Qw-Mo; Thu, 16 Jul 2026 14:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkQgd-0008Lk-Iq
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:19:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkQgc-0003s2-2c
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:19:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GHZX0L385748
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dUEitCb9ahAPYJsbF4lxEsN49kaEGBf6OghfCzaRX4U=; b=VcN8224FaexZ3tmp
 YLc5xLx4sEGsdiXkluJrVedjZq/Dk4hyYC7vtnlrLOywILt0709+WhipIo1sbRF7
 HI3/OurDbNvwvmQizoUG5y2Ua7ZcR+Gf/aPmeMactMcCRgdHloJl4/8sBJ/itjv5
 oR/Ym7meEBynoNAoYJPLyglm4LLt0++NFXg3ilnPKJmmiVCXLZce5lffCtc2QUUF
 TX3WchB7bncgN+Y5KHvzQZ6fWCAZB2Jvp5r2fuhldfWhJ/4C9x56zw697OCC1BIJ
 JBOHlD08CBq/h2D/vup5h5FS+u9GTrkLPK9Qc6mZW0NFuVOXg1onQlZt1qgI8lxy
 vdFknw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6g5de-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:19:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so10275813a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225992; x=1784830792; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dUEitCb9ahAPYJsbF4lxEsN49kaEGBf6OghfCzaRX4U=;
 b=IhKVLEj7uteHedaA+VxRsoTfWWeDcaVGIcMLk0Iax/ZDQC0YPSBBWe1uNsrdoW51lh
 7yksohgGa9XCrIt7KRj+pYKX/iUS6NMSAkuzi82oUgrVy6ob8fZM9MQLPlpzKhVN399M
 n9AsC+OULWhWlb1pH+vm+dzdH4tm+Tmu6dB6qtxpxXRHlK30NKUUfTOO6i0PFPvYxrm6
 //UfYImuBC3h0UqlxT1Ky6pLzyh/IWBTe3PwpVVP35nucMGjcyPkcbny9y6sYaaub/qM
 mpUNEKCEhuJC7BrDuyky5+6rUIjXT2n9rUGxFDfRp15SBbJdpPSF1trb3fzWFPXiXhr+
 AOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225992; x=1784830792;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dUEitCb9ahAPYJsbF4lxEsN49kaEGBf6OghfCzaRX4U=;
 b=koQuMTKiN/E4AGSj0tIAmoSAwhBEgApKGL3uTjzV/FV5cAjSEyHCRXc02wfPiXCrPH
 xAEaozgrQAJgFbMGtqUBg4LTXEbyX2pZUDPAja23u4IfoBEWM7jIJhPU1YPe38lnEGn8
 /SwaM38eumKHl6oqQPIh/i00FdiCHRDf16SEvdjt7GIQxv78ly81EJ1l71X3woDYRANx
 FJldbJmHEANdd8M0DsNmaIIFDj2LyK9gBDkFe3VrKYiwAj49t7eXBfqpHijdh3ti035v
 svpsktle37UKrmdAR1t4UrfDJ9Z8h4mqC6/eCkGRfau/GBpeUKa4gPNcTpEUbQhQngV3
 gagw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrV9/q3eoIvRllWAFmMUdCRII6BQrRRt97u/VAnwc1S004FGSjmZS/FVyah2guwvscGUqEWjsIFC6x9@nongnu.org
X-Gm-Message-State: AOJu0YypglTPNieONaUJcQSFEsEMlSxljrJ8IiI4fjfMN2PcYEWk6VzY
 4sPh52ZMr+TW92DFxBAaCNb17JsnGiu5JY6MJdFf9bsM7Uu3CSEzsXJYCRP1A9ZP2yC7qPnI+4k
 IrZQLO2HDXQcEPMr8wp/ButJVhMI2NUp5vDnoROef+TE8pAWwwR+WjLQmeg==
X-Gm-Gg: AfdE7cniZqL/OSivY3bA4Fb9ORv5tYWX15Ggia5nPHiLLa93CFTflIRM/vp6Pu9apgi
 YUXEuXJyeHNzeGYucP5bZb6NtSN7bTuxUeM4OfhK2vsP7qOfU6MSnZimWeV/Sx2SIKq9sn+48os
 MhioAYEWl4+rCizKZG2+uHqgq8a1vjCo6ovqOzd+BnvJ0JhdFNT8KD+Ofvz7PkbWXtZ5A6rs/1E
 NGnHpGKDTHphFludIqiQyxAT14mr+KlApQAZhfJme1B3i7BcJ1pV4COTnA0x5WQ68jMjtCMYix0
 y7mjbAkUW/ZO2ZxakaJ/NE8x29GOKCfE2qf+Rr9LJS+M7qA8X3iLZ7LP9CIqOExwHopoQ1jkCPo
 zrSRk3DcytWzgv0IlqV0IjwJhQdsTpJ8l2fv1ODwL06EWtAcIeGUCpqKQRqktKYjNA19l
X-Received: by 2002:a05:6a20:43a9:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3c34d71bb83mr16468030637.37.1784225992083; 
 Thu, 16 Jul 2026 11:19:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:43a9:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3c34d71bb83mr16467999637.37.1784225991641; 
 Thu, 16 Jul 2026 11:19:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd432f1cesm19929904c88.11.2026.07.16.11.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 11:19:51 -0700 (PDT)
Message-ID: <55ab11d7-8318-406b-8b6c-54dcc8a63d29@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:19:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] target/hexagon: add main arch-specific
 semihosting operations
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
 <b66476c599c399031bb95bb6683e74835fee74ed.1784225209.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b66476c599c399031bb95bb6683e74835fee74ed.1784225209.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4OCBTYWx0ZWRfX50TeEHuV43J5
 ccMxWkQNZSWun71kTyWt+uddj9Gyvh7L4mfqLp5ZYlJoxLO1OfKYsu/O7ncjwAZV3LtXltyvzD9
 7XfOwHxMPJtt3aBrLfQ8Prie0HYDYGdqtLeWDZZ58ZkwsxP5VyGaz9SvZzirvmxPClNEqGTzRp2
 eUfL/6UsOPsH+AfA4nd/AzXewyx3j6P7ZiXl7Mi32oZASHSBLgr7E86+CLr5+Y1SDNy6LjCTxtb
 XYhwbbNOuaoCIvL/QyGAr0fbltRq9fF6UM1N2DS2fM9kF95hMkehKsunryYn9kWfzqdGR4KULtP
 unk8KAidZHjJZr7iPIlsWeoPYRzM/OSg9YXxxGsLMeZBBDEwito1dbyBXSAqClOfvAZLgQgAEWT
 G+sMbwBDiEZPEXQf9bCmxgti7w0PtLns4CAQ2omGvKAMkDtc9aA/ZzvNB135VJhvpLLDhkrFPGg
 Emqup7DHbv7EFYo1i5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4OCBTYWx0ZWRfX5bEUpm7uLHZt
 h3mF67Sf3K2OZ3ObINaUuls+6nWvsqKvOf14+KCRNLVa96e2onJ49puxc3zyZ4qgbFLD9ZtZ9zR
 nhW1xwT+oECDJ+nzpDpYusztyIejjaw=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a5920c8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=i2qBr1YnXRHWHLctaxUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: cKJl5J4I4a1IufM8kLPUtsX3FnFIx2dl
X-Proofpoint-ORIG-GUID: cKJl5J4I4a1IufM8kLPUtsX3FnFIx2dl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160188
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/16/2026 11:06 AM, Matheus Tavares Bernardino wrote:
> The Hexagon semihosting ABI extends the arm-compatible set with
> operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
> SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
> that baremetal programs using the standard Hexagon simulator ABI can
> perform file I/O when running on qemu-system-hexagon.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  include/semihosting/common-semi.h |   1 +
>  semihosting/arm-compat-semi.c     |   2 +-
>  target/hexagon/hexswi.c           | 298 +++++++++++++++++++++++++++++-
>  3 files changed, 299 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

