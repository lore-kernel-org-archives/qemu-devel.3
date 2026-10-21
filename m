Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D7606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mtERfJBV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XRGYbCSd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJKP0-0002B9-6i; Tue, 20 Oct 2026 20:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKOw-0002AY-Cl
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:41:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKOt-0006yl-LP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:41:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtk4Y2584176
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Urk/z169uglJNuybHBm0Zk
 OREXlR9D9UMvh6xXA3/xU=; b=mtERfJBVo6q6r8WJgyScNqpXD7u/sJSpeb7TlY
 A5Z5lON2OkxPu1epV4fEycOJ99Ewpw/DWaWMxYK1uC5CIim5YcyThnGyGxydCoBO
 uJbCJ1b/aQliM/Q2okyPT3oBWa0xnPLAKzkyNo1QvSS9MPLkwqzYmdQpQDcp6VJ2
 PEb7SWDS8OUfnmYKKFf+UyDp3+x+ameIR8zWjkn9ze56Y1lVgut0Rbce97TVwntA
 +mlaLAY+vTR81LaXwPFPNbro8kJo6VsC4I8na+9K5wel0Ppn4gJFL6o6FjE8/SNx
 wrpdWbFk30KeGv9DYW9iRbrD70WWPUl2zsR0HKdemWhWBmRA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v1823-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:41:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso272822eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792543309; x=1793148109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Urk/z169uglJNuybHBm0ZkOREXlR9D9UMvh6xXA3/xU=;
 b=XRGYbCSdBxBJcYpd5rDMABOXL/mHUajHtg1xOLL1brq0jgjct5O+OCXqiYnR9s7640
 bn+mY5OUlAPjJfBrSnWdFCqFjH9TecXILk224Y+e1gXEhLB7EOTe/CNX4CxAgtACDTT/
 24vWGTK8kLTCU1dX0WFdMNblhQnl5DlXE795XfC6GDah8YlxAAQ+iaLDU9iJ3CPXzWiU
 19Qfqmn98/u88IDOeNr5j7m112LdsmgdWwbGkUxvan2RBE9mX8H5hdZay9s2MGcP6etm
 w1LvB+kShLDsm7K9NYVAMjHOBaH3jqltYK8f6BIdXvQO2RhnILfi1To3P3rcEvyr4uh3
 z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792543309; x=1793148109;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Urk/z169uglJNuybHBm0ZkOREXlR9D9UMvh6xXA3/xU=;
 b=hR43bs3UP7VUV7pPdwuKZyzeF4CfFohZLwSMxZO0ng0K+mGu/UOvL/MXECinTgrTtI
 G/uSVHCmPnHVCCg43oc9JDYtpMo3wZFSg0KY4rSeF+zkx2CNvbk2Y5N6WUd62Lhgiz2C
 oO+j6krN+WKIStxpTiUaUkznRNWq74Ogr0mGOxwXVroCxT9I3GHzjaPnjksAxNL4wJ56
 Zqgze4Br6+h3T1C6rMO8BxiwVScBm+A5H4SfcAXC18mq6aAOCNEP8YLImAldPSEyODXR
 2/HYRMzECn5ZcThQR6lluaFPzdU0nAqihYURGXyX+yoxWnphJRbtIvMTXohoVDVMKDv+
 L9Hw==
X-Gm-Message-State: AFq9FYKoKMWuhGNMyxR8YHs2TYkb/TBR1fNffISKuPG4AI4WGt+3D2hL
 aGNhZe+QONu7AxW8Dq7Tn9yLj2+gCZlT+t+EbvyF4uFF6tHmm3hYy0Hwis0njcHY6fHMY3n3uYM
 +Z42og3ZhdnAgQn6yrTCnoJ1Sh4W85woqCZaoR8tIK9NXp++98CEU8n8r+IVR6iibbQ==
X-Gm-Gg: AYBFou0sOkQiPlRZ5lmNKpat695IdIXHam+PSgiQ2lL1aEBoawVxQQPp6nMk0jElIwh
 tNADYncKkHurUStyfHvdwc+q84mp9OlyZYIzM9WAgdgYse/bkqEjla22TD1jKbwPgezx9SDGMUx
 TjHBBONXEKnNGjRbHY0cnhMhNCiBvLRwXOuC4RF/yUeaac01a3g3JS78YYbpWgkDb6grsdmTIrV
 GcBKKV8YeHg9VOHQruyfl/82Aza07ZDLE4rKmsLv0hncLshcEmssiBv9XJMt739OYGnQlkoBUBy
 diBtI6WwpCnjgjZS4t8Hbh9LUn0lxoQCXg+VmNrKRS6a6WsBQauiBw34RWJ37u9CWr4+aY1xHg2
 meLhBEjclvxnqp7heO4ULYf216oEfQUvc+IrgjnMSzvc7CZE=
X-Received: by 2002:a05:701b:2601:b0:15c:20b8:796e with SMTP id
 a92af1059eb24-190a57ac4a4mr578177c88.22.1792543308359; 
 Tue, 20 Oct 2026 17:41:48 -0700 (PDT)
X-Received: by 2002:a05:701b:2601:b0:15c:20b8:796e with SMTP id
 a92af1059eb24-190a57ac4a4mr578131c88.22.1792543307593; 
 Tue, 20 Oct 2026 17:41:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d87ab1bsm2005788c88.21.2026.10.20.17.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 17:41:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Alessandro Di Federico <ale@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 00/15] Hexagon: Add real SoC-style machines
Date: Tue, 20 Oct 2026 17:41:30 -0700
Message-Id: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX23TTp9ircvgj
 GeRy26v4GQZnvL0XxsYXmPfLttN+6mwndLGX/623ZtIhaB1siRd1vidbK0jDRFtqPiygV6hvvcf
 8F0FrFDZKXMtCOJKNGUZDEPDp4W9WAI=
X-Proofpoint-ORIG-GUID: 4EparlSbprp-J0AWQAziqfV2hJGN8A9g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX/DX7RWV1fLe3
 Efvvsh3mNb+G0VeeuFXGJ7ynK3xcjfQvDi+FsTbCZn3xAwUs1fr4MfMkKB+x7z4C/i8a2VYSCvN
 WAGfzypg+rM+Dth/JTbLJzxAzsQp/mNOvbxMdlxP5gF/uas1+1inouImKzbOa1VadknOypAQzz0
 O9TBtW+XFjY+1pGyHulsyLPQlzZKRNAwPvO51vWu13m+ZhmVvRKvBBtAuemBrDKHcz2YwyH6wwZ
 iQESO23ED14cl9a60PmgewOc38YTM2BBAhR6f6bKa/IgID14wovnoskktkunTuHOClbv5OfIqD6
 B/V4PfRRvh5de1O6GgaIC1pGlvtrRJTOBAK2D0EqL1MxCtVHu8YzLmcy/iiSxhv/qJH1Nj2ecaX
 CMyJTxEP5V2IyG/73ZpWDzlzuZGYZeMN3CObRY9x/IbC8wEamdsppQfGnGYVth+hpZVYheguWp/
 cVTIDGQFPdvUacDdY8g==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad80a4d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ucr7pvldDQy_sbWZzr4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 4EparlSbprp-J0AWQAziqfV2hJGN8A9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210001
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UHJldmlvdXNseSB3ZSBhZGRlZCBzeW50aGV0aWMgbWFjaGluZXMgaW50ZW5kZWQgZm9yIGNvbXBh
dGliaWxpdHkgd2l0aApwcm9ncmFtcyBjcmVhdGVkIGJ5IHRoZSBIZXhhZ29uIFNESy4gIFRoZXNl
IHNpbXBsZSBjb25maWd1cmF0aW9ucyBoYXZlIGEKbWVtb3J5L2lycSBtYXAgdGhhdCBkb2Vzbid0
IG1hdGNoIGFueSByZWFsIGNoaXBzLCBhbmQgdGhleSBhcmUgbGltaXRlZAp0byBhbiBpbnRlcnJ1
cHQgY29udHJvbGxlciBhbmQgYSB0aW1lciBkZXZpY2UuCgpIZXJlIHdlIGFkZCBEU1AgbWFjaGlu
ZXMgdGhhdCByZWZsZWN0IHJlYWwtd29ybGQgZGV2aWNlcyBhbmQgcnVuIHNvbWUgb2YKdGhlIGNv
bW1lcmNpYWwgZmlybXdhcmUgdG8gdGVzdCBpdC4gIE5vdGUgdGhhdCBmb3Igbm93IHRoZSBib290
IHdpbGwgbm90CnByb2dyZXNzIG11Y2ggYmV5b25kIHRoZSBpbml0aWFsIGtlcm5lbCBib290LiAg
RGVwZW5kZW5jaWVzIG9uIG90aGVyCnlldC10by1iZS1tb2RlbGVkIGRldmljZXMgYXJlIHByZXZl
bnRpbmcgdGhlIGZpcm13YXJlIGZyb20gY29taW5nIHVwIGZ1bGx5CnRvIGEgc3RlYWR5L2lkbGUg
c3RhdGUuCgpJbiB2MjoKLSBhZGRlZCByYW5nZSBjaGVja3MgZm9yIFJBTS9GRFQvaW5pdHJkIGJv
dW5kcywgc3Vic3lzdGVtX2Jhc2UgYWRkci4KLSBmaXhlZCBlbmRpYW5uZXNzIGJ1ZyBpbiBib290
bG9hZGVyIGNyZWF0aW9uLgotIFVzZWQgZnVsbCBVUkxzIGZvciBBc3NldCgpcyBpbiB0ZXN0X3Fj
b21fZHNwX2Zpcm13YXJlLnB5LCBzd2l0Y2hlZCBmcm9tCmEgc2hhIHRvIGEgdGFnLgotIEluY2x1
ZGVkIHRoZSAicmVwb3J0IElTQSBIV0NBUCB0aHJvdWdoIHY4NSIgcGF0Y2ggZnJvbSBhbm90aGVy
IHNlcmllcwpmb3IgYmV0dGVyIGNvbnRleHQuCgp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8yMDI2MTAxOTA1NTI0NS4xNDU3Nzk1LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tLwoKQnJpYW4gQ2FpbiAoMTUpOgogIEhleGFnb246IGFkZCB2ODUgQ1BVIG1vZGVsCiAg
bGludXgtdXNlci9oZXhhZ29uOiByZXBvcnQgSVNBIEhXQ0FQIHRocm91Z2ggdjg1CiAgaHcvaGV4
YWdvbjogbGV0IGEgbWFjaGluZSBwbGFjZSBpdHMgRERSCiAgaHcvaGV4YWdvbjogaW50cm9kdWNl
IGhleC1ib2FyZCBhYnN0cmFjdGlvbgogIGh3L2hleGFnb246IGNvbnZlcnQgdmlydCBib2FyZCB0
byBoZXgtYm9hcmQKICBody9taXNjOiBhZGQgdGhlIFFEU1A2U1MgUExMLCBSQ0cKICBody9oZXhh
Z29uOiBhZGQgdGhlIFFDUzY0OTAgQ0RTUCBtYWNoaW5lCiAgaHcvaGV4YWdvbjogYWRkIHRoZSBT
QTg3NzVQIENEU1AgbWFjaGluZQogIGh3L2hleGFnb246IGFkZCB0aGUgU0M4NDgwWFAgTlNQMCBt
YWNoaW5lCiAgaHcvaGV4YWdvbjogYWRkIHRoZSBTQTg3OTdQIE5TUDAgbWFjaGluZQogIGh3L2hl
eGFnb246IGFkZCB0aGUgU004OTc1IE5TUCBtYWNoaW5lCiAgaHcvaGV4YWdvbjogYWRkIHY3OU5B
MSBtYWNoaW5lCiAgaHcvaGV4YWdvbjogYWRkIHN1YnN5c3RlbS1iYXNlIHByb3BlcnR5CiAgdGFy
Z2V0L2hleGFnb246IGZpeCB0aGUgYWxsb2NmcmFtZSBmcmFtZWtleQogIHRlc3RzL2Z1bmN0aW9u
YWwvaGV4YWdvbjogYm9vdCBEU1AgZmlybXdhcmUKCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKwogZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRp
b24ucnN0ICAgICAgICAgICAgIHwgICAyICstCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4LWJvYXJk
LmggICAgICAgICAgICAgICAgfCAgNjUgKysrCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5o
ICAgICAgICAgICAgICAgICAgfCAgMTAgKwogaW5jbHVkZS9ody9oZXhhZ29uL3Fjb21fZHNwLmgg
ICAgICAgICAgICAgICAgIHwgIDgxICsrKysKIGluY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmggICAg
ICAgICAgICAgICAgICAgICB8ICAgNiAtCiBpbmNsdWRlL2h3L21pc2MvcWNvbS1xZHNwNnNzLWNs
ay5oICAgICAgICAgICAgfCAgMTUgKwogbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYuaCAg
ICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2NwdS1xb20uaCAgICAgICAgICAg
ICAgICAgICAgICB8ICAgNCArCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3FjczY0OTBfY2RzcC5o
LmluYyAgICAgfCAgNjUgKysrCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5o
LmluYyAgICAgfCAgIDYgKy0KIGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzk3cF9uc3AwLmgu
aW5jICAgICB8ICA1NiArKysKIGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2M4NDgweHBfbnNwMC5o
LmluYyAgICB8ICA1MiArKysKIGh3L2hleGFnb24vbWFjaGluZV9jZmdfc204OTc1X25zcC5oLmlu
YyAgICAgICB8ICA1NSArKysKIGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYyAg
ICAgICAgICB8ICAzNCArKwogaHcvaGV4YWdvbi9oZXgtYm9hcmQuYyAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMjY1ICsrKysrKysrKysrCiBody9oZXhhZ29uL2hleC1zdWJzeXMuYyAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDQgKy0KIGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYyAgICAgICAg
ICAgICAgICAgICAgICB8ICA5MyArKystCiBody9oZXhhZ29uL3Fjb21fZHNwLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgfCA0MTAgKysrKysrKysrKysrKysrKysrCiBody9oZXhhZ29uL3FjczY0
OTBfY2RzcC5jICAgICAgICAgICAgICAgICAgICAgfCAgNjQgKysrCiBody9oZXhhZ29uL3NhODc3
NXBfY2RzcC5jICAgICAgICAgICAgICAgICAgICAgfCAgNTkgKysrCiBody9oZXhhZ29uL3NhODc5
N3BfbnNwMC5jICAgICAgICAgICAgICAgICAgICAgfCAgNjggKysrCiBody9oZXhhZ29uL3NjODQ4
MHhwX25zcDAuYyAgICAgICAgICAgICAgICAgICAgfCAgOTAgKysrKwogaHcvaGV4YWdvbi9zbTg5
NzVfbnNwLmMgICAgICAgICAgICAgICAgICAgICAgIHwgMTAyICsrKysrCiBody9oZXhhZ29uL3Zp
cnQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzMDkgKystLS0tLS0tLS0tLQogaHcv
bWlzYy9xY29tLXFkc3A2c3MtY2xrLmMgICAgICAgICAgICAgICAgICAgIHwgMjA4ICsrKysrKysr
KwogbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICAgICAgICAgICAgICAgIHwgIDEwICsK
IHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiB0
YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jICAgfCAgIDIgKy0KIHRl
c3RzL3F0ZXN0L2hleGFnb24tY29uZmlnLXRlc3QuYyAgICAgICAgICAgICB8ICA3OCArKysrCiB0
ZXN0cy9xdGVzdC9sMnZpYy10ZXN0LmMgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKwogdGVz
dHMvcXRlc3QvcWNvbS1kc3AtdGVzdC5jICAgICAgICAgICAgICAgICAgIHwgMTEzICsrKysrCiB0
ZXN0cy9xdGVzdC9xY3QtcXRpbWVyLXRlc3QuYyAgICAgICAgICAgICAgICAgfCAgMTAgKwogdGVz
dHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYyAgICAgICAgICAgICAgICAgIHwgIDY3ICsrKwogaHcv
aGV4YWdvbi9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQ4ICstCiBody9o
ZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKwogaHcvbWlz
Yy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsKIGh3L21pc2Mv
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiB0ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgfCAgIDIgKwogLi4uL2hleGFnb24v
dGVzdF9xY29tX2RzcF9maXJtd2FyZS5weSAgICAgICAgIHwgIDkyICsrKysKIHRlc3RzL3F0ZXN0
L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQogdGVzdHMvdGNnL2hl
eGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgIHwgICAxICsKIDQyIGZpbGVzIGNoYW5n
ZWQsIDIyODUgaW5zZXJ0aW9ucygrKSwgMjk4IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXgtYm9hcmQuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGlu
Y2x1ZGUvaHcvaGV4YWdvbi9xY29tX2RzcC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9o
dy9taXNjL3Fjb20tcWRzcDZzcy1jbGsuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24v
bWFjaGluZV9jZmdfcWNzNjQ5MF9jZHNwLmguaW5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4
YWdvbi9tYWNoaW5lX2NmZ19zYTg3OTdwX25zcDAuaC5pbmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBo
dy9oZXhhZ29uL21hY2hpbmVfY2ZnX3NjODQ4MHhwX25zcDAuaC5pbmMKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NtODk3NV9uc3AuaC5pbmMKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBody9oZXhhZ29uL2hleC1ib2FyZC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4
YWdvbi9xY29tX2RzcC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9xY3M2NDkwX2Nk
c3AuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vc2E4Nzc1cF9jZHNwLmMKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL3NhODc5N3BfbnNwMC5jCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaHcvaGV4YWdvbi9zYzg0ODB4cF9uc3AwLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhh
Z29uL3NtODk3NV9uc3AuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvcWNvbS1xZHNwNnNz
LWNsay5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvaGV4YWdvbi1jb25maWctdGVz
dC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvcWNvbS1kc3AtdGVzdC5jCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYwogY3JlYXRlIG1vZGUg
MTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5
CgotLSAKMi4zNC4xCgo=

