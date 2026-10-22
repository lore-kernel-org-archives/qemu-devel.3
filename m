Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ADE606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iX0/VOJo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XeCpYf2d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzRF-0002li-4y; Thu, 22 Oct 2026 16:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzR9-0002lF-8f
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:30:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzR5-0007vF-9r
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:30:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHaw81495580
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LETvwzLNjhRh29uX4rEwoltb4/XtQrPchWQEHW7Gr5U=; b=iX0/VOJofpPHnkmP
 lUGUk1YfZz/Lvtj4h54zsIbOAVdlLps3TQ2XV8SvV4TmaV/bmm665l5cLXhXzAFL
 9o78vKW09ISXw7ZhIWsUutIG6owpL3LPrrcSh0DHAvnbrPAVeMttRbm+8Y0p/dSa
 veVgcHqWs+Ahzccag7l3OzuA0xzpkryBzUVFuCR2FNOMMF/FG+mth+ZWqYJvwZMG
 DSpCiYeag+PUQTtPzbZlp7ywJm0zXnCZ/muoBr5ugRkBP54KkFxYVflewAV5JAOB
 QS5DzJONXjj30pWFN3Uuj7oP8auKpUkmxPAOBQmFtbLYUHH0BypYbjPzCNw1muhG
 Ge9geg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8eph-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:30:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c902e0da2so1539985eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792701045; x=1793305845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LETvwzLNjhRh29uX4rEwoltb4/XtQrPchWQEHW7Gr5U=;
 b=XeCpYf2diq1GwJf+zEbKG4c55YecDcTv420BponTlkVm0HttWLkPMh9rExwfhmDywn
 C7w0phlLoORAD104WySKQCK/toOuKnfWAD6pAagzIDsv9cdVnyL3uLsX16KTvMrrcQHS
 j+6+3inpaR5NyQy/nSIfoU0jEo1eP2Y6Sr6DEWd3dSdgUNwJUFt2dRgdYhWmhEwo4EOc
 DWvP1rCWyUZx5O8IUCIiP7qKfaK65wAMi+yerQXkJ6lPMAVUKN5QP3OH1xZbbZzX6X61
 myZ9HXTYgQ5WOOyHABaL7m00cyDmkI7bAPigf/qvqH53HrEDhf4RDvWo1DsFPUDhLEuQ
 XWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792701045; x=1793305845;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LETvwzLNjhRh29uX4rEwoltb4/XtQrPchWQEHW7Gr5U=;
 b=cVrOanzPP7hu/lNwcaEt51rfmOLLAGY6Jv9nCwDDJJ8oJ2naPo04ZB3SbDN6j1irfj
 A1ccLFg+aI69C+f21fuSgUWSZ4fcrz2S2p01XTbkrgHtKWA5lnIQlH3Rkc21MvKqfu4A
 ZLc7xqY8c/UcMA44WTvMzQTk6z3/IDhhAzDbTKB+dmwjUPmw/KT4gB4Mdq73/Ca2Yth1
 u5dvCdqp2sR0lfC0icZIshb0yUZbtZFGo8/v/qPye+JZQW9IcN9Kiqcgp4eIN487Mblj
 /3P/X3z11IWg7+KR7UB57jZMJQ3v085Q0O7tRwRUafCo/s0yCMzYgWmiQXveUWFMuWa2
 zedQ==
X-Gm-Message-State: AFq9FYIAkJvWy30IaYecmXMCo/9WiqLVoi72VVUTubH772LtmlwczsYY
 /ug502nUiOZKCURcv8poUuYnrJH+qQrKfskT9vq2MfY/1dLgoDrIWX2r7/oma//qXFic4KbdeEw
 5SVeA5XrN8ty9TCtb92AcGId0hFZQSa1tIM1CBEj+grdtKMH8C1gWZLnhTw==
X-Gm-Gg: AYBFou1uAc+FtwzEb+/Iek7wVQKnmJJm/DZTm49GnIe5/H9NFu0r22UHRNzQpSxTObb
 Aseu2amW6Iw9Nx3S+yGgfMusoSNmfjuIBQGR5BP6cSBZw/HVcNoaSgbGozdvHw3Ywbnvnd98ZN3
 Z7wi6aZqYEwL/pbze+gxv8qrM7ddmM6sUTQNZn8F41fSWb2A7jVbrAih8qqkpFAjyqKouy55U74
 ZScfqRZfKTax/TqEITw+AYLPJJa/w85zLRLE/T5EMSCf0V2dsQ3BzvipskZ+7WK15lHXMSLAiVM
 iu0mmjYALjQWXy5mrOCMtaUpLww3LBLWTobp/V5eBhTYHUnnVkMGnyRvh11KNSQZun3GjXfFzyy
 cnejn5yAUGCOLeZAAyVTR7kH190h4nfeTdQpkYS8ASLBmUM1cIt/HrR19qypYWDy50k6Atg==
X-Received: by 2002:a05:7022:1005:b0:185:6c8c:d860 with SMTP id
 a92af1059eb24-19599bd3184mr713997c88.5.1792701045326; 
 Thu, 22 Oct 2026 13:30:45 -0700 (PDT)
X-Received: by 2002:a05:7022:1005:b0:185:6c8c:d860 with SMTP id
 a92af1059eb24-19599bd3184mr713969c88.5.1792701044744; 
 Thu, 22 Oct 2026 13:30:44 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195eab24c9dsm325854c88.9.2026.10.22.13.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 13:30:44 -0700 (PDT)
Message-ID: <9e695340-1b23-4c69-ac1b-d28b245ccb59@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 13:30:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] tests/tcg fixes
To: Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019185600.2031729-1-farman@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019185600.2031729-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yezRzZDQPZuBXhK2eU3erpf_CgOjKeZ9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MSBTYWx0ZWRfX78dTNt3qRqdx
 ZQ6L58Ba1laOAiiTetym4j+Ms7p8kM3g5LmbxCaXXw/gaMHeFCGenbVENr+yf79iOGU/Yg4fKwW
 dPy1HzI7EaXmf5YBpcwmBZtKRGmc1rU=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada7276 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=vpHPgimwONWjb4lggYAA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MSBTYWx0ZWRfX3Q+8J6mjyseO
 Cgqt1FqjdE7DrDnYRTqAduMrhTE4F8uaPzmzy5Jj9Ntm0ipBoBJxjcpWg1n+IG/fGICMOa2QzxP
 oAMnH605P8MdJoelUjEeRDGu46jyenyXU3ngRrOh0iWSKmuaKjKo0+TZavfpBBYoelC/GjDqowb
 b3W6UPGFiQvD+6Q3oPjtE9jqLHTsQw3605Uq0lRkTlMA39NN/pRjYsHTZumZFpSEnJBsiVTcWk3
 F2owvU/fE035iHl5uuY6hdRmO8MLPqwnJnnN9y6xGRQMpt5/Lgku4v3FjzjfrWC5QDiloDW3iCw
 RZgNSW5GlKUX4GeLQAoZRZRJlNy3jT1BPFto9EFuzIOZSlbo/zZUAC8Ps3umyzYXc4/LO+toJhq
 OJAcbpAcVfXn2i+xQYKefLUtDlQ8Wj+Vcwk38KXxiU6ekUkfa+AzcmiDZi+cRRW5tTFyWKHFI+y
 FSqywYJ+JuXCmQjozEw==
X-Proofpoint-ORIG-GUID: yezRzZDQPZuBXhK2eU3erpf_CgOjKeZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220081
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

On 10/19/2026 11:55 AM, Eric Farman wrote:
> Hi,
> 
> Here's a quick turnaround on the tests/tcg fixes to address Pierrick's
> comments on v1.
> 
> Quoting the important part of v1:
> 
>  - Patch 1 addresses an endianness problem that shows up when running
>    on a big-endian (s390) host. It's existed for a while, as I can
>    recreate similar errors (if slightly different messages) at least
>    back to 11.0.0. Just never noticed (or looked into it) before.
>  - Patch 2 addresses a change in behavior that occurs in the powerpc
>    toolchain between power6 and power7 (based on experimentation with
>    gcc -mcpu= settings). The tests as they currently are run fine for me
>    on either an s390 or x86 host running Fedora, but fail on both hosts
>    running Debian. 
> 
> v1->v2:
>  - [PB] Add -mcpu in the loop processing the multiarch tests, rather than
>    skipping it and adding it later.
>  - [PB] Squash patches 2-4 into one
> v1: https://lore.kernel.org/qemu-devel/20261019151233.230172-1-farman@linux.ibm.com/
> 
> Eric Farman (2):
>   hw/i386: ELF endianness fixes
>   tests/tcg/ppc64: Run float_conv* against power8
> 
>  hw/i386/x86-common.c            |   6 +-
>  include/hw/elf_ops.h.inc        |  20 ++++-
>  tests/tcg/ppc64/float_convd.ref | 144 ++++++++++++++++----------------
>  tests/tcg/ppc64/float_convs.ref |  80 +++++++++---------
>  tests/tcg/ppc64/meson.build     |   6 ++
>  5 files changed, 140 insertions(+), 116 deletions(-)
> 

Series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


