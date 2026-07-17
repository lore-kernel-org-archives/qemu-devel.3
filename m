Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97842C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2P-0006lM-Q9; Fri, 17 Jul 2026 15:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2N-0006l1-PG
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:15:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2L-00083e-MN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:15:55 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGo2e52344609
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qtSbc3/V1S7Zgz4+uUkXmF
 sJE5XkAuytqOuhChTwcsg=; b=dFwpTYJ4iO/YqXYZBPdk3pgPoNQI2vmbojUlXM
 HSQAMsAryWwqoMjK5DjLLdwWG2sg3iS1czkVqH03+yAaMHHUP4CeWvulENXoCsa+
 pGV2jFnw/DbWN19d0Flkkk2p+EyIOsE0ViObcpNdUMeUGxSHmroducXp3nvvIFpy
 ztG51euVAbnlZE5ZiBPjhIrwQiNX7awshTpA14YLHexPe3lGpv9kSWye7fwn178v
 cN70QaGEvYOFF2lOwUtLP9Y8bawyRlklJF7jaks5ryldUaO7Cwc3c1fUwsln+tFy
 pa7juyA1eYTCS4FCJ3oW7MvDMSPmETUzrQo+68H+KE/yu5IA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug10s5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38de842a1a9so7735122a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315750; x=1784920550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qtSbc3/V1S7Zgz4+uUkXmFsJE5XkAuytqOuhChTwcsg=;
 b=GGJQdOM6vf7BiEZ2EqNRRhxIK3mUDp4Vq5MlcvMYTw4LFhQ6kt1eGNnlsqj1+Wx+TS
 U0vdqJgikLlrgvVptMPWvQDsJ1X0+UHm5CvRBpxugs4ZgR5DnEiCBPESTIWaIpo8eqM0
 JF4PXFeKzh/ldts3UbHIHgPIBEWzTFwkuwzkaTJjqfdNvG7ShSxvTrtjM2LRzf35gF0n
 lH3EvrUYdhkxwlCu7y0k/7V+39jnN2+4eOkx4d9dJy0Lrh5saidLhjkkgKo6y4N9XA0s
 MHfQjD51KGeluycBDGrWlpWRZrBVMF5yJDKf9+2rCBzwfOCXRvCED8eNHpZLQ0oqhZRY
 v8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315750; x=1784920550;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qtSbc3/V1S7Zgz4+uUkXmFsJE5XkAuytqOuhChTwcsg=;
 b=fs4vS1/50+VqeVdVQIoI6DuTamNLy0d5hruw1NrsPVZXnqW6bc42izj0b7z+pcJKmx
 8r+yfFyqo8DVzFGX8Idil3UkVINqxqRkxwPVziT+c28Da/FUgis4l60ZUgPOZgI7ZkOc
 qIoRdv70IbBQe7nOArrjY26UecqjlUgorhzrgvjrIQxxzLDi3CB97Z30XF0MQ2AHpj1D
 WP4LD0PuXxetnpFvapzdWZEzQAp8XokkeFOdyhHVbWODdB/a9K1Vbve5Cj/ZZvT8icp4
 HFZI/8vElDN1lREPc+YVlWUbzGAVTC/0zTJRNgMXEoRrlGa3qheCzBoRSJgUA5p4hDQG
 fT9g==
X-Gm-Message-State: AOJu0Yzt1jDNAcuRCN74JoNkREASW0WXp4otYBxEUOeWkdJH3Y+iPiNC
 aYN8QUT2qcMPBev27yb3IgLaSpr7p0Tk5CzVHP98xydWuZpQsnQIeKJfv5rYlsoElANj9PmRs5m
 TjYp0AKrvTbD7cLBDLH7N/f3O6YptdXLQ6d7qeTYZhg9p+w7FMs+6C7XMIU2Ep3m1eA==
X-Gm-Gg: AfdE7cmSmy7M4PBvsvPxEV12M4puf8XYaA9FG7naIVYiVeHwlhhcg4PbhQV21C0oY0U
 Tf4ZYSLBLG/1YDRUh53lK3PLKIuko9/EjQT5fIjx1i4mr06XyFB0Q2NplKW9OvHEucYpeF+Vyui
 C97kUULlsgRLDO0Y26EX2MUFGuCu+LK7et5oOH6Rt6MkCAE+ANEFWT75+FcC4qockRyFB09juqA
 muxvo6gwQZMhJVTSdrxtfk7Ixbh2GHKo0UXT/MKGq8d5XR64DG78oUD2IlyUFY7MTkpbGu95z/Y
 RMsZFtEKY6reiLeLpQy31mJxV8JaItGT16B9wR6ATABKRVayDf60Z4jFdgGgATaZ62j4DtJmrBe
 6BsAAnSszME7nBifosn6ThAD6BVSDlHFgg8AB5q2HWCEcQB1h
X-Received: by 2002:a17:90b:55d0:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-38e4b41f50amr4393656a91.4.1784315750521; 
 Fri, 17 Jul 2026 12:15:50 -0700 (PDT)
X-Received: by 2002:a17:90b:55d0:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-38e4b41f50amr4393596a91.4.1784315749892; 
 Fri, 17 Jul 2026 12:15:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:15:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com
Subject: [PULL 00/12] Hexagon fix queue
Date: Fri, 17 Jul 2026 12:15:35 -0700
Message-Id: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX6VZXJGK2TV3i
 TpPFDnpCjq2jth+/BoBwCqzcJfGWVZRjzAUvfFkN7jLk3NYqOI9BaJjX/bcg1B//foSvTY//hrR
 J4T7hoElDMMGT+nWRQHZce3D6bdXIrd91ZLeBGPFuVFGN4xSCi/2NqjemDTUlSBsYhUldjNy9+Q
 BhZxvSABqq8Kumlf+b8eu5syuYUIFcfov6SFTPFK20xLfFsLkIm9qRkt5oh9Sv0UQXVqF1lTeQd
 QTQnYWctcoCLSsjRTsPSeKj7PhR3aD9sukMAT+FnGweFbC4OkJEaehwQEUw9Ao04MMJfCX3SpMU
 gnhNjgWNfzcogV9q2709XvHnpdsXi6GWF1zinSiqZBfsKoaqBZX8Nvw2w/mQIRYh1FQXbgQP0ve
 J4ndyQZ0Whv4jxZlmR7/cIKHvcrgyQdn0sWaZdjkMihJFxKR3KHfHgU/XXm+GroObn4JN2ty5KP
 tHZZVo7sI/GaUfEHCYQ==
X-Proofpoint-GUID: y7pk380iWpLlv9zTQhKQNSv2Y2Cortxj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX9g4Acq5Gzi6P
 MjZTDioSTOlQKXpL08dRozls6L2rrRyCKJUshJgKQc9kFhAPgAPTx61Ac+mpYnsbQBdc6BL0Y5N
 iGQPCO5NmKdd4C851HIZMODpP5qpE8g=
X-Proofpoint-ORIG-GUID: y7pk380iWpLlv9zTQhKQNSv2Y2Cortxj
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5a7f67 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=W8jkbhi-mClSr6YzSUsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170197
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1ZWYwZWNjNTk0MmVlMDdiYjU4MWNj
OTZhOTdiYmZjMGZkZjQwMDVjOgoKICBNZXJnZSB0YWcgJ2h3LW1pc2MtMjAyNjA3MTQnIG9mIGh0
dHBzOi8vZ2l0aHViLmNvbS9waGlsbWQvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjYtMDctMTcgMTA6
MDE6NTIgKzAxMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAg
aHR0cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUgdGFncy9oZXgtbmV4dC1leHByZXNzLXB1
bGwtcmVxdWVzdAoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDI2MGQxNWM0NWI5Mzg1
MTFhZGUxOTkyZDdmZjNlZmU0N2I3NTE5YmY6CgogIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbjog
YWRkIGFyY2hfdGVzdHMgZnVuY3Rpb25hbCB0ZXN0ICgyMDI2LTA3LTE3IDEwOjA0OjQ1IC0wNzAw
KQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpIZXhhZ29uIGZpeCBxdWV1ZQoKRml4ZXMgZm9yIHRoZXNlIGlzc3VlczoKCiog
Zml4IHVuYWxpZ25lZCBzY2FsYXIgYWNjZXNzZXMgKG5vdyBjb3JyZWN0bHkgZmF1bHRzL3JhaXNl
cyBleGNlcHRpb24pCiogZml4IGJ1aWxkIGVycm9yIHdpdGggLS1kaXNhYmxlLWhleGFnb24taWRl
Zi1wYXJzZXIgYW5kIGdjYyAxNAoqIGZpeCBzeXN0ZW0gZW11bGF0aW9uIGJ1Z3M6IHBhY2tldCBz
cmVnIHdyaXRlcywgUEMgc3R1Y2sgb24gbm9uLUNPRiBUQi1lbmQKKiBmaXggZGVidWcgYWNjZXNz
ZXMgdy9NTVUKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KCkJyaWFuIENhaW4gKDExKToKICB0ZXN0cy9kb2NrZXI6IGhleGFn
b24gZml4IHBvZG1hbiB1bnRhciwgMjIuMS44CiAgZ2l0bGFiLWNpOiBidWlsZCBoZXhhZ29uLXNv
ZnRtbXUgdG8gZW5hYmxlIGZ1bmN0aW9uYWwgdGVzdAogIHRhcmdldC9oZXhhZ29uOiBmaXggLVdz
aGFkb3c9bG9jYWwgYnVpbGQgZXJyb3Igb24gR0NDIDE0CiAgdGFyZ2V0L2hleGFnb246IGhhbmRs
ZSBtaXNhbGlnbmVkIGxvYWQvc3RvcmUgY2F1c2UgY29kZXMgaW4gY3B1X2xvb3AKICB0YXJnZXQv
aGV4YWdvbjogcmFpc2UgU0lHQlVTIG9uIHVuYWxpZ25lZCBzY2FsYXIgbG9hZHMKICB0YXJnZXQv
aGV4YWdvbjogcmFpc2UgU0lHQlVTIG9uIHVuYWxpZ25lZCBzY2FsYXIgc3RvcmVzCiAgdGFyZ2V0
L2hleGFnb246IHJhaXNlIFNJR0JVUyBvbiB1bmFsaWduZWQgZGF0YSBhY2Nlc3MgaW4gc3lzZW11
CiAgdGVzdHMvdGNnL2hleGFnb246IGFkZCB1bmFsaWduZWQgc2NhbGFyIHRlc3QKICB0YXJnZXQv
aGV4YWdvbjogaW5pdGlhbGl6ZSBkZWZlcnJlZCBzcmVnLXdyaXRlIHRlbXBzIHRvIGN1cnJlbnQg
dmFsdWUKICB0YXJnZXQvaGV4YWdvbjogZml4IFBDIG5vdCBhZHZhbmNpbmcgZm9yIG5vbi1DT0Yg
VEItZW5kaW5nIHBhY2tldHMKICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IGFkZCBhcmNoX3Rl
c3RzIGZ1bmN0aW9uYWwgdGVzdAoKTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gKDEpOgogIHRh
cmdldC9oZXhhZ29uOiBmaXggZ2V0X3BoeXNfYWRkcl9kZWJ1ZyB3aXRoIGluLXBhZ2Ugb2Zmc2V0
CgogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsK
IHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQog
dGFyZ2V0L2hleGFnb24vbWFjcm9zLmggICAgICAgICAgICAgICAgICAgICAgIHwgIDMwICsrKy0t
CiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwog
bGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgICAgICAgICAgICAgICAgIHwgICA1ICsKIHRh
cmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNyArKysrCiB0
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMjQgKystLQog
dGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyAgIHwgICAyICstCiB0
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgICAgfCAgMTMgKy0KIHRh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgICB8ICA2MiArKysrKy0t
LS0KIHRlc3RzL3RjZy9oZXhhZ29uL3VuYWxpZ25lZF9kYXRhLmMgICAgICAgICAgICB8IDExOCAr
KysrKysrKysrKysrKysrKysKIC4uLi9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5k
b2NrZXIgICB8ICAyNyArKy0tCiAuZ2l0bGFiLWNpLmQvYnVpbGR0ZXN0LnltbCAgICAgICAgICAg
ICAgICAgICAgfCAgIDQgKy0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAg
ICAgICAgICB8ICAgNSArCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3Rz
LnB5ICAgfCAgNTcgKysrKysrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkICAgICAg
ICAgICAgICAgICAgfCAgIDEgKwogdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0ICAg
ICAgICAgICAgIHwgICAyICsKIDE3IGZpbGVzIGNoYW5nZWQsIDMyNiBpbnNlcnRpb25zKCspLCA1
OSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi91bmFs
aWduZWRfZGF0YS5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L21lc29uLmJ1aWxkCiBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L3Rlc3RfYXJjaF90ZXN0cy5weQoKLS0gCjIuMzQuMQoK

