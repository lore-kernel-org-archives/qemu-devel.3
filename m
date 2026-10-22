Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637A606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RbO+UgyG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BZCSkWXq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1mh-00051T-Uj; Thu, 22 Oct 2026 19:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1me-00050L-Ju
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mb-00022Q-5N
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:16 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMF6242012800
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d9daeYoDIG69nrtq7fY9PbUJ/CPct4wvk9mqnxfr2RU=; b=RbO+UgyGON7m7aJ9
 8gpgjTtYjpvzaSYcF+jX1OUOdi7BiJzm7aBPL9DjnK3NZJjpPAmKgnYS6o8SFhJD
 Ui7T90kcg0ZN52EdORTC3c6AtzhmuW0Sx+tkU28VZQyQ9TSDMtLUtynnnYEAP4Bg
 tpQTRA8IrTqcyc9Fj4IVWUb8GT3dFmdgTn1mpKNx94Vx5qVeL4Kcg8UYaC1Hsrav
 q9w7o49v+oOjJV9Y7mW7me4iCDo6LB8sWQoB9aUXTA2LXVJph+KwZe2oOS5H4KMw
 m5wqRPzY7slH8pcvGeAQxZWxwUk/Xkfzx6q71l8R/Hx4ZjR6VCxHrwLbTpahITWp
 AUbVFg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp8x1k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so774907eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792710071; x=1793314871; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d9daeYoDIG69nrtq7fY9PbUJ/CPct4wvk9mqnxfr2RU=;
 b=BZCSkWXqL1N2QpvgVMgCDu4uQH7yOYL2QFhjKD5pb1O+TAicDCgnkc3k82Fk1Xn7p/
 8BQ0TefI/oUUxNZB2rH3e36iTD3OIcOsA4YoJtQRtXMEM8iV7JkLocuz7BIl+sGbXHGp
 s0o6ssjgXDSuz22zh0C0YmtJ8bUlQENkZ0/2MvaCkmtqxp/W3ak7QBlFtQLiwhg1B+iQ
 Jym28WcswchzGHZIEV/rOH2qvi4dxvnpn8E861KxG5RJGcAoC9rIZhm2GtlQmTZ5q5qJ
 Fb/J8+UThncrLOCjH6fWLS6jwD6nR/PXa9qdTzhqNS+E1qWnDu7c5w7PFETZIHnZNFqg
 fZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710071; x=1793314871;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d9daeYoDIG69nrtq7fY9PbUJ/CPct4wvk9mqnxfr2RU=;
 b=eFACflUBAmO6e9VIrFeYu345dbcNmLbnMvQOC7FYDu8rx0i5NAjgZoCLKNFxINJwaZ
 D93BMhtmS+oVGUrDE7stmqabNuO/bE9rZpk+dkU1Hi24oVNJdtPYdRZ0oPX3TudKQVeE
 lp6euCyU9qnyVMBwoeeXU8UGNAGklMoo1KBVK0DkYPVBp/kjcXXVC3V2lXmDwaj8oC0e
 CPGOc/3Af3ZL230HmzHeDSWeaA3mSErmtHOEi2CR1Wfp3CQpGczvhnzq/NMI+RLYIuwa
 eKP/dyXUyaJN35x9V3AwFsP9kvt6wfcXuxb95MjDbwGFkXfyfSZcEFOwncjm420ckdmY
 GoLQ==
X-Gm-Message-State: AFq9FYIDF0t5IXvptmxXpiQaYgiUTD6eFgV5q47ANDsn2rvWo3e4+LWI
 do/kqE2lNM+KkAJ/GtTTX3wP3+XGtrLriwbdMJVE9Hfg9LvQBEW6Yn/VJlFX3kUhJZeV4HrMM+N
 xby2ExfedCWxg1/7u++nNf9g9fVfQWO6MZOV3IaLQF6Y6/rh9pM98gatwOawrjIFRVw==
X-Gm-Gg: AYBFou3iYmjwo/lItgx/PCnYruvqR4uwfv/n4143kfgMbiY3oMbB+Kg6wLFRB7xSZnC
 CC+9PfAqcY31THA8dRgI/MbEQ3VQpzIgz+cEp1bTn5CQJmC1kkIlw4AkPREoGDPMjrZCUv7gSSv
 pklGuU/aZZplY9O9aBC33xE9JH5EmJORiw08tDnI7jGVklpmlH8O3h47iCUAOP2MvsXkjl5bKWj
 9d9CgQJ+pXxVyLYpkkk9eBLLZRMAx3WedIrjK6dg0Z4e7ZdFdGJlv6/Rx6sZraJRCFfck+4vubT
 O6k249nOxOMjZL0Ks/N6CQco7MWOVUZsiseFHdlVeveE9Tcc9gjZwq2Y5leJE3fc3nx66hdB5kI
 i1kj1sC7nOng3J7aXP4i9u4vmKPAfeYZhcv3RQ+mZjid7eyF8
X-Received: by 2002:a05:693c:639c:20b0:35e:a225:3ba6 with SMTP id
 5a478bee46e88-369d97a98a9mr610484eec.13.1792710070857; 
 Thu, 22 Oct 2026 16:01:10 -0700 (PDT)
X-Received: by 2002:a05:693c:639c:20b0:35e:a225:3ba6 with SMTP id
 5a478bee46e88-369d97a98a9mr610450eec.13.1792710070266; 
 Thu, 22 Oct 2026 16:01:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c0e60dsm1088138eec.2.2026.10.22.16.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:01:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 08/16] hw/hexagon: add the SA8775P CDSP machine
Date: Thu, 22 Oct 2026 16:00:40 -0700
Message-Id: <20261022230048.2160400-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfXwv7X6CWhyF+d
 V27+D7sbaMSLukqax8uYc+KWX9ClGK5v9HMS/vGhx7yvyViS2jxTiCxJQ/TD5Lh9rbVBPKlEors
 O2Qo5To/cjEcZC7+Rfhw0uDiP6xvLdU=
X-Proofpoint-GUID: vy6chnJHMv8OpQGrcEFBsFuIsIZfxoHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX9oiBIPpYYYcm
 ldnxV1K2ET48MyfkMM9VJULEvRLAATPW97eIbFJ/oEqSaPcbQacr7N4LMExJKNInzdSEgrcf/ZY
 ChxrNm/vcBRETBTMiSC1M3mnvTPv3gef8iiVFcEtjbrbh3OW8IgddYQhuypuEiHrfW6hHMJu0lW
 XVNRr6rDJC43Lkbo7BCV1Blaalbzcjf6GcQBsjCvwcbzEopzpqvgUm1iZiFNWPLAEx2eEtZi+v9
 QNDgdC2g0169+tAssxKdtr2mOAwrCh3I70der3mnFW2GFwOtZ59L5NMYwOIPK3GXaLX8Hblxz0y
 kTtus6Jr672b2giT/tXQfKKDQ15D9359hYl39s9K0px+lhddpxs/o+IjlCMVBRJrmq/fr3SwdyP
 vo6ftzgdkTc2mJKjepl65ARHST3/Akn1aDLCWyphwNjKqDqResaO+I7LZvdVIaW3PDdlHt1ZCyJ
 vEoB8+E4aZBApKKhfbQ==
X-Proofpoint-ORIG-GUID: vy6chnJHMv8OpQGrcEFBsFuIsIZfxoHP
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6ada95b7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=NpvsaE68gZiddUfqzw8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220091
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jIHwgIDYgKystCiBo
dy9oZXhhZ29uL3NhODc3NXBfY2RzcC5jICAgICAgICAgICAgICAgICB8IDU5ICsrKysrKysrKysr
KysrKysrKysrKysrCiB0ZXN0cy9xdGVzdC9sMnZpYy10ZXN0LmMgICAgICAgICAgICAgICAgICB8
ICAyICsKIHRlc3RzL3F0ZXN0L3Fjb20tZHNwLXRlc3QuYyAgICAgICAgICAgICAgIHwgIDEgKwog
dGVzdHMvcXRlc3QvcWN0LXF0aW1lci10ZXN0LmMgICAgICAgICAgICAgfCAgMiArCiBody9oZXhh
Z29uL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrKwogaHcvaGV4YWdvbi9t
ZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgfCAgMSArCiA3IGZpbGVzIGNoYW5nZWQsIDc2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhh
Z29uL3NhODc3NXBfY2RzcC5jCgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19z
YTg3NzVfY2RzcDAuaC5pbmMgYi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5o
LmluYwppbmRleCA0NDJjYmUzYmUzMS4uN2UyZWY0MmI5ZTIgMTAwNjQ0Ci0tLSBhL2h3L2hleGFn
b24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCisrKyBiL2h3L2hleGFnb24vbWFjaGlu
ZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCkBAIC0xLDYgKzEsNyBAQAogLyogU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgKi8KIAogc3RhdGljIGNvbnN0IHN0cnVjdCBo
ZXhhZ29uX21hY2hpbmVfY29uZmlnIFNBODc3NVBfY2RzcDAgPSB7CisgICAgLmRkcl9iYXNlID0g
ICAgICAgIDB4ODAwMDAwMDAsCiAgICAgLmNmZ2Jhc2UgPSAgICAgICAgIDB4MjQwMDAwMDAgKyAw
eDE4MDAwMCwKICAgICAubDJ0Y21fc2l6ZSA9ICAgICAgMHgwMDAwMDAwMCwKICAgICAubDJ2aWNf
YmFzZSA9ICAgICAgMHgyNjMwMDAwMCArIDB4OTAwMDAsCkBAIC0yNSw3ICsyNiw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyBTQTg3NzVQX2Nkc3AwID0gewog
ICAgICAgICAudnRjbV9iYXNlID0gMHgwMDAwMjUwMCwKICAgICAgICAgLnZ0Y21fc2l6ZV9rYiA9
IDB4MDAwMDIwMDAsCiAgICAgICAgIC5sMnRhZ19zaXplID0gMHgwMDAwMDQwMCwKLSAgICAgICAg
LmwyZWNvbWVtX3NpemUgPSAweDAwMDAwMDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4
MDAwMDA0MDAsCiAgICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAogICAg
ICAgICAuZWNjcmVnX2Jhc2UgPSAweDAwMDAyNDFmLAogICAgICAgICAubDJsaW5lX3NpemUgPSAw
eDAwMDAwMDgwLApAQCAtNjAsNSArNjEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhleGFnb25f
bWFjaGluZV9jb25maWcgU0E4Nzc1UF9jZHNwMCA9IHsKICAgICAgICAgLmNvbnNpc3RlbmN5X2Rv
bWFpbiA9IDB4MDAwMDAwZTAsCiAgICAgICAgIC5jYXBhY2l0eV9kb21haW4gPSAweDAwMDAwMDgw
LAogICAgICAgICAuYXhpM19sb3dhZGRyID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJf
aW50OF9zdWJjb2x1bW5zID0gMHgwMDAwMDAwMiwKKyAgICAgICAgLmNvcmVjZmdfcHJlc2VudCA9
IDB4MDAwMDAwMDUsCisgICAgICAgIC5jb3Byb2MyX2ZwMTZfYWNjX2V4cCA9IDB4MDAwMDAwMDcs
CiAgICAgfSwKIH07CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL3NhODc3NXBfY2RzcC5jIGIvaHcv
aGV4YWdvbi9zYTg3NzVwX2Nkc3AuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
MDAwMC4uZGU0NGY4ZjY1Y2MKLS0tIC9kZXYvbnVsbAorKysgYi9ody9oZXhhZ29uL3NhODc3NXBf
Y2RzcC5jCkBAIC0wLDAgKzEsNTkgQEAKKy8qCisgKiBNb2RlbHMgdGhlIHY3MyBDRFNQMCBvZiB0
aGUgU0E4Nzc1UC4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywg
SW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNs
dWRlICJody9jb3JlL2JvYXJkcy5oIgorI2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbi5oIgor
I2luY2x1ZGUgImh3L2hleGFnb24vcWNvbV9kc3AuaCIKKyNpbmNsdWRlICJ0YXJnZXQvaGV4YWdv
bi9jcHUuaCIKKworI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYyIKKwor
I2RlZmluZSBUWVBFX1NBODc3NVBfQ0RTUF9NQUNISU5FIE1BQ0hJTkVfVFlQRV9OQU1FKCJzYTg3
NzVwLWNkc3AiKQorCitzdGF0aWMgY29uc3QgUWNvbURzcFJlZ2lvbiBzYTg3NzVwX2Nkc3BfcmVn
aW9uc1tdID0geworICAgIHsgInRjc3IiLCAweDAxZmMwMDAwIH0sCisgICAgeyAiaHdrbS1wcm5n
IiwgMHgwMTBkYTAwMCB9LAorICAgIHsgImdkc2NyIiwgMHgwMDE1MTAwMCB9LAorICAgIHsgInBs
bDAiLCAweDI2MzQwMDAwIH0sCisgICAgeyAicGxsMSIsIDB4MjYwMDAwMDAgfSwKKyAgICB7ICJj
bGtjdGwiLCAweDI2MzQ4MDAwIH0sCisgICAgeyAiY2Nzd2kiLCAweDI2MDA4MDAwIH0sCisgICAg
eyAicnNjIiwgMHgyNjBhNDAwMCB9LAorfTsKKworc3RhdGljIHZvaWQgc2E4Nzc1cF9jZHNwX2lu
aXRfZGV2aWNlcyhNYWNoaW5lU3RhdGUgKm1zKQoreworICAgIHFjb21fZHNwX2FkZF9yZWdpb25z
KG1zLCBzYTg3NzVwX2Nkc3BfcmVnaW9ucywKKyAgICAgICAgICAgICAgICAgICAgICAgICBBUlJB
WV9TSVpFKHNhODc3NXBfY2RzcF9yZWdpb25zKSk7CisKKyAgICBxY29tX3NvY19hZGRfcXVwX2dl
bmlfcG9ydHMoInNhODc3NXAiLCAweDAwYjgwMDAwLCAxLCAweDQwMDApOworICAgIHFjb21fc29j
X2FkZF9xdXBfZ2VuaV9wb3J0cygic2E4Nzc1cCIsIDB4MDA4ODAwMDAsIDcsIDB4NDAwMCk7Cisg
ICAgcWNvbV9zb2NfYWRkX3F1cF9nZW5pX3BvcnRzKCJzYTg3NzVwIiwgMHgwMDk4MDAwMCwgNywg
MHg0MDAwKTsKKyAgICBxY29tX3NvY19hZGRfcXVwX2dlbmlfcG9ydHMoInNhODc3NXAiLCAweDAw
YTgwMDAwLCA3LCAweDQwMDApOworfQorCitzdGF0aWMgY29uc3QgUWNvbURzcE1hY2hpbmVJbmZv
IHNhODc3NXBfY2RzcF9pbmZvID0geworICAgIC5kZXNjID0gIlNBODc3NVAgQ0RTUDAiLAorICAg
IC5jcHVfdHlwZSA9IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjczIiksCisgICAgLmNwdXMgPSA2
LAorICAgIC5yZXYgPSB2NzNfcmV2LAorICAgIC5jZmcgPSAmU0E4Nzc1UF9jZHNwMCwKKyAgICAu
a2VybmVsX2FkZHIgPSAweGEwMDAwMDAwLAorICAgIC5pbml0X2RldmljZXMgPSBzYTg3NzVwX2Nk
c3BfaW5pdF9kZXZpY2VzLAorfTsKKworc3RhdGljIGNvbnN0IFR5cGVJbmZvIHNhODc3NXBfY2Rz
cF90eXBlc1tdID0geworICAgIHsKKyAgICAgICAgLm5hbWUgPSBUWVBFX1NBODc3NVBfQ0RTUF9N
QUNISU5FLAorICAgICAgICAucGFyZW50ID0gVFlQRV9RQ09NX0RTUF9NQUNISU5FLAorICAgICAg
ICAuY2xhc3NfaW5pdCA9IHFjb21fZHNwX2NsYXNzX2luaXQsCisgICAgICAgIC5jbGFzc19kYXRh
ID0gJnNhODc3NXBfY2RzcF9pbmZvLAorICAgIH0sCit9OworCitERUZJTkVfVFlQRVMoc2E4Nzc1
cF9jZHNwX3R5cGVzKQpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvbDJ2aWMtdGVzdC5jIGIvdGVz
dHMvcXRlc3QvbDJ2aWMtdGVzdC5jCmluZGV4IDJlMGQ3ZGNiMGYxLi41ZDMwZDE4YTlmZCAxMDA2
NDQKLS0tIGEvdGVzdHMvcXRlc3QvbDJ2aWMtdGVzdC5jCisrKyBiL3Rlc3RzL3F0ZXN0L2wydmlj
LXRlc3QuYwpAQCAtMTIsNiArMTIsNyBAQAogI2luY2x1ZGUgImh3L2hleGFnb24vbWFjaGluZV9j
ZmdfdjY2Z18xMDI0LmguaW5jIgogI2luY2x1ZGUgImh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4
bl8xMDI0LmguaW5jIgogI2luY2x1ZGUgImh3L2hleGFnb24vbWFjaGluZV9jZmdfcWNzNjQ5MF9j
ZHNwLmguaW5jIgorI2luY2x1ZGUgImh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3Aw
LmguaW5jIgogCiAvKiBMMlZJQyByZWdpc3RlciBvZmZzZXRzIGV4ZXJjaXNlZCBieSB0aGlzIHRl
c3QgKi8KICNkZWZpbmUgTDJWSUNfSU5UX0VOQUJMRW4gMHgxMDAgLyogUmVhZC9Xcml0ZSAqLwpA
QCAtNDcsNiArNDgsNyBAQCBzdGF0aWMgY29uc3QgTDJWSUNNYWNoaW5lQ2ZnIGwydmljX21hY2hp
bmVzW10gPSB7CiAgICAgeyAidmlydCIsICAgICAgJnY2OG5fMTAyNCB9LAogICAgIHsgIlY2Nkdf
MTAyNCIsICZ2NjZnXzEwMjQgfSwKICAgICB7ICJxY3M2NDkwLWNkc3AiLCAmcWNzNjQ5MF9jZHNw
IH0sCisgICAgeyAic2E4Nzc1cC1jZHNwIiwgJlNBODc3NVBfY2RzcDAgfSwKIH07CiAKIHN0YXRp
YyB1aW50MzJfdCBsMnZpY19yZWFkMzIodWludDY0X3QgYmFzZSwgdWludDMyX3Qgb2Zmc2V0KQpk
aWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvcWNvbS1kc3AtdGVzdC5jIGIvdGVzdHMvcXRlc3QvcWNv
bS1kc3AtdGVzdC5jCmluZGV4IDM5ZDZlNTNiYzRlLi41ODZlMTEzYzE4MSAxMDA2NDQKLS0tIGEv
dGVzdHMvcXRlc3QvcWNvbS1kc3AtdGVzdC5jCisrKyBiL3Rlc3RzL3F0ZXN0L3Fjb20tZHNwLXRl
c3QuYwpAQCAtMjQsNiArMjQsNyBAQAogCiBzdGF0aWMgY29uc3QgY2hhciAqY29uc3QgcWNvbV9k
c3BfbWFjaGluZXNbXSA9IHsKICAgICAicWNzNjQ5MC1jZHNwIiwKKyAgICAic2E4Nzc1cC1jZHNw
IiwKIH07CiAKIHN0YXRpYyB2b2lkIHRlc3RfY29uc29sZShjb25zdCB2b2lkICptYWNoaW5lKQpk
aWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvcWN0LXF0aW1lci10ZXN0LmMgYi90ZXN0cy9xdGVzdC9x
Y3QtcXRpbWVyLXRlc3QuYwppbmRleCAyNjM3NTFiNTViZi4uYjIwZDRhMmJjZWQgMTAwNjQ0Ci0t
LSBhL3Rlc3RzL3F0ZXN0L3FjdC1xdGltZXItdGVzdC5jCisrKyBiL3Rlc3RzL3F0ZXN0L3FjdC1x
dGltZXItdGVzdC5jCkBAIC0xMyw2ICsxMyw3IEBACiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9tYWNo
aW5lX2NmZ192NjhuXzEwMjQuaC5pbmMiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9tYWNoaW5lX2Nm
Z192NjZnXzEwMjQuaC5pbmMiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19xY3M2
NDkwX2Nkc3AuaC5pbmMiCisjaW5jbHVkZSAiaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYTg3NzVf
Y2RzcDAuaC5pbmMiCiAKICNkZWZpbmUgUVRJTUVSX0RFRkFVTFRfRlJFUV9IWiAxOTIwMDAwMFVM
TAogCkBAIC0zNDQsNiArMzQ1LDcgQEAgc3RhdGljIGNvbnN0IFF0aW1lck1hY2hpbmVDZmcgcXRp
bWVyX21hY2hpbmVzW10gPSB7CiAgICAgeyAidmlydCIsICAgICAgJnY2OG5fMTAyNCB9LAogICAg
IHsgIlY2NkdfMTAyNCIsICZ2NjZnXzEwMjQgfSwKICAgICB7ICJxY3M2NDkwLWNkc3AiLCAmcWNz
NjQ5MF9jZHNwIH0sCisgICAgeyAic2E4Nzc1cC1jZHNwIiwgJlNBODc3NVBfY2RzcDAgfSwKIH07
CiAKIHN0YXRpYyB2b2lkIHRlc3RfcXRpbWVyX29uX21hY2hpbmUoZ2NvbnN0cG9pbnRlciBkYXRh
KQpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9LY29uZmlnIGIvaHcvaGV4YWdvbi9LY29uZmlnCmlu
ZGV4IGZmYzg2MjM2OTFjLi5iZGRhNzg3Mjg3OCAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9LY29u
ZmlnCisrKyBiL2h3L2hleGFnb24vS2NvbmZpZwpAQCAtMzYsMyArMzYsOSBAQCBjb25maWcgSEVY
X1FDUzY0OTBfQ0RTUAogICAgIGRlZmF1bHQgeQogICAgIGRlcGVuZHMgb24gSEVYX0RTUCAmJiBG
RFQKICAgICBzZWxlY3QgSEVYX1FDT01fRFNQCisKK2NvbmZpZyBIRVhfU0E4Nzc1UF9DRFNQCisg
ICAgYm9vbAorICAgIGRlZmF1bHQgeQorICAgIGRlcGVuZHMgb24gSEVYX0RTUCAmJiBGRFQKKyAg
ICBzZWxlY3QgSEVYX1FDT01fRFNQCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL21lc29uLmJ1aWxk
IGIvaHcvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCA3MTQ1ZThhNjVkZi4uYjc0OTY0MjZjOWEg
MTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIvaHcvaGV4YWdvbi9tZXNv
bi5idWlsZApAQCAtOCw1ICs4LDYgQEAgaGV4YWdvbl9zcy5hZGQod2hlbjogJ0NPTkZJR19IRVhf
Qk9BUkQnLCBpZl90cnVlOiBmaWxlcygnaGV4LWJvYXJkLmMnKSkKIGhleGFnb25fc3MuYWRkKHdo
ZW46ICdDT05GSUdfSEVYX1ZJUlQnLCBpZl90cnVlOiBmaWxlcygndmlydC5jJykpCiBoZXhhZ29u
X3NzLmFkZCh3aGVuOiAnQ09ORklHX0hFWF9RQ09NX0RTUCcsIGlmX3RydWU6IGZpbGVzKCdxY29t
X2RzcC5jJykpCiBoZXhhZ29uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0hFWF9RQ1M2NDkwX0NEU1An
LCBpZl90cnVlOiBmaWxlcygncWNzNjQ5MF9jZHNwLmMnKSkKK2hleGFnb25fc3MuYWRkKHdoZW46
ICdDT05GSUdfSEVYX1NBODc3NVBfQ0RTUCcsIGlmX3RydWU6IGZpbGVzKCdzYTg3NzVwX2Nkc3Au
YycpKQogCiBod19hcmNoICs9IHsnaGV4YWdvbic6IGhleGFnb25fc3N9Ci0tIAoyLjM0LjEKCg==

