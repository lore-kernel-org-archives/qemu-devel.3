Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A187F8D77C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTs8-00005d-5S; Thu, 16 Apr 2026 17:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTrz-0008UT-7P
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTrw-0000z8-Pd
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:26 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GIRTeN1183798
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=ztuxBCV1XdY
 VDtddruuiDSkLWnaw62K91JzsPi9H0yc=; b=k+Vnx5m5mNBQ8jYTAhrQK3BdcgI
 7Cjfz6pKacwCV5p0wa9rkgD+QQ2sunPlmRdSK9spkmpphpX/onTPPzYHk9sCeMfO
 Y/6vQKlkWf4Zk7J2a0woDdymSfP6snx8vvr77HYKX3Hejdln/GojFu+waMxBWzmI
 rOHt3S5uRwY6mic52zjNuNneEkYLruB+kLEly+YedXNimrWDONmC7KVPeKmCu7oJ
 YL9fxfBPYLaVWtjOldp424kjT/TNZGfqg/0xaLkSfDMTeJ2RSIf7g9cdcu7iLhYY
 95MGRGmVdL3OGx0PQU1cPjIieT8KUyw/U/fwcVex0xTZmPhYQFRzTUlfppQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk52jgfe0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:20 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c726ddda8so500601c88.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776373400; x=1776978200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ztuxBCV1XdYVDtddruuiDSkLWnaw62K91JzsPi9H0yc=;
 b=ISQm46LsWX87y4RbDCjoQf4BG5QbafLQknDe+44U1JbNAgWKGAWV9imfKCiO4DeWjj
 XbbPq5Q34cMyJl8du3fWzVfphzSwYMPrZ7lNHjp+rLQghFJaGnvgCZIk/oJSrRoFBKv1
 fRbsXkPm/XwELuZvoYz5/igMHaQ3fSYpnHQPGHf5eg0Tj0cImCXjVg8xdFjdz8eIdGxv
 ws/SEEPx08nYSjLIJ+i5OmK6t++QP/tIAdmQ1Xaqc29hXR/5hN4iyeExFnsNv6fdeYFH
 cJBmpV3fJ2iukbLCCWLHzWi34Htc1yHxesc1yl76nqXEtI4AU6VEkqqgW4DMyBcYGQ2Q
 x7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373400; x=1776978200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztuxBCV1XdYVDtddruuiDSkLWnaw62K91JzsPi9H0yc=;
 b=JPcAUiGiYjWwoDGGYxUvKplNhIAHeUNeclXJOfTMxTxg39HvAeS6FLXMheNKWAeyeH
 bUPllL0JTv+s8kkzw+EKNbC7yrqS+GlUdpg9KJVTNOe9iMIARLvMd62OavlxVtuiucVd
 r8NkffB9SG1NfaXkCILpCQZ5IUDXDnzNMyhJ+02tkyN9j4XZ8uhdDgnEvMwyy2JcDLwj
 DEtraHBg2lMzMartEwN7tUp86XPJzVnxWuBuMhC31W3Gxa+U0rAxLyIusqehbQ3eXiMs
 bbgbnbSVyESEQex2ncIy/hxfiOv8u+ckLAwU0jiVIZJ+C6iUR56mQUX2+e6VYd0am+iM
 Uc0w==
X-Gm-Message-State: AOJu0YypyJBFJ+AAlInEVdfedj5NdaSl+CB2iHEF98Dcung4Teu5pr0x
 L9VhYrKeeDNZmJqyAleuCGVyi18tkQjGClB2GTcONJ9E7Vc9z5aHKKDfnqxKJ22UT8lqS3FQP2H
 0Xi2V2Zng8EaW28A3xn0zdtDSfXS0uZX65ky1JYbiXJN62Jvf3O/EHDjYiYKVjyDmVw==
X-Gm-Gg: AeBDieukfZpjw93qRUrw/gthc+MGKj2vKRI7/1P2GwUWfS9JW60R6olpjFoUmeDTkKJ
 Y7ANPNQyiuPUSS6Si0vZlhBH8jky68NrbxJuLETMjvmLGEQRSuScUpDEujeWCIvmHVK97ODP3SM
 4KE8Q2i9awhMQ0uSTffR1JiCUVsz+w8sUDcSJFIgkgggZ4gWzKpm1zONItR7+h0UX2Wa8voG2kG
 xDQKPXenSJZ7eHQMbwN7ZL7MY9j5lMH49vohOkWwEZ8GkViunD0L9UglASZXwNIflt2uq3PoCEX
 6igjhMSIw0U0/OVQF1zSjiKjCJ+SPPeXpVy7lg58AwBp+uP00gr2JEFNJ+bJqNDvOnsZAhbEFlt
 U4yF4APiE5gflAAGmnHmVHHABUH5h4NoPOSibivwC6t9z33ss81uEgJkZcXK3ewi+oUBppVSIyc
 UmqXBz
X-Received: by 2002:a05:7022:ef11:b0:12a:72af:83d2 with SMTP id
 a92af1059eb24-12c7283bf8emr427650c88.14.1776373399651; 
 Thu, 16 Apr 2026 14:03:19 -0700 (PDT)
X-Received: by 2002:a05:7022:ef11:b0:12a:72af:83d2 with SMTP id
 a92af1059eb24-12c7283bf8emr427618c88.14.1776373398788; 
 Thu, 16 Apr 2026 14:03:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c90cd7esm11176277eec.13.2026.04.16.14.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 14:03:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v5 0/9] Hexagon system emulation - Part 3/3
Date: Thu, 16 Apr 2026 14:02:56 -0700
Message-Id: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=buR8wkai c=1 sm=1 tr=0 ts=69e14e98 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=N3XQ6_GsU5t2OgCActgA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: qc47Q9fOYTGAXZe3msVn-QmOHOLSPbhJ
X-Proofpoint-ORIG-GUID: qc47Q9fOYTGAXZe3msVn-QmOHOLSPbhJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE5OSBTYWx0ZWRfXwnapBe+9fLup
 Sjbie0rvmT3xg7pj3FTThzB3aU15E9CaJ2auza1HNwSWqRQhzcg+aG88lHqQqZzLnAgmXuTpIWh
 +O/h0qTbi2m0I8t5NMsAO5HYoGCBtzekzMZcF/wCzQ7MZ7N72LF9IBLN3qcJzcqrqsdQHbI5BUx
 0WGO7cQ1gP3WWV2hw/LESfzqtIfkEm37L9KrenNWjnMymvYVaW9EhYtQeDpPQjpyL6GCKPndmO9
 U1CiW4B/rTu2NWAlMGs9wZd+4QNes5lCXBXrZpTMk/0b//3ysBhsQj0PcjWKxuYDWDRCVL/9PA7
 m5NN6epNIZUn0AItQuC3BURU+by/m/qlCHurdwIdXHrBsJQL3rXsa0/qS6Oom9sfVIrWUrksJNb
 099l78a2FXyWBHC3Qnk8r4EC/Ey+iRJh+7P4di1hTS+5L0k137RoASk6ZXUtcKFhpHmUhS7poND
 CTfvP8gjQHNgxFZBHKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

VGhpcyBpcyBQYXJ0IDMgb2YgdGhlIEhleGFnb24gc3lzdGVtIGVtdWxhdGlvbiBzZXJpZXMuICBJ
dCBhZGRzIHRoZQpib2FyZC1sZXZlbCBzdXBwb3J0LCBtYWNoaW5lIGRlZmluaXRpb25zLCBhbmQg
YnVpbGQgaW5mcmFzdHJ1Y3R1cmUKbmVlZGVkIHRvIHJ1biBoZXhhZ29uLXNvZnRtbXUuCgpUaGlz
IGluY2x1ZGVzOgogLSBHbG9iYWwgcmVnaXN0ZXIgbW9kZWwgKFFPTSBkZXZpY2UgZm9yIHNoYXJl
ZCBzeXN0ZW0gcmVnaXN0ZXJzKQogLSBHbG9iYWwgcmVnaXN0ZXIgdHJhY2luZwogLSBNYWNoaW5l
IGNvbmZpZ3VyYXRpb24gZGVmaW5pdGlvbnMgKHY2NmcsIHY2OG4sIHNhODc3NS1jZHNwMCkKIC0g
Y2ZnYmFzZSBzdXBwb3J0CiAtIEhleGFnb24gInZpcnQiIG1hY2hpbmUgZGVmaW5pdGlvbgogLSBC
dWlsZCBjb25maWd1cmF0aW9uIGZvciBoZXhhZ29uLXNvZnRtbXUgdGFyZ2V0CiAtIEJvb3Qgc2Vy
aWFsIHRlc3QgZm9yIGhleGFnb24KCkJhc2VkIG9uIFBhcnQgMSB2NiArIFBhcnQgMiB2NC4KCkNo
YW5nZXMgc2luY2UgdjQ6CiAtIFJlbW92ZWQgZW1wdHkgaGV4YWdvbl9nbG9iYWxyZWdfcmVhbGl6
ZSgpIHN0dWIgYW5kIGl0cwogICBkYy0+cmVhbGl6ZSBhc3NpZ25tZW50CiAtIENoYW5nZWQgdmly
dCBtYWNoaW5lIGRlZmF1bHQgQ1BVIGZyb20gdjczIHRvIHY2OCB0byBtYXRjaAogICB0aGUgbWFj
aGluZSBjb25maWcKIC0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSAiZGVwZW5kcyBvbiBUQ0ciIGZyb20g
SEVYX0RTUCBLY29uZmlnCiAtIFJlbW92ZWQgdW51c2VkICJpbXBseSBQVElNRVIiIGZyb20gSEVY
X0RTUCBLY29uZmlnCiAtIFJlbW92ZWQgc3RhbGUgI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X3BhZ2Uu
aCIgZnJvbSB0cmFuc2xhdGUuYwoKUHJldmlvdXMgdmVyc2lvbnM6CiAtIHY0OiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwNDA4MDQyMTQ5LjE5MDI3OTYtMS1icmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20vCiAtIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjYwMzExMDQyMDE5LjEwODUwMzAtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20vCiAtIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwOTAyMDM0
OTUxLjE5NDgxOTQtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCiAtIHYxOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwMzAxMTcyMDQ1LjEyOTU0MTItMS1icmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpSZWxhdGVkIHNlcmllczoKIC0gUGFydCAxIHY2OiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwNDAxMTUyNjU3LjMxNDkwMi0x
LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KIC0gUGFydCAyIHY0OiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwNDA4MDQxOTUzLjE4OTk1MzItMS1icmlhbi5jYWlu
QG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWluICg4KToKICBody9oZXhhZ29uOiBBZGQgZ2xv
YmFscmVnIG1vZGVsCiAgaHcvaGV4YWdvbjogQWRkIGdsb2JhbCByZWdpc3RlciB0cmFjaW5nCiAg
aHcvaGV4YWdvbjogQWRkIG1hY2hpbmUgY29uZmlncyBmb3Igc3lzZW11CiAgaHcvaGV4YWdvbjog
QWRkIHY2OCwgc2E4Nzc1LWNkc3AwIGRlZnMKICBody9oZXhhZ29uOiBNb2RpZnkgIlN0YW5kYWxv
bmUiIHN5bWJvbHMKICB0YXJnZXQvaGV4YWdvbjogYWRkIGJ1aWxkIGNvbmZpZyBmb3Igc29mdG1t
dQogIGh3L2hleGFnb246IERlZmluZSBoZXhhZ29uICJ2aXJ0IiBtYWNoaW5lCiAgdGVzdHMvcXRl
c3Q6IEFkZCBoZXhhZ29uIGJvb3Qtc2VyaWFsLXRlc3QKClNpZCBNYW5uaW5nICgxKToKICBody9o
ZXhhZ29uOiBBZGQgc3VwcG9ydCBmb3IgY2ZnYmFzZQoKIE1BSU5UQUlORVJTICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwogY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29m
dG1tdS9kZWZhdWx0Lm1hayB8ICAgOCArCiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11
Lm1hayAgICAgICAgIHwgICA4ICsKIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKwogaHcvaGV4YWdvbi90cmFjZS5oICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMiArCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgICAgICAg
IHwgMTUwICsrKysrKysKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5oICAg
ICAgfCAgNTYgKysrCiBpbmNsdWRlL2h3L2hleGFnb24vdmlydC5oICAgICAgICAgICAgICAgICAg
IHwgIDQzICsrCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA3ICstCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYyAgIHwgIDY0
ICsrKwogaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjZnXzEwMjQuaC5pbmMgICAgICB8ICA2NCAr
KysKIGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5jICAgICAgfCAgNjUgKysr
CiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgICAgICAgIHwgMTg4ICsrKysr
KysrCiBody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMgICAgICAgICAgICAgIHwgMzEzICsr
KysrKysrKysrKysrCiBody9oZXhhZ29uL3ZpcnQuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgNDU2ICsrKysrKysrKysrKysrKysrKysrCiBzeXN0ZW0vcWRldi1tb25pdG9yLmMgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAyICstCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA2ICstCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAg
ICAgICAgICAgIHwgICAxICsKIHRlc3RzL3F0ZXN0L2Jvb3Qtc2VyaWFsLXRlc3QuYyAgICAgICAg
ICAgICAgfCAgIDggKwogaHcvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMSArCiBody9oZXhhZ29uL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDE0ICsKIGh3L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgfCAgIDgg
KwogaHcvaGV4YWdvbi90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiBo
dy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIHRhcmdl
dC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L2hl
eGFnb24vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdv
bi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgIHwgIDEzICstCiB0ZXN0cy9xZW11LWlvdGVz
dHMvdGVzdGVudi5weSAgICAgICAgICAgICAgIHwgICAxICsKIHRlc3RzL3F0ZXN0L21lc29uLmJ1
aWxkICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKwogMjkgZmlsZXMgY2hhbmdlZCwgMTQ4MCBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdz
L2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFrCiBjcmVhdGUgbW9kZSAxMDA2NDQg
Y29uZmlncy90YXJnZXRzL2hleGFnb24tc29mdG1tdS5tYWsKIGNyZWF0ZSBtb2RlIDEwMDY0NCBo
dy9oZXhhZ29uL3RyYWNlLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbi5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25f
Z2xvYmFscmVnLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2hleGFnb24vdmlydC5o
CiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYTg3NzVfY2RzcDAu
aC5pbmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y2NmdfMTAy
NC5oLmluYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8x
MDI0LmguaW5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jCiBjcmVhdGUg
bW9kZSAxMDA2NDQgaHcvaGV4YWdvbi92aXJ0LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhh
Z29uL0tjb25maWcKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21lc29uLmJ1aWxkCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi90cmFjZS1ldmVudHMKIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0YXJnZXQvaGV4YWdvbi9LY29uZmlnCgotLSAKMi4zNC4xCgo=

