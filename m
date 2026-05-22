Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40C7CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZLh-0002FY-0p; Fri, 22 May 2026 19:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZLc-0002FP-M1
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:32:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZLY-000796-3p
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:32:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MH1RMm1801155
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wC+bunPOLt96fBPcfMzAF9bjbXlcHLDPzddadlN152E=; b=DEEReKP7r3ErIh1i
 SzbtunB2fajXNECn3wmuA6XnMDWH0pO0wa7HvkS5tf/7JBkQhomD1snTSGSiRlte
 meR5dWgTtX0++g7YfqCifc3BMZibECVmdBkWMCNssFxCxddQ+hGwnjersgNqhdJV
 WaloGEMQ6dVOFymxG+M1KiRetrbyglksjRQKhQvlQSuxFvQ985z+1HUEXPtCvmdr
 njysV8WR6nlrlxhOPNzCdQLqSjvWf89BMhdWMdAuFA4LN1p+t23IYyUE7OLwc4Q+
 zdQd1dNs3awr6RTGpikUNeEgSyroSUdd45rWBlu2hOGKHa6rZEGBB5d91d9uDLc1
 Y9obWg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g2pv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:32:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304448ab58cso5761029eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779492721; x=1780097521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wC+bunPOLt96fBPcfMzAF9bjbXlcHLDPzddadlN152E=;
 b=OifK3NjLHK3qAnoQO5KKYGV1mTFJliZL9Mki0BKnI+b6pYQCfqTs7/Y1si/C2IUEU+
 8nvy6HOVf8yNus6KNspp/aI//Sa3MmEU6lPrqr1zeayAcwLAvKAdGLfJ85uj0pYRZfKF
 IXzY+ipDJpk6DI9PXtTctmyaRivCHTdmpgbH1apQb256snLd+R0j8WUXOs1MxhiFDH8f
 1OnzSj+1ZYT0l3wBqJhExP1Kg//m10MAbWKgfsra84SwHQmYDkoTaEJ1BfHDe4VtuYUC
 gW9LqoAA3GH2q5zUUgfXhl335pNZ5Gl4jWMH2f/mBeYsZIeIZ9la89vtfoACmoJZ44JA
 SJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779492721; x=1780097521;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wC+bunPOLt96fBPcfMzAF9bjbXlcHLDPzddadlN152E=;
 b=g8rwDSZ0/tEcxAFSNj1jHzZOT6zCFcNhd6HHjuKC6eK3XD/H2v9oaZRfAXtQIJ7C+m
 d4BDqtooy6rjUCz5TrRVfJBAw1UqWQuPthgCuK+UhbBeYzuuRzmLqza6hStVpRWs11To
 LdecSBkqgvLeI/oWiF+6Jv0x0PusOXqOKCM5HSbnyZ1q1s9MjAMvegK5BNrh9IMH3x5H
 0digjmoogFh2vDpVKUfTB7d/0ngW10Y9oMjRyQIK3+PzoQ0J9SS18BGX9df0pZHsuJ6j
 EWZglZj5EvYhWeDHi/+wK/BT9HRnRXOVIRHnc8K/80S1WER43h+sujf2VwNhMfCD5N0/
 8kgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7umhkvvhUjBBKnQnGdr3JGMOAwWYTxBcneoij3955i8KtLr6LtwjL756qXcsJxOk1Rbx3/cxAIwLT@nongnu.org
X-Gm-Message-State: AOJu0Yxx9FqNBc/XXXK8bYc0rRzuzWZBHHyP5Q0h3X8yRaOMZN97xlCm
 BnlJ4pBXoV9VNsceg8CjcKJQnFer9BuUOvqpSWzh1U7chagqD77Iltp0NB9So81LTEIj0tnMFHC
 IFZMZrsV9Nvlj4y5XVeAulVng3cttojqMZ8lVUKHlQyUueSdoMmOsAn70UQ==
X-Gm-Gg: Acq92OHKqB6Es9Oeb5wXiDA545I0gCACJ81AWD/Ec76gjH9GFX6aMn9EvNZRH4QJH0r
 l79BHwhPzdoyVxD3qKXrlxW546rRmMBVNz8OPB5Q3MhGD1IeR+JpRTgqDD4K6fAgqvy+vOy0rbS
 K39E4TpseTVsDWRqUbjtsHFqHNczyVV9l4VuldTG67F4AWr6Bg3w7EISfH1uCDlhnHJE4Z2bm+1
 jutSj0q79zbrhQeXlId9myz8yMss3TO6OyHnupk7wPTPIV/sgZlD3Llbba9kyvdifJh0c2vwj1a
 FgIU3i8BKZGnQTmGWhOcTr69Sjk0n+AZTx33s4zwbb3gNHQYyLkbPV0gUihh/HpVwEAIXgVLJf7
 o5MAVx0QFVNGO8FS1OghVeRCvzOHrY26aLsOCiWG+ZcBJcNvLo/CejdJnCmYXqNLh6n+89DJAa/
 giR7q0NcoVaDxcM+6WElIbElqD
X-Received: by 2002:a05:693c:3b0c:b0:2f2:8857:17f6 with SMTP id
 5a478bee46e88-30449037990mr2781837eec.4.1779492721128; 
 Fri, 22 May 2026 16:32:01 -0700 (PDT)
X-Received: by 2002:a05:693c:3b0c:b0:2f2:8857:17f6 with SMTP id
 5a478bee46e88-30449037990mr2781822eec.4.1779492720649; 
 Fri, 22 May 2026 16:32:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045223103bsm2114219eec.16.2026.05.22.16.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:32:00 -0700 (PDT)
Message-ID: <0bf04ec8-ca92-47d9-808b-925af7f65d04@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:31:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/37] bsd-user: Add socket system call dispatch
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-16-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-16-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WyDKAA9yHsOdvMcdKEZw2Ay1gZNJBPHQ
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a10e771 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=6ngRMmacRQXifHAwtJYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: WyDKAA9yHsOdvMcdKEZw2Ay1gZNJBPHQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzNSBTYWx0ZWRfX3YwDiG6SZ/kL
 EudzHJLGRZynfAVl2Zxi69wc0/TZuCFr3dOEX+al+Ie36cJd0cnTqQAwFFmELNu7znkarBji6Cu
 QU6F2vNynrHGYmoeh+VYoBJqcIM6lnP8jCSuDm2d25cauOLz/miIQD6lLAaAmY37fZ9Mm6uLofu
 akW4v+q47JIbzRNIF7SL8u9X4oDpPB8joRV27jKEwt+TkcQUK77FGMVzCzwyajT42UkcTRbeuce
 sRv3plSlbqzxK0OZWMGlexOMNcb2meY+3mMDAUj+wRXtJZdXSvUp5f34J/Q/m2/FmxbTaXJELVg
 Pze+7MNGcEAeXVgx6NHb7fCOiCYKlqkeQOBycosE/nH2mAI5ENaFpJet5KZC410VZUXZXP6ek/F
 unEs8QsoIGR/9Ficuh6up14ylvIHjgnd7tYu3MpP/cRDTMvyds54WIGFZxFQenK47IEeZ6X9DgR
 Fwqz5nsBmro54PbY9/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220235
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Wire up socket-related system calls in the FreeBSD syscall dispatcher:
> accept, accept4, bind, bindat, connect, connectat, getpeername,
> getsockname, getsockopt, setsockopt, listen, recvfrom, recvmsg,
> sendmsg, sendto, socket, socketpair, shutdown, and setfib.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-syscall.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

