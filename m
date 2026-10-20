Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277A606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K1BTKltO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rd7+OUpH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFDb-0003wF-8K; Tue, 20 Oct 2026 15:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFDV-0003n2-DT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:09:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFDT-0006NS-SN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:09:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI6Br22079813
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gwqKPrt5C2xuHAmwVd+y2DqnfbBflMUevE1Uzu5PZv4=; b=K1BTKltOUI+H/gsC
 jzhBRqWpce2QzLcdDHglBGV9amVnMMlEAdhyawRPNdkZENf9upiopgf4IVCYmXvh
 g6zFbc0hXuVfGgugOrCIcvXw8f5zjSHslM3VgOhQ+yZeIRer15B7VMdVvJr7bLac
 oTQFDTeRcERjS3nvitPl0c8d4wHUocuxlWjJyfsXo4eNy6Y/qVS2dYRSERH+B9TC
 xvi4RNIcpcxgJ2nR23fwxMUkE+xOLsP4/BZhAgWt7SmVlGmZjnHZ4If28NbQidEM
 QGwH68/oetXOvuFEpxwd/hiirqkLOFROnSEQBYZA5goQIyyqw4UP6yHAN7tvM1j1
 hgYawg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hr7m6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:09:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c3c370b17so6583558eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523381; x=1793128181; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gwqKPrt5C2xuHAmwVd+y2DqnfbBflMUevE1Uzu5PZv4=;
 b=Rd7+OUpHu9DDKX2M+YAhhj4hv1594caXhdAg/0tGCiwAjjFn9ID9KUPpjV6kCFyiNt
 X8locBukeRddfaM8QydAisyhNFeOZdFw81aBhrDAf1lnpkMJLlYdWitVwdCPFri/Z0hU
 cwrWUOOLGewxRFI7Kd7M3XGxy3J5tBZN6rS5/7Qv4Ao7WFe++89BN6QuE1LisbYSVrT/
 ydDLNma+Ur1IgYVJ/GpTY3MXR/OyyRNlJQqNfpNYyxPWJA/P82M2dC+y5lKnjE7bdIQp
 XnK6ndbXkaZVjaIKKVVvuWVW8v8IREiM/WyjLxSDEKZR1zrlddlOhyleQ6D9K973qevn
 5Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523381; x=1793128181;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gwqKPrt5C2xuHAmwVd+y2DqnfbBflMUevE1Uzu5PZv4=;
 b=C6g648k7wdI3al11vS3PEsCuUk7ymF//Ur472Mp05BZHOBMyYUwjeWGgJexTFDxqfX
 hCPiNF+z3VaqSmuWokVEmtIoOo+cQm3bLasVIUTXnsmR+K+m/3QAdf8L6h2gvtZwrlbw
 EOOJeKnyQqZJbWC7882LAQOLvQa8CMwSmg/QDaIN9lLsnIUdj2O6dlJ5DW87yR0VFEUf
 e+ZmOvqdHHCzOiEIA4TamYY+pscWLpk0VWOjBpfHcnPy2gyRzaQCU0kDAt/XaENaBfVq
 Jr/b+DOM6lpD4xyXxs0I62E+4fifOlabV+oyKMzrd6/9fRwVIlznTAHEOXKVSmFgKgCC
 oBeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsG9+ZaZIUN9ObdPpAy6xwfu+6NLv/ZYJkyRd3NES9FxYTem8O8AMM9Vh5UgfBcGbl1kWfwxtikJ1V@nongnu.org
X-Gm-Message-State: AFq9FYKv9OQYvE705XCpVdE59F1Cy0E4nAmxmjdE5wTtbsMYrHoaqTIn
 R/4IJZrv1RgGvfZ5MyOKZqMwW6RJoMCJGz3PeXhElO7+feiCPAy5QUy99VUtJTc2+b9tXMZrB+D
 MV6Dfag2Bcsb3NP9Rh3kbvXw7kGUrSSbIwgnh4wvlJBYEZwYQjkKa3I4wng==
X-Gm-Gg: AYBFou2z0i5dCzxTiQqEbvVDgqx7hMPrjqhPEn9hcNqbkX6JOuUz4CeC7TiCJKTOwf7
 iU0s5Qzvy5Qgbkwoehy1iP4L7hdAsRXVCuMrADb0zO1O8sSotjMZP7ovGLDtCi2NE6MWmLbaauE
 FVOyI3tBRC0WMAxfFFo7qRt6+g+T3gkxiPDwOf8FMxBmiC78szcEUA3RT6BXC01qq5M5QkdzLdx
 2wZ6D5Sok6S76vzGguaU0EK3mk6X2I7pHZLPemNf9BzwlaerJX8DHIW4G8w+mxwnjFsYsCUefCs
 lLGwuRGXrD2wICVmPrLjuBfZMwEhdBhyBvRNrDuUchBnDSOycluL9wrsu6YZq1DxflyMg9wfTE4
 oKuSynJ9ezGuMCQ4Zm1XBL3Hj4lWXbY0ceMZekXCNGVouXIYertm12J/E5w2AB/C5oDrSRg==
X-Received: by 2002:a05:7301:5808:b0:360:34e4:39d2 with SMTP id
 5a478bee46e88-3674d44a645mr286747eec.10.1792523380437; 
 Tue, 20 Oct 2026 12:09:40 -0700 (PDT)
X-Received: by 2002:a05:7301:5808:b0:360:34e4:39d2 with SMTP id
 5a478bee46e88-3674d44a645mr286688eec.10.1792523379802; 
 Tue, 20 Oct 2026 12:09:39 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc8439sm645830eec.11.2026.10.20.12.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:09:39 -0700 (PDT)
Message-ID: <b4ffb765-5b47-47c9-856b-2db7ff6b5c92@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:09:38 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/27] target/mips: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-15-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-15-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad7bc75 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=lY_aseLld7uLOnc1zocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX7JnPWt99Qbu2
 VTIPhOZouX/anxCHewZOqgVTwFCPH9INYorFRiVL+KJIinZA9rrZErirBqvMcFqyVTMWZLl8NUc
 InbgMXu/XDmFBQmVZmG3Bgq4Reg0jOs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXw48hZuAEMmpv
 ibdmXrPTFkNTnYUf11Tf1rb7PMh5T6Bim6AG3Ze+HH2IBBqLpYlNE4sjnDTsZQK6mlA1aRrAhN7
 Mx8aZrfG7iO6eXcbEPObBYS5Rp6zbVw/z+a/+f5o3k2HlxDncm8xeDFq87gavoS+u2gNIv6kHUv
 GZaYOVdzmo677XGoISjDDCIaA6RKG5ohcwMpeL2iTULG4RBgfHi9xxsWBVCMbHUUxc8YCbJWbgA
 zshe79TIr58LY9o7DgRiLfawTLPpelm8IjoLJlj8Mx1k8N3UJDHTmZ2Vk+XzGXrN2+DIpNli0PZ
 Jc8ltHkVSPHVYD6OH2Bd0mJqW8fMnqvNv5VhjJnERWfujqX0skw5CH8qkVdkXDDn+P8N6oadV2N
 VUCfPaQz29LpIDzevU10odWij36CufbbXAOx8BgulI+XoRFvWgqa865guDO4TRaKx5tk4kU+joj
 BxD7MscC+SEC2+tkQPw==
X-Proofpoint-GUID: 5cSycegsFIjEYOL_v3jhWPeTS67D8734
X-Proofpoint-ORIG-GUID: 5cSycegsFIjEYOL_v3jhWPeTS67D8734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200076
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

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> Register mips_exception_name() as the CPUClass::exception_name()
> handler, so the common exception logging can resolve MIPS exception
> codes to names. Return "unknown" for missing array entries.
> Remove the qemu_log_mask() call in do_raise_exception_err()
> because it would duplicate the one in log_raise_exception().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/mips/cpu.h              |  2 ++
>  target/mips/tcg/tcg-internal.h |  2 --
>  target/mips/cpu.c              |  1 +
>  target/mips/tcg/exception.c    | 10 +++-------
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

