Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F914606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ojeEcqJ6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PRihjuPq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLYN9-0004uJ-Vg; Tue, 27 Oct 2026 00:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLYN3-0004tV-4w
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 00:01:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLYN0-00030w-Re
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 00:01:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F3kr3521336
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=; b=ojeEcqJ6sQ83D948
 zSqTTPsCb9PFqBhC0XWz0JSJ4+i4Gtu1Q4rx8Pmg7yXXvDLnZrY1yA4h2qKmlsvG
 +uXhsmrN7JiE+g9ufaYvbIwPgJkVzfVCJ395h4UHZS/BkgrAGyBYJLj9oh1sQgT6
 v+6EDQEgM75FjbDLqImDnVv0YoIAbhc2kf0HuknEMbdBw9xlI0kK2hxXzO7QtuaJ
 raFGPlMCFihs6+mdtjLAyt+CTT+dGxrXoOdWWp6yuJCLZnRXapKV+7N2/fPZnN05
 VBkDuSuJcHLH3A6F3CeOly7bRA+ADkiL/zk4vG0qukvtNFulEoriQkY357n/q6I5
 xxZCqw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54hy8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:01:00 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-82274137201so6122325a34.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793073660; x=1793678460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=;
 b=PRihjuPqsPQ9jAqJrfx23jKei2b+DJXj9OmCrHyEJ4qPaqpk615tPU3mQFjcBsuLhT
 LC2sKF2E7kz8tyw8rT02tymCWEsIoecog/XASY6CF67HoKtM7vEozey4aMtUrl/JTGqn
 0VQKf3/cp8bVt4y5y7ll38JJjqLKj+SRoCJqu/C3jgIjtpgUk43mpmQLkcMxJszduxMr
 TH84bNXMFwGaH2yNj7Eixk8ecLOy7XRxvssxUIxgTxa4E1VmhosckbrhpOvNymM13bCx
 LYx6fTRdkxKuyxA0MYyKOd0yasd5ERZ8ovqHTMBzcrhC8czUx/s8G7lthl4V1Ra2z/3L
 2PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793073660; x=1793678460;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=;
 b=VoTR9L6xS6/SNGBoGfqmi7GcbYlasf1hrBFMzV104scoU59qaMcsvu3xZtptfSsRaq
 pJCI2eIS1Zj2dwJ1meIpa4jONo935NXlhijsBG8g/TPVDRICfqTWzCM4CZMTWtZWC/m9
 mMOnKJTPQzl53Dd68lVdY1mS6W36vzGatn1ApPbaJZpKupinSWya3g5uy1EtfYbyk38J
 9v27+erOvD0kGPnrWACL3/FHps+M8PLUHguY8zN4Aq+aXClbO5AuxM1X+T7PLKBb1lXQ
 pFZ8saLZkxDWZJcUgcsAJf+1UrRX9DvNxfb3Dvbzoh1m/Szi9Qk5IbwIie2jFoPMr9b0
 If2Q==
X-Gm-Message-State: AFq9FYI9rUzkHqltSIbc0p+JiyzwhGNarCAMjuMWrCWTKc6UivRsDjl5
 TbRY8xgbBJoT+ctHj3YSh1XpRHl90fmnKVdq9prb4cDsSf/hGuqMDJpnxFxWCOkqSy2llF+a19p
 mZv80i1nNjHRiObFLXSXTsCiHqAwRIUdFGz+gRduq2emsdzR4AnOigc4wgofA5o5twg==
X-Gm-Gg: AYBFou1yGSq+SKRV4XRuXXJeziCC4pF/SzcFGHhvCulV/MdEbeIhnAYXAbJ5mVgqP4e
 GizjM9/scbaqYFd/R81eBOpbSDCGgf20lYsEGscY0+SWkQdByuWkQ0qmaIJzU++A3GjzimyQuHw
 Y9AYAcOa9w3Mi1v4tS2EwIiEZievMu5ZBotdKilOTq5a6lcelYAFbJRn26zHxmZK5zF3PD3HMDD
 QbMR1OXkswhLiIb4RoiqejZHBl4zaobpKsRNCwwhuxFJ+iWQgMYrOYazbsuYJ1+mhEA8O0ET4hP
 IKc+bSttb3zxbPJh7LIKx2B4lOwi4buP2U70651RK3SIWxwdawdNVKM7pyhewt4gJHfuariT7Hg
 NkvvXCWlfHAdU28mTQU7HmF7wl6qVIHjXDx9ZrhI/pqvciL0=
X-Received: by 2002:a05:6830:4408:b0:824:659a:adbf with SMTP id
 46e09a7af769-850fde29ef0mr7131511a34.5.1793073659891; 
 Mon, 26 Oct 2026 21:00:59 -0700 (PDT)
X-Received: by 2002:a05:6830:4408:b0:824:659a:adbf with SMTP id
 46e09a7af769-850fde29ef0mr7131492a34.5.1793073659401; 
 Mon, 26 Oct 2026 21:00:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fbb25f59sm9489121a34.20.2026.10.26.21.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 21:00:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 41/41] hw/intc/hex-l2vic: find the next pending irq a word
 at a time
Date: Mon, 26 Oct 2026 20:29:27 -0700
Message-Id: <20261027032927.3055166-42-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxNSBTYWx0ZWRfX6huHBPY+Aim2
 mpea9wgpSxBiG5GhtK1Q4bKmPusYhxVuExqDMoSlqm14Hdfuak9Yz5XklTGmpRNUdfQvnV8+l2A
 Sehscf+gzi3VzQuoOIg0gK++og5th9c=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae021fc cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=8fQjqy5ARp1ca2tc:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XWoxCBOuUWUKfCXQB-IA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: l1kzzV1faVT3yNJv2o_tjUcmSWCChggb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxNSBTYWx0ZWRfX7EPOg9u+SAoB
 sxchSWEGIioDbvbJzkKYe4RfdI01yfBHLjHE1gB7rlHA5HLTYf3OJw1SI/G3WqCI4y1NSJn0n8r
 OKvyN4XLibpJD1cvUEPEVlfqLKL6+BGIgRZCdzviuN/ACsLTnTMOeHeZp7PnBU3xuIf/QHW0gx9
 edwALV7ksWr1rIkev+Ty9nO30Cg/OmwWt+IVnMnmKPVU1MLbzVigXv5gojovXQmFJ0gIlNzQewz
 CjufGZxreNr5E2tyzz65WH2bWNmkfH24pMGr0hyUKpn8vyppjeX47wQVQHnDzkr/sVBjnydtMyC
 AtHBR6LZv5IWPP631IgISj3NShCWkthYgQ5lFsrehpWj2NMHlmpo4lWDXyGR9zw2NmpjaJgCPxH
 gZUV+WN1JjuA+THvBQtsjOfBWuHBrUQEvI6U1+F0oG+7oOIYgbhx89r4SmJXMq8d7FKNUCUK0Ab
 dOX8v1eYOUINN7UlYpA==
X-Proofpoint-GUID: l1kzzV1faVT3yNJv2o_tjUcmSWCChggb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270015
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

bDJ2aWNfdXBkYXRlX2FsbCgpIGNhbGxlZCBsMnZpY191cGRhdGUoKSBmb3IgZWFjaCBvZiB0aGUg
MTAyNCBpcnFzLCBhbmQKZXZlcnkgY2FsbCByZXNjYW5uZWQgYWxsIG9mIGludF9zdGF0dXMgZm9y
IGFuIGFjdGl2ZSB2aWQuICBjaWFkIHJ1bnMgaXQKb24gZWFjaCBpbnRlcnJ1cHQgcmV0dXJuLCBz
byB0aGlzIHdhcyBhIGhvdCBmdW5jdGlvbiBmb3IgYW4gT1MgYm9vdC4KCkNoZWNrIG9uY2Ugd2hl
dGhlciBhIHZpZCBpcyBhY3RpdmUsIHRoZW4gZGVsaXZlciB0aGUgbG93ZXN0IGlycSB0aGF0IGlz
CmJvdGggcGVuZGluZyBhbmQgZW5hYmxlZCBieSBzY2FubmluZyBpbnRfcGVuZGluZyAmIGludF9l
bmFibGUgYSB3b3JkIGF0CmEgdGltZS4gIFRoZSBkZWxpdmVyZWQgaXJxIGlzIHVuY2hhbmdlZC4K
ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBody9pbnRjL2hleC1sMnZpYy5jIHwgMTcgKysrKysrKysrKysrKystLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9ody9pbnRjL2hleC1sMnZpYy5jCmluZGV4IGI3
M2VjYjgyMWU0Li4yMzM1MjM2ZjgzNyAxMDA2NDQKLS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYwor
KysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC0yOTAsOSArMjkwLDIwIEBAIHN0YXRpYyBib29s
IGwydmljX3VwZGF0ZShIZXhMMlZJQ1N0YXRlICpzLCBpbnQgaXJxKQogCiBzdGF0aWMgdm9pZCBs
MnZpY191cGRhdGVfYWxsKEhleEwyVklDU3RhdGUgKnMpCiB7Ci0gICAgZm9yIChpbnQgaSA9IDA7
IGkgPCBMMlZJQ19JTlRFUlJVUFRfTUFYOyBpKyspIHsKLSAgICAgICAgaWYgKGwydmljX3VwZGF0
ZShzLCBpKSkgewotICAgICAgICAgICAgLyogb25jZSB2aWQgaXMgYWN0aXZlLCBuby1vbmUgZWxz
ZSBjYW4gc2V0IGl0IHVudGlsIGNpYWQgKi8KKyAgICAvKiBvbmNlIHZpZCBpcyBhY3RpdmUsIG5v
LW9uZSBlbHNlIGNhbiBzZXQgaXQgdW50aWwgY2lhZCAqLworICAgIGlmICh2aWRfYWN0aXZlKHMp
KSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICAvKgorICAgICAqIFF1aWNrbHkgZmlu
ZCBsb3dlc3QtbnVtYmVyZWQgaXJxIHJlYWR5IGJ5IHNjYW5uaW5nIHRoZWlyIHN0YXR1c2VzCisg
ICAgICogcmFuZ2UgYnkgcmFuZ2UgaW5zdGVhZCBvZiBvbmUgYnkgb25lLgorICAgICAqLworICAg
IGZvciAoaW50IHNsaWNlID0gMDsgc2xpY2UgPCBTTElDRV9NQVg7IHNsaWNlKyspIHsKKyAgICAg
ICAgdWludDMyX3QgcmVhZHkgPSBzLT5pbnRfcGVuZGluZ1tzbGljZV0gJiBzLT5pbnRfZW5hYmxl
W3NsaWNlXTsKKworICAgICAgICBpZiAocmVhZHkpIHsKKyAgICAgICAgICAgIGwydmljX3VwZGF0
ZShzLCBzbGljZSAqIDMyICsgY3R6MzIocmVhZHkpKTsKICAgICAgICAgICAgIHJldHVybjsKICAg
ICAgICAgfQogICAgIH0KLS0gCjIuMzQuMQoK

