Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7382BFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaA-0001jA-Ed; Tue, 10 Mar 2026 23:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZk-0001aD-KC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZj-0005Bp-1v
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AJvdZe3296538
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=hXTKVadNbF7Nafcc52WYRnadGlu8Tw8n3Q2b2H/Byh4=; b=Ns
 9/PZckDLP3KkrgpuJaXvN4E1e/ms7hhgkRG8j0JEho6JsA92xGcmCeqLRLa17W2B
 z92whs+MNned4todblOJwxTPPJdS2PTPxNGr6t9BGWGdeipax+pIubLB/28OzKWW
 i/lN8wJqUSCx+hqV3PDJC50OrF9s/CUuFGRo6e8vSi0tvaNYE7Qa7K4vSCHlZat1
 Fz2AE3FB+xylXu7tFGd9SpsLRQueEvq30a3nwrJKC0qQ8OmXx9kzHplydbXl2kJM
 G/zRUPszpKNGr28ttmQu7YpoM0NDnNSx26uQ0hCKsMpwcdAh/yr3CMLZ7YEeqikq
 PtxVhwttp+7TBXA5rsaw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg1muuuy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:33 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d74d78c5f7so5573267a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200973; x=1773805773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXTKVadNbF7Nafcc52WYRnadGlu8Tw8n3Q2b2H/Byh4=;
 b=Z9skpDKr3VpVdK9qbR5as4ti+PNIcY/vv5iAPpwT4YUdiJD4+gs+wy/oQkHCmmkV1C
 p3yjDPU0Fx6l3JhFTbQ4V105d2jik1IaszH8XO4HlaFV0NWOOhaVGwOB/1NlLrBnxPjc
 YC77Upc1hXcBSd9AHmZTejbDCElTm1b9dgYnQDx5sNp48x5cgR8EqlHkzBj6Xw61H6lF
 68BK0ziJ9JjPJOXlQzB+6Ik9aHKDXCuej+FlzldJp74g/KWan5uE6cYbhLKcf5LNNSiy
 0cvw+pHZr/RmtXTF21Q5gQ24+OQlF0lYrHVKjPoCOzTZBKYRLG2pddjJwnkhplyQjwbq
 J3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200973; x=1773805773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hXTKVadNbF7Nafcc52WYRnadGlu8Tw8n3Q2b2H/Byh4=;
 b=nK3xZKdbHMJUg53lIiDpnPjfFciN3/DukCgdcSp3ffcrTRKQo6Uu/2PwZGZrzDuSXz
 sgTxMzyotEEieVYgX1yMj3CIzQPmTwn/4xBXXkED2cpLlPiQXAZaR+9Bs3VDbo6/g2DK
 w6xZ6oU5H4su5jhlM/vsQvwChBTldhzZzxIqJPXFSGaaXgzhQk20spPzqn7iaaIEOszn
 06I494KXnv6JGIGkNUmpRKB7hJ0EG5jCO9CRlr8iiG471jG2PwFHtG/DU20OIMsSrNon
 W26gIDdeXGZv60Z+hxC9+Ig39KiRcu0yyGk5keG+8D9Cnv2vJ5umVl4eJs9LRvPf/EX8
 QJMg==
X-Gm-Message-State: AOJu0Yz6Gwznc/IW/4t4+nq+ZEvS5PrhCkRNkTEvWViSHt0d8vABAK0M
 hbZr6G37kK3NjDHSeQoBy513Ej16p38uoFn9XxrchoLak+Sg1HxTQF1gueBzESh9qcd6FkmQ68h
 mOacL0VJY74ojCa8nJm8SNU0VUCztcfvgpAtFbrc/NDyHgi9IMKx29mGM73QYGFDmLw==
X-Gm-Gg: ATEYQzw6uXQOnbel5fmdBlDpRQNQOsDCHMtdypU3eeqpOPdeqaYaQ3TkcRU2WYtHmkv
 ftU6CVymYepRUtzhMsAi1kybS3vwiW4p+vlWhbNaY+HIru+WlmKdL5wdD4oHiTs+tuGe0911mE2
 xl0qdDsyPQtm6xS/f+PZjvVPwvjLfRCfIuvtxoD+PkVyj/5dsIliLUUtULyq/S+xxNP4gbIudGt
 VNEzlRYrtsgHo7UoyGGVVSUx1dnlMAl6+MtdmE7gBikHZYqYumzqoUV6x/7Cw+ZM1kjeYFd/gZd
 z/dWhsspwZ1hoHq2G0E7o4QA+GmbuokYiUBJOSvE9gOccrbLG/27ZUyGOJxXzQM6oXxG7qJ/yEk
 wyJZBz9cSYAsQV/yMhynOL7/jZOFKjYlNZdW3e8zzU8W+mAysYBEl3ieR2+JPpIdiR9Y64Q==
X-Received: by 2002:a05:6830:2641:b0:7d5:c480:6327 with SMTP id
 46e09a7af769-7d76ade4b42mr807777a34.0.1773200972722; 
 Tue, 10 Mar 2026 20:49:32 -0700 (PDT)
X-Received: by 2002:a05:6830:2641:b0:7d5:c480:6327 with SMTP id
 46e09a7af769-7d76ade4b42mr807761a34.0.1773200972403; 
 Tue, 10 Mar 2026 20:49:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 03/35] target/hexagon: Fix badva reference, delete CAUSE
Date: Tue, 10 Mar 2026 20:48:51 -0700
Message-Id: <20260311034923.1044737-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=YOeSCBGx c=1 sm=1 tr=0 ts=69b0e64d cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=YHbvUooXmMNqKe3LDhEA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jFW7pDL_fqI7NJ4xbrC8AptZsRHReGi6
X-Proofpoint-GUID: jFW7pDL_fqI7NJ4xbrC8AptZsRHReGi6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfXxzoS7hC9/LWM
 8HMb4Z94XIo0dHp6h7xLQ4eComlDZIgRRQtWQAzlOitg8vtqxK690JuyOLBLY6KNt1ssM/2Ku76
 muAOE0IdFnYv1qIkymXUlHzB+/yIwGmF0gD7llGf9MH78LM+Yrd2pcx8VSzSEbj0JuRLqB0w5Q7
 e5kGfUmFEVp2YMvjk1e8qUAI+HFhv/0IBzvCkRkqkteEJQv1UQVzPf325/fjgsZIXcY+HJrbc0Q
 Oxi3joUNzQleuYtgDr19sqxk9qeEm1xWmf6gimte3R0L2wourzJGuKtmPyuHBjX0vSoXKxfTW2s
 FSZQYpW26Ish1rdsL91ud+9tgS9VakEJO5hoKgo2+vflo1K8EBw9dX6nRf700zaLhjlbJy1/wPI
 ttoKSwZnrkcz0zeQtVp4eMYLRtkFctHN0ZyR6+ZTK61nARSsoi38uYMX3w5S/Cg4WkvY3Lu7v+Y
 3GAj+cNc9uGCvc3ejng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8IDExICsrKysrKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
NThhMjJlZTQxZjIuLmU2MWFjMTBmYmYzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMTE3LDYgKzExNywxNCBAQCBzdGF0aWMg
dm9pZCBwcmludF9yZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRlICplbnYsIGludCByZWdudW0p
CiAgICAgICAgICAgICAgICAgIGhleGFnb25fcmVnbmFtZXNbcmVnbnVtXSwgdmFsdWUpOwogfQog
CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIHByaW50X3Rfc3JlZyhGSUxF
ICpmLCBjb25zdCBDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSkKK3sKKyAgICBxZW11
X2ZwcmludGYoZiwgIiAgJXMgPSAweCIgVEFSR0VUX0ZNVF9seCAiXG4iLAorICAgICAgICAgICAg
ICAgICBoZXhhZ29uX3NyZWduYW1lc1tyZWdudW1dLCBlbnYtPnRfc3JlZ1tyZWdudW1dKTsKK30K
KyNlbmRpZgorCiBzdGF0aWMgdm9pZCBwcmludF92cmVnKEZJTEUgKmYsIENQVUhleGFnb25TdGF0
ZSAqZW52LCBpbnQgcmVnbnVtLAogICAgICAgICAgICAgICAgICAgICAgICBib29sIHNraXBfaWZf
emVybykKIHsKQEAgLTIxNiw4ICsyMjQsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2R1bXAoQ1BV
SGV4YWdvblN0YXRlICplbnYsIEZJTEUgKmYsIGludCBmbGFncykKICAgICBxZW11X2ZwcmludGYo
ZiwgIiAgY3MwID0gMHgwMDAwMDAwMFxuIik7CiAgICAgcWVtdV9mcHJpbnRmKGYsICIgIGNzMSA9
IDB4MDAwMDAwMDBcbiIpOwogI2Vsc2UKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVHX0NB
VVNFKTsKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVHX0JBRFZBKTsKKyAgICBwcmludF90
X3NyZWcoZiwgZW52LCBIRVhfU1JFR19CQURWQSk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVY
X1JFR19DUzApOwogICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ1MxKTsKICNlbmRpZgot
LSAKMi4zNC4xCgo=

