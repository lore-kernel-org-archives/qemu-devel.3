Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50FDC79F8B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2weK-0001UR-Af; Sat, 05 Sep 2026 16:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weH-0001Te-2a
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weF-00060y-IJ
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hb4Eg3777565
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /Jj4j2GCfBwE5ovkoFjN3VV5tzOwu7hql1i8S9as56c=; b=R/NevmNNswZqg4P0
 d7Frx5lzS2oYba0PjYOOcNTFE9CHPPVPam4N2goHjr2Sh/revkKVEjOPPGoiQegO
 yBwL0Yus9MlS+ZoepN3VsTpTo7XJN6blYOb2p3jnLuTjn7ZRFPQSFCZKpVO1MAZD
 fUzTR4JvzrHH45Dv+RxzKfIZQKhIgwnTUG34rEst+e8+RIPvCG0l6WkDgwIITlEE
 n2BpaO99DikZCgAVvW9FI/7WtdLYI94cCXS3bQ86mnNjjMzKMy/Z1f+rW0hzyjCY
 EFsL3XANFyl/Kowcx6NK4exeBz48lSstvoOCL1FKUOgXY9tEUGQgB775gTzsZzGD
 +9GkRA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga1s29sm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:05:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381250979d5so2663343a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638757; x=1789243557; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/Jj4j2GCfBwE5ovkoFjN3VV5tzOwu7hql1i8S9as56c=;
 b=b2EWrBGujmgA5puRBGLfgJzyWK2wORF18dfEyo6M58/qw9iEoWFuOq7OAdT/DLETdj
 VgQz8I7tkh6NsiJSXsLYiuHdr7NVoyjS9iT9wYJ99q2oMwR4SfZmY+J0l7yzIDBKR3BL
 DayWODBs6avsby+Ouv5LbEC6X+TMXrOEthnsADQxctfFeAewWrqHrBSf2jzhpcTV15r0
 MMG3+g4HiJza36T4/bIyfEu750uXKoBN0xbjpwvlGYpaooX0xYZXN4eIedRne9vmUaUU
 obT0Sh51Wl26umtJq4exiJetu3DoCMyV38KxvAWPm1hDk7p7Wp0KWwQy1QgtNKSfRg8o
 IRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638757; x=1789243557;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Jj4j2GCfBwE5ovkoFjN3VV5tzOwu7hql1i8S9as56c=;
 b=UKkbJj71ru3iWXh3pGb8CfBVuOabBs/uosoXMgSpIfskd4XIPLfhLYUTlz7MpJAuq5
 0QzNjucaWAKQ/pz0qfyCyypnuZ3XhTCFw3UzyxP1uazjZnFCUaflpd/RGkOAwj2guaSf
 TW9OcJxSXXb5zNoesC2pqAyo2iKi1XAMGdWaw49TrfJKUhug+0oZQn6U23/6V+RLLwoP
 7Ma0qLns635B0+FIkZTC8+0i/ur9kyc+SYbVb+RPX4xxhKUmpyZki6iquG0ZmVnODiEW
 34BRK2IyNvrBAPt7ki8coRlE9ZkULLSBAwvZHhP7B0ju/gIvKx4UoFgLxr8VqgiqzokO
 fl2Q==
X-Gm-Message-State: AFuF++lEsgb1y+0fIkBxFg4OjBaeG2pOBSBvvJCp2g/dseSw51omECRG
 xFRUXQfW6yAdMgj5RnMQOFFS9FS4o/5jthqkKbmgVwngH+XBeFCFXBszRbur8gtKj9YiUq/bIJR
 LEomgNncdG0xL9epKOdnhEzM8Bv/0EI/hxl21ZO6V7J76h6dlAHKiK0ebLbya8+3Bzg==
X-Gm-Gg: AYBFou3tcEMkHXqdQuCbPaemOAw2Nyxo7XKKK04GuCm+q9NaaNJjrbRXdFHXutz5snX
 RfrSTePMtiiWm4AvYo5cJUmli77n0XGvWXbXm1K7gVHzooZB9I9TnspJR/+H3XExoa7srgodmc9
 KmZVBkxrZtEhhVEu+H+iNSTDh+p61ZsDcCKPNd64Ar05wtyDUrk4LArdzkcdCthgumTEcSu6WEW
 QWYwXoISzy6YZIhZQUuPn7HXPEYhdn5sR8qWKtHdNH4Q+JDldgztmTTXa/mk3JUdBCxqNbP6+8U
 pIbXzepD60Va0YmvjKU1HYbyQ/SowlBzwV9QaUyEnEKp3pW5K6ocUWp+T2vOcpuPP4LDDwP6hsf
 gUQP4YN3DKN7JR66DS2/7EKNBa6tZf/gkChYq0vgv58+DDyh3
X-Received: by 2002:a17:90b:2d0b:b0:398:c794:ca26 with SMTP id
 98e67ed59e1d1-39b263167f7mr21130279a91.25.1788638757192; 
 Sat, 05 Sep 2026 13:05:57 -0700 (PDT)
X-Received: by 2002:a17:90b:2d0b:b0:398:c794:ca26 with SMTP id
 98e67ed59e1d1-39b263167f7mr21130231a91.25.1788638756715; 
 Sat, 05 Sep 2026 13:05:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbebf2fsm17346075eec.25.2026.09.05.13.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:05:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 2/9] target/hexagon: read BADVA as an alias of BADVA0/1
Date: Sat,  5 Sep 2026 13:05:43 -0700
Message-Id: <20260905200550.2009799-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
References: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a9c7626 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=feXoTaF-XZ6kQvkB_U8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX9VVc1tYT3zbU
 z9p2BYn01gcQG9t9I68AqUdw2qY0OWtHUOrpMS6xGYPyNEB1+e94cHKWQbW+yTew7Aky9/dE0ZS
 s03nHYKH2dIomsjbC1msg8PVmjaeWXA=
X-Proofpoint-GUID: a_fIHk2ksw0RC4cgzU3i4HO0TFRYv2xb
X-Proofpoint-ORIG-GUID: a_fIHk2ksw0RC4cgzU3i4HO0TFRYv2xb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX8ulvSPmiQGYM
 qJZ8gNW1w1vXNQjDkS9Spco0bmWDuSRDTxriY9wiaVx6t50pVsS7FU25pNX6oAga/cIcEuTwppY
 CbNB3Nj+MuvhfNvD6a+DqYbzrAG5HWWyynXPB0HGEKQ1QgWLr5wMya+tVBfEZd0otc8tPDcwXug
 ZOf7Wu548WnI45Rgr9ZrC6uLbkhpVbDUBjSUKaFtAQKsJeTomD4tEpcz0NlbHlzumRfUKIEYQ8A
 SAY0HeHx/eiOlR0+lJmnnGYxeoI01LEGOw/p3jXaG4hg1g9ralCD5CiUpZbPRYElXkDrbhAUijA
 MOVbwjFPKItgSKOYMPwjieteRyLaEDYIGhaONHQ733IoOFEKjZitISpjO3j5L5EUpql6X6OcYoq
 hF3cC/rczOk+ULMGdtJ1xc/UQOYmGDyqj7OsgRs4WOhFw+yoPckY7mIKtB/CKDuUt6XCKNaR6My
 yvGEWeWQcUz7UZtfyLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050223
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QkFEVkEgaXMgc29ydCBvZiBhIHZpcnR1YWwgcmVnaXN0ZXI6IGl0IHJlYWRzIGJhY2sgYXMgZWl0
aGVyIEJBRFZBMApvciBCQURWQTEsIHNlbGVjdGVkIGJ5IFNTUltCVlNdLiAgc3JlZ19yZWFkKCkg
aW5zdGVhZCByZXR1cm5lZCB0aGUKc2VwYXJhdGUgY29weSB0aGF0IHNldF9iYWR2YV9yZWdzKCkg
c3RvcmVzIGluIHRfc3JlZ1tIRVhfU1JFR19CQURWQV0uCgpHdWVzdCBjb2RlIHRoYXQgd3JpdGVz
IEJBRFZBMC9CQURWQTEgZGlyZWN0bHkgd2FzIHJlYWRpbmcgYmFjayBhIHN0YWxlIEJBRFZBLgoK
VW5jb3ZlcmVkIGJ5IHRoZSBoMiBoeXBlcnZpc29yIGtlcm5lbC9tZW0vdGxibWlzcyB0ZXN0LgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgNyArKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCA3MTU1NWE3YmEz
Ni4uNWQ2NGM1NTIzYmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xODg5LDYgKzE4ODksMTMgQEAgc3Rh
dGljIGlubGluZSBRRU1VX0FMV0FZU19JTkxJTkUgdWludDMyX3Qgc3JlZ19yZWFkKENQVUhleGFn
b25TdGF0ZSAqZW52LAogICAgIEhleGFnb25DUFUgKmNwdTsKIAogICAgIGdfYXNzZXJ0KGJxbF9s
b2NrZWQoKSk7CisgICAgaWYgKHJlZyA9PSBIRVhfU1JFR19CQURWQSkgeworICAgICAgICB1aW50
MzJfdCBzc3IgPSBlbnYtPnRfc3JlZ1tIRVhfU1JFR19TU1JdOworICAgICAgICBpZiAoR0VUX1NT
Ul9GSUVMRChTU1JfQlZTLCBzc3IpKSB7CisgICAgICAgICAgICByZXR1cm4gZW52LT50X3NyZWdb
SEVYX1NSRUdfQkFEVkExXTsKKyAgICAgICAgfQorICAgICAgICByZXR1cm4gZW52LT50X3NyZWdb
SEVYX1NSRUdfQkFEVkEwXTsKKyAgICB9CiAgICAgaWYgKHJlZyA8IEhFWF9TUkVHX0dMQl9TVEFS
VCkgewogICAgICAgICByZXR1cm4gZW52LT50X3NyZWdbcmVnXTsKICAgICB9Ci0tIAoyLjM0LjEK
Cg==

