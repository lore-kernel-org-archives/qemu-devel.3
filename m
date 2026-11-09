Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADCF606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EfkvAR5f;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VWuk/S9X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW17-0003XH-0Q; Mon, 09 Nov 2026 15:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0Y-0003NR-Jl
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0V-0007Hj-0b
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:26 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH8dY879270
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0XSF+P/Mslc/LEMHxW7OFY
 LJQKQMBaIvobgFOblNQLI=; b=EfkvAR5fgM+oU7V1lQNVLHuFYLMDq1Nvntjrw4
 hMtgJHPtsDl0A72hLX6rBnp9gNcZloHfFDswN1GTMYCFByG9RtQXrejawkPyuRBv
 srimrKwBJW/UYCTWX//t+/DTOKl0S1pL6vFwDiNz0Jlad2xXP7X/+oL44yFCAqPw
 6aglX9TNqGK88QnQNGxZvGZfXc6Bqwi3z9mgeZ+xbN/LTW4XgHy7ZW/tlsbLaG8+
 2GnwmVK/9vr9g9gV2VQZ0QwhSSQXnrJKS9acnjblLZIjetutdTxGE6/Y2j9m5wFr
 R478U5/q8NKrA7XO9H/eenaqt8FDw9Smt671P/gZRW0lx/pg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5t23x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:30:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so2229208eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256220; x=1794861020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0XSF+P/Mslc/LEMHxW7OFYLJQKQMBaIvobgFOblNQLI=;
 b=VWuk/S9XLBYMG5qTY+hgc0FCCPkJMWnYU6Jj5H0TZPSQ6RQPGac9Kz7TdwD4lMd3cU
 TyvKLNKcoDiJbhxGcXZ1Tiesb4EBtx2CD0+ws0ZrrPab3E5ne4mDTasDAUjbK6zGkyJP
 XeoLfj59QUPJb1TxjQoV4akk1qi/ccQOXfsWLApAghOqP9FsKMf6kVaCh9EDQu5RPbuK
 ruvSPNk4kGXN85b+kBWCh6VLYkIo4SewlAHt4nlYGJi14CaECB3yTOgdivQMy29x5QrU
 DpBBsArTmMI761WgtADNQCgtvjTmFGz1EPk0AXAJO3mx2RSk0BlytEF1ZCwA90uGW2U/
 8fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256220; x=1794861020;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0XSF+P/Mslc/LEMHxW7OFYLJQKQMBaIvobgFOblNQLI=;
 b=JQXABef4GHqQEFDmUfpGA2+czr3+Bl0p0g2ibSUhEvleRAvf9POps710U+F7sCvv62
 +voZertaQ3/muS9gK/RhlJKvcp4HmDPAkApOIjVFoYigRSRQCEZNW54vUV/8r1dYGUto
 5dlg+y4NoRaDmNhnBUdmviL6jnKdFZ6alYFnxy1+FbktiokiQq5aiz7vigM/x7BFOAtU
 z8Nlyp3A+RL9k74l5frGAgwcqpjtp3EuAFYE0+Bw5q1uewM4+6Y0JYQ26veLQbPgMe9K
 eSkhbbExpzSCVk3K/qmok7HRFJkHl0ey1quUY5d3wD2cbKqNDfYo1Ar1sSHmXQl18BZv
 bd+Q==
X-Gm-Message-State: APuU4Z+T+Fc/4JX7ub68mphZ/bwQt62KS407Uf7et6MQhDAY6SiB5Q+E
 VfMRilMxWDf5sHjw7fKjTGFtm8VXMJShzAWGkdrm0SNiYqAfHIKp7zIcokZL84l9QyKJ4TGHOOv
 N2BplHMVvyeGrK54VVstRjYl1vAtUbasyyQUom3BXVlG+rXnxZu9zHvIakt3ZeGB08g==
X-Gm-Gg: AYBFou1K9UsjDFJpmQN81Lz9rjPS6oDwCUxlq5DQDdvOS1qvHF6oyEJ/CQIqsq6Y8Js
 zAEtvjVM8an+dHkDQFOTX3PFZ20aChqkCAOohjFWvL8lDkZAzzIPtdHbBer1Qb5NjfECuTjK08M
 h/saYB8prKLsNylvKFhBbL39ZeSFGHSSveWcf55ZQfWk1FcynbNZofnFuOZaNOw+/nO8bwqYG9o
 VzJ8AXpgjDrSwN1LbHPLf1I4+/LB5/vdyKK+CfHkrUS3fYsWm1cx+81VHMdrecQCFo44W6DOxS9
 dcvEKI+ByIElNgA1fGDgFOdM6+DCULHMBLwkuzffiLB2hlnG/1be5OYdjiTcby6ngFAeWK7WBIc
 ePl67fwk3eV8NZBpFgnnNxAaDq19UKrlze+a8oWuhWLf/8itRiYoR9/jv21gQeNUT4V6qY+gamJ
 ChAEkPiR/IGAZKsOZNIUcu
X-Received: by 2002:a05:7301:f22:b0:370:cc56:b61a with SMTP id
 5a478bee46e88-375215d6a7fmr435159eec.39.1794256219832; 
 Mon, 09 Nov 2026 12:30:19 -0800 (PST)
X-Received: by 2002:a05:7301:f22:b0:370:cc56:b61a with SMTP id
 5a478bee46e88-375215d6a7fmr435091eec.39.1794256218793; 
 Mon, 09 Nov 2026 12:30:18 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3752060dc0csm823737eec.14.2026.11.09.12.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:30:18 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 0/5] Hexagon: doc updates
Date: Mon,  9 Nov 2026 12:30:12 -0800
Message-Id: <20261109203017.262225-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX7y7WiCny4Rqr
 QJgBRR4UtNnDLpAIsqxaXuNPhi4Rgv39QVHapCVV2SRHngieXnOTlSHejFyt22oWKEtao5Kg69v
 xGbBAJKqdpKlkYrJ4yi6zvlAS+iwXBY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX0yySQnRdzFba
 wLqK2f+491OOTmX03pkwxOpIgXL72qqz+07rZA/xCUNiDidA5cRd6WM+uVBstYUfWMxQ5KnQtBU
 evE6wnSA+mfYQDX0qMMKokoj297UG8XETK2L+GbmIjzG/d8M0wFP8dXDySH2WQ3hUpUX/q1Ycf2
 4AxfbgjmdTz7bzYKhq/knpX3+eadKfYdTR0avxbnlNL66dUSf1AVXAzWzvdmit11/3fPA8JpGHD
 Mt/Qw5lhmLPF1QtIZM8Po2msfpzzPwiOX7iAGJB6A8t89H4DFV8ju62d1FMxSVdKMQi9M2JVc/U
 oBfI/XJOZp4Hwc2uiqSKToWFw1QC36TlwuECTM/akx4n5dT5AvylechatMsWUJlzYgqbiB9d1ST
 0+/kegTEiYSLbNAz6eYPc4Wd0+hCku3pjdfFDdIVfTWdEe4DsmqD66MazD0Cp9odBAlEWf6YNp8
 yn1RQNJ1MJq+/rn4xCA==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af22d5c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0htksBNy__AaqUuXQ2QA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: Ym0WYzD3_5fJ0BT2RiQRJf-VY5CzyCNI
X-Proofpoint-GUID: Ym0WYzD3_5fJ0BT2RiQRJf-VY5CzyCNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090081
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VXBkYXRlIHRoZSBkb2NzIHRvIGRlc2NyaWJlIHRoZSBzeXN0ZW0gZW11bGF0aW9uIHVzYWdlIGZv
ciBjb21tb24gdXNlCmNhc2VzIGxpa2UgSGV4YWdvbiBTREsvUXVSVCBwcm9ncmFtcywgU3RhbmRh
bG9uZSBPUyBwcm9ncmFtcywgYm9vdGluZwpWTSBndWVzdHMsIGxpa2UgTGludXguCgpGdWxseSBy
ZXZpZXdlZCBzZXJpZXMsIHBsYW5uZWQgZm9yIGluY2x1c2lvbiBpbiBhbiB1cGNvbWluZyBQUi4K
CkNoYW5nZWQgaW4gdjI6CgotIFJlbW92ZWQgIi4uLiBwaHlzaWNhbCBsb2FkIGFkZHJlc3NlcyBh
cmUgcmVsYXRpdmUgdG8gdGhlIHN0YXJ0IG9mIHRoZQprZXJuZWwgd2luZG93IGF0IDB4YTAwMDAw
MDAuLi4iIGRlc2NyaXB0aW9uLgoKdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNjExMDkwNDIzMDcuMTMwMTQzOC0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8K
CkJyaWFuIENhaW4gKDUpOgogIGRvY3Mvc3lzdGVtL2hleGFnb246IGRlc2NyaWJlIG1hY2hpbmUg
bW9kZWxzIGFuZCBtZW1vcnkgbWFwcwogIGRvY3Mvc3lzdGVtL2hleGFnb246IHVwZGF0ZSB0aGUg
b3ZlcnZpZXcgYW5kIGVtdWxhdGlvbiBsaW1pdHMKICBkb2NzL3N5c3RlbS9oZXhhZ29uOiBkb2N1
bWVudCBib290IGludGVyZmFjZXMKICBkb2NzL3N5c3RlbS9oZXhhZ29uOiBkb2N1bWVudCBTREsg
c2VtaWhvc3Rpbmcgd29ya2xvYWRzCiAgZG9jcy9zeXN0ZW0vaGV4YWdvbjogZGVzY3JpYmUgaW50
ZWdyYXRlZCBmaXJtd2FyZSBPUyBib290IHBhdGhzCgogZG9jcy9zeXN0ZW0vaGV4YWdvbi9ib290
LnJzdCAgICAgICAgICAgICAgfCAxMDAgKysrKysrKysrKysrKysKIGRvY3Mvc3lzdGVtL2hleGFn
b24vY2RzcC5yc3QgICAgICAgICAgICAgIHwgIDQxICsrKy0tLQogZG9jcy9zeXN0ZW0vaGV4YWdv
bi9lbXVsYXRpb24ucnN0ICAgICAgICAgfCAgMTggKysrCiBkb2NzL3N5c3RlbS9oZXhhZ29uL21h
Y2hpbmVzLnJzdCAgICAgICAgICB8ICAzOCArKysrKysKIGRvY3Mvc3lzdGVtL2hleGFnb24vb3Bl
cmF0aW5nLXN5c3RlbXMucnN0IHwgIDQ4ICsrKysrKysKIGRvY3Mvc3lzdGVtL2hleGFnb24vc2Rr
LXByb2dyYW1zLnJzdCAgICAgIHwgMTU1ICsrKysrKysrKysrKysrKysrKysrKysKIGRvY3Mvc3lz
dGVtL3RhcmdldC1oZXhhZ29uLnJzdCAgICAgICAgICAgIHwgIDU4ICsrKysrLS0tCiA3IGZpbGVz
IGNoYW5nZWQsIDQxOCBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkb2NzL3N5c3RlbS9oZXhhZ29uL2Jvb3QucnN0CiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZG9jcy9zeXN0ZW0vaGV4YWdvbi9tYWNoaW5lcy5yc3QKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2Nz
L3N5c3RlbS9oZXhhZ29uL29wZXJhdGluZy1zeXN0ZW1zLnJzdAogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRvY3Mvc3lzdGVtL2hleGFnb24vc2RrLXByb2dyYW1zLnJzdAoKLS0gCjIuMzQuMQoK

