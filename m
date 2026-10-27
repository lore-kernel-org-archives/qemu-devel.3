Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646A606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uq9X/Qy3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yb5aV2ZQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLhlj-0000VE-O3; Tue, 27 Oct 2026 10:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLhlh-0000T2-Mr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:03:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLhlf-0002Mb-P9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:03:13 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoAIW2344661
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=iPyqUuHyR5wPyphM9RNZQc
 BTxHIXfoyLfutvxErYejc=; b=Uq9X/Qy3OwIJmzmg9hQXkD3T4ufCGXPDxYqfKR
 Lklu8tWGNUWiXAAss9m4y6Jb7tDuOyJhQ5v3LtHI43G5/WzubBGx2wbI1sAqI4QF
 pJ0LUK9FhSBywF5KhuclDctFFMReYzN2itJAf4udAZAaBcDCphFwV+hwOaI7o3nG
 X88Qqlm49FJanEfmzjafTTDm4+1Za4LjfdOuGKHV2MjOc025TK/zs1AYCaVWiSfN
 MRvgrBOBsdi5nH6a1uumNT8kgCQc190M/2BaJz38CSrmaMHEttQCTM9T6SjTUtoA
 ZEaTV4Em/v9xMfP5M+ylnW5hOXXX5XbzEYQYU9H4vkb8CrDw==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq697ej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:03:10 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67906c453b8so2108559d50.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793109790; x=1793714590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iPyqUuHyR5wPyphM9RNZQcBTxHIXfoyLfutvxErYejc=;
 b=Yb5aV2ZQdPgI54Po4CLEplrdsUmy0Dw3oOXoEFZqz2DJR4Uo0/9ewNid/bpfhqiaaP
 pxFrhhvc4ao9JvqQan94C5jaisF9H7XrC/aekzdFoKzCYC7MgTjhi4+qEQz3wzzTwM1q
 5XknOKU8hBBH8kZB5d/IN1lOoSj974phxD/VBkdAdHLDstY3uMUVMFv4Cb2DQsuAWuNN
 7m+nQWMGDYF7Qw0ZlpoF3AnnZ0Ym9DVfgUOa/uUhvQD+bqTnCH1dpY84c5tIz5NitNmg
 rEatnIxBq9MtTUvBE8Fuv6h29AZaEcCwMZbkfOvC1cBRGBsxWld7PmyhiPYYAQ8PGOr1
 /ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109790; x=1793714590;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iPyqUuHyR5wPyphM9RNZQcBTxHIXfoyLfutvxErYejc=;
 b=g2iLB1qQRirMnk2yok29kS3UB4gYcmIcMH/uDpPHT8z996brSoKH7v6Dfrt3odjvm9
 pBdPBVcVt2mgOdVBFWk5CmDYJRQtfr7JpB9Kqw8usrSjflVCbmSmrzF8qVoPoM+rehYG
 qzQG10sYMX3jtfQ14CnBQQtfA4E7DLlcm7hVle04m4dgAhogDEqHSTTPFnigrobEI65J
 Tqg1VjwmDXnWL2MOvGFc0oMEzN/tzQj1qiLEiPiHhmxkCEYUq3tCDzjjbEuAtnBJbr/u
 3g+SyCVWupy+gEQQov8/K0Z5RZBDuAjDx7aVDWRv5t708CpqHqoOk+lsCEoCVrbeoBJV
 Skrg==
X-Gm-Message-State: AFq9FYIu1tLK2F+0wBeKbkavdZzxzuUZAXuYfXylNjwgODx0Z1gIofUm
 o/A+ZUQlQDIr4Y7ITKnHYdAkARnQda89sy38cRsKpNDko6FMbz8TlguFM5ZDJ5aaf/NqUY1Sgo7
 v3MO4w2D1CdlGuJCmU7RULfIu3tl4smrhScIXDK3KFVsGsKgeQV0odPXE4svhybq/WQ==
X-Gm-Gg: AYBFou3MupXBs7wOxugr46KO3PyTLeg0itUmtNKeAqnc1D9MK64Zqf8pmPSo1t8dgg+
 /reklbMFkVkHHeT+0nfqk49ixKJRbB9ksvyn98GHNHPinMwSxZa2zzrFjyLjZNHhbsJgXx98Jjj
 8cLp4O61Xn2y6MM0ey2+Onn+1MLnjb/oahp9CeQsdjFgEZZ7AoYmktsATn63vLr6raW2bgy4JCn
 yCbzSp3zELuVEj9ECmYE7ETnA8NTBImAd5M28OoLq3XqtbmgtKZS2ukhvZfRCmkAnjw5K8cMka6
 4MqGCZqXaZH1UXl5Des59I80/BRAryS+BQdtMn24Hj0Dxb8I+O7nFwoh8zDCCMKVQjOYxhHEt7Q
 bFT9gonWRwm8EEV+vDFCKGMikz4AkoxyJTZKHeT75/vsHGTc=
X-Received: by 2002:a05:690e:dc6:b0:677:cf6c:ed79 with SMTP id
 956f58d0204a3-67a6e027a5amr1888594d50.29.1793109789385; 
 Tue, 27 Oct 2026 07:03:09 -0700 (PDT)
X-Received: by 2002:a05:690e:dc6:b0:677:cf6c:ed79 with SMTP id
 956f58d0204a3-67a6e027a5amr1888542d50.29.1793109788323; 
 Tue, 27 Oct 2026 07:03:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a7a15ac59sm105571d50.17.2026.10.27.07.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:03:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] scripts/clean_functional_cache: tolerate missing .stamp files
Date: Tue, 27 Oct 2026 07:03:05 -0700
Message-Id: <20261027140305.4027440-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0af1e cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=O_aXAYYkZahAwHBccVsA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: qjVub0ydK-35b-Gky6ZIMLGx9Gf7KOqz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NSBTYWx0ZWRfX1RWmRxTj8Zql
 /bVmzwiwp/v57ec2f8dMWWkYVEh+9jg1ARKCMffoKTnftvHc9BQxkm/zda4StZ3VRjq2hf6N1Zo
 Ya2/A2nSb0bYwDpfHMhzEwF8GwMqNlQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NSBTYWx0ZWRfX1sIlwVDpUcQN
 +Fii6cyxdpbFFdntdjMZjATD/AoY8OwQbuFF5quHr/AZs1van9ESPFUD5k5hmoJ9Xsekm/xHbWy
 lssvndFEIuVNyuqyiJVwHi7F3T/GXsp4iQ8MpxkANsiRsS/BI/Cl+li/CxG2bHY30w0pcww5sfd
 sc5Ix3II7gkiSq1sb+oSEN6g4W0DQHqLCNq3HI96RKYtWBJ3kfI4egYwhiKlX6Agu1t5QGYNuH3
 io8rS5GdYIhfXNaY+jI4MCEIn4B5A2/WFqIUFNuCn+ITXDU4mny6onYaM10hej92//MC3LK5cGq
 qd8FXSPamF0BzAd9ic13vqUn7kIq0UPqrtjXdEB3EstcSNNXz9uGhX0yA6W49Yh8cKKGC61AxWA
 VmkIAdztbSyw9xTL37gDGC1CHNsETJEnzZLPtw+pjsuGkdhzHhiY4LgtLpzZhVrerqGpIhcU2fk
 odRQkDzVhTh6WE2NecQ==
X-Proofpoint-ORIG-GUID: qjVub0ydK-35b-Gky6ZIMLGx9Gf7KOqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QXNzZXRzIGNhY2hlZCBiZWZvcmUgdGhlIHN0YW1wIGZpbGVzIHdlcmUgaW50cm9kdWNlZCBoYXZl
IG5vCmNvcnJlc3BvbmRpbmcgLnN0YW1wIGZpbGUuICBUaGUgc2NyaXB0IGFscmVhZHkgY29wZXMg
d2l0aCB0aGF0IHdoZW4KcmVhZGluZyB0aGUgdGltZXN0YW1wLCBieSBhc3N1bWluZyB0aGUgUUVN
VSB2MTAuMSByZWxlYXNlIGRhdGUsIHdoaWNoCm1ha2VzIHN1Y2ggYXNzZXRzIGVsaWdpYmxlIGZv
ciByZW1vdmFsLgoKSG93ZXZlciwgc2luY2UgY29tbWl0IGMxYmI1OTRmZTQxLCByZW1vdmluZyB0
aGUgYXNzZXQgYWxzbwp1bmNvbmRpdGlvbmFsbHkgdW5saW5rcyBpdHMgLnN0YW1wIGZpbGUuICBG
b3IgdGhlc2Ugb2xkIGVudHJpZXMgdGhhdApmaWxlIGRvZXMgbm90IGV4aXN0LCBzbyB1bmxpbmso
KSByYWlzZXMgRmlsZU5vdEZvdW5kRXJyb3IgYW5kIHRoZQpzY3JpcHQgYWJvcnRzIGFmdGVyIGRl
bGV0aW5nIHRoZSBmaXJzdCBzdWNoIGFzc2V0LCBsZWF2aW5nIHRoZSByZXN0IG9mCnRoZSBjYWNo
ZSB1bmNsZWFuZWQgYW5kIHJldHVybmluZyBhbiBlcnJvci4KClBhc3MgbWlzc2luZ19vaz1UcnVl
IHNvIHRoYXQgYSBtaXNzaW5nIC5zdGFtcCBmaWxlIGlzIG5vdCBhbiBlcnJvci4KCkZpeGVzOiBj
MWJiNTk0ZmU0MTUgKCJzY3JpcHRzL2NsZWFuX2Z1bmN0aW9uYWxfY2FjaGU6IFJlbW92ZSBhbHNv
IC5zdGFtcCBmaWxlcyIpClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiBzY3JpcHRzL2NsZWFuX2Z1bmN0aW9uYWxfY2FjaGUucHkgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9zY3JpcHRzL2NsZWFuX2Z1bmN0aW9uYWxfY2FjaGUucHkgYi9zY3JpcHRzL2NsZWFu
X2Z1bmN0aW9uYWxfY2FjaGUucHkKaW5kZXggMWZmOThjNzYwNmQuLjMwNjMzMDY5YzhmIDEwMDc1
NQotLS0gYS9zY3JpcHRzL2NsZWFuX2Z1bmN0aW9uYWxfY2FjaGUucHkKKysrIGIvc2NyaXB0cy9j
bGVhbl9mdW5jdGlvbmFsX2NhY2hlLnB5CkBAIC00NCw0ICs0NCw0IEBACiAgICAgICAgIHByaW50
KGYiUmVtb3Zpbmcge2NhY2hlX2Rpcn0ve2ZpbGUubmFtZX0uIikKICAgICAgICAgZmlsZS5jaG1v
ZChzdGF0LlNfSVdSSVRFKQogICAgICAgICBmaWxlLnVubGluaygpCi0gICAgICAgIHN0YW1wZmls
ZS51bmxpbmsoKQorICAgICAgICBzdGFtcGZpbGUudW5saW5rKG1pc3Npbmdfb2s9VHJ1ZSkKLS0g
CjIuMzQuMQoK

