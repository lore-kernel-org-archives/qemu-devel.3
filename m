Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3450AC5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvEtj-0005og-O4; Sat, 15 Aug 2026 09:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEti-0005oB-EO
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:58:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEtg-0003fd-Ig
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:58:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDNK3I980300
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5LWHdVx1Zf4lW3z4pAOhboppNvxoPMiM5ape0K/TM5I=; b=djQh75X3DckF7hG9
 44v4xz12oKv1jqqmx6EaoVGZRviJ+BYED8eXpwo7YCbZZ0nfaZ16LFuTcxtFW3E/
 8EWjDPBuZGb8IuFNdwzdpKhVE4ezZ37TE4SKuHL0SOD6BLgAad1h3rPgMXfkLvIC
 MAm89ifFH21LO4WINFRQ1GNg+7kaNbbxBEilMdKQ8AluPK2kasQw9/GAyPmRCvXj
 AUy+OQrfT4YIC5A3zBQSE3kOe7yYyk5ONR2pWt8CjGTj9dk+2+303ETdFbn2hoOE
 GaqIcXC7YNbXy/gMp0VcBKW3Kimi6wQNusLO8qSqyq8GfW7ZUrbUbEIj/lzxcMWg
 0LjIjw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghns2ws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:58:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9349c5af52bso345764385a.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786802282; x=1787407082; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5LWHdVx1Zf4lW3z4pAOhboppNvxoPMiM5ape0K/TM5I=;
 b=QfsnFOsDc8wkuTWiUtnhvhFcb1pj/45IPhzsMiEcEt+UoZpqPyCzCC+tZIdHNKX5cP
 B/BWlaOMwme3xb1m323gBlqYyJsgru0fwdcDtcVe6mqvCWikkQLXwqCpqgfYE2ZZ5mC1
 wwtHQoIMrEr+cIdI4vTsiaxqgoGIZfF6GdJvt0lzy6efWjI3Cp5G1McxX+yoCU5PP1XL
 DLt0Qw1klCJmZTsOGjDk40DBARtHY+J9l0YRshsmpkPTR57S0fP1pZ0vSKNhoEKPJKWW
 G6U7q2U3gExX0PQ0M9WAJxhV6kQwB9143AHUT0FMf036P3KLvYcP/rC93VRN2rtk9hsg
 rERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786802282; x=1787407082;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5LWHdVx1Zf4lW3z4pAOhboppNvxoPMiM5ape0K/TM5I=;
 b=ek+aIZMwJXxz16kz2lvH7sD5RtxWSFTJxpTu79g0VqVeUHq3Y5PDxx91jN+ia9Rq5Y
 6spgwOwHsTl7ZEQYB498QfaxnWyXrdMvmys4yH115wX6O7fr0ghzwKKIPQ9TsSRGgP0e
 QpNZm1O9Rm8BZNqCC/7swM7HUjih1grpFhlHDV56ddMzIQnb7Bh5VLkEqSj+GH83QnNT
 KUUMhr5tVTZpyMnFs45PG3r15YN4mJXL5aW+yEiIJloNoyNDat2bklbIgjERD2/p1SaP
 RXl/JiaGj1BAyUQd1JZM0A5Ow9GmKjTSy8nu4L4R1JIO/3ErU/00XjHtJCCrz2R2rlSC
 mORw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+IwAp9wwCmXB6E9rUNvA1N2ax1QCIyIAKJufihLuNuTgF0nrrhXwXs5Kf9VSEz8ti0xVOi3kcDPcN@nongnu.org
X-Gm-Message-State: AOJu0YzZFDLVMCkjBI7Qf4/hitKysaKKhbEAWOuw9xa4RsUX5dvZgXg9
 FdW/oqmWhVk7Zg7Lj1/eB2LFUsWAgpKNplU90b6zo4OwooJG8x1NlTQHh3uiMIdyyPOfVxEbHxF
 GXJg9rSYaEovRaXu550GuLEkxemAMl2Vf+ZRM9valn9c4JQgYVYEGI5BT8g==
X-Gm-Gg: AR+sD11Hpu3w+0NK6XenVLb+q3c/qf2FOwUFx7hM7NAHCo6e6SVzKurMlriOwTTGrk7
 tCNEKGxqAPsZBoLroDED8OypKBccEyPg6FprVRDKDE3SQN33R0eatoxhdLFis+3b17ewdHRmvAN
 NBoYCgvmFBDBVz9AcZrHGFehlBeA4ImWW+zygU9VSAQTQCh2OISa2nIR+Xx9WjSF5yMYRz2iCq6
 qgpBMx+qnspjvx42gtdO0QMYa6cK8MwULgJ/OnOIuYirUnDH3mDig5PYuzmZJY5wbeDJe3gpoZG
 HSMQoS4sjPmSqa7WeDjubG3MZO8UwIRH3QNA8YRJYSfBb7rQl40YFrgK5Tu6A0UlquWRb9jsT/H
 jDFQ6rz/Tg/vmXhSTi0h1w4q7k91RkK4d++o=
X-Received: by 2002:a05:622a:8614:10b0:52d:8743:bc52 with SMTP id
 d75a77b69052e-52d8743be05mr84968841cf.34.1786802281925; 
 Sat, 15 Aug 2026 06:58:01 -0700 (PDT)
X-Received: by 2002:a05:622a:8614:10b0:52d:8743:bc52 with SMTP id
 d75a77b69052e-52d8743be05mr84968641cf.34.1786802281517; 
 Sat, 15 Aug 2026 06:58:01 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b25625sm147572165e9.13.2026.08.15.06.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:58:00 -0700 (PDT)
Message-ID: <0ccb0d65-b185-4700-af98-faa27a806aa4@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 15:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/char: add K230 DW 8250-compatible UART
Content-Language: en-US
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
 <20260808-feat-k230-uart-v3-v3-1-d73b31f0034b@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260808-feat-k230-uart-v3-v3-1-d73b31f0034b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMSBTYWx0ZWRfXxE3Uf+i/zXSZ
 hJVXxNdlELAWRhj2R2U5m9kvFYEQCXRO6A+jQcQ7yQgBJ9/3u62Z6cq47hCZIXupy0MQA6Nac0U
 YmQZyg3PVeTwQF06Nz2TnVbW1J1NjMExJ+JI4SI17ZH7zJwjrCRdjuDK2spdfXwX8PCgNJpP369
 1WgceUThZUl4frrpvx3QZzbxScmjFlKqNFYYR/4XnrLk1LXQhvU9iBP57sfkF98vcBMTiiD2vba
 TcJ3XhHAgQdENNM1lZs7GQYZ+oEnscxS9AfSqLhEfvW3UO1Za1g/pvwkm96rY+s6EE3wZSWMRIT
 D2Q1/xNbIhumbeZNiBGeqx1MOlhSVMj16TyauONhqr+H2oDwPY4MGnjMTC3VRx7vK7ClEM8Wmlf
 OMi06xi7QH/RKZeaqFAG2IDOBsSISSDRyV8vfKZtSqjlxVR0/sLBc3VbXQCwCv381Vh2qbjs7Md
 LhN3JoIMLjZmaa4bEiA==
X-Proofpoint-ORIG-GUID: 7ZfTaHli5sCTGNtOrMnxPFnLGU8g-BY0
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a80706a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=moOIGioJgd6YXtDZ1I4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMSBTYWx0ZWRfX9zcPNm2vuWZq
 kU12DzUvF6fsiZ3FqmV7QnNbwqv0tShDhlxVZshivNDPbaphQ6qaZpdDDKwv3AKOxS1bBrwaZwK
 422D7RY2bSuDRz6IiI13Mn1YLRbrC38=
X-Proofpoint-GUID: 7ZfTaHli5sCTGNtOrMnxPFnLGU8g-BY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

On 8/8/26 04:32, WX Chen wrote:
> Implement a K230 SoC DesignWare 8250-compatible UART controller model for
> QEMU, capable of running the Linux 8250_dw driver and providing an
> interactive shell.
> 
> Implemented:
>    - Standard 16550 registers (RBR/THR/DLL, IER/DLH, IIR/FCR, LCR, MCR,
>      LSR, MSR, SCR) and DesignWare-specific registers (USR, TFL, RFL, SRR,
>      SRTS, SBCR, SDMAM, SFE, SRT, STET, HTX, CPR, UCV, CTR)
>    - DLAB switching; 32-byte TX/RX FIFO; synchronous transmit with
>      backpressure handling
>    - Loopback mode; chardev BREAK routed to LSR.BI/FE via CHR_EVENT_BREAK
>    - Four-level prioritized interrupt scheme (ELSI / RX Data / Timeout /
>      THRE), with edge-triggered THRE
>    - RX Character Timeout interrupt (IID=0xc) with 4-char-time timer that
>      tracks the programmed divisor latch
>    - Busy Detect interrupt (IID=0x7): LCR (and its shadow SBCR) writes
>      while USR.BUSY=1 are rejected and raise IID=0x7, cleared by reading
>      USR; USR.BUSY reflects TX-not-empty / RX-data-ready
>    - Shadow registers alias their underlying fields
>    - SRR (UR/RFR/XFR) self-clearing software reset
> 
> Not implemented:
>    - RS485 transceiver control (TCR/DE_EN/RE_EN/DET/TAT)
>    - 9-bit multidrop (LCR_EXT/RAR/TAR)
>    - Fractional baud rate (DLF)
>    - Auto Flow Control (MCR.AFCE)
>    - IrDA SIR mode (MCR.SIRE)
>    - Low-power divisor latch (LPDLL/LPDLH)
>    - FIFO access test mode (FAR/TFR/RFW)
>    - DMA Software Acknowledge (DMASA)
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---
>   hw/char/Kconfig             |   3 +
>   hw/char/k230_uart.c         | 816 ++++++++++++++++++++++++++++++++++++++++++++

How much this diverges of the generic 8250 model we have?

In order to reduce maintenance burden with duplicated code, the
project preference is to use the inheritance pattern of oriented
bject programming, in particular with QOM APIs.

This model could inherit from our generic model with:

   TypeInfo::parent = TYPE_SERIAL

then override its specific methods.

Could you have a look and justify the full rewrite?

Thanks,

Phil.

>   hw/char/meson.build         |   1 +
>   include/hw/char/k230_uart.h | 198 +++++++++++
>   4 files changed, 1018 insertions(+)


