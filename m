Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A22CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMCh-0006tH-Hx; Tue, 05 May 2026 16:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKMCg-0006sm-3B
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:17:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKMCe-00082O-8B
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:17:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645IoCs12187253
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 20:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g62WWP5yLXXyA6PV/IbyWqXiSw02/pxJiAzTHHxXZ4I=; b=QaXJ5N/jFvhRrlEm
 5nvRI9QgcTLdR++8YCeXbuVimlqMh9egL03cE1i1SDBilKnGUzxcWEhcJl4dVL2U
 ALIO6Ys7et3lTu/3LLh7lt5qAbW8etPWqSHan8GPTlE40ReRW0j+EhYdTOb+17zp
 5aNarGWfTfT0RyNTreHSdK3G5V0htx3pPqPDPuJz9doz5pgn6rliRVw6ETo3pwUY
 2biPiqzUO/bBXeoTOwJYfIOj/yfceRZzT1XJ2gPkx2H2+anDjPxqog5/0LSPwxQB
 y8CkBpx3ty88WdJ2GR345BllzYz0nuCjDCoic+eTTtOa3jmkQs2x40gZ2u5iK3wv
 YKZzaA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dygce1ytr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 20:17:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2efc342ef15so4545110eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778012229; x=1778617029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g62WWP5yLXXyA6PV/IbyWqXiSw02/pxJiAzTHHxXZ4I=;
 b=hZRRyzDjnBPBc+5d2j6n5N4DAGYS5l7YelqEq77qZb2aEIXyRoO+BFJZy/pyMYT/Wz
 LBOGFbY42DO43UmhRivOVjuv71G5CEdB4nCR16QJx6qMQJeCXR3XyCzNMF8iUPARm0GM
 71TrOD7xksImINjj4vDcZa6OETI9BQwO4N6hinNX+3xOw97M6eoHEHSSDZfcSQy1F+5Q
 45rmhVmNLt3nSThSmNMn6jMUxkEcWb0pGI2oNyRhotnMJArmt1Y067vkdlwed7F8o4xY
 6blnnCnA5Be5ENLgrGpkS9L4F5YOFPgjeZKvUANeU/lGlZ9PoYGqFC1F6DDf3zUY7f0g
 xZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012229; x=1778617029;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g62WWP5yLXXyA6PV/IbyWqXiSw02/pxJiAzTHHxXZ4I=;
 b=WFg687ky9WB5BdTU2cl/mZPrNADZFah8zuKmc/n3omvI9MkaDNwSYxSOkRrHxsslOZ
 iSeLv19/JoKFkjrw+1joSv8Wg47JOIWU3Ec3IfzZG9uWS/Fw1hg5MgPPCpJdkTBBSqxu
 c2dljcWjljT/ZTro0c7cfRoS7yLWCpa6dOt+wKaENMQv3CmE1qPTafvI1L6eY8TEYJpq
 lAHgnR/FMwZFerziMvX8TdjaT8lce5iaTbnPM3qbQu9ElcZYDr/lFZJbvSCzL8n2lMAb
 4/lskT8VrCctvNZseTRn19LMKFuExRQS4P/w8MQm1MOeSSdYC0gUXZ68Wq0pJRqT0bc1
 wSag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5tCOhG/LgLtnoHMoZdOMraUIOiL+zT8YhErJ164g3pywh8W/I/uUya5SUaTF2weh5dweq7NlpGX1r@nongnu.org
X-Gm-Message-State: AOJu0Yw0YlSfxeLPa1WUKQUCwDyqeKQcprRXu72mzwphfjUc7mLC1wX8
 5RtMXP6JCNs6AiwZcrZFBUDBgndDPYbKQGORPj1E1lyeu/O2SYHqPW1WWawXXRxukGON+oZas9R
 lOKbq76I2Cl3jT85nwbkwkSlt5v0JX4iOxsCwXl+Y4LQpgjwksz+VoEAT1w==
X-Gm-Gg: AeBDieslLX8D1rIBmG5jmY0+HQmYq943cEouypFn1ecLeZrtvz7RfnpqEpMfDZPPIzD
 iKmDiLj850etqNtT1TBYX8CT6uze/sXqmiuT4idYDJ1vTeWke4+TqZtmX7cRnlOQzs795c6qktx
 bVCMRXG07ooIEUzU/Ps4CfnxPY8Gg22F7xsleCs4aUmJn/0eOQImm3Ljlzv59kol13ETrDhgXN3
 8hEbKgaMTfiy7gWsNJ9w8ksbkbiPl4OqoNi8oTp0E35ZHBBEphn9+G09VKnFHNshMn6VI7VEz/e
 ysWcMzieFfU4z4m41CKRXWtWcRoXPYau/LL0FMnnhtHPV8/koGsQ8yyRj8n46js+/5ozUQTEtP0
 ZhOYMA69Fl5ee9jUxJF4NqYu1lj6SpKesp/pFG4bMIEm0AbdEwu6vW4+CSCHD6S8gM1ZJ+0ALkR
 FV1qGj4JFKnnSMsChnyfGUC61w
X-Received: by 2002:a05:7022:5f11:b0:12d:c1eb:3bb6 with SMTP id
 a92af1059eb24-131967d7b8fmr197949c88.8.1778012229188; 
 Tue, 05 May 2026 13:17:09 -0700 (PDT)
X-Received: by 2002:a05:7022:5f11:b0:12d:c1eb:3bb6 with SMTP id
 a92af1059eb24-131967d7b8fmr197930c88.8.1778012228435; 
 Tue, 05 May 2026 13:17:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-131f9679dc4sm344456c88.3.2026.05.05.13.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 13:17:07 -0700 (PDT)
Message-ID: <a0492f90-cb96-4a79-ab93-680b1cbd7b7d@oss.qualcomm.com>
Date: Tue, 5 May 2026 13:17:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mark struct ip6_header as QEMU_PACKED
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
References: <20260505201324.932323-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505201324.932323-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5NyBTYWx0ZWRfX4OCoybyStNhd
 t3zTJXT1MqAQmyyiF9/3XhyXg0ZHcpUoMqRodoAvyFLxA9ZTW2Bp5WqDYmRudcGgt0A8zWg3JTt
 N61euZA7Dzr2mrxuWQsvmyKDy9mjtdv4LOvpSldLYTtp6bek2PG9rUs06P6G9RUc5OVhSKyOaMM
 2gfBd5MYVJmbvQJY4XYdMAnR71vef/DOCp3KQHgVm3+ylacJVMIV5VSp+ApWEqVsbffhLkAjpm9
 J+ZiUxhjUYhhVSzfJgG3AgqfvUdO61T60/d2GsAKT5IcwDn9DLSZWvW6aJO7IZd0/Oyl4bxlY2k
 ymFzaY4wywYSust3ePkC6u0jCRpCAp3ELGMLweBbY5XhjJ746s+O9yzTIg49QvQpqGndccUYrVg
 GK5pUCcXNX0JY4EA3JsfYVdCjl+hH3T6q//XEx4dt3yd+ljpIFfWqHdt/6x6Bry3Hwa+6UQGZRW
 mQWo1r9m9Mh3qoLf2HA==
X-Proofpoint-GUID: 4cWoUffxukfCbTPO1kik9VB8HET_NA2c
X-Proofpoint-ORIG-GUID: 4cWoUffxukfCbTPO1kik9VB8HET_NA2c
X-Authority-Analysis: v=2.4 cv=b6KCJNGx c=1 sm=1 tr=0 ts=69fa5045 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wbSR7ExuzqgWBqXGAcYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050197
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

On 5/5/2026 1:13 PM, Peter Maydell wrote:
> The ip6_header is often used by network devices to examine structures in
> packet data, and it's not guaranteed to be aligned. This manifests as
> errors from the clang sanitizer like this one:
> 
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/net/rocker/rocker_of_dpa.c:321:37
> ../../hw/net/rocker/rocker_of_dpa.c:730:33: runtime error: member access within misaligned address 0x742970fe7ecd for type 'struct ip6_header', which requires 4 byte alignment
> 0x742970fe7ecd: note: pointer points here
>  00 00 02 81 00 60 00  00 00 00 38 3a ff fe 80  00 00 00 00 00 00 00 00  00 00 00 00 00 02 ff 02  00
>              ^
> 
> Fix this by marking the ip6_header struct as QEMU_PACKED, the way we
> have done to handle similar problems involving tcp_header, ip_header,
> etc.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Found this one while I was working on a rocker bug.
> 
>  include/net/eth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

