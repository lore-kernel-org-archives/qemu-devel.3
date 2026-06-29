Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85592C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3cz-0002ch-Fc; Mon, 29 Jun 2026 00:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3cu-0002c2-RC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3ct-0000ir-8m
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NNux1754496
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=; b=kmUNSGr9gEv7Ks5+
 U5WuPUb1E2VUDYegOHujA7U8BZjlCeFRgeZpUSR6bTq0HJjrkyK8cQ1CztUc401W
 j4YiInY8a+kEQKK4rnkyH0UnFT/eAfnv7Jv+q/Cw/wOGu8lSeKCja79MuFy6mdwP
 +jEt6Sx+i/o11XwImhXA+3YgsbXxQ2nyJh5D4m4c8s3wCUtO5ygKw2X30E3sOEka
 jQJfv9E+YO4xnSR+nuP0npNtFH+uHjZFOz6z0Ahi7S+30DENpNDHHHsWEbFpch0t
 8sLRiXNAYpb+sqX7V9ONkuqd/s1i6nkzKoYkzzI1FH6rxg9Cr72OssiPAVur5bIs
 LF+zSA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27334fab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so6738917eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707381; x=1783312181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=WTMeuaa/F1y5jMaSDaatU51KqQyszNOiKoBwkI/v0aamSKqNP6Q9nM1qpDShg8Yu8S
 vr4SFdDGUJndcyK7uZVzQqjxoj1D6lMaDK4a6wxaOQyC3oingBRFxQOE5dgUTZ8LuSic
 cRkkeeUsY7JxnHrnB0p5IDtt5UiPfdlHHKqxzsrOWLwNSx7Sv1huSQji9aBcBj9A98BT
 02SrrDXD4EId39k6mNSbCvjJB/vyN0dSms1wT99FjgAsXRO+oOo7vOC6UISfx86UYxSi
 9foG+g/uo7V6vPZlZF1gQKLpMZrX07GhwmSVHsj9L5dYc3uGqIj67Cgm7bspjq/VAmRX
 UDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707381; x=1783312181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=C0xeVIxabQs2KygRk14cvGXyYCEMo58k+8u2VYvWK7QMFfiHGgtv037qmqwekeNGwT
 Nv0JutXeqpN7W4SDJRL64g+u6RURXSXnf/paIV5POLbdolMHDBp8x1fVwGb0vsDjRqqa
 zbjqb788Y4iZV3mssspOq+HI13bvpPx+eTcn5Dfz2J7juXN6E05SKvAkMPiul4Gon/M+
 aEE6KsFaMmgvXbiCSX5PAT9rWDE83YWOWbkTGNT4wX23ZNI4jn545Rihf5NNsYOV8LkZ
 y1Nvp6Co4LuDBHKk+es4IK9S27RJmumVekQPRnt3ThTkvkZmRgDwgMAPfzq2FGwGR3Zo
 VGnA==
X-Gm-Message-State: AOJu0YxvyPBLfHtIyUCDnughCEEZgdt6wQmynhDQaY6ODk4W/RKmnNTy
 0beBKB5H+GTZABEGazrtFzJHmUuXITtz9N2shHXHJASYSCUXmfTxbJOutOXeV1mPyeeLyBfsUkc
 gTkASRI3eLIVA9aZ0c5vSbgILswIXvR72NIwTTGAwglXuFZoAc8wtGvEtH2h5LF/TeQ==
X-Gm-Gg: AfdE7clp913tCip3HeCCMhInCsRr/a0i5mItDMh+HFeVZYTkTwk3cl9QhaunJ+sO6kw
 UjZ72fkIeULEFo7q2QrsSDXo46a85TUgePuMbCsGelE7cphXGDk/qPB5ffcmfeW90ciE2NrdeTM
 kO7nAv97CnVGOP9H8aQS4oOUcz2kNTvRKFutnZzms4PKHbKuQxHCv6R5qYhVDjgi/DUQmLQjHRR
 MNvE5yhaaofFRavZ8WvYWXnwy2wdfhEaMWG2Syr4YFeMfKrFO8o20ox3kap2B4WjJvxfNwHPWH3
 srZEq8/Hu4PoG75vnTa6HpfbswEgBcqklLH9Jwajhq3q82T1hC3F1upDOalkHgmpyj7eTnmoMji
 O6M9mgfnG6z5UUQ/Xs8rn+flinDH2Z0wXaplu8NAJ3ydDwHsCKrwNdt4tY54=
X-Received: by 2002:a05:693c:8951:10b0:30c:a62b:d033 with SMTP id
 5a478bee46e88-30ca62be4f9mr6621567eec.15.1782707380503; 
 Sun, 28 Jun 2026 21:29:40 -0700 (PDT)
X-Received: by 2002:a05:693c:8951:10b0:30c:a62b:d033 with SMTP id
 5a478bee46e88-30ca62be4f9mr6621553eec.15.1782707379988; 
 Sun, 28 Jun 2026 21:29:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 41/77] target/hexagon: Implement {c,}swi helpers
Date: Sun, 28 Jun 2026 20:57:54 -0700
Message-Id: <20260629035830.1520296-42-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a41f4b5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wskM1cnEyOB5xrvKOInc4zK65K8leAvt
X-Proofpoint-ORIG-GUID: wskM1cnEyOB5xrvKOInc4zK65K8leAvt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX4jcv2tcqaihM
 Kd9WdJhmMlT83aYhMSj15V+BrQxpLPAqfXR9Fk+y9x7+wTJ7x2WeUtBy0fZTY/lGR2Ionc8UUIc
 +Ut9Xa4lwYcKvlvCgsWhjOMH7YiEt1nMk0X3tJHxXYM6bElXgUmFU88qEdiOlIZaAmzDEymkftT
 vdlL2GnQKoa5ZOf+7gAR/gYOMZJZUAYqeY+e7LgipX5xRkop9BRLm4fsz7wAndLjkTiUMsHXlSZ
 O/EpqS1N5jXlanKl5aoetiVQDPKyuw8i2xUCR8pkshdv1TVmyh7l2avJbBhpg2VSn5jshnsGl2o
 nVC68GtpbNgQnDT7YzObsU/MxD1YoYrHgahy/KCwcMz2W3HT6NPjxfel7+b/Yt1GVX6ZiQtHxB7
 Z3OOuthX/ScZ4gCSv9Oyvf21zWK2n+PmrWSf5op93DeOsBSvhtIpm9/2Kmu3+sa4EGoE9AGJpJZ
 7HyPm+rYWd/DdIbFChw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX+6dN/Y72WdWY
 PhmYONnrv4x4oAHZll1Mo7+ZCXoWcxkcGwFoYByTQNSx87umxnmKmOgsyAR5QKrlgKVzTI3DX9B
 FK9K5SpOB337Ca81cTJnNafPdkEuqDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

