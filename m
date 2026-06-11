Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C83CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2O-00009N-CJ; Thu, 11 Jun 2026 01:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2L-0008N1-Qs
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2H-0002Po-Hu
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:04 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQdU3835154
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=RLHJUg+DRAmy+YfhLbPuYd
 XqIrBaJmas7oQyYeABtzQ=; b=lPyPx9XnfkJJzkcxw7FiinGqpFIkOmoGq3vGmg
 bycmhbi1czND9G2eHADwSmbEZySfVzpMEwrCiJoXGde4UHr26put47bHqSYg7r5s
 yWC4MhOHGr8yy0Ay+rnn+Oq9RN9jJuUrIbqUFdvfu9JWbOsiTWWGtL48119RGEN6
 N6C9VrVv753hOF+fJAfTqieko5u4OITohsZ4GJ46Wfex+Dx1+jUeLZw0Z8oW95Zq
 dfEGOE3CDMI3rwFKVrDcz1/oW9ms49OMBzV6emz5UNumLt8gD/X312zS2jb5nYmO
 htFTLPXQ3qGkgZY81c8vhlfzs1q4s/d85zywKCcoPg/K47BQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6thsm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:32:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3074d4102a9so6628809eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155979; x=1781760779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RLHJUg+DRAmy+YfhLbPuYdXqIrBaJmas7oQyYeABtzQ=;
 b=aWX0MhAV/jELoZohJBUFVg6rJiTT0vkDiywt6HRErPRVw71/PdTCFAYKUkTVRKTM+H
 oQfgoDzzu3jm0A81HiiNgzJDKUpogF9J9BkliDzbvxPZp/jUu5BGZfmmILVSMG22LKie
 QEmaOdPDE7mdAncdx7LNhySngTBmGHarp49HT0d33to+wECzEMyaR0pq9XlF5CrX42H5
 IudSXpWOMDAHFEpTJE4NYu/kdV6XiEcAZkWhxeDOumex5jCBGGNRptd86nzeYXIAREIc
 y/ywbZ6+6txocMvVZd15gd2o73+E82Vwv0EgOZrVyS0wq2QqsBYiaS7sFoATGIvEE7sk
 wHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155979; x=1781760779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLHJUg+DRAmy+YfhLbPuYdXqIrBaJmas7oQyYeABtzQ=;
 b=TiMG9FYsJPdYxMlfZqIbpRXXjCxy9fCDGJH+R7JFPiJgyFNanOlm4fLz0NPqnGiMRP
 I1gp0nR1HtAhuGH5UZcQU2fQj8nuBwpidGPY0mex/aP3khGptg+0T2J5FZYqNtVaqtJr
 OqBlBWya/CK5oL1sAaQeJFaYykbDJfnVie9TPlSwBRt/iVhCIXmza65Kd6tZB4TS8Mx7
 /tozRKaBILSgMS1/P3N5X+5UIrADgnU2HBb1baaffedpGSMmNiRAoVdtks/1zPhq6+Ek
 1yf7p0R/cFSEN+hh0gu1uxQ+D5kFDGX63rPUz6rBAdl649BK4YZhpchYcigLMrP7pzrW
 txyw==
X-Gm-Message-State: AOJu0YzGnw+RN2RUs5qLqBMlDHan5ylqcbnGdxLIPBNbJQm3DfssZp1G
 qLjuE4XDhZKpNQk0JDfZrq8kbE+fOsQR+1T9nnvR7JBJwuJNGots9TOHq+gCyaktmECREbK6jZx
 S9xnBV8o1I7KqOfouaJPO7kpZAsPgjIVh+0tQziIIZS6bzRdPesVONAZDwAZnVzTx1g==
X-Gm-Gg: Acq92OHnKnW0KA0B3C1UmsNeNCgd6143tQ1OU6KXDDy9TDSPrgkjwFLeVW3m5SQ9i1C
 yknXTt1+9V5guCi2R1S7UFKjmFfjx8OaAtW1t8H1ewiCUdHVcQHXlgEkd93fqVovh6FXo1n5pa5
 LK7TH8i/hUjhX3/MBcFBFH5mXrTA6GS5FAE1LGjY9E90KclP7xY2N1dEJsIzreyZBjwioBiOVTK
 T7lPvSWq1VLutRKmRlRlnKkUEYzj4YTCPsS+uyEM5+5bGMr2pbLkSh07lPwD12hCk2QLz6iS+bl
 d1U2RBQZadAx5jJulXB6oxA8dhOvVZQedkbtwMNnkls5+FeHTm3t8MlJl48Bq96hKyeCcjkh/3R
 XPhm5RN11KWaRI3EkGwUyPjidlE1XjbHQOLb3awerhhSVo/VdjjG8Gpi6KuNoxDIyow9rK6M4QD
 cfpRvJ
X-Received: by 2002:a05:7300:7313:b0:2ed:7e1:975 with SMTP id
 5a478bee46e88-30804608cfbmr1173700eec.1.1781155978719; 
 Wed, 10 Jun 2026 22:32:58 -0700 (PDT)
X-Received: by 2002:a05:7300:7313:b0:2ed:7e1:975 with SMTP id
 5a478bee46e88-30804608cfbmr1173681eec.1.1781155978121; 
 Wed, 10 Jun 2026 22:32:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:32:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com
Subject: [PATCH v6 00/28] Hexagon system emulation - Part 2/3
Date: Wed, 10 Jun 2026 22:32:21 -0700
Message-Id: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX2U3CCPC3K0yC
 E8MI8Sqko0x4SPAbk/8wScT+/sKE17gY0w4BLrKvt1uaRUJY94wCTz2vHeqIifw4XPIy5K41ofN
 yHfczg8M604A4HiVbA+qnadR0JUhXIob2feO077xCrDGBQxYqsM0TWX3SQFl5iLQq3eJ9PVTpKm
 Rg/3cZMb74MnT614b/q8SIZALEfC3kPz/nd3X2KyTDif5XjrV1V7fQ2mYU6k45b34VujnWDjx3N
 pz7yYkNOeum++0lIrMx/rOyr6P/aft0BlwFFrZ+QKzqFRFpnLBrz+8NAMdp7Uza/eTF0wa98cqQ
 E0dpv39LJ2FOmkS0VGOBngKM9b3W78Ri9BQbW13F2cbb2W/ZmGEk5I/2bMvZiyGOYrbcvsq8Hcb
 tTdSYHZ91M2izNoWh49MJvyVq3YOF/dMrcJx5QWW+uTZmT4ZpxX69hMPQzKhYp3qbNPp0Go+3kt
 xXMfr8RNW+mtMevwFSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX9ESnEkdbWRmi
 46h8SvdeNLGt/hWUjRDfgSXNb4qqaVE6E3BJAOthMskafIqlNURWKVnFKRT7r1V3OxCT5FCh9zG
 zE3hNldw1hpqvRi3RJQLBQSrN+MNft8=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a488b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p_mR8qS5J_EkG-FELWwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: LYRc24udTNYqvaljhuYy8LTW1kHAs1ay
X-Proofpoint-GUID: LYRc24udTNYqvaljhuYy8LTW1kHAs1ay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

VGhpcyBpcyBQYXJ0IDIgb2YgdGhlIGhleGFnb24gc3lzdGVtIGVtdWxhdGlvbiAoc3lzZW11KSBw
YXRjaCBzZXJpZXMsCmJ1aWxkaW5nIG9uIHRoZSBpbmZyYXN0cnVjdHVyZSBmcm9tIFBhcnQgMSB0
byBpbXBsZW1lbnQgdGhlIHJ1bnRpbWUKaGVscGVycyBhbmQgQ1BVIG9wZXJhdGlvbnMgbmVlZGVk
IGZvciBmdWxsLXN5c3RlbSBlbXVsYXRpb24uCgpUaGlzIHBhcnQgYWRkczoKICAtIEhlbHBlciBp
bXBsZW1lbnRhdGlvbnMgZm9yIHN5c3RlbSBpbnN0cnVjdGlvbnM6IHN3aSwgY3N3aSwKICAgIGlh
c3NpZ24sIHN0YXJ0L3N0b3AsIHdhaXQvcmVzdW1lLCBzZXRwcmlvLCByZXNjaGVkCiAgLSBTU1Ig
KFN5c3RlbSBTdGF0dXMgUmVnaXN0ZXIpIG1vZGlmaWNhdGlvbiBhbmQgZXhlIG1vZGUgc3VwcG9y
dAogIC0gVExCIG9wZXJhdGlvbnM6IHRsYl9maWxsLCB0bGJfZW50cnlfZ2V0X3Blcm0KICAtIElu
dGVycnVwdCBoYW5kbGluZzogZXhlY19pbnRlcnJ1cHQsIHNldF9pcnEsIHNvZnR3YXJlIGludGVy
cnVwdAogIC0gU3RhY2sgb3ZlcmZsb3cgZXhjZXB0aW9uIChmRlJBTUVDSEVDSyAvIEZSQU1FTElN
SVQgY2hlY2spCiAgLSBDUFUgZXhlY3V0aW9uIHN1cHBvcnQ6IGNwdV9leGVjX3Jlc2V0LCBwb2lu
dGVyX3dyYXAsIHN5c2VtdV9vcHMKICAtIFRyYW5zbGF0aW9uIHN1cHBvcnQ6IHBrdF9lbmRzX3Ri
LCBpbXBsaWNpdCBzeXNyZWcgd3JpdGVzLCBuZXh0X1BDCiAgLSBTeXN0ZW0vZ3Vlc3QgcmVnaXN0
ZXIgbmFtZSBkZWZpbml0aW9ucwogIC0gVENHIG92ZXJyaWRlcyBmb3IgdHJhbnNmZXIgYW5kIGxv
YWRfcGh5cyBpbnN0cnVjdGlvbnMKICAtIEd1ZXN0IHJlZ2lzdGVyIHJlYWRpbmcgZnVuY3Rpb25h
bGl0eQoKQ2hhbmdlcyBzaW5jZSB2NToKICAtIFJlYmFzZWQgb250byBQYXJ0IDEgdjggKG5vIGZ1
bmN0aW9uYWwgY2hhbmdlcyBpbiBQYXJ0IDIpCgpQcmV2aW91cyB2ZXJzaW9uczoKICB2NTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDUyOTIxNTgwNi42MDg3NzAtMS1i
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCiAgdjQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMjAyNjA0MDgwNDE5NTMuMTg5OTUzMi0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbS8KICB2MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDMx
MTA0MDc1OC4xMDY4NzMxLTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwogIHYyOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwOTAyMDM0ODQ3LjE5NDgwMTAtMS1i
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCiAgdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMjAyNTAzMDEwNTI4NDUuMTAxMjA2OS0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbS8KCkJyaWFuIENhaW4gKDI2KToKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHtj
LH1zd2kgaGVscGVycwogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgaWFzc2lnbntyLHd9IGhl
bHBlcnMKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHN0YXJ0L3N0b3AgaGVscGVycywgc29m
dCByZXNldAogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQge2csc31ldGltYXNrIGhlbHBlcnMK
ICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHdhaXQgaGVscGVyCiAgdGFyZ2V0L2hleGFnb246
IEltcGxlbWVudCBnZXRfZXhlX21vZGUoKQogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgaGV4
X3RsYl9lbnRyeV9nZXRfcGVybSgpCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBzb2Z0d2Fy
ZSBpbnRlcnJ1cHQKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHN0YWNrIG92ZXJmbG93IGV4
Y2VwdGlvbgogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgZXhlY19pbnRlcnJ1cHQsIHNldF9p
cnEKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IGhleGFnb25fdGxiX2ZpbGwoKQogIHRhcmdl
dC9oZXhhZ29uOiBJbXBsZW1lbnQgc2lhZCBpbnN0CiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVu
dCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKCkKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHNl
dHByaW8sIHJlc2NoZWQKICB0YXJnZXQvaGV4YWdvbjogQWRkIHN5c2VtdV9vcHMsIGNwdV9nZXRf
cGh5c19wYWdlX2RlYnVnKCkKICB0YXJnZXQvaGV4YWdvbjogZXh0ZW5kIGhleGFnb25fY3B1X21t
dV9pbmRleCgpIGZvciBzeXNlbXUKICB0YXJnZXQvaGV4YWdvbjogRGVjb2RlIHRyYXAxLCBydGUg
YXMgQ09GCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBtb2RpZnlfc3NyLCByZXNjaGVkLCBw
ZW5kaW5nX2ludGVycnVwdAogIHRhcmdldC9oZXhhZ29uOiBBZGQgcGt0X2VuZHNfdGIgdG8gdHJh
bnNsYXRpb24KICB0YXJnZXQvaGV4YWdvbjogQWRkIG5leHRfUEMsIHtzLGd9cmVnIHdyaXRlcwog
IHRhcmdldC9oZXhhZ29uOiBBZGQgaW1wbGljaXQgc3lzcmVnIHdyaXRlcwogIHRhcmdldC9oZXhh
Z29uOiBEZWZpbmUgc3lzdGVtLCBndWVzdCByZWcgbmFtZXMKICB0YXJnZXQvaGV4YWdvbjogQWRk
IGswIHt1bix9bG9jawogIHRhcmdldC9oZXhhZ29uOiBBZGQgUEMgdG8gcmFpc2VfZXhjZXB0aW9u
LCB1c2UgZlRSQVAoKSBoZWxwZXIKICB0YXJnZXQvaGV4YWdvbjogQWRkIFRDRyBvdmVycmlkZXMg
Zm9yIHRyYW5zZmVyIGluc3RzCiAgdGFyZ2V0L2hleGFnb246IEFkZCBzdXBwb3J0IGZvciBsb2Fk
d19waHlzCgpNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyAoMik6CiAgdGFyZ2V0L2hleGFnb246
IGFkZCBzaW1wbGUgY3B1X2V4ZWNfcmVzZXQgYW5kIHBvaW50ZXJfd3JhcAogIHRhcmdldC9oZXhh
Z29uOiBBZGQgZ3Vlc3QgcmVnIHJlYWRpbmcgZnVuY3Rpb25hbGl0eQoKIHRhcmdldC9oZXhhZ29u
L2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKwogdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5oICAgICAgICAgICAgICAgICB8ICAgOCArCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNn
LmggICAgICAgICAgICAgICAgICAgIHwgICA3IC0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lz
LmggICAgICAgICAgICAgICAgfCAgMjcgKy0KIHRhcmdldC9oZXhhZ29uL2hlbHBlci5oICAgICAg
ICAgICAgICAgICAgICAgfCAgIDMgKy0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5oICAgICAgICAg
ICAgICAgICAgICAgfCAgMTcgKysKIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1o
ZWxwZXJzLmggfCAgIDIgKwogdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaCAgICAgICAgICAgICAg
ICAgICB8ICAgNCArCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAgICAgICAgICAgICAgICAgICAg
IHwgICAzIC0KIHRhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCAgICAgICAgICAgICAgICAgfCAg
IDcgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgICAgICAgICB8ICAgNSAr
LQogdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgICAgICAgICB8ICAxMSArCiBs
aW51eC11c2VyL2hleGFnb24vY3B1X2xvb3AuYyAgICAgICAgICAgICAgIHwgICA3ICsKIHRhcmdl
dC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAzNjAgKysrKysrKysrKysr
KysrKysrKysrLQogdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgICAgICAgICAgICAgICAgICAgICB8
ICAxNCArCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgICAgIHwgIDE4
ICstCiB0YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMgICAgICAgICAgICAgICAgICAgIHwgICA0ICst
CiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyAgICAgICAgICAgICAgICAgICAgIHwgMjcwICsrKysr
KysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMg
fCAgIDkgKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAgICB8IDQ1
NiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyAgICAgICAgICAgICAgICAgIHwgMjE2ICsrKysrKysrKysrKy0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgICAgICAgICAgICAgICAgfCAgIDMgKwogdGFyZ2V0L2hleGFnb24vaWRlZi1w
YXJzZXIvaWRlZi1wYXJzZXIueSAgICB8ICAgMyArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9l
bmNvZGVfcHAuZGVmICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2xkc3Qu
aWRlZiAgICAgICAgICAgfCAgIDMgKwogMjUgZmlsZXMgY2hhbmdlZCwgMTQxMyBpbnNlcnRpb25z
KCspLCA1NiBkZWxldGlvbnMoLSkKCi0tCjIuMzQuMQo=

