Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70319606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YhdTBB0b;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HXwa7Ubh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQGub-0003lD-FC; Sun, 08 Nov 2026 23:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGuZ-0003km-8E
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGuX-0008Rb-KZ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:14 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93KFnf3899986
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 04:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=kQcU1WVPC4C043B6/CgUWw
 73ZByVRB35hyn/gNx5a3s=; b=YhdTBB0bz5dg5ekDE3tSw5dH5HKIsNIhcJQf3l
 USR4wY2rT4V3krMTo2IJSZRyVr8AC1KAtJbmhRYtHQUaF9jdEIQv38wExMJFu1ob
 JJ1hTd0SXJ/elhRcA9QkfBTJHbMftyZRuc+KbnughQmtX63crM4zMbN6KaFL//Pt
 oGHeVjehoGCqronrvFoakE6xXDw66Cjf/50x8WdwsW30VxBNKQ/zLsPnjkM/GdEW
 eyqrwdrdvEI+PNO+c+uf7nl72IL/21Eo/9O1CdpESq8HEE875mp9dkhCYDtln/eN
 pkpEcTF2tyfy3Uug8L5hggONjp8Ukbq7TkDn6XJE1j8kkhEw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsujxcq10-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 04:23:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so1307371eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 20:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794198189; x=1794802989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kQcU1WVPC4C043B6/CgUWw73ZByVRB35hyn/gNx5a3s=;
 b=HXwa7UbhBQwdCD2Rya7SC+BE1fIo89viJCzoDYkpdGzXzkUxbjQcOXQAgTB7dzRfDM
 ZWIFzHWPARw4O5jVbJjz9xCkq2KpJftsRxeNjKrY9a+u3xRzIk8aN/Igj4K5o4fKrWx+
 OBuCpJ/8SRlyQHNvoxBaJQTEDiVYZcRPt+ItJvfmb4WpK1zOpjGuHbSfTjOaFCWKZ+5B
 FkwUTd74P4SfgoNhA44hd3S1O363qPS2GG0xvQufCzMmehWj9wozZgRi3F30qJ8AWaFB
 cFA6y7MrGTVJYpK4Labnq1xhi1f9iPlQ62fr/H7V8Kk/Cp98N0fSqFZ4e0ylQFax1bBq
 mZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794198189; x=1794802989;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kQcU1WVPC4C043B6/CgUWw73ZByVRB35hyn/gNx5a3s=;
 b=FFnXKsNuBXB0W+BtvcsPYXtl0QR1HxOumXHFqzqJFKeYkdk5p6VmZwyngD+pJkMjRh
 NwQuSLQY0k+FkpysLl6SnDt8lhxWZ9Tp32kUDAF01RfoqqiZKIzNrHiBLM2KGKW0j7aX
 q8485i6kgitazokHKLCjROPu/IAG/SqfbwQ9Pe8VvGoxtxLzA3+iZrC7lCJcescRLPAf
 emBzidixZyks9z+wJ0nfRYJsrbCAN/DnNJ6gk/2F8cvH2cRQ/sHuu9tDiCNSPGfLpCzD
 FYBrLd7ldRk+o/98JBD6VMOKrU+5lsnEowSfFMAvTuIMcKlnM4fckz9W1dAzkyIXKSy3
 nF4Q==
X-Gm-Message-State: APuU4Z9HKnYAs7sxSWsSV+eXIrwoWs85SkoXiqaFaBAr5M5xEeSIHCKW
 iFVZ6kxeBVvWsJtmdlsjdDIEmvN67odnreCnBdK1lnjuvOKHvOCc0PbFNY32z+SPQ6E1N4fK6O2
 lUuzJwvS/o3vnJ24sbwJnKZ7TH125q6W/sT7pLqUkWiGk4DZqlEsV71m6STzPhSZn8A==
X-Gm-Gg: AYBFou0/LSb8ET+AyF3sGXM/ClYpy31fkKenFH5qjGPNRYN0Y4z2oIjxScEHqqx1yZC
 4aS85w1tzG3JkE7Rpvvg34C1FVSi2XBxqVIOcnvtxKdFGZ8RIfhQ2zSKfQk47LiK8s6JuuxNo+E
 z11l1soJ1ucLEzM1jQ+i9jsR+/zgeFZB057LZ6xApIzFSCjIEay3PKt3yctUNPZFNP/qzo0gBMd
 JdwJhTEdiIpRDCPfuYAVoE0iM74Lq364G5CEalLi/kpaD7T50/QcQU/2Ro823/t1AdB9gV24/D8
 wW2LsJ8fgZ3RBref09G2w7fYYPONicyajSQwvxMWVVaIA20aLiGf07UAqkSesiCKFCOsjpyzhW9
 s8gRi3NL2ChqfPGrmfc7Ix7pPhGAkke0JPBbVBIIdyqiKh7/ilyUD42ojKVvw7hGGDqtgPcMSxY
 gBrgwe1N2qKaEiq1cVaHPmZQ==
X-Received: by 2002:a05:7300:f58e:b0:36d:4135:cd7 with SMTP id
 5a478bee46e88-37256bed5ecmr6339794eec.18.1794198189129; 
 Sun, 08 Nov 2026 20:23:09 -0800 (PST)
X-Received: by 2002:a05:7300:f58e:b0:36d:4135:cd7 with SMTP id
 5a478bee46e88-37256bed5ecmr6339764eec.18.1794198188618; 
 Sun, 08 Nov 2026 20:23:08 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372669d2826sm10156773eec.29.2026.11.08.20.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 20:23:07 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/5] Hexagon: doc updates
Date: Sun,  8 Nov 2026 20:23:01 -0800
Message-Id: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: _vVjHrG1VgZXiVB-l_pFyVv0s_dhMgwr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfX9eBCx/T9CLQ8
 qyEVL6uAIkUsBMTmZIanfKYx9JrWUWboIzAizwzMoraBM9C8uSHCBDzQmelwh0i9UIOZ8g6cnpO
 ReOEAO8cEGS1Sziib27uA/Ad5RLbWCSVrhSz6hhDbGi3f4gSp1Wgf5LsSBFJE5+8M7CYNosapN1
 LVfI8HOJjF6bhKJRzGesFFcpD+P8xbdXSk+Tf/ksvHeZw5kfzKrXTdrd6FETI8GwEB09gTA/6RZ
 B2/eyXPMRX6rPKrTGnfUJUcZpLHEjTLHkqO//vZXbNgCsD74rB9wlaTeHRTMEwb5YhF8/SgIbNl
 W/Re3XWNFOucuPidxxUgiMRW/J7EBuSnOpZd5oFsS5D1hbDuNSki8MyUI3SeUXVZ6YMW0a9KA8q
 Ypori39Be1/m1aJ1y46mlMi1VhSKYQvyjysh61W2GrkJHNtoju1kEEQtyshj/kyQ8EVEJNNW66k
 B7bPDW6rt1l+laS0DxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfX+cYeEdTRGjQv
 EPslUp5cSiMcftf1rwcqZcqYIKW5sVPVE/JOX2Zmy/yxNXPW9uhtGMSztYEP1yueC6gENqNGLIp
 IZ7SmgodqZueV73SjMHgAZ/rdlOQJwQ=
X-Authority-Analysis: v=2.4 cv=TeIDJhQh c=1 sm=1 tr=0 ts=6af14aae cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=0htksBNy__AaqUuXQ2QA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: _vVjHrG1VgZXiVB-l_pFyVv0s_dhMgwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090017
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
bG9uZSBPUyBwcm9ncmFtcywgYm9vdGluZwpWTSBndWVzdHMsIGxpa2UgTGludXguCgpCcmlhbiBD
YWluICg1KToKICBkb2NzL3N5c3RlbS9oZXhhZ29uOiBkZXNjcmliZSBtYWNoaW5lIG1vZGVscyBh
bmQgbWVtb3J5IG1hcHMKICBkb2NzL3N5c3RlbS9oZXhhZ29uOiB1cGRhdGUgdGhlIG92ZXJ2aWV3
IGFuZCBlbXVsYXRpb24gbGltaXRzCiAgZG9jcy9zeXN0ZW0vaGV4YWdvbjogZG9jdW1lbnQgYm9v
dCBpbnRlcmZhY2VzCiAgZG9jcy9zeXN0ZW0vaGV4YWdvbjogZG9jdW1lbnQgU0RLIHNlbWlob3N0
aW5nIHdvcmtsb2FkcwogIGRvY3Mvc3lzdGVtL2hleGFnb246IGRlc2NyaWJlIGludGVncmF0ZWQg
ZmlybXdhcmUgT1MgYm9vdCBwYXRocwoKIGRvY3Mvc3lzdGVtL2hleGFnb24vYm9vdC5yc3QgICAg
ICAgICAgICAgIHwgMTAwICsrKysrKysrKysrKysrCiBkb2NzL3N5c3RlbS9oZXhhZ29uL2Nkc3Au
cnN0ICAgICAgICAgICAgICB8ICA0MSArKystLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0
aW9uLnJzdCAgICAgICAgIHwgIDE4ICsrKwogZG9jcy9zeXN0ZW0vaGV4YWdvbi9tYWNoaW5lcy5y
c3QgICAgICAgICAgfCAgMzggKysrKysrCiBkb2NzL3N5c3RlbS9oZXhhZ29uL29wZXJhdGluZy1z
eXN0ZW1zLnJzdCB8ICA1MCArKysrKysrCiBkb2NzL3N5c3RlbS9oZXhhZ29uL3Nkay1wcm9ncmFt
cy5yc3QgICAgICB8IDE1NSArKysrKysrKysrKysrKysrKysrKysrCiBkb2NzL3N5c3RlbS90YXJn
ZXQtaGV4YWdvbi5yc3QgICAgICAgICAgICB8ICA1OCArKysrKy0tLQogNyBmaWxlcyBjaGFuZ2Vk
LCA0MjAgaW5zZXJ0aW9ucygrKSwgNDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZG9jcy9zeXN0ZW0vaGV4YWdvbi9ib290LnJzdAogY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3Mvc3lz
dGVtL2hleGFnb24vbWFjaGluZXMucnN0CiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zeXN0ZW0v
aGV4YWdvbi9vcGVyYXRpbmctc3lzdGVtcy5yc3QKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL3N5
c3RlbS9oZXhhZ29uL3Nkay1wcm9ncmFtcy5yc3QKCi0tIAoyLjM0LjEKCg==

