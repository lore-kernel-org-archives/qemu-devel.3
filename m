Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2681C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4nC-0002kc-5b; Wed, 15 Jul 2026 14:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wk4nA-0002ju-02
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:57:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wk4n7-0005xI-32
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:57:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHHQSn161507
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cMDDgULMPaXVsCQN/OjK/Qlh+8CwP1mRe2DYbS8FB9M=; b=RE7zMvnYnGA6SCCI
 HWj80vr/pvEWUZVHq0X14CSPQRD64b7L+nR1CIUpH/W5r7E22tMTCXxDtaZV9t5H
 pVjfuY25J4vwexPeduetmDXPufGhJdie4z4BlLHdumFS/suoiB6BDFJap6kfoMDP
 QA6sl/SyJRAi6aaO/B8DKLo8NsbB2JDtJ06d81f2gUudLOD+YbRvJlQdKT83rvmS
 EaMsbfJoQOJ+ta6oq+71paPlwx3gJYA1BT/tYJsDN8g7ZbisAxVLWmf43bGcWsQd
 HRgQtiNDe+rYiMx9as4FHnojnDf51Hef/U+o8sM1ccl8QMrjCouY5GRhnxg52VT3
 9m5+Zw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqgcjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:57:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dd87656d3so4745483a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784141825; x=1784746625; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cMDDgULMPaXVsCQN/OjK/Qlh+8CwP1mRe2DYbS8FB9M=;
 b=POt4OqXP0VxuPLjO6Rd53O1vzeAMH+9TphKZ7rLyS4PxMEo5YXC16l5ePmOnxAALHz
 lfZysTlw73hAepRgI4+qbIedblRf42h8u8pwoRbkv6ojM1QCy7dX6u+BwiclmGLVhgrt
 i9YqTdDuVwnAIMiIFg66V7YgWBX2Ciw/V54UMY5VuykuznjZFIR9dsSDtanBl0Rn/C6r
 cb5lTSOTojIVM2DykJH5iRJzocjCWnTCpUHCTpli8eSn/c6ILvKqqzB2QFezhXbutljF
 eoWPzSKv0EHgEM4q0QmEE0MVfynEYlJiELWw87kc5Lte91m8ZghTAyzEry5+8BtWFDPH
 ZBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784141825; x=1784746625;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cMDDgULMPaXVsCQN/OjK/Qlh+8CwP1mRe2DYbS8FB9M=;
 b=WfiqN7fzd0OOMUNPDqtsCx1WKmAxUcPgXh4sxlSP2pWIHMu3fst5YVpYH0o3bQKSL9
 O2mKC9FgmuiRPYK+Ea1JXxMS9kxL7FBsq1iqaHzXmWbCMq+74NYN93ZzWXF4NErNvOPB
 cW0JdwudS9mhP7DyQT4H8GID5lyhWmBdNAJ6MaDCPbXOVWOhlUovF3SLTdlSW1/oQvcW
 NkLcIDcm9cSNlebd0YOHkQnSOwXDvhY9OBD44OMfIyHATlK3Wwm5NhzCDmSmcyJgh0/f
 PQP9lveF4fhVtosL4pmdzErrvzp9pu83uk7vC/ET1gHFt1QqnVJn49c7if31zkkvp0B4
 Yufg==
X-Gm-Message-State: AOJu0Ywl5r747HQtbjyyaoPRIdkmJh9FiTga1x7fcYf4M/wBgPJ/G0jz
 VDfx4rKlPssyz5TC8TYWWzRkgcZ2qEIzXWjlw3QkQdvwTyxb6Jc+9WjTuDolzvmV24jajykXuNx
 385NEEWTdhxH3d4zhHMb9vYa6VcP6tIOCMua7KAQvYeObD1yvWOhfFlKTEGcN4j7RNg==
X-Gm-Gg: AfdE7cm71OJbzQ85TDlZhLDbewGGF8ySMaC3DyvRPT1JTPmm2YKjH5WBfSd8czM1A55
 VozdiYhVIgQQvSQHmojwyomuVlFRM7Aal1i2/AjpzixeK3j+gXVS1U346kVmmBAeZfeLS0kYxx2
 R7xeelUQ7BB+55+ngvPp3hRbPmaeMndAGXOMF4oveaPrTnC9N57C4f5757FL1S1Q+z7vY7apR1z
 cMpkgTtHAbrvaSydMJS33/qsa+C1zmfXDU9Ck6Tz0hpRW9cFjjhRiCVai7QEhkFo+HjBPF2+6KL
 yF7zXT3iZmrlQXV14//F6hfDM4cv4Dd469C6UXj0wZu2dXa044avjkUh79JJVLmSm79OnojYFDi
 XpIHJuF9woqKZzmv/BLNeZulABQCg2ARbo01Rn84z4fxlTc6J//tAgxV4Q7E=
X-Received: by 2002:a17:90b:3d81:b0:387:df8f:1406 with SMTP id
 98e67ed59e1d1-38e2a0eacc3mr3301316a91.39.1784141824673; 
 Wed, 15 Jul 2026 11:57:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3d81:b0:387:df8f:1406 with SMTP id
 98e67ed59e1d1-38e2a0eacc3mr3301303a91.39.1784141824200; 
 Wed, 15 Jul 2026 11:57:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c2b17sm5469546eec.25.2026.07.15.11.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 11:57:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 1/7] target/hexagon: initialize deferred sreg-write temps
 to current value
Date: Wed, 15 Jul 2026 11:56:55 -0700
Message-Id: <20260715185701.1287176-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a57d801 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IlOZXNdbeIrMSDKviAkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE4OCBTYWx0ZWRfXyTpS3/A6GQ7e
 EKukGx778EE4wugPO7JGAF4JyBgj+eIms4HB11yDPuOKvzl+eGmUI3mJgp/Xsj4dr1QPu4jzktF
 NwG9LU4lFaAReTT7J5pwqcDK+eX/VjY=
X-Proofpoint-ORIG-GUID: Oz8rXBfmjjHJ2N8veiYUUTGOP7bdFNlb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE4OCBTYWx0ZWRfX1Xv49QVGfUEv
 Mc27HiqKZWXeoPmJYiyCNowhznYau3KW1GdeM6Qh4esTIMYzK625YG2uKqlhVSwweLMc9l0DWGw
 1FodAFEmjS32Z/FC62kCNF8UjIhu6ns5a3krG5Nwk3kXYdaHnKacPsHzXhgdzLrbMDSlkWCi216
 bMrGCLWlfjx5OJrOxbIJZVh5URE7hHbEmYSaXjDPSEs4I4vfOVGtaanwRaYfZIbP9n9KNgboa0o
 b9oWxY+6+a5BjPuv1PMnfN1Hi4F+7kl9POGCLkS94iF42xAs0Z8wKVU5wFLnNRV1xRF9lRSQ7sV
 Y2cUG+v8l3fcTlO0ZJSDuJdAuUi/OmbFCHPQukhUgMHMyW/gbUP44odw9qYWlhPaOoXWqzR0pOi
 SXW4u2KNN+s7yFrKPRL4jf8+DGdVubGU7mtRvMqqNyqjoqn4+OrSJ44ZMRZrglV9WyWCkB1gGrf
 YzCg6LlqmOYhfgMXKTA==
X-Proofpoint-GUID: Oz8rXBfmjjHJ2N8veiYUUTGOP7bdFNlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150188
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

VW5jb25kaXRpb25hbGx5IGFsbG9jYXRlIGFuZCBpbml0aWFsaXplIHRoZSB0ZW1wIHRvIHRoZSBz
cmVnJ3MgY3VycmVudAp2YWx1ZSBmb3IgZXZlcnkgbG9nZ2VkIHNyZWcgd3JpdGUsIHJhdGhlciB0
aGFuIG9ubHkgYWxsb2NhdGluZwp3aGVuIG5lZWRfY29tbWl0IGlzIHNldCBvciB0aGUgcmVnaXN0
ZXIgaXMgU1NSLgoKV2l0aG91dCB0aGlzLCByZWFkaW5nIGEgZGVmZXJyZWQgc3JlZyB3cml0ZSB3
aXRoaW4gdGhlIHNhbWUgcGFja2V0CmJlZm9yZSBpdCBpcyBjb21taXR0ZWQgY2FuIG9ic2VydmUg
YW4gdW5pbml0aWFsaXplZCB0ZW1wIGluc3RlYWQKb2YgdGhlIHJlZ2lzdGVyJ3MgcHJlLXBhY2tl
dCB2YWx1ZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDUgKysr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYwppbmRleCA3NzIzNTkxNmY0Yi4uMjhhMTcxYmY2MjMgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBA
IC02MTUsOSArNjE1LDEwIEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250
ZXh0ICpjdHgpCiAgICAgfQogICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPnNyZWdfbG9nX2lkeDsg
aSsrKSB7CiAgICAgICAgIGludCByZWdfbnVtID0gY3R4LT5zcmVnX2xvZ1tpXTsKLSAgICAgICAg
aWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQgJiYKLSAgICAgICAgICAgIChjdHgtPm5l
ZWRfY29tbWl0IHx8IHJlZ19udW0gPT0gSEVYX1NSRUdfU1NSKSkgeworICAgICAgICBpZiAocmVn
X251bSA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgewogICAgICAgICAgICAgY3R4LT50X3NyZWdfbmV3
X3ZhbHVlW3JlZ19udW1dID0gdGNnX3RlbXBfbmV3KCk7CisgICAgICAgICAgICB0Y2dfZ2VuX21v
dl90bChjdHgtPnRfc3JlZ19uZXdfdmFsdWVbcmVnX251bV0sCisgICAgICAgICAgICAgICAgICAg
ICAgICAgIGhleF90X3NyZWdbcmVnX251bV0pOwogICAgICAgICB9CiAgICAgfQogICAgIGZvciAo
aSA9IDA7IGkgPCBOVU1fR1JFR1M7IGkrKykgewotLSAKMi4zNC4xCgo=

