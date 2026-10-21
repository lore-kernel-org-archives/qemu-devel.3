Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D6606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CLAZ/eWm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fDCFMTsv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoC-0004NC-2w; Wed, 21 Oct 2026 14:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao4-0004LC-CM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao1-000822-LR
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpJDl1359519
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hKm3M8SW97wrfjSlpsXEmZiJdKTe9+UAL2wVL8taLd4=; b=CLAZ/eWmk7ji/BaV
 z+kAQFSbbssOndaaPO+Aykw40QqY+G8T6hykq7LGJrNqBt11IzOE98g7x7Gz32z9
 SEbfrW54JKELBzXEiox76n3QQ/Coesn4C/oLms1gtOLdDERy3tdgGa5GXQ0MkzSB
 u5MJZi0VSO8tvIjx/pK3ZqHgogwvnKNT0a4iykxsyUFpXuhvsOUHK3cd2aqHaCcb
 CZQs517Ve+GvoN+I36wpNY2fgo1zUhGNiJekxf8w+WbCN88pYfTm5H8kJrOjS7A3
 cQEdszBVR3FxcPc7cBU25wuzv8UlAm4uzpzZK8lq+sm9hEfYnraqKzwTBq/gTKPE
 zi+oCw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj4a7ct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a46f0f158dso138524a91.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606371; x=1793211171; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hKm3M8SW97wrfjSlpsXEmZiJdKTe9+UAL2wVL8taLd4=;
 b=fDCFMTsvt8CoT90QQuloKH63FR/eUahpevtHyobiOqEZ1IjRQUJMX7Tpr5KDrDkj3D
 lbp4IP+GBJvWFVjlPY8Xha5cYjw9tdqbGCLCViPXM2Pf2eUS3CwYjiIsGZlxUMDMsCv3
 f8Wu0Ux3Z1JBMD4ki5naGG01Dej4nA9q+mGIpJw9K/43D4i8OM7x/X8P6CdY3AfFaYCM
 +ohmRMtS+3wn6zpLbk7yfiBcNG1mC0eRVrABO9vp7aWlyjiS00AZHQ7Qc++bWiGm4kM2
 kaMNI/Zi5e/13zsqOwkE5jnNLkarQEnHqyWUiZND058KEop2WBKIrEKtL6LGUNko6HbC
 dH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606371; x=1793211171;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hKm3M8SW97wrfjSlpsXEmZiJdKTe9+UAL2wVL8taLd4=;
 b=frWzNMtM/WEqeEQcMBDGhWkD+x6aPBqoMvV0M5QtaipeE4ptphfiiCB2jMjY+Kw9SV
 Q8hq3E9tPDQfGEiJdlWSh+TeR3I0bPseD6fsIYUz+m6qgLJjBBwZ0VgzpHKOLIPyg396
 ZZ849Id2g4n02c+mWyXEdoQPI4h6LBzIb+ukVHC2nn7KV/U9TO6a+YFa5uN9Yh+Sa4eP
 IDYCERWAAyNiE8OFu74WBCRXMgwFJMafAYMl8TxoqSC7uC88/Lwz+L7vIrPqUu45JICt
 0rlsTrA3IHaQW7I2QV4vVbWLxuEXvSkqF7kU9Ldi/v+A4Ux137xsDsPerRwamE4cRVCs
 jWXw==
X-Gm-Message-State: AFq9FYIbxact2R6Dl4jbC+T4qfM7Ll9RvalCRooQUHO1hMz5ylCdy7WV
 VnlL5TDvIRfMHKzGF6PPfFiT7CCM3DVX4/LJEJAsko7BwE0js/JkkTKboMsWue4tCk/pQ6nf3Bh
 1Rvbg0MMCbjmtzLoAeV1N2E33HNDoJJo5fjCinf2BKt/LuXuiQ7CFqN9h98ZgqBPTXA==
X-Gm-Gg: AYBFou2m6KiTc9rH7d1PoT37DNzpzC78cEBfHzmZ0N48YOfVedUMtw4R/nqcDNTjEqD
 UQq5NaG/hUHvQDiNQcJcxfwSrAsZ6zmkHINzk7LHqVf6JXLUZ0jQczTBKNrRG1hhZCKB2101WuT
 PNqa5L8exhTRk9kJisQQpHdYcvjQ4ZMR/8Sn7UwSC/J2BAfiIQp3noE2wsDZa+fUeocruwY0/2l
 dRUbcjCygCI63drmhGrMnGeGnsJVGXMzxoarLL/kozPwKyZzHTjPJ9T0OgqZB7O+cjPGeD1Bv3Y
 c1ZxDD5Yt5m61RuZ0lYDlQT6V/orIQx+l9TAe0Sjqx/zIqGhxGVA83uG3ahVz2QVJEyve9NxIZt
 5m8NBdLyQGffE0Y5Lv95Q3DlGSXXSiCQWfMYN4bbKRwcYWlkvzPNWHeW1u8gZFAE=
X-Received: by 2002:a17:90b:5109:b0:3ac:928a:68ce with SMTP id
 98e67ed59e1d1-3ada6c9d358mr63978a91.33.1792606371005; 
 Wed, 21 Oct 2026 11:12:51 -0700 (PDT)
X-Received: by 2002:a17:90b:5109:b0:3ac:928a:68ce with SMTP id
 98e67ed59e1d1-3ada6c9d358mr63959a91.33.1792606370477; 
 Wed, 21 Oct 2026 11:12:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 02/21] dump/dump: do not dump machine if doing
 heterogeneous emulation
Date: Wed, 21 Oct 2026 11:12:25 -0700
Message-ID: <20261021181244.867840-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tEwk3hjXIgrzoZqsbNiU59PY2OR5FRTQ
X-Proofpoint-GUID: tEwk3hjXIgrzoZqsbNiU59PY2OR5FRTQ
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad900a4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=3q1FPIo8JGfx5WVhvewA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX1U7IFJg1mOMZ
 2iOJPmqp19UQ02SrB6NF/v71YT+DSFrGWBDEmfOoPrMoCDzpCOjAxo+GE8abk138Y1We5HkNqU2
 TN+Xcq1kI5rMkHtxSlV5LhVPqeIytPhBLACq2HZqn/J/XJXZQhvXLIm2Kn2DvhiAhOcsQKpyCcm
 9ELLAFIs5lRdPB0ty6takmozkaBqu0a+bhow7V4o5Qzkpt5424/DwGhpKtjv/yUeGl+Dkbk9p1c
 SK3ATAV3ZrHXEcx3+M3sRV5xdFf3BC5Syqr25GckbHuWOOqnynnuWQw53Yhe0E8mCh713KpSXsu
 VArtgyZHzKlF05sRXVypyOjPsbbKudwhfUJFxWDut12i885yX/M8Zpt+xc7xWfLE54Dz5F4Exay
 xHnyRXgICkWus5Qa5aN7FNHVeoj3n2kKitWdwk0aDh7PGpanK7lLxh9zIwXHYBZ8QFfWJ0568DT
 J4QrxxEjIY46XeKKoqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfXzI1dX6+bw2Mt
 XzthL4/U20cnXq0Hagq3qCGakqOG6gaYhhyFdJhJlxAI0R1GCFE1EG2TPXigT2pKPMZqqnWgWyv
 BgF+CSJUdFVMqgPFd8Tpg91UhlZSTXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This would need some refactoring to do it correctly over all targets
involved. For now, simply prevent this from happening.

We do the check at beginning of function, so no need to call cleanup
routine.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dump/dump.c b/dump/dump.c
index 52be7258a5d..0ecff682dd4 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1795,6 +1795,12 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     int nr_cpus;
     int ret;
 
+    if (target_heterogeneous()) {
+        error_setg(errp,
+                   "dumping guest memory is not supported for heterogeneous emulation");
+        return;
+    }
+
     s->has_format = has_format;
     s->format = format;
     s->written_size = 0;
-- 
2.47.3


