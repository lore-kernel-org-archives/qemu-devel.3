Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F6606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RSJVsYlP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IngpP6LH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiKn-00029j-P5; Tue, 27 Oct 2026 10:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJX-0007dG-AO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJV-00065s-Ix
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoDXY2358407
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r3WOvdRk6q9uOwIyLgCWCr89tN5UwlkzfMPmHZ8doEE=; b=RSJVsYlPOtvZ1Bpw
 qnggsSwHuw7Hpohlkkl64BKUs6KTQjuouYqrCHtHPvKMKheHkVEpCxvxK52tvLY7
 lSXmhtIaiQjRe7F8iMcqwlv7lklukx5HhL3oQU7bcpuNFkLnInlAofgAPeELQjby
 voG23yFsPjYRVNOlVgRmdj2zam6Q1eFfXuch7Ct4lMoSeHF5SHSGxIeVyZwJCubf
 BD5p0mXMUdq66R+orVshUuNCl2/z5qW8jsyubhrTZQeo97vU+9oMj4lxQ2MZ6MZp
 nO0xaNhemiTLJH/Txg2hM5+Jt33WUUYuuyvbnKLKv/MGuxgGznXlPMM89JYfMCLy
 iz6auA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavucmc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd8b299b0abso477a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111888; x=1793716688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r3WOvdRk6q9uOwIyLgCWCr89tN5UwlkzfMPmHZ8doEE=;
 b=IngpP6LHE/nmYrdnep4BFxqq/BJED0qc1WjoR0PFVpxToPa0Nf7b9uqzlq32VZ4lMf
 OlFHN4V3ibWKIc393uJ67p7mRkfj5tyvPDVQ59icTtlwvLMC/zRtSBMAraVqXcBg7A9R
 DN+TlzfIBNYI8YaJ5z71X/aXH2MWxyvtKYbM7N7jhWpFpX5zFVGu7jqquZm2K/mgAq7X
 Ospx5epUK4BalyFRCOLJ5PwjYBGCU4ycqLcXlnXpZmR5CZa41Kq+lhB/oll5DDMfmbY9
 KRHnX7oViNPwXbWPafamnzo1kvJ5DlW9ogE5xq3txQaWGmQ6bK6Plo4MHEz8nGCxFty0
 Tc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111888; x=1793716688;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r3WOvdRk6q9uOwIyLgCWCr89tN5UwlkzfMPmHZ8doEE=;
 b=bzR3MzAG6kZWKS85VaBmCXnFAHjUsRE853fBK1xFRokASmQ6dgeHrb2cRnatHuqp6J
 SCTY4lOGZI2P76IOibx02hojlAzW7YqcekCw9zxn7MLgKz48g6tg1jl2lfPs9F7YEING
 UKDmOmU6LmP2g80nj3ftL4wfbDuMRN6tZijZgGj/Pu9qVQx55DCcEbEZMR/63g+iIH54
 Ir8fmzSX3WXmeSWwtZtPHOsTYdBriFXEydF7KLe9XAbot/hDiYh3pNWC9fxaX6nJQocb
 faQ/nyNcO/C86Ad7lEIzuqN37nmFFOupRlwaqkSq0r2iab5HmzUEKWkUmxVikiS9R+/S
 udEg==
X-Gm-Message-State: AFq9FYIcbMjimgtoxam0JZYELISsuNkoJp/o7NSJOPs3mpe4/p+ZY8nP
 AfJ5x/Bq7eOrvD4f2X9HUu2+TNpaPVf1IXr7huYq51iv2YUiXb3ZooPgsqzKiMgUcPbikgxOfyV
 q3Sm0978/47Ix7Tk257gCE531CxnGJjw2XaHZfJc3P83AGLPvDNkybtoNbaLBa3iR6w==
X-Gm-Gg: AYBFou0m7hy8jmNyE6K5JeXiw2fJQvCUbzyKF9G5+ob5YjlMnTE/k9p2HeRbcBEpwQr
 nji2HuF8967R6DBuigHtMDDFbpj6oZn8HTf2zg9bPiQF42CS3mTDfg0X8SuJUKWkAyC1YstKj4w
 MS25FF58cnnONBS94lZlKrUJwTBpbxL+ew1828NEKKL911qRGORvA/6Yn5LyuxRqgWF4Bffn/rq
 vug9sKDWTkzp3Wb9FygLbsZiTOEh/BBkT2QTSjXJMSsnPFTf3KjRY1ZgIQnh7wBHQsTY+VzrDP/
 Ewba1/UTEzGM3RAJMf+qUFzCjVBAI7YcvVJd9brZNbuE8T1FJ3DgDqar0Qk8aWw5ksW/Pdm5VE2
 +4UuLV98Wq8hyKOLfkSN2p1A136IO1SQx6uHiIFvuzCNDs18=
X-Received: by 2002:a17:90b:4a51:b0:3ab:2737:3396 with SMTP id
 98e67ed59e1d1-3adeafc9d9cmr8564237a91.65.1793111887487; 
 Tue, 27 Oct 2026 07:38:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4a51:b0:3ab:2737:3396 with SMTP id
 98e67ed59e1d1-3adeafc9d9cmr8564213a91.65.1793111886958; 
 Tue, 27 Oct 2026 07:38:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 17/42] target/hexagon: fix semihosting STAT filename handling
Date: Tue, 27 Oct 2026 07:36:56 -0700
Message-Id: <20261027143721.4125584-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 6rFDrE3MfzOLBK_lsfXyJF-7iWMCKPvt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX0fEXUWLjU1tf
 AYCe23k+oSkaAsvfBXqDgtZ5KM10DIRRXMlFPSYp/Tcu8pW5rDAE6lOKAH3iUTRN2lMlRNeh3f9
 wyCAwf5NebVwV/569fUM6pH8kBf6Q04=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae0b750 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vW8nx58EJidmct_-KksA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6rFDrE3MfzOLBK_lsfXyJF-7iWMCKPvt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX93+3bYqu3Swu
 LvusOENO90jyurL8y0ffrDDo1lVTGyGxKMAID9rTDjwkOuFGe6I3qc0jQ1AjV72R8rKP6o4yrbw
 TduO3m7AX3WPmdtJTc3ZZNbxeixGFpCYYjGMkxLxorN/Is9zv+GqPgAedLX6sEvr6yNrrVwyj5g
 u5wYjZhfVQzJZNR1eVmb9WK/CMRHPrEyodBkox2Y0tCjAs4ErRXi54sUgwWE/RzjF7vO03j8ixj
 axzJ9nOTQcGNXd/o+NNuMWNcFvzDZdtO/skit4cDwS1QGD7xJRE3OeBaX3M1dTd0SnAcg7v7xc8
 LJziRAqqhJfKKKQVX3n0w521kELxr9JRbOH6FF9HqxrE/sPhvdE819fzzVdhaUI/Fcz6dxYgZX6
 oPyuAYw7KCMvJvrzM5tiv/Yg4NJdcB9rrVlDrZGzNDqb81n/wR6gtqz2nN8VZGqqwpHra8l9QU0
 kSo6ec80xvD/+wvpcDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

SEVYX1NZU19TVEFUIGNvdWxkIHBhc3MgYW4gdW50ZXJtaW5hdGVkIGxvY2FsIGZpbGVuYW1lIGJ1
ZmZlciB0byBzdGF0KCkKd2hlbiB0aGUgZ3Vlc3Qgc3RyaW5nIGZpbGxlZCBpdC4gVXNlIGxvY2tf
dXNlcl9zdHJpbmcoKSB0byBtYXAgdGhlIGd1ZXN0CnN0cmluZyBzYWZlbHkuCgpGaXhlczogNzcx
MWZkYmE4OGIgKCJ0YXJnZXQvaGV4YWdvbjogYWRkIG1haW4gYXJjaC1zcGVjaWZpYyBzZW1paG9z
dGluZyBvcGVyYXRpb25zIikKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBRkVB
Y0E5TU9zNlZmSGYyVUhaOHo0Y2R2YUIrN0RZNmhKYjJlbVlaMmFMU2UtdDZpd0BtYWlsLmdtYWls
LmNvbS8KU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+ClJldmlld2VkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyB8IDE1ICsrKysrKystLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IDZl
ODNkODY3MzNhLi4yZWJhNjAyMWI0YyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dp
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKQEAgLTU2OCw3ICs1NjgsNyBAQCBzdGF0
aWMgdm9pZCBzaW1faGFuZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICBz
dHJ1Y3Qgc3RhdCBzdF9idWY7CiAgICAgICAgIHVpbnQ4X3QgKnN0X2J1ZnB0ciA9ICh1aW50OF90
ICopJnN5c19zdGF0OwogICAgICAgICBpbnQgcmMsIGVyciA9IDA7Ci0gICAgICAgIGNoYXIgZmls
ZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAgIHRhcmdldF91
bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB0YXJnZXRfdWxvbmcgc3RhdEJ1
ZmZlckFkZHI7CiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIocGh5c2ljYWxfZmlsZW5hbWVfYWRk
ciwgc3dpX2luZm8pIHx8CkBAIC01NzcsMTUgKzU3NywxNCBAQCBzdGF0aWMgdm9pZCBzaW1faGFu
ZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICB9CiAKICAgICAgICAgaWYg
KHdoYXRfc3dpID09IEhFWF9TWVNfU1RBVCkgewotICAgICAgICAgICAgaW50IGkgPSAwOwotICAg
ICAgICAgICAgZG8gewotICAgICAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtp
XSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAgICAgICAgICAgICAgICAgIGdv
dG8gZG9fZmF1bHQ7Ci0gICAgICAgICAgICAgICAgfQotICAgICAgICAgICAgICAgIGkrKzsKLSAg
ICAgICAgICAgIH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiBmaWxlbmFtZVtpIC0gMV0pOworICAg
ICAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXJfc3RyaW5nKHBoeXNpY2FsX2ZpbGVuYW1lX2Fk
ZHIpOworICAgICAgICAgICAgaWYgKCFmaWxlbmFtZSkgeworICAgICAgICAgICAgICAgIHNlbWlf
Y2IoY3MsIC0xLCBFRkFVTFQpOworICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAg
fQogICAgICAgICAgICAgcmMgPSBzdGF0KGZpbGVuYW1lLCAmc3RfYnVmKTsKICAgICAgICAgICAg
IGVyciA9IGVycm5vOworICAgICAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5hbWUsIHBoeXNpY2Fs
X2ZpbGVuYW1lX2FkZHIsIDApOwogICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgaW50IGZk
ID0gcGh5c2ljYWxfZmlsZW5hbWVfYWRkcjsKICAgICAgICAgICAgIEd1ZXN0RkQgKmdmID0gZ2V0
X2d1ZXN0ZmQoZmQpOwotLSAKMi4zNC4xCgo=

