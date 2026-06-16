Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631EFCD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJA5-0006hD-CR; Mon, 15 Jun 2026 22:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJA4-0006h3-9l
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJA2-0007xI-Lm
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G204Q92148524
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rDEM2XcKvCPctGiNVGvP91Jj7baqZxy5jXwlIijFwuw=; b=NzCvyN85qiqSzszT
 LXK7QaORiyk7OBIEzh7qw+3hH0gU9up58xWNuGWtFtmzGMTgZyQ/A68hz8pJrY6K
 ES7RpI1uOerymzymPVCGBJknCXXVZ7LfX2FdwmOo1dyhRvl1RaGqynwJg/pzvPFz
 7ClQPAeyEjaiHyALdpsA6jFefN1nXNf1BIxhP+Tc5l4wTeGwCOHsmCf1W9rK/EFL
 +Wk2csdGovz8kGXeA88uZwdT0mFIvwjJzCZuMU2046spZ1xgbb8QHzcD0uCSXdK6
 fksWWB0HAFcEK27DbWvV/OA+bJ+HdMkBngJfTGm7lONphZlvrdJJ72uFoo7SmXoE
 VMYjdA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetf41rx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51989985485so14072581cf.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575457; x=1782180257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDEM2XcKvCPctGiNVGvP91Jj7baqZxy5jXwlIijFwuw=;
 b=Nfs/KeDGj0gDLiIun2IAbXSZNPzmeQrF2eX48ExK7qb/d6MRHpvA5QD98ufpRClbk4
 euGHVAQ2zIrj5W3TlxEYmn6siPqS1E/vitKisPWTffzuCLiCRdNgcfp1fxBPYURyh4NL
 nMOO70GH+aG6p/MXMl2x9zS1IZEkyP2bBL7fIB9EafFInJJRMlYMPv/cSh1iiuwwR59M
 HLL3vSmfJKUDGwteqwGttzn5aQmHdTJv+Cw/UvHuORY6QuJEG7uuLhWe+Zl/UhQhnU7U
 zBO3vnza3w72h9XZRIkk1XmYmnQqs5to7lxEfW5L6oBUn6yMvXHyZK7cNkTXs136VuV9
 5kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575457; x=1782180257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rDEM2XcKvCPctGiNVGvP91Jj7baqZxy5jXwlIijFwuw=;
 b=THYQXffRlP+UqMh1H8N27ac9Z6v2DMmqlsQzpwGpzf96a1tD9cazmFi7TBKCsp2jmG
 jMf2xwgmDjj1koh5Y6jPLKagOjCP2k3veVlDC4ZfLTbgLlAicW95KADGuGXGVgxhoiQs
 PcIZUj896u+aU84no1jNIoTyrgyQThHmvmscJHR8VDIdtLNdTjPJJdnnegIrFRj/yowz
 kodYtJ/8d9WQgHZYiVNN/u961aBpKPCLcZ+TctdchOVN5TLsu02VS9oHGa3RSGuEaIgX
 NReawMRq8uzNfqa2ayRvUJmvrBVZTStX+/GZruwEXWpL7wCHRqAVTAEZfLPVF2R4QiMm
 SN1g==
X-Gm-Message-State: AOJu0YyY9EH2P+u9HaXrrqSb2UfA8Nx1Nfp2bQXCfCvKqMl3G2UiQfx7
 J5xyYk8hQj7qvRLJBB5Z6sd0vG8U0haXSYKtB67zeS/QhDFIl/bqhXpDw8/t2cOu4r/l2feAML/
 ab/9npYh0DgKzs2ARkKLm3Z+SXbFF6gUv/7du71oZ967G9Uc9UiIDPf9e+vGPKGwpVQ==
X-Gm-Gg: Acq92OFgPMPYYLzCppMCoQLcuUV3B1s0MKp1sjZeF37jUlk34Psa2miFlgNQQ3h0Jxj
 pSPhNqOa8LwHK7Cf46boeVKE8D6rgnPp4+A/t92myI1ZTDqMp4dMHiqZoCmYZ30x+XyWwnCXobU
 XDZTDK+MFc/W3jwBJjE1mO5rhTfEyAxKtPknRrjfdzpQxw/2cVTVsdfOmaFEqGFyf1rXVBvJhR7
 eMGmcIDcn874Fjp56KBkYKB5CyrfmxYqjV9cjLAuBbZgifKdxRIaF4gnrNGr3XVIZreKT/zINCa
 NYufA5MN7kvyghtFIOzJYolGwAKmUqzEcmysED0m/JOhi6wKrHsvNmz3eITGEgASZbMrUhhlEiZ
 7jOR5hfsmsEh0H/jtq84ZChh0uqg2mKMkEfj1xnTxN6A5T7u62eHiFnkh/Uo3/Lex05PTES/jDm
 7ROOw=
X-Received: by 2002:a05:620a:460d:b0:915:673a:617b with SMTP id
 af79cd13be357-917eefc4291mr2095161785a.24.1781575456969; 
 Mon, 15 Jun 2026 19:04:16 -0700 (PDT)
X-Received: by 2002:a05:620a:460d:b0:915:673a:617b with SMTP id
 af79cd13be357-917eefc4291mr2095158685a.24.1781575456566; 
 Mon, 15 Jun 2026 19:04:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa8b423sm35892525e9.11.2026.06.15.19.04.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:04:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 2/6] system/memory: Constify various AddressSpace arguments
 (flat-range)
Date: Tue, 16 Jun 2026 04:03:54 +0200
Message-ID: <20260616020359.18627-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020359.18627-1-philmd@oss.qualcomm.com>
References: <20260616020359.18627-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=adxRWxot c=1 sm=1 tr=0 ts=6a30af21 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=PVUNuLZfzPDvKcjOmkIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yZ4GNy36Q46YfkZNm65tjkoyKDb9whVX
X-Proofpoint-ORIG-GUID: yZ4GNy36Q46YfkZNm65tjkoyKDb9whVX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX9b/xcaSNJlzO
 7A6rHNhYSMz5y4PlRunlkMxmY6Ul2Dm7MWi6IP/I/Quk/XqnmQoLOueuILkP+8yejI6fd+HiNf9
 mn2k5bjEIwn5koZ2RRHv6E+0/YsDclI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX9zLmLgL0IoU6
 awvk6EHJ7n/aB4eAo9XY/VoR6njr7ABjKi1ERqnxzwQ91RnVPOeaERwBgsdHT/gSxAkQjvEQDik
 RdfKNq36OYxMrBQ9oOGDRxNR6xb4iO6fIGYbdiB3RaGWlCq1Um6KVchy/bQzf9LAQSmM0xVNlBg
 AYypuXGGDNU2Y6IYtNu6dlQd1jGk4PIW7qCb2TOr2X+vwgUlAy0+voYLjMlwJpi+pYfQz7LgfP8
 QbgqWKPMk+QHELgWY8BCNpMXsjjKd+MorMXYwN8vVhCOHqTWjCqsYSC1kn5vYySyZ76tWE0VBBM
 ZBzJ/6Yil7YoWZ6/+KEXIhLFjIVQJke9qsTZtd9G0S5pDXzcUPBKyvCjNEXzdxZKC6v5MrJy64N
 sLzAsLiJVwhA+8bbFh/Ncd6HvT1uNLmoC6DruDDLMAsgwGaTBMv7syEXO2/yTt5xO1L9YJEhWgK
 mRKqcnNYRgZcwMFSXMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160016
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the AddressSpace structure const when it is only accessed
read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/memory.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 739ba11da6f..ea2ce80cf2c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -889,7 +889,8 @@ static void address_space_update_ioeventfds(AddressSpace *as)
  * range `cmr'.  Only the part that has intersection of the specified
  * FlatRange will be sent.
  */
-static void flat_range_coalesced_io_notify(FlatRange *fr, AddressSpace *as,
+static void flat_range_coalesced_io_notify(FlatRange *fr,
+                                           const AddressSpace *as,
                                            CoalescedMemoryRange *cmr, bool add)
 {
     AddrRange tmp;
@@ -913,7 +914,7 @@ static void flat_range_coalesced_io_notify(FlatRange *fr, AddressSpace *as,
     }
 }
 
-static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
+static void flat_range_coalesced_io_del(FlatRange *fr, const AddressSpace *as)
 {
     CoalescedMemoryRange *cmr;
 
@@ -922,7 +923,7 @@ static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
     }
 }
 
-static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
+static void flat_range_coalesced_io_add(FlatRange *fr, const AddressSpace *as)
 {
     MemoryRegion *mr = fr->mr;
     CoalescedMemoryRange *cmr;
@@ -940,7 +941,8 @@ static void
 flat_range_coalesced_io_notify_listener_add_del(FlatRange *fr,
                                                 MemoryRegionSection *mrs,
                                                 MemoryListener *listener,
-                                                AddressSpace *as, bool add)
+                                                const AddressSpace *as,
+                                                bool add)
 {
     CoalescedMemoryRange *cmr;
     MemoryRegion *mr = fr->mr;
-- 
2.53.0


