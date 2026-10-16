Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25829CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHlQS-0003mX-RC; Fri, 16 Oct 2026 13:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHlQO-0003ky-QW
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:08:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHlQM-0006mR-K2
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:08:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5qV01450473
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=sXXRvnZD3IL2PaUM+pAhcP
 oiorjQA0fKae720tcLKqc=; b=ZyTk/Sl/NNXP++GIxeeC/Q8/mj4N4fI1Lz7gvZ
 eJZIeWPJ+nbG0T2+OI5LXkQdswepuBXBrpDqhQg1f1DQ+96yOHXB2Ys7+T8Tz5PC
 /j9Nl/Nq+s6yrOZNwTvHJJBuLJk+i+q4bK54L6ijn88CcTtRjp1cduKVsWKnW1QN
 F5JVbAm0KK7J1JKss/2fK/IeRvOnkLNYSt1Zkkerye5EekzHgD80uyMwlYlkVrXD
 Ax7Zjh5roizEG6WH3ycLBW6CEdWgvkKN/gIujNPTr2W3nC4ESLUsgzB+vb4Ot2gt
 GHv41Q8+KQ4/SUCxjG/NcKxKzfkbL/cHX71sJO6GrdgbsP4A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur1jt3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:08:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab27eb38d6so177402a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792170531; x=1792775331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sXXRvnZD3IL2PaUM+pAhcPoiorjQA0fKae720tcLKqc=;
 b=X9FoWw9M3hsPIfgHJPVtKXZImcoNni3TOth+avv40/mN/ewnKaKuo0JlkXtNmwrNKL
 dLQ6kGZehWzOxPPGF4nkgFb9qBumf1AhFcuogdMTCEc690Y8VaDuIZtidUpSQ28yOECE
 xUfiKd9rF3BivSLVcsaKSmX8Czr2AF3nweXKdk3vFXzSELrUnoElCKevc4VZlLAXtEAZ
 p5VPAp4OUY35T7z+kn+pU6QK8XDbakWGbwmCMK5kNo1ZZ14if08MPRkWkllBhmddvbdd
 5sFhgCdJnHUss5TDFc5jSe6eDRybbkAVwQQg9GcV5owuXariaoIpTZKDmhUKzQYeW7lx
 qeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792170531; x=1792775331;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sXXRvnZD3IL2PaUM+pAhcPoiorjQA0fKae720tcLKqc=;
 b=sm3I06+zq1fGXyzPS8ULIwShk4f3uowGiCJp4OL8ce3PdFCY850aZXNbvtbtbzumpa
 H5SgCT8da+Cpc4db7TzMhMrfFO3mfhQyhcKmZMU5o+cN/B0OPgYNbifxzxcFmAMHfHLk
 5tja5K5hd4iXsr5kQRtuMcB9JWEAsgAgavhb2p20NLg6Gp1gQ3qXoCJt8mA3Oh7IESei
 sTSZYpc1Pq2KUQ8u0lbc3q2HhlrFsfrIKMrrIagTKWexn5x/fRM7RVI0ZXJruULQu4aW
 5vxB6DSSJ9QOBQwYDDza2mYabFCkZYscnri/7ZPHqGkJ+9LTRnozfnS7P7TX4yAB7GgB
 Q7rQ==
X-Gm-Message-State: AFq9FYI8ITa+Gh8twRs3VXakg4Xdkf9l1RyMW6ON6xot24DqCHg7nH2Q
 Wo+Cve4HLgx6Wn2rv4FgrLP5FejVlkfYCjOUAy0wR1ZwmamXlJ5wU4RO8i1A/PL0yDsbSIhdqyF
 +0999/n9GtTau5UNPZ7hVNgOeo6WCutbAmVVbvfM43KvMWpgLIbEH7vangGytY3El0A==
X-Gm-Gg: AYBFou3MbqBjE6r5YOWRYB77632P7MlcIhwbyMgTesh3lM5rTN4XF5o9K10+lCncYPQ
 Fha5Z5sL+IRP/gj4NLkAdENlu7g0i1eKZm5lh8eDJlPWFWF/VheZgv82UCetq2jMm84ju75OqS3
 J4GIduKSh+lrUuIL1CkXXNDEGeTgmNZXVAuAVP1yTdapHv4DgktmEUhyeujLxh4l1OtrWddWFH5
 iBGTLXclW40su4LaKBo0kdr9UGYwDoyxNlO82wey69xt7mwffwUthLFDmTO04PAh4mNwpUbwfFB
 zOsW/ns4F0K4yDlT2EZzCDU3BPtvmQi7M5ygGrcvxlIlIGFSP8Ou9PQ5dpuDTA/B/o2FCGNVB1D
 9/cmdNdo5ongw7WQkVAC3+7DAVcMXk0GuEt+blTe8cqo92eo=
X-Received: by 2002:a17:90b:4a4b:b0:3ac:80dc:f40c with SMTP id
 98e67ed59e1d1-3aceefbdefamr442998a91.14.1792170531258; 
 Fri, 16 Oct 2026 10:08:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4b:b0:3ac:80dc:f40c with SMTP id
 98e67ed59e1d1-3aceefbdefamr442955a91.14.1792170530609; 
 Fri, 16 Oct 2026 10:08:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac94748c6csm10155552a91.10.2026.10.16.10.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:08:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] target/hexagon: fix the allocframe framekey
Date: Fri, 16 Oct 2026 10:08:48 -0700
Message-Id: <20261016170848.4024042-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX695/MkOp6kxo
 63AQu5IME0IvbP50vh5badEFNy0qUn9yksJuX8+i3YPhk/acNeCnBXp2CZznwothOGPieZ2aX3A
 ljwK4V0JyhZ0nt2v6Csxyy2MsAw8HRHJcBvHERUUFTB9tYN4gRrUnxgdysVeHKGJChdrrMZ80v2
 fBb15Arccg4I0w+QYvCj6I77HT22PUYnXsdvzQ/utWM1fp+kToQHM5128MU7idrP7NoiTMc5izA
 VNyW+DhCH/0ytVtvsp7WgFOPAZtQVSuPBwIO8LKfHXYn4+wtnV9U7uncbdqVt/8KlTkXWMrtPws
 ascb2zE9LSQy9uIYhH+4SQ5JFIrrz5YKY5Xl4HvkB0gFVKs8cLXUBgPfLO2aX27GquF1/5XoOYR
 /psL7s/3iDU2G40L9w/UVoSMlZiMQe9YAQAfGv8tfV/0Y9Ke7VN9DbH8K4CSmwePZQ2ol94RLMN
 ALJmyE/xH0MjQ1JXWOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfXzja3zMMpoMX3
 v5rWlPO4UEyMQGWu9iGlecufqV+nNZyKl/ZM48OF6ewLuTti9cvB6m+nJKOOvxKtZXe5UFMGDvu
 fDJfGv0dbfWizoPmKzaBQ10hTaOyDnI=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad25a24 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_X05_UiFBxjwBGZApkgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: oDPfm-f1xBkL46Rg0zlSYIR-jgbawoGQ
X-Proofpoint-GUID: oDPfm-f1xBkL46Rg0zlSYIR-jgbawoGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160068
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

VGhlIGZyYW1lIHRoYXQgYWxsb2NmcmFtZSBwdXNoZXMgaXMge0xSLCBGUH0sIGFuZCB3aGF0IGlz
IHNjcmFtYmxlZCBpcwp0aGUgTFIgd29yZDogRlJBTUVLRVkgaXMgWE9SJ2QgaW50byB0aGUgdXBw
ZXIgMzIgYml0cy4gIFRoZSBnZW5lcmF0ZWQKY29kZSBmb3IgZkZSQU1FX1NDUkFNQkxFIGJ1aWx0
IHRoZSBrZXkgZnJvbSBGUkFNRUtFWSBpbiBib3RoIGhhbHZlcyBvZgphIDY0LWJpdCB2YWx1ZSwg
c28gaXQgc2NyYW1ibGVkIEZQIGFzIHdlbGwuICBkZWFsbG9jZnJhbWUgYW5kCmRlYWxsb2NfcmV0
dXJuIG9ubHkgdW5kbyB0aGUgdXBwZXIgd29yZCwgc28gYSBGUCByZXN0b3JlZCBmcm9tIGEgZnJh
bWUKcHVzaGVkIHdpdGggYSBub24temVybyBGUkFNRUtFWSB3YXMgY29ycnVwdC4KClVuY292ZXJl
ZCBieSB0ZXN0aW5nIHNvbWUgYm9vdCBpbWFnZXMgdXNpbmcgUXVSVC4KClNpZ25lZC1vZmYtYnk6
IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4
YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jIHwgIDIgKy0KIHRlc3RzL3RjZy9oZXhh
Z29uL2ZyYW1la2V5LmMgICAgICAgICAgICAgICAgfCA2NyArKysrKysrKysrKysrKysrKysrKysK
IHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAgMSArCiAzIGZp
bGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyBiL3RhcmdldC9oZXhhZ29uL2lk
ZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMKaW5kZXggNDljYzExZmRkZDguLjE0ODQwZDk4NzM3
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMKQEAgLTE5
ODksNyArMTk4OSw3IEBAIEhleFZhbHVlIGdlbl9ydmFsdWVfZnNjcihDb250ZXh0ICpjLCBZWUxU
WVBFICpsb2NwLCBIZXhWYWx1ZSAqdmFsdWUpCiAgICAgKnZhbHVlID0gZ2VuX3J2YWx1ZV9leHRl
bmQoYywgbG9jcCwgdmFsdWUpOwogICAgIE9VVChjLCBsb2NwLCAiZ2VuX3JlYWRfcmVnKCIsICZm
cmFtZV9rZXksICIsIEhFWF9SRUdfRlJBTUVLRVkpO1xuIik7CiAgICAgT1VUKGMsIGxvY3AsICJ0
Y2dfZ2VuX2NvbmNhdF9pMzJfaTY0KCIsCi0gICAgICAgICZrZXksICIsICIsICZmcmFtZV9rZXks
ICIsICIsICZmcmFtZV9rZXksICIpO1xuIik7CisgICAgICAgICZrZXksICIsIHRjZ19jb25zdGFu
dF90bCgwKSwgIiwgJmZyYW1lX2tleSwgIik7XG4iKTsKICAgICBPVVQoYywgbG9jcCwgInRjZ19n
ZW5feG9yX2k2NCgiLCAmcmVzLCAiLCAiLCB2YWx1ZSwgIiwgIiwgJmtleSwgIik7XG4iKTsKICAg
ICByZXR1cm4gcmVzOwogfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXku
YyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMDAwMDAuLjVkNTc5MjkzNDc3Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvdGNn
L2hleGFnb24vZnJhbWVrZXkuYwpAQCAtMCwwICsxLDY3IEBACisvKgorICogIENvcHlyaWdodChj
KSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJpZXMuCisg
KgorICogIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKwor
I2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkaW50Lmg+CisKK2ludCBlcnI7CisKKyNp
bmNsdWRlICJoZXhfdGVzdC5oIgorCisvKgorICogYWxsb2NmcmFtZSBwdXNoZXMge0xSLCBGUH0s
IHNjcmFtYmxpbmcgTFIgd2l0aCBGUkFNRUtFWSwgYW5kIGRlYWxsb2NmcmFtZQorICogcmVzdG9y
ZXMgdGhlbS4gIFB1c2ggYSBmcmFtZSBhbmQgcmV0dXJuIHRoZSB3b3JkcyB0aGF0IHdlcmUgc3Rv
cmVkLCBGUAorICogdGhyb3VnaCB0aGUgcmV0dXJuIHZhbHVlIGFuZCBMUiB0aHJvdWdoIEBscl9z
dG9yZWQsIGFuZCB0aGUgRlAgYW5kIExSCisgKiB0aGF0IGRlYWxsb2NmcmFtZSByZXN0b3Jlcy4K
KyAqLworc3RhdGljIGlubGluZSB1aW50MzJfdCBmcmFtZV9yb3VuZHRyaXAodWludDMyX3Qga2V5
LCB1aW50MzJfdCBmcCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQzMl90IGxyLCB1aW50MzJfdCAqbHJfc3RvcmVkLAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgKmZwX2JhY2ssIHVpbnQzMl90ICpscl9iYWNrKQorewor
ICAgIHVpbnQzMl90IGZwX3N0b3JlZCwgc2F2ZWRfZnAsIHNhdmVkX2xyOworCisgICAgYXNtIHZv
bGF0aWxlKCIlW3NhdmVkX2ZwXSA9IHIzMFxuXHQiCisgICAgICAgICAgICAgICAgICIlW3NhdmVk
X2xyXSA9IHIzMVxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFtZWtleSA9ICVba2V5XVxuXHQi
CisgICAgICAgICAgICAgICAgICJyMzAgPSAlW2ZwXVxuXHQiCisgICAgICAgICAgICAgICAgICJy
MzEgPSAlW2xyXVxuXHQiCisgICAgICAgICAgICAgICAgICJhbGxvY2ZyYW1lKCMwKVxuXHQiCisg
ICAgICAgICAgICAgICAgICIlW2ZwX3N0b3JlZF0gPSBtZW13KHIzMClcblx0IgorICAgICAgICAg
ICAgICAgICAiJVtscl9zdG9yZWRdID0gbWVtdyhyMzAgKyAjNClcblx0IgorICAgICAgICAgICAg
ICAgICAicjMxID0gIzBcblx0IgorICAgICAgICAgICAgICAgICAiZGVhbGxvY2ZyYW1lXG5cdCIK
KyAgICAgICAgICAgICAgICAgIiVbZnBfYmFja10gPSByMzBcblx0IgorICAgICAgICAgICAgICAg
ICAiJVtscl9iYWNrXSA9IHIzMVxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFtZWtleSA9ICVb
emVyb11cblx0IgorICAgICAgICAgICAgICAgICAicjMwID0gJVtzYXZlZF9mcF1cblx0IgorICAg
ICAgICAgICAgICAgICAicjMxID0gJVtzYXZlZF9scl1cbiIKKyAgICAgICAgICAgICAgICAgOiBb
ZnBfc3RvcmVkXSAiPSZyIihmcF9zdG9yZWQpLCBbbHJfc3RvcmVkXSAiPSZyIigqbHJfc3RvcmVk
KSwKKyAgICAgICAgICAgICAgICAgICBbZnBfYmFja10gIj0mciIoKmZwX2JhY2spLCBbbHJfYmFj
a10gIj0mciIoKmxyX2JhY2spLAorICAgICAgICAgICAgICAgICAgIFtzYXZlZF9mcF0gIj0mciIo
c2F2ZWRfZnApLCBbc2F2ZWRfbHJdICI9JnIiKHNhdmVkX2xyKQorICAgICAgICAgICAgICAgICA6
IFtrZXldICJyIihrZXkpLCBbZnBdICJyIihmcCksIFtscl0gInIiKGxyKSwgW3plcm9dICJyIigw
KQorICAgICAgICAgICAgICAgICA6ICJtZW1vcnkiLCAiZnJhbWVrZXkiKTsKKyAgICByZXR1cm4g
ZnBfc3RvcmVkOworfQorCitzdGF0aWMgdm9pZCBjaGVja19mcmFtZSh1aW50MzJfdCBrZXksIHVp
bnQzMl90IGZwLCB1aW50MzJfdCBscikKK3sKKyAgICB1aW50MzJfdCBscl9zdG9yZWQsIGZwX2Jh
Y2ssIGxyX2JhY2s7CisKKyAgICAvKiBPbmx5IExSIGlzIHNjcmFtYmxlZCwgRlAgaXMgc3RvcmVk
IGFzIGlzICovCisgICAgY2hlY2szMihmcmFtZV9yb3VuZHRyaXAoa2V5LCBmcCwgbHIsICZscl9z
dG9yZWQsICZmcF9iYWNrLCAmbHJfYmFjayksIGZwKTsKKyAgICBjaGVjazMyKGxyX3N0b3JlZCwg
bHIgXiBrZXkpOworICAgIGNoZWNrMzIoZnBfYmFjaywgZnApOworICAgIGNoZWNrMzIobHJfYmFj
aywgbHIpOworfQorCitpbnQgbWFpbigpCit7CisgICAgY2hlY2tfZnJhbWUoMCwgMHgxMjM0ZmZm
MCwgMHg1Njc4YWJjYyk7CisgICAgY2hlY2tfZnJhbWUoMHhmMjFmMjBhMCwgMHgxMjM0ZmZmMCwg
MHg1Njc4YWJjYyk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CisgICAgcmV0
dXJuIGVycjsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkIGIv
dGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggYTZhY2U0Yzc3YzIuLjBmZDYyY2U3
ZTRjIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAorKysgYi90ZXN0
cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNjgsNiArNjgsNyBAQCB0ZXN0cyArPSB7CiAg
ICdvdmVyZmxvdy5jJzogeydjZmxhZ3MnOiBjZmxhZ3MsICdleGVfbmFtZSc6ICdoZXgtb3ZlcmZs
b3cnfSwKICAgJ3ByZWdfYWxpYXMuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwKICAgJ2R1YWxfc3Rv
cmVzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCisgICdmcmFtZWtleS5jJzogeydjZmxhZ3MnOiBj
ZmxhZ3N9LAogICAnbXVsdGlfcmVzdWx0LmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdtZW1f
bm9zaHVmLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdtZW1fbm9zaHVmX2V4Y2VwdGlvbi5j
JzogeydjZmxhZ3MnOiBjZmxhZ3N9LAotLSAKMi4zNC4xCgo=

