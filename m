Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851A8C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cbx-0000Wq-3Y; Thu, 03 Sep 2026 14:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cbu-0000WM-JG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cbs-0000Vf-5S
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G39JV346140
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=RvVItG96G0U
 o/KGum1seaFSf+o1xOevPbjmXQMgILZs=; b=X206wiSiXwso4Zx9zLjdqWZhFIh
 2mpaFTLdaBSVO1Z2eOCaqmEOB4ebkRL5y5tcOOM9gym+EZfJBK8U7oun7ioV1VUi
 gsKdpx3Q40vdnV+btR4KokRkSjJzXKlEBAkrxhEUXiu0i0t3ERn3fPkj5HuHLxpJ
 pTI8p7bu0yRZ4uZBPe4ffXImRidcb6DGcmLRD8amZgxVXcF+iMQ2TonhJxADWdlj
 4+GgjcwEIhn6C5h7U5ED060kauLYB0mR9JXvXOc5zU5JJcwj1oDtgTEl8cV0wLUB
 ZOF/7C2xq2oqv3mgSC5b0fMhsjsOxK90kFGJhUicnFofq5zSy0gbpIWh4dw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdtqnb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:56:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398d7e0f3b4so149828a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788461785; x=1789066585; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RvVItG96G0Uo/KGum1seaFSf+o1xOevPbjmXQMgILZs=;
 b=dU7tAEHe2CO2MkGn5PMtXXwgXzupyQh0dsFRZls9uuLOPDq+C1cX+1lldZdNgysVIn
 mHiUhHb7zDBdw1mzwrR2UouRc1Zgq6p9KTcrMAyy6g70UHxdpQlbsayyfa5+/G1bD+fI
 7Mc5DIcXI3XvTaB1FDLbSYWG5bO+Snquv5munQEkCPrg8Vm0SMq0+ldkuBhDDH3Heai3
 PMzGR1VhwLDFA3YV3H2SBBYtajP3q8tpaf+rrUb/4G8C54tLlxlke8qMbg3crauAwVan
 2yKj1+iDpju1+4eG/bQprbbMlx7lfGY7YoMBH9caFVgd8zkLBx4FuhCAhox1HMChuM6d
 Vftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461785; x=1789066585;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RvVItG96G0Uo/KGum1seaFSf+o1xOevPbjmXQMgILZs=;
 b=VDFKf8FJw/KnJ8OgJBdVjJFC3vAtZtFaJviHj80rYnt3F0JgisndSd4IjEDHD1jj5W
 zagirehTEdDQtwOvL1QKAzyxCfUED5tjajEVlmfCSVOeOtdNzjpj015f6cL9MkvlgSNB
 pJkFLKEYHCE0ydY22rQSvxgE/BuHKTOsq3+wxMhClKsooqAmJc1kviPKYqm/DIp0MrhX
 c9gPqTA0OidJy+R/+vaAZ/X2B42EwGm29GuHzs/8ChBBnhWZp8aQfmbilajZ8ZvC7Igk
 j6Z/paGofe+qm4bz3WY4btWRUY4yECyk2V46d1S54n4GvavWLdBW6fBLmNLeDhqe8Yzk
 P2sw==
X-Gm-Message-State: AFuF++k3h7BirG2Va77zU3t7KnctGjcf9V/8NRGYbLtvqlw0KVyQDcGN
 awuguLxcnIJ1JkGqIYKnAm4X7VpNqfhZ/aOFyE5hR/CmYOYzLkNoNLIlJpx6jZUNL7g6lpymsmM
 NsFR4WTvIYFtcP1ggLOuL1uUh7OA96EVhka2Dj0b07LsXPNFRKyRJU4LZeGutlm1kdg==
X-Gm-Gg: AYBFou3k+JqJ4tuV/XE8hUY00Mk5UhWbSGIS41pqm6E6vq+5ckQjJU+rQxSYqQ6rSX+
 yqmQYHAV0DTXpMOjOeeT3/kRtw7PL8COJxo6IxNZZ63byOe40Ye4uWc/3ET5QH32ofUNU+Bmboi
 DgiAQx+LB9l5NGDx0syY6B6l0QnjhBrbxoBMMy6ZVYTly+Hsv1/uOolLQwQtjtuKL+S9c7PYCL+
 xCVz5NM+AEHBwm7OK2wnN/sey7zFPpI9UmwI0KhiXRtJ8hfk3dwC3+KT65ieJxEoGl4FGWs7OMV
 j5tzEGPWUNmn5o9HQBM4U5ZPig/K3Na+rXyjXMjJuKdJ8cMcvqQyeie4XOFhLCZCbM4QPZX0jCJ
 uP3ayFAQDQOJBbIGL/3yKnjuyA8Nd0vKSU4g5LJG2MS/fyzzM
X-Received: by 2002:a17:90b:17cd:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-39b26272b4dmr646719a91.13.1788461784886; 
 Thu, 03 Sep 2026 11:56:24 -0700 (PDT)
X-Received: by 2002:a17:90b:17cd:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-39b26272b4dmr646690a91.13.1788461784375; 
 Thu, 03 Sep 2026 11:56:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm922974eec.31.2026.09.03.11.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:56:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/8] hexagon: fixes for tlb, badva
Date: Thu,  3 Sep 2026 11:56:14 -0700
Message-Id: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX37x6ujRJv8v6
 6Zc7xsFQTH8ETkI5wj1JuA5M1tUK0CCd5ojVHBuDs/U72yeNSMxyYL840AG01gNcg7cXv/HxzhY
 CRA2ypa0SUBdohbPyEkrK/QF/sMxg60=
X-Proofpoint-ORIG-GUID: ILYiTOjeCl7bNtMZ5SESYmn8YCo3jPKe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfXy0RJ1H/FogHt
 iKDLrZoqgz8i/rMpJX2Kdciq+ewIZCwtLMkz2CEQeqm8DeS6ocZH7zdeM/03oiPpnX9n9haGgQe
 1/e2oCMqvIHcGsTGfzv6b827vkeEvDNsBDQGtMN8EaWXm8/Um5eYzjlxCtr1bminkNoTQFWMISz
 /O0ZrD3+x86Ygiz2TGHipkVQvqihrztp6n0MKg/HEva9SF9AdGFiZaKEK3vK+j5BUPTU2LXvtiA
 p8wb9bxVIOUX0ncrZes5jwYfjzAkmZnIcbNWuKaCdNTO1hD1Me0vFD2sV+MV2p8mfM8dwR8P8Ib
 XhMXdtYoVWn/1yiPODlOKkPD+j06OnqIvul7YNfIeBLa+eeO5FniTbTS0csc/xgPXP5bkN++KGa
 ZTAjYJ0lgIYHJurklqOkJhheQSxy1q1zY3JkpqZ9lGUn54NbrVWaniYrWpnbVJei301iUdTCS7a
 r4BUfWBizIw2yS9J3hQ==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a99c2d9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=3sUpYS6cUqGNwrsv4FsA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: ILYiTOjeCl7bNtMZ5SESYmn8YCo3jPKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165
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

QWRkaXRpb25hbCB0ZXN0IHN1aXRlcyB1bmNvdmVyIHNvbWUgc3VidGxlIGlzc3VlcyB3aXRoIFRM
QnMsIGludGVycnVwdHMKYW5kIGJhZHZhIHJlZ2lzdGVyLgoKQnJpYW4gQ2FpbiAoOCk6CiAgaHcv
aGV4YWdvbjogcmVnaXN0ZXIgdGhlIFY2OE5fMTAyNCBtYWNoaW5lCiAgdGFyZ2V0L2hleGFnb246
IHJlYWQgQkFEVkEgYXMgYW4gYWxpYXMgb2YgQkFEVkEwLzEKICB0YXJnZXQvaGV4YWdvbjoga2lj
ayB2Q1BVIHdoZW4gcmUtYXNzZXJ0aW5nIGludGVycnVwdHMKICBody9pbnRjOiBuYW1lIHRoZSBM
MlZJQyBlZGdlIHRyaWdnZXIgY2hlY2sKICB0YXJnZXQvaGV4YWdvbjogYXNzZXJ0IGd1ZXN0IHJl
Z2lzdGVyIHBhaXIgYWxpZ25tZW50CiAgaGV4YWdvbjogcmFpc2UgaW1wcmVjaXNlIGV4Y2VwdGlv
biBmb3IgbXVsdGktVExCIG1hdGNoZXMKICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IGFkZCB0
ZXN0cywgdXBkYXRlIHRvIHYwLjIuMTQKICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IHVwZGF0
ZSBhcmNoIHRlc3RzIHRvIHYwLjIuMTQKCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAg
ICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrCiBody9oZXhhZ29uL2hleGFn
b25fdGxiLmMgICAgICAgICAgICAgICAgICAgIHwgMTAgKysrKysrKysrCiBody9pbnRjL2hleC1s
MnZpYy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKystLS0tCiB0YXJnZXQv
aGV4YWdvbi9oZXhfaW50ZXJydXB0cy5jICAgICAgICAgICAgIHwgIDIgKy0KIHRhcmdldC9oZXhh
Z29uL2hleF9tbXUuYyAgICAgICAgICAgICAgICAgICAgfCAxMiArKysrKysrKy0tLQogdGFyZ2V0
L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRhcmdldC9oZXhh
Z29uL29wX2hlbHBlci5jICAgICAgICAgICAgICAgICAgfCAgOSArKysrKysrKwogdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgICB8IDIyICsrKysrKystLS0tLS0tLS0t
LS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgIDYgKysr
LS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSAgIHwgMTcgKysr
KysrKysrKystLS0tCiAxMCBmaWxlcyBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspLCAyOSBkZWxl
dGlvbnMoLSkKCi0tIAoyLjM0LjEKCg==

