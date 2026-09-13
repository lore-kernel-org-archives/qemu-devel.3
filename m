Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1C4C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 16:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5mcD-0003SG-Gx; Sun, 13 Sep 2026 11:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5mcB-0003Rn-JE
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 11:59:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5mc9-0002cn-Jf
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 11:59:35 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DE06XS1251595
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 15:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=TngR7WK0lAlrBLP/uHFNhk
 s2nN7HD3JbjXMjZwp/cH0=; b=cOANrQGgihiIPmu7x9jOStB7La3/lRpsHclvW6
 vidDTQLHU+LLP0QwquCuMw9iBu7vb05G+1aTo2HOI6sJ7tT4a/qqC5PCJ+Wc+hM8
 YGpA6h7YkhdTx0oblBUwDJo567jnsy/Csb5MnHeHgk1DY8e6Y9XRyRTFErCjRIBe
 l/oiZa/PSO4XpHEjHbEmDCH/BoFAdSvblu6IBv3BKiWp4+YbZzjS7ddEufaPR58t
 Knjgq4dcOSuWUmuBMp/f5/sezB90ZxOHt2WltLhJ9fpZikFQfw0ZhOCZeFsbqwNo
 fuq8UzREafwPzU5xHOBiDjLjpiGPylfeh8hN762dqhyWiZbQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cbjn5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 15:59:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so4375930a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789315170; x=1789919970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TngR7WK0lAlrBLP/uHFNhks2nN7HD3JbjXMjZwp/cH0=;
 b=i8m++2VFJSQKI9JOjle5vCQoze3WrgLx/Fxnge49CEYA1P3YynMppOj4fE7JqBTYlo
 rtCAKPVG84ZrsxZJ/GnD5UweyUAl/CHXvXXr67PbhvgpXSepDZiSE26YUv5epTe5c5Mn
 oHFCf956nRYVS6ENrM5ePEeh23xU0GVrDo8R3nJrN/L+rtlpw7Or/Xi4GHZ9X3vPrZEH
 P6VCeWiq8Ah8u21ljzwBO7tSNqWpf5Ee8bLcQC496rpJviqnHkaSg25V7k7CMDdYDAlD
 a6wPgB3F5nDYMsJf7tuKQpZGBSGxx7xyX0/QJ5DEFoJ3tQ23Xeq2Me0lIdgufPW696jF
 Vjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789315170; x=1789919970;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TngR7WK0lAlrBLP/uHFNhks2nN7HD3JbjXMjZwp/cH0=;
 b=e8tOpC6Lq21G7h4kfSzZcJ2RYf49Qf4w8VQxWw+p81xIPbefobgvvS1Rw2nXY1FNmb
 HlkUdFngQXw5OiS+80vH/6prDPtXmDVnRsjY3fuFSGuJTFoufNwD725GPioUbaIZ9gIl
 LB8DeJZsYymHdH6+6Vov9vaTa80KMtSNso1TEEJrsdqw/OVn2L/vj/BvXXQNd3B7t34I
 q+VdZHBNnauE/T5XLTNin/rWfjoqeCnXesNFJwpGK+aXkHJ6tiN70wBHcAHN+g2lKt2C
 3YJaNYgs+lnUji7QdNZyYC7oPMM/3BYkpLTTJ0odrDPDGyrwJj/TVpqdK9IoGd0Mpr1O
 ECAg==
X-Gm-Message-State: AFuF++nRSLgwLmUoD46UdjbHI3L8gGDod7r0RW1ZMWAL/sWpn6unx4zY
 8NbPS2Pr7kfsJILTu8YcRUkiXltoFHXzWP/imXe0WpKWyabFXh9OzEGPJlNP/e/6Obazg2YfJC6
 3Liy6Qv5ozrAtEXL3fgQy+CIffjvyL8zeKu7wA/2ZJZQjI5ilOKcgUgSIEBByljG4wQ==
X-Gm-Gg: AYBFou1sNaXSFKRTZz0D1KirhrGK6+p514sOEbsz6x0KI5nSUqj30mta9bD0c0618w8
 Nc59vVq1FrstX2laiGQ0HSSlmpGAuMEvShZIuNHmdyUdHf+TyO6APs36DuopSLGvrN4tSFXFIQR
 AheJ/YaIIm3qSFmO5+5dc0jnZcWDvzBtU2YMHCFqtXm5NEZVP81L4gL94Sq7sE3pr0fKCgh8ffA
 x1VxguaYaDygyj6F6Y+hIPqZimqGc/Vd0d3JAJPipoWz5u1s1p87PKcuWqBubiJprYg2b0SajMf
 heRME6Zpvkf8zHODbAQ46a6izvAiAbBOl5fw3nLn/yn3bdXQ95MjPKIG04/YMsmi4FsFjTXN+Mz
 b7zf6X5/vWxfR3sjWC/tink9RPRuJNBSIv3UEyAbebN9z8axZ
X-Received: by 2002:a17:90b:3810:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-39d9c35dddemr24520130a91.21.1789315170558; 
 Sun, 13 Sep 2026 08:59:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3810:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-39d9c35dddemr24520070a91.21.1789315170024; 
 Sun, 13 Sep 2026 08:59:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bbeb053a5sm8076380eec.27.2026.09.13.08.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:59:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 0/6] hexagon: Add HVX context
Date: Sun, 13 Sep 2026 08:59:22 -0700
Message-Id: <20260913155928.365928-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: GBoqrpnFfBpJjzOwf8KMjRSfGl-bvDDU
X-Authority-Analysis: v=2.4 cv=Pv4G/AM3 c=1 sm=1 tr=0 ts=6aa6c863 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0WyL-R9DJl2wsrhYlPIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIyNyBTYWx0ZWRfX4pNEDori0GQ3
 tCaQUk002DEBafMXn8sgLKc6S5Xu3AfcOljH57QSjDn3ASPaFvPh2xlMKxo0JVHm5mkkXCWVR1P
 2L0+zxY/e9H000iKlsoHackbzMIEB6c=
X-Proofpoint-ORIG-GUID: GBoqrpnFfBpJjzOwf8KMjRSfGl-bvDDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIyNyBTYWx0ZWRfX95kNT1HTTF+K
 LnKPSGat3UOrP1rhGIItGCKLo+nePzYR93L76Fh0GDfl3ifzvL1/MhVOzOyAgFE090/rNDS1tfu
 /z+pKmEMDkLZsz02OMgGZckULkVMCywV9qkAGx1v+xC7jaJTaOvQ2I9amUNwSoJoS2KBztpbyaK
 equsXcpLT2bOPsh8CEoKnfctSgz4uUoKDPglt9l8QJ2g/NhPfcF+utKaJVLF3lEgxhnXiW+1otk
 90/tjySL04z+PU1FsNMHn3/lwUbbU9j/7wzdIPkZlUKoGSK+B6J4SebwB/yHTNh1ontowlMDSfo
 jPh42PE6EZevRcd1dEb3E+oi8i1VeXOvLCbMq2eSaa0g6626Hj1hEKwcrg3FA8s03K/+At5mk+X
 ht7uxj/ETp74sXyNjdo6Rcz9Q0K6Tj3+DIP4etL9QQCWLv7eJvrdrWLXS9g+BSV18HwcAwPs50W
 Vh/Ac0E9f25XDFPhYjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130227
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

QWRkIEhWWCBjb250ZXh0cyB0byBIZXhhZ29uIHRyYW5zbGF0aW9uLCBuZWNlc3NhcnkgZm9yIHN5
c3RlbSBlbXVsYXRpb24uCkNoYW5nZSB0aGUgSFZYIGluc3RydWN0aW9uIHRyYW5zbGF0aW9uIHRv
IGFjY2VzcyB0aGUgY29udGV4dCB2aWEgYSBiYXNlCnBvaW50ZXIuCgpNb2RlbGluZyB0aGUgSFZY
IGNvbnRleHQgbWFwcGluZyB3aGlsZSBhdm9pZGluZyB0aGUgbmVlZCB0byBjb3B5IHRoZQpjb250
ZXh0IHdoZW4gdGhlIE9TIHNjaGVkdWxlciBkZWNpZGVzIHRvIHJlbWFwIHRoZW0gcmVxdWlyZWQg
c29tZSBnZW5lcmFsClRDRyBndmVjIGNoYW5nZXMgdG8gZW5hYmxlIHNvbWUgbW9yZSBfdmFyIGZv
cm1zLgoKSW4gdjM6Ci0gZml4ZWQgSFZYIGNvbnRleHQgYWxpZ25tZW50IGRlY2xhcmF0aW9ucwot
IGNyZWF0ZWQgaGV4X2h2eF9wdHIgZ2xvYmFsIGZvciBzeXNlbXUsIGFic3RyYWN0aW9uIGhleF9o
dngoKSB0byByZWZlcgogIHRvIHRoZSBjb250ZXh0LgotIGFkZGVkIHNvbWUgdGVzdCBjYXNlcyAo
cmVzZXQgTWFyY28ncyBSLWIpCgpJbiB2MjoKLSBSZW1vdmVkIHVudXNlZCBkZWZhdWx0IGh2eCBj
b250ZXh0IGZyb20gdGFyZ2V0L2hleGFnb24vY3B1LltjaF0sIGFkZCBhCmhleGFnb25faHZ4X3Nl
bGVjdF9jb250ZXh0KCkgdG8gdGhlIHJlc2V0IGluc3RlYWQuCi0gY29tYmluZWQgdGhlIEhWWCBw
b2ludGVyLCBRT00gY29udGV4dCwgYW5kIFNTUjpYQSBzZWxlY3Rpb24gd29yayBjb21taXRzCmlu
dG8gYHNoYXJlIEhWWCBjb250ZXh0cyBhbW9uZyBDUFVzYC4KCnYyOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9xZW11LWRldmVsLzIwMjYwOTExMjA0MzM0LjEyNjQ5MjItMS1icmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20vCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIw
MjYwOTEwMTUzMjIxLjE2NzQyODUtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlh
biBDYWluICg2KToKICB0Y2c6IHNwbGl0IG91dCBfdmFyIGZvcm1zIG9mIGd2ZWMgbG9naWNhbCwg
YWJzIGFuZCBtaW4vbWF4IG9wcwogIHRjZzogYWRkIGJhc2UgYXJndW1lbnRzIHRvIHRoZSBndmVj
IDJzLCBkdXBfaTMyIGFuZCBjbXAgZXhwYW5kZXJzCiAgdGNnOiBzcGxpdCBvdXQgX3ZhciBmb3Jt
cyBvZiBndmVjIHNhdHVyYXRpbmcvbXVsL3NoaWZ0LWltbWVkaWF0ZSBvcHMKICB0YXJnZXQvaGV4
YWdvbjogcmFpc2UgYW4gZXhjZXB0aW9uIGZvciBIVlggd2l0aCBTU1I6WEUgY2xlYXIKICB0YXJn
ZXQvaGV4YWdvbjogc2hhcmUgSFZYIGNvbnRleHRzIGFtb25nIENQVXMKICB0ZXN0cy9mdW5jdGlv
bmFsL2hleGFnb246IGFkZCBIVlggdGVzdHMKCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5o
ICAgICAgICAgICAgICAgIHwgICAxICsKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9j
b250ZXh0LmggICAgfCAgMjcgKwogaW5jbHVkZS90Y2cvdGNnLW9wLWd2ZWMtY29tbW9uLmggICAg
ICAgICAgICB8ICA5NyArKysKIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMjggKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCAgICAgICAgICAgICAg
ICAgfCAgIDEgKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaCAgICAgICAgICAgICAgICB8
IDYwOCArKysrKysrKysrLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuaCAgICAgICAg
ICAgICAgICAgICAgIHwgICA4ICsKIHRhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oICAgICAg
ICAgICAgICAgfCAgMTQgKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgICAgICAg
ICAgICAgfCAgMTQgKy0KIGh3L2hleGFnb24vaGV4LXN1YnN5cy5jICAgICAgICAgICAgICAgICAg
ICAgfCAgMzYgKysKIGh3L2hleGFnb24vaGV4YWdvbl9odnhfY29udGV4dC5jICAgICAgICAgICAg
fCAgODQgKysrCiBsaW51eC11c2VyL21haW4uYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAzICsKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzIg
Ky0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgICAgICAgICAgICAgfCAgNzIgKysr
CiB0YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgICAgICAgICAgICAgICAgICAgIHwgIDE2ICstCiB0
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgICAgIHwgMTAyICsrLS0KIHRh
cmdldC9oZXhhZ29uL21hY2hpbmUuYyAgICAgICAgICAgICAgICAgICAgfCAgMTIgKwogdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAgICB8ICAzNyArLQogdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgICB8ICA3MSArKy0KIHRjZy90Y2ctb3At
Z3ZlYy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA2MTcgKysrKysrKysrKysrKystLS0t
LS0KIGh3L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwog
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgICB8IDE3OSArKystLS0K
IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAgIDcgKwogdGVz
dHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgICB8ICAgNiArCiAyNCBmaWxl
cyBjaGFuZ2VkLCAxNDUxIGluc2VydGlvbnMoKyksIDYyMiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl9odnhfY29udGV4dC5oCiBjcmVh
dGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9jb250ZXh0LmMKCi0tIAoyLjM0
LjEKCg==

