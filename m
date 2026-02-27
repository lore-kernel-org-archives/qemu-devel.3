Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58937FD9E30
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 02:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvnfd-0000t2-2X; Thu, 26 Feb 2026 21:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vvnfb-0000s9-DE
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 21:33:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vvnfZ-0001qo-R0
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 21:33:35 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61R2KJ3A2440245
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2AixRjXaqeQyoT5uj5VhVZNfiB7RT+gbFIJW/+gtHAQ=; b=XZfDfj0DELtU5uYA
 viuHJib4i0ruyrNTvRoUjvHCdmqpNF5tF7TI6aIGbYwWWIq68KQttxcSTVAGeRvs
 zVGtQ7CXqA8pY3L2RbcNI7F1UPlMk/b22zSVVMaLBpvGQtrQDsNid7FEsBiv6Ria
 osJwa1YVsSktYhEACkHTQ4dCyfw6QLM5wgJwqcXTorrWqhAJQducbelQq8YBTx1b
 A6r1g3dB8sZaGwY3hBOXvY3vxFFOmjbdbc5cEYog3vBHq9RYEbNjt0rpWC8MZeGl
 bytWeCzqiK/oRGBxmwPD7Lf++IWmwb6r5j+GvwQFDwYQRdUefIeXl+a1HjH978js
 D11Rxw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r1jp5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:33:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bddf271854so11085945eec.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 18:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772159611; x=1772764411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2AixRjXaqeQyoT5uj5VhVZNfiB7RT+gbFIJW/+gtHAQ=;
 b=jHvwPFgDS6u3gAUGCyKohwCJA4R1D/IMZcHExqNSxWRh4OIOUxz2jxbPj6ov+vWY77
 OklS2ImIfS/nMYMy3OvkBBe2WWKbzx8/ab4IsMXW4+UbTz1eQ3Uq6h1YJY1iwvaTSCEH
 xWZMfPJreh+/jZxYlEG1ljm820AtYnyCKk937WfaD0q5aMevmyHuCyS//3tN2w3nKvpv
 pgUZGZ0u/PVU6w9Olj05xaFpYUS5epC3BlpO77gv4CSg4Cyq9ASHgr32ZsMrmMZb2VyG
 KxwhDvQHLFByfhig6zMOZN00QCZKMiowYJGcs041su8yv/VWTqFgNmhnpqEskHb3lubJ
 lCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772159611; x=1772764411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2AixRjXaqeQyoT5uj5VhVZNfiB7RT+gbFIJW/+gtHAQ=;
 b=C91zyVc5XeNtDbBeJG1uiY9g4X5uvNFEzdJf+QMWwtPxWmEQdxY6s/xJjcsKFL++fz
 BdbPn7tjOyGGfyN9ZF2PRkoMFHLw21Mh/7SejEKj07OuZp2EmWr7tryb2jdzrENhRxAj
 wxOcBk6SNO4ihizDWW8DthDzwVmG7gB1yjgvyA8/uJdc3TIgxdl7QSnS2bLADVWI8oRx
 U25a1B+nP+V0Vh7BqNPlH9TzoDX3Vbducv5Fph8cvetl2kgWhnnpoLTFGd5x8Bn8Mqmg
 SsZBV5bFn8VJYjmxc4Tm81xe8GLGIlI/zg/0LASnHoOC/t/BsrAdpGnwtW+B+3041zwM
 W01Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZPMYeYMT19zhLKDLv4T5ZuuOOBQEKWFSc38oVvMoro7/DOzRskrUpRatkq/HHEDNLg8xr0fiDkxyg@nongnu.org
X-Gm-Message-State: AOJu0Yz6sh22zDVFO9Gr9ll9FYxcHW/Ei8zabG5Ns7ZqhDgQsgOsNIqj
 fwP3ciOYxxpfXk7tkQEKryxL3IeDLsfrp3K037jfzanUMi31V7dZOntHHWOZGe+N6N8WwONG5Wr
 R60FwksvOXAh4IyJF+oukqTXklTgOp3GimATUyo2wSKE5Xv06fdzrUZo6Ig==
X-Gm-Gg: ATEYQzzvvQUuIMSZ9UwKbjbspnCKCnTYZ8SyBTh0P7nq5LoF0HqSPJE1wvFhZccz6rR
 8jW4Z6CplfKGqHNi5WYAI/O+sS/ydM5CvnJ93pzlyI1Mg5yijMt7e1SxyhQ6zMpYpQDud5IR/dY
 wK9fBBWIlGTks2zHaxMZwQ00P5D6WWGEGbidLgHa/35m4R8pGhp8XTr9BRBOHGUJZOuYNd93le6
 1SagE1ywZ1oIeVcF6C5+toIa5CbWHaYlPm4TgrcTzCFIM3NA37fVOHOWB1y4sel85sODtUsrDnq
 gKsR9JyhMv5KnAbr9FpSEH4sH+rXyH7JBRqRfQketsh80jEKKYoh0Ekt8TwXwVvnMvE7ZzUQzrK
 6ikD4Hm52lHgf4VX2omW+Hueddb2JX/8scP6C3kmoSP44WTYFhLv+7o7EfeP+RVsW1R7YvDL0hJ
 baGw==
X-Received: by 2002:a05:693c:3018:b0:2bd:c7bc:2d44 with SMTP id
 5a478bee46e88-2bde1e843b5mr697201eec.31.1772159610610; 
 Thu, 26 Feb 2026 18:33:30 -0800 (PST)
X-Received: by 2002:a05:693c:3018:b0:2bd:c7bc:2d44 with SMTP id
 5a478bee46e88-2bde1e843b5mr697187eec.31.1772159610063; 
 Thu, 26 Feb 2026 18:33:30 -0800 (PST)
Received: from [10.110.80.16] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1cf0045sm2957743eec.11.2026.02.26.18.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 18:33:29 -0800 (PST)
Message-ID: <a19985e2-c9ca-4158-9c64-e0d16ce40c8c@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 18:33:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] i3c: aspeed: Add I3C support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAxOSBTYWx0ZWRfXxshcNi7uFFwd
 iNUzI7Lf6GLLPrHoWG0PJs7mvc1D1cRUPOturuto3UnW9QauC+pDpXD8N1oVScOFC4zIqhNrruk
 SvG88xdIeK1YY+i47qLOW4D2/fGm18G4GI0dTg6a7dpDB14F5OQriPUxPfT0rqR2jYuhdnF8VPQ
 UsWdr7PiYMTvh7CbBH/x77vrPQygGlc38B5ZlgV/9I16w/EZ+RCVu44iKXXbDRiZcLGTxpPRGSw
 fHyJRwA4aKMVuHroWxESwaOZGrkytpvZPrSGB4MT9YD68PVYQLejAPBKa7RXj/Yo6bQ2sGtgRO7
 k3GtEa+QoxADTxKklFBKShrJKWY8vauKtRBS+jPLqYoHj/+ev3S1588kX2c/5KZYpF5V/2AzMRq
 WIgYeOl3r2ARu2e9JjiAU8AePgRsa+yieIkdpdLfCxaH7nVU7KaNHxf6pqe2HhswfCrgGtJOJmW
 zvVd7F+YI38MIyE9Z1A==
X-Proofpoint-GUID: 2F-LfL6N-EBfSYZBcKXxcH7aMUdl60ZZ
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a1027b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=V6i_gWB5W4swWFkNg9YA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 2F-LfL6N-EBfSYZBcKXxcH7aMUdl60ZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/24/2026 6:11 PM, Jamin Lin wrote:

>   The initial patch series was based on work by Joe Komlodi <komlodi@google.com>.
> 
>   This series adds I3C bus support to QEMU and adds more functionality to the
>   Aspeed I3C controller.
> 

Thanks Jaimin for the series, I was able to test this series to a good extent over the last week

Tested read/write transfers from guest Linux using i3ctransfer against the mock-i3c-target  on an AST2600 based machine
Looks good to me, Feel free to add my tag for the whole series

Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>



Jithu


