Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAC1CA6009
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEc8V-0004dq-4S; Wed, 07 Oct 2026 20:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8T-0004dH-Ok
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8S-000814-Am
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtWFX625632
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 00:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mx/s3RlzAz7+uVrqyVMPIAXgyVHf9NRvKzpley8JlZk=; b=pwMbLVFfRcxAHFCu
 3radytD0Vzy8Q8C3exucvbV44jRAmOpeTSpeR6+Piv0Qf+n/VbsXQum6Gz8w7sxf
 VeJWR4mGEavi7akkRYfPSF/jGQW1X7zxxDoIg+Qq4piLRk7P8jbNXuILRuJW3zM5
 1eCZNPv44xtLcGzlO0XP/DGrG/P5cCa0RduFOwkCxyo82uBTl61GK6WeEaw24lZT
 iOFqgwfHVIPSp4HxTvF26JS/d+Wk3WO0n0vyaHvwpCjY4uRuooAlmNqyW1eRFXfp
 pM2Ij7UQUfxW3y7f//nFcLojhSWnrG25KjyPlT41I9Ipqum0qRH2zVjn+0gk8+a4
 xLAjyA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3gj2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:37:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510a481ae9so8977998eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791419842; x=1792024642; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mx/s3RlzAz7+uVrqyVMPIAXgyVHf9NRvKzpley8JlZk=;
 b=kZj3Krjbe+7r0IO9n9voesybTFe2QQN2xy2P+nwWRnUYVh/K/GqLGmqWrVFD1o4OSv
 GmQTEhQ3opKhYafdcsxDOSDNE7NXOTfFDp2L9QWXntCRj+qGU06hrbBqSiDnFlp97oO8
 BcsJHRzd4n+4i+fqS0JxVNrl2Wls5jNPZm6ggmGdAU0znvrriOWHhWj7jL9fYmbIA11P
 9oBEMRS6MP5LCYAvcPg0Z06IEIxXOd1cjfCBqhKPpvcKZA65VM0OwzOfyeGluShRIlTc
 DnlE1IhoduSCOWwnOEJ8uk60lYpbD07MfrnIaIUdJZxcyxnjxppK/Ol132G0ra073bxV
 1LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791419842; x=1792024642;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mx/s3RlzAz7+uVrqyVMPIAXgyVHf9NRvKzpley8JlZk=;
 b=EU6slTfECwVoAcf+66dWQKUrHNM02RiTaJ+eCwjtmfY9CwK8U+rjCxeV0JL6A5EjU9
 9eTpU7sgNHNDGhWDtTBPUCZRGw+I0u4obsVU53+CK94ACiwzkzaC5qe3kvsWXA+z0KRH
 BZtKueWAfW/LjOvV4Tz3VTh1Gdpbmdp39/ZxXeIQ3U375t8dkybNFZPXdcQzV3IxfKKy
 bdaM68nocTt2Dz8qnPAwcx9S0EhZb8NLJHuTVLMamBPCFRADLQUjztSJyk9fKYFTDkHQ
 BYcJzsdsFpHsC1bg/bq4J94kNU6iBj8ASAKTdEhLPy94sYH/P4WaTcy0Dqa9F+ATwtDy
 440g==
X-Gm-Message-State: AFuF++mcasRsYeTOXZb43sGcgkxE5wZih4E1reHGmuP4KrDomVtcOY6g
 6nh/hfWaq1Eb5WCFE6jB8vDfYJldzrWFgYK4pDLuyIJBqHgk21mRvxZcBAehYVkoXwjA3v2KFVW
 sH12n9J7vdF5olH3J56WQbPWUQgvU5l/oRmloHxPEoWdqOHUbOqaS6co018fdz8pzPg==
X-Gm-Gg: AYBFou0Pn6vEMBCFUAcLJx2bCH3tVfTF0b//DjBpE3oV1WY8hYzgS9oj5aJKvTy29lp
 1fk6J8EC0euRZTdy9jpXwz/IDmoHx5r8A0M3bhAsc1a7lfHZ5CKdsYQn3xtqzyFNzBys7CX2lYf
 PA/U1EltoFf4EarnADtf+4QSPels/rgQErNnelsKcARhuD4MwRJWKYIjuJ2ROKjD1ypIoOr0FfM
 k0Z3fhWUswow+fzez2vtVJOGJix0GRkry0UsiYwRkk5vFKnT32oQ+IR2QjNQoHpSKsrObcn3dU0
 pH5vIqJsW/K2tSyxZ1epwwiSl1MbYp5bdL7IDIW3wDelGxDXcK8nh4V0Yj3/yAJEWTleepMLLh4
 ck4DUtZX5Wd3AALHCMzFunG8zDYXl7HuAaahQ5CwGuYhxwJs=
X-Received: by 2002:a05:7022:288:b0:148:80d4:84ac with SMTP id
 a92af1059eb24-16206e0f37bmr4226842c88.29.1791419842134; 
 Wed, 07 Oct 2026 17:37:22 -0700 (PDT)
X-Received: by 2002:a05:7022:288:b0:148:80d4:84ac with SMTP id
 a92af1059eb24-16206e0f37bmr4226804c88.29.1791419841490; 
 Wed, 07 Oct 2026 17:37:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-163e3c5bed6sm4380048c88.7.2026.10.07.17.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 17:37:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>
Subject: [PATCH v3 05/12] target/hexagon: fix V6_vcmov reserved-bit encoding
Date: Wed,  7 Oct 2026 17:37:04 -0700
Message-Id: <20261008003711.3984454-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfX1UyLZtCgq9mE
 ke2ZAhmj3vDUZ94wdJQlzlOaiSg86mrjZ1HZg5oQ+EdEIY1xAvSbuKRGcKXdrmrerw0Tq/fL+fd
 i1yhKeyq7Pt4T0vfc323xFFYlgRq3bI=
X-Proofpoint-ORIG-GUID: cVQwO-izMCsx5WHE7e5OuqRYQH51qKXD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfXzJ9Ohc0Dgs9l
 s1YHU7tWzQkKDKEfhSyWx+QszF25Gg/L1yGWR+6GH+DZLzYW/1nCyn7Xu1j/WMs+f0vX0j+OBx8
 K7rvBx9va2E64GyQxuFkpNyltXcKKkj9vgcYKTxQWb9Gi6PEcVi2TuMHXICTGeNddWrxs/4GdYl
 w5rDgvZXoppMtTi0IIqjWL43RZfqaJxnAIR2nztDcQxlMGBeg6WqbVGxFGX3sMyBHxdAWuWIl9v
 gZLDZnVf4KrwwBC7ISgnxwPxDPLHY90NyCCdbAZWyaiPh6MczQy08fgcB8dWYIjl7ytl+2eRqzV
 bKxybFo2irt5TZeLQnltO/oixlROyzNy7xAhXLPle1aWQd9+AbTSAMK8P/t0fadeVM/IOJj1Hdx
 9sTg1cZKVy63ivckLk3PLxuYUYR2Mqy70EON546Yv4MdsGgHd1xiTm8jK76WyZE9I6CaRGPgV79
 OdTnf/2vjTDolKKKGtg==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac6e5c3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ptefoZwEObSeWYFtGJoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: cVQwO-izMCsx5WHE7e5OuqRYQH51qKXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080001
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

VGhlIGFyY2hpdGVjdHVyZSBkZWZpbmVzIHRoaXMgZW5jb2RpbmcgYml0IGFzIHplcm8uICBMZWF2
aW5nIGl0CnVuY29uc3RyYWluZWQgYWNjZXB0cyByZXNlcnZlZCBlbmNvZGluZ3MgYXMgVjZfdmNt
b3YuCgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21t
LmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2VuY29kZV9leHQuZGVmIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZW5jb2RlX2V4dC5kZWYgYi90
YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZgppbmRleCAwODRhZTNk
ODU0Mi4uYjQ2ZjUxNDkyZDkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21t
dmVjL2VuY29kZV9leHQuZGVmCisrKyBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2Vu
Y29kZV9leHQuZGVmCkBAIC0zOTQsNyArMzk0LDcgQEAgREVGX0VOQyhWNl92c2h1ZmYsICAgICAg
ICAgICAgIElDTEFTU19DSiIgMSAwMDEgMTExIHR0dHR0IFBQIDEgeXl5eXkgMDAxIHh4eHh4IikK
IERFRl9FTkMoVjZfdmRlYWwsICAgICAgICAgICAgIElDTEFTU19DSiIgMSAwMDEgMTExIHR0dHR0
IFBQIDEgeXl5eXkgMDEwIHh4eHh4IikgLy8KIAogREVGX0ZJRUxEUk9XX0RFU0MzMiggICAgSUNM
QVNTX0NKIiAxIDAxMCAtLS0gLS0tLS0gUFAgLSAtLS0tLSAtLS0tLSAtLS0iLCJbIzJdIGlmIChQ
cykgVmQ9VnUiKQotREVGX0VOQyhWNl92Y21vdiwgICAgICAgICBJQ0xBU1NfQ0oiIDEgMDEwIDAw
MCAtLS0tLSBQUCAtIHV1dXV1IC1zcyBkZGRkZCIpCitERUZfRU5DKFY2X3ZjbW92LCAgICAgICAg
IElDTEFTU19DSiIgMSAwMTAgMDAwIC0tLS0tIFBQIDAgdXV1dXUgLXNzIGRkZGRkIikKIERFRl9F
TkMoVjZfdm5jbW92LCAgICAgICAgIElDTEFTU19DSiIgMSAwMTAgMDAxIC0tLS0tIFBQIC0gdXV1
dXUgLXNzIGRkZGRkIikKIERFRl9FTkMoVjZfdm5jY29tYmluZSwgICAgIElDTEFTU19DSiIgMSAw
MTAgMDEwIHZ2dnZ2IFBQIC0gdXV1dXUgLXNzIGRkZGRkIikKIERFRl9FTkMoVjZfdmNjb21iaW5l
LCAgICAgSUNMQVNTX0NKIiAxIDAxMCAwMTEgdnZ2dnYgUFAgLSB1dXV1dSAtc3MgZGRkZGQiKQot
LSAKMi4zNC4xCgo=

