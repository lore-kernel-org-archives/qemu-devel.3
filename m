Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE01606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sf1gMFAE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cFiSujah
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxvx-0004tz-IJ; Fri, 30 Oct 2026 21:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvN-0004fR-R1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvL-00034N-PE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1CJFw1314050
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LZVPrgUcBFSe3ERqc57EGsfmd9oq4Kb126CnDQijOE0=; b=Sf1gMFAEXTyo98Q4
 e03DZ1tssJXjIg1lKkFHQPSsa7mrkHDYGAh5vN6ZSi0N4WK3IzA6XYp7hfWSK/5d
 M8Ag9XuO09fIpWDyCQbSpiHZP869QFxDctKvRa/ov76tQvinzjf+uca/CQIZIH4j
 xUe8nxv/gC2WMrggH++Hk+Qx2jfQGSpE8YdKecxDf30MZnF69ipi+zQ80oBVQLaH
 bydZf3YijwILKXI3Zq/9vAeK3hyPidqLqUxDkMJxZqkl5X7sWJzCETVaH1Il7whU
 wUiDwSwHS80rgjCDaRj+uYmdy+evWTU+W0Gv+ewDcWDEoH2/bL5diErmt6+QlPrm
 R3b8sA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x10qt2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a223755e4so5113586eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410221; x=1794015021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LZVPrgUcBFSe3ERqc57EGsfmd9oq4Kb126CnDQijOE0=;
 b=cFiSujahaWd3Gqcbf54qY6iQcO3oJG7s2LMUq5pgCAYVq3tYoIA5YkzgHHAaJDy9BH
 Ir5jTCVRh/V+LInW8NDw9h2Ie1WJ5+Ab+og2+OM/CfSsNpy2AIpvahqMmYSpuWJbF+r/
 zMltbAeCfWribfOtGN3elrPUQ0kfEG2uUJA1FIV/BXiQUGdRtbcGGcC6/Pt3QIWlxz5f
 bocglwr8m8aC7SHEWOgK+cG+GXUzCwj5uE5rgnsX+CcxRZagqWXq0Yhb7bUZFCu/IhUb
 Tft+YUfPw4w/CuxvUZxW0+Ggsl5y5p3s161cuoFP091RFgWig1oy1HaAIfBqIOvHAkrs
 dZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410221; x=1794015021;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LZVPrgUcBFSe3ERqc57EGsfmd9oq4Kb126CnDQijOE0=;
 b=Ac9qTeSb1u5jv697/nhySsRP2OGwJHWjWAe1knLLat0n31zbApv8TORe9g78dpok3y
 02kk3/eF+MGGl5ASIOq3t68A7UhCE5SBiJM0OD7OIVqKTZmrzA1oFERo3ovOdNeHv6ox
 Qx+PbERZ/eDmnbVR8WP0TidW+LGvJhWvBP+Q1A2qaNYINSVPNdencVlgAGwA0YtxsL2m
 4WUEFU3RiJaySqGdT/hgV9fQxvtT1/96soaufYU1GK+3rID0m3GciiQBtFittlzajyVf
 ZdeWeMdXte5q8v1/gsc8PM5nqNbVQH/AXdWkfwpmns8wTArX04aaO7dN0G5L7Igu8QFW
 k4IQ==
X-Gm-Message-State: AFq9FYJFRkwULNCyYe6F/3mDCpGtk2SNI0ZoqMi1q9ufs1CynR5A8AwM
 rn5e2UVquWQ8C2ps3YhaEO5kzKDbEnp8rywoijhQ9IyR3mGIPoeuVSOAPXiFs4eBor7VtwNIsZC
 dn4jXMcDUmlEKcKOX12uhKQomIck9sHHBBAxgVnaOd50cRtggmFEUGSIcKHuVrQrj4A==
X-Gm-Gg: AYBFou1gICzaB684FaKciEclnSCp2xOxHNTj+fRtP7Pz5Mqx6S20wKIunZ2lHx0MRyu
 YXkQvArJQF7ExXif1cZPuf5+648880V8vlDrYx6TnFHZoM/gHMp5VrCWpPsR6rCMCGO0lLaTZr8
 mD6xzR+Xhz+2UVxclL3IMVX7zn0quBAo8/GJ88NiuDFtnBtLrcvI6mReHuhVPB9fTtlFasa+zrj
 en+izZVyvVaMAS8St5Fti8OIFmcdqtQaxcQkV9yqhSoVgp2mv08l2oqyXaKMUwDB2jIq3z0Ozy4
 dNm95WCkU9wlRcF6Synl/JQ8dctBlGusd9SQzEJ/B+/sCytTh9YDqvi9KMo3n2NwYjK1mlyOU4c
 ZCQK7O5RxVglCWbCRNJo+vGdsrVBYaZarCJ8IoOZcVDx/ePq+fGUkWgX+AL2KiYbqcr4hRrTFSJ
 359mFSdUtL6TRgW58IJ0NDeg==
X-Received: by 2002:a05:7301:4543:b0:347:8d01:164f with SMTP id
 5a478bee46e88-36a42378cd8mr5430181eec.19.1793410221359; 
 Fri, 30 Oct 2026 18:30:21 -0700 (PDT)
X-Received: by 2002:a05:7301:4543:b0:347:8d01:164f with SMTP id
 5a478bee46e88-36a42378cd8mr5430128eec.19.1793410220578; 
 Fri, 30 Oct 2026 18:30:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 14/40] target/hexagon: add HLX attributes and exception cause
Date: Fri, 30 Oct 2026 18:29:15 -0700
Message-Id: <20261031012941.339141-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX0qe8lyV8VlmZ
 Z8XqWEgthXLNiU4TPgKDpEqSL4b2d+Bwl9Me6U8uCJvQ61Q+faIlrTV47BWM1fbW7tWUESzXhtv
 nRL9UXBp8zzEn35VwgH+V5wZYRv+36LprPLIKXYAyak1EHyP2aPcVfZDacc7mAXCS/tW00DYoRT
 WAT2vxy+FrOvbXz8grGCJMDczm71/EX1rybwKgIZxSkSxZiX6b+tdPXFna2Gp5O8bUFAULlmya4
 x+QiAFfrWuF+CVfya6cMY7QPeCUf1VBWYrjEptVVqQeLWnhg11CqUuzln45VtVJnbJn6ZCdHOfw
 Rda3PiI57Iy4QjPBI3upGg1y+GhYrXKXNxTPvEpky2Cejchg20hypdaJhH9GiEtWYr9fa3YzeWV
 Udb9lko0LXM9C2eLI6GuCYb+3aMIXYbZkw5dAyEsAqSTOtYLtzv5eRphH1TpeyBSZxkJTxlwJk/
 NggwOX+RvV/I767HxPA==
X-Authority-Analysis: v=2.4 cv=CLG/zhrD c=1 sm=1 tr=0 ts=6ae544ae cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=SQNLHeiHp6WtZxeD8egA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX2Zp1POZ4rLa+
 iybHucly4yZyLUdo8ert4sLwSIfle8ifCpUDiL3tGzoR5BzqwRQ6Gkjl8/zmOx9f3GQp0255sT4
 Fq4swsXavC1vJRPepESu89iR8clsLJE=
X-Proofpoint-GUID: Bv2ffDMv3dsPmzNresWM5gxHhskHawN5
X-Proofpoint-ORIG-GUID: Bv2ffDMv3dsPmzNresWM5gxHhskHawN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310005
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCkFkZCBI
TFggaW5zdHJ1Y3Rpb24gYXR0cmlidXRlcywgYSBwYWNrZXQgZmxhZywgYW5kIHRoZQpOT19DT1BS
T0MzX0VOQUJMRSBleGNlcHRpb24gY2F1c2UuCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBMaWViZWwg
PG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMu
aCAgICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdvbi9pbnNuLmggICAgICAgICAgICB8ICAxICsK
IHRhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jIHwgMTggKysrKysrKysrKysrKysrKysr
CiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyAgICAgICAgICB8ICAxICsKIDQgZmlsZXMgY2hhbmdl
ZCwgMjEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9iaXRz
LmggYi90YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCmluZGV4IGM5YmEwOTk4OWUwLi42NWRkYTIx
NzVkNSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaAorKysgYi90YXJnZXQv
aGV4YWdvbi9jcHVfYml0cy5oCkBAIC03OSw2ICs3OSw3IEBAIGVudW0gaGV4X2NhdXNlIHsKICAg
ICBIRVhfQ0FVU0VfSU5WQUxJRF9PUENPREUgPSAweDAxNSwgLyogYWxpYXM6IHNhbWUgY2F1c2Ug
YXMgSU5WQUxJRF9QQUNLRVQgKi8KICAgICBIRVhfQ0FVU0VfTk9fQ09QUk9DX0VOQUJMRSA9IDB4
MDE2LAogICAgIEhFWF9DQVVTRV9OT19DT1BST0MyX0VOQUJMRSA9IDB4MDE4LAorICAgIEhFWF9D
QVVTRV9OT19DT1BST0MzX0VOQUJMRSA9IDB4MDE5LAogICAgIEhFWF9DQVVTRV9QUklWX1VTRVJf
Tk9fR0lOU04gPSAweDAxYSwKICAgICBIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX1NJTlNOID0gMHgw
MWIsCiAgICAgSEVYX0NBVVNFX1ZFQ1RPUl9TVEFDS19PVkVSRkxPVyA9IDB4MDFjLApkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vaW5zbi5oIGIvdGFyZ2V0L2hleGFnb24vaW5zbi5oCmluZGV4
IDVkNTk0MzBkYTllLi41NzUxYzljZWQ5ZCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW5z
bi5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2luc24uaApAQCAtNzEsNiArNzEsNyBAQCBzdHJ1Y3Qg
UGFja2V0IHsKIAogICAgIGJvb2wgcGt0X2hhc19odng7CiAgICAgSW5zbiAqdmhpc3RfaW5zbjsK
KyAgICBib29sIHBrdF9oYXNfaGx4OwogCiAgICAgSW5zbiBpbnNuW0lOU1RSVUNUSU9OU19NQVhd
OwogfTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jIGIvdGFy
Z2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMKaW5kZXggYWMwODZjYjA5OWIuLjY1ZmJkZjU4
ODVlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYworKysgYi90
YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYwpAQCAtNjksNiArNjksMjQgQEAgREVGX0FU
VFJJQihSTFNfU0FNRV9USFJFQUQsICJTdG9yZSByZWxlYXNlIHdpdGggdGhlIHNhbWUgdGhyZWFk
IiwgIiIsICIiKQogLyogVjYgVmVjdG9yIGF0dHJpYnV0ZXMgKi8KIERFRl9BVFRSSUIoQ1ZJLCAi
RXhlY3V0ZXMgb24gdGhlIEhWWCBleHRlbnNpb24iLCAiIiwgIiIpCiAKKy8qIEhMWCBhdHRyaWJ1
dGVzICovCitERUZfQVRUUklCKEhMWCwgIkV4ZWN1dGVzIG9uIHRoZSBITFggZXh0ZW5zaW9uIiwg
IiIsICIiKQorREVGX0FUVFJJQihITFhfTUVNLCAiSExYIG1lbW9yeSBpbnN0cnVjdGlvbiIsICIi
LCAiIikKK0RFRl9BVFRSSUIoSExYX01QWSwgIkhMWCBtdWx0aXBseSBpbnN0cnVjdGlvbiIsICIi
LCAiIikKK0RFRl9BVFRSSUIoSExYX1NISUZULCAiSExYIHNoaWZ0IGluc3RydWN0aW9uIiwgIiIs
ICIiKQorREVGX0FUVFJJQihITFhfQ09NTU9OX0FMVSwgIkhMWCBjb21tb24gQUxVIGluc3RydWN0
aW9uIiwgIiIsICIiKQorREVGX0FUVFJJQihITFhfUEFJUkVEX0FMVSwgIkhMWCBwYWlyZWQgQUxV
IGluc3RydWN0aW9uIiwgIiIsICIiKQorREVGX0FUVFJJQihITFhfQU5ZX1JFU09VUkNFLCAiSExY
IGNhbiB1c2UgYW55IHJlc291cmNlIiwgIiIsICIiKQorREVGX0FUVFJJQihITFhfU0xPVDIzLCAi
SExYIGNhbiBleGVjdXRlIGluIHNsb3QgMiBvciAzIiwgIiIsICIiKQorREVGX0FUVFJJQihITFhf
TkVXLCAiSExYIG5ldy12YWx1ZSBpbnN0cnVjdGlvbiIsICIiLCAiIikKK0RFRl9BVFRSSUIoSExY
X1RNUCwgIkhMWCB0ZW1wb3JhcnkgcmVnaXN0ZXIgaW5zdHJ1Y3Rpb24iLCAiIiwgIiIpCitERUZf
QVRUUklCKEhMWF9DVV9TQ0FMQVIsICJITFggc2NhbGFyIENVIGluc3RydWN0aW9uIiwgIiIsICIi
KQorREVGX0FUVFJJQihITFhfU0NBTEFSMzIsICJITFggMzItYml0IHNjYWxhciBvcGVyYW5kIiwg
IiIsICIiKQorREVGX0FUVFJJQihITFhfU0NBTEFSNjQsICJITFggNjQtYml0IHNjYWxhciBvcGVy
YW5kIiwgIiIsICIiKQorREVGX0FUVFJJQihITFhfTFhYX01QWSwgIkhMWCBMeHggbXVsdGlwbHkg
b3BlcmF0aW9uIiwgIiIsICIiKQorREVGX0FUVFJJQihITFhfTFhYX0FERCwgIkhMWCBMeHggYWRk
IG9wZXJhdGlvbiIsICIiLCAiIikKK0RFRl9BVFRSSUIoTk9URV9ITFhfTUVNLCAiSExYIG1lbW9y
eSBhY2Nlc3Mgbm90ZXMiLCAiIiwgIiIpCisKIERFRl9BVFRSSUIoQ1ZJX05FVywgIk5ldyB2YWx1
ZSBtZW1vcnkgaW5zdHJ1Y3Rpb24gZXhlY3V0ZXMgb24gSFZYIiwgIiIsICIiKQogREVGX0FUVFJJ
QihDVklfVk0sICJNZW1vcnkgaW5zdHJ1Y3Rpb24gZXhlY3V0ZXMgb24gSFZYIiwgIiIsICIiKQog
REVGX0FUVFJJQihDVklfVlAsICJQZXJtdXRlIGluc3RydWN0aW9uIGV4ZWN1dGVzIG9uIEhWWCIs
ICIiLCAiIikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jIGIvdGFyZ2V0L2hl
eGFnb24vaGV4c3dpLmMKaW5kZXggZTJkODIzMzcwMWQuLjY2M2Q5ZmU0OWVhIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwpA
QCAtMTAzNCw2ICsxMDM0LDcgQEAgdm9pZCBoZXhhZ29uX2NwdV9kb19pbnRlcnJ1cHQoQ1BVU3Rh
dGUgKmNzKQogICAgICAgICBjYXNlIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERToKICAgICAgICAg
Y2FzZSBIRVhfQ0FVU0VfTk9fQ09QUk9DX0VOQUJMRToKICAgICAgICAgY2FzZSBIRVhfQ0FVU0Vf
Tk9fQ09QUk9DMl9FTkFCTEU6CisgICAgICAgIGNhc2UgSEVYX0NBVVNFX05PX0NPUFJPQzNfRU5B
QkxFOgogICAgICAgICBjYXNlIEhFWF9DQVVTRV9VTlNVUFBPUlRFRF9IVlhfNjRCOgogICAgICAg
ICBjYXNlIEhFWF9DQVVTRV9WRUNUT1JfU1RBQ0tfT1ZFUkZMT1c6CiAgICAgICAgIGNhc2UgSEVY
X0NBVVNFX1JFR19XUklURV9DT05GTElDVDoKLS0gCjIuMzQuMQoK

