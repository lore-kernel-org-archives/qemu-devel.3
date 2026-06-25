Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99392CDE00D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNI-0002a5-HV; Thu, 25 Jun 2026 10:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNG-0002Zi-0v
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNE-0008WD-Cc
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jvbe1754106
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=; b=puChwSRNa2KMc7qR
 W6gxmA/5Y5nJmkzgPajszJvNKf72JQBd9/gUVYjIdyFaHWss4VKUlsx6jzDT5/Q/
 /nsnl9YznZenP0J128D5AfrEqrGqci3T0xWiYzOTEQuguGqwuHMBQH6ol9/fQ+Nc
 BErUH+gSZD5fCk+zvAiIGIJh3LrUF+BgggotLixJf8+ciYJ0e8FZONgbaef1xLNu
 Qu5+2yhKgD65ucebKKtlbPxzFxRCMeOOl9XSluY12rKY6Cij1MA3OKwUb7q1KngC
 7mG9tAp88QTmyWlqH1I2szhT31Zo5pWEU49RBCABb1N5PEp6W0jAXBDyom2a+3su
 ndNC5w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q2bxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so6611623eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398889; x=1783003689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=gES3/JVKCw/EF8xBq/WLjDKW26ExZNx4KbovjsxBhhr98Jh6YP8yp5hibJTVk+MI42
 iqQ+L+ExyxV7ydXNB3LiRWnekMFMWuglS0LBxJSjT0qSMFJyiEsKFzPJfDYnrcP9UCn7
 9tQ1rnJYp5Lx+67HxG4mRsRlRCske8+b38nBxgXXR4iZngEF0K8GkCjktSH0bkubfg7A
 J8ipZPLFCbq4lSdwt6LXMUF29cwJKrres16BSjneWelc/MRs2fGbFRpDAgpiXfkGeVS8
 zW/Wl9Wehl8mBI34BiSr7lsqlAsBtMz6ojW/gajdLbMOnzqKCmt7lO2KcbEcjiL8V2Pv
 vYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398889; x=1783003689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=iWmjSR5yN6MMPoyyrU2+j3IBVZary7+Dhx6khkyPghtP4S/LudIn7cP/Zaqtl0u9hT
 CRjLCwXdhXAlEhKMas77y7Vollya2EEYr2SFwBXchFNrxi3IHitL8uZgf4C9N3cuYAEp
 1U+lX0tDcIMXmowVot3bo2oHwF0ch+aztATPcJcmDS2Uqb7i6mfqey2wD0QA7HsceMWn
 aRZjdc9L4/JlYt7iLPLXgJ3Dmy00exjb9CQTuB7dlOa2GJwzMraL5BH1krYAQYiB41RT
 NhljWYPufUdwM3vjEef0CZiNkOk9+glWtzbNu9Y25OFokphAF9fvOEiwFvXi9ExbEI7w
 Ch0g==
X-Gm-Message-State: AOJu0YzcAUp+ebqUhEg9oEj0wtrIq/7+wz6phI66utZ51joTyRILr180
 LI5YVqlxSNi1gdmTOBfhPS2ajjDxFteZmoledh2n9pZ8zJ89qjuMDYOHF+mZKI3K1RnTWKghb+f
 XVVBT6w5D/aHdOhgePjEE0hSjvUxpmpllm6VoUqn+FnAofcbX6BNDtwu2ZWUNclw8rQ==
X-Gm-Gg: AfdE7cm+efbe7I9kvQe0wUuDPbhKKLw0XgScnXFuF9F56z6iXKmGZg7lYrPzVn5tk4H
 rRnGHGzaK6j9BHbIdWP6Nj4MIfHwReWeiYy2d8nz4BzUf1wzVX44py+ANjYwIScmp4sufW4Jn8V
 lFqpAMdv2WT+sxF2jddqIyEnOklqntzWRJMJja/SWws2SoZemFFSsvaig1XJFmOrubmekEhIxVA
 VJT4YMldY3ZVXSxyk+KKm5R21GdLidDvcZV2juSrbvchkJn5uEUvArP4Yl1vOA0X0gsi6WxK36h
 p38nyrpYKSU03SzdSW70advJtvjElIE9MeaJGU5qm6PLM56KkUVdMUDwh0z6rQSBpUV7E4YPnG+
 x8EDwkCOl5ezCovLYuO6ilTekt/AVN3budRU5dV7pcFsIROMNGJuAeJOpKFQ=
X-Received: by 2002:a05:7300:aca5:b0:2d9:ad46:4a92 with SMTP id
 5a478bee46e88-30c84e214b8mr3157279eec.13.1782398889231; 
 Thu, 25 Jun 2026 07:48:09 -0700 (PDT)
X-Received: by 2002:a05:7300:aca5:b0:2d9:ad46:4a92 with SMTP id
 5a478bee46e88-30c84e214b8mr3157246eec.13.1782398888696; 
 Thu, 25 Jun 2026 07:48:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 40/76] target/hexagon: Implement {c,}swi helpers
Date: Thu, 25 Jun 2026 07:15:57 -0700
Message-Id: <20260625141633.449487-41-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: tax4Pop4wycpRihdiqZTUaL968HxE6Rq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfX1G8iyrpQC5hG
 l9oUweiUGzmbfrU/KkD1dawuu6goFvaZqdwZOsoH4chdh3AeGzHiD+kV5zFaheMc1wLUF3pXsst
 euqZ23mwkq3XMJBTDTq5NAKnQtACpIk=
X-Proofpoint-GUID: tax4Pop4wycpRihdiqZTUaL968HxE6Rq
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d3faa cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfX9YAMf68iyBQv
 LyZ8bsLnlV2QqNnnCmRCwo3B6TJoHew4VYw4B8vCZJ+ExYBANspLRggZsPHewbUDVSI8Ss0PXHK
 fe6fFC2OImvfLqKjYModjn8q3UG61o5n6/ru6D+SPMZ3I+m4Rxb4t+ku1/rkTIgvB8U9jA2aoM3
 oKVMCd4YQWUC81EMzE95UJ7uQ69vCVaFvNEZX23+i8iQy6JegrYwzbMkfHBNtD7yfOmEsGO/+ZM
 dSjC0DHsYV+GRGM3P6erXCBEbu6hY2h41HJIKkSlsaoRY+qkqCuz0+8Od4sqbg0LMRvyupyIVja
 03UxtRiuTxYR905wZjH7QIvjy8XKKfpdnN7547eQuLs55YtcwPh3DESRQ7l3D7e46tiK2abgc9u
 MtmM9jJ0qdZlkrH1vhSxbSQA/DU7eI/2ac2QmP2HwRrmNOPPvrXpsZrzH79ksCz6/PQFTszsJUd
 GTF+aj1JnjOL/DFlE1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250126
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7Yyx9c3dpIGFyZSB0aGUgInNv
ZnR3YXJlIGludGVycnVwdCIvIkNhbmNlbCBwZW5kaW5nIGludGVycnVwdHMiIGluc3RydWN0aW9u
cy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXgg
NGRjMmI4ZTYzYTcuLjc4Mjc2OTZjNmIyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjQsNiArMjQsNyBA
QAogI2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCiAjaW5j
bHVkZSAiZnB1L3NvZnRmbG9hdC5oIgorI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgog
I2luY2x1ZGUgImludGVybmFsLmgiCiAjaW5jbHVkZSAibWFjcm9zLmgiCiAjaW5jbHVkZSAic3lz
X21hY3Jvcy5oIgpAQCAtMzYsNiArMzcsNyBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNp
bmNsdWRlICJ0cmFuc2xhdGUuaCIKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCiAjaW5jbHVkZSAiaGV4c3dpLmgiCiAjZW5kaWYKIApAQCAtMTQw
MywxMiArMTQwNSwxNCBAQCB2b2lkIEhFTFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCBtYXNrLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CiB9CiAKIHZvaWQgSEVMUEVSKGNzd2kpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY2xlYXJfaW50ZXJydXB0cyhlbnYsIG1hc2ssIENQVV9J
TlRFUlJVUFRfU1dJKTsKIH0KIAogdm9pZCBIRUxQRVIoaWFzc2lnbncpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBzcmMpCi0tIAoyLjM0LjEKCg==

