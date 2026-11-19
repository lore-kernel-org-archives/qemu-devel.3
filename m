Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99160A2616
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C+9ieQEF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XFouYdDs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAJT-0003MG-KU; Thu, 19 Nov 2026 17:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAJQ-0003Lj-FC
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:09:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAJO-0006l2-4Q
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:09:00 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1XDd095604
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RFxiPMZUDtV+dWCcaJ3V32Pmo+3Ha8y5QA0lhXRngy0=; b=C+9ieQEFAapM4DIa
 CkpM94CRW3gKe2EnmVjs48g70N765ftRzNL8AntOdHr3uB6JxgRGfTHtoWOzuRl1
 WrnjwR6bUnOSTgpYM+OEdV/LVfan9m/N+zSQxrtEQw2Fyr1iH+Uk3aH8QLzhsaYf
 tLgzyiQOI0bcokz7sHbId+aOh/e1p0qHeT0ROpoSw+F94z5ULksXwhgqxvH5VYDb
 5l59T5yv3aJmn7r9jz/LZHqFk3GqHMIJ4g3eA3UOlhDhR+iB/4edK0XEJ5CVNpM/
 3mtCJiZ1Tg0uhnlnt35gea7BPojZltXj0zf/V98UJvwyRTwOjV4oXJOVlARiE9wj
 y5JJkA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx1bg9w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:08:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f3969a2a7so49235385a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795126136; x=1795730936; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RFxiPMZUDtV+dWCcaJ3V32Pmo+3Ha8y5QA0lhXRngy0=;
 b=XFouYdDs8VumSJFd+OOdSH13J+wsGG+Mqzk693ErKhYRC7RNPxsANMccDPcvwYbmlv
 i1MDaVZSbWRZUHi405kOXGxLf4DjWRjet4pYygGl1zJDDCsuk1fv2MyCLYoTIpWviXVt
 PobV74iB/IFd6kF2dAot0gNJXKGSlEdc5roeVF4hckNPpQk/XMGaUBFz+6AaJwsr5yxf
 Isx9fl63sOXmgzrpqDvo06dTWP9fRTxN9Kf9eAH8dfb7NuMF0SrkwxvfanpgWShRVNMr
 f7WzbWfh1OXUk6c0Po8crOC/mXJwflDJiMHVg7nZ+VgtuhjFLxQsWIcz7AbIGYUwPM2g
 /wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795126136; x=1795730936;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RFxiPMZUDtV+dWCcaJ3V32Pmo+3Ha8y5QA0lhXRngy0=;
 b=R8a84CWme543PR+G1dgUUBR8W4w65+UUq6ccGvD+Qi1rQ9b7DjyJLM6+juSoer+7I+
 cBgOvFk7w5PknHaV9L9P4v4a1jrgGmdkKNAM0OELuiJv8xl21oUhU7k5+bKNDOh94JO7
 w5pqj7cUYp45waugbxnKnM9fOw+zH8JL8ChxJ+YqDexane5W4T08Oi846GLj2csfxbzJ
 8NNILe/tTTWM9AUTd9CaRQb4QdljV7223egSQvDHT0Q9ablnswfUCXGsdguoqbvwgrHi
 bW2KWXsJYOJo7tVXARinQwkbdGWZDsV5sC9EQlaFoi2U6pvsYna/zYJPnHXrTCmltEnU
 6lZw==
X-Gm-Message-State: APuU4Z8x0G6BySJgdgK77a0R7FG00WMH9BtKkKmpGmTJb5LV7RB1slEm
 SokGx/JoYiClz1rmPmDlEFKPbPeqx1sjpXPtdsH8i9Wok6HsZ66HXLOiJAAmoLM8vPhdPHqCSUw
 x8EJqW2vP9fg82R9FWmx8ZzBkQW5xJJ8CoQtNxvHyyKgk2sIYiLrNA3KRsgibP30uy9ms
X-Gm-Gg: AYBFou3O4irUlaBXD47AuzszWW0rgFc/lHLuZTKozS2DRgftVrDs9HGG/oWp9m5UmOA
 gMH06faP7tOhjvqTauvvW5Kua7fLi6v1gjwKqwQYoMCVy9E7rjc+rHUH/hdHBpR8IP0Szy99AEX
 d+Kv0hqBR+dczn0ocLOrZxYKz+lvwyRcFIQzaJqKIDyAjiJ7iUsa8HsOpsvKLEkFtWZMdnvR/Fr
 h1ODed1y1Tm93LTfVd+WsEKBMAbWdJGep8lPfV4m2QY8YzuC7jnIEqOdo8ymlzXVGZUnAuVZZFq
 C29IzrYuYMvIxDOT2Cep3wskzXe1cVKhOyhC2/QV4uimuwjYZq0r/rLRnQt1Z3Kqsi/uMontKb5
 dK4QimwzWXN3QZkRlGaEd7OnD+2Ca4dXolUQ6dx9YxA+oGg7DPb9sLB+qLdcwx0ZOLmgiLwibLH
 NarcDA0w6K1MxglA==
X-Received: by 2002:a05:620a:6f05:b0:93f:2e72:8389 with SMTP id
 af79cd13be357-949bab47baamr189146985a.54.1795126136078; 
 Thu, 19 Nov 2026 14:08:56 -0800 (PST)
X-Received: by 2002:a05:620a:6f05:b0:93f:2e72:8389 with SMTP id
 af79cd13be357-949bab47baamr189142185a.54.1795126135603; 
 Thu, 19 Nov 2026 14:08:55 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989eesm1823796f8f.50.2026.11.19.14.08.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:08:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/3] hw/dma/i8257: Zero the reserved bits of the mask register
Date: Thu, 19 Nov 2026 23:08:36 +0100
Message-ID: <20261119220838.52034-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119220838.52034-1-philmd@oss.qualcomm.com>
References: <20261119220838.52034-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PcBqFShd c=1 sm=1 tr=0 ts=6aff7378 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=zk1an3oMGe3fWqGA7cwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 8hWO86Iu8QQrYfMsWbGPbbQWl1X7zEYT
X-Proofpoint-GUID: 8hWO86Iu8QQrYfMsWbGPbbQWl1X7zEYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX8zJlaxnJ1pUL
 29JdCOaHt72N8omEz+pYYg2vwLi5+S06amogO73qfqKtwuqEHLKkXyO6P7VelZtWYOMyr1tY5nY
 AXNeMBoiiIMVFWMDnCMy7PW7AgpAAmiNbugxb8MBqURl82KBHBX0AIrlUdd6RYtVhYQv7W+NSZH
 J3NeGjEyKN+xs8OgC9OLh06obeIDxKA8GuZPkTjjBNpGsU8oWRhs1hwulzLVim/oy3w1CaQXoxv
 7OLC+57FD0JjofBU/yKQGB0VFnt3FH2oU59MEZX+NVnkpzgcrYV//QCPSi+6pCpWOPEoIJ1ebTN
 iC588PQU46R0/DbGL9CRcxGGpeiRFg0tfz8bFKOND1bnlL+/kLq315w5yClB/gCXuWtxjHxfcLT
 DwmZZHl5SJirJKdTxZrkA57qAaI4EkN5lzuI+27vtr6tfwmDYkVub/m6R9FVq4PonXhYSuXLbp7
 eVKeh1A6LeW4YvTQ6mA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX7D1euz8TJgjT
 iqmewLrr/wwyTOBsMu73Vuxh4t0yJy1BLTLPep8bXa8zNAmykJJkSlwRXD/b1JSafVkb7wxOXBB
 iLtiBqkPZFL71AwcPGy7Sv8olR8a0hw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190089
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

The 82C37-compatible read/write-all-mask register has four
channel-mask bits; the upper nibble is reserved and reads as
zero (PIIX3 datasheet, section 2.5.1.5).
The model reset it to all ones and exposed the reserved nibble.
Keep only bits [3:0] in reset, write and read paths.

Fixes: 27503323968 ("Soundblaster 16 support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/dma/i8257.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index f44632de3db0..ade8609ff438 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -242,7 +242,8 @@ static void i8257_write_cont(void *opaque, hwaddr nport, uint64_t data,
 
     case 0x05:                  /* reset */
         d->flip_flop = 0;
-        d->mask = ~0;
+        /* bits [3:0] mask the four channels; bits [7:4] are reserved 0 */
+        d->mask = 0x0f;
         d->status = 0;
         d->command = 0;
         break;
@@ -253,7 +254,7 @@ static void i8257_write_cont(void *opaque, hwaddr nport, uint64_t data,
         break;
 
     case 0x07:                  /* write mask for all channels */
-        d->mask = data;
+        d->mask = data & 0x0f;
         i8257_dma_run(d);
         break;
 
@@ -282,7 +283,7 @@ static uint64_t i8257_read_cont(void *opaque, hwaddr nport, unsigned size)
         d->status &= 0xf0;
         break;
     case 0x07:                  /* read all mask bits (RWAMB) */
-        val = d->mask;
+        val = d->mask & 0x0f;
         break;
     default:
         val = 0;
-- 
2.55.0


