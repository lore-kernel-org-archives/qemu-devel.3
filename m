Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616B2606A339
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fb3al429;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dVVwBtVy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8Yc-0002sG-4r; Thu, 19 Nov 2026 15:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YP-0002oa-Qn
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YE-0000pj-VT
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:18 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1SRu1936307
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bCnkRnm0Uc+pTP7pIvwtA+oKroPqs2WbY6Bp+x3cHoE=; b=Fb3al42958ZaJmUs
 J9h0yTztWDozAVGsOLrp1NttVg5fWvs2gNtvWHQYQMMiK/eZNBdDN9c1d6SNo0H9
 keML7aBywPaNBUh4k8EJ4TQXibEu9ABdNtlaJHOksZIuyZ1/zyrU5atw2MqGNnkK
 ZUg1kSeXRVdikYL4kyPEEqV3Qqm3xxZlRX42csjSxx2eFSDAAKspYXWAa6ctgM2H
 +Tfyt+3eoVRz/9dCF3B7fIQ1kdSJsrYca1Ulup3PCzTyErKSyjC0a8zjCSwsvaul
 zDkqcrSDbfFXJuL8E0JdF9TvilOl6Xnn5ABpcqI2ZqFmFsUQMgtrKN72ESggThxn
 xHxn/A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j22ugssrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3821eb27024so151463eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119367; x=1795724167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bCnkRnm0Uc+pTP7pIvwtA+oKroPqs2WbY6Bp+x3cHoE=;
 b=dVVwBtVytxdPJQbQE8uBjbFv6Ijc3Mn4vxt+bjBghtKis25WsFdi1lKgjt3kgkzmPm
 HMgu7yM/IklvZ4YPQcH3XJxgShcUSLQlbyKKEQr/mqfRN69lA1jNx2MXOgHcXGlfQeNf
 h8ScoUyMS7e+dIGtIZs/RnwEew06mP2AtVFvLEMfof74Ht2gc0XsBhO+lyikDI6hqmo0
 pf+J45Qr8OiwnoaSqt7oHyGwYytK2BKyZi/039sOk1/oMuAPJz6z5k40ZXUyT/yZrhZ4
 FzEmZ0IN7Rd+9PjhHd4293/Olak3yiOq+KpazKTzKpp7YCz0acj7UEJkZKI6ZfbK9yvv
 zZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119367; x=1795724167;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bCnkRnm0Uc+pTP7pIvwtA+oKroPqs2WbY6Bp+x3cHoE=;
 b=q7FtxQxB2FEWRyaL/RQZqyvp1AhIRqLqZDt5+RtW6QhhFfp5P4Fm9pVxpiey7KsTvm
 maBpm4VHoyF1Ao4CckmCavE48cD7u4U/B1Vim4jVrXEPB2dhzGf5bQH3qvmHDYYLPqwT
 rP2IF2JQ3o+0k/lE9kBEZp0EIPhkce6tGfDuiBunKBweO23injQuIuhztlCljQkGkoIE
 pj/FMEa+ZfCDlSLSbTxSMrJFrhB9CrhVFS3zfrA6Ms5uMYXLu5MJXIWwQ/eKoDn89w6G
 DToEhb9Dwp8lYkSjwexjFjM3UuRNomMB+oJ9q+fP3oXuO/KMEnEwbWbcKOJOrstYtX40
 nccQ==
X-Gm-Message-State: APuU4Z8+KVH2T9g6lrTA3bYlBwljKIr1AMVYcllixFoA8YUj2bpW8PBX
 Zs8a9KJvt0gsf20J6e0DYxw7KCIl3kbwOUXXf/Qnrit3s6p+Mq1/Kt3qrx1Hj8pr8568uz5SAO8
 qzaMPFfplF97gpUHJmJNqJDrOghkBi8P0kJRN7/T/Lh0M7JBsoo/QcJIQ4hrB2ipRJg==
X-Gm-Gg: AZFdTZdF3GiHoKBTNLxMAWqG0e4ROUe8bQsxCOeyCdHXaBE5UeCCEOTWX6O12WH3Q+P
 TRsYJrmPKp8X0d46R017UstDO7D1qs0iEmh4hofofD2XNOtOGFPjfMBjpDiLVw06TE85StCN5Si
 7wKPSdQZbkRbSQv+urULJhDNoNczCfm69McVYOoByInlfs/P+R32wXbN2yXIR3r2hFlQYHALovI
 Y6gPaC688ZTmOt18KuU8g/7ywT5yrE7Q22XB6oJkwlrvf6lAodGm31dbgCIbvcGQReHA9B8HU1a
 BTgmBGlpSVhb45AHxFfo09xoYJnPjEfGqNQduhf7sDTKzziwTiZbtpcP3E4qfw5wsyGS/W9QkhI
 TvqP4iGKYEsnD3i801hEOR2h09suXamcoKPH7twNdzRK4VvymUe+k+qJ6pU5ugSjL6dyQirLlIA
 Xn+/GLL1NVPhEuMXMhFAxcgw==
X-Received: by 2002:a05:7300:e91e:b0:384:2780:8757 with SMTP id
 5a478bee46e88-38570a3e793mr437520eec.22.1795119367181; 
 Thu, 19 Nov 2026 12:16:07 -0800 (PST)
X-Received: by 2002:a05:7300:e91e:b0:384:2780:8757 with SMTP id
 5a478bee46e88-38570a3e793mr437497eec.22.1795119366661; 
 Thu, 19 Nov 2026 12:16:06 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:06 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH-for-11.2 01/14] target/hexagon: read the old predicate value
 through C4
Date: Thu, 19 Nov 2026 12:15:50 -0800
Message-Id: <20261119201603.2377989-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: AvAeZUdq6FByykSfhqCrSOfpaR7Th5gN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX4R1FgXwqZ9RF
 dELEN0xI3oZ+4CpmwIUUHn1hiek88o0H6Sq+GeFdajQKyyBYSo1ejFVLXtFJQsgov75mImT6ZfF
 VfopWH4X2FBowG4a+39NsxQhV+hU9h8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX2vguXeV0/I1C
 jOVghiZFV44+4+60VxE95cVBUxhQRLqmGCAZ2RWAJatA6u3UBxghuX86tY3S8ZO0rkLb+hXoX0t
 lK6pKmF1mt64IjVRn8WwRzBgEsXwPui+UghunqJCueuXa+twOoOQs5/uLt5wQLCwB0FbyKRVBEu
 DSK6wSBI1pIz1KsZUd3TEWC2hRpWvhC6LupRujci/HJHgUIrIy8OKJr/SHDCGXNO3cs6TsSKHyT
 Yq/dDW+YPPhZi7icNWFj8+C3n5zSVbDpRlE+jh81EzJgjL3dssSnkDD9KI9F8A1nbFxJS9A6W6O
 PUTCl+M3KwecUNHLfoEsl37TuF78W1fjDuMqlDJux68M77d6mhMlLow1s3IgK918tKW+mlByhoZ
 o8GjevtzviBltABirRwKHgRbm4V9zq9+uN5qbAIi+WOLbgjK+QHiI5o/47AGv0hFtZNmSbHM6RB
 NcrAUDwRw9Rn4sPmhEg==
X-Authority-Analysis: v=2.4 cv=YeEodARf c=1 sm=1 tr=0 ts=6aff5908 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=9fZTsBWXyneHJwdpUA4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: AvAeZUdq6FByykSfhqCrSOfpaR7Th5gN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190080
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KClRyYWNr
IEM0IHJlYWRzIGFzIHJlYWRzIG9mIGFsbCBmb3VyIHByZWRpY2F0ZXMuIFRoaXMgcHJldmVudHMg
dGhlCnBhY2tldCBzaG9ydCBjaXJjdWl0IGZyb20gZXhwb3NpbmcgYSBwcmVkaWNhdGUgcmVzdWx0
IHRvIGFuIG9sZC12YWx1ZQpjb250cm9sIHJlZ2lzdGVyIHJlYWQuCgpTaWduZWQtb2ZmLWJ5OiBN
YXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgfCAgNiArKysrKy0KIHRlc3RzL3RjZy9oZXhh
Z29uL3BhY2tldF91c2VyLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
IHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgfCAgMSArCiAzIGZpbGVzIGNoYW5nZWQs
IDQ0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy90Y2cvaGV4YWdvbi9wYWNrZXRfdXNlci5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBiYzNiNDlhYjA2
ZC4uYzk4OGM4NWYzM2IgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0yNDgsNyArMjQ4LDExIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBjdHhfbG9nX3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBp
bnQgcm51bSwKIAogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfcmVnX3JlYWQoRGlzYXNDb250
ZXh0ICpjdHgsIGludCBybnVtKQogewotICAgIGlmICh0ZXN0X2JpdChybnVtLCBjdHgtPnJlZ3Nf
d3JpdHRlbikpIHsKKyAgICBpZiAocm51bSA9PSBIRVhfUkVHX1AzXzBfQUxJQVNFRCkgeworICAg
ICAgICBmb3IgKGludCBpID0gMDsgaSA8IE5VTV9QUkVHUzsgaSsrKSB7CisgICAgICAgICAgICBj
dHhfbG9nX3ByZWRfcmVhZChjdHgsIGkpOworICAgICAgICB9CisgICAgfSBlbHNlIGlmICh0ZXN0
X2JpdChybnVtLCBjdHgtPnJlZ3Nfd3JpdHRlbikpIHsKICAgICAgICAgY3R4LT5yZWFkX2FmdGVy
X3dyaXRlID0gdHJ1ZTsKICAgICB9CiB9CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9w
YWNrZXRfdXNlci5jIGIvdGVzdHMvdGNnL2hleGFnb24vcGFja2V0X3VzZXIuYwpuZXcgZmlsZSBt
b2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uYWNjNzcyMDJlZjMKLS0tIC9kZXYvbnVsbAor
KysgYi90ZXN0cy90Y2cvaGV4YWdvbi9wYWNrZXRfdXNlci5jCkBAIC0wLDAgKzEsMzggQEAKKy8q
CisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRz
IHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBCU0QtMy1DbGF1c2Ut
Q2xlYXIKKyAqLworCisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxzdGRpbnQuaD4KKwor
c3RhdGljIGludCBlcnI7CisKKyNpbmNsdWRlICJoZXhfdGVzdC5oIgorCitzdGF0aWMgdm9pZCB0
ZXN0X3ByZWRpY2F0ZV9yZWFkKHZvaWQpCit7CisgICAgdW5zaWduZWQgb2xkLCBuZXc7CisKKyAg
ICBhc20gdm9sYXRpbGUoCisgICAgICAgICJyMCA9ICMweDEyXG4iCisgICAgICAgICJwMzowID0g
cjBcbiIKKyAgICAgICAgIntcbiIKKyAgICAgICAgIiAgICBwMCA9IGNtcC5lcShyMCxyMClcbiIK
KyAgICAgICAgIiAgICAlW29sZF0gPSBwMzowXG4iCisgICAgICAgICJ9XG4iCisgICAgICAgICIl
W25ld10gPSBwMzowXG4iCisgICAgICAgIDogW29sZF0gIj1yIihvbGQpLCBbbmV3XSAiPXIiKG5l
dykKKyAgICAgICAgOiA6ICJyMCIsICJwMCIsICJwMSIsICJwMiIsICJwMyIKKyAgICApOworICAg
IC8qIFBhY2tldCByZWFkcyBvbGQgQzQsIHRoZW4gY29tbWl0cyBQMC4gKi8KKyAgICBjaGVjazMy
KG9sZCwgMHgxMik7CisgICAgY2hlY2szMihuZXcsIDB4ZmYpOworfQorCitpbnQgbWFpbih2b2lk
KQoreworICAgIHRlc3RfcHJlZGljYXRlX3JlYWQoKTsKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6
ICJQQVNTIik7CisgICAgcmV0dXJuIGVyciAhPSAwOworfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNn
L2hleGFnb24vbWVzb24uYnVpbGQgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRl
eCA3MGY2NDc1NjU2Yy4uYjM2MzViZTNmY2IgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29u
L21lc29uLmJ1aWxkCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC05Niw2
ICs5Niw3IEBAIHRlc3RzICs9IHsKICAgJ21pc2MuYyc6IHsnY2ZsYWdzJzogW2NmbGFncywgJy1t
djcxJywgJy1PMiddfSwKICAgJ211bHRpcGxlLXdyaXRlcy5jJzogeydjZmxhZ3MnOiBbY2ZsYWdz
LCAnLW1odngnXX0sCiAgICdvdmVyZmxvdy5jJzogeydjZmxhZ3MnOiBjZmxhZ3MsICdleGVfbmFt
ZSc6ICdoZXgtb3ZlcmZsb3cnfSwKKyAgJ3BhY2tldF91c2VyLmMnOiB7J2NmbGFncyc6IFtjZmxh
Z3MsICctTzInXX0sCiAgICdwcmVnX2FsaWFzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdk
dWFsX3N0b3Jlcy5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAogICAnZnJhbWVrZXkuYyc6IHsnY2Zs
YWdzJzogY2ZsYWdzfSwKLS0gCjIuMzQuMQoK

