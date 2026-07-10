Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31562C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 17:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiEgw-0002Qf-AM; Fri, 10 Jul 2026 13:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wiEgu-0002QE-26
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 13:07:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wiEgr-0001ji-UP
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 13:07:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH3gqd1307180
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 17:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dK/TFQqzwCj
 AB47EhATkjuR4Cm4uPiV3r3gBsnD7xps=; b=pAwpAuuxVG9rpevV093iRy9gvzG
 N0LnQABaKelHgQXe1BEcgIuKWo9oY4Mfu0R+o2uC4gJPQlvDVInQomGFifzedwZ2
 pRU2boHme2bVIZXnoUCyqrG5WtcXQPJk+ZGmDFu56L0mktn9aW79jLgOsvffq9aQ
 KPMzh/FI6aTU7OytfSVJ5L79YNe9yle1oFyIONRyQGH5i0F5DXUADIkmIgp/3cUq
 08ayy93WUh4trh92HZEQgH6Y5cY/JNvuixzlu5YrtXmMyyu3GfZv9B9NynNYiGrl
 fO45Rf62a0Dl+h2bKjyso55pZorCA6X9X3VH0oAxC/U/cixQGwAxuBHhoWg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dhpcq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 17:07:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8487ed7f7beso558629b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783703221; x=1784308021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dK/TFQqzwCjAB47EhATkjuR4Cm4uPiV3r3gBsnD7xps=;
 b=i0FA8QVokNMsUVUwJ5YzyoMKiRfh/z9PO+q3eEbyDTa+/24VGa4mUhVaDnmuIp75wI
 wnCtqAB8XTel2A0tcjK5CBifLAdqXYZBMZMfYdhvFv5ofUo7XlJsfVJAVsfnloykxDyt
 wKuJo6fb2dNnynXlKAfyQhItY5NNgC2yLtoIPeKNl/T/AH8obO5xQjUIBtOdI0xu9rvM
 oY3DZ2CwpDIvEg04e9gjb9IjyeS1R3AawzRj9LH95RAX9KWott7p1wwI52dCtNl0nL1y
 yTeDYXDaLBwzzILK0EWA2osrptdFJa+4xofqp9vQLYGQ08ofOoqaCivrjPMRjoI4LLX2
 AeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783703221; x=1784308021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dK/TFQqzwCjAB47EhATkjuR4Cm4uPiV3r3gBsnD7xps=;
 b=GzZ8cHsUkl0taZL3TU1pHtUJSM/89IMyRxCpNNP0A/18+NO3tXN3y275xTW496+drY
 LEUJAodeqZ3fl+YxHGb8oAOSUsnY97nnepdXW/oZipZdBjm+eK8sHyJAG+TecAqxcohT
 lEK8eQMtzJIEpSmHp07mmJGWEtOJ5qrwsEfZVapyq8P81agvR/9lEM98aBw7aRgySdIt
 /9fF9sCnMCQkTMsWi9Q6pR4O0lnwVKhe8HI0IGICV433qGSU7yJE948UHC8QuloEfi3R
 SVD9FBebwN/r0sKd2LRf5vwkyxLB+x3c+crpfHtZ0ENKLc4fUbqx0OGddPezEL4wRrIL
 a82g==
X-Gm-Message-State: AOJu0YzDVY3VG93nWzG042wttTfUr1eAcI2tOFv6aLjlayfmrqOucYRF
 pQ1aFnzinNyBgSSRmnCG76VyH4trdwgWgYh8TcD3c5Vqu9QRlIfEBe2ftr9qeyHFWZNw54iaWkA
 /eck0hF3KziSUFxYcAZxeFWC00a4WsZ60AhBZaIoLDTNLeqkgDtZJXzq/3Q==
X-Gm-Gg: AfdE7ck1GiXqJUMQ1cjgMFI0Gq2Exk7T4OAr6OAw3TGjlpRFgWPcuJxkMaQhBvSwfov
 RWYpcqF3LA1DGN7Md14R4g6MsGAngRSuA2nTTWbstI3hKvag7ITDOHKRbVNuZr6VWfSrmETpV1m
 gA7e4/b8qG3jW6NMSRY4vpUDOOs60VmZfY1NiU/T6XTiYdSPf28hXjR0PjWEwG/lQGBdYWR2N5y
 cUPjsYwZUCQ4argulxn9sUnI8z5L2Uv1Z8r8CBQorVmsrWR01ksll5PW+itI7uzSUHXjE4hGJan
 wgNOTScrnZ88P5m1RUb8FwjCu0M5f4uI3P/Afve/7PFGz0eqzF4gZlA9cTJN7Myi3KCO2GZdv9b
 WCKLB/oghn77duY60UPzI89oP8M0HpcXmspZKaS1AEgzyI+HtMBOy8Lc3GsHGVSaHDYfQOTfxEA
 ==
X-Received: by 2002:a05:6a21:111:b0:3b4:b24e:27a2 with SMTP id
 adf61e73a8af0-3c0bd036411mr14670315637.31.1783703221192; 
 Fri, 10 Jul 2026 10:07:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:111:b0:3b4:b24e:27a2 with SMTP id
 adf61e73a8af0-3c0bd036411mr14670286637.31.1783703220729; 
 Fri, 10 Jul 2026 10:07:00 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d87a2sm39473229c88.13.2026.07.10.10.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 10:07:00 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com, deller@gmx.de,
 matheus.bernardino@oss.qualcomm.com, anjo@rev.ng, laurent@vivier.eu,
 ale@rev.ng
Subject: Re: [PATCH 0/4] Fixes for unaligned scalar accesses
Date: Fri, 10 Jul 2026 10:06:57 -0700
Message-Id: <20260710170657.1454052-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
References: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE3MSBTYWx0ZWRfX1a+jm5hLMQZ5
 gLHCZQSkmvCj+IOsVv1rzI0H2XJvQtz+uvsrrlMpFJjdW1hxATetddyeH6AIPXhiaX2+4I5xG7m
 VK+FMSFKCCZwfzH7Is0XSjOxhvqEIQw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE3MSBTYWx0ZWRfX8H89TQikrrKs
 QB56dj4kYV/upsi8HPn5p+m2IKL6lT8DbYiayextW/FtsjwHcwI72EMCzn5AU4d4+uEUlMS8Nbd
 WXFtZJZQxw1hc9sDZIwSTe6VT6FHo6CaPvWvzh/41mzbuZhE0fViKrLpyTYL9uWNQ47Mon1assA
 4YKkjQtLuD8n+7JwFk87nq971/9Q97W2VxsB6bf8lBiBGJ54hxElK5m7nAT2Tmiltf6LiHdd3sK
 Y8DgTSrcrpAKY5cJrwVqGULIg0DeZ/8GySdnJuet17sAsVkF8kOxVZd6CTEqXnXCzmfE25PZGIY
 oRKQolY0NSehGihO4sbwUqfgJgDZce85TV6MmbnDEhBP/XEf2MTRqqrfycyvv1Z4vFavZ1I0x/H
 3Mru488J8I/b9s9zIgaspb6AlpfYfju51bRnGBoK+ndiBfVhEZKI8YExh2op2oDyyLClShoU3Ec
 gknbAQCGO442DqDpMPw==
X-Proofpoint-GUID: T9h3WMfvMQPABaP5GqHpSdIYU3WxaNlC
X-Proofpoint-ORIG-GUID: T9h3WMfvMQPABaP5GqHpSdIYU3WxaNlC
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a5126b5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=M8D8PsdgvQ5BQcFcrqQA:9 a=zZCYzV9kfG8A:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Thu,  9 Jul 2026 16:34:32 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> I took some "working" programs under userspace emulation into a linux
> instance running on a fork with comprehensive system mode support and
> discovered a compiler bug causing unaligned accesses.  This bug had
> gone undetected in userspace tests because they were not handled correctly
> by QEMU.
> 
> With these patches, unaligned accesses cause an exception that generates
> SIGBUS.
> 
> Brian Cain (4):
>   target/hexagon: raise SIGBUS on unaligned scalar loads
>   target/hexagon: raise SIGBUS on unaligned scalar stores
>   target/hexagon: raise SIGBUS on unaligned data access in sysemu
>   tests/tcg/hexagon: add unaligned scalar test

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

