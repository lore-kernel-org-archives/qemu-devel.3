Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4492606A333
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pJNgJWyJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D/mflCGg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvrH-0001sd-GQ; Tue, 24 Nov 2026 14:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVvrG-0001qM-7C
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:07:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVvrE-00034v-Hz
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:07:13 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXF7I3000179
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vhrxClnohqBMDWfpfiBE4WEQ+WVbwhaeguhsrod0CXM=; b=pJNgJWyJn3Ksfi6M
 90bL4izjnGqpsT+dY9KsC0MIAfSQVGikLhJmUmf5XLU3RzaHu0HUOv3wYUywUXEO
 VljewZy9q9ZQEGeVmXWu020udsvDRp9io/1Crl8VebVWmnCluzPUY61v4uSZXrjd
 NaQZf9wkA+bho9uhJKCiJwN0U519tb/LDPdmWRETOqySV+RE5/F/Mm/6BJw9w1Yy
 Kbzi565KJWRwb/2p51m9zzTCcrWm5i60EWWGrnEOZjXfPKMRHDS/FnBRmF16L0ei
 /OK7m7Oy3Qq+Fnb4bJPEgjiysiiyIiHN7ZwMHIZ1C8qCvpOGc4LWl7sc45QBpv6U
 uz9Wyg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5f00gdhu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:07:10 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b3b5b49cabso4459495c88.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547230; x=1796152030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vhrxClnohqBMDWfpfiBE4WEQ+WVbwhaeguhsrod0CXM=;
 b=D/mflCGgkC0NBZQTWfgJyla3v3GnK2Yu7BSqEbhV+bpTAN6Fh6rosctktppXrOrNFi
 wEK+jy7tUsnxd+E+ckhVl9M8vy3fzeh29OVm/heQmArbrUi0UZEsmL6HE6fXSlK4EfuG
 jKwYjGQOLqH7be8KP5L/Y7w1p5eBa34FlIVD8gCoooEhl5AXCkjF0AtDqkjWszR1qn15
 6DHlCNujs3iE1CQfz4jtWGe5AfJ2RKOMB62nJdEsbxZyDw8JFIjeIrCTevMGiLPokoYh
 6J1f17TXCoSnJx0yiRiR0RKnODln3X6vmrZc+vb1mBAYlgR7rIqPXYfqhEmQ66J0wBpH
 aIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547230; x=1796152030;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vhrxClnohqBMDWfpfiBE4WEQ+WVbwhaeguhsrod0CXM=;
 b=PfpggQh+FYl1BAjWdJUqBIz/L5L8mOdyeDKt3jopc1GfVBFI/Wl60FEzf/5Hki3JSg
 eN7KROFxZ8MoER9/8udx2jSPclKHmQ8dpIwzISl1M/nngu/TKiWMEy7/f5h6f8+IsZHR
 9vLOP4/ECFUdoRNETuQ2F/C1ne96Tmy5SPoal2TOscrN8Dlr3LJX4xPeHxG9913KMcx+
 4nnvgCQaskhbek3FmBufXQYxzOI19eeLmX5V7/ZbaJcQTMSL/FgyCkEU8mB+Lio94/iH
 ve0+EbCAwvkw+2mJHk8kaNjDjZi/t96rcyB2RLwnFMb315S2wGnDakIsOguZaZdeCvk1
 Py1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErF8ApZ5L9VUsrqo2VliQhwyQBDiIyTImSZ7WZ3c0aACP7A6Ny0QG2OEgoGE0PgGletVhGLtYllZ2dpS@nongnu.org
X-Gm-Message-State: APuU4Z8oiz0/qtZC+0+O37X66NbJdE883pz2EVn6FpWLm8Alf78avq15
 wdOB57IjzOHUc394Ap2ae0dWQO92hpSg61ATyMr+nuPf+KlppnRliuYjzP3nffw7erYBrcVcQoM
 cYD6VA3ErGLwbtK+2nQKMcGw1YY+Hi48E3TgJXVZnuzxbSHJaSVMlwthGjNnMvUKkcw==
X-Gm-Gg: AZFdTZdCNOGOOGe8JPb+M2Y/UO6+alY1o1/6o/dXefqCD8sz+jgq7SkeULdiuw5LuaY
 dBwf3l2LyRGuX9/H74Dh9uc6M5B+eTUc2s3D4l86kFDGHujDcfCTeQQj7TdW8t9UNvjc+MjkGHd
 De5LGW1snnR/h/U8kPQ6I8xHrbVxQJo09idITx9XCVCPBuUSGgj/pR6/Z0GEjNNubAiD5H/c2r/
 P8jXpZxkdrWlCqZM6S8Pcyxm2CFxvfc9OI8lG8j+N1u7PRp0Jf6nZHxlish96jJhjqZDhx/gq8h
 NZX8cKRiSeNrYtmm/otHSRD743Vr/IbZIVPFyG+rQgKl8eS22eEEOBLxPK0O4f3AobX2HKJvrQ8
 IMeno3ycp4XteHdTxPYYqH1tBvDfrtYB2mgtT2whcUDuSDwBH9hGzsItAgsEF/O6XBTsE3A5/rZ
 VtyS4UggyKGo6xhtp4ysMl66pThuMZecImCKlVWFmZLw0=
X-Received: by 2002:a05:7022:1585:b0:15b:7f7a:730d with SMTP id
 a92af1059eb24-1b55690c5a4mr16120293c88.28.1795547229944; 
 Tue, 24 Nov 2026 11:07:09 -0800 (PST)
X-Received: by 2002:a05:7022:1585:b0:15b:7f7a:730d with SMTP id
 a92af1059eb24-1b55690c5a4mr16120272c88.28.1795547229287; 
 Tue, 24 Nov 2026 11:07:09 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5569bffd2sm34272418c88.0.2026.11.24.11.07.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 11:07:08 -0800 (PST)
Message-ID: <f81d5090-c03e-4230-b0f1-becad4752f2e@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:07:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v3 5/7] target/hexagon: report the faulting
 packet for stack limit exceptions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
 <20261124190314.3882017-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261124190314.3882017-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YRalH54tZ1plkNEQvzTmc7m0-gs1K8VJ
X-Proofpoint-GUID: YRalH54tZ1plkNEQvzTmc7m0-gs1K8VJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfX+Q9nxCLZW4IE
 ozT9iVp5ASEdKAdkzrNOkuBiQ0wKSXqGlcuaeSRtz2ksWHV9hwFepnw5QNB5fLujh3LHC1Hk26s
 Eo43bux9Hcx4hHO0BH1hPcVCUfP1JyQ=
X-Authority-Analysis: v=2.4 cv=JqtkP84C c=1 sm=1 tr=0 ts=6b05e05e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=mcuABler3LHUAgRv5qgA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfXy4GBKHLOU1b6
 a7YAFZJ2an1mMcVBQqNOFd+y++No0RY2uKsHkuS7WepStkGfPVddoJm/Oy3QizyKxQUQDw4O4cY
 lASDi3hD0fQfI+fjwmQr4k/C2g2uYGk49DjsgBU1LQBEjNiR5bWKa7kU/5XsYptr3EoIpvgB8Ac
 ai3zTcQDuaXWqfjvq/rJmXNkcSGzh/fjz6Peb2lczOAgjfN5DkiFQrRu2LExaVq6aC3cQXB92ZL
 6/TD9LsXKdUgDtY24qmhZiLgT3J3naCrMHa29YDDRwXh87hWOeG55TLEXFH2f6uMgHewW3q98DE
 YZ6LT6QsCT+TiWNmH+yTKochH+HaanaDCBEnJ3+oNMhavGP9S/90EkcC543ugO2YwxWYS6D7ntX
 KEAeFoeE3Hp+gHpoAR06NbBJL6DNKH2tJIfpoRQkA0b5P3Z+dA95RrPpTltPzOjWDa6jYXPj+OS
 62ijZu1EtYgRUaNeVVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240075
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

On 11/24/2026 11:03 AM, Brian Cain wrote:
> The stack limit check raised the exception from a helper without
> updating the PC register, which is not kept current while a packet runs.
> The exception's ELR was whatever PC was last written, so a handler that
> skipped the faulting allocframe resumed at an earlier packet and took
> the same exception forever.  Pass the packet's PC to the helper.
> 
> This enables the framelimit systest.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/helper.h                   | 2 +-
>  target/hexagon/genptr.c                   | 3 ++-
>  target/hexagon/op_helper.c                | 4 +++-
>  tests/functional/hexagon/test_systests.py | 5 +++++
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

