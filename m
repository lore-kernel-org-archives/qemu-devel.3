Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ED6C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2X-0006oD-Fq; Fri, 17 Jul 2026 15:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2W-0006nG-5u
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2U-00084V-J8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGo4sV2372001
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dtdOH53AMHLIX3SwaSQjU1e9K4NoiOgfgUpgSnC/+rs=; b=NM8QgQMcUpjwYzJK
 erFph/coKkDtTj/O7jIUA79gPKKYCOa2G2JSHxDJ7bCl66CtT+ITGu4RFqprNWTr
 /sV3nYHQGKKnRiHbJqkyFKJK0+pWumI+8HrzZMhq3WcUvfcMZteyTXbwndFK6HWB
 mleZDdGt2WEUQ/YV8FqZv1rQno4uGA+50CwXohP8zfidAvBTmsBoUEnlbET3AcEQ
 sPQS63Zp4+8uQ8zeQFF0oueg324RJfBihvWsXGKv7MuqRiMMiKm0aQhkeH61muI0
 LCMfUUMvJ19cOdXz9Ds0rH/LnfJe17dTJaW5fQF08J5nneiG9Ky5PX7so8z6iqlY
 BI5zxA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gu01d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso589970a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315760; x=1784920560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dtdOH53AMHLIX3SwaSQjU1e9K4NoiOgfgUpgSnC/+rs=;
 b=OIxww6lpjWYIaN2qNwCsOhbWVRYASdnDrDkr8Aywq2yFU3hWr2qh5UfvSiaVmx6lDL
 gOpysHcsFvIGN9Yw7GGH8U5ynwzq2W5PUG+Lw/Nn28tnCzzsTMivh4Rw3vJqtdrTuk1U
 a9kcVObSLPrCdxzUGQslPcW1rFbj08Al1UHnV7VS3nhvTPqzpTJ9Jju1aUU/MGFrrSc9
 +CcGXo6zpy0JxE0pmD8tFCqjz2LhoU1gtmKQimNYBXJlwA3v1XHGlCXvlIKm0YRQEbwT
 C4HyPr+YTbCfLsfaJU/8mH2Os10RyiW2kYPFuS/CumCu7y+QlxFHAzBf6xLGOzTyYesp
 1P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315760; x=1784920560;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dtdOH53AMHLIX3SwaSQjU1e9K4NoiOgfgUpgSnC/+rs=;
 b=Dze/4wMi+Ok5sD9i8X8j170nyf0oXOtnDvEQhs8PVXe7k27dPUwVK1XBOfu0ZHBcoK
 yKNvl3I8lYiBv8gGW5oO8axb4PwR6jPQYuPhmKXFuwomce5trpCn/wEdOFtDLZFnb2Cw
 0ADnhjwn1D41a/08CCnmbaeyVTXAWzjHsLuzldNNTTWdSSW1sbQjFC6Y8Lq3ZSGI3acT
 pZBKY081VfLDeOri20rve1wcwc5V5QceDY/yhCnYIR/9XrqMmSnSr7Vjdtzi15QB1ECa
 qLEJLElN5fyi67QXALrZs777am6sqjalHcOpJ/3FMtjftR2iFU79lWyWA9IDuqVa7kYu
 yaow==
X-Gm-Message-State: AOJu0YxnMF1Mcat6EMty3QVbKOQTkWmqMEQkZYjK8o2NsjJFUFLKTNLK
 +sZDmT2ML3dYe5TfhSYxzZlppXBd475mf0M3BqxvBPKjOS2PyOl+mdS9Lwl9QODL9ysIBaVzr5o
 g2gSg9H5qrOhLPqoIOM1vd1Xsdej61F+IoVAq+83S5nYGWCG37u8SITEL0i2z0oCpOA==
X-Gm-Gg: AfdE7clNr0XkKstSwd5AISgsGISDGMkkMTpvdEyGVCBi9hxuJHFeOgS3OhnH2tHhuhx
 nCZIM4Cru3Mgp37tMrDgiJgeeHZ2ox1LFqK//yIqz33TyNozVByIXrYIokuDSDaEtJeziWANj2V
 Zge86SzBp4dUq7b9MjWdTDNIYdmPZj3CBO5oZ4GHEbagjPAB6eTsUmlan07SjQMjvh2GIkh7+OE
 ZwueBlqZP9jexMq7xKhctwgUGv1KlJ4MCQgPbeJP6yUriIzZREp1H5YYiS/QOz/BG5jmDeZsULq
 rfbHVaf1QK2WRD5aQ74m6kop8PeXL4R1LjAxo+JQBUbpSczMnGqEh/A1kWHfLqSXsDot9gHnWL/
 mFznsxiQ86Epdc1/rUmc0yhAgDTKm+boSaGAAy0Ft53Qg22u1
X-Received: by 2002:a17:90b:2642:b0:381:6466:7160 with SMTP id
 98e67ed59e1d1-38e4b56d7b2mr4468640a91.26.1784315760183; 
 Fri, 17 Jul 2026 12:16:00 -0700 (PDT)
X-Received: by 2002:a17:90b:2642:b0:381:6466:7160 with SMTP id
 98e67ed59e1d1-38e4b56d7b2mr4468577a91.26.1784315759453; 
 Fri, 17 Jul 2026 12:15:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:15:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PULL 05/12] target/hexagon: raise SIGBUS on unaligned scalar loads
Date: Fri, 17 Jul 2026 12:15:40 -0700
Message-Id: <20260717191547.920048-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX1YaW7qC4/obb
 fSAOVCBCT/lvG2JBnpHtZzVNDmBcatxm/QuprVkr4ajl1bvD6uusDluEp07ljtqXqsfWV7WSo4Y
 PJU3fyyyCNN4rkbrGamNKjA6ZOgn57s=
X-Proofpoint-ORIG-GUID: NyGbvNuAIbLy0CWfgWKCTuKCvuHyedd_
X-Proofpoint-GUID: NyGbvNuAIbLy0CWfgWKCTuKCvuHyedd_
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a7f71 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=f50odatAX-H4vQHS3akA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX0vU45JmIiDAI
 c8AbroA5C0cloJQzvrHaWu4SRFmMgjx7ls6AROahPweIadKlnHNj96SVXo/c0prl3eH7ciFUW2k
 ocf8RrhdYDDKmDNaQnG2XtqqneUxzw5lscfOdmdLEy8EQYzIwGZGYSgIw1ORnUdhfggnt6QUmAQ
 5ua8ryRs0iQEgBJAwMEzRhV4KvLOgdjbGULw87deepp/8r4g10xd3u8bBt8OW9yA/h2O+hm0TU7
 ywXM5/g8128Gbyfv2tLFf/tLdHq0aEJqfNlXeZ4nqwdAQ5UAka4GMy2mJwbBghLUHkFcHDW7LUP
 JTN/jldl45vBkSAwRe2s0xyeTJEAM/F5gz12H5nCuc12Gsq0bCUbl97g7flCETsxF600l5l41ky
 dakZdXVek3s0rogWew3GbU+ROTYK3C5WBdkNS10LF5PC4dFlHmBmYXZHYyZfK27SjDFgUpR9gbU
 VYpj8JDI6vmW1hZ7ClA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

aGV4YWdvbi1saW51eC11c2VyIGhhZCBubyBlbmZvcmNlbWVudCBvZiBhbGlnbm1lbnQgZm9yIHNj
YWxhciBsb2FkCmV4Y2VwdGlvbnMsIGFuZCB1bmFsaWduZWQgbG9hZHMgc2lsZW50bHkgc3VjY2Vl
ZGVkIGluc3RlYWQgb2YgcmFpc2luZwpTSUdCVVMuCgpBZGQgTU9fQUxJR04gdG8gdGhlIE1FTV9M
T0FEKiBtYWNyb3MsIHRoZSBsb2NrZWQtbG9hZCBhbmQKbG9hZC1mcmFtZSBoZWxwZXJzIGluIGdl
bnB0ci5jLCBhbmQgdGhlIGlkZWYtcGFyc2VyJ3MgZkxPQUQuCgpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1i
eTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVh
bGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vbWFjcm9zLmggICAgICAgICAgICAgICAgICAg
ICB8IDI2ICsrKysrKysrKysrKystLS0tLS0tLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAg
ICAgICAgICAgICAgICAgICB8ICA2ICsrLS0tCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9w
YXJzZXItaGVscGVycy5jIHwgIDIgKy0KIDMgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygr
KSwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgg
Yi90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaAppbmRleCA4YTMyZDVmNzljMi4uYTViOWMyNGM2YmIg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oCisrKyBiL3RhcmdldC9oZXhhZ29u
L21hY3Jvcy5oCkBAIC0xMDYsMzcgKzEwNiwzNyBAQAogI2RlZmluZSBNRU1fTE9BRDFzKERTVCwg
VkEpIFwKICAgICBkbyB7IFwKICAgICAgICAgQ0hFQ0tfTk9TSFVGKFZBLCAxKTsgXAotICAgICAg
ICB0Y2dfZ2VuX3FlbXVfbGRfdGwoRFNULCBWQSwgY3R4LT5tZW1faWR4LCBNT19TQik7IFwKKyAg
ICAgICAgdGNnX2dlbl9xZW11X2xkX3RsKERTVCwgVkEsIGN0eC0+bWVtX2lkeCwgTU9fU0IgfCBN
T19BTElHTik7IFwKICAgICB9IHdoaWxlICgwKQogI2RlZmluZSBNRU1fTE9BRDF1KERTVCwgVkEp
IFwKICAgICBkbyB7IFwKICAgICAgICAgQ0hFQ0tfTk9TSFVGKFZBLCAxKTsgXAotICAgICAgICB0
Y2dfZ2VuX3FlbXVfbGRfdGwoRFNULCBWQSwgY3R4LT5tZW1faWR4LCBNT19VQik7IFwKKyAgICAg
ICAgdGNnX2dlbl9xZW11X2xkX3RsKERTVCwgVkEsIGN0eC0+bWVtX2lkeCwgTU9fVUIgfCBNT19B
TElHTik7IFwKICAgICB9IHdoaWxlICgwKQogI2RlZmluZSBNRU1fTE9BRDJzKERTVCwgVkEpIFwK
ICAgICBkbyB7IFwKICAgICAgICAgQ0hFQ0tfTk9TSFVGKFZBLCAyKTsgXAotICAgICAgICB0Y2df
Z2VuX3FlbXVfbGRfdGwoRFNULCBWQSwgY3R4LT5tZW1faWR4LCBNT19MRSB8IE1PX1NXKTsgXAor
ICAgICAgICB0Y2dfZ2VuX3FlbXVfbGRfdGwoRFNULCBWQSwgY3R4LT5tZW1faWR4LCBNT19MRSB8
IE1PX1NXIHwgTU9fQUxJR04pOyBcCiAgICAgfSB3aGlsZSAoMCkKICNkZWZpbmUgTUVNX0xPQUQy
dShEU1QsIFZBKSBcCiAgICAgZG8geyBcCiAgICAgICAgIENIRUNLX05PU0hVRihWQSwgMik7IFwK
LSAgICAgICAgdGNnX2dlbl9xZW11X2xkX3RsKERTVCwgVkEsIGN0eC0+bWVtX2lkeCwgTU9fTEUg
fCBNT19VVyk7IFwKKyAgICAgICAgdGNnX2dlbl9xZW11X2xkX3RsKERTVCwgVkEsIGN0eC0+bWVt
X2lkeCwgTU9fTEUgfCBNT19VVyB8IE1PX0FMSUdOKTsgXAogICAgIH0gd2hpbGUgKDApCiAjZGVm
aW5lIE1FTV9MT0FENHMoRFNULCBWQSkgXAogICAgIGRvIHsgXAogICAgICAgICBDSEVDS19OT1NI
VUYoVkEsIDQpOyBcCi0gICAgICAgIHRjZ19nZW5fcWVtdV9sZF90bChEU1QsIFZBLCBjdHgtPm1l
bV9pZHgsIE1PX0xFIHwgTU9fU0wpOyBcCisgICAgICAgIHRjZ19nZW5fcWVtdV9sZF90bChEU1Qs
IFZBLCBjdHgtPm1lbV9pZHgsIE1PX0xFIHwgTU9fU0wgfCBNT19BTElHTik7IFwKICAgICB9IHdo
aWxlICgwKQogI2RlZmluZSBNRU1fTE9BRDR1KERTVCwgVkEpIFwKICAgICBkbyB7IFwKICAgICAg
ICAgQ0hFQ0tfTk9TSFVGKFZBLCA0KTsgXAotICAgICAgICB0Y2dfZ2VuX3FlbXVfbGRfdGwoRFNU
LCBWQSwgY3R4LT5tZW1faWR4LCBNT19MRSB8IE1PX1VMKTsgXAorICAgICAgICB0Y2dfZ2VuX3Fl
bXVfbGRfdGwoRFNULCBWQSwgY3R4LT5tZW1faWR4LCBNT19MRSB8IE1PX1VMIHwgTU9fQUxJR04p
OyBcCiAgICAgfSB3aGlsZSAoMCkKICNkZWZpbmUgTUVNX0xPQUQ4dShEU1QsIFZBKSBcCiAgICAg
ZG8geyBcCiAgICAgICAgIENIRUNLX05PU0hVRihWQSwgOCk7IFwKLSAgICAgICAgdGNnX2dlbl9x
ZW11X2xkX2k2NChEU1QsIFZBLCBjdHgtPm1lbV9pZHgsIE1PX0xFIHwgTU9fVVEpOyBcCisgICAg
ICAgIHRjZ19nZW5fcWVtdV9sZF9pNjQoRFNULCBWQSwgY3R4LT5tZW1faWR4LCBNT19MRSB8IE1P
X1VRIHwgTU9fQUxJR04pOyBcCiAgICAgfSB3aGlsZSAoMCkKIAogI2RlZmluZSBNRU1fU1RPUkUx
X0ZVTkMoWCkgXApAQCAtNTE5LDkgKzUxOSwxNSBAQCBzdGF0aWMgaW5saW5lIFRDR3YgZ2VuX3Jl
YWRfaXJlZyhUQ0d2IHJlc3VsdCwgVENHdiB2YWwsIGludCBzaGlmdCkKICNkZWZpbmUgZkxPQUQo
TlVNLCBTSVpFLCBTSUdOLCBFQSwgRFNUKSBNRU1fTE9BRCMjU0laRSMjU0lHTihEU1QsIEVBKQog
I2Vsc2UKICNkZWZpbmUgTUVNX0xPQUQxIGNwdV9sZHViX2RhdGFfcmEKLSNkZWZpbmUgTUVNX0xP
QUQyIGNwdV9sZHV3X2xlX2RhdGFfcmEKLSNkZWZpbmUgTUVNX0xPQUQ0IGNwdV9sZGxfbGVfZGF0
YV9yYQotI2RlZmluZSBNRU1fTE9BRDggY3B1X2xkcV9sZV9kYXRhX3JhCisjZGVmaW5lIE1FTV9M
T0FEMihFTlYsIEVBLCBSQSkgXAorICAgIGNwdV9sZHdfbW11KEVOViwgRUEsIG1ha2VfbWVtb3Bf
aWR4KE1PX0xFVVcgfCBNT19BTElHTiwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNwdV9tbXVfaW5kZXgoZW52X2NwdShFTlYpLCBmYWxzZSkpLCBSQSkKKyNkZWZp
bmUgTUVNX0xPQUQ0KEVOViwgRUEsIFJBKSBcCisgICAgY3B1X2xkbF9tbXUoRU5WLCBFQSwgbWFr
ZV9tZW1vcF9pZHgoTU9fTEVVTCB8IE1PX0FMSUdOLCBcCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY3B1X21tdV9pbmRleChlbnZfY3B1KEVOViksIGZhbHNlKSksIFJB
KQorI2RlZmluZSBNRU1fTE9BRDgoRU5WLCBFQSwgUkEpIFwKKyAgICBjcHVfbGRxX21tdShFTlYs
IEVBLCBtYWtlX21lbW9wX2lkeChNT19MRVVRIHwgTU9fQUxJR04sIFwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjcHVfbW11X2luZGV4KGVudl9jcHUoRU5WKSwgZmFs
c2UpKSwgUkEpCiAKICNkZWZpbmUgZkxPQUQoTlVNLCBTSVpFLCBTSUdOLCBFQSwgRFNUKSBcCiAg
ICAgZG8geyBcCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9o
ZXhhZ29uL2dlbnB0ci5jCmluZGV4IDFlYmM3NDcxNDA5Li4wNWM5YWEwNDQ2NyAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMK
QEAgLTQ3MCwxNCArNDcwLDE0IEBAIHZvaWQgZ2VuX3NldF9ieXRlX2k2NChpbnQgTiwgVENHdl9p
NjQgcmVzdWx0LCBUQ0d2IHNyYykKIAogc3RhdGljIGlubGluZSB2b2lkIGdlbl9sb2FkX2xvY2tl
ZDR1KFRDR3YgZGVzdCwgVENHdiB2YWRkciwgaW50IG1lbV9pbmRleCkKIHsKLSAgICB0Y2dfZ2Vu
X3FlbXVfbGRfdGwoZGVzdCwgdmFkZHIsIG1lbV9pbmRleCwgTU9fTEUgfCBNT19VTCk7CisgICAg
dGNnX2dlbl9xZW11X2xkX3RsKGRlc3QsIHZhZGRyLCBtZW1faW5kZXgsIE1PX0xFIHwgTU9fVUwg
fCBNT19BTElHTik7CiAgICAgdGNnX2dlbl9tb3ZfdGwoaGV4X2xsc2NfYWRkciwgdmFkZHIpOwog
ICAgIHRjZ19nZW5fbW92X3RsKGhleF9sbHNjX3ZhbCwgZGVzdCk7CiB9CiAKIHN0YXRpYyBpbmxp
bmUgdm9pZCBnZW5fbG9hZF9sb2NrZWQ4dShUQ0d2X2k2NCBkZXN0LCBUQ0d2IHZhZGRyLCBpbnQg
bWVtX2luZGV4KQogewotICAgIHRjZ19nZW5fcWVtdV9sZF9pNjQoZGVzdCwgdmFkZHIsIG1lbV9p
bmRleCwgTU9fTEUgfCBNT19VUSk7CisgICAgdGNnX2dlbl9xZW11X2xkX2k2NChkZXN0LCB2YWRk
ciwgbWVtX2luZGV4LCBNT19MRSB8IE1PX1VRIHwgTU9fQUxJR04pOwogICAgIHRjZ19nZW5fbW92
X3RsKGhleF9sbHNjX2FkZHIsIHZhZGRyKTsKICAgICB0Y2dfZ2VuX21vdl9pNjQoaGV4X2xsc2Nf
dmFsX2k2NCwgZGVzdCk7CiB9CkBAIC04OTAsNyArODkwLDcgQEAgc3RhdGljIHZvaWQgZ2VuX2xv
YWRfZnJhbWUoRGlzYXNDb250ZXh0ICpjdHgsIFRDR3ZfaTY0IGZyYW1lLCBUQ0d2IEVBKQogewog
ICAgIEluc24gKmluc24gPSBjdHgtPmluc247ICAvKiBOZWVkZWQgZm9yIENIRUNLX05PU0hVRiAq
LwogICAgIENIRUNLX05PU0hVRihFQSwgOCk7Ci0gICAgdGNnX2dlbl9xZW11X2xkX2k2NChmcmFt
ZSwgRUEsIGN0eC0+bWVtX2lkeCwgTU9fTEUgfCBNT19VUSk7CisgICAgdGNnX2dlbl9xZW11X2xk
X2k2NChmcmFtZSwgRUEsIGN0eC0+bWVtX2lkeCwgTU9fTEUgfCBNT19VUSB8IE1PX0FMSUdOKTsK
IH0KIAogLyogU3RhY2sgb3ZlcmZsb3cgY2hlY2sgKi8KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMgYi90YXJnZXQvaGV4YWdvbi9pZGVmLXBh
cnNlci9wYXJzZXItaGVscGVycy5jCmluZGV4IGI5NDJkOWVhMTZiLi40OWNjMTFmZGRkOCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jCkBAIC0xNzcwLDcg
KzE3NzAsNyBAQCB2b2lkIGdlbl9sb2FkKENvbnRleHQgKmMsIFlZTFRZUEUgKmxvY3AsIEhleFZh
bHVlICp3aWR0aCwKICAgICBpZiAoc2lnbmVkbmVzcyA9PSBTSUdORUQpIHsKICAgICAgICAgT1VU
KGMsIGxvY3AsICIgfCBNT19TSUdOIik7CiAgICAgfQotICAgIE9VVChjLCBsb2NwLCAiIHwgTU9f
TEUpO1xuIik7CisgICAgT1VUKGMsIGxvY3AsICIgfCBNT19MRSB8IE1PX0FMSUdOKTtcbiIpOwog
fQogCiB2b2lkIGdlbl9zdG9yZShDb250ZXh0ICpjLCBZWUxUWVBFICpsb2NwLCBIZXhWYWx1ZSAq
d2lkdGgsIEhleFZhbHVlICplYSwKLS0gCjIuMzQuMQoK

