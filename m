Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCA8C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpmp-0002An-RG; Thu, 06 Aug 2026 00:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmT-00027a-2I
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmR-00045V-Iv
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbM094138443
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0n1hwlJsHzSmx2dFXPr1Z0A5cUsYOIaUndeJcb2d3Ms=; b=nwUCtLK/+5V0KFp1
 SO/FCGwfd/oIhYLfO//YZ12OZGBBkMk3piK+iaQ2tFzgrU97z6KyFRNIBGSZM1pY
 gQuQWilbcUx8trKlNZeflRKP5jTwRx8nky+vzUZwaerG0CjhYKjXx3N10L5k9DJ+
 r5A05VJuw0KXOUgeJaBh2ehqfm9nqNpvVwxvmAm31ROEYBQpmCu0A1eecHPiJc5B
 MHD7O9xV97/XmI8PuNRWN15KJWS8nL+/qbJv18pvzSbVc1MAKIidQD6lfnfKgwTl
 tf0nqEIlUs9tXJbgUVi0ZKjZSNazeip5pVaJF0A6lb5M0nHtX0+zOYMFCGvjwbN2
 +TMTBw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x9uhj5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:32:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so2129744a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990750; x=1786595550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0n1hwlJsHzSmx2dFXPr1Z0A5cUsYOIaUndeJcb2d3Ms=;
 b=CbQ5ERe/JhLbwpRJS98zu5l94q1vcoZcV0WrIVsu4kNQjawc3Aw63EW5AMM5q7dxjA
 SknKbGZlhhK0uMHwUbCB7DisvFTzkDKu6c1wtYz3/t3u4q0ChJUVhdByDaTJ+daNr4Ob
 H145dRj3BPZSYM6qsX79gUY/6uSnareBoLGDbjAB0Exa6ctPvFtZNwrRfw9An+F68zES
 KRgJp4VDQ0RRGwyntmUcJojvn1rHGDzSwGOxm9M/L9AjjqcCGpFJGhE/QGOIs6mu6IU6
 IgiU4RyQXYso0sHhSq8/y+CBRXEa0ZLMow6VCweqcokFC5juWtDkutx3x2JhO7gFQ/0l
 YboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990750; x=1786595550;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0n1hwlJsHzSmx2dFXPr1Z0A5cUsYOIaUndeJcb2d3Ms=;
 b=SAbEbFLIEdhHrV2YuZiTl6SINLk58bPVTDlTzY94vLZIbZDmb3MqxulzfRLlZNh0PQ
 tj4BPSGpiyf9mzEYH6zf50vUNuB+GVabWkZYOZ78nKsbE6R1pspbnV5ZMjuwH6dwnI9a
 SLjcAlfpTBuYCRvywq6GT0M2GebU2impVUcvy9FNJxeHzgfMe+ghj418yhO+mAwqp/a+
 OWE6ciQlKr90wenMocPUmEm/wYxQ0ThYXQXJ+b6y502KzHxp1Q0XxKKIUfzUwXwuJv6j
 wnimYI5dCRNT2C62DpD/+MUaDCVx/JBTXN1gzSym+r3IR0nEBvu1FRL3bJhzZnieoMhf
 bOgQ==
X-Gm-Message-State: AOJu0YxG3tZk+k/DHRXbHP1ihWTmQk0WIPdauXaCYu1FEjFWcdsOKfiF
 2hNHnK7bzIbniOGhwBL6bUJvLZUHnixuvW2VLYIwXudTt272CmwsQHDIYbPzwNdls7Jl6ebJQB4
 aYBxj4xmiPa7ofQAuIaB8aIVSpNTHp6ynPMXJl3dW3jEGL2i5C+2qDrzM+bUzUEy0vg==
X-Gm-Gg: AR+sD13dSHt2mrj2vNKV33haC4BhaQ8XiKZQWV3DURrd+O63VDa9lPxw0FNKT8J9prK
 UMuuuXNmFO/UKfsMFy+9uKSqL10jVvQTR5MfyRUjvok01gHAG8d/jnrPhQMy20zLqb9Vek+JgJ7
 3oIQiy2ZCqS5t0DnsLmLAao4JfzPCqUvZIUnB39/5C2LtQV/rxFUHlwl8bJ9cfH10Q5P59/O7zy
 WNb6LKaQ8i6zyw7q7QObHpJ3MKpsoel2FrFvXo+7cLYEKMpJM1n1qVNVXgfhpN2qSMnek+UfIP2
 x6Px+MAM70T08BfpVWYcnmU6NBmLPrTvZ9ns5Mp/AMmFk3iu6k74RlLZnQ6jQtanJdZZSg7RyKu
 kfV3C9oxfoZvF3t+S8vx+zo/oOUHaax8IbmnVkxPCuFOrq70Q
X-Received: by 2002:a17:90b:3c0b:b0:382:1a6f:ba3b with SMTP id
 98e67ed59e1d1-3903c543fcbmr11983173a91.5.1785990749664; 
 Wed, 05 Aug 2026 21:32:29 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0b:b0:382:1a6f:ba3b with SMTP id
 98e67ed59e1d1-3903c543fcbmr11983127a91.5.1785990749192; 
 Wed, 05 Aug 2026 21:32:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0a9csm29958146eec.2.2026.08.05.21.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:32:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org
Subject: [PATCH v2 3/6] target/hexagon: add GVec override for HVX vmpyih
 multiply
Date: Wed,  5 Aug 2026 21:32:20 -0700
Message-Id: <20260806043223.3787083-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
References: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX5Jj+Ps3o+D1Y
 wjKuPYhb2fbj9vLoDQ7xyZpv70yZPM/WOoVgjvaVoFwdm1Ox86iSB50y8qtV9v8R+XyRqR88Jdu
 mZwB/I3PaqoKMMq4hJCB/IRxYdQ5mLy3tgK9KNcIm0R493q2/WKFGng3mCI26AozLZW0PgjhyhR
 d3Og2U2SfmiOLxJM2tgUeXzEgo6NrBAX2LrsKFvvtosHZiPY4TCM32LSnzvEzglcCiRHdi28x4s
 C3jh5jYxy5e1cB9K1gOk9Fy7yKFI3mhuw+hkTXRKQ/514Et9RKAqhftXRv21dwd/GEXhoO/CMdb
 wBwx4bE2ZtMGGK6ZD/SVKw+BvrYF+LrgfAb3R8y+XdlYMfjobamN4L6uLGItB6PzejZCuXeCCCd
 1ZFb+GDeMUPb7bwYyX4/7BmK4b9knKEw6s2n4CvCJdBPF8YJBgMbz03j6QkDMdpG04JoJuWvq9j
 06U5MDzvWdMQ9LyuShQ==
X-Proofpoint-ORIG-GUID: UascEK6ER__4FEpCjr8x1rGHAhHJSgwt
X-Authority-Analysis: v=2.4 cv=BMqDalQG c=1 sm=1 tr=0 ts=6a740e5e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BRFeZrn0LRIrCjf-XoEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: UascEK6ER__4FEpCjr8x1rGHAhHJSgwt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX4iPCHrtFqOYw
 KytrR4sq46iiuONJ21rnjifFSdez7ifBquJ1t7VRqxJ0kLlItJhijqtcGMO8M9sXIhULvCmkYwY
 jkQasRjEEZek5D8CrdffwX0Ugbb4zSQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgNSArKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
aHZ4LmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCmluZGV4IDQzYTBmMzU4ZjAwLi5m
ODQzZmU0ZTJlMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCkBAIC0zMjcsNiArMzI3LDExIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogCiAjZGVm
aW5lIGZHRU5fVENHX1Y2X3ZzdWJ1d3NhdF9kdihTSE9SVENPREUpIFwKICAgICBmR0VOX1RDR19Q
QUlSX0FERFNVQih1c3N1YiwgTU9fMzIsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisK
KyNkZWZpbmUgZkdFTl9UQ0dfVjZfdm1weWloKFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3Zl
Y19tdWwoTU9fMTYsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAg
ICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKIC8qIFZlY3RvciBz
aGlmdCByaWdodCAtIHZhcmlvdXMgZm9ybXMgKi8KICNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFzcmgo
U0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCi0tIAoyLjM0LjEKCg==

