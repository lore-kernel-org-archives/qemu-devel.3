Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126560A260B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UKWlMYBh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dRNzJHxm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTi2l-0000uu-Jj; Wed, 18 Nov 2026 10:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTi2j-0000uM-Jn
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:57:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTi2h-0002nG-7y
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:57:53 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIDQ9nq3912225
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 15:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=fm1Emc93Tly5Ezzp25qPpc
 zczVTBoK80wc5AW/oEa9M=; b=UKWlMYBhsx9OFhAeRlkH7MNweHD0LauVjl8+0C
 zcsZU75N+AeRDfcgrxfSWWazJVA0b9OD8+RTFFxvfqG8BzI2qTemxs2coyCwudJB
 ms2IQXggZg+Lw1vrK5bwlBKknnWSnM3bbdPFKhnHcPy8nMcuRq7DkJQUO957o2u3
 /gOAYnLgC+LtsQfv6vvxa8/9Ihe2xQy5JrT40Q47awfbEH9Y1T2tBkJCZb08I/Bd
 KJAnNZA3eHWTcp8WXO3RPiY7eTEvuwWRkURMc3dLueBVm6B94DcAZH/eyEaLxz6L
 m0/Teswab5iHvgO6XKX//Ramzrw2NQhCH9t7paETqnZQdbKg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9bw4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 15:57:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so199495685a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795017468; x=1795622268; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fm1Emc93Tly5Ezzp25qPpczczVTBoK80wc5AW/oEa9M=;
 b=dRNzJHxmVboKWLdUTrCpWog8VYs+aEzXmYwjhZTgQc2q19YCN/3Dj7PC4k49NfKLQ0
 7pQ0JlCMTA05fqHcdDg8xbIq0FQTMnXpSsuVyqm44AVAE+v+FN8sbkDviyix/eAxz5f+
 PSzRnSr/GkimSuW8N3emdFgbvRr12Jb47rDcAK8tMtjia8o1vC45KEeohfF+55yEQSOV
 YX8glPiRcjhmguAgYUNEoPp7f18VzL/sqwhUiSPceuxQU2ASIFzusoyhy4Dk0LZdeIox
 NJWAYqy+5v9gYP2/wgetPFdAamH+SanLyY6zJAvjHJJQGDWX0YDzfxm2hUZfJ+qQQbbE
 EtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795017468; x=1795622268;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fm1Emc93Tly5Ezzp25qPpczczVTBoK80wc5AW/oEa9M=;
 b=2p3KYs5crh8uHpStkJ1CNvLCDbA9QDXQNWRQ42d15PUvVi8/pdsi5q9VbOa3qQ0IRA
 Zxcj11A8mKIiKWKeb4vUfEWSrv3roUpYKJN+O3EFAvb/LkWixxvl29gN3PUq8GxE6xec
 ZrSFwTy0TXqGItwk4uHE84GGUjzbVINCJpelDtAzHL/+gPsjAosYdrKRkL052mKGGQo4
 A+GzrwmBlIyAOTVSZTgg6Hf64WSBS4QFxZuBt15tyj6Pbtm7KGtDRQBUkN/AlZa1f1uy
 Bz5CR4g9AECPrEGW84TVcpJRkLlZTwbEVWKBTlMa5CwM2SqIcx97Nl993rI1Hs7fkKL0
 OgIw==
X-Gm-Message-State: APuU4Z+IkQURVi+aqbTTMQN5thgvXIfiNociU4NlFwZibIoKsUNOnIkO
 1z7TwLSwWfqH9FUYnWz0aF6nIlyWBZVZKCKpndbT+IvzK9NnII8qsmGq9nZFhRfotQ3GrwE3RGq
 4dIOpwzwXPXtCq8ijoVJ+cvejIn4MFPqjYgY9GvRvkqTyrGF8VBer6N8m8/8DlBgo/g==
X-Gm-Gg: AYBFou3msRji151+OVBzBkQsAixoV0VLjgmhGSn6B7QA+K7FpJbSO7sO/wivOevxZkf
 6BqQzmNoUGBoB+MYg4S6nqyp1fhNRSdv+wXvYwfifQchiM1oYxGmxZKUe1uxOG4ZN0AYb7ZbpCL
 qc5e1OWucq/CU59fF1y9M4miqRQhFTd3WCoPKXBzq11oRyYObqlNuEQfgGXNNQXRwyE46KEmxee
 mY0sZsoJjmNjHRFNp+xKbmHHe7PICW8ATSjmgmsH8Inc3K648BgeHzTr1bJc/mI/8qKLPK4Vesc
 GW5mwKdAyCcA0tHB4NDWpEcKgSIjmJLB1PtLCkpeOEjc/HfIwFeqAIiVhoHWF665OOHkz5RFjTy
 wqPeUEehdHgqs/QPFg0/qND7Hx9CNGLNEmMBBqGRlZ6iM9yO04MIiPUVi5LxSTGawMhMeXjTbJd
 4HJyjXVJcsR1onRkqKzrns
X-Received: by 2002:a05:620a:4003:b0:93e:95ce:5394 with SMTP id
 af79cd13be357-94999499b39mr562714285a.2.1795017467861; 
 Wed, 18 Nov 2026 07:57:47 -0800 (PST)
X-Received: by 2002:a05:620a:4003:b0:93e:95ce:5394 with SMTP id
 af79cd13be357-94999499b39mr562709685a.2.1795017467372; 
 Wed, 18 Nov 2026 07:57:47 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b75aa1csm211710085a.20.2026.11.18.07.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:57:46 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] target/hexagon: Fix disassembly of extended GP-relative
 accesses
Date: Wed, 18 Nov 2026 07:57:45 -0800
Message-Id: <20261118155745.3620910-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX9HzNgeQoXP8n
 WmljGzauiCLn3z3DeHp+V+34sJlBww9z/qPoPQjGvwlUCemXpnrKOoAKMeX/ZRj9gZg/lRL8qSj
 OFyMed004wz4bgRFdi6tSU7jBkEgHqc=
X-Authority-Analysis: v=2.4 cv=acT0Dhot c=1 sm=1 tr=0 ts=6afdcafc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KjefK8gMg-PaKceYsj8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX9QRPK6+rM+u0
 wZKgQRJ7BSHr8LEXKvPTPJsJ483nj7SZ3EEbbPknmmAfxGwMcVEQlaiMRIWemK0UTFvqTCRWkV2
 fXv8K75SvJaYY+vIcoVlfmkFAYGJuyt7SLRfjnqc1ECtkU2Rj8+TKCHqPWhett1nr8BRFtAl/ZO
 2VSQ/yAeS+Up9J2rAj6uLGStGPVFrclckcvOMpKB806Ql1twyIWmMYD7HeBPSA788BT/Fyl1RvR
 pJVQt21c9M8n4qKVCNkIuR5Bmw/SwX/PLJl7552lDuZBiW2X4RuBIrcMir5ijWVwrW3gEGafLoW
 fNPW0A118IIbff/KX0Vh2U+nSfrWZkGOP/pxtvYjVEggru87BBVuyFTJmuvmDvfwW7Y4vDtQe2x
 EsTfddGDqaxXsIA7QGCYO+ynl0p6pYR0gzXcFnrDioJMQs99UAZl48BEf6D7BM0uNUhj4Ee2QDL
 5RrLT+qzYZ3qlT6zqiw==
X-Proofpoint-ORIG-GUID: -2K8Q4Losp-1IjG7qcESc8PfpZ1yiL3R
X-Proofpoint-GUID: -2K8Q4Losp-1IjG7qcESc8PfpZ1yiL3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180063
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

QSBHUC1yZWxhdGl2ZSBsb2FkIG9yIHN0b3JlIHdpdGggYSBjb25zdGFudCBleHRlbmRlciBpcyBh
biBhYnNvbHV0ZQphY2Nlc3M6IHRoZSBzZW1hbnRpY3MgcmVhZCBHUCBhcyAwIHdoZW4gaW5zbi0+
ZXh0ZW5zaW9uX3ZhbGlkIGlzIHNldCwKYW5kIHRoZSBleHRlbmRlZCBpbW1lZGlhdGUgaXMgdGhl
IGZ1bGwgYWRkcmVzcy4gIFRoZSBwcmludGVkIGZvcm0ga2VwdAp0aGUgImdwKyIgYmFzZSwgc28g
Zm9yIGV4YW1wbGUKCiAgICBSMCA9IG1lbXcoZ3ArIyMweDQ4YzMwKQoKd2FzIHNob3duIGZvciBh
biBpbnN0cnVjdGlvbiB0aGF0IGFjY2Vzc2VzIDB4NDhjMzAgYW5kIGRvZXMgbm90IHVzZSBHUC4K
Ck9ubHkgcHJpbnQgdGhlICJncCsiIGJhc2Ugd2hlbiB0aGVyZSBpcyBubyBleHRlbmRlci4KCkxp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjExMTgxNDQ0NDEuMjc2
ODAtMS1hbmpvQHJldi5uZy8KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBv
c3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dlbl9wcmludGluc24ucHkgfCA3
ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9nZW5fcHJpbnRpbnNuLnB5IGIvdGFyZ2V0L2hleGFnb24vZ2VuX3ByaW50
aW5zbi5weQppbmRleCBjZjFhMTJhZGJjMS4uMWViOThhMWE0MzIgMTAwNzU1Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2dlbl9wcmludGluc24ucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3ByaW50
aW5zbi5weQpAQCAtMTI1LDYgKzEyNSwxMCBAQCBkZWYgbWFpbigpOgogICAgICAgICAgICAgYmVo
ID0gaGV4X2NvbW1vbi5hYnNpbW1yZS5zdWIociIjJXMweCV4IiwgYmVoKQogICAgICAgICAgICAg
YmVoID0gaGV4X2NvbW1vbi5yZWxpbW1yZS5zdWIociJQQyslcyVkIiwgYmVoKQogICAgICAgICAg
ICAgYmVoID0gc3BhY2lmeShiZWgpCisKKyAgICAgICAgICAgIGdwX3JlbGF0aXZlID0gIihncCsi
IGluIGJlaAorICAgICAgICAgICAgaWYgZ3BfcmVsYXRpdmU6CisgICAgICAgICAgICAgICAgYmVo
ID0gYmVoLnJlcGxhY2UoIihncCsiLCAiKCVzIikKICAgICAgICAgICAgICMgUHJpbnQgb3V0IGEg
bGl0ZXJhbCAiJXMiIGF0IHRoZSBlbmQsIHVzZWQgdG8gbWF0Y2ggZW1wdHkgc3RyaW5nCiAgICAg
ICAgICAgICAjIHNvIEMgd29uJ3QgY29tcGxhaW4gYXQgdXMKICAgICAgICAgICAgIGlmICJBX1ZF
Q1giIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgpAQCAtMTU4LDYgKzE2Miw5IEBAIGRl
ZiBtYWluKCk6CiAgICAgICAgICAgICAgICAgICAgICAgICByaSArPSAxCiAgICAgICAgICAgICAg
ICAgZWxzZToKICAgICAgICAgICAgICAgICAgICAgIyBpbW1lZGlhdGUKKyAgICAgICAgICAgICAg
ICAgICAgaWYgZ3BfcmVsYXRpdmU6CisgICAgICAgICAgICAgICAgICAgICAgICBmLndyaXRlKCcs
IGluc24tPmV4dGVuc2lvbl92YWxpZCA/ICIiIDogImdwKyInKQorICAgICAgICAgICAgICAgICAg
ICAgICAgZ3BfcmVsYXRpdmUgPSBGYWxzZQogICAgICAgICAgICAgICAgICAgICBpZiBpbW1sZXR0
LmlzdXBwZXIoKToKICAgICAgICAgICAgICAgICAgICAgICAgIGlmIGV4dGVuZGFibGVfdXBwZXJf
aW1tOgogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIGltbWxldHQgaW4gInJSIjoKLS0g
CjIuMzQuMQoK

