Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01845606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=In3gLZIz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MoeWWGhG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJz7m-0002xP-8r; Thu, 22 Oct 2026 16:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJz7S-0002wo-Nv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:10:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJz7P-0005ra-Ua
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:10:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtxvp409422
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lbcq2qhjBkbAcBpCLkwlmezH0NApbXFvukR2gnusaqs=; b=In3gLZIzWE1GFYz5
 4F6EgRZC394mk5BKZ4AEv4CXIx5kPF72C4KSJRh1pUKPwBO8NBnBygFBXLWjp6In
 wE56w2LhKck2tqSszCuCNF4/XvwA8NZYQCxFjsoBbA5Ck7dWym+dcmgFYHl3UJva
 eMXKHhYr8xFa2akLd2eoNq0MOOSgsufN26ljW5XN5iTTsPYxVSoBlT2xPRekqCDc
 29Pgf9i+pu8N8WZBQ72ou98jpAS+xuBcToP8vIg4AZ8KBY7mTgz7GhLexNqzBBXE
 cA16IZ0luYqpL5Cg1uNcNfJ5CV4pYUp7rqoutGzVLqUJWM/+vCCs7vrOjuGcTgQy
 u3ylsQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a5bme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:10:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so808591eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792699828; x=1793304628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lbcq2qhjBkbAcBpCLkwlmezH0NApbXFvukR2gnusaqs=;
 b=MoeWWGhGONK9MQwP+U4SNoNfUToo+UmIedPEnKvhTDxs1xyMlWIuQ4NqclU7YWlKoO
 kt3CHr1SLgx8TT1akM0GJpiF74J8Cz0MwxYvF+LqJk3fLscxBYR2a73d9DbBx/bBj477
 bpdo952wFjCR9RttvLOLwUkAEtGHwq6dMxJxzDfTyS7IRVSEFK1XoiwmeCUZpzC5zz+N
 +yvxpV1oO6mJQqEK0Fvk1uOakdDc7bu861z+qaaqJKWAyApcZUKH/9tkI5hm+m6xTfRO
 sQ2LebmqlABblv1qJdbQxdovFT32zpi2H7Av1uxuEBSHoyJmU4yya6NrWdAXppYgtsf/
 euyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792699828; x=1793304628;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lbcq2qhjBkbAcBpCLkwlmezH0NApbXFvukR2gnusaqs=;
 b=GbLHVSLwY70VQM3OkBk6820TQ63SY2gMulGHw6fWVYqCRu/WRYXiL+N7JIJIiU/l1o
 CNdNC2E+wJ0djEKkc/IzTCA//4AZKxz4C0kH4eechGV0TpQ94j1BJ27YzitRvB2gNg3T
 fCPzytEYu2VlpMr7h8BS0skNOlpObii9UfBO4vZ6urmPRQLWAPSiGPcxiPm2boe6h/Hn
 r4vA+psiMQjXfGyymZa4/4bBXWsnFAD6BwtVMGZySEZesEKd8t2tOdTzAfFgXk/9SK3+
 zGU10zcgHxrwO42h9YqOiXdsfDj6p+u6kDeEXE17hsCwS8K5pHuUfeleJsn6HJGqkQG/
 PbOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1x2ZEn7xUA5VAG9tjGlyuqiBe4JZgJKzfTOLKiAPOxMXbJyftnU0mEIknxkLU68o6fSVP9xW398g0@nongnu.org
X-Gm-Message-State: AFq9FYJ7Ly/YAkVoDfr62ZzodzcoOGIjFuWEMNFhYosuNM36q/x6LWkQ
 nDSLCsLsDEC7Zs7LmUI0TObdZLpv9J/N9Ks4THW/nmreSpsCi8Bn00eZMaQDcxoYL3kGfjDuBdQ
 HAXTiR/vdDF1/ESyQ38K60W68b6VehPSBQH0bdR4oX6vBzvWxXNtPr/PPAw==
X-Gm-Gg: AYBFou3sgcCaolQzHUWeRcejg9lfROKc7enhp/8rkV7da6Y20zeF1I7MAEBrv5rdcL5
 KyWU3dqpCfFbthUtQbKudwEmiJg2bJwGAn/yPVvwiLBuSgfA8m3WKsvZWKM6+pkbbm+ncthIMoa
 N3ZlsQB7qRowgyebLl62c1cjRytmFUtpXfqrZ657Lq3ldbmizRg5pCEPREtVfBUiUgIevWtrP6U
 4VayeHr4xHdtFvr/gmP0OehBDwSaYXy98222iVlehMa+PGLYgSK4Ew606V3rB87KqEBYg+HKFC5
 o/eP3s2PitgnxQvB54yeNNOx8OA8Cfj+naG6fxUodn7ze73zA3j0d5GaYHWddo7JF88jD+VIjFD
 9hI21UbtXkNhhKNBuNz/ZKthRy7BIk9xLOmUs2bxL3MAQyuGTJa1htuXYxxjiuRYvqi0TJw==
X-Received: by 2002:a05:7300:fe45:b0:339:7b3b:236d with SMTP id
 5a478bee46e88-369d977eedemr247772eec.15.1792699827662; 
 Thu, 22 Oct 2026 13:10:27 -0700 (PDT)
X-Received: by 2002:a05:7300:fe45:b0:339:7b3b:236d with SMTP id
 5a478bee46e88-369d977eedemr247745eec.15.1792699827093; 
 Thu, 22 Oct 2026 13:10:27 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5ea64sm312634eec.5.2026.10.22.13.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 13:10:25 -0700 (PDT)
Message-ID: <52c57348-dc18-4ada-a613-f34da06d00a8@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 13:10:24 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Use QemuSemaphore to wait for clone child
 thread
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20261022163718.562442-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022163718.562442-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfX+xLCYn0aVd7x
 iqYOkkBbWaWJq2t7Br1n8DiQyr071U42iYZHTtGJG7V2tH7l7JJSgRhde7Y232uk9Ev+MF2s/DO
 uda3WyONRFaIWuivZatd2/YKIh9DFLROeQH+P1rztFxBPCYn+RbBzdWB/xYj9y+1W9c6uxCGQOW
 xG9umyPmgGWb3NZy9NY+krylOPnjVRBWHmmPYdwO2BJkRgtCgo7m2QH4O9SH1aam2PndHWru0Ez
 CaSAUes6zeirvZJEZJMjSdD/jAlwIM0qrsrJpwItyDLFPvw8YpZbW9OfGVndJkRSc13k1HTweFy
 ZjF+2+NqxUYr93fKpP6Mc8A0RzSfPQww1d/nYD4QWuf7ck1awUDaQMOE6i6DyZPiVZ7ZXwOG81x
 ARW3axUsTSSzcBKhS4eaAyApI+NDmGBq2z2E7RXLRzf32n1FlEp/QeYr4UXlPXsO46U26r10e4i
 uQ4qV0tyeMa8EsGGxBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfX2Mo1A+W8ahIY
 /1Xk7ZiLbcjJghaJ8txSbXrsTnZIPf+osImUpxqfNVoOH0Mgz36OhNdX63l0YZlWGnNG/dPTROH
 SmuDagNnDizAbowZEk/RH778nM92WUQ=
X-Proofpoint-GUID: xwUdRPv4DmxGHUt-gOEj4FumDjkfz4-n
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ada6db4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pL82vkdrVt9kQNf1YA0A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: xwUdRPv4DmxGHUt-gOEj4FumDjkfz4-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220080
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

On 10/22/2026 9:37 AM, Peter Maydell wrote:
> In do_fork() and clone_func() we currently use a pthread_mutex_t and
> a pthread_cond_t to allow the parent thread to wait until the child
> thread has started and e.g.  set fields like info->tid, before the
> parent reads those fields and otherwise proceeds.
> 
> Coverity points out that this use of a pthread condition variable
> isn't reliable: pthread_cond_wait() may wake up spuriously, so the
> idiom for "wait on a condition" should be "loop around calling
> pthread_cond_wait() until a predicate that was updated by the caller
> of pthread_cond_broadcast() is true".
> 
> This is quite old code; rather than fixing up its use of raw pthread
> condition variables, we can use a QemuSemaphore.  This gives us the
> "thread A waits until thread B signals it" semantics we want.  (Under
> the hood it is implemented with a mutex and condition variable.)
> 
> Cc: qemu-stable@nongnu.org
> Resolves: CID 1527417
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> cc stable because in theory this could result in the parent thread
> waking up too early and weird stuff happening; however my guess is
> that in practice with one waiter and one signaller that the
> "spurious wakeup" case won't happen. At any rate this code has
> been like this for a very long time.
> 
> Disclaimer: tested with "make check" only, but that does include
> various linux-user tests that use multiple threads.
> ---
>  linux-user/syscall.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 

LGTM,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

