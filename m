Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A6606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mHhIDi+f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iVz87agT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1mV-0004xY-8h; Thu, 22 Oct 2026 19:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mO-0004wW-I7
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mK-0001yp-TU
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:00:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMFfXe612503
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NrDOW2PxEa1cZ2IXzvCo/E
 ix84yDw2Q+KS6mUNaO1qA=; b=mHhIDi+fpjZwUu4AiKqr+GSA9VRq2qbvcpdz/w
 6klmSrfzxsepRAnHqvC+kuBeI6D10lo5haG1KNlODhLhkBRFmwUfQSiom1VeCRNw
 +FULIKZUPDuYYWuanUvsi6ExY8ti3eWgLtje2u0TvbEUHbMdGd92yIjNfWe3RHev
 COJVOPueuRUIfyhvSbb8ZRfz2dCVE78VibPuaBxUznjJuy33d9xFiCLa5Cjw3EoL
 oKo+tCNPtvjd3NyDR8PttFWUp5hsUgNMCer6oCo2zBG4S+tI3XoA1vbq1HVlv4EB
 t0z4plcSB7OaYqVWgtqDTyK1hSORxNBEQL8gdtCrWvn/YnqQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahsamr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:00:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso1081993eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792710052; x=1793314852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NrDOW2PxEa1cZ2IXzvCo/Eix84yDw2Q+KS6mUNaO1qA=;
 b=iVz87agTDlCDoXQFdx9fiAB+zuMmHjTaAOADcuNDBoI1B5ofFLOyPIRqn1ocivVF1n
 07Q8i07RiO8ekXwvrkSH9OfSF5IOHX+Eilm4Zv+aCR5jhhxL4q43UcPrN0e2eSPXY+1+
 vquLeKkIvYUBwZnDJFNLTRhMNez/wxox3Av2h0N3PRGLsgwFIq6N0CaxqUtRMXAO9Pd/
 D9QLUlfm/UYs+35qjH5GS4Odxsu0NGqqRAvtPTCtHYzsdk4AJmtH+PZ3SNggO7qAY1Kv
 YX3KO3ak680RPq8OsIQxOcRcEQygQqpjkyC9xZqjgttBY6cpyhIbhB8nHz6YTPgLUsVk
 DeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710052; x=1793314852;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NrDOW2PxEa1cZ2IXzvCo/Eix84yDw2Q+KS6mUNaO1qA=;
 b=iEUF5gD076C6LJPxCTrjr9aIUEYC7fYsAKrJIjmeWepdiH4X1V0l1PgGZgBsNpGQQJ
 dm1Aqmujdk0Ywl8P0YWdXAjHbnmCVPpTpOBvH2KYhY2TjOanvMYfxxAHN2yzqN2eWl86
 oWYEeOBCyxL5gJUYuYKWFa/T/vu1BWWGvTm41SA1ZNvsypvOKeTv/we2T9ettmeL7Gcy
 KKHuZ419WlrVDEZVOuRgpCfGCJ4KJbCt6AZlmdewoX6GXebBzqOIgZKIu1Cmpsc0MPsx
 fMuDNikX+zVTC85x5hCzcesZVxIGNCD91JYvnKN1Flx5Lsqc0madVZ43bH+NcGF10Wt4
 vohg==
X-Gm-Message-State: AFq9FYI+XAE11F2UJV/bXSEFOmUM9WvW0EZKEYbMNrwCmdBQ4cQ894S2
 S5CUhhzE3N0qVai3enRKHIVyAk9Pa4eIjqQ/LPNoFF+OBkuIPdHeBvsCK22CXblhfiq2RifbCyc
 SlGwOrzWm/aiZeUfgCL6PRj9GRZ86A87QX2bKaRNR2/EdK4HiZniNybz8xypHFYONNA==
X-Gm-Gg: AYBFou1F2IdfRLUraXEwH3Gzfsk4xQa+A5wKJV+UuaOp3Z+9Imh7XUglxldil7JRLUn
 weoLL7yEOLX9E3UwQku0Q1eembe/I7ZPhm1Sr9Vm8aawBekeOvMkckFIhSMmBbXD3oRtJlrtcCE
 dhBJN/+kKzZuJYNstjiVftj5wTt99fOzXSgiTi0Vp7hjIVb0rxHfeYT+VvMEJi45JbpPDln09m1
 8sjLgDxI5nOEXMBmMNr/W18kZiHVETgICWiW8SWuW7auAeFf10sUiZSkTRWPUvVRs/bSzQf1MgJ
 A2bD7qHeqPgiHb+HdTR4SwNBhcndwbxBe8QRqx7EnI6tQMrXC3KumyJEGYuBIS1fa6t5bZqfePK
 tBHExkeh5FlsmBl1uSNGdmgkPqmT4FPrTEtZn0ugUaVw8+vrR
X-Received: by 2002:a05:7301:b18:b0:35f:f0:8edf with SMTP id
 5a478bee46e88-369d971f2e6mr707860eec.13.1792710051827; 
 Thu, 22 Oct 2026 16:00:51 -0700 (PDT)
X-Received: by 2002:a05:7301:b18:b0:35f:f0:8edf with SMTP id
 5a478bee46e88-369d971f2e6mr707802eec.13.1792710050937; 
 Thu, 22 Oct 2026 16:00:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c0e60dsm1088138eec.2.2026.10.22.16.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:00:50 -0700 (PDT)
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
Subject: [PATCH v3 00/16] Hexagon: Add real SoC-style machines
Date: Thu, 22 Oct 2026 16:00:32 -0700
Message-Id: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX9RtpDYVEgcl4
 IJOyRool1KLhFiuYQvezxdAPjK4htu8xxt326XhKS7zQ22fecHYKgTfN0Yfkb4NqkO5GCtYVZ6T
 mjtxhPBXQREt329WOfAO1dSNi/4x654=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX3fslYT6LmE4U
 WL1JSFMUC80ivGNccXDYidG1YyhjV262pZYK5gQyffSHBjiLFQ5KOyPtxKoEUrGTt449qJmfl77
 hTQAI1GsQ9+MYL3SfSKvpuzhVi/OV0PP+15AicG91inpgaeGWS1SwTCBUBwtgNECNZInnXicfh+
 VGl7WX7DS/Kaug5vhCUcMzBHKp1bCFnwXbhtgpyGDbZ7Wxer8h+gaoOUG0cCR2aLG8222P+LMbn
 p68rG+UT0cgf35xwwwtJzvHxjvtReBJJsmnfwbhMaVaZq047X1u8/DD9DyKEvmm0Hwt6vK+Btag
 x+MreeOp84rNKq8/kL+hKYC3/z86/NNuFdA+NUNie4Dc4GF3dvscW98rJOZUnyX6SYX/l4tlbnO
 ThHGpuGZTlPReDzL/KBdstwFevZt/V9/mkq0k0GgspdE8cTTiW3ifCW54DxWeFQovRiV7PrlWIY
 9nimVng9jMJLAUFd3vg==
X-Proofpoint-GUID: USJLuz-kcOBeJo1LTzxLZCdabJ2BR0RD
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6ada95a5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iESlTiRV2haYUAOta3EA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: USJLuz-kcOBeJo1LTzxLZCdabJ2BR0RD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220091
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
c3RhdGUuCgpJbiB2MzoKLSBzL0FTU0VUL0FTU0VUX0ZJUk1XQVJFLyBpbiBvcmRlciB0byBnZXQg
dGhlIGFzc2V0IHByZWNhY2hlIHdvcmtpbmcKYXMgaW50ZW5kZWQuCgpJbiB2MjoKLSBhZGRlZCBy
YW5nZSBjaGVja3MgZm9yIFJBTS9GRFQvaW5pdHJkIGJvdW5kcywgc3Vic3lzdGVtX2Jhc2UgYWRk
ci4KLSBmaXhlZCBlbmRpYW5uZXNzIGJ1ZyBpbiBib290bG9hZGVyIGNyZWF0aW9uLgotIFVzZWQg
ZnVsbCBVUkxzIGZvciBBc3NldCgpcyBpbiB0ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5LCBzd2l0
Y2hlZCBmcm9tCmEgc2hhIHRvIGEgdGFnLgotIEluY2x1ZGVkIHRoZSAicmVwb3J0IElTQSBIV0NB
UCB0aHJvdWdoIHY4NSIgcGF0Y2ggZnJvbSBhbm90aGVyIHNlcmllcwpmb3IgYmV0dGVyIGNvbnRl
eHQuCgp2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAyMTAwNDE0
NS4xNjkzMjYwLTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwp2MTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAxOTA1NTI0NS4xNDU3Nzk1LTEtYnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoMTYpOgogIEhleGFnb246IGFkZCB2ODUg
Q1BVIG1vZGVsCiAgbGludXgtdXNlci9oZXhhZ29uOiByZXBvcnQgSVNBIEhXQ0FQIHRocm91Z2gg
djg1CiAgaHcvaGV4YWdvbjogbGV0IGEgbWFjaGluZSBwbGFjZSBpdHMgRERSCiAgaHcvaGV4YWdv
bjogaW50cm9kdWNlIGhleC1ib2FyZCBhYnN0cmFjdGlvbgogIGh3L2hleGFnb246IGNvbnZlcnQg
dmlydCBib2FyZCB0byBoZXgtYm9hcmQKICBody9taXNjOiBhZGQgdGhlIFFEU1A2U1MgUExMLCBS
Q0cKICBody9oZXhhZ29uOiBhZGQgdGhlIFFDUzY0OTAgQ0RTUCBtYWNoaW5lCiAgaHcvaGV4YWdv
bjogYWRkIHRoZSBTQTg3NzVQIENEU1AgbWFjaGluZQogIGh3L2hleGFnb246IGFkZCB0aGUgU0M4
NDgwWFAgTlNQMCBtYWNoaW5lCiAgaHcvaGV4YWdvbjogYWRkIHRoZSBTQTg3OTdQIE5TUDAgbWFj
aGluZQogIGh3L2hleGFnb246IGFkZCB0aGUgU004OTc1IE5TUCBtYWNoaW5lCiAgaHcvaGV4YWdv
bjogYWRkIHY3OU5BMSBtYWNoaW5lCiAgaHcvaGV4YWdvbjogYWRkIHN1YnN5c3RlbS1iYXNlIHBy
b3BlcnR5CiAgdGFyZ2V0L2hleGFnb246IGZpeCB0aGUgYWxsb2NmcmFtZSBmcmFtZWtleQogIHRl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbjogYm9vdCBEU1AgZmlybXdhcmUKICBCQ0FJTiBkbyBub3Qg
bWVyZ2UgLSBnaXRsYWItY2k6IGVuYWJsZSBDSSBwaXBlbGluZXMgb24gZm9ya3MKCiBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKwogZG9jcy9zeXN0
ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0ICAgICAgICAgICAgIHwgICAyICstCiBpbmNsdWRlL2h3
L2hleGFnb24vaGV4LWJvYXJkLmggICAgICAgICAgICAgICAgfCAgNjUgKysrCiBpbmNsdWRlL2h3
L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgICAgICAgICAgfCAgMTAgKwogaW5jbHVkZS9ody9o
ZXhhZ29uL3Fjb21fZHNwLmggICAgICAgICAgICAgICAgIHwgIDgxICsrKysKIGluY2x1ZGUvaHcv
aGV4YWdvbi92aXJ0LmggICAgICAgICAgICAgICAgICAgICB8ICAgNiAtCiBpbmNsdWRlL2h3L21p
c2MvcWNvbS1xZHNwNnNzLWNsay5oICAgICAgICAgICAgfCAgMTUgKwogbGludXgtdXNlci9oZXhh
Z29uL3RhcmdldF9lbGYuaCAgICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2Nw
dS1xb20uaCAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArCiBody9oZXhhZ29uL21hY2hpbmVf
Y2ZnX3FjczY0OTBfY2RzcC5oLmluYyAgICAgfCAgNjUgKysrCiBody9oZXhhZ29uL21hY2hpbmVf
Y2ZnX3NhODc3NV9jZHNwMC5oLmluYyAgICAgfCAgIDYgKy0KIGh3L2hleGFnb24vbWFjaGluZV9j
Zmdfc2E4Nzk3cF9uc3AwLmguaW5jICAgICB8ICA1NiArKysKIGh3L2hleGFnb24vbWFjaGluZV9j
Zmdfc2M4NDgweHBfbnNwMC5oLmluYyAgICB8ICA1MiArKysKIGh3L2hleGFnb24vbWFjaGluZV9j
Zmdfc204OTc1X25zcC5oLmluYyAgICAgICB8ICA1NSArKysKIGh3L2hleGFnb24vbWFjaGluZV9j
Zmdfdjc5bmFfMS5oLmluYyAgICAgICAgICB8ICAzNCArKwogaHcvaGV4YWdvbi9oZXgtYm9hcmQu
YyAgICAgICAgICAgICAgICAgICAgICAgIHwgMjY1ICsrKysrKysrKysrCiBody9oZXhhZ29uL2hl
eC1zdWJzeXMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0KIGh3L2hleGFnb24vaGV4
YWdvbl9kc3AuYyAgICAgICAgICAgICAgICAgICAgICB8ICA5MyArKystCiBody9oZXhhZ29uL3Fj
b21fZHNwLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCA0MTAgKysrKysrKysrKysrKysrKysr
CiBody9oZXhhZ29uL3FjczY0OTBfY2RzcC5jICAgICAgICAgICAgICAgICAgICAgfCAgNjQgKysr
CiBody9oZXhhZ29uL3NhODc3NXBfY2RzcC5jICAgICAgICAgICAgICAgICAgICAgfCAgNTkgKysr
CiBody9oZXhhZ29uL3NhODc5N3BfbnNwMC5jICAgICAgICAgICAgICAgICAgICAgfCAgNjggKysr
CiBody9oZXhhZ29uL3NjODQ4MHhwX25zcDAuYyAgICAgICAgICAgICAgICAgICAgfCAgOTAgKysr
KwogaHcvaGV4YWdvbi9zbTg5NzVfbnNwLmMgICAgICAgICAgICAgICAgICAgICAgIHwgMTAyICsr
KysrCiBody9oZXhhZ29uL3ZpcnQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzMDkg
KystLS0tLS0tLS0tLQogaHcvbWlzYy9xY29tLXFkc3A2c3MtY2xrLmMgICAgICAgICAgICAgICAg
ICAgIHwgMjA4ICsrKysrKysrKwogbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICAgICAg
ICAgICAgICAgIHwgIDEwICsKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVy
cy5jICAgfCAgIDIgKy0KIHRlc3RzL3F0ZXN0L2hleGFnb24tY29uZmlnLXRlc3QuYyAgICAgICAg
ICAgICB8ICA3OCArKysrCiB0ZXN0cy9xdGVzdC9sMnZpYy10ZXN0LmMgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTAgKwogdGVzdHMvcXRlc3QvcWNvbS1kc3AtdGVzdC5jICAgICAgICAgICAgICAg
ICAgIHwgMTEzICsrKysrCiB0ZXN0cy9xdGVzdC9xY3QtcXRpbWVyLXRlc3QuYyAgICAgICAgICAg
ICAgICAgfCAgMTAgKwogdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYyAgICAgICAgICAgICAg
ICAgIHwgIDY3ICsrKwogLi4uL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tl
ciAgIHwgICAyICsKIC5naXRsYWItY2kuZC9idWlsZHRlc3QueW1sICAgICAgICAgICAgICAgICAg
ICB8ICA1OCArKysKIC5naXRsYWItY2kuZC9xZW11LXByb2plY3QueW1sICAgICAgICAgICAgICAg
ICB8ICAgMiArCiBody9oZXhhZ29uL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNDggKy0KIGh3L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgNyArCiBody9taXNjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDMgKwogaHcvbWlzYy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAz
ICsKIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICB8ICAgMiAr
CiAuLi4vaGV4YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5ICAgICAgICAgfCAgOTcgKysr
KysKIHRlc3RzL3F0ZXN0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCAr
LQogdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgIHwgICAxICsK
IDQ1IGZpbGVzIGNoYW5nZWQsIDIzNTIgaW5zZXJ0aW9ucygrKSwgMjk4IGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXgtYm9hcmQuaAogY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9xY29tX2RzcC5oCiBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9ody9taXNjL3Fjb20tcWRzcDZzcy1jbGsuaAogY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfcWNzNjQ5MF9jZHNwLmguaW5jCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYTg3OTdwX25zcDAuaC5pbmMKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NjODQ4MHhwX25zcDAuaC5pbmMK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NtODk3NV9uc3AuaC5p
bmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5p
bmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL2hleC1ib2FyZC5jCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaHcvaGV4YWdvbi9xY29tX2RzcC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4
YWdvbi9xY3M2NDkwX2Nkc3AuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vc2E4Nzc1
cF9jZHNwLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL3NhODc5N3BfbnNwMC5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9zYzg0ODB4cF9uc3AwLmMKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBody9oZXhhZ29uL3NtODk3NV9uc3AuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21p
c2MvcWNvbS1xZHNwNnNzLWNsay5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvaGV4
YWdvbi1jb25maWctdGVzdC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvcWNvbS1k
c3AtdGVzdC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXku
YwogY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3Fjb21f
ZHNwX2Zpcm13YXJlLnB5CgotLSAKMi4zNC4xCgo=

