Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F0606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oJIfwVJO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c2BXoeh7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLm8k-0007D0-20; Tue, 27 Oct 2026 14:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLm8h-0007Ce-3n
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:43:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLm8f-0006YT-FX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:43:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHOO72945718
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qDDyDLGqcTb8IU39FxBKMoYtWWsXyFNnMFvBHhAGwAg=; b=oJIfwVJOBvtYsYVX
 DA+98vH04Obp4lHkh5IiHtMNQrb+iEcJdRNMV6SOfJXsx3Ou47EyPb0UCrKylaGF
 XlJe3SITaZHPT/cOw3WjH/eeMIBM4eKeo3edwiM8C1t5pCX7xwY9C/YirwkkeNOE
 cax5HY5q/ky+4apz/+PkSQl9ObgYquKBC85O9zAHy8GMfe5tjmMXxT//J9eyF1Qg
 UobSV6I0x8D9nXICKW/nu7IG38gGDE6hkN6+3fP2GvSoq1MgRtPA2OE5U+J+cGlT
 eri8w3pukSh1NFFV7JFnc6spIOf5Ks062vb5uCC4UCZyLzVla5vx7NKA4nAgG+yD
 0ILqKw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq6ah9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:43:12 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-19dbbe4b1d8so94158c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793126591; x=1793731391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qDDyDLGqcTb8IU39FxBKMoYtWWsXyFNnMFvBHhAGwAg=;
 b=c2BXoeh7HyuzKuRbyILDa4uQFpmpnVM2RQ7a/ds2VH1el/DJlDMBlK0Qi4w3fvvQmv
 XWYcAV03RhU68aNGx7eMdC6sIi/3njjrIeO/15Cfad7CKPwXuXkgzTFd3HtKRmLDvg1w
 q9RF6VHWJliQ6FJ5CqZEh+LnhuUy688CnbpzTYQthkPjRS9HWLn9ZELKOBm0nR/d5gTf
 6Ta5zkpcqYDTKeRivDbyaRI2GtS5whO6zDVnD70eqIESmPjKnbFD7nIvcoU38gAoXgZa
 haINprNNpCH6LOed8AXcWOsHW/lIoWYlvVB1Ujm5yRF0fzQWrTqyvhnrmfuuLxUKxlu5
 c/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793126591; x=1793731391;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qDDyDLGqcTb8IU39FxBKMoYtWWsXyFNnMFvBHhAGwAg=;
 b=zyat4f3SbH3oogTtDpwC3paQNX+MsEX9P8fjrk7reIxd9jbmlJ0hBqjmSv5qYh/1Wc
 AOxCnnvpUHx8nqAZ26qw9UeDpT+dacmHo3TXFSH1ffd1hc17fYY4Y1AzSDDqHf+usKpZ
 bE7vHZ2ho2LGgXbuV/dvXhyEx8tNL/RxXlMYsmqEokf2z8y/wbum1YDXcIH5ROxsUhhy
 xwGwqIpWhTGevdcT/WMGIJT/WoWlYw7LzRFZtLaOuDGPJWO0a0k3M3+Cdg/mzekReu82
 Ab+KBTtEmkWtX9HlX+GRBMW+yNMxHSR4aGJcVuhftJ1DpZb/Kr1uEU1gMMjlU7LPQPlY
 YOpA==
X-Forwarded-Encrypted: i=1;
 AKwUvByPFIDry+GOcEj+rRIIMe7vfKW/pCvUEUDe8+0LrNCS7YBcOFB/SCrpCOsY4qfM4bqtckce1HMpVD0i@nongnu.org
X-Gm-Message-State: AFq9FYImEDjJkwUQ6zJPWvuc+7pbdGN5R99lvX8h2IfkhaVHs7duITlc
 K92G4ZKW9dg2sSeZfYggV31j5Vdj076Fjj/79PsndxPTpCn9uFFSVLgriQYm9MpCdjZhe/HYWiP
 Aa2UfPyfQOwBSI7rb2VgM89uU71a/mC05w1HL0gte6ROthy1wOwm+uNE6UQ==
X-Gm-Gg: AYBFou1DkDODkCVDXD+p3DLgtYoyj6weLIjk28kjdykrqOED+9wuc4o3CD2MrxYXdE9
 H2LJroiUJo8hf1sby/sfBHvxi+jrftQE5wu2j1NV1FaMeCvZG2PKbBt9hLkQbLcgV5kbbhpWCY5
 8ytvpVswsLPgaZIu/0Ib3XMaYAiwyqWJx9dW0ByYkC0o74WFSaaJHk/LIjr6ey3UitO9smpZb5m
 P+IMBX2oWqOe/jtkSo0vjoS1OcenIRYPgfl6rmKQtwqkzpwmkFXQSUqEsNJ0UIbHJHqZo/LRpQu
 NTzRN+zN2kiNTHTuwUZtHaDCw/KjNvkVQryztm05TlghMcVjMvGWoQ6zJF6H3TTmdI++wHQBF8o
 cjXczj8JGLhjmPmxYPMmWEPs0/30GShGdrJU0kAOyHXi32ehPtfoiK5/iAFEeHCLz0yMy7Q==
X-Received: by 2002:a05:701b:2515:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-1a6cd3a138fmr102060c88.10.1793126591112; 
 Tue, 27 Oct 2026 11:43:11 -0700 (PDT)
X-Received: by 2002:a05:701b:2515:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-1a6cd3a138fmr102027c88.10.1793126590408; 
 Tue, 27 Oct 2026 11:43:10 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a002a486csm20740628eec.22.2026.10.27.11.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 11:43:09 -0700 (PDT)
Message-ID: <c47cf1a7-15ba-46bb-8579-1b5a2367f2fd@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 10:43:09 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/misc: QUP UART device
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261027183823.383806-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261027183823.383806-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0f0c0 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1fEj3FehfFSb209yl4QA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: nFTUqTGZvbRSTAOy5Lsg-_zERFG4JSFD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NCBTYWx0ZWRfXy5mSKryurMZY
 aQCIdzhtT9jL1pGcgmn50fEGWXW/afd4hu60tQvcfhDR2BGZ1uVI+Xg8jJo0tQ4eB+0XtlVKdWT
 GkTJx0Cv0//+PtJCKw73XAqIaxVWFF4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NCBTYWx0ZWRfXx3BKabE3AbMJ
 EtFRLWxZFfPHAlf2/fWZVsw0QWHSsvVjO3QPyI6v8SZTcz7fMdIh+ZI05lUOos4J5a/rFy9dyLP
 UAaC6phW6b8kZnNQ1cqKxbjUockJ/gxGIV05qQC+GiOKC7OSU33tQeTziprA3OSh0+rY90wRkfP
 TBPYzsvh+LucWjaSXHpe86s3RM74mtlGU+kC+rF7U9prECBxBS9uf+txCDo6tXMCHvIjRvqDt8O
 2kqAgfUOAgjNBm7/YfCSS6LgfmD5bcjE8a0mgpOmbJDBrs8qu6VuzAzewSfkiKH9OrfneEwpRSX
 YxuBbpkZX+N1gyCTWnzZZcY+8gZXRoj+x68NHKWpY1SR0wUacnLd9n+Z/GzAGrdhQo7PPjfAGq1
 eEyubo24BfjxnB/k3F/7V261+WelG8h4ezXHD9rAlrilD58TrKq8KNkhFXkz6MLSxcR7/I66Vjl
 05cK3ct8Ege2uxYHY8Q==
X-Proofpoint-ORIG-GUID: nFTUqTGZvbRSTAOy5Lsg-_zERFG4JSFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/2026 10:38 AM, Brian Cain wrote:
> Add the QUP + GENI uart device models.  The QUP is a "Universal Peripheral"
> present on Qualcomm SoCs, with connections for SPI, UART, I2C, I3C.  For
> now we're only interested in UART.
> 
> Will follow up with a v2 including wiring into machines + qtest after
> https://lore.kernel.org/qemu-devel/20261027143721.4125584-1-brian.cain@oss.qualcomm.com/
> lands.
> 
> Brian Cain (3):
>   hw/misc: add the QUP wrapper device
>   rust/chardev: fix write errors and add write watches
>   rust/hw/char: add QUP GENI UART device model
> 
>  MAINTAINERS                                 |    3 +
>  docs/system/device-emulation.rst            |    1 +
>  docs/system/devices/qup.rst                 |   10 +
>  include/hw/misc/qup-wrapper.h               |   27 +
>  hw/misc/qup-wrapper.c                       |   90 ++
>  Cargo.lock                                  |   15 +
>  Cargo.toml                                  |    1 +
>  hw/misc/Kconfig                             |    3 +
>  hw/misc/meson.build                         |    3 +
>  rust/chardev/src/chardev.rs                 |   82 +-
>  rust/hw/char/Kconfig                        |    4 +
>  rust/hw/char/meson.build                    |    1 +
>  rust/hw/char/qup_geni_uart/Cargo.toml       |   27 +
>  rust/hw/char/qup_geni_uart/meson.build      |   28 +
>  rust/hw/char/qup_geni_uart/src/device.rs    | 1293 +++++++++++++++++++
>  rust/hw/char/qup_geni_uart/src/lib.rs       |    9 +
>  rust/hw/char/qup_geni_uart/src/registers.rs |  160 +++
>  17 files changed, 1741 insertions(+), 16 deletions(-)
>  create mode 100644 docs/system/devices/qup.rst
>  create mode 100644 include/hw/misc/qup-wrapper.h
>  create mode 100644 hw/misc/qup-wrapper.c
>  create mode 100644 rust/hw/char/qup_geni_uart/Cargo.toml
>  create mode 100644 rust/hw/char/qup_geni_uart/meson.build
>  create mode 100644 rust/hw/char/qup_geni_uart/src/device.rs
>  create mode 100644 rust/hw/char/qup_geni_uart/src/lib.rs
>  create mode 100644 rust/hw/char/qup_geni_uart/src/registers.rs
> 

Any specific reason to have this implemented in Rust?

Not a bad thing in itself, but it means it's only available with rust
builds, which can be a problem if a machine defined in C wants to use it
unconditionally. Rust is not (yet) a mandatory dep for QEMU.

Regards,
Pierrick

