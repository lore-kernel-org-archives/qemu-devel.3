Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80288606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jFOrkjhM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TVCley5s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPT8t-0001Ww-Kg; Fri, 06 Nov 2026 18:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@oss.qualcomm.com>)
 id 1xPT8r-0001WI-1o
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 18:14:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@oss.qualcomm.com>)
 id 1xPT8m-0006V3-5l
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 18:14:40 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Mntou2083877
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 23:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N+qrBAabGgn7H1L5ektW2xbF5GlWpWVNETSk9hU3SmY=; b=jFOrkjhMh1NGPwU7
 tPOvYDRJLRvEnPgqohJp6NGuUn/+UaK2lM/RU1a2qCmsccqSHyiLxnSeIcBMAM/3
 USycKVOUVGCQvnGrWpZMqkzug+ZgRAN+W6b6ZsVPp4g7hocWi0JMC2k3uLMZxTZp
 g7JPxde99VDuwGjXP3sbKIN8e66ybKm/kdESVacH25j7HJRAS4xCOYgWsvfF8CIt
 JXLsOgmTy1ZZgFyrVZQ2teSymz+s4GTRwVsnzl/eb1TC9lWXLwqIrq6uMV5uVfmH
 sOHcq8gVcNcQNcvtJscD/vUUUxRLCgkYX1003VPHWMrqU6Ut78Fn4YPdiofDtXDw
 D+b1dQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsm6m8xv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 23:14:32 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso1857177c88.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 15:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794006872; x=1794611672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:organization
 :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N+qrBAabGgn7H1L5ektW2xbF5GlWpWVNETSk9hU3SmY=;
 b=TVCley5sXYaG1Bbk7PNPZeVyZF9J9mv6Xnc2meI9aXILVXwn/HjBxsDqcQx167nC9o
 RDqhByrZVEOxR6vo2NtQYDT4nSK9QWtMl+EvotNT15nn8Ip39zSYmKoVFhGDviGxRiOb
 VHvmvtJi3QFYUz0SVOY1GsDBP7AeSWlC+Tg2CfJlcvC9WPbA0HxsdZzR/2ooyFAR838/
 yf8Mlj5xcT4nZZGAjjZ58zIQBFVVhWeKJ6ylOGQDf6sB4IKp62bczlzBfXLbkrD5kaCJ
 80eoMFPk9tnrylfirX8RawD+AOJF6zmVZnLe56/jQrT4IvGi3+qdI/cs8AAsoG+klv4w
 Nf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794006872; x=1794611672;
 h=content-transfer-encoding:content-type:mime-version:organization
 :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N+qrBAabGgn7H1L5ektW2xbF5GlWpWVNETSk9hU3SmY=;
 b=M0rMeTM9taGwLcxqtKCw7KGavplaABvm1ohw8WUbvAkF1aDli2ij5ZcqfmBuPKrFJf
 RjKmiSvFdofmkcdJW066FlNxVi7tL3u7KeLv1OSM5nBYuRrFyNcfQGd9aKuA27gNp3M2
 oAw2RvUOCRterur8+pME9G081nf8vi+wVpDvTBzRwCi6Nipk0cZr7X3GYKUAsx5zPFcH
 TAS8kT3UNKvvE717aaqNj++vT1uraosmPHb20ckMnyxsi+OLitbT389sefZ1tOaTSdCT
 K8IWpWTrRQW4F/dwXJQNj5/gERmpbkVfTj5Ys3zAP1jYO5ck0poK3yoy9GR0H/CFhSoA
 MEMA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQvj2vlQ/AyTByvAFdqlNTVHmhKQ/e4e1nRh5mlkwsOecU2aSqqEMQBIeHmnfRNwtcoueZ3KzblSz+@nongnu.org
X-Gm-Message-State: APuU4Z/f/JijHHo4n7kfsmYaW3T+d6Xu+5ZVqgiaF5h/U4bNElnE0l2t
 Rzopao3q/TBVAFhP1annTzpA2TuO5gOKt0nATGXqaQPSJDjeW+eOCeQuNvdro38QyNM4Xgohkx1
 gTF+mX/Vij21PLGWX3Q/ma0AYl+NjANMDj0kILfjdz7kMJJbmmUOUeqNgNw==
X-Gm-Gg: AYBFou2uEmz2tSJUXaJJboDr2OuqTCbUnXDExm32XWXjQrIHLStv4QLeo4LT6t2Lgbw
 dIVhHsOv/t4qU1yesTJLdCoVIUZPJ7VeUTeq7JrGjphXAmp8MPZLzRxRNlZUA7eWLBrhVeJoNmW
 MTYbVJ2TebYM93lW8YAi7Zkfa3eOTxYHFdO6TJQpGATYaxpfRfETuWOII6DTad7LW3Gl2gXiTRd
 y3o4BZP3IJANGeJuhWb8Iy+//R28L98iOwzIc/T1aUPcXPS3WRmyoB4hp7ma9V81udryg0rrwQc
 G1tpkY1ewrkZ0Pb9pyajZurSFObrA4wcVe50qzQ118VnDuChB6dUC5yMkQkyqQJBh52lhL4uhkS
 KMd6Ke33dsRVRVVz8hmolI736kE7FJdMrgDMKjWhtvr0WpcxHzoJHC+l2ftdPpdzIq/jVBqLDQf
 cv1RFIv9D25g50uBDX5efaGE1O0g==
X-Received: by 2002:a05:7022:2206:b0:1b2:43b0:4794 with SMTP id
 a92af1059eb24-1b25d2f79ffmr6296947c88.9.1794006871136; 
 Fri, 06 Nov 2026 15:14:31 -0800 (PST)
X-Received: by 2002:a05:7022:2206:b0:1b2:43b0:4794 with SMTP id
 a92af1059eb24-1b25d2f79ffmr6296836c88.9.1794006869668; 
 Fri, 06 Nov 2026 15:14:29 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4c41eesm13094122c88.15.2026.11.06.15.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:14:29 -0800 (PST)
Date: Fri, 6 Nov 2026 15:14:24 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Peter Maydell
 <peter.maydell@linaro.org>,
 Jinjie Ruan <2118537295@qq.com>, <anisinha@redhat.com>,
 <armbru@redhat.com>, <eblake@redhat.com>, <imammedo@redhat.com>,
 <michael.roth@amd.com>, <mst@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
Message-ID: <20261106151424.00000fa2@oss.qualcomm.com>
In-Reply-To: <d9e9f9dc-3ac4-4455-b27a-f9a450d319bf@huawei.com>
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
 <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
 <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
 <tencent_82895B2529E419B263EC95C8349389114407@qq.com>
 <CAFEAcA-amrQOM8+qnaxgWLyGNM=vp-vKV=OqqU7Qp17PRiH_KA@mail.gmail.com>
 <501bf5cc-cee1-4593-943d-505003541d41@huawei.com>
 <CAFEAcA8ffgrbh_gUK7wcZW5E8p=ZC+CC=3U23ah+nWHxOGpjrg@mail.gmail.com>
 <20261020013906.0ee141e5@jic23-hlaptop>
 <d9e9f9dc-3ac4-4455-b27a-f9a450d319bf@huawei.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MiBTYWx0ZWRfX9XRzk7Y1ZxXl
 kCOsH237y9tgLlErbGzPLLNuVQ+k7WiJeBT8uv2TWQjOHSQxRGnMuJu7/1+TsUlgDB4gV5XlKCS
 cNkbPnqT3KIGtnfSJWNegjicLvMtLog=
X-Proofpoint-GUID: Cavr5expZkOKXOXAM2O4LNCniwA5tEg_
X-Authority-Analysis: v=2.4 cv=S7NMU4sP c=1 sm=1 tr=0 ts=6aee5f59 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=RQKcCSmWHK-HXnah-XcA:9 a=CjuIK1q_8ugA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MiBTYWx0ZWRfX0A5AIR+yxcqV
 Wh7jafJ6tGucs9TE7e+1ZxnB+otvMv+eEc1E9Qj1ZC2Ykn6wDR1iaH9r0NI8aM46XjAvgnr6hSs
 ek3QCDyEeCLpoV6RAaEku/FgC8R83ti24cM3NXzmaSL2akgnxyYwkIbHhFsHU5GbAvf5LhU99yC
 4qbwI8OYY2E/svOeSl1o+cLvh4Le0+IFAMnT00TIOtY2KrDx35d2t2quV6WZe4TmKb7zoV0j/cH
 nCzvWtpTF2JgVwkM0IxLHgfb1rjP8WexuJ54R0hjnbSKrv6Vr6oJU7DFKUKct6u1vSH7kpyxZuu
 cP1v2S1KKJVF4oz+YqLdLkbOfQvkmtN+9UG2ZOap62XYG0EWbf839jWgqIc5MZ4qVhDMZ55Mokz
 PFzvvCZAzwy+VsygfSb4TXWOQ++GBBgZm1U0eRelu5WOzMddh/6+dfYUj+zMOo+SR/jMUg7mEki
 UE+F/cgAIfV4lfDLK2Q==
X-Proofpoint-ORIG-GUID: Cavr5expZkOKXOXAM2O4LNCniwA5tEg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jonathan.cameron@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


> 
> Hi Jonathan,
> 
> > 
> > FWIW the much more minimal emulation that I posted years ago and
> > which I few crumbs of in here came up at plumbers this year with  
> 
> With your foundational patch, it is very convenient to extend
> other functionality.
> 
> > an engineer from yet another company asking if I could look at
> > rebasing and upstreaming because they also found it very useful.  
> 
> Glad to hear that someone else is also interested in QEMU emulation of MPAM.
> 
> > I was trying to work out if I could fit that into my todo list
> > or whether to ask a colleague to do it.
> > 
> > As such I'm very pleased to see this surface a few days later!
> > Even what I had was very useful for testing so I'm with this  
> 
> Feel the same way when developing new features or adapting test cases.
> 
> > much extended feature set I'm not surprised to hear even more
> > issues have shaken out.
> > 
> > It might take me a little while to get time to look at this series
> > but I definitely plan on doing so!  
> 
> Look forward to your review and suggestions.

I perhaps got a little carried away and decided to see how good an LLM
was at generating test cases for this... Was a little painful but
in the end I think helpful.

I also span a bunch of runtime options up to exercise all the optional
properties, field widths etc.  That adds about 600 lines of code and
25 machine properties (assuming just memory controller, l2 and l3 caches
+ all homogeneous.)  I might clean that up and post at some point but
it feels like an optional stage 2 on what you have here!

First up, bunch of fixes related to this.  The field access width ones
are probably most important and then the various width and HAS_ checks.
I haven't checked these all closely but some are obviously fine.

Because it might be helpful, the test follows.  I'm not suggesting this be
included for now anyway but might help you with v2!

Maybe long term we include a self test, but one that has had more review
than I've given this before sharing.

Easy to run with:

 QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/arm-mpam-test --verbose

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index f4f40cacf0..15280c44a0 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -711,6 +711,37 @@ void mpam_cache_fill_info(Object *obj, MpamCacheInfo *info)
 
 }
 
+/*
+ * IHI0099 9.4: a width-reported fraction field occupies the most
+ * significant 'wd' bits of its 16-bit field; the remaining low bits are
+ * RAZ/WI. Returns a mask of the bits software is allowed to set.
+ */
+static uint32_t mpam_fracwd_mask(uint32_t wd)
+{
+    if (wd >= 16) {
+        return 0xffffu;
+    }
+    return ~((1u << (16 - wd)) - 1) & 0xffffu;
+}
+
+/*
+ * IHI0099 9.4 (MPAMCFG_CPBM<n>/MPAMCFG_MBW_PBM<n>): bit x of register n is
+ * writable iff (n*32)+x <= wd. Returns the writable-bit mask for word
+ * 'array_offset' of such a bitmap, given the overall bitmap width 'wd'.
+ */
+static uint32_t mpam_bitmap_mask(uint32_t wd, uint32_t array_offset)
+{
+    int64_t remaining = (int64_t)wd + 1 - 32 * (int64_t)array_offset;
+
+    if (remaining <= 0) {
+        return 0;
+    }
+    if (remaining >= 32) {
+        return 0xffffffffu;
+    }
+    return (1u << remaining) - 1;
+}
+
 static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
                                   unsigned size)
 {
@@ -781,14 +812,38 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
     case A_MPAMF_MSMON_IDR:
         return mpamf->msmon_idr;
     case A_MPAMF_CSUMON_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CSUMON_IDR with no CSU monitor support\n");
+            return 0;
+        }
         return mpamf->csumon_idr;
     case A_MPAMF_MBWUMON_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of MBWUMON_IDR with no MBWU monitor support\n");
+            return 0;
+        }
         return mpamf->mbwumon_idr;
     case A_MSMON_CFG_MON_SEL:
         return s->mon_sel;
     case A_MSMON_CFG_CSU_FLT:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CSU_FLT with no CSU monitor support\n");
+            return 0;
+        }
         return mpam_csu_mon(s, mpam_mon_ris(s))->flt;
     case A_MSMON_CFG_CSU_CTL:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CSU_CTL with no CSU monitor support\n");
+            return 0;
+        }
         return mpam_csu_mon(s, mpam_mon_ris(s))->ctl;
     case A_MSMON_CSU ... (A_MSMON_CSU + 3):
     case A_MSMON_CSU_CAPTURE ... (A_MSMON_CSU_CAPTURE + 3):
@@ -802,12 +857,26 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return extract32(v, off * 8, 32 - off * 8);
     }
     case A_MSMON_CFG_MBWU_FLT:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of MBWU_FLT with no MBWU monitor support\n");
+            return 0;
+        }
         return mpam_mbwu_mon(s, mpam_mon_ris(s))->flt;
     case A_MSMON_CFG_MBWU_CTL:
     {
-        MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
-        uint32_t ctl = m->ctl;
+        MpamMbwuMon *m;
+        uint32_t ctl;
 
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of MBWU_CTL with no MBWU monitor support\n");
+            return 0;
+        }
+        m = mpam_mbwu_mon(s, mpam_mon_ris(s));
+        ctl = m->ctl;
         if (m->oflow) {
             ctl |= R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK;
         }
@@ -852,11 +921,24 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
     case A_MPAMF_ERR_MSI_ATTR:
         return mpamf->err_msi_attr;
     case A_MPAMF_ECR:
+        if (FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) &&
+            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_ESR)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected read of ECR with no ESR support\n");
+            return 0;
+        }
         return s->ecr;
     case A_MPAMF_ESR:
+        if (FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) &&
+            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_ESR)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected read of ESR with no ESR support\n");
+            return 0;
+        }
         return s->esr;
     case A_MPAMF_ESR + 0x4:
-        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, EXT)) {
+        if (!FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) ||
+            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR)) {
             qemu_log_mask(LOG_UNIMP,
                           "MPAM: Unexpected read of extended ESR\n");
             return 0;
@@ -876,33 +958,59 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->cfg_intpartid[s->part_sel];
     }
     case A_MPAMF_MPAMCFG_CMAX:
-        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
+            FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, NO_CMAX)) {
             qemu_log_mask(LOG_UNIMP,
-                "MPAM: Unexpected read of CMAX with no CCAP support\n");
+                "MPAM: Unexpected read of CMAX with no CMAX support\n");
             return 0;
         }
         return mpamf->per_nrw_id[nrw_part_sel].cfg_cmax;
     case A_MPAMF_MPAMCFG_CMIN:
-        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
+            !FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, HAS_CMIN)) {
             qemu_log_mask(LOG_UNIMP,
-                "MPAM: Unexpected read of CMIN with no CCAP support\n");
+                "MPAM: Unexpected read of CMIN with no CMIN support\n");
             return 0;
         }
         return mpamf->per_nrw_id[nrw_part_sel].cfg_cmin;
     case A_MPAMF_MPAMCFG_CASSOC:
-        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
+            !FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, HAS_CASSOC)) {
             qemu_log_mask(LOG_UNIMP,
-                "MPAM: Unexpected read of CASSOC with no CCAP support\n");
+                "MPAM: Unexpected read of CASSOC with no CASSOC support\n");
             return 0;
         }
         return mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc;
     case A_MPAMF_MPAMCFG_MBW_MIN:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
+            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MIN)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of MBW_MIN with no MBW_MIN support\n");
+            return 0;
+        }
         return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min;
     case A_MPAMF_MPAMCFG_MBW_MAX:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
+            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MAX)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of MBW_MAX with no MBW_MAX support\n");
+            return 0;
+        }
         return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max;
     case A_MPAMF_MPAMCFG_PRI:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CFG_PRI with no PRI PART support\n");
+            return 0;
+        }
         return mpamf->per_nrw_id[nrw_part_sel].cfg_pri;
     case A_MPAMF_MPAMCFG_MBW_PROP:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
+            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PROP)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of MBW_PROP with no MBW_PROP support\n");
+            return 0;
+        }
         return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop;
     case A_MPAMF_MPAMCFG_CPBM0...
         (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
@@ -922,9 +1030,10 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
     {
         uint32_t array_offset;
 
-        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART)) {
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
+            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PBM)) {
             qemu_log_mask(LOG_UNIMP,
-                "MPAM: Unexpected read of MBW_PBM with no MBW_PART support\n");
+                "MPAM: Unexpected read of MBW_PBM with no MBW_PBM support\n");
             return 0;
         }
         array_offset = (offset - A_MPAMF_MPAMCFG_MBW_PBM0) / sizeof(uint32_t);
@@ -1020,70 +1129,147 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
             FIELD_EX32(value, MPAMF_MPAMCFG_INTPARTID, INTPARTID);
         return;
     case A_MPAMF_MPAMCFG_CMAX:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
+            FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, NO_CMAX)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CMAX when not supported\n");
+            return;
+        }
         if (value & ~MPAMF_MPAMCFG_CMAX_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "MPAM: Unexpected write to CMAX Mask=%x Value=%lx\n",
                           MPAMF_MPAMCFG_CMAX_WRITE_MASK, value);
         }
-        mpamf->per_nrw_id[nrw_part_sel].cfg_cmax = value;
+        {
+            uint32_t wd = FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                      CMAX_WD);
+            uint32_t valid = mpam_fracwd_mask(wd);
+
+            if (FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                            HAS_CMAX_SOFTLIM)) {
+                valid |= R_MPAMF_MPAMCFG_CMAX_SOFTLIM_MASK;
+            }
+            mpamf->per_nrw_id[nrw_part_sel].cfg_cmax = value & valid;
+        }
         return;
     case A_MPAMF_MPAMCFG_CMIN:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
+            !FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, HAS_CMIN)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CMIN when not supported\n");
+            return;
+        }
         if (value & ~MPAMF_MPAMCFG_CMIN_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "MPAM: Unexpected write to CMIN Mask=%x Value=%lx\n",
                           MPAMF_MPAMCFG_CMIN_WRITE_MASK, value);
         }
-        mpamf->per_nrw_id[nrw_part_sel].cfg_cmin = value;
+        {
+            uint32_t wd = FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                      CMAX_WD);
+
+            mpamf->per_nrw_id[nrw_part_sel].cfg_cmin =
+                value & mpam_fracwd_mask(wd);
+        }
         return;
     case A_MPAMF_MPAMCFG_CASSOC:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
+            !FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, HAS_CASSOC)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CASSOC when not supported\n");
+            return;
+        }
         if (value & ~MPAMF_MPAMCFG_CASSOC_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "MPAM: Unexpected write to CASSOC Mask=%x Value=%lx\n",
                           MPAMF_MPAMCFG_CASSOC_WRITE_MASK, value);
         }
-        mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc = value;
+        {
+            uint32_t wd = FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                      CASSOC_WD);
+
+            mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc =
+                value & mpam_fracwd_mask(wd);
+        }
         return;
     case A_MPAMF_MPAMCFG_MBW_MIN:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
+            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MIN)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_MIN when not supported\n");
+            return;
+        }
         if (value & ~MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "MPAM: Unexpected write to MBW_MIN Mask=%x Value=%lx\n",
                           MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK, value);
         }
-        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min = value;
+        {
+            uint32_t wd = FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, BWA_WD);
+
+            mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min =
+                value & mpam_fracwd_mask(wd);
+        }
         return;
     case A_MPAMF_MPAMCFG_MBW_MAX:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
+            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MAX)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_MAX when not supported\n");
+            return;
+        }
         if (value & ~MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "MPAM: Unexpected write to MBW_MAX Mask=%x Value=%lx\n",
                           MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK, value);
         }
-        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max = value;
+        {
+            uint32_t wd = FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, BWA_WD);
+            uint32_t valid = mpam_fracwd_mask(wd) |
+                              R_MPAMF_MPAMCFG_MBW_MAX_HARDLIM_MASK;
+
+            mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max = value & valid;
+        }
         return;
     case A_MPAMF_MPAMCFG_PRI:
         if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
             qemu_log_mask(LOG_UNIMP,
                           "MPAM: Unexpected write to CFG_PRI when !HAS_PRI_PART\n");
-        } else {
-            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_DSPRI) &&
-                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, DSPRI)) {
-                qemu_log_mask(LOG_UNIMP,
-                              "MPAM: Unexpected write to CFGP_PRI DSPRI when !HAS_DSPRI\n");
-            }
-            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_INTPRI) &&
-                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, INTPRI)) {
-                qemu_log_mask(LOG_UNIMP,
-                              "MPAM: Unexpected write to CFGP_PRI INTPRI when !HAS_INTPRI\n");
-            }
+            return;
+        }
+        {
+            uint32_t intpri_wd = FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                             INTPRI_WD);
+            bool has_dspri = FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                        HAS_DSPRI);
+            uint32_t dspri_wd = FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                            DSPRI_WD);
+            uint32_t valid = mpam_fracwd_mask(intpri_wd) |
+                              (has_dspri ?
+                               (mpam_fracwd_mask(dspri_wd) << 16) : 0);
+
+            mpamf->per_nrw_id[nrw_part_sel].cfg_pri = value & valid;
         }
-        mpamf->per_nrw_id[nrw_part_sel].cfg_pri = value;
         return;
     case A_MPAMF_MPAMCFG_MBW_PROP:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
+            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PROP)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_PROP when not supported\n");
+            return;
+        }
         if (value & ~MPAMF_MPAMCFG_MBW_PROP_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "MPAM: Unexpected write to MBW_PROP Mask=%x Value=%lx\n",
                           MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK, value);
         }
-        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop = value;
+        {
+            uint32_t wd = FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, BWA_WD);
+            uint32_t valid = mpam_fracwd_mask(wd) |
+                              R_MPAMF_MPAMCFG_MBW_PROP_EN_MASK;
+
+            mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop = value & valid;
+        }
         return;
     case A_MPAMF_MPAMCFG_CPBM0...
         (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
@@ -1105,15 +1291,21 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
     {
         uint32_t array_offset;
 
-        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART)) {
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
+            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PBM)) {
             qemu_log_mask(LOG_UNIMP,
-                          "MPAM: Unexpected write to MBW_PBM when !HAS_MBW_PART\n");
+                          "MPAM: Unexpected write to MBW_PBM when not supported\n");
             return;
         }
-        /* TODO: Figure out write mask to check this stays in write bits */
         array_offset = (offset - A_MPAMF_MPAMCFG_MBW_PBM0) / sizeof(uint32_t);
 
-        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] = value;
+        {
+            uint32_t wd = FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR,
+                                      BWPBM_WD);
+
+            mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] =
+                value & mpam_bitmap_mask(wd, array_offset);
+        }
         return;
     }
     case A_MSMON_CFG_MON_SEL:
@@ -1151,6 +1343,12 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
     {
         uint32_t partid = FIELD_EX32(value, MSMON_CFG_MBWU_FLT, PARTID);
 
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBWU_FLT with no MBWU monitor support\n");
+            return;
+        }
         if (partid >= s->num_partid) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "MPAM: MBWU_FLT PARTID %d out of range\n", partid);
@@ -1166,9 +1364,16 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
     }
     case A_MSMON_CFG_MBWU_CTL:
     {
-        MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
+        MpamMbwuMon *m;
 
-        m->ctl = value;
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBWU_CTL with no MBWU monitor support\n");
+            return;
+        }
+        m = mpam_mbwu_mon(s, mpam_mon_ris(s));
+        m->ctl = value & ~0x00040f00u;
         if (value & R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK) {
             m->oflow = false;               /* write-one-to-clear */
         }
@@ -1190,6 +1395,12 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
     {
         uint32_t partid = FIELD_EX32(value, MSMON_CFG_CSU_FLT, PARTID);
 
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CSU_FLT with no CSU monitor support\n");
+            return;
+        }
         if (partid >= s->num_partid) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "MPAM: CSU_FLT PARTID %d out of range\n", partid);
@@ -1204,7 +1415,13 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
     case A_MSMON_CFG_CSU_CTL:
-        mpam_csu_mon(s, mpam_mon_ris(s))->ctl = value;
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
+            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CSU_CTL with no CSU monitor support\n");
+            return;
+        }
+        mpam_csu_mon(s, mpam_mon_ris(s))->ctl = value & ~0x7ffc0000u;
         return;
     case A_MSMON_CSU:
     case A_MSMON_CSU_CAPTURE:
@@ -1220,6 +1437,12 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
                       offset);
         return;
     case A_MPAMF_ECR:
+        if (FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) &&
+            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_ESR)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to ECR with no ESR support\n");
+            return;
+        }
         if (value & ~MPAMF_ECR_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "MPAM: Unexpected write to ECR Mask=%x Value=%lx\n",
@@ -1230,16 +1453,28 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         mpam_msc_update_err_irq(s);
         return;
     case A_MPAMF_ESR:
+        if (FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) &&
+            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_ESR)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to ESR with no ESR support\n");
+            return;
+        }
         /*
          * Software clears an error by writing ERRCODE as zero; writing a
          * non-zero ERRCODE activates the level error interrupt (8.2).
          */
-        s->esr = deposit64(s->esr, 0, 32, value);
+        s->esr = deposit64(s->esr, 0, 32, value & ~0x70000000u);
         mpam_msc_sync_esr_ecr(s);
         mpam_msc_update_err_irq(s);
         return;
     case A_MPAMF_ESR + 0x4:
-        s->esr = deposit64(s->esr, 32, 32, value);
+        if (!FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) ||
+            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to extended ESR\n");
+            return;
+        }
+        s->esr = deposit64(s->esr, 32, 32, value & ~0xfffffff0u);
         mpam_msc_sync_esr_ecr(s);
         mpam_msc_update_err_irq(s);
         return;
-- 
2.43.0

And the test
---
 tests/qtest/arm-mpam-test.c      | 766 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   1 +
 tests/qtest/run-arm-mpam-test.sh |  33 ++
 3 files changed, 800 insertions(+)

diff --git a/tests/qtest/arm-mpam-test.c b/tests/qtest/arm-mpam-test.c
new file mode 100644
index 0000000000..667820d427
--- /dev/null
+++ b/tests/qtest/arm-mpam-test.c
@@ -0,0 +1,766 @@
+/*
+ * QTest for ARM MPAM MSC register map, checked against IHI0099.
+ *
+ * Verifies, independently of hw/arm/mpam.c's own bit-position choices
+ * (the masks below are hand-derived from the spec, not #included from the
+ * device model): HAS_*-gated register presence/absence (RES0 when
+ * absent), reserved-bit zeroing, read-only enforcement on the ID-register
+ * block, and MPAMF_CFG_PART_SEL.RIS-based Resource Instance selection.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+/*
+ * "%s" is a splice point for a scenario's "x-mpam-no-X=on," fragment(s);
+ * build the full argument string at runtime with g_strdup_printf() since
+ * the fragment is itself runtime data, not a string literal.
+ */
+#define MACHINE_FMT \
+    "-machine virt,gic-version=max,mpam=on,mpam-min-msc=on,%s" \
+    "smp-cache.0.cache=l1i,smp-cache.0.topology=core," \
+    "smp-cache.1.cache=l1d,smp-cache.1.topology=core," \
+    "smp-cache.2.cache=l2,smp-cache.2.topology=cluster," \
+    "smp-cache.3.cache=l3,smp-cache.3.topology=socket " \
+    "-accel tcg -cpu max " \
+    "-smp cpus=8,sockets=2,clusters=2,cores=2,threads=1 " \
+    "-m 4G " \
+    "-object memory-backend-ram,id=mem0,size=2G " \
+    "-object memory-backend-ram,id=mem1,size=2G " \
+    "-numa node,nodeid=0,cpus=0-3,memdev=mem0 " \
+    "-numa node,nodeid=1,cpus=4-7,memdev=mem1 "
+
+/* Same topology/NUMA layout as MACHINE_FMT, but with mpam-min-msc=off: one
+ * single-RIS mem MSC per NUMA node with memory, instead of one consolidated
+ * multi-RIS mem MSC. */
+#define MACHINE_FMT_MIN_MSC_OFF \
+    "-machine virt,gic-version=max,mpam=on,mpam-min-msc=off,%s" \
+    "smp-cache.0.cache=l1i,smp-cache.0.topology=core," \
+    "smp-cache.1.cache=l1d,smp-cache.1.topology=core," \
+    "smp-cache.2.cache=l2,smp-cache.2.topology=cluster," \
+    "smp-cache.3.cache=l3,smp-cache.3.topology=socket " \
+    "-accel tcg -cpu max " \
+    "-smp cpus=8,sockets=2,clusters=2,cores=2,threads=1 " \
+    "-m 4G " \
+    "-object memory-backend-ram,id=mem0,size=2G " \
+    "-object memory-backend-ram,id=mem1,size=2G " \
+    "-numa node,nodeid=0,cpus=0-3,memdev=mem0 " \
+    "-numa node,nodeid=1,cpus=4-7,memdev=mem1 "
+
+#define MEM_MSC_BASE 0x0b006000
+
+/* Each MSC's MMIO window is MPAM_SIZE (16 KiB) - see
+ * include/hw/arm/mpam.h - independently re-derived here rather than
+ * #included, so a mismatch in hw/arm/virt.c's base-address arithmetic is a
+ * real finding. */
+#define MPAM_MSC_STRIDE 0x4000
+
+/* 2 L3 (one per socket) + 4 L2 (one per cluster), creation order per
+ * create_mpam_msc_cache() looping over sockets then clusters. */
+static const uint64_t cache_msc_base[] = {
+    0x0b00a000, 0x0b00e000,             /* L3: socket 0, socket 1 */
+    0x0b012000, 0x0b016000,             /* L2: socket0/cluster{0,1} */
+    0x0b01a000, 0x0b01e000,             /* L2: socket1/cluster{0,1} */
+};
+
+/* Under mpam-min-msc=off, the two NUMA nodes (each with memory) each get
+ * their own single-RIS mem MSC, so the cache MSCs' base addresses are
+ * shifted one extra MPAM_MSC_STRIDE later than under mpam-min-msc=on. */
+static const uint64_t mem_msc_base_min_msc_off[] = {
+    0x0b006000, 0x0b00a000,
+};
+static const uint64_t cache_msc_base_min_msc_off[] = {
+    0x0b00e000, 0x0b012000,             /* L3: socket 0, socket 1 */
+    0x0b016000, 0x0b01a000,             /* L2: socket0/cluster{0,1} */
+    0x0b01e000, 0x0b022000,             /* L2: socket1/cluster{0,1} */
+};
+
+/* Register offsets (IHI0099 7/8/9) */
+#define R_MPAMF_IDR_LO          0x000
+#define R_MPAMF_IDR_HI          0x004
+#define R_MPAMF_IIDR            0x018
+#define R_MPAMF_AIDR            0x020
+#define R_MPAMF_IMPL_IDR        0x028
+#define R_MPAMF_CPOR_IDR        0x030
+#define R_MPAMF_CCAP_IDR        0x038
+#define R_MPAMF_MBW_IDR         0x040
+#define R_MPAMF_PRI_IDR         0x048
+#define R_MPAMF_PARTID_NRW_IDR  0x050
+#define R_MPAMF_MSMON_IDR       0x080
+#define R_MPAMF_CSUMON_IDR      0x088
+#define R_MPAMF_MBWUMON_IDR     0x090
+#define R_MPAMF_ERR_MSI_MPAM    0x0dc
+#define R_MPAMF_ERR_MSI_ADDR_L  0x0e0
+#define R_MPAMF_ERR_MSI_ADDR_H  0x0e4
+#define R_MPAMF_ERR_MSI_DATA    0x0e8
+#define R_MPAMF_ERR_MSI_ATTR    0x0ec
+#define R_MPAMF_ECR             0x0f0
+#define R_MPAMF_ESR_LO          0x0f8
+#define R_MPAMF_ESR_HI          0x0fc
+#define R_MPAMF_CFG_PART_SEL    0x100
+#define R_MPAMCFG_CMAX          0x108
+#define R_MPAMCFG_CMIN          0x110
+#define R_MPAMCFG_CASSOC        0x118
+#define R_MPAMCFG_MBW_MIN       0x200
+#define R_MPAMCFG_MBW_MAX       0x208
+#define R_MPAMCFG_WINWD         0x220
+#define R_MPAMCFG_EN            0x300
+#define R_MPAMCFG_DIS           0x310
+#define R_MPAMCFG_EN_FLAGS      0x320
+#define R_MPAMCFG_PRI           0x400
+#define R_MPAMCFG_MBW_PROP      0x500
+#define R_MPAMCFG_INTPARTID     0x600
+#define R_MPAMCFG_CPBM0         0x1000
+#define R_MPAMCFG_MBW_PBM0      0x2000
+#define R_MSMON_CFG_MON_SEL     0x800
+#define R_MSMON_CFG_CSU_FLT     0x810
+#define R_MSMON_CFG_CSU_CTL     0x818
+#define R_MSMON_CFG_MBWU_FLT    0x820
+#define R_MSMON_CFG_MBWU_CTL    0x828
+
+/* IDR field positions, independently derived from IHI0099 9.3.1 */
+#define IDR_HAS_CCAP_PART     (1u << 24)
+#define IDR_HAS_CPOR_PART     (1u << 25)
+#define IDR_HAS_MBW_PART      (1u << 26)
+#define IDR_HAS_PRI_PART      (1u << 27)
+#define IDR_EXT               (1u << 28)
+#define IDR_HAS_IMPL_IDR      (1u << 29)
+#define IDR_HAS_MSMON         (1u << 30)
+#define IDR_HAS_PARTID_NRW    (1u << 31)
+#define IDR_HI_HAS_RIS        (1u << 0)
+#define IDR_HI_HAS_EXTD_ESR   (1u << 6)
+#define IDR_HI_HAS_ESR        (1u << 7)
+#define IDR_HI_HAS_ERR_MSI    (1u << 8)
+#define IDR_HI_RIS_MAX_SHIFT  24
+#define IDR_HI_RIS_MAX_MASK   0xfu
+#define MSMON_IDR_MSMON_CSU   (1u << 16)
+#define MSMON_IDR_MSMON_MBWU  (1u << 17)
+#define MBW_IDR_HAS_PROP      (1u << 13)
+#define CFG_PART_SEL_RIS_SHIFT 24
+
+/* MPAMF_CCAP_IDR/MPAMF_MBW_IDR/MPAMF_CPOR_IDR sub-fields (IHI0099
+ * 9.3.5/9.3.9/9.3.4), gating finer-grained MPAMCFG_* presence and
+ * width than the top-level HAS_CCAP_PART/HAS_MBW_PART bits do.
+ * Hand-derived from the spec, independent of hw/arm/mpam.c's own
+ * FIELD() positions. */
+#define CCAP_IDR_CMAX_WD_SHIFT    0
+#define CCAP_IDR_CMAX_WD_MASK     0x3fu
+#define CCAP_IDR_CASSOC_WD_SHIFT  8
+#define CCAP_IDR_CASSOC_WD_MASK   0x1fu
+#define CCAP_IDR_HAS_CASSOC       (1u << 28)
+#define CCAP_IDR_HAS_CMIN         (1u << 29)
+#define CCAP_IDR_NO_CMAX          (1u << 30)
+#define CCAP_IDR_HAS_CMAX_SOFTLIM (1u << 31)
+#define MBW_IDR_BWA_WD_SHIFT      0
+#define MBW_IDR_BWA_WD_MASK       0x3fu
+#define MBW_IDR_HAS_MIN           (1u << 10)
+#define MBW_IDR_HAS_MAX           (1u << 11)
+#define MBW_IDR_HAS_PBM           (1u << 12)
+#define MBW_IDR_BWPBM_WD_SHIFT    16
+#define MBW_IDR_BWPBM_WD_MASK     0x1fffu
+#define CPOR_IDR_CPBM_WD_SHIFT    0
+#define CPOR_IDR_CPBM_WD_MASK     0xffffu
+#define PRI_IDR_INTPRI_WD_SHIFT   4
+#define PRI_IDR_INTPRI_WD_MASK    0x3fu
+#define PRI_IDR_HAS_DSPRI         (1u << 16)
+#define PRI_IDR_DSPRI_WD_SHIFT    20
+#define PRI_IDR_DSPRI_WD_MASK     0x3fu
+
+typedef struct {
+    bool has_ccap_part, has_cpor_part, has_mbw_part, has_pri_part;
+    bool has_partid_nrw, has_msmon, has_impl_idr, ext;
+    bool has_msmon_csu, has_msmon_mbwu;
+    bool has_cmax, has_cmin, has_cassoc, has_cmax_softlim;
+    bool has_mbw_min, has_mbw_max, has_mbw_pbm, has_mbw_prop;
+    bool has_esr, has_extd_esr, has_err_msi;
+    bool has_dspri;
+    uint32_t cmax_wd, cassoc_wd, bwa_wd, cpbm_wd, bwpbm_wd;
+    uint32_t intpri_wd, dspri_wd;
+} MpamGates;
+
+typedef enum {
+    GATE_ALWAYS,
+    GATE_EXT,
+    GATE_HAS_IMPL_IDR,
+    GATE_HAS_CPOR_PART,
+    GATE_HAS_CCAP_PART,
+    GATE_HAS_MBW_PART,
+    GATE_HAS_PRI_PART,
+    GATE_HAS_PARTID_NRW,
+    GATE_HAS_MSMON_CSU,
+    GATE_HAS_MSMON_MBWU,
+    GATE_HAS_CMAX,
+    GATE_HAS_CMIN,
+    GATE_HAS_CASSOC,
+    GATE_HAS_MBW_MIN,
+    GATE_HAS_MBW_MAX,
+    GATE_HAS_MBW_PBM,
+    GATE_HAS_MBW_PROP,
+    GATE_HAS_ESR,
+    GATE_HAS_EXTD_ESR,
+    GATE_HAS_ERR_MSI,
+} MpamGate;
+
+/* Several MPAMCFG_* registers' valid-bit width is itself variable, governed
+ * by a _WD capability field (IHI0099 9.4). WK_NONE means "use the static
+ * reserved_mask below, unconditionally" as for every other register. */
+typedef enum {
+    WK_NONE,
+    WK_CMAX,
+    WK_CMIN,
+    WK_CASSOC,
+    WK_MBW_MIN,
+    WK_MBW_MAX,
+    WK_MBW_PROP,
+    WK_PRI,
+} WidthKind;
+
+typedef struct {
+    const char *name;
+    uint32_t offset;
+    uint32_t reserved_mask;
+    MpamGate gate;
+    bool ro;
+    WidthKind width_kind;
+} RegDesc;
+
+/*
+ * Reserved-bit masks are hand-derived from IHI0099's per-register bit
+ * tables (deliberately not reusing hw/arm/mpam.c's FIELD() positions),
+ * so a mismatch here is a real finding, not a tautology.
+ */
+static const RegDesc regs[] = {
+    { "MPAMF_IDR_LO",      R_MPAMF_IDR_LO,      0x00000000, GATE_ALWAYS,         true,  WK_NONE },
+    { "MPAMF_IDR_HI",      R_MPAMF_IDR_HI,      0xf0fff00e, GATE_EXT,            true,  WK_NONE },
+    { "MPAMF_IIDR",        R_MPAMF_IIDR,        0x00000000, GATE_ALWAYS,         true,  WK_NONE },
+    { "MPAMF_AIDR",        R_MPAMF_AIDR,        0xffffff00, GATE_ALWAYS,         true,  WK_NONE },
+    { "MPAMF_IMPL_IDR",    R_MPAMF_IMPL_IDR,    0x00000000, GATE_HAS_IMPL_IDR,   true,  WK_NONE },
+    { "MPAMF_CPOR_IDR",    R_MPAMF_CPOR_IDR,    0xffff0000, GATE_HAS_CPOR_PART,  true,  WK_NONE },
+    { "MPAMF_CCAP_IDR",    R_MPAMF_CCAP_IDR,    0x0fffe0c0, GATE_HAS_CCAP_PART,  true,  WK_NONE },
+    { "MPAMF_MBW_IDR",     R_MPAMF_MBW_IDR,     0xe00083c0, GATE_HAS_MBW_PART,   true,  WK_NONE },
+    { "MPAMF_PRI_IDR",     R_MPAMF_PRI_IDR,     0xfc0cfc0c, GATE_HAS_PRI_PART,   true,  WK_NONE },
+    { "MPAMF_PARTID_NRW_IDR", R_MPAMF_PARTID_NRW_IDR, 0xffff0000, GATE_HAS_PARTID_NRW, true, WK_NONE },
+    { "MPAMF_MSMON_IDR",   R_MPAMF_MSMON_IDR,   0x0ffcffff, GATE_ALWAYS,         true,  WK_NONE },
+    { "MPAMF_CSUMON_IDR",  R_MPAMF_CSUMON_IDR,  0x10ff0000, GATE_HAS_MSMON_CSU,  true,  WK_NONE },
+    { "MPAMF_MBWUMON_IDR", R_MPAMF_MBWUMON_IDR, 0x00e00000, GATE_HAS_MSMON_MBWU, true,  WK_NONE },
+
+    { "MPAMF_CFG_PART_SEL", R_MPAMF_CFG_PART_SEL, 0xf0fe0000, GATE_ALWAYS,       false, WK_NONE },
+
+    /* reserved_mask for these 7 is dynamic - see compute_reserved_mask() -
+     * since the valid bit width depends on a _WD capability field, and/or
+     * presence depends on a finer sub-bit than HAS_CCAP_PART/HAS_MBW_PART
+     * alone (IHI0099 9.4). The 0 below is intentionally unused. */
+    { "MPAMCFG_CMAX",      R_MPAMCFG_CMAX,      0x00000000, GATE_HAS_CMAX,       false, WK_CMAX     },
+    { "MPAMCFG_CMIN",      R_MPAMCFG_CMIN,      0x00000000, GATE_HAS_CMIN,       false, WK_CMIN     },
+    { "MPAMCFG_CASSOC",    R_MPAMCFG_CASSOC,    0x00000000, GATE_HAS_CASSOC,     false, WK_CASSOC   },
+    { "MPAMCFG_MBW_MIN",   R_MPAMCFG_MBW_MIN,   0x00000000, GATE_HAS_MBW_MIN,    false, WK_MBW_MIN  },
+    { "MPAMCFG_MBW_MAX",   R_MPAMCFG_MBW_MAX,   0x00000000, GATE_HAS_MBW_MAX,    false, WK_MBW_MAX  },
+
+    /* No case in mpam_msc_{read,write}_reg(): spec-defined offsets that
+     * are entirely unimplemented today, so they read 0 / ignore writes
+     * regardless of gate - recorded as a finding in the comment, not a
+     * hard failure, since the generic check happens to pass today. */
+    { "MPAMCFG_WINWD (unimplemented)",    R_MPAMCFG_WINWD,    0x00000000, GATE_ALWAYS, true, WK_NONE },
+    { "MPAMCFG_EN (unimplemented)",       R_MPAMCFG_EN,       0x00000000, GATE_ALWAYS, true, WK_NONE },
+    { "MPAMCFG_DIS (unimplemented)",      R_MPAMCFG_DIS,      0x00000000, GATE_ALWAYS, true, WK_NONE },
+    { "MPAMCFG_EN_FLAGS (unimplemented)", R_MPAMCFG_EN_FLAGS, 0x00000000, GATE_ALWAYS, true, WK_NONE },
+
+    { "MPAMCFG_PRI",       R_MPAMCFG_PRI,       0x00000000, GATE_HAS_PRI_PART,   false, WK_PRI       },
+    /* Known gap: mpam_msc_read_reg()/write_reg() gate this on HAS_MBW_PART
+     * only (hw/arm/mpam.c), not on the finer HAS_PROP sub-bit - expect a
+     * reported failure once HAS_PROP differs from HAS_MBW_PART, i.e. under
+     * x-mpam-no-mbw-prop. */
+    { "MPAMCFG_MBW_PROP",  R_MPAMCFG_MBW_PROP,  0x00000000, GATE_HAS_MBW_PROP,   false, WK_MBW_PROP  },
+    { "MPAMCFG_INTPARTID", R_MPAMCFG_INTPARTID, 0xfffe0000, GATE_HAS_PARTID_NRW, false, WK_NONE },
+    /* MPAMCFG_CPBM0/MPAMCFG_MBW_PBM0 are checked separately by
+     * check_bitmap_reg(), which walks every implemented word (plural,
+     * since CPBM_WD/BWPBM_WD can now exceed 31), not just word 0. */
+
+    /* IHI0099 9.3.1: implemented iff MPAMF_IDR_HI.HAS_ERR_MSI == 1 (itself
+     * only meaningful, and required 0, unless EXT==1). */
+    { "MPAMF_ERR_MSI_MPAM",   R_MPAMF_ERR_MSI_MPAM,   0x00000000, GATE_HAS_ERR_MSI, false, WK_NONE },
+    { "MPAMF_ERR_MSI_ADDR_L", R_MPAMF_ERR_MSI_ADDR_L, 0x00000000, GATE_HAS_ERR_MSI, false, WK_NONE },
+    { "MPAMF_ERR_MSI_ADDR_H", R_MPAMF_ERR_MSI_ADDR_H, 0x00000000, GATE_HAS_ERR_MSI, false, WK_NONE },
+    { "MPAMF_ERR_MSI_DATA",   R_MPAMF_ERR_MSI_DATA,   0x00000000, GATE_HAS_ERR_MSI, false, WK_NONE },
+    { "MPAMF_ERR_MSI_ATTR",   R_MPAMF_ERR_MSI_ATTR,   0x00000000, GATE_HAS_ERR_MSI, false, WK_NONE },
+
+    /* MPAMF_ECR/MPAMF_ESR are mandatory when !EXT (base MPAM); under EXT
+     * they're implemented iff HAS_ESR == 1 - see GATE_HAS_ESR derivation. */
+    { "MPAMF_ECR",         R_MPAMF_ECR,         0xfffffffe, GATE_HAS_ESR,        false, WK_NONE },
+    { "MPAMF_ESR_LO",      R_MPAMF_ESR_LO,      0x70000000, GATE_HAS_ESR,        false, WK_NONE },
+    /* ESR widens to 64 bits (this high half exists) iff HAS_EXTD_ESR == 1. */
+    { "MPAMF_ESR_HI",      R_MPAMF_ESR_HI,      0xfffffff0, GATE_HAS_EXTD_ESR,   false, WK_NONE },
+
+    /* Known gap: not gated by MSMON_IDR.MSMON_CSU/MBWU in the write path -
+     * expect a reported failure on the mem MSC (MSMON_CSU=0). */
+    { "MSMON_CFG_CSU_FLT",  R_MSMON_CFG_CSU_FLT,  0x7f000000, GATE_HAS_MSMON_CSU,  false, WK_NONE },
+    { "MSMON_CFG_CSU_CTL",  R_MSMON_CFG_CSU_CTL,  0x7ffc0000, GATE_HAS_MSMON_CSU,  false, WK_NONE },
+    { "MSMON_CFG_MBWU_FLT", R_MSMON_CFG_MBWU_FLT, 0x3f000000, GATE_HAS_MSMON_MBWU, false, WK_NONE },
+    { "MSMON_CFG_MBWU_CTL", R_MSMON_CFG_MBWU_CTL, 0x00040f00, GATE_HAS_MSMON_MBWU, false, WK_NONE },
+};
+
+static int g_failures;
+
+static void expect(bool cond, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
+
+static void expect(bool cond, const char *fmt, ...)
+{
+    if (!cond) {
+        va_list ap;
+        char *msg;
+
+        va_start(ap, fmt);
+        msg = g_strdup_vprintf(fmt, ap);
+        va_end(ap);
+
+        g_test_message("FAIL: %s", msg);
+        g_test_fail();
+        g_failures++;
+        g_free(msg);
+    }
+}
+
+static bool gate_present(const MpamGates *g, MpamGate gate)
+{
+    switch (gate) {
+    case GATE_ALWAYS:
+        return true;
+    case GATE_EXT:
+        return g->ext;
+    case GATE_HAS_IMPL_IDR:
+        return g->has_impl_idr;
+    case GATE_HAS_CPOR_PART:
+        return g->has_cpor_part;
+    case GATE_HAS_CCAP_PART:
+        return g->has_ccap_part;
+    case GATE_HAS_MBW_PART:
+        return g->has_mbw_part;
+    case GATE_HAS_PRI_PART:
+        return g->has_pri_part;
+    case GATE_HAS_PARTID_NRW:
+        return g->has_partid_nrw;
+    case GATE_HAS_MSMON_CSU:
+        return g->has_msmon_csu;
+    case GATE_HAS_MSMON_MBWU:
+        return g->has_msmon_mbwu;
+    case GATE_HAS_CMAX:
+        return g->has_cmax;
+    case GATE_HAS_CMIN:
+        return g->has_cmin;
+    case GATE_HAS_CASSOC:
+        return g->has_cassoc;
+    case GATE_HAS_MBW_MIN:
+        return g->has_mbw_min;
+    case GATE_HAS_MBW_MAX:
+        return g->has_mbw_max;
+    case GATE_HAS_MBW_PBM:
+        return g->has_mbw_pbm;
+    case GATE_HAS_MBW_PROP:
+        return g->has_mbw_prop;
+    case GATE_HAS_ESR:
+        return g->has_esr;
+    case GATE_HAS_EXTD_ESR:
+        return g->has_extd_esr;
+    case GATE_HAS_ERR_MSI:
+        return g->has_err_msi;
+    }
+    g_assert_not_reached();
+}
+
+/*
+ * MSB-aligned fraction-field reserved mask: bits [15:16-wd] are real,
+ * bits [16-wd-1:0] are RAZ/WI (IHI0099 9.4, "implemented bits ... are
+ * always the most significant bits of the field"). wd==0 reserves the
+ * whole low 16 bits; wd>=16 reserves none of them.
+ */
+static uint32_t frac16_reserved(uint32_t wd)
+{
+    if (wd >= 16) {
+        return 0;
+    }
+    return (1u << (16 - wd)) - 1;
+}
+
+/*
+ * LSB/position-indexed bitmap reserved mask for register word n: per the
+ * spec's literal RES0 condition "(n*32)+x > UInt(WD)" (IHI0099, the
+ * MPAMCFG_CPBM<n>/MPAMCFG_MBW_PBM<n> register descriptions), bit x of word n
+ * is reserved iff (n*32)+x > wd. A word entirely beyond the implemented
+ * range (remaining <= 0) is fully reserved; a word entirely within it
+ * (remaining >= 32) has nothing reserved.
+ */
+static uint32_t bitmapN_reserved(uint32_t wd, uint32_t n)
+{
+    int64_t remaining = (int64_t)wd + 1 - 32 * (int64_t)n;
+
+    if (remaining <= 0) {
+        return 0xffffffffu;
+    }
+    if (remaining >= 32) {
+        return 0;
+    }
+    return ~((1u << remaining) - 1);
+}
+
+static uint32_t compute_reserved_mask(const RegDesc *d, const MpamGates *g)
+{
+    switch (d->width_kind) {
+    case WK_NONE:
+        return d->reserved_mask;
+    case WK_CMAX:
+        /* bits[15:0] width-dependent; bit31 SOFTLIM gated on
+         * HAS_CMAX_SOFTLIM; bits[30:16] always reserved. */
+        return frac16_reserved(g->cmax_wd) | 0x7fff0000u |
+               (g->has_cmax_softlim ? 0 : 0x80000000u);
+    case WK_CMIN:
+        return frac16_reserved(g->cmax_wd) | 0xffff0000u;
+    case WK_CASSOC:
+        return frac16_reserved(g->cassoc_wd) | 0xffff0000u;
+    case WK_MBW_MIN:
+        return frac16_reserved(g->bwa_wd) | 0xffff0000u;
+    case WK_MBW_MAX:
+        /* bit31 HARDLIM unconditionally valid; bits[30:16] reserved. */
+        return frac16_reserved(g->bwa_wd) | 0x7fff0000u;
+    case WK_MBW_PROP:
+        /* bit31 EN unconditionally valid; bits[30:16] reserved. */
+        return frac16_reserved(g->bwa_wd) | 0x7fff0000u;
+    case WK_PRI:
+        /* INTPRI in bits[15:0], DSPRI in bits[31:16] (only present/valid
+         * when HAS_DSPRI); both are MSB-aligned fraction fields. */
+        return frac16_reserved(g->intpri_wd) |
+               (g->has_dspri ? (frac16_reserved(g->dspri_wd) << 16) :
+                                0xffff0000u);
+    }
+    g_assert_not_reached();
+}
+
+/* Select RIS 'ris' both for the main PARTID-config path (CFG_PART_SEL)
+ * and for the monitor-config path (MSMON_CFG_MON_SEL), which has an
+ * independent RIS selector (IHI0099 7.2.9). */
+static void select_ris(uint64_t base, uint32_t ris)
+{
+    writel(base + R_MPAMF_CFG_PART_SEL, ris << CFG_PART_SEL_RIS_SHIFT);
+    writel(base + R_MSMON_CFG_MON_SEL, ris << CFG_PART_SEL_RIS_SHIFT);
+}
+
+static MpamGates read_gates(uint64_t base)
+{
+    MpamGates g;
+    uint32_t idr_lo = readl(base + R_MPAMF_IDR_LO);
+    uint32_t msmon_idr, ccap_idr, mbw_idr, cpor_idr, idr_hi;
+
+    memset(&g, 0, sizeof(g));
+
+    g.has_ccap_part = idr_lo & IDR_HAS_CCAP_PART;
+    g.has_cpor_part = idr_lo & IDR_HAS_CPOR_PART;
+    g.has_mbw_part  = idr_lo & IDR_HAS_MBW_PART;
+    g.has_pri_part  = idr_lo & IDR_HAS_PRI_PART;
+    g.ext           = idr_lo & IDR_EXT;
+    g.has_impl_idr  = idr_lo & IDR_HAS_IMPL_IDR;
+    g.has_msmon     = idr_lo & IDR_HAS_MSMON;
+    g.has_partid_nrw = idr_lo & IDR_HAS_PARTID_NRW;
+
+    msmon_idr = g.has_msmon ? readl(base + R_MPAMF_MSMON_IDR) : 0;
+    g.has_msmon_csu  = msmon_idr & MSMON_IDR_MSMON_CSU;
+    g.has_msmon_mbwu = msmon_idr & MSMON_IDR_MSMON_MBWU;
+
+    ccap_idr = g.has_ccap_part ? readl(base + R_MPAMF_CCAP_IDR) : 0;
+    g.has_cmax         = g.has_ccap_part && !(ccap_idr & CCAP_IDR_NO_CMAX);
+    g.has_cmin         = g.has_ccap_part && (ccap_idr & CCAP_IDR_HAS_CMIN);
+    g.has_cassoc       = g.has_ccap_part && (ccap_idr & CCAP_IDR_HAS_CASSOC);
+    g.has_cmax_softlim = g.has_ccap_part &&
+                          (ccap_idr & CCAP_IDR_HAS_CMAX_SOFTLIM);
+    g.cmax_wd   = (ccap_idr >> CCAP_IDR_CMAX_WD_SHIFT) & CCAP_IDR_CMAX_WD_MASK;
+    g.cassoc_wd = (ccap_idr >> CCAP_IDR_CASSOC_WD_SHIFT) &
+                  CCAP_IDR_CASSOC_WD_MASK;
+
+    mbw_idr = g.has_mbw_part ? readl(base + R_MPAMF_MBW_IDR) : 0;
+    g.has_mbw_min  = g.has_mbw_part && (mbw_idr & MBW_IDR_HAS_MIN);
+    g.has_mbw_max  = g.has_mbw_part && (mbw_idr & MBW_IDR_HAS_MAX);
+    g.has_mbw_pbm  = g.has_mbw_part && (mbw_idr & MBW_IDR_HAS_PBM);
+    g.has_mbw_prop = g.has_mbw_part && (mbw_idr & MBW_IDR_HAS_PROP);
+    g.bwa_wd   = (mbw_idr >> MBW_IDR_BWA_WD_SHIFT) & MBW_IDR_BWA_WD_MASK;
+    g.bwpbm_wd = (mbw_idr >> MBW_IDR_BWPBM_WD_SHIFT) & MBW_IDR_BWPBM_WD_MASK;
+
+    cpor_idr = g.has_cpor_part ? readl(base + R_MPAMF_CPOR_IDR) : 0;
+    g.cpbm_wd = (cpor_idr >> CPOR_IDR_CPBM_WD_SHIFT) & CPOR_IDR_CPBM_WD_MASK;
+
+    {
+        uint32_t pri_idr = g.has_pri_part ? readl(base + R_MPAMF_PRI_IDR) : 0;
+
+        g.intpri_wd = (pri_idr >> PRI_IDR_INTPRI_WD_SHIFT) &
+                      PRI_IDR_INTPRI_WD_MASK;
+        g.has_dspri = g.has_pri_part && (pri_idr & PRI_IDR_HAS_DSPRI);
+        g.dspri_wd = (pri_idr >> PRI_IDR_DSPRI_WD_SHIFT) &
+                     PRI_IDR_DSPRI_WD_MASK;
+    }
+
+    /*
+     * MPAMF_ESR/MPAMF_ECR are mandatory in base (non-extended) MPAM, so
+     * HAS_ESR only narrows their presence when EXT==1 (IHI0099 9.3.1,
+     * "Discovery of MPAMF_ESR and MPAMF_ECR"); HAS_EXTD_ESR/HAS_ERR_MSI
+     * are themselves only meaningful (and non-RES0) when EXT==1.
+     */
+    idr_hi = g.ext ? readl(base + R_MPAMF_IDR_HI) : 0;
+    g.has_esr      = !g.ext || (idr_hi & IDR_HI_HAS_ESR);
+    g.has_extd_esr = g.ext && (idr_hi & IDR_HI_HAS_EXTD_ESR);
+    g.has_err_msi  = g.ext && (idr_hi & IDR_HI_HAS_ERR_MSI);
+
+    return g;
+}
+
+static void check_presence_and_reserved(uint64_t base, const RegDesc *d,
+                                         const MpamGates *gates,
+                                         const char *ctx)
+{
+    uint32_t value = readl(base + d->offset);
+    uint32_t reserved_mask = compute_reserved_mask(d, gates);
+
+    if (!gate_present(gates, d->gate)) {
+        expect(value == 0,
+               "%s: %s reads %#x while gated absent, expected RES0",
+               ctx, d->name, value);
+    } else {
+        expect((value & reserved_mask) == 0,
+               "%s: %s reserved bits set, value=%#x reserved_mask=%#x",
+               ctx, d->name, value, reserved_mask);
+    }
+}
+
+static void check_write_behaviour(uint64_t base, const RegDesc *d,
+                                   const MpamGates *gates, const char *ctx)
+{
+    uint32_t orig = readl(base + d->offset);
+    uint32_t reserved_mask = compute_reserved_mask(d, gates);
+    uint32_t after;
+
+    writel(base + d->offset, 0xffffffffu);
+    after = readl(base + d->offset);
+
+    if (d->ro) {
+        expect(after == orig,
+               "%s: %s is read-only but changed %#x -> %#x on write",
+               ctx, d->name, orig, after);
+    } else if (!gate_present(gates, d->gate)) {
+        expect(after == 0,
+               "%s: %s write took effect (%#x) while gated absent",
+               ctx, d->name, after);
+    } else {
+        expect((after & reserved_mask) == 0,
+               "%s: %s reserved bits became settable, value=%#x reserved_mask=%#x",
+               ctx, d->name, after, reserved_mask);
+    }
+
+    /* Restore so later registers/RIS in this MSC aren't perturbed. */
+    writel(base + d->offset, orig);
+}
+
+/*
+ * MPAMCFG_CPBM<n>/MPAMCFG_MBW_PBM<n> are a multi-word bitmap, unlike every
+ * other register in regs[] - walk every word up to one past the
+ * implemented range (wd/32 + 1 words), rather than just word 0, to confirm
+ * the first fully-unimplemented word also reads back as entirely reserved.
+ */
+static void check_bitmap_reg(uint64_t base, uint32_t offset0, uint32_t wd,
+                              bool present, const char *name,
+                              const char *ctx)
+{
+    uint32_t words_impl = wd / 32 + 1;
+    uint32_t words_to_check = words_impl + 1;
+    uint32_t n;
+
+    for (n = 0; n < words_to_check; n++) {
+        uint32_t offset = offset0 + n * 4;
+        uint32_t reserved_mask = present ? bitmapN_reserved(wd, n) :
+                                            0xffffffffu;
+        uint32_t orig = readl(base + offset);
+        uint32_t after;
+        char *rctx = g_strdup_printf("%s word %u", name, n);
+
+        if (!present) {
+            expect(orig == 0,
+                   "%s: %s reads %#x while gated absent, expected RES0",
+                   ctx, rctx, orig);
+        } else {
+            expect((orig & reserved_mask) == 0,
+                   "%s: %s reserved bits set, value=%#x reserved_mask=%#x",
+                   ctx, rctx, orig, reserved_mask);
+        }
+
+        writel(base + offset, 0xffffffffu);
+        after = readl(base + offset);
+        if (!present) {
+            expect(after == 0,
+                   "%s: %s write took effect (%#x) while gated absent",
+                   ctx, rctx, after);
+        } else {
+            expect((after & reserved_mask) == 0,
+                   "%s: %s reserved bits became settable, value=%#x reserved_mask=%#x",
+                   ctx, rctx, after, reserved_mask);
+        }
+        writel(base + offset, orig);
+
+        g_free(rctx);
+    }
+}
+
+static void check_ris_selection(uint64_t base, uint32_t num_ris,
+                                 const char *ctx)
+{
+    uint32_t before, after, ris_mask = 0xfu << CFG_PART_SEL_RIS_SHIFT;
+    uint32_t ris;
+
+    before = readl(base + R_MPAMF_CFG_PART_SEL);
+    writel(base + R_MPAMF_CFG_PART_SEL, num_ris << CFG_PART_SEL_RIS_SHIFT);
+    after = readl(base + R_MPAMF_CFG_PART_SEL);
+    expect((after & ris_mask) == (before & ris_mask),
+           "%s: selecting out-of-range RIS %u (num_ris=%u) was not rejected"
+           " (CFG_PART_SEL %#x -> %#x)",
+           ctx, num_ris, num_ris, before, after);
+
+    for (ris = 0; ris < num_ris; ris++) {
+        writel(base + R_MPAMF_CFG_PART_SEL, ris << CFG_PART_SEL_RIS_SHIFT);
+        after = readl(base + R_MPAMF_CFG_PART_SEL);
+        expect(((after >> CFG_PART_SEL_RIS_SHIFT) & 0xf) == ris,
+               "%s: selecting valid RIS %u did not round-trip (read back %#x)",
+               ctx, ris, after);
+    }
+
+    writel(base + R_MPAMF_CFG_PART_SEL, before);
+}
+
+static void check_msc(uint64_t base, const char *ctx)
+{
+    uint32_t idr_hi, num_ris;
+    size_t i;
+
+    qtest_system_reset(global_qtest);
+
+    select_ris(base, 0);
+    idr_hi = readl(base + R_MPAMF_IDR_LO) & IDR_EXT ?
+             readl(base + R_MPAMF_IDR_HI) : 0;
+    num_ris = (idr_hi & IDR_HI_HAS_RIS) ?
+              ((idr_hi >> IDR_HI_RIS_MAX_SHIFT) & IDR_HI_RIS_MAX_MASK) + 1 : 1;
+
+    g_test_message("%s: num_ris=%u", ctx, num_ris);
+
+    if (num_ris > 1) {
+        check_ris_selection(base, num_ris, ctx);
+    }
+
+    for (uint32_t ris = 0; ris < num_ris; ris++) {
+        MpamGates gates;
+        char *ris_ctx = g_strdup_printf("%s RIS %u", ctx, ris);
+
+        select_ris(base, ris);
+        gates = read_gates(base);
+
+        for (i = 0; i < G_N_ELEMENTS(regs); i++) {
+            check_presence_and_reserved(base, &regs[i], &gates, ris_ctx);
+            check_write_behaviour(base, &regs[i], &gates, ris_ctx);
+        }
+
+        check_bitmap_reg(base, R_MPAMCFG_CPBM0, gates.cpbm_wd,
+                         gates.has_cpor_part, "MPAMCFG_CPBM0", ris_ctx);
+        check_bitmap_reg(base, R_MPAMCFG_MBW_PBM0, gates.bwpbm_wd,
+                         gates.has_mbw_pbm, "MPAMCFG_MBW_PBM0", ris_ctx);
+
+        g_free(ris_ctx);
+    }
+}
+
+static void test_mem_msc(void)
+{
+    check_msc(MEM_MSC_BASE, "mem MSC");
+}
+
+static void test_cache_msc_0(void) { check_msc(cache_msc_base[0], "cache MSC 0 (L3 socket0)"); }
+static void test_cache_msc_1(void) { check_msc(cache_msc_base[1], "cache MSC 1 (L3 socket1)"); }
+static void test_cache_msc_2(void) { check_msc(cache_msc_base[2], "cache MSC 2 (L2 socket0/cluster0)"); }
+static void test_cache_msc_3(void) { check_msc(cache_msc_base[3], "cache MSC 3 (L2 socket0/cluster1)"); }
+static void test_cache_msc_4(void) { check_msc(cache_msc_base[4], "cache MSC 4 (L2 socket1/cluster0)"); }
+static void test_cache_msc_5(void) { check_msc(cache_msc_base[5], "cache MSC 5 (L2 socket1/cluster1)"); }
+
+/*
+ * mpam-min-msc=off gives each NUMA node with memory its own single-RIS mem
+ * MSC instead of one MSC with multiple RIS - reboot and re-run the same
+ * check_msc() walk against both mem MSCs and all 6 (now differently based)
+ * cache MSCs, to confirm create_mpam_msc()'s base-address arithmetic for
+ * this path.
+ */
+static void test_mpam_min_msc_off(void)
+{
+    char *machine_args = g_strdup_printf(MACHINE_FMT_MIN_MSC_OFF, "");
+    size_t i;
+
+    qtest_end();
+    qtest_start(machine_args);
+    g_free(machine_args);
+
+    for (i = 0; i < G_N_ELEMENTS(mem_msc_base_min_msc_off); i++) {
+        char *ctx = g_strdup_printf("mem MSC %zu (mpam-min-msc=off)", i);
+        check_msc(mem_msc_base_min_msc_off[i], ctx);
+        g_free(ctx);
+    }
+    for (i = 0; i < G_N_ELEMENTS(cache_msc_base_min_msc_off); i++) {
+        char *ctx = g_strdup_printf("cache MSC %zu (mpam-min-msc=off)", i);
+        check_msc(cache_msc_base_min_msc_off[i], ctx);
+        g_free(ctx);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    const char *arch = qtest_get_arch();
+    GPtrArray *full_argv = g_ptr_array_new();
+    int full_argc;
+
+    /*
+     * Failures here are reported via g_test_fail()/g_test_message() so the
+     * walk can continue past the first mismatch; that only works if the
+     * overall suite doesn't bail out after the first failed test, which is
+     * GLib's default without "-k"/"--keep-going". Inject it unconditionally
+     * so this holds regardless of how the binary is invoked (meson test,
+     * standalone, ...).
+     */
+    g_ptr_array_add(full_argv, argv[0]);
+    g_ptr_array_add(full_argv, (char *)"-k");
+    for (int i = 1; i < argc; i++) {
+        g_ptr_array_add(full_argv, argv[i]);
+    }
+    full_argc = full_argv->len;
+    g_ptr_array_add(full_argv, NULL);
+    argv = (char **)full_argv->pdata;
+    argc = full_argc;
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "aarch64") || !qtest_has_machine("virt")) {
+        g_test_skip("'aarch64/virt' machine is not available");
+        return 0;
+    }
+
+    qtest_add_func("/arm-mpam/mem-msc", test_mem_msc);
+    qtest_add_func("/arm-mpam/cache-msc-0", test_cache_msc_0);
+    qtest_add_func("/arm-mpam/cache-msc-1", test_cache_msc_1);
+    qtest_add_func("/arm-mpam/cache-msc-2", test_cache_msc_2);
+    qtest_add_func("/arm-mpam/cache-msc-3", test_cache_msc_3);
+    qtest_add_func("/arm-mpam/cache-msc-4", test_cache_msc_4);
+    qtest_add_func("/arm-mpam/cache-msc-5", test_cache_msc_5);
+    qtest_add_func("/arm-mpam/mpam-min-msc-off", test_mpam_min_msc_off);
+
+    {
+        char *machine_args = g_strdup_printf(MACHINE_FMT, "");
+        qtest_start(machine_args);
+        g_free(machine_args);
+    }
+    ret = g_test_run();
+    qtest_end();
+
+    g_test_message("total failures recorded: %d", g_failures);
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ff4bf9528a..ea2ecb7eea 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -296,6 +296,7 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_ARM_VIRT') ?
    ['iommu-smmuv3-test'] : []) + \
   (config_all_devices.has_key('CONFIG_WDT_SBSA') ? ['sbsa-gwdt-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_MPAM') ? ['arm-mpam-test'] : []) + \
   qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
diff --git a/tests/qtest/run-arm-mpam-test.sh b/tests/qtest/run-arm-mpam-test.sh
new file mode 100755
index 0000000000..03323afee8
--- /dev/null
+++ b/tests/qtest/run-arm-mpam-test.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+# Build and run tests/qtest/arm-mpam-test.c against a given build directory.
+#
+# Usage: tests/qtest/run-arm-mpam-test.sh [build-dir] [-- extra test args]
+#
+# build-dir defaults to "build" relative to the repo root, and must already
+# be configured with --target-list=aarch64-softmmu (or including it).
+
+set -e
+
+SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
+REPO_ROOT=$(cd "$SCRIPT_DIR/../.." && pwd)
+BUILD_DIR="${1:-$REPO_ROOT/build}"
+
+if [ -n "$1" ] && [ "$1" != "--" ]; then
+    shift
+fi
+if [ "$1" = "--" ]; then
+    shift
+fi
+
+if [ ! -f "$BUILD_DIR/build.ninja" ]; then
+    echo "error: '$BUILD_DIR' is not a configured build directory" >&2
+    echo "configure one first, e.g.:" >&2
+    echo "  $REPO_ROOT/configure --target-list=aarch64-softmmu" >&2
+    exit 1
+fi
+
+cd "$BUILD_DIR"
+ninja tests/qtest/arm-mpam-test
+
+QTEST_QEMU_BINARY=./qemu-system-aarch64 \
+    exec ./tests/qtest/arm-mpam-test --verbose "$@"
-- 
2.43.0

> 
> > 
> > Jonathan
> > 
> > p.s. On off chance that (carefully unnamed) engineer sees this I
> >      had no idea ruanjinjie was working on this.
> > 
> >      Must have been something in the air :)  
> 


